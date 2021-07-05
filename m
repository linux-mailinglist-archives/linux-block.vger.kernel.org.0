Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D194B3BBF08
	for <lists+linux-block@lfdr.de>; Mon,  5 Jul 2021 17:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbhGEPbN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 5 Jul 2021 11:31:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231964AbhGEPbM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Jul 2021 11:31:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EB7861261;
        Mon,  5 Jul 2021 15:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625498915;
        bh=choV9XyiDQfO8+tQb364qDokC9FLs+TrZnBU+YTMgzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rAsuxG8Mptf3bPu5v6P7ocRwtG8PHtA/ojP+M1cjctYo7IA571xcRvaTrPv1GLkjF
         CRaBA5PuMq+6CJ7v1FjTds3kAA1PIAdctvuqPglYwhNDunOPwFzcbP58b864PvAAPy
         Cgt6JiQ8kRKi+3pfZXvUN2x+3sGNGxs55ZqfZATNa8kLtPJdVKU6qJ/qqTEgDmy0Aa
         1IAvXSL2m/DDtprgALR6zaPoqCk1rsS33LG7JPxyXF8NIB1LlSKo4ni7k80hH80ZZ0
         YsM/bfwRtoMES34UU1JNMXARgopY9BOQyV9NddigrgQLz817bpaYmiCkCGYlAvY8IF
         Wi+VOhUV2Tzbg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 14/59] blk-mq: clear stale request in tags->rq[] before freeing one request pool
Date:   Mon,  5 Jul 2021 11:27:30 -0400
Message-Id: <20210705152815.1520546-14-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210705152815.1520546-1-sashal@kernel.org>
References: <20210705152815.1520546-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit bd63141d585bef14f4caf111f6d0e27fe2300ec6 ]

refcount_inc_not_zero() in bt_tags_iter() still may read one freed
request.

Fix the issue by the following approach:

1) hold a per-tags spinlock when reading ->rqs[tag] and calling
refcount_inc_not_zero in bt_tags_iter()

2) clearing stale request referred via ->rqs[tag] before freeing
request pool, the per-tags spinlock is held for clearing stale
->rq[tag]

So after we cleared stale requests, bt_tags_iter() won't observe
freed request any more, also the clearing will wait for pending
request reference.

The idea of clearing ->rqs[] is borrowed from John Garry's previous
patch and one recent David's patch.

Tested-by: John Garry <john.garry@huawei.com>
Reviewed-by: David Jeffery <djeffery@redhat.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20210511152236.763464-4-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq-tag.c |  9 +++++++--
 block/blk-mq-tag.h |  6 ++++++
 block/blk-mq.c     | 46 +++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 544edf2c56a5..1671dae43030 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -202,10 +202,14 @@ struct bt_iter_data {
 static struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
 		unsigned int bitnr)
 {
-	struct request *rq = tags->rqs[bitnr];
+	struct request *rq;
+	unsigned long flags;
 
+	spin_lock_irqsave(&tags->lock, flags);
+	rq = tags->rqs[bitnr];
 	if (!rq || !refcount_inc_not_zero(&rq->ref))
-		return NULL;
+		rq = NULL;
+	spin_unlock_irqrestore(&tags->lock, flags);
 	return rq;
 }
 
@@ -538,6 +542,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
+	spin_lock_init(&tags->lock);
 
 	if (blk_mq_is_sbitmap_shared(flags))
 		return tags;
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 7d3e6b333a4a..f887988e5ef6 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -20,6 +20,12 @@ struct blk_mq_tags {
 	struct request **rqs;
 	struct request **static_rqs;
 	struct list_head page_list;
+
+	/*
+	 * used to clear request reference in rqs[] before freeing one
+	 * request pool
+	 */
+	spinlock_t lock;
 };
 
 extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index debfa5cd8025..dd371f321d35 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2307,6 +2307,45 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 	return BLK_QC_T_NONE;
 }
 
+static size_t order_to_size(unsigned int order)
+{
+	return (size_t)PAGE_SIZE << order;
+}
+
+/* called before freeing request pool in @tags */
+static void blk_mq_clear_rq_mapping(struct blk_mq_tag_set *set,
+		struct blk_mq_tags *tags, unsigned int hctx_idx)
+{
+	struct blk_mq_tags *drv_tags = set->tags[hctx_idx];
+	struct page *page;
+	unsigned long flags;
+
+	list_for_each_entry(page, &tags->page_list, lru) {
+		unsigned long start = (unsigned long)page_address(page);
+		unsigned long end = start + order_to_size(page->private);
+		int i;
+
+		for (i = 0; i < set->queue_depth; i++) {
+			struct request *rq = drv_tags->rqs[i];
+			unsigned long rq_addr = (unsigned long)rq;
+
+			if (rq_addr >= start && rq_addr < end) {
+				WARN_ON_ONCE(refcount_read(&rq->ref) != 0);
+				cmpxchg(&drv_tags->rqs[i], rq, NULL);
+			}
+		}
+	}
+
+	/*
+	 * Wait until all pending iteration is done.
+	 *
+	 * Request reference is cleared and it is guaranteed to be observed
+	 * after the ->lock is released.
+	 */
+	spin_lock_irqsave(&drv_tags->lock, flags);
+	spin_unlock_irqrestore(&drv_tags->lock, flags);
+}
+
 void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		     unsigned int hctx_idx)
 {
@@ -2325,6 +2364,8 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		}
 	}
 
+	blk_mq_clear_rq_mapping(set, tags, hctx_idx);
+
 	while (!list_empty(&tags->page_list)) {
 		page = list_first_entry(&tags->page_list, struct page, lru);
 		list_del_init(&page->lru);
@@ -2384,11 +2425,6 @@ struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
 	return tags;
 }
 
-static size_t order_to_size(unsigned int order)
-{
-	return (size_t)PAGE_SIZE << order;
-}
-
 static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 			       unsigned int hctx_idx, int node)
 {
-- 
2.30.2

