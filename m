Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB73C368042
	for <lists+linux-block@lfdr.de>; Thu, 22 Apr 2021 14:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbhDVMXJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 22 Apr 2021 08:23:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55498 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236175AbhDVMXI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Apr 2021 08:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619094153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JTkA4+t1rhZCSGM9w/tvwfqxMN7zFRjEYT2ARJT71n0=;
        b=S2AkBFlt2DuzR2bQJkodcEyjXMe11vYbMsEqlndaekowQ6sRNcq+NMUrWF0LLZU9e+O4HY
        IRul8wgf2/PUr26RKZPyDBiaPuqYlmru2xTXNpSCRjGJCuZPjiquz3r16vzGq3UxKtM9Wu
        0qR3pUOHqxm6+HkipE0feGUn3sjh908=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-yFDuMWR9Nwe6mQRAspfqbQ-1; Thu, 22 Apr 2021 08:22:32 -0400
X-MC-Unique: yFDuMWR9Nwe6mQRAspfqbQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D49831922964;
        Thu, 22 Apr 2021 12:22:30 +0000 (UTC)
Received: from localhost (ovpn-13-243.pek2.redhat.com [10.72.13.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C00F5C1D5;
        Thu, 22 Apr 2021 12:22:20 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 09/12] block: use per-task poll context to implement bio based io polling
Date:   Thu, 22 Apr 2021 20:20:35 +0800
Message-Id: <20210422122038.2192933-10-ming.lei@redhat.com>
In-Reply-To: <20210422122038.2192933-1-ming.lei@redhat.com>
References: <20210422122038.2192933-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently bio based IO polling needs to poll all hw queue blindly, this
way is very inefficient, and one big reason is that we can't pass any
bio submission result to blk_poll().

In IO submission context, track associated underlying bios by per-task
submission queue and store returned 'cookie' in bio->bi_poll_data which
is added by filling a hole of .bi_iter, and return current->pid to
caller of submit_bio() for any bio based driver's IO, which is
submitted from FS.

In IO poll context, the passed cookie tells us the PID of submission
context, then we can find bios from the per-task io pull context of
submission context. Moving bios from submission queue to poll queue of
the poll context, and keep polling until these bios are ended. Remove
bio from poll queue if the bio is ended. Add bio flags of BIO_DONE and
BIO_END_BY_POLL for such purpose.

In was found in Jeffle Xu's test that kfifo doesn't scale well for a
submission queue as queue depth is increased, so a new mechanism for
tracking bios is needed. So far bio's size is close to 2 cacheline size,
and it may not be accepted to add new field into bio for solving the
scalability issue by tracking bios via linked list, switch to bio group
list for tracking bio, the idea is to reuse .bi_end_io for linking bios
into a linked list for all sharing same .bi_end_io(call it bio group),
which is recovered before ending bio really, since BIO_END_BY_POLL is
added for enhancing this point. Usually .bi_end_bio is same for all
bios in same layer, so it is enough to provide very limited groups, such
as 16 or less for fixing the scalability issue.

Usually submission shares context with io poll. The per-task poll context
is just like stack variable, and it is cheap to move data between the two
per-task queues.

Also when the submission task is exiting, drain pending IOs in the context
until all are done.

Tested-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c               |   5 +
 block/blk-core.c          |  39 ++++-
 block/blk-ioc.c           |   3 +
 block/blk-poll.c          | 345 +++++++++++++++++++++++++++++++++++++-
 block/blk.h               |  33 ++++
 include/linux/blk_types.h |  27 ++-
 6 files changed, 448 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 303298996afe..3cf9cf4479db 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1365,6 +1365,11 @@ static inline bool bio_remaining_done(struct bio *bio)
  **/
 void bio_endio(struct bio *bio)
 {
+	/* BIO_END_BY_POLL has to be set before calling submit_bio */
+	if (bio_flagged(bio, BIO_END_BY_POLL)) {
+		bio_set_flag(bio, BIO_DONE);
+		return;
+	}
 again:
 	if (!bio_remaining_done(bio))
 		return;
diff --git a/block/blk-core.c b/block/blk-core.c
index ad57e04d5297..06acb233e606 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -982,7 +982,7 @@ static blk_qc_t __submit_bio(struct bio *bio)
  * bio_list_on_stack[1] contains bios that were submitted before the current
  *	->submit_bio_bio, but that haven't been processed yet.
  */
-static blk_qc_t __submit_bio_noacct(struct bio *bio)
+static blk_qc_t __submit_bio_noacct_ctx(struct bio *bio, struct io_context *ioc)
 {
 	struct bio_list bio_list_on_stack[2];
 	blk_qc_t ret = BLK_QC_T_NONE;
@@ -1005,7 +1005,15 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
 		bio_list_on_stack[1] = bio_list_on_stack[0];
 		bio_list_init(&bio_list_on_stack[0]);
 
-		ret = __submit_bio(bio);
+		if (ioc && queue_is_mq(q) && (bio->bi_opf & REQ_HIPRI)) {
+			bool queued = blk_bio_poll_prep_submit(ioc, bio);
+
+			ret = __submit_bio(bio);
+			if (queued)
+				bio_set_poll_data(bio, ret);
+		} else {
+			ret = __submit_bio(bio);
+		}
 
 		/*
 		 * Sort new bios into those for a lower level and those for the
@@ -1031,6 +1039,33 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
 	return ret;
 }
 
+static inline blk_qc_t __submit_bio_noacct_poll(struct bio *bio,
+		struct io_context *ioc)
+{
+	struct blk_bio_poll_ctx *pc = ioc->data;
+
+	__submit_bio_noacct_ctx(bio, ioc);
+
+	/* bio submissions queued to per-task poll context */
+	if (READ_ONCE(pc->sq->nr_grps))
+		return current->pid;
+
+	/* swapper's pid is 0, but it can't submit poll IO for us */
+	return BLK_QC_T_BIO_NONE;
+}
+
+static inline blk_qc_t __submit_bio_noacct(struct bio *bio)
+{
+	struct io_context *ioc = current->io_context;
+
+	if (ioc && ioc->data && (bio->bi_opf & REQ_HIPRI))
+		return __submit_bio_noacct_poll(bio, ioc);
+
+	__submit_bio_noacct_ctx(bio, NULL);
+
+	return BLK_QC_T_BIO_NONE;
+}
+
 static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
 {
 	struct bio_list bio_list[2] = { };
diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 5574c398eff6..c1fd7c593a54 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -211,6 +211,9 @@ void exit_io_context(struct task_struct *task)
 	task->io_context = NULL;
 	task_unlock(task);
 
+	/* drain io poll submissions */
+	blk_bio_poll_io_drain(ioc);
+
 	atomic_dec(&ioc->nr_tasks);
 	put_io_context_active(ioc);
 }
diff --git a/block/blk-poll.c b/block/blk-poll.c
index 8e4bec55293e..249d73ff6f81 100644
--- a/block/blk-poll.c
+++ b/block/blk-poll.c
@@ -162,7 +162,7 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	struct blk_mq_hw_ctx *hctx;
 	long state;
 
-	if (!blk_qc_t_valid(cookie) || !blk_queue_poll(q))
+	if (queue_is_mq(q) && (!blk_qc_t_valid(cookie) || !blk_queue_poll(q)))
 		return 0;
 
 	if (current->plug)
@@ -212,14 +212,330 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 EXPORT_SYMBOL_GPL(blk_poll);
 
 /* bio base io polling  */
+static inline void *bio_grp_data(struct bio *bio)
+{
+	return bio->bi_poll;
+}
+
+/* add bio into bio group list, return true if it is added */
+static bool bio_grp_list_add(struct bio_grp_list *list, struct bio *bio)
+{
+	int i;
+	struct bio_grp_list_data *grp;
+
+	for (i = 0; i < list->nr_grps; i++) {
+		grp = &list->head[i];
+		if (grp->grp_data == bio_grp_data(bio)) {
+			__bio_grp_list_add(&grp->list, bio);
+			return true;
+		}
+	}
+
+	if (i == list->max_nr_grps)
+		return false;
+
+	/* create a new group */
+	grp = &list->head[i];
+	bio_list_init(&grp->list);
+	grp->grp_data = bio_grp_data(bio);
+	__bio_grp_list_add(&grp->list, bio);
+	list->nr_grps++;
+
+	return true;
+}
+
+static int bio_grp_list_find_grp(struct bio_grp_list *list, void *grp_data)
+{
+	int i;
+	struct bio_grp_list_data *grp;
+
+	for (i = 0; i < list->nr_grps; i++) {
+		grp = &list->head[i];
+		if (grp->grp_data == grp_data)
+			return i;
+	}
+
+	if (i < list->max_nr_grps) {
+		grp = &list->head[i];
+		bio_list_init(&grp->list);
+		return i;
+	}
+
+	return -1;
+}
+
+/* Move as many as possible groups from 'src' to 'dst' */
+static void bio_grp_list_move(struct bio_grp_list *dst,
+		struct bio_grp_list *src)
+{
+	int i, j, cnt = 0;
+	struct bio_grp_list_data *grp;
+
+	for (i = src->nr_grps - 1; i >= 0; i--) {
+		grp = &src->head[i];
+		j = bio_grp_list_find_grp(dst, grp->grp_data);
+		if (j < 0)
+			break;
+		if (bio_grp_list_grp_empty(&dst->head[j])) {
+			dst->head[j].grp_data = grp->grp_data;
+			dst->nr_grps++;
+		}
+		__bio_grp_list_merge(&dst->head[j].list, &grp->list);
+		bio_list_init(&grp->list);
+		cnt++;
+	}
+
+	src->nr_grps -= cnt;
+}
+
+static int blk_mq_poll_io(struct bio *bio)
+{
+	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
+	blk_qc_t cookie = bio_get_poll_data(bio);
+	int ret = 0;
+
+	/* wait until the bio is submitted really */
+	if (!blk_qc_t_ready(cookie))
+		return 0;
+
+	if (!bio_flagged(bio, BIO_DONE) && blk_qc_t_valid(cookie)) {
+		struct blk_mq_hw_ctx *hctx =
+			q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
+
+		ret += blk_mq_poll_hctx(q, hctx);
+	}
+	return ret;
+}
+
+static int blk_bio_poll_and_end_io(struct bio_grp_list *grps)
+{
+	int ret = 0;
+	int i;
+
+	/*
+	 * Poll hw queue first.
+	 *
+	 * TODO: limit max poll times and make sure to not poll same
+	 * hw queue one more time.
+	 */
+	for (i = 0; i < grps->nr_grps; i++) {
+		struct bio_grp_list_data *grp = &grps->head[i];
+		struct bio *bio;
+
+		if (bio_grp_list_grp_empty(grp))
+			continue;
+
+		for (bio = grp->list.head; bio; bio = bio->bi_poll)
+			ret += blk_mq_poll_io(bio);
+	}
+
+	/* reap bios */
+	for (i = 0; i < grps->nr_grps; i++) {
+		struct bio_grp_list_data *grp = &grps->head[i];
+		struct bio *bio;
+		struct bio_list bl;
+
+		if (bio_grp_list_grp_empty(grp))
+			continue;
+
+		bio_list_init(&bl);
+
+		while ((bio = __bio_grp_list_pop(&grp->list))) {
+			if (bio_flagged(bio, BIO_DONE)) {
+				/* now recover original data */
+				bio->bi_poll = grp->grp_data;
+
+				/* clear BIO_END_BY_POLL and end me really */
+				bio_clear_flag(bio, BIO_END_BY_POLL);
+				bio_endio(bio);
+			} else {
+				__bio_grp_list_add(&bl, bio);
+			}
+		}
+		__bio_grp_list_merge(&grp->list, &bl);
+	}
+	return ret;
+}
+
+static void blk_bio_poll_pack_groups(struct bio_grp_list *grps)
+{
+	int i, j, k = 0;
+	int cnt = 0;
+
+	for (i = grps->nr_grps - 1; i >= 0; i--) {
+		struct bio_grp_list_data *grp = &grps->head[i];
+		struct bio_grp_list_data *hole = NULL;
+
+		if (bio_grp_list_grp_empty(grp)) {
+			cnt++;
+			continue;
+		}
+
+		for (j = k; j < i; j++) {
+			if (bio_grp_list_grp_empty(&grps->head[j])) {
+				hole = &grps->head[j];
+				break;
+			}
+		}
+		if (hole == NULL)
+			break;
+		*hole = *grp;
+		cnt++;
+		k = j;
+	}
+
+	grps->nr_grps -= cnt;
+}
+
+#define  MAX_BIO_GRPS_ON_STACK  8
+struct bio_grp_list_stack {
+	unsigned int max_nr_grps, nr_grps;
+	struct bio_grp_list_data head[MAX_BIO_GRPS_ON_STACK];
+};
+
+static int blk_bio_poll_io(struct io_context *submit_ioc)
+
+{
+	struct bio_grp_list_stack _bio_grps = {
+		.max_nr_grps	= ARRAY_SIZE(_bio_grps.head),
+		.nr_grps	= 0
+	};
+	struct bio_grp_list *bio_grps = (struct bio_grp_list *)&_bio_grps;
+	struct blk_bio_poll_ctx *submit_ctx = submit_ioc->data;
+	struct blk_bio_poll_ctx *poll_ctx = blk_get_bio_poll_ctx();
+	int ret = 0;
+
+	/*
+	 * Move IO submission result from submission queue in submission
+	 * context to poll queue of poll context.
+	 */
+	if (READ_ONCE(submit_ctx->sq->nr_grps) > 0) {
+		spin_lock(&submit_ctx->sq_lock);
+		bio_grp_list_move(bio_grps, submit_ctx->sq);
+		spin_unlock(&submit_ctx->sq_lock);
+	}
+
+	/* merge new bios first, then start to poll bios from pq */
+	if (poll_ctx) {
+		spin_lock(&poll_ctx->pq_lock);
+		bio_grp_list_move(poll_ctx->pq, bio_grps);
+		bio_grp_list_move(bio_grps, poll_ctx->pq);
+		spin_unlock(&poll_ctx->pq_lock);
+	}
+
+	do {
+		ret += blk_bio_poll_and_end_io(bio_grps);
+		blk_bio_poll_pack_groups(bio_grps);
+
+		if (bio_grps->nr_grps) {
+			/*
+			 * move back, and keep polling until all can be
+			 * held in either poll queue or submission queue.
+			 */
+			if (poll_ctx) {
+				spin_lock(&poll_ctx->pq_lock);
+				bio_grp_list_move(poll_ctx->pq, bio_grps);
+				spin_unlock(&poll_ctx->pq_lock);
+			} else {
+				spin_lock(&submit_ctx->sq_lock);
+				bio_grp_list_move(submit_ctx->sq, bio_grps);
+				spin_unlock(&submit_ctx->sq_lock);
+			}
+		}
+	} while (bio_grps->nr_grps > 0);
+
+	return ret;
+}
+
+void blk_bio_poll_io_drain(struct io_context *submit_ioc)
+{
+	struct blk_bio_poll_ctx *submit_ctx = submit_ioc->data;
+
+	if (!submit_ctx)
+		return;
+
+	spin_lock(&submit_ctx->sq_lock);
+	while (READ_ONCE(submit_ctx->sq->nr_grps) > 0) {
+		blk_bio_poll_and_end_io(submit_ctx->sq);
+		blk_bio_poll_pack_groups(submit_ctx->sq);
+		cpu_relax();
+	}
+	spin_unlock(&submit_ctx->sq_lock);
+}
+
+static bool blk_bio_ioc_valid(struct task_struct *t)
+{
+	if (!t)
+		return false;
+
+	if (!t->io_context)
+		return false;
+
+	if (!t->io_context->data)
+		return false;
+
+	return true;
+}
+
+static int __blk_bio_poll(blk_qc_t cookie)
+{
+	struct io_context *poll_ioc = current->io_context;
+	pid_t pid;
+	struct task_struct *submit_task;
+	int ret;
+
+	pid = (pid_t)cookie;
+
+	/* io poll often share io submission context */
+	if (likely(current->pid == pid && blk_bio_ioc_valid(current)))
+		return blk_bio_poll_io(poll_ioc);
+
+	submit_task = find_get_task_by_vpid(pid);
+	if (likely(blk_bio_ioc_valid(submit_task)))
+		ret = blk_bio_poll_io(submit_task->io_context);
+	else
+		ret = 0;
+	if (likely(submit_task))
+		put_task_struct(submit_task);
+
+	return ret;
+}
+
 static int blk_bio_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 {
+	long state;
+
+	/* no need to poll */
+	if (cookie == BLK_QC_T_BIO_NONE)
+		return 0;
+
 	/*
 	 * Create poll queue for storing poll bio and its cookie from
 	 * submission queue
 	 */
 	blk_create_io_poll_context(q);
 
+	state = current->state;
+	do {
+		int ret;
+
+		ret = __blk_bio_poll(cookie);
+		if (ret > 0) {
+			__set_current_state(TASK_RUNNING);
+			return ret;
+		}
+
+		if (signal_pending_state(state, current))
+			__set_current_state(TASK_RUNNING);
+
+		if (current->state == TASK_RUNNING)
+			return 1;
+		if (ret < 0 || !spin)
+			break;
+		cpu_relax();
+	} while (!need_resched());
+
+	__set_current_state(TASK_RUNNING);
 	return 0;
 }
 
@@ -255,3 +571,30 @@ void bio_poll_ctx_alloc(struct io_context *ioc)
 			kfree(pc);
 	}
 }
