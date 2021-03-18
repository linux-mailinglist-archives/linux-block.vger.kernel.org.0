Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D55340AA0
	for <lists+linux-block@lfdr.de>; Thu, 18 Mar 2021 17:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhCRQuE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 18 Mar 2021 12:50:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35480 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232256AbhCRQtt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Mar 2021 12:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616086188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xi/VJK0+cBKfLhtuYQf4rMEignq4TUkJMT7CX4+5kW4=;
        b=BDK+A3KE8fSaxG0zkjEPlydPVQam/pczILCBBna/r+baS7RIx7ijx/7F9HzzWEcwIprltN
        4jzQJ9YzkKbeO+i1x0ZzA4uZM/sGjwjgRlPtiRyhGJVCQ3TfQE0jnEgENZbNKead+tJi42
        NXIdKFjSgiedZNBhmOtYLSSZkoQnf1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-te2NxyGcOQ20S6U4JdbR_g-1; Thu, 18 Mar 2021 12:49:43 -0400
X-MC-Unique: te2NxyGcOQ20S6U4JdbR_g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 272C8100CE91;
        Thu, 18 Mar 2021 16:49:24 +0000 (UTC)
Received: from localhost (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D3BB5D9C6;
        Thu, 18 Mar 2021 16:49:23 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH V2 04/13] block: create io poll context for submission and poll task
Date:   Fri, 19 Mar 2021 00:48:18 +0800
Message-Id: <20210318164827.1481133-5-ming.lei@redhat.com>
In-Reply-To: <20210318164827.1481133-1-ming.lei@redhat.com>
References: <20210318164827.1481133-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Create per-task io poll context for both IO submission and poll task
if the queue is bio based and supports polling.

This io polling context includes two queues: submission queue(sq) for
storing HIPRI bio submission result(cookie) and the bio, written
by submission task and read by poll task; polling queue(pq) for holding
data moved from sq, only used in poll context for running bio polling.

Following patches will support bio poll.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c          | 71 ++++++++++++++++++++++++++++++++-------
 block/blk-ioc.c           |  1 +
 block/blk-mq.c            | 14 ++++++++
 block/blk.h               | 46 +++++++++++++++++++++++++
 include/linux/iocontext.h |  2 ++
 5 files changed, 122 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d58f8a0c80de..0b00c21cbefb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -792,16 +792,59 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 	return BLK_STS_OK;
 }
 
-static inline void blk_create_io_context(struct request_queue *q)
+static inline struct blk_bio_poll_ctx *blk_get_bio_poll_ctx(void)
 {
-	/*
-	 * Various block parts want %current->io_context, so allocate it up
-	 * front rather than dealing with lots of pain to allocate it only
-	 * where needed. This may fail and the block layer knows how to live
-	 * with it.
-	 */
-	if (unlikely(!current->io_context))
-		create_task_io_context(current, GFP_ATOMIC, q->node);
+	struct io_context *ioc = current->io_context;
+
+	return ioc ? ioc->data : NULL;
+}
+
+static inline unsigned int bio_grp_list_size(unsigned int nr_grps)
+{
+	return sizeof(struct bio_grp_list) + nr_grps *
+		sizeof(struct bio_grp_list_data);
+}
+
+static void bio_poll_ctx_init(struct blk_bio_poll_ctx *pc)
+{
+	pc->sq = (void *)pc + sizeof(*pc);
+	pc->sq->max_nr_grps = BLK_BIO_POLL_SQ_SZ;
+
+	pc->pq = (void *)pc->sq + bio_grp_list_size(BLK_BIO_POLL_SQ_SZ);
+	pc->pq->max_nr_grps = BLK_BIO_POLL_PQ_SZ;
+
+	spin_lock_init(&pc->sq_lock);
+	mutex_init(&pc->pq_lock);
+}
+
+void bio_poll_ctx_alloc(struct io_context *ioc)
+{
+	struct blk_bio_poll_ctx *pc;
+	unsigned int size = sizeof(*pc) +
+		bio_grp_list_size(BLK_BIO_POLL_SQ_SZ) +
+		bio_grp_list_size(BLK_BIO_POLL_PQ_SZ);
+
+	pc = kzalloc(GFP_ATOMIC, size);
+	if (pc) {
+		bio_poll_ctx_init(pc);
+		if (cmpxchg(&ioc->data, NULL, (void *)pc))
+			kfree(pc);
+	}
+}
+
+static inline bool blk_queue_support_bio_poll(struct request_queue *q)
+{
+	return !queue_is_mq(q) && blk_queue_poll(q);
+}
+
+static inline void blk_bio_poll_preprocess(struct request_queue *q,
+		struct bio *bio)
+{
+	if (!(bio->bi_opf & REQ_HIPRI))
+		return;
+
+	if (!blk_queue_poll(q) || (!queue_is_mq(q) && !blk_get_bio_poll_ctx()))
+		bio->bi_opf &= ~REQ_HIPRI;
 }
 
 static noinline_for_stack bool submit_bio_checks(struct bio *bio)
