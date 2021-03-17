Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AA233E7BF
	for <lists+linux-block@lfdr.de>; Wed, 17 Mar 2021 04:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhCQDja (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 16 Mar 2021 23:39:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22958 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229541AbhCQDjN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Mar 2021 23:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615952352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n7+GqqrylRZuBL04jkIi009mKEE6txjnFw+qiM3nH4A=;
        b=fDb35iS6t6uDfLWTIL+3gYSngdHqqHhi36xtNxtP8ukOHSq8NbjsM+IllNUezRHRHuNtYf
        sBsxG3P07ckYqGVluxuCOCnW9+Vox6hZ/Cn0T5E6YErViM+Xu2HrBXwyYTxtxCnMJJTLOw
        O24QDsZ7SOHF/s6ljDGICBMiqJB43WE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-_gamDS8oPIqnojlRAk6HFg-1; Tue, 16 Mar 2021 23:39:10 -0400
X-MC-Unique: _gamDS8oPIqnojlRAk6HFg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75751839A43;
        Wed, 17 Mar 2021 03:39:09 +0000 (UTC)
Received: from T590 (ovpn-13-81.pek2.redhat.com [10.72.13.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EB5C39A70;
        Wed, 17 Mar 2021 03:38:55 +0000 (UTC)
Date:   Wed, 17 Mar 2021 11:38:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Subject: Re: [RFC PATCH 08/11] block: use per-task poll context to implement
 bio based io poll
Message-ID: <YFF5yynvUFOf5sdO@T590>
References: <20210316031523.864506-1-ming.lei@redhat.com>
 <20210316031523.864506-9-ming.lei@redhat.com>
 <b4dce8c6-61dd-9524-0a55-41db63eb084d@linux.alibaba.com>
 <YFBbjY+oDpjIHI3P@T590>
 <b2a33da7-84e6-14ba-c960-988bba448bf4@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2a33da7-84e6-14ba-c960-988bba448bf4@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 16, 2021 at 07:00:49PM +0800, JeffleXu wrote:
> 
> 
> On 3/16/21 3:17 PM, Ming Lei wrote:
> > On Tue, Mar 16, 2021 at 02:46:08PM +0800, JeffleXu wrote:
> >> It is a giant progress to gather all split bios that need to be polled
> >> in a per-task queue. Still some comments below.
> >>
> >>
> >> On 3/16/21 11:15 AM, Ming Lei wrote:
> >>> Currently bio based IO poll needs to poll all hw queue blindly, this way
> >>> is very inefficient, and the big reason is that we can't pass bio
> >>> submission result to io poll task.
> >>>
> >>> In IO submission context, store associated underlying bios into the
> >>> submission queue and save 'cookie' poll data in bio->bi_iter.bi_private_data,
> >>> and return current->pid to caller of submit_bio() for any DM or bio based
> >>> driver's IO, which is submitted from FS.
> >>>
> >>> In IO poll context, the passed cookie tells us the PID of submission
> >>> context, and we can find the bio from that submission context. Moving
> >>> bio from submission queue to poll queue of the poll context, and keep
> >>> polling until these bios are ended. Remove bio from poll queue if the
> >>> bio is ended. Add BIO_DONE and BIO_END_BY_POLL for such purpose.
> >>>
> >>> Usually submission shares context with io poll. The per-task poll context
> >>> is just like stack variable, and it is cheap to move data between the two
> >>> per-task queues.
> >>>
> >>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >>> ---
> >>>  block/bio.c               |   5 ++
> >>>  block/blk-core.c          |  74 +++++++++++++++++-
> >>>  block/blk-mq.c            | 156 +++++++++++++++++++++++++++++++++++++-
> >>>  include/linux/blk_types.h |   3 +
> >>>  4 files changed, 235 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/block/bio.c b/block/bio.c
> >>> index a1c4d2900c7a..bcf5eca0e8e3 100644
> >>> --- a/block/bio.c
> >>> +++ b/block/bio.c
> >>> @@ -1402,6 +1402,11 @@ static inline bool bio_remaining_done(struct bio *bio)
> >>>   **/
> >>>  void bio_endio(struct bio *bio)
> >>>  {
> >>> +	/* BIO_END_BY_POLL has to be set before calling submit_bio */
> >>> +	if (bio_flagged(bio, BIO_END_BY_POLL)) {
> >>> +		bio_set_flag(bio, BIO_DONE);
> >>> +		return;
> >>> +	}
> >>>  again:
> >>>  	if (!bio_remaining_done(bio))
> >>>  		return;
> >>> diff --git a/block/blk-core.c b/block/blk-core.c
> >>> index a082bbc856fb..970b23fa2e6e 100644
> >>> --- a/block/blk-core.c
> >>> +++ b/block/blk-core.c
> >>> @@ -854,6 +854,40 @@ static inline void blk_bio_poll_preprocess(struct request_queue *q,
> >>>  		bio->bi_opf |= REQ_TAG;
> >>>  }
> >>>  
> >>> +static bool blk_bio_poll_prep_submit(struct io_context *ioc, struct bio *bio)
> >>> +{
> >>> +	struct blk_bio_poll_data data = {
> >>> +		.bio	=	bio,
> >>> +	};
> >>> +	struct blk_bio_poll_ctx *pc = ioc->data;
> >>> +	unsigned int queued;
> >>> +
> >>> +	/* lock is required if there is more than one writer */
> >>> +	if (unlikely(atomic_read(&ioc->nr_tasks) > 1)) {
> >>> +		spin_lock(&pc->lock);
> >>> +		queued = kfifo_put(&pc->sq, data);
> >>> +		spin_unlock(&pc->lock);
> >>> +	} else {
> >>> +		queued = kfifo_put(&pc->sq, data);
> >>> +	}
> >>> +
> >>> +	/*
> >>> +	 * Now the bio is added per-task fifo, mark it as END_BY_POLL,
> >>> +	 * so we can save cookie into this bio after submit_bio().
> >>> +	 */
> >>> +	if (queued)
> >>> +		bio_set_flag(bio, BIO_END_BY_POLL);
> >>> +	else
> >>> +		bio->bi_opf &= ~(REQ_HIPRI | REQ_TAG);
> >>> +
> >>> +	return queued;
> >>> +}
> >>
> >> The size of kfifo is limited, and it seems that once the sq of kfifio is
> >> full, REQ_HIPRI flag is cleared and the corresponding bio is actually
> >> enqueued into the default hw queue, which is IRQ driven.
> > 
> > Yeah, this patch starts with 64 queue depth, and we can increase it to
> > 128, which should cover most of cases.
> > 
> >>
> >>
> >>> +
> >>> +static void blk_bio_poll_post_submit(struct bio *bio, blk_qc_t cookie)
> >>> +{
> >>> +	bio->bi_iter.bi_private_data = cookie;
> >>> +}
> >>> +
> >>>  static noinline_for_stack bool submit_bio_checks(struct bio *bio)
> >>>  {
> >>>  	struct block_device *bdev = bio->bi_bdev;
> >>> @@ -1008,7 +1042,7 @@ static blk_qc_t __submit_bio(struct bio *bio)
> >>>   * bio_list_on_stack[1] contains bios that were submitted before the current
> >>>   *	->submit_bio_bio, but that haven't been processed yet.
> >>>   */
> >>> -static blk_qc_t __submit_bio_noacct(struct bio *bio)
> >>> +static blk_qc_t __submit_bio_noacct_int(struct bio *bio, struct io_context *ioc)
> >>>  {
> >>>  	struct bio_list bio_list_on_stack[2];
> >>>  	blk_qc_t ret = BLK_QC_T_NONE;
> >>> @@ -1031,7 +1065,16 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
> >>>  		bio_list_on_stack[1] = bio_list_on_stack[0];
> >>>  		bio_list_init(&bio_list_on_stack[0]);
> >>>  
> >>> -		ret = __submit_bio(bio);
> >>> +		if (ioc && queue_is_mq(q) &&
> >>> +				(bio->bi_opf & (REQ_HIPRI | REQ_TAG))) {
> >>> +			bool queued = blk_bio_poll_prep_submit(ioc, bio);
> >>> +
> >>> +			ret = __submit_bio(bio);
> >>> +			if (queued)
> >>> +				blk_bio_poll_post_submit(bio, ret);
> >>> +		} else {
> >>> +			ret = __submit_bio(bio);
> >>> +		}
> >>>  
> >>>  		/*
> >>>  		 * Sort new bios into those for a lower level and those for the
> >>> @@ -1057,6 +1100,33 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
> >>>  	return ret;
> >>>  }
> >>>  
> >>> +static inline blk_qc_t __submit_bio_noacct_poll(struct bio *bio,
> >>> +		struct io_context *ioc)
> >>> +{
> >>> +	struct blk_bio_poll_ctx *pc = ioc->data;
> >>> +	int entries = kfifo_len(&pc->sq);
> >>> +
> >>> +	__submit_bio_noacct_int(bio, ioc);
> >>> +
> >>> +	/* bio submissions queued to per-task poll context */
> >>> +	if (kfifo_len(&pc->sq) > entries)
> >>> +		return current->pid;
> >>> +
> >>> +	/* swapper's pid is 0, but it can't submit poll IO for us */
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static inline blk_qc_t __submit_bio_noacct(struct bio *bio)
> >>> +{
> >>> +	struct io_context *ioc = current->io_context;
> >>> +
> >>> +	if (ioc && ioc->data && (bio->bi_opf & REQ_HIPRI))
> >>> +		return __submit_bio_noacct_poll(bio, ioc);
> >>> +
> >>> +	return __submit_bio_noacct_int(bio, NULL);
> >>> +}
> >>> +
> >>> +
> >>>  static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
> >>>  {
> >>>  	struct bio_list bio_list[2] = { };
> >>> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >>> index 03f59915fe2c..4e6f1467d303 100644
> >>> --- a/block/blk-mq.c
> >>> +++ b/block/blk-mq.c
> >>> @@ -3865,14 +3865,168 @@ static inline int blk_mq_poll_hctx(struct request_queue *q,
> >>>  	return ret;
> >>>  }
> >>>  
> >>> +static blk_qc_t bio_get_poll_cookie(struct bio *bio)
> >>> +{
> >>> +	return bio->bi_iter.bi_private_data;
> >>> +}
> >>> +
> >>> +static int blk_mq_poll_io(struct bio *bio)
> >>> +{
> >>> +	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> >>> +	blk_qc_t cookie = bio_get_poll_cookie(bio);
> >>> +	int ret = 0;
> >>> +
> >>> +	if (!bio_flagged(bio, BIO_DONE) && blk_qc_t_valid(cookie)) {
> >>> +		struct blk_mq_hw_ctx *hctx =
> >>> +			q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
> >>> +
> >>> +		ret += blk_mq_poll_hctx(q, hctx);
> >>> +	}
> >>> +	return ret;
> >>> +}
> >>> +
> >>> +static int blk_bio_poll_and_end_io(struct request_queue *q,
> >>> +		struct blk_bio_poll_ctx *poll_ctx)
> >>> +{
> >>> +	struct blk_bio_poll_data *poll_data = &poll_ctx->pq[0];
> >>> +	int ret = 0;
> >>> +	int i;
> >>> +
> >>> +	for (i = 0; i < BLK_BIO_POLL_PQ_SZ; i++) {
> >>> +		struct bio *bio = poll_data[i].bio;
> >>> +
> >>> +		if (!bio)
> >>> +			continue;
> >>> +
> >>> +		ret += blk_mq_poll_io(bio);
> >>> +		if (bio_flagged(bio, BIO_DONE)) {
> >>> +			poll_data[i].bio = NULL;
> >>> +
> >>> +			/* clear BIO_END_BY_POLL and end me really */
> >>> +			bio_clear_flag(bio, BIO_END_BY_POLL);
> >>> +			bio_endio(bio);
> >>> +		}
> >>> +	}
> >>> +	return ret;
> >>> +}
> >>
> >> When there are multiple threads polling, saying thread A and thread B,
> >> then there's one bio which should be polled by thread A (the pid is
> >> passed to thread A), while it's actually completed by thread B. In this
> >> case, when the bio is completed by thread B, the bio is not really
> >> completed and one extra blk_poll() still needs to be called.
> > 
> > When this happens, the dm bio can't be completed, and the associated
> > kiocb can't be completed too, io_uring or other poll code context will
> > keep calling blk_poll() by passing thread A's pid until this dm bio is
> > done, since the dm bio is submitted from thread A.
> > 
> 
> This will affect the multi-thread polling performance. I tested
> dm-stripe, in which every bio will be split and enqueued into all
> underlying devices, and thus amplify the interference between multiple
> threads.
> 
> Test Result:
> IOPS: 332k (IRQ) -> 363k (iopoll), aka ~10% performance gain
> 
> 
> Test Environment:
> 
> nvme.poll_queues = 3
> 
> BLK_BIO_POLL_SQ_SZ = 128
> 
> dmsetup create testdev --table "0 629145600 striped 3 8 /dev/nvme0n1 0
> /dev/nvme1n1 0 /dev/nvme4n1 0"
> 
> 
> ```
> $cat fio.conf
> [global]
> name=iouring-sqpoll-iopoll-1
> ioengine=io_uring
> iodepth=128
> numjobs=1

If numjobs is 1, there can't be the queue interference issue because
there is only one submission job.

If numjobs is 3 and nvme.poll_queues is 3, there are two cases:

1) each job is assigned with different hw queue, so no queue
interference

2) two jobs share one same hw queue, and there is queue interference

The behavior is decided by scheduler since the queue mapping between
cpu vs. poll queue is fixed.

You can compare the above two cases by passing different 'cpus_allowed'
to each job in fio.

> thread
> rw=randread
> direct=1
> hipri=1
> runtime=10
> time_based
> group_reporting
> randrepeat=0
> filename=/dev/mapper/testdev
> bs=12k
> 
> [job-1]
> cpus_allowed=14
> 
> [job-2]
> cpus_allowed=16
> 
> [job-3]
> cpus_allowed=84

It depends if cpu of 14,16,84 is mapped to same hw poll queue or
not.

If all 3 cpus are mapped to same hw poll queue, there will be lock
contention in submission path, see nvme_submit_cmd(), and the hw queue
data is concurrent polled in 3 cpus too.


Thanks,
Ming