+
+bool blk_bio_poll_prep_submit(struct io_context *ioc, struct bio *bio)
+{
+	struct blk_bio_poll_ctx *pc = ioc->data;
+	unsigned int queued;
+
+	/*
+	 * We rely on immutable .bi_end_io between blk-mq bio submission
+	 * and completion. However, bio crypt may update .bi_end_io during
+	 * submission, so simply don't support bio based polling for this
+	 * setting.
+	 */
+	if (likely(!bio_has_crypt_ctx(bio))) {
+		/* track this bio via bio group list */
+		spin_lock(&pc->sq_lock);
+		queued = bio_grp_list_add(pc->sq, bio);
+		blk_bio_poll_mark_queued(bio, queued);
+		if (queued)
+			bio_set_poll_data(bio, BLK_QC_T_NOT_READY);
+		spin_unlock(&pc->sq_lock);
+	} else {
+		queued = false;
+		blk_bio_poll_mark_queued(bio, false);
+	}
+
+	return queued;
+}
diff --git a/block/blk.h b/block/blk.h
index 47f60612957a..4590da07f8f6 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -376,6 +376,8 @@ struct blk_bio_poll_ctx {
 #define BLK_BIO_POLL_SQ_SZ		16U
 #define BLK_BIO_POLL_PQ_SZ		(BLK_BIO_POLL_SQ_SZ * 2)
 
+bool blk_bio_poll_prep_submit(struct io_context *ioc, struct bio *bio);
+void blk_bio_poll_io_drain(struct io_context *submit_ioc);
 void bio_poll_ctx_alloc(struct io_context *ioc);
 
 static inline bool blk_queue_support_bio_poll(struct request_queue *q)
@@ -431,4 +433,35 @@ static inline void blk_create_io_poll_context(struct request_queue *q)
 		bio_poll_ctx_alloc(ioc);
 }
 
