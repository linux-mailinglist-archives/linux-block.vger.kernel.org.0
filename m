Return-Path: <linux-block+bounces-2479-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD73D83F859
	for <lists+linux-block@lfdr.de>; Sun, 28 Jan 2024 17:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11B11C22AF7
	for <lists+linux-block@lfdr.de>; Sun, 28 Jan 2024 16:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0149D35280;
	Sun, 28 Jan 2024 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mIMGPvgK"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D3033CFB;
	Sun, 28 Jan 2024 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706461135; cv=none; b=O3M3X7z3y55Wf/FnxbgmalP+yB/yM7nCvieOC37ewsmCoYSmuoOJA0/SH2r1elH1YR0CuFzaHqu0mU1NSF6QsLZljAkskUQJOyvH7/9hLDWv72y+DmexGOJ+SXYUBLyDMLW5xKGAW3VuNEubZnHvl2TlWNeG1XlQUPbgpaVrgMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706461135; c=relaxed/simple;
	bh=Y3qD5O4+f1tQwvpbIvPgUZ/zTPw2aUXowCnxx+C2nmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YVpBGVcy5lAhNddOAL7UzvcvcM8pfTN43UlQYqiN8ZxW8ivnAtmxI0PzlV3hPLOhOjzjIPVWx/XQqu5RPUqVLe3o8XEZN+2VQeS8IbmVpGYtB90kKK0wvPr3+PUegBj+LFGWryRJWvVUiw0za4We672v3q8E+jLiYEUivo1j5pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mIMGPvgK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1rC96JPIw60wGtyelFSw0nJY6Da4CMeb34hgsyD2/tk=; b=mIMGPvgKN99saqMkTXJ0rKNMw2
	NAWqCxikc6fB1FWuJm/poiilJ7dpR8GhKn+AYelgV9ZVdPXgIl4kK2HDpaB/YGnvlmSn+gi2FkAGk
	s5U6IfYi4GYX0yn7ijJiDVA+Ozt8EfjNIItXClEBmqvJjXU35VVdCjRXdpg6qUezL6wupUO3DZSON
	xKjWVyIr/UyD04YZpU5IluHxwkA55J1Gow8/rApaJ02YSBf/dvTIWOrd0KKHrNZVIMOGecXRladea
	2xvxnRr8yW4Gu/v4Fv0TiUMlTUn+xnAKQVgEmU3WudFQlJ2sU6fTCoLJ5oOqctWZqsxFGgMgZxs8G
	KoyEXsnA==;
Received: from [2001:4bb8:182:6550:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rU8Uc-0000000A2C5-0J3l;
	Sun, 28 Jan 2024 16:58:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 07/14] block: pass a queue_limits argument to blk_alloc_queue
Date: Sun, 28 Jan 2024 17:58:06 +0100
Message-Id: <20240128165813.3213508-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240128165813.3213508-1-hch@lst.de>
References: <20240128165813.3213508-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Pass a queue_limits to blk_alloc_queue and apply it if non-NULL.  This
will allow allocating queues with valid queue limits instead of setting
the values one at a time later.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-core.c | 30 ++++++++++++++++++++++--------
 block/blk-mq.c   |  6 +++---
 block/blk.h      |  2 +-
 block/genhd.c    |  4 ++--
 4 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 09f4a44a4aa3cc..26d3be06bcc0fd 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -393,24 +393,38 @@ static void blk_timeout_work(struct work_struct *work)
 {
 }
 
-struct request_queue *blk_alloc_queue(int node_id)
+struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 {
 	struct request_queue *q;
+	int error;
 
 	q = kmem_cache_alloc_node(blk_requestq_cachep, GFP_KERNEL | __GFP_ZERO,
 				  node_id);
 	if (!q)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	q->last_merge = NULL;
 
+	if (lim) {
+		error = blk_validate_limits(lim);
+		if (error)
+			goto fail_q;
+		q->limits = *lim;
+	} else {
+		blk_set_default_limits(&q->limits);
+	}
+
 	q->id = ida_alloc(&blk_queue_ida, GFP_KERNEL);
-	if (q->id < 0)
+	if (q->id < 0) {
+		error = q->id;
 		goto fail_q;
+	}
 
 	q->stats = blk_alloc_queue_stats();
-	if (!q->stats)
+	if (!q->stats) {
+		error = -ENOMEM;
 		goto fail_id;
+	}
 
 	q->node = node_id;
 
@@ -435,12 +449,12 @@ struct request_queue *blk_alloc_queue(int node_id)
 	 * Init percpu_ref in atomic mode so that it's faster to shutdown.
 	 * See blk_register_queue() for details.
 	 */
-	if (percpu_ref_init(&q->q_usage_counter,
+	error = percpu_ref_init(&q->q_usage_counter,
 				blk_queue_usage_counter_release,
-				PERCPU_REF_INIT_ATOMIC, GFP_KERNEL))
+				PERCPU_REF_INIT_ATOMIC, GFP_KERNEL);
+	if (error)
 		goto fail_stats;
 
-	blk_set_default_limits(&q->limits);
 	q->nr_requests = BLKDEV_DEFAULT_RQ;
 
 	return q;
@@ -451,7 +465,7 @@ struct request_queue *blk_alloc_queue(int node_id)
 	ida_free(&blk_queue_ida, q->id);
 fail_q:
 	kmem_cache_free(blk_requestq_cachep, q);
-	return NULL;
+	return ERR_PTR(error);
 }
 
 /**
diff --git a/block/blk-mq.c b/block/blk-mq.c
index aa87fcfda1ecfc..2ddbefdeae93e4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4092,9 +4092,9 @@ static struct request_queue *blk_mq_init_queue_data(struct blk_mq_tag_set *set,
 	struct request_queue *q;
 	int ret;
 
-	q = blk_alloc_queue(set->numa_node);
-	if (!q)
-		return ERR_PTR(-ENOMEM);
+	q = blk_alloc_queue(NULL, set->numa_node);
+	if (IS_ERR(q))
+		return q;
 	q->queuedata = queuedata;
 	ret = blk_mq_init_allocated_queue(set, q);
 	if (ret) {
diff --git a/block/blk.h b/block/blk.h
index 58b5dbac2a487d..100c7a02854bfd 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -448,7 +448,7 @@ static inline void bio_release_page(struct bio *bio, struct page *page)
 }
 
 int blk_validate_limits(struct queue_limits *lim);
-struct request_queue *blk_alloc_queue(int node_id);
+struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id);
 
 int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode);
 
diff --git a/block/genhd.c b/block/genhd.c
index d74fb5b4ae6818..defcd35b421bdd 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1396,8 +1396,8 @@ struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass)
 	struct request_queue *q;
 	struct gendisk *disk;
 
-	q = blk_alloc_queue(node);
-	if (!q)
+	q = blk_alloc_queue(NULL, node);
+	if (IS_ERR(q))
 		return NULL;
 
 	disk = __alloc_disk_node(q, node, lkclass);
-- 
2.39.2


