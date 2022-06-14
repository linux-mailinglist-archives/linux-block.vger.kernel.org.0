Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575A154AAC6
	for <lists+linux-block@lfdr.de>; Tue, 14 Jun 2022 09:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiFNHjf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 14 Jun 2022 03:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbiFNHje (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 03:39:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24FC431911
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 00:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655192372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p/bWEyiZpCozkfleSHQ8auR+9PrMiw1OSCsZJihursk=;
        b=FraizmIS2rmWDnuQ2WOWl4bztbdZWKn0A6ciZfPxqCz1fGEa6L8kH6tTrLfihLPMWc1tgK
        sYE278kaqjbPPyARK8WdXkzpAD22f1o7FSeRd+3xmg3Fc5nHSRMChqMTHQFcLzIx9l9Oss
        droDBvM36FcoJ0k8u8r5UptoFg3f1C8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-wbNf4Y5sPmuGAQis424FFA-1; Tue, 14 Jun 2022 03:39:30 -0400
X-MC-Unique: wbNf4Y5sPmuGAQis424FFA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B6A2811E75;
        Tue, 14 Jun 2022 07:39:30 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 21EA12026D64;
        Tue, 14 Jun 2022 07:39:26 +0000 (UTC)
Date:   Tue, 14 Jun 2022 15:39:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] block: fix rq_qos leak for bio based queue
Message-ID: <Yqg7KqXs38G3i2YY@T590>
References: <20220614064426.552843-1-ming.lei@redhat.com>
 <Yqg0w2tC6ac39ayJ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqg0w2tC6ac39ayJ@infradead.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 14, 2022 at 12:12:03AM -0700, Christoph Hellwig wrote:
> On Tue, Jun 14, 2022 at 02:44:26PM +0800, Ming Lei wrote:
> > Commit 5ca7546fe317 ("block: move rq_qos_exit() into disk_release()")
> > moves rq_qos_exit() to disk_release(), but only done for blk-mq queue.
> > 
> > However, now rq qos can be created via blkcg_init_queue() for bio based
> > queue, so we need to call rq_qos_exit() for bio queue too.
> > 
> > In theory, so far, rq_qos is only implemented for request based queue,
> > and we should only add it for blk-mq queue. However, if using blk-mq
> > during allocating queue may not be known, fix the rq qos leak issue by
> > always releasing rq qos for both two kinds of queues.
> 
> This is also fixed by "block: disable the elevator int del_gendisk"
> which was just resent yesterday, and fundamentally gets the lifetimes
> right rather than doctoring around even more.
 
Just checked my block mbox and lore, not see the patch sent from
yesterday.

Thanks, 
Ming

