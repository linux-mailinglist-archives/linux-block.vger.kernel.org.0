Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A769334C1D4
	for <lists+linux-block@lfdr.de>; Mon, 29 Mar 2021 04:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhC2CAq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 28 Mar 2021 22:00:46 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:37503 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbhC2CAk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Mar 2021 22:00:40 -0400
Received: by mail-pg1-f181.google.com with SMTP id 33so2571014pgy.4
        for <linux-block@vger.kernel.org>; Sun, 28 Mar 2021 19:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ptGtddf+iHZQ6SBXhNgC5lL8AaDfg1tJ4P7Xhuj5GQ=;
        b=cLvhxXuyL3ODNHBL6KBSa5yXhUzoWHdPhYeCqUOSSbSjQeuDuIJA2RmqAPM5TMjABG
         3SAvHiJjhR/9UWeeUb4kfWeKJgWpO5Z/EdCHLJ22akthKU44OiJZMKdcb2DUIXmoib+e
         KpZqZYbCiZMBxCNmBJbArK8cbqI+xyai7caoLtX35RlMRwPn+MToY5a59CG1RJlX9G5V
         e2u+eLQGc/uKNeW4tQVGwa/HuRYayq93qZdlqytjjCJ9Bxlx2OmSU8MJKGw3+JizTGHQ
         fIn27Zku4zZf/bPms4ETcKS6BBwO5z5aTbMoc/eTHMtBpWu8MaP+Q/HqG10chodKpnMs
         Bn0Q==
X-Gm-Message-State: AOAM530HyLUFKod55YlGkBjkiz3GGXIRH+ZVuZy/4WSvTcRgOC6Sbmkm
        WGt+k9hsondC31vh06A5iBo=
X-Google-Smtp-Source: ABdhPJzy994C3zQQV3anWki5gFT9qOLnyP6x66mEiA9GbreEItdTxHYj3YueYtmZNAxgIQ1KtftRSA==
X-Received: by 2002:a63:1144:: with SMTP id 4mr21625974pgr.333.1616983239707;
        Sun, 28 Mar 2021 19:00:39 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:7123:9470:fec5:1a3a])
        by smtp.gmail.com with ESMTPSA id x125sm15784979pfd.124.2021.03.28.19.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 19:00:39 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v4 3/3] blk-mq: Fix a race between iterating over requests and freeing requests
Date:   Sun, 28 Mar 2021 19:00:28 -0700
Message-Id: <20210329020028.18241-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210329020028.18241-1-bvanassche@acm.org>
References: <20210329020028.18241-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When multiple request queues share a tag set and when switching the I/O
scheduler for one of the request queues associated with that tag set, the
following race can happen:
* blk_mq_tagset_busy_iter() calls bt_tags_iter() and bt_tags_iter() assigns
  a pointer to a scheduler request to the local variable 'rq'.
* blk_mq_sched_free_requests() is called to free hctx->sched_tags.
* blk_mq_tagset_busy_iter() dereferences 'rq' and triggers a use-after-free.

Fix this race as follows:
* Use rcu_assign_pointer() and rcu_dereference() to access hctx->tags->rqs[].
  The performance impact of the assignments added to the hot path is minimal
  (about 1% according to one particular test).
* Protect hctx->tags->rqs[] reads with an RCU read-side lock or with a
  semaphore. Which mechanism is used depends on whether or not it is allowed
  to sleep and also on whether or not the callback function may sleep.
* Wait for all preexisting readers to finish before freeing scheduler
  requests.

Multiple users have reported use-after-free complaints similar to the
following (from https://lore.kernel.org/linux-block/1545261885.185366.488.camel@acm.org/):

BUG: KASAN: use-after-free in bt_iter+0x86/0xf0
Read of size 8 at addr ffff88803b335240 by task fio/21412

CPU: 0 PID: 21412 Comm: fio Tainted: G        W         4.20.0-rc6-dbg+ #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
Call Trace:
 dump_stack+0x86/0xca
 print_address_description+0x71/0x239
 kasan_report.cold.5+0x242/0x301
 __asan_load8+0x54/0x90
 bt_iter+0x86/0xf0
 blk_mq_queue_tag_busy_iter+0x373/0x5e0
 blk_mq_in_flight+0x96/0xb0
 part_in_flight+0x40/0x140
 part_round_stats+0x18e/0x370
 blk_account_io_start+0x3d7/0x670
 blk_mq_bio_to_request+0x19c/0x3a0
 blk_mq_make_request+0x7a9/0xcb0
 generic_make_request+0x41d/0x960
 submit_bio+0x9b/0x250
 do_blockdev_direct_IO+0x435c/0x4c70
 __blockdev_direct_IO+0x79/0x88
 ext4_direct_IO+0x46c/0xc00
 generic_file_direct_write+0x119/0x210
 __generic_file_write_iter+0x11c/0x280
 ext4_file_write_iter+0x1b8/0x6f0
 aio_write+0x204/0x310
 io_submit_one+0x9d3/0xe80
 __x64_sys_io_submit+0x115/0x340
 do_syscall_64+0x71/0x210

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Khazhy Kumykov <khazhy@google.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c   | 34 +++++++++++++++++++++++++++++++++-
 block/blk-mq-tag.c | 41 +++++++++++++++++++++++++++++++++++++----
 block/blk-mq-tag.h |  4 +++-
 block/blk-mq.c     | 21 +++++++++++++++++----
 block/blk-mq.h     |  1 +
 block/blk.h        |  2 ++
 block/elevator.c   |  1 +
 7 files changed, 94 insertions(+), 10 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fc60ff208497..400537dde675 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -279,6 +279,36 @@ void blk_dump_rq_flags(struct request *rq, char *msg)
 }
 EXPORT_SYMBOL(blk_dump_rq_flags);
 
