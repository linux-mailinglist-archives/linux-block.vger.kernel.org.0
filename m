Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA0E693FC4
	for <lists+linux-block@lfdr.de>; Mon, 13 Feb 2023 09:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjBMIiI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 13 Feb 2023 03:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjBMIiG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2023 03:38:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0EDC64F
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 00:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676277441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/1U70nDIhh0wWRn6i+OpLdwoCB9WNkYfM0LMTWRS+vc=;
        b=Fs1Fk8oPb0/nyJBYb8TnqdWpFChwzosGCoa4BMPRfIeDPOIkQm945474IF2cehkBbar2jf
        hGjiqMKoWJI8/N8JqnJxb8Yz8jpD1q8FMjm/MXlQ0D4ZRaWTHR1M+sK3vsN3cKURvn5VLV
        5E9nyWcnXpRtfasZm96rC3BCIKub9D8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-NwLkK3r0NWKVmM2L7bqWkQ-1; Mon, 13 Feb 2023 03:37:18 -0500
X-MC-Unique: NwLkK3r0NWKVmM2L7bqWkQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2184A858F09;
        Mon, 13 Feb 2023 08:37:18 +0000 (UTC)
Received: from T590 (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E74BE492B15;
        Mon, 13 Feb 2023 08:37:14 +0000 (UTC)
Date:   Mon, 13 Feb 2023 16:37:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH] blk-cgroup: delay calling blkcg_exit_disk until
 disk_release
Message-ID: <Y+n2tX4fVuRrQLuN@T590>
References: <20230208063514.171485-1-hch@lst.de>
 <Y+XQh3zMHMIX2+jr@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+XQh3zMHMIX2+jr@T590>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 10, 2023 at 01:05:11PM +0800, Ming Lei wrote:
> On Wed, Feb 08, 2023 at 07:35:14AM +0100, Christoph Hellwig wrote:
> > While del_gendisk ensures there is no outstanding I/O on the queue,
> > it can't prevent block layer users from building new I/O.
> > 
> > This leads to a NULL ->root_blkg reference in bio_associate_blkg when
> > allocating a new bio on a shut down file system.  Delay freeing the
> > blk-cgroup subsystems from del_gendisk until disk_release to make
> > sure the blkg and throttle information is still avaіlable for bio
> > submitters, even if those bios will immediately fail.
> > 
> > This now can cause a case where disk_release is called on a disk
> > that hasn't been added.  That's mostly harmless, except for a case
> > in blk_throttl_exit that now needs to check for a NULL ->td pointer.
> > 
> > Fixes: 178fa7d49815 ("blk-cgroup: delay blk-cgroup initialization until add_disk")
> > Reported-by: Ming Lei <ming.lei@redhat.com>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> hammmmmm, this patch actually causes bigger trouble.
> 
> After commit 84d7d462b16d ("blk-cgroup: pin the gendisk in struct blkcg_gq"),
> blkcg_gq instance grabs disk's reference, so moving blkcg_exit_disk
> into disk_release() just causes reference cross-dependency, both are
> leaked.

Hi Christoph & Jens,

This issue is a bit serious, both blkg & disk & request_queue are leaked by
commit c43332fe028c ("blk-cgroup: delay calling blkcg_exit_disk until disk_release").

Can we solve it before merging for-6.3/block into v6.3-rc1?

Thanks,
Ming

