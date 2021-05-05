Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5E8373E0E
	for <lists+linux-block@lfdr.de>; Wed,  5 May 2021 17:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhEEPBJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 5 May 2021 11:01:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44600 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232677AbhEEPBG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 May 2021 11:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620226809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CvN2kmmbq5L+PtS1EZV43g/E2OjDT1L3Udc2bAiWGUE=;
        b=Zi4XYszTGEoGZXn/HHzWiZ3gmLC8ZXQL44r53ErLrYhtVML/beTrnX8CAqY/UPWN2sGd9x
        NBuJzudwkPKMZ+vQkuG8amOMlESHTc16PV6MWUQ/9Ytj1Xqg4DnKdXCe6PrGxGtncRt7by
        2RkB2exnyTRR6KI/Qq21qH3mbKk0nMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-ba4sLlr1NZ-esTmmmDglRQ-1; Wed, 05 May 2021 11:00:05 -0400
X-MC-Unique: ba4sLlr1NZ-esTmmmDglRQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0582B101C8D5;
        Wed,  5 May 2021 15:00:04 +0000 (UTC)
Received: from localhost (ovpn-12-80.pek2.redhat.com [10.72.12.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CFDC6106A7B6;
        Wed,  5 May 2021 14:59:57 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 2/4] blk-mq: grab rq->refcount before calling ->fn in blk_mq_tagset_busy_iter
Date:   Wed,  5 May 2021 22:58:53 +0800
Message-Id: <20210505145855.174127-3-ming.lei@redhat.com>
In-Reply-To: <20210505145855.174127-1-ming.lei@redhat.com>
References: <20210505145855.174127-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Grab rq->refcount before calling ->fn in blk_mq_tagset_busy_iter(), and
this way will prevent the request from being re-used when ->fn is
running. The approach is same as what we do during handling timeout.

Fix request UAF related with completion race or queue releasing:

- If one rq is referred before rq->q is frozen, then queue won't be
frozen before the request is released during iteration.

- If one rq is referred after rq->q is frozen, refcount_inc_not_zero()
will return false, and we won't iterate over this request.

However, still one request UAF not covered: refcount_inc_not_zero() may
read one freed request, and it will be handled in next patch.

Tested-by: John Garry <john.garry@huawei.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c | 44 +++++++++++++++++++++++++++++++++-----------
 block/blk-mq.c     | 14 +++++++++-----
 block/blk-mq.h     |  1 +
 3 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 2a37731e8244..4a40d409f5dd 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -199,6 +199,16 @@ struct bt_iter_data {
 	bool reserved;
 };
 
+static struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
+		unsigned int bitnr)
+{
+	struct request *rq = tags->rqs[bitnr];
+
+	if (!rq || !refcount_inc_not_zero(&rq->ref))
+		return NULL;
+	return rq;
+}
+
 static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 {
 	struct bt_iter_data *iter_data = data;
@@ -206,18 +216,22 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	struct blk_mq_tags *tags = hctx->tags;
 	bool reserved = iter_data->reserved;
 	struct request *rq;
+	bool ret = true;
 
 	if (!reserved)
 		bitnr += tags->nr_reserved_tags;
-	rq = tags->rqs[bitnr];
-
+	rq = blk_mq_find_and_get_req(tags, bitnr);
 	/*
 	 * We can hit rq == NULL here, because the tagging functions
 	 * test and set the bit before assigning ->rqs[].
 	 */
-	if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx)
-		return iter_data->fn(hctx, rq, iter_data->data, reserved);
-	return true;
+	if (!rq)
+		return true;
+
+	if (rq->q == hctx->queue && rq->mq_hctx == hctx)
+		ret = iter_data->fn(hctx, rq, iter_data->data, reserved);
+	blk_mq_put_rq_ref(rq);
+	return ret;
 }
 
 /**
@@ -264,6 +278,8 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	struct blk_mq_tags *tags = iter_data->tags;
 	bool reserved = iter_data->flags & BT_TAG_ITER_RESERVED;
 	struct request *rq;
+	bool ret = true;
+	bool iter_static_rqs = !!(iter_data->flags & BT_TAG_ITER_STATIC_RQS);
 
 	if (!reserved)
 		bitnr += tags->nr_reserved_tags;
@@ -272,16 +288,19 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	 * We can hit rq == NULL here, because the tagging functions
 	 * test and set the bit before assigning ->rqs[].
 	 */
-	if (iter_data->flags & BT_TAG_ITER_STATIC_RQS)
+	if (iter_static_rqs)
 		rq = tags->static_rqs[bitnr];
 	else
-		rq = tags->rqs[bitnr];
+		rq = blk_mq_find_and_get_req(tags, bitnr);
 	if (!rq)
 		return true;
-	if ((iter_data->flags & BT_TAG_ITER_STARTED) &&
-	    !blk_mq_request_started(rq))
-		return true;
-	return iter_data->fn(rq, iter_data->data, reserved);
+
+	if (!(iter_data->flags & BT_TAG_ITER_STARTED) ||
+	    blk_mq_request_started(rq))
+		ret = iter_data->fn(rq, iter_data->data, reserved);
+	if (!iter_static_rqs)
+		blk_mq_put_rq_ref(rq);
+	return ret;
 }
 
 /**
@@ -348,6 +367,9 @@ void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
  *		indicates whether or not @rq is a reserved request. Return
  *		true to continue iterating tags, false to stop.
  * @priv:	Will be passed as second argument to @fn.
+ *
+ * We grab one request reference before calling @fn and release it after
+ * @fn returns.
  */
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 466676bc2f0b..d053e80fa6d7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -909,6 +909,14 @@ static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
 	return false;
 }
 
+void blk_mq_put_rq_ref(struct request *rq)
+{
+	if (is_flush_rq(rq, rq->mq_hctx))
+		rq->end_io(rq, 0);
+	else if (refcount_dec_and_test(&rq->ref))
+		__blk_mq_free_request(rq);
+}
+
 static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 		struct request *rq, void *priv, bool reserved)
 {
@@ -942,11 +950,7 @@ static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 	if (blk_mq_req_expired(rq, next))
 		blk_mq_rq_timed_out(rq, reserved);
 
-	if (is_flush_rq(rq, hctx))
-		rq->end_io(rq, 0);
-	else if (refcount_dec_and_test(&rq->ref))
-		__blk_mq_free_request(rq);
-
+	blk_mq_put_rq_ref(rq);
 	return true;
 }
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 9ce64bc4a6c8..556368d2c5b6 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -47,6 +47,7 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
 struct request *blk_mq_dequeue_from_ctx(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_ctx *start);
+void blk_mq_put_rq_ref(struct request *rq);
 
 /*
  * Internal helpers for allocating/freeing the request map
-- 
2.29.2