+/**
+ * blk_mq_wait_for_tag_iter - wait for preexisting __blk_mq_all_tag_iter() calls to finish
+ * @set: Tag set to wait on.
+ *
+ * Waits for preexisting __blk_mq_all_tag_iter() calls to finish accessing
+ * hctx->tags->rqs[]. New readers may start while this function is in progress
+ * or after this function has returned. Use this function to make sure that
+ * hctx->tags->rqs[] changes have become globally visible.
+ *
+ * Accesses of hctx->tags->rqs[] by blk_mq_queue_tag_busy_iter() calls are out
+ * of scope for this function. The caller can pause blk_mq_queue_tag_busy_iter()
+ * calls for a request queue by freezing that request queue.
+ */
+void blk_mq_wait_for_tag_iter(struct blk_mq_tag_set *set)
+{
+	struct blk_mq_tags *tags;
+	int i;
+
+	if (set->tags) {
+		for (i = 0; i < set->nr_hw_queues; i++) {
+			tags = set->tags[i];
+			if (!tags)
+				continue;
+			down_write(&tags->iter_rwsem);
+			up_write(&tags->iter_rwsem);
+		}
+	}
+	synchronize_rcu();
+}
+
 /**
  * blk_sync_queue - cancel any pending callbacks on a queue
  * @q: the queue
@@ -412,8 +442,10 @@ void blk_cleanup_queue(struct request_queue *q)
 	 * it is safe to free requests now.
 	 */
 	mutex_lock(&q->sysfs_lock);
-	if (q->elevator)
+	if (q->elevator) {
+		blk_mq_wait_for_tag_iter(q->tag_set);
 		blk_mq_sched_free_requests(q);
+	}
 	mutex_unlock(&q->sysfs_lock);
 
 	percpu_ref_exit(&q->q_usage_counter);
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 3abfa4897ea2..c5e3d7716a5f 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -209,7 +209,12 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 
 	if (!reserved)
 		bitnr += tags->nr_reserved_tags;
-	rq = tags->rqs[bitnr];
+	/*
+	 * See also the percpu_ref_tryget() and blk_queue_exit() calls in
+	 * blk_mq_queue_tag_busy_iter().
+	 */
+	rq = rcu_dereference_check(tags->rqs[bitnr],
+			!percpu_ref_is_zero(&hctx->queue->q_usage_counter));
 
 	/*
 	 * We can hit rq == NULL here, because the tagging functions
@@ -254,11 +259,17 @@ struct bt_tags_iter_data {
 	unsigned int flags;
 };
 
+/* Include reserved tags. */
 #define BT_TAG_ITER_RESERVED		(1 << 0)
+/* Only include started requests. */
 #define BT_TAG_ITER_STARTED		(1 << 1)
+/* Iterate over tags->static_rqs[] instead of tags->rqs[]. */
 #define BT_TAG_ITER_STATIC_RQS		(1 << 2)
+/* The callback function may sleep. */
+#define BT_TAG_ITER_MAY_SLEEP		(1 << 3)
 
