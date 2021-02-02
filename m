Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B279130CD43
	for <lists+linux-block@lfdr.de>; Tue,  2 Feb 2021 21:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhBBUqM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Feb 2021 15:46:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48008 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233384AbhBBUpc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Feb 2021 15:45:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612298644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qB7eJjJEwuVBawwhdiSf0pwWEiHuFAZ232JKX4Aaoj8=;
        b=fLj4Eynyfn9rc3H1DSxSAzvBDa8FFPxKAhcbsiBBA1D6K1v1ZbBMH3x4B6IE8Nlj/oj2F8
        eoY5AfSnAg+ZXu38NdtGkdmjkY0crOKYL1K2uRUIaiDsFIBF8UhMZ5p8S20Rzug9qm5gsS
        XEbAEFLcanWDK0td1ZgiCOk7HnGuSqg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-qEGmr014PPq0sHvfu2od8A-1; Tue, 02 Feb 2021 15:44:03 -0500
X-MC-Unique: qEGmr014PPq0sHvfu2od8A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F151810066EF;
        Tue,  2 Feb 2021 20:44:01 +0000 (UTC)
Received: from redhat (ovpn-117-133.rdu2.redhat.com [10.10.117.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 52B5360C66;
        Tue,  2 Feb 2021 20:43:58 +0000 (UTC)
Date:   Tue, 2 Feb 2021 15:43:55 -0500
From:   David Jeffery <djeffery@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org,
        Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH] block: recalculate segment count for multi-segment
 discard requests correctly
Message-ID: <20210202204355.GA31803@redhat>
References: <20210201164850.391332-1-djeffery@redhat.com>
 <20210202033343.GA165584@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202033343.GA165584@T590>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 02, 2021 at 11:33:43AM +0800, Ming Lei wrote:
> 
> On Mon, Feb 01, 2021 at 11:48:50AM -0500, David Jeffery wrote:
> > When a stacked block device inserts a request into another block device
> > using blk_insert_cloned_request, the request's nr_phys_segments field gets
> > recalculated by a call to blk_recalc_rq_segments in
> > blk_cloned_rq_check_limits. But blk_recalc_rq_segments does not know how to
> > handle multi-segment discards. For disk types which can handle
> > multi-segment discards like nvme, this results in discard requests which
> > claim a single segment when it should report several, triggering a warning
> > in nvme and causing nvme to fail the discard from the invalid state.
> > 
> >  WARNING: CPU: 5 PID: 191 at drivers/nvme/host/core.c:700 nvme_setup_discard+0x170/0x1e0 [nvme_core]
> >  ...
> >  nvme_setup_cmd+0x217/0x270 [nvme_core]
> >  nvme_loop_queue_rq+0x51/0x1b0 [nvme_loop]
> >  __blk_mq_try_issue_directly+0xe7/0x1b0
> >  blk_mq_request_issue_directly+0x41/0x70
> >  ? blk_account_io_start+0x40/0x50
> >  dm_mq_queue_rq+0x200/0x3e0
> >  blk_mq_dispatch_rq_list+0x10a/0x7d0
> >  ? __sbitmap_queue_get+0x25/0x90
> >  ? elv_rb_del+0x1f/0x30
> >  ? deadline_remove_request+0x55/0xb0
> >  ? dd_dispatch_request+0x181/0x210
> >  __blk_mq_do_dispatch_sched+0x144/0x290
> >  ? bio_attempt_discard_merge+0x134/0x1f0
> >  __blk_mq_sched_dispatch_requests+0x129/0x180
> >  blk_mq_sched_dispatch_requests+0x30/0x60
> >  __blk_mq_run_hw_queue+0x47/0xe0
> >  __blk_mq_delay_run_hw_queue+0x15b/0x170
> >  blk_mq_sched_insert_requests+0x68/0xe0
> >  blk_mq_flush_plug_list+0xf0/0x170
> >  blk_finish_plug+0x36/0x50
> >  xlog_cil_committed+0x19f/0x290 [xfs]
> >  xlog_cil_process_committed+0x57/0x80 [xfs]
> >  xlog_state_do_callback+0x1e0/0x2a0 [xfs]
> >  xlog_ioend_work+0x2f/0x80 [xfs]
> >  process_one_work+0x1b6/0x350
> >  worker_thread+0x53/0x3e0
> >  ? process_one_work+0x350/0x350
> >  kthread+0x11b/0x140
> >  ? __kthread_bind_mask+0x60/0x60
> >  ret_from_fork+0x22/0x30
> > 
> > This patch fixes blk_recalc_rq_segments to be aware of devices which can
> > have multi-segment discards. It calculates the correct discard segment
> > count by counting the number of bio as each discard bio is considered its
> > own segment.
> > 
> > Signed-off-by: David Jeffery <djeffery@redhat.com>
> > Tested-by: Laurence Oberman <loberman@redhat.com>
> > ---
> >  block/blk-merge.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/block/blk-merge.c b/block/blk-merge.c
> > index 808768f6b174..fe7358bd5d09 100644
> > --- a/block/blk-merge.c
> > +++ b/block/blk-merge.c
> > @@ -382,6 +382,13 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
> >  
> >  	switch (bio_op(rq->bio)) {
> >  	case REQ_OP_DISCARD:
> > +		if (queue_max_discard_segments(rq->q) > 1) {
> > +			struct bio *bio = rq->bio;
> > +			for_each_bio(bio)
> > +				nr_phys_segs++;
> > +			return nr_phys_segs;
> > +		}
> > +		/* fall through */
> >  	case REQ_OP_SECURE_ERASE:
> 
> REQ_OP_SECURE_ERASE needs to be covered since block layer treats
> the two in very similar way from discard viewpoint.
> 
> Also single range discard should be fixed too, since block layer
> thinks single-range discard req segment is 1. Otherwise, the warning in
> virtblk_setup_discard_write_zeroes() still may be triggered, at least.
> 
> 
> -- 
> Ming
>

The return 0 does seem to be an old relic that does not make sense anymore.
Moving REQ_OP_SECURE_ERASE to be with discard and removing the old return 0,
is this what you had in mind?

 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 808768f6b174..68458aa01b05 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -383,8 +383,14 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
 	switch (bio_op(rq->bio)) {
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
+		if (queue_max_discard_segments(rq->q) > 1) {
+			struct bio *bio = rq->bio;
+			for_each_bio(bio)
+				nr_phys_segs++;
+			return nr_phys_segs;
+		}
+		/* fall through */
 	case REQ_OP_WRITE_ZEROES:
-		return 0;
 	case REQ_OP_WRITE_SAME:
 		return 1;
 	}

--
David Jeffery