@@ -848,10 +891,14 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 		}
 	}
 
-	blk_create_io_context(q);
+	/*
+	 * Created per-task io poll queue if we supports bio polling
+	 * and it is one HIPRI bio.
+	 */
+	blk_create_io_context(q, blk_queue_support_bio_poll(q) &&
+			(bio->bi_opf & REQ_HIPRI));
 
-	if (!blk_queue_poll(q))
-		bio->bi_opf &= ~REQ_HIPRI;
+	blk_bio_poll_preprocess(q, bio);
 
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index b0cde18c4b8c..5574c398eff6 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -19,6 +19,7 @@ static struct kmem_cache *iocontext_cachep;
 
 static inline void free_io_context(struct io_context *ioc)
 {
+	kfree(ioc->data);
 	kmem_cache_free(iocontext_cachep, ioc);
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 63c81df3b8b5..c832faa52ca0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3852,6 +3852,17 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
 	return blk_mq_poll_hybrid_sleep(q, rq);
 }
 
+static int blk_bio_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
+{
+	/*
+	 * Create poll queue for storing poll bio and its cookie from
+	 * submission queue
+	 */
+	blk_create_io_context(q, true);
+
+	return 0;
+}
+
 /**
  * blk_poll - poll for IO completions
  * @q:  the queue
@@ -3875,6 +3886,9 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	if (current->plug)
 		blk_flush_plug_list(current->plug, false);
 
+	if (!queue_is_mq(q))
+		return blk_bio_poll(q, cookie, spin);
+
 	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
 
 	/*
diff --git a/block/blk.h b/block/blk.h
index 3b53e44b967e..ae58a706327e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -357,4 +357,50 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		unsigned int max_sectors, bool *same_page);
 
+/* grouping bios belonging to same group into one list  */
+struct bio_grp_list_data {
+	/* group data */
+	void *grp_data;
+
+	/* all bios in this list share same 'grp_data' */
+	struct bio_list list;
+};
+
+struct bio_grp_list {
+	unsigned int max_nr_grps, nr_grps;
+	struct bio_grp_list_data head[0];
+};
+
+struct blk_bio_poll_ctx {
+	spinlock_t sq_lock;
+	struct bio_grp_list *sq;
+
+	struct mutex pq_lock;
+	struct bio_grp_list *pq;
+};
+
+#define BLK_BIO_POLL_SQ_SZ		32U
+#define BLK_BIO_POLL_PQ_SZ		(BLK_BIO_POLL_SQ_SZ * 2)
+
+void bio_poll_ctx_alloc(struct io_context *ioc);
+
+static inline void blk_create_io_context(struct request_queue *q,
+		bool need_poll_ctx)
+{
+	struct io_context *ioc;
+
+	/*
+	 * Various block parts want %current->io_context, so allocate it up
+	 * front rather than dealing with lots of pain to allocate it only
+	 * where needed. This may fail and the block layer knows how to live
+	 * with it.
+	 */
+	if (unlikely(!current->io_context))
+		create_task_io_context(current, GFP_ATOMIC, q->node);
+
+	ioc = current->io_context;
+	if (need_poll_ctx && unlikely(ioc && !ioc->data))
+		bio_poll_ctx_alloc(ioc);
+}
+
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/iocontext.h b/include/linux/iocontext.h
index 0a9dc40b7be8..f9a467571356 100644
--- a/include/linux/iocontext.h
+++ b/include/linux/iocontext.h
@@ -110,6 +110,8 @@ struct io_context {
 	struct io_cq __rcu	*icq_hint;
 	struct hlist_head	icq_list;
 
+	void			*data;
+
 	struct work_struct release_work;
 };
 
-- 
2.29.2