-static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
+static bool __bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr,
+			   void *data)
 {
 	struct bt_tags_iter_data *iter_data = data;
 	struct blk_mq_tags *tags = iter_data->tags;
@@ -275,7 +286,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	if (iter_data->flags & BT_TAG_ITER_STATIC_RQS)
 		rq = tags->static_rqs[bitnr];
 	else
-		rq = tags->rqs[bitnr];
+		rq = rcu_dereference_check(tags->rqs[bitnr], true);
 	if (!rq)
 		return true;
 	if ((iter_data->flags & BT_TAG_ITER_STARTED) &&
@@ -284,6 +295,25 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	return iter_data->fn(rq, iter_data->data, reserved);
 }
 
+static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
+{
+	struct bt_tags_iter_data *iter_data = data;
+	struct blk_mq_tags *tags = iter_data->tags;
+	bool res;
+
+	if (iter_data->flags & BT_TAG_ITER_MAY_SLEEP) {
+		down_read(&tags->iter_rwsem);
+		res = __bt_tags_iter(bitmap, bitnr, data);
+		up_read(&tags->iter_rwsem);
+	} else {
+		rcu_read_lock();
+		res = __bt_tags_iter(bitmap, bitnr, data);
+		rcu_read_unlock();
+	}
+
+	return res;
+}
+
 /**
  * bt_tags_for_each - iterate over the requests in a tag map
  * @tags:	Tag map to iterate over.
@@ -357,10 +387,12 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 {
 	int i;
 
+	might_sleep();
+
 	for (i = 0; i < tagset->nr_hw_queues; i++) {
 		if (tagset->tags && tagset->tags[i])
 			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
-					      BT_TAG_ITER_STARTED);
+				BT_TAG_ITER_STARTED | BT_TAG_ITER_MAY_SLEEP);
 	}
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
@@ -544,6 +576,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
+	init_rwsem(&tags->iter_rwsem);
 
 	if (flags & BLK_MQ_F_TAG_HCTX_SHARED)
 		return tags;
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 0290c308ece9..d1d73d7cc7df 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -17,9 +17,11 @@ struct blk_mq_tags {
 	struct sbitmap_queue __bitmap_tags;
 	struct sbitmap_queue __breserved_tags;
 
-	struct request **rqs;
+	struct request __rcu **rqs;
 	struct request **static_rqs;
 	struct list_head page_list;
+
+	struct rw_semaphore iter_rwsem;
 };
 
 extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5b170faa6318..8dc54976815f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -495,8 +495,10 @@ static void __blk_mq_free_request(struct request *rq)
 	blk_crypto_free_request(rq);
 	blk_pm_mark_last_busy(rq);
 	rq->mq_hctx = NULL;
-	if (rq->tag != BLK_MQ_NO_TAG)
+	if (rq->tag != BLK_MQ_NO_TAG) {
 		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
+		rcu_assign_pointer(hctx->tags->rqs[rq->tag], NULL);
+	}
 	if (sched_tag != BLK_MQ_NO_TAG)
 		blk_mq_put_tag(hctx->sched_tags, ctx, sched_tag);
 	blk_mq_sched_restart(hctx);
@@ -838,9 +840,20 @@ EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
 
 struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
 {
+	struct request *rq;
+
 	if (tag < tags->nr_tags) {
-		prefetch(tags->rqs[tag]);
-		return tags->rqs[tag];
+		/*
+		 * Freeing tags happens with the request queue frozen so the
+		 * srcu dereference below is protected by the request queue
+		 * usage count. We can only verify that usage count after
+		 * having read the request pointer.
+		 */
+		rq = rcu_dereference_check(tags->rqs[tag], true);
+		WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && rq &&
+			     percpu_ref_is_zero(&rq->q->q_usage_counter));
+		prefetch(rq);
+		return rq;
 	}
 
 	return NULL;
@@ -1111,7 +1124,7 @@ static bool blk_mq_get_driver_tag(struct request *rq)
 		rq->rq_flags |= RQF_MQ_INFLIGHT;
 		__blk_mq_inc_active_requests(hctx);
 	}
-	hctx->tags->rqs[rq->tag] = rq;
+	rcu_assign_pointer(hctx->tags->rqs[rq->tag], rq);
 	return true;
 }
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 3616453ca28c..9ccb1818303b 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -226,6 +226,7 @@ static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
 					   struct request *rq)
 {
 	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
+	rcu_assign_pointer(hctx->tags->rqs[rq->tag], NULL);
 	rq->tag = BLK_MQ_NO_TAG;
 
 	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
diff --git a/block/blk.h b/block/blk.h
index e0a4a7577f6c..85e0a59ef954 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -184,6 +184,8 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 void blk_account_io_start(struct request *req);
 void blk_account_io_done(struct request *req, u64 now);
 
+void blk_mq_wait_for_tag_iter(struct blk_mq_tag_set *set);
+
 /*
  * Internal elevator interface
  */
diff --git a/block/elevator.c b/block/elevator.c
index 4b20d1ab29cc..70a10e31b336 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -201,6 +201,7 @@ static void elevator_exit(struct request_queue *q, struct elevator_queue *e)
 {
 	lockdep_assert_held(&q->sysfs_lock);
 
+	blk_mq_wait_for_tag_iter(q->tag_set);
 	blk_mq_sched_free_requests(q);
 	__elevator_exit(q, e);
 }
