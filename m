Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7422C3A10F2
	for <lists+linux-block@lfdr.de>; Wed,  9 Jun 2021 12:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238706AbhFIKSe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 9 Jun 2021 06:18:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42613 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234217AbhFIKSe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Jun 2021 06:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623233799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MP/9LMBAdxP9WlP7AmKzZU7alrkLWIzBFSRAvoN8Rz0=;
        b=F91hfsjax6yyk1J3TtRVqwxbgmWcSgHNoiTZsBKjFFj7gp8UsKKQtA7aFToHMu+yL74doZ
        kAFVbrylcSdjLCm/0ioN6MXCbOgFRZrLtPylMjeXCBGokESTXTNTWBrSrbIPrweGHh/UV1
        OOWBePSVECOFg1+yGPrzUOk2Xiq0irQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-9Syhd5vYPnGXhTn-2t1f2A-1; Wed, 09 Jun 2021 06:16:38 -0400
X-MC-Unique: 9Syhd5vYPnGXhTn-2t1f2A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DAD9100C610;
        Wed,  9 Jun 2021 10:16:37 +0000 (UTC)
Received: from T590 (ovpn-12-143.pek2.redhat.com [10.72.12.143])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 028AB10016F4;
        Wed,  9 Jun 2021 10:16:30 +0000 (UTC)
Date:   Wed, 9 Jun 2021 18:16:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org,
        syzbot+77ba3d171a25c56756ea@syzkaller.appspotmail.com
Subject: Re: [PATCH] blk-mq: fix use-after-free in blk_mq_exit_sched
Message-ID: <YMCU+iuHs4ULN0lb@T590>
References: <20210609063046.122843-1-ming.lei@redhat.com>
 <f5fbc650-5bd3-32ee-1d31-8b1dd1d7fa19@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5fbc650-5bd3-32ee-1d31-8b1dd1d7fa19@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 09, 2021 at 09:59:43AM +0100, John Garry wrote:
> On 09/06/2021 07:30, Ming Lei wrote:
> 
> Thanks for the fix
> 
> > tagset can't be used after blk_cleanup_queue() is returned because
> > freeing tagset usually follows blk_clenup_queue(). Commit d97e594c5166
> > ("blk-mq: Use request queue-wide tags for tagset-wide sbitmap") adds
> > check on q->tag_set->flags in blk_mq_exit_sched(), and causes
> > use-after-free.
> > 
> > Fixes it by using hctx->flags.
> > 
> 
> The tagset is a member of the Scsi_Host structure. So it is true that this
> memory may be freed before the request_queue is exited?

Yeah, please see commit c3e2219216c9 ("block: free sched's request pool in
blk_cleanup_queue")

> 
> > Reported-by: syzbot+77ba3d171a25c56756ea@syzkaller.appspotmail.com
> > Fixes: d97e594c5166 ("blk-mq: Use request queue-wide tags for tagset-wide sbitmap")
> > Cc: John Garry <john.garry@huawei.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   block/blk-mq-sched.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > index a9182d2f8ad3..80273245d11a 100644
> > --- a/block/blk-mq-sched.c
> > +++ b/block/blk-mq-sched.c
> > @@ -680,6 +680,7 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
> >   {
> >   	struct blk_mq_hw_ctx *hctx;
> >   	unsigned int i;
> > +	unsigned int flags = 0;
> >   	queue_for_each_hw_ctx(q, hctx, i) {
> >   		blk_mq_debugfs_unregister_sched_hctx(hctx);
> > @@ -687,12 +688,13 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
> >   			e->type->ops.exit_hctx(hctx, i);
> >   			hctx->sched_data = NULL;
> >   		}
> > +		flags = hctx->flags;
> 
> I know the choice is limited, but it is unfortunate that we must set flags
> in a loop

Does it matter?

> 
> >   	}
> >   	blk_mq_debugfs_unregister_sched(q);
> >   	if (e->type->ops.exit_sched)
> >   		e->type->ops.exit_sched(e);
> >   	blk_mq_sched_tags_teardown(q);
> > -	if (blk_mq_is_sbitmap_shared(q->tag_set->flags))
> > +	if (blk_mq_is_sbitmap_shared(flags))
> >   		blk_mq_exit_sched_shared_sbitmap(q);
> 
> this is
> 
> blk_mq_exit_sched_shared_sbitmap(struct request_queue *queue)
> {
> 	sbitmap_queue_free(&queue->sched_bitmap_tags);
> 	..
> }
> 
> And isn't it safe to call sbitmap_queue_free() when
> sbitmap_queue_init_node() has not been called?
> 
> I'm just wondering if we can always call blk_mq_exit_sched_shared_sbitmap()?
> I know it's not an ideal choice either.

So far it may work, not sure if it can in future, I suggest to follow
the traditional alloc & free pattern.


Thanks,
Ming

