Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE8E434FB9
	for <lists+linux-block@lfdr.de>; Tue,  4 Jun 2019 20:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfFDSRp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 4 Jun 2019 14:17:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33582 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfFDSRp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jun 2019 14:17:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id x15so3382426pfq.0
        for <linux-block@vger.kernel.org>; Tue, 04 Jun 2019 11:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6VxXdwEp81IaA+kmj3LivDVU5YHXTxQp+Hulra4sYVc=;
        b=KujOikOilWnGImWh/AMt4tJOzkOl+ocbCtPFVTN1kLD5IlGtJAv2+Ss5kWawYgK3hq
         ZdGjJjXnQ+vj46tuwhWo/DCquAb42Nh3kxNdlez4YIx/qrUSuE5+NO2JR4H2DRYm0XhP
         gthdNqo7nWeutgcqajubcCIS2OXjG7HtsGSgc9VjOsmEuO4SPli/Rg+iONmDMn4oxQYT
         P8tqmVhZMjfl+A8ZcOSo9+nZocaOwYMdawNv5jw1I7nUN9+WMt/VQaYD3jvE06/pAhEp
         JgN3MAoWl4J9irQ8PejtWfxnxQf20nvREyLOEr1XVk6jD0TL6agdzMImBFdDZ7p5CtPE
         rYUQ==
X-Gm-Message-State: APjAAAUPXEpf622KM0ywI8zrro8BkhGW+gO6AQKmHQ2DuDvWaMvOIo2R
        4Y7fcMjiQF/7N4xBnyTpXW8=
X-Google-Smtp-Source: APXvYqyqcyglAUsW5W3wQ719bXbV0NatoPkthOJ2Ljsoew1FR8NadtlEKJQK4SYVROPVaVepH2ZUVQ==
X-Received: by 2002:a17:90a:9f8b:: with SMTP id o11mr32134124pjp.102.1559672264274;
        Tue, 04 Jun 2019 11:17:44 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id q19sm18318709pff.96.2019.06.04.11.17.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 11:17:43 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>, Omar Sandoval <osandov@fb.com>
Subject: [PATCH 1/2] blk-mq: Remove blk_mq_put_ctx()
Date:   Tue,  4 Jun 2019 11:17:35 -0700
Message-Id: <20190604181736.903-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190604181736.903-1-bvanassche@acm.org>
References: <20190604181736.903-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No code that occurs between blk_mq_get_ctx() and blk_mq_put_ctx() depends
on preemption being disabled for its correctness. Since removing the CPU
preemption calls does not measurably affect performance, simplify the
blk-mq code by removing the blk_mq_put_ctx() function and also by not
disabling preemption in blk_mq_get_ctx().

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Omar Sandoval <osandov@fb.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-sched.c  |  5 +----
 block/blk-mq-tag.c    |  8 --------
 block/blk-mq.c        | 16 +++-------------
 block/blk-mq.h        |  7 +------
 block/kyber-iosched.c |  1 -
 5 files changed, 5 insertions(+), 32 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 74c6bb871f7e..0daadb8d2274 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -326,10 +326,8 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
 	bool ret = false;
 	enum hctx_type type;
 
-	if (e && e->type->ops.bio_merge) {
-		blk_mq_put_ctx(ctx);
+	if (e && e->type->ops.bio_merge)
 		return e->type->ops.bio_merge(hctx, bio);
-	}
 
 	type = hctx->type;
 	if ((hctx->flags & BLK_MQ_F_SHOULD_MERGE) &&
@@ -340,7 +338,6 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
 		spin_unlock(&ctx->lock);
 	}
 
-	blk_mq_put_ctx(ctx);
 	return ret;
 }
 
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 7513c8eaabee..da19f0bc8876 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -113,7 +113,6 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	struct sbq_wait_state *ws;
 	DEFINE_SBQ_WAIT(wait);
 	unsigned int tag_offset;
