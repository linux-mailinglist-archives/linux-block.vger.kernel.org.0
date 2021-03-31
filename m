Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B96345D78
	for <lists+linux-block@lfdr.de>; Tue, 23 Mar 2021 12:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhCWL4j (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 Mar 2021 07:56:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58187 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229675AbhCWL4J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 07:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616500568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OyDbVHpW+iFvLz7ay8e+RJKbJpQA12dbmPMHAxjRXWc=;
        b=h3cdj1x3BwYBKrpTdfxCHUJB8OGhoQxMMBQ7aj+Anp2GOJtNNAlhAGuufTStvnkTNQGbYD
        BDsDwKzQIBLYbQdKcU8DjbECQM0nVh9TfseHvk7xUyoSx0gifgCAadbSHqXSwy1NkUdO/3
        xGzSZb93VzOHeJfmqU/AQA/pfjpdAJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-53vBURuZONesus4txCTVzA-1; Tue, 23 Mar 2021 07:56:06 -0400
X-MC-Unique: 53vBURuZONesus4txCTVzA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10724107ACCD;
        Tue, 23 Mar 2021 11:56:05 +0000 (UTC)
Received: from T590 (ovpn-13-171.pek2.redhat.com [10.72.13.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 000FF5D9C0;
        Tue, 23 Mar 2021 11:55:59 +0000 (UTC)
Date:   Tue, 23 Mar 2021 19:55:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com
Subject: Re: [RFC PATCH V2 09/13] block: use per-task poll context to
 implement bio based io poll
Message-ID: <YFnXSuob40KYziKS@T590>
References: <20210318164827.1481133-1-ming.lei@redhat.com>
 <20210318164827.1481133-10-ming.lei@redhat.com>
 <20210319183810.GA10212@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319183810.GA10212@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 19, 2021 at 02:38:11PM -0400, Mike Snitzer wrote:
> On Thu, Mar 18 2021 at 12:48pm -0400,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > Currently bio based IO poll needs to poll all hw queue blindly, this way
> > is very inefficient, and the big reason is that we can't pass bio
> > submission result to io poll task.
> 
> This is awkward because bio-based IO polling doesn't exist upstream yet,
> so this header should be covering your approach as a clean slate, e.g.:
> 
> The complexity associated with frequent bio splitting with bio-based
> devices makes it difficult to implement IO polling efficiently because
> the fan-out of underlying hw queues that need to be polled (as a
> side-effect of bios being split) creates a need for more easily mapping
> a group of bios to the hw queues that need to be polled.
> 
> > In IO submission context, track associated underlying bios by per-task
> > submission queue and save 'cookie' poll data in bio->bi_iter.bi_private_data,
> > and return current->pid to caller of submit_bio() for any bio based
> > driver's IO, which is submitted from FS.
> > 
> > In IO poll context, the passed cookie tells us the PID of submission
> > context, and we can find the bio from that submission context. Moving
> 
> Maybe be more precise by covering how all bios from that task's
> submission context will be moved to poll queue of poll context?

Strictly speaking, it isn't a must to add poll context which is just
more efficient for polling locally after taking bio grouping list in V2.

> 
> > bio from submission queue to poll queue of the poll context, and keep
> > polling until these bios are ended. Remove bio from poll queue if the
> > bio is ended. Add BIO_DONE and BIO_END_BY_POLL for such purpose.
> > 
> > In previous version, kfifo is used to implement submission queue, and
> > Jeffle Xu found that kfifo can't scale well in case of high queue depth.
> 
> Awkward to reference "previous version", maybe instead say:
> 
> In was found that kfifo doesn't scale well for a submission queue as
> queue depth is increased, so a new mechanism for tracking bios is
> needed.

OK.

> 
> > So far bio's size is close to 2 cacheline size, and it may not be
> > accepted to add new field into bio for solving the scalability issue by
> > tracking bios via linked list, switch to bio group list for tracking bio,
> > the idea is to reuse .bi_end_io for linking bios into a linked list for
> > all sharing same .bi_end_io(call it bio group), which is recovered before
> > really end bio, since BIO_END_BY_POLL is added for enhancing this point.
> > Usually .bi_end_bio is same for all bios in same layer, so it is enough to
> > provide very limited groups, such as 32 for fixing the scalability issue.
> > 
> > Usually submission shares context with io poll. The per-task poll context
> > is just like stack variable, and it is cheap to move data between the two
> > per-task queues.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/bio.c               |   5 ++
> >  block/blk-core.c          | 149 +++++++++++++++++++++++++++++++-
> >  block/blk-mq.c            | 173 +++++++++++++++++++++++++++++++++++++-
> >  block/blk.h               |   9 ++
> >  include/linux/blk_types.h |  16 +++-
> >  5 files changed, 348 insertions(+), 4 deletions(-)
> > 
> > diff --git a/block/bio.c b/block/bio.c
> > index 26b7f721cda8..04c043dc60fc 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -1402,6 +1402,11 @@ static inline bool bio_remaining_done(struct bio *bio)
> >   **/
> >  void bio_endio(struct bio *bio)
> >  {
> > +	/* BIO_END_BY_POLL has to be set before calling submit_bio */
> > +	if (bio_flagged(bio, BIO_END_BY_POLL)) {
> > +		bio_set_flag(bio, BIO_DONE);
> > +		return;
> > +	}
> >  again:
> >  	if (!bio_remaining_done(bio))
> >  		return;
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index efc7a61a84b4..778d25a7e76c 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -805,6 +805,77 @@ static inline unsigned int bio_grp_list_size(unsigned int nr_grps)
> >  		sizeof(struct bio_grp_list_data);
> >  }
> >  
> > +static inline void *bio_grp_data(struct bio *bio)
> > +{
> > +	return bio->bi_poll;
> > +}
> > +
> > +/* add bio into bio group list, return true if it is added */
> > +static bool bio_grp_list_add(struct bio_grp_list *list, struct bio *bio)
> > +{
> > +	int i;
> > +	struct bio_grp_list_data *grp;
> > +
> > +	for (i = 0; i < list->nr_grps; i++) {
> > +		grp = &list->head[i];
> > +		if (grp->grp_data == bio_grp_data(bio)) {
> > +			__bio_grp_list_add(&grp->list, bio);
> > +			return true;
> > +		}
> > +	}
> > +
> > +	if (i == list->max_nr_grps)
> > +		return false;
> > +
> > +	/* create a new group */
> > +	grp = &list->head[i];
> > +	bio_list_init(&grp->list);
> > +	grp->grp_data = bio_grp_data(bio);
> > +	__bio_grp_list_add(&grp->list, bio);
> > +	list->nr_grps++;
> > +
> > +	return true;
> > +}
> > +
> > +static int bio_grp_list_find_grp(struct bio_grp_list *list, void *grp_data)
> > +{
> > +	int i;
> > +	struct bio_grp_list_data *grp;
> > +
> > +	for (i = 0; i < list->max_nr_grps; i++) {
> > +		grp = &list->head[i];
> > +		if (grp->grp_data == grp_data)
> > +			return i;
> > +	}
> > +	for (i = 0; i < list->max_nr_grps; i++) {
> > +		grp = &list->head[i];
> > +		if (bio_grp_list_grp_empty(grp))
> > +			return i;
> > +	}
> > +	return -1;
> > +}
> > +
> > +/* Move as many as possible groups from 'src' to 'dst' */
> > +void bio_grp_list_move(struct bio_grp_list *dst, struct bio_grp_list *src)
> > +{
> > +	int i, j, cnt = 0;
> > +	struct bio_grp_list_data *grp;
> > +
> > +	for (i = src->nr_grps - 1; i >= 0; i--) {
> > +		grp = &src->head[i];
> > +		j = bio_grp_list_find_grp(dst, grp->grp_data);
> > +		if (j < 0)
> > +			break;
> > +		if (bio_grp_list_grp_empty(&dst->head[j]))
> > +			dst->head[j].grp_data = grp->grp_data;
> > +		__bio_grp_list_merge(&dst->head[j].list, &grp->list);
> > +		bio_list_init(&grp->list);
> > +		cnt++;
> > +	}
> > +
> > +	src->nr_grps -= cnt;
> > +}
> > +
> >  static void bio_poll_ctx_init(struct blk_bio_poll_ctx *pc)
> >  {
> >  	pc->sq = (void *)pc + sizeof(*pc);
> > @@ -866,6 +937,46 @@ static inline void blk_bio_poll_preprocess(struct request_queue *q,
> >  		bio->bi_opf |= REQ_TAG;
> >  }
> >  
> > +static bool blk_bio_poll_prep_submit(struct io_context *ioc, struct bio *bio)
> > +{
> > +	struct blk_bio_poll_ctx *pc = ioc->data;
> > +	unsigned int queued;
> > +
> > +	/*
> > +	 * We rely on immutable .bi_end_io between blk-mq bio submission
> > +	 * and completion. However, bio crypt may update .bi_end_io during
> > +	 * submitting, so simply not support bio based polling for this
> 
> s/submitting/submission/
> s/not/don't/
> 
> > +	 * setting.
> > +	 */
> > +	if (likely(!bio_has_crypt_ctx(bio))) {
> > +		/* track this bio via bio group list */
> > +		spin_lock(&pc->sq_lock);
> > +		queued = bio_grp_list_add(pc->sq, bio);
> > +		spin_unlock(&pc->sq_lock);
> > +	} else {
> > +		queued = false;
> > +	}
> > +
> > +	/*
> > +	 * Now the bio is added per-task fifo, mark it as END_BY_POLL,
> > +	 * and the bio is always completed from the pair poll context.
> 
> This reads awkwardly.. "pair poll context"?

Actually I meant that poll context in which blk_poll(cookie) is called
and 'cookie' is the exact return value of submit_bio(bio based bio) and
this blk-mq bio is for complete the bio driver's bio, and share same
pool context with the bio driver's bio.

> 
> > +	 *
> > +	 * One invariant is that if bio isn't completed, blk_poll() will
> > +	 * be called by passing cookie returned from submitting this bio.
> > +	 */
> > +	if (!queued)
> > +		bio->bi_opf &= ~(REQ_HIPRI | REQ_TAG);
> > +	else
> > +		bio_set_flag(bio, BIO_END_BY_POLL);
> > +
> > +	return queued;
> > +}
> > +
> > +static void blk_bio_poll_post_submit(struct bio *bio, blk_qc_t cookie)
> > +{
> > +	bio->bi_iter.bi_private_data = cookie;
> > +}
> > +
> >  static noinline_for_stack bool submit_bio_checks(struct bio *bio)
> >  {
> >  	struct block_device *bdev = bio->bi_bdev;
> > @@ -1020,7 +1131,7 @@ static blk_qc_t __submit_bio(struct bio *bio)
> >   * bio_list_on_stack[1] contains bios that were submitted before the current
> >   *	->submit_bio_bio, but that haven't been processed yet.
> >   */
> > -static blk_qc_t __submit_bio_noacct(struct bio *bio)
> > +static blk_qc_t __submit_bio_noacct_int(struct bio *bio, struct io_context *ioc)
> >  {
> >  	struct bio_list bio_list_on_stack[2];
> >  	blk_qc_t ret = BLK_QC_T_NONE;
> 
> I mentioned this in previous mail, but what is it you're trying to
> convey with _int?
> 
> Think we need a better function name here.

I will think about one better name, not got one yet.

> 
> > @@ -1043,7 +1154,16 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
> >  		bio_list_on_stack[1] = bio_list_on_stack[0];
> >  		bio_list_init(&bio_list_on_stack[0]);
> >  
> > -		ret = __submit_bio(bio);
> > +		if (ioc && queue_is_mq(q) &&
> > +				(bio->bi_opf & (REQ_HIPRI | REQ_TAG))) {
> > +			bool queued = blk_bio_poll_prep_submit(ioc, bio);
> > +
> > +			ret = __submit_bio(bio);
> > +			if (queued)
> > +				blk_bio_poll_post_submit(bio, ret);
> > +		} else {
> > +			ret = __submit_bio(bio);
> > +		}
> >  
> >  		/*
> >  		 * Sort new bios into those for a lower level and those for the
> > @@ -1069,6 +1189,31 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
> >  	return ret;
> >  }
> >  
> > +static inline blk_qc_t __submit_bio_noacct_poll(struct bio *bio,
> > +		struct io_context *ioc)
> > +{
> > +	struct blk_bio_poll_ctx *pc = ioc->data;
> > +
> > +	__submit_bio_noacct_int(bio, ioc);
> > +
> > +	/* bio submissions queued to per-task poll context */
> > +	if (READ_ONCE(pc->sq->nr_grps))
> > +		return current->pid;
> > +
> > +	/* swapper's pid is 0, but it can't submit poll IO for us */
> > +	return 0;
> > +}
> > +
> > +static inline blk_qc_t __submit_bio_noacct(struct bio *bio)
> > +{
> > +	struct io_context *ioc = current->io_context;
> > +
> > +	if (ioc && ioc->data && (bio->bi_opf & REQ_HIPRI))
> > +		return __submit_bio_noacct_poll(bio, ioc);
> > +
> > +	return __submit_bio_noacct_int(bio, NULL);
> > +}
> > +
> >  static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
> >  {
> >  	struct bio_list bio_list[2] = { };
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 03f59915fe2c..f26950a51f4a 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -3865,14 +3865,185 @@ static inline int blk_mq_poll_hctx(struct request_queue *q,
> >  	return ret;
> >  }
> >  
> > +static blk_qc_t bio_get_poll_cookie(struct bio *bio)
> > +{
> > +	return bio->bi_iter.bi_private_data;
> > +}
> > +
> > +static int blk_mq_poll_io(struct bio *bio)
> > +{
> > +	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> > +	blk_qc_t cookie = bio_get_poll_cookie(bio);
> > +	int ret = 0;
> > +
> > +	if (!bio_flagged(bio, BIO_DONE) && blk_qc_t_valid(cookie)) {
> > +		struct blk_mq_hw_ctx *hctx =
> > +			q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
> > +
> > +		ret += blk_mq_poll_hctx(q, hctx);
> > +	}
> > +	return ret;
> > +}
> > +
> > +static int blk_bio_poll_and_end_io(struct request_queue *q,
> > +		struct blk_bio_poll_ctx *poll_ctx)
> > +{
> > +	int ret = 0;
> > +	int i;
> > +
> > +	/*
> > +	 * Poll hw queue first.
> > +	 *
> > +	 * TODO: limit max poll times and make sure to not poll same
> > +	 * hw queue one more time.
> > +	 */
> > +	for (i = 0; i < poll_ctx->pq->max_nr_grps; i++) {
> > +		struct bio_grp_list_data *grp = &poll_ctx->pq->head[i];
> > +		struct bio *bio;
> > +
> > +		if (bio_grp_list_grp_empty(grp))
> > +			continue;
> > +
> > +		for (bio = grp->list.head; bio; bio = bio->bi_poll)
> > +			ret += blk_mq_poll_io(bio);
> > +	}
> > +
> > +	/* reap bios */
> > +	for (i = 0; i < poll_ctx->pq->max_nr_grps; i++) {
> > +		struct bio_grp_list_data *grp = &poll_ctx->pq->head[i];
> > +		struct bio *bio;
> > +		struct bio_list bl;
> > +
> > +		if (bio_grp_list_grp_empty(grp))
> > +			continue;
> > +
> > +		bio_list_init(&bl);
> > +
> > +		while ((bio = __bio_grp_list_pop(&grp->list))) {
> > +			if (bio_flagged(bio, BIO_DONE)) {
> > +
> 
> Remove empty newline? ^
> 
> > +				/* now recover original data */
> > +				bio->bi_poll = grp->grp_data;
> > +
> > +				/* clear BIO_END_BY_POLL and end me really */
> > +				bio_clear_flag(bio, BIO_END_BY_POLL);
> > +				bio_endio(bio);
> > +			} else {
> > +				__bio_grp_list_add(&bl, bio);
> > +			}
> > +		}
> > +		__bio_grp_list_merge(&grp->list, &bl);
> > +	}
> > +	return ret;
> > +}
> > +
> > +static int __blk_bio_poll_io(struct request_queue *q,
> > +		struct blk_bio_poll_ctx *submit_ctx,
> > +		struct blk_bio_poll_ctx *poll_ctx)
> > +{
> > +	/*
> > +	 * Move IO submission result from submission queue in submission
> > +	 * context to poll queue of poll context.
> > +	 */
> > +	spin_lock(&submit_ctx->sq_lock);
> > +	bio_grp_list_move(poll_ctx->pq, submit_ctx->sq);
> > +	spin_unlock(&submit_ctx->sq_lock);
> > +
> > +	return blk_bio_poll_and_end_io(q, poll_ctx);
> > +}
> > +
> > +static int blk_bio_poll_io(struct request_queue *q,
> > +		struct io_context *submit_ioc,
> > +		struct io_context *poll_ioc)
> > +{
> > +	struct blk_bio_poll_ctx *submit_ctx = submit_ioc->data;
> > +	struct blk_bio_poll_ctx *poll_ctx = poll_ioc->data;
> > +	int ret;
> > +
> > +	if (unlikely(atomic_read(&poll_ioc->nr_tasks) > 1)) {
> > +		mutex_lock(&poll_ctx->pq_lock);
> > +		ret = __blk_bio_poll_io(q, submit_ctx, poll_ctx);
> > +		mutex_unlock(&poll_ctx->pq_lock);
> > +	} else {
> > +		ret = __blk_bio_poll_io(q, submit_ctx, poll_ctx);
> > +	}
> > +	return ret;
> > +}
> > +
> > +static bool blk_bio_ioc_valid(struct task_struct *t)
> > +{
> > +	if (!t)
> > +		return false;
> > +
> > +	if (!t->io_context)
> > +		return false;
> > +
> > +	if (!t->io_context->data)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> > +static int __blk_bio_poll(struct request_queue *q, blk_qc_t cookie)
> > +{
> > +	struct io_context *poll_ioc = current->io_context;
> > +	pid_t pid;
> > +	struct task_struct *submit_task;
> > +	int ret;
> > +
> > +	pid = (pid_t)cookie;
> > +
> > +	/* io poll often share io submission context */
> > +	if (likely(current->pid == pid && blk_bio_ioc_valid(current)))
> > +		return blk_bio_poll_io(q, poll_ioc, poll_ioc);
> > +
> > +	submit_task = find_get_task_by_vpid(pid);
> > +	if (likely(blk_bio_ioc_valid(submit_task)))
> > +		ret = blk_bio_poll_io(q, submit_task->io_context,
> > +				poll_ioc);
> 
> Style nit, but think it fine to put "poll_ioc);" on previous line.
> Otherwise, best to add braces.
> 
> > +	else
> > +		ret = 0;
> > +
> > +	put_task_struct(submit_task);
> > +
> > +	return ret;
> > +}
> > +
> >  static int blk_bio_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
> >  {
> > +	long state;
> > +
> > +	/* no need to poll */
> > +	if (cookie == 0)
> > +		return 0;
> > +
> >  	/*
> >  	 * Create poll queue for storing poll bio and its cookie from
> >  	 * submission queue
> >  	 */
> >  	blk_create_io_context(q, true);
> >  
> > +	state = current->state;
> > +	do {
> > +		int ret;
> > +
> > +		ret = __blk_bio_poll(q, cookie);
> > +		if (ret > 0) {
> > +			__set_current_state(TASK_RUNNING);
> > +			return ret;
> > +		}
> > +
> > +		if (signal_pending_state(state, current))
> > +			__set_current_state(TASK_RUNNING);
> > +
> > +		if (current->state == TASK_RUNNING)
> > +			return 1;
> > +		if (ret < 0 || !spin)
> > +			break;
> > +		cpu_relax();
> > +	} while (!need_resched());
> > +
> > +	__set_current_state(TASK_RUNNING);
> >  	return 0;
> >  }
> >  
> > @@ -3893,7 +4064,7 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
> >  	struct blk_mq_hw_ctx *hctx;
> >  	long state;
> >  
> > -	if (!blk_qc_t_valid(cookie) || !blk_queue_poll(q))
> > +	if (!blk_queue_poll(q) || (queue_is_mq(q) && !blk_qc_t_valid(cookie)))
> >  		return 0;
> >  
> >  	if (current->plug)
> > diff --git a/block/blk.h b/block/blk.h
> > index ae58a706327e..05b9f5eafdd1 100644
> > --- a/block/blk.h
> > +++ b/block/blk.h
> > @@ -403,4 +403,13 @@ static inline void blk_create_io_context(struct request_queue *q,
> >  		bio_poll_ctx_alloc(ioc);
> >  }
> >  
> > +BIO_LIST_HELPERS(__bio_grp_list, poll);
> 
> Why the leading double underscore?
> Especially given the following 2 helpers don't have leading double underscore?
> 
> Whichever you decide, just looking for consistency.

The double underscore helpers are base helpers to build helper without
double underscore.


Thanks, 
Ming