+BIO_LIST_HELPERS(__bio_grp_list, poll);
+
+static inline bool bio_grp_list_grp_empty(struct bio_grp_list_data *grp)
+{
+	return bio_list_empty(&grp->list);
+}
+
+static inline void blk_bio_poll_mark_queued(struct bio *bio, bool queued)
+{
+	/*
+	 * The bio has been added to per-task poll queue, mark it as
+	 * END_BY_POLL, so that this bio is always completed from
+	 * blk_poll() which is provided with cookied from this bio's
+	 * submission.
+	 */
+	if (!queued)
+		bio->bi_opf &= ~(REQ_HIPRI | REQ_POLL_CTX);
+	else
+		bio_set_flag(bio, BIO_END_BY_POLL);
+}
+
+static inline unsigned int bio_get_poll_data(struct bio *bio)
+{
+	return bio->bi_poll_data;
+}
+
+static inline void bio_set_poll_data(struct bio *bio, unsigned int data)
+{
+	bio->bi_poll_data = data;
+}
+
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 99160d588c2d..3c276d163480 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -234,8 +234,20 @@ struct bio {
 	atomic_t		__bi_remaining;
 
 	struct bvec_iter	bi_iter;
+	unsigned int		bi_poll_data;	/* fill hole of bi_iter */
 
-	bio_end_io_t		*bi_end_io;
+	union {
+		bio_end_io_t		*bi_end_io;
+		/*
+		 * bio based io polling needs to track bio via bio group
+		 * list which links bios by their .bi_end_io, and original
+		 * .bi_end_io is saved into the group head. Will recover
+		 * .bi_end_io before really ending bio. BIO_END_BY_POLL
+		 * will make sure that this bio won't be ended before
+		 * recovering .bi_end_io.
+		 */
+		void			*bi_poll;
+	};
 
 	void			*bi_private;
 #ifdef CONFIG_BLK_CGROUP
@@ -304,6 +316,9 @@ enum {
 	BIO_CGROUP_ACCT,	/* has been accounted to a cgroup */
 	BIO_TRACKED,		/* set if bio goes through the rq_qos path */
 	BIO_REMAPPED,
+	BIO_END_BY_POLL,	/* end by blk_bio_poll() explicitly */
+	/* set when bio can be ended, used for bio with BIO_END_BY_POLL */
+	BIO_DONE,
 	BIO_FLAG_LAST
 };
 
@@ -513,6 +528,16 @@ typedef unsigned int blk_qc_t;
 #define BLK_QC_T_NONE		-1U
 #define BLK_QC_T_SHIFT		16
 #define BLK_QC_T_INTERNAL	(1U << 31)
+/* only used for bio based submission, has to be defined as 0 */
+#define BLK_QC_T_BIO_NONE	0
+/* only used for bio based polling, not ready for polling */
+#define BLK_QC_T_NOT_READY	-2U
+
+/* not ready for bio based polling since this bio isn't submitted really */
+static inline bool blk_qc_t_ready(blk_qc_t cookie)
+{
+	return cookie != BLK_QC_T_NOT_READY;
+}
 
 static inline bool blk_qc_t_valid(blk_qc_t cookie)
 {
-- 
2.29.2

