Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A927577D92
	for <lists+linux-block@lfdr.de>; Mon, 18 Jul 2022 10:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiGRIdq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 18 Jul 2022 04:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbiGRIdp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 04:33:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F29219019
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 01:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658133223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w7A1bExvC2fZfktgZT5a8FbB+VQj1q0Rk6hqgYVPf7w=;
        b=ax+5QtnN2Nz7GqW/7UdwW/pR6VzGtnL5HftS+ManEQOkW5st5e/s+80A5rgVijPRMjRQVq
        hkIjLGlJyuomTbIZyuBTgeQyhK/TlxlibWk6slkarJwNggfkB3zFJeTpVuJ/tsKX/NmIcT
        zlXaofMAVDXrhRui1aClwyOE9WWttUc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-nHOHql1nNqeb-L1eGdIJhA-1; Mon, 18 Jul 2022 04:33:41 -0400
X-MC-Unique: nHOHql1nNqeb-L1eGdIJhA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FA343C0CD3A;
        Mon, 18 Jul 2022 08:33:41 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 58BF52166B26;
        Mon, 18 Jul 2022 08:33:37 +0000 (UTC)
Date:   Mon, 18 Jul 2022 16:33:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH 1/2] block: call blk_mq_exit_queue from disk_release for
 never added disks
Message-ID: <YtUa3f2Z3xra9gTG@T590>
References: <20220718062928.335399-1-hch@lst.de>
 <YtUJXGhFBw5yrf7N@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtUJXGhFBw5yrf7N@T590>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 18, 2022 at 03:18:52PM +0800, Ming Lei wrote:
> On Mon, Jul 18, 2022 at 08:29:27AM +0200, Christoph Hellwig wrote:
> > To undo the all initialization from blk_mq_init_allocated_queue in case
> > of a probe failure where add_disk is never called we have to call
> > blk_mq_exit_queue from put_disk.
> > 
> > We should be doing this in general, but can't do it for the normal
> > teardown case (yet) as the tagset can be gone by the time the disk is
> > released once it was added.  I hope to sort this out properly eventual
> > but for now this isolated hack will do it.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  block/genhd.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/block/genhd.c b/block/genhd.c
> > index 44dfcf67ed96a..ad8a3678d4480 100644
> > --- a/block/genhd.c
> > +++ b/block/genhd.c
> > @@ -1138,6 +1138,18 @@ static void disk_release(struct device *dev)
> >  	might_sleep();
> >  	WARN_ON_ONCE(disk_live(disk));
> >  
> > +	/*
> > +	 * To undo the all initialization from blk_mq_init_allocated_queue in
> > +	 * case of a probe failure where add_disk is never called we have to
> > +	 * call blk_mq_exit_queue here. We can't do this for the more common
> > +	 * teardown case (yet) as the tagset can be gone by the time the disk
> > +	 * is released once it was added.
> > +	 */
> > +	if (queue_is_mq(disk->queue) &&
> > +	    test_bit(GD_OWNS_QUEUE, &disk->state) &&
> > +	    !test_bit(GD_ADDED, &disk->state))
> > +		blk_mq_exit_queue(disk->queue);
> > +
> 
> Request queue is allocated successfully, but disk allocation may fail,
> so blk_mq_exit_queue still may be missed in this case.

Or we do have request queue uses without disk attached, such as nvme
admin/connection queue.


Thanks,
Ming