-	bool drop_ctx;
 	int tag;
 
 	if (data->flags & BLK_MQ_REQ_RESERVED) {
@@ -136,7 +135,6 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		return BLK_MQ_TAG_FAIL;
 
 	ws = bt_wait_ptr(bt, data->hctx);
-	drop_ctx = data->ctx == NULL;
 	do {
 		struct sbitmap_queue *bt_prev;
 
@@ -161,9 +159,6 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		if (tag != -1)
 			break;
 
-		if (data->ctx)
-			blk_mq_put_ctx(data->ctx);
-
 		bt_prev = bt;
 		io_schedule();
 
@@ -189,9 +184,6 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		ws = bt_wait_ptr(bt, data->hctx);
 	} while (1);
 
-	if (drop_ctx && data->ctx)
-		blk_mq_put_ctx(data->ctx);
-
 	sbitmap_finish_wait(bt, ws, &wait);
 
 found_tag:
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 35948d45d7b9..00d572265aa3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -359,13 +359,13 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	struct elevator_queue *e = q->elevator;
 	struct request *rq;
 	unsigned int tag;
-	bool put_ctx_on_error = false;
+	bool clear_ctx_on_error = false;
 
 	blk_queue_enter_live(q);
 	data->q = q;
 	if (likely(!data->ctx)) {
 		data->ctx = blk_mq_get_ctx(q);
-		put_ctx_on_error = true;
+		clear_ctx_on_error = true;
 	}
 	if (likely(!data->hctx))
 		data->hctx = blk_mq_map_queue(q, data->cmd_flags,
@@ -391,10 +391,8 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 
 	tag = blk_mq_get_tag(data);
 	if (tag == BLK_MQ_TAG_FAIL) {
-		if (put_ctx_on_error) {
-			blk_mq_put_ctx(data->ctx);
+		if (clear_ctx_on_error)
 			data->ctx = NULL;
-		}
 		blk_queue_exit(q);
 		return NULL;
 	}
@@ -431,8 +429,6 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 	if (!rq)
 		return ERR_PTR(-EWOULDBLOCK);
 
-	blk_mq_put_ctx(alloc_data.ctx);
-
 	rq->__data_len = 0;
 	rq->__sector = (sector_t) -1;
 	rq->bio = rq->biotail = NULL;
@@ -1975,7 +1971,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 	plug = current->plug;
 	if (unlikely(is_flush_fua)) {
-		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio);
 
 		/* bypass scheduler for flush rq */
@@ -1989,7 +1984,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		unsigned int request_count = plug->rq_count;
 		struct request *last = NULL;
 
-		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio);
 
 		if (!request_count)
@@ -2023,8 +2017,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		blk_add_rq_to_plug(plug, rq);
 		trace_block_plug(q);
 
-		blk_mq_put_ctx(data.ctx);
-
 		if (same_queue_rq) {
 			data.hctx = same_queue_rq->mq_hctx;
 			trace_block_unplug(q, 1, true);
@@ -2033,11 +2025,9 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		}
 	} else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&
 			!data.hctx->dispatch_busy)) {
-		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio);
 		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
 	} else {
-		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio);
 		blk_mq_sched_insert_request(rq, false, true, true);
 	}
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 633a5a77ee8b..f4bf5161333e 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -151,12 +151,7 @@ static inline struct blk_mq_ctx *__blk_mq_get_ctx(struct request_queue *q,
  */
 static inline struct blk_mq_ctx *blk_mq_get_ctx(struct request_queue *q)
 {
-	return __blk_mq_get_ctx(q, get_cpu());
-}
-
-static inline void blk_mq_put_ctx(struct blk_mq_ctx *ctx)
-{
-	put_cpu();
+	return __blk_mq_get_ctx(q, raw_smp_processor_id());
 }
 
 struct blk_mq_alloc_data {
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index c3b05119cebd..71c7b07b645a 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -574,7 +574,6 @@ static bool kyber_bio_merge(struct blk_mq_hw_ctx *hctx, struct bio *bio)
 	spin_lock(&kcq->lock);
 	merged = blk_mq_bio_list_merge(hctx->queue, rq_list, bio);
 	spin_unlock(&kcq->lock);
-	blk_mq_put_ctx(ctx);
 
 	return merged;
 }
-- 
2.22.0.rc3

