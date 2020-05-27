Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72B31E4CD1
	for <lists+linux-block@lfdr.de>; Wed, 27 May 2020 20:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388952AbgE0SHF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 27 May 2020 14:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387696AbgE0SHF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 14:07:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CC8C03E97D
        for <linux-block@vger.kernel.org>; Wed, 27 May 2020 11:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=0ujvs5IFJTA1dqLvoX1TlCSNJF0cn8bZct1XLTBA30c=; b=tRb7ayFzmh6nF6qbi0DGilu6o5
        U2eEah1SbW5yh4I+qsGeMl9ZfiXNlc0/cPsAaDHGtclfMn+mJunDsXOeY/unCirtFtLqDxiF88Py5
        uDMeALu0G1bnoRpm3hHN/hNz8T6G744r8ZY3KCK3ZdWJO29VKQemeZr6x43w44J2SL1lBc91dXZhl
        fcKorQdkSMBwDM/WFGUiDbkcEh2J+VCYtrq1864vYzJNO8xTCAbgOwdqww1keBfKDwmSYukILDone
        GnUUIR7uNH/SBh5CZZr/kwWBH8AQvkxwao0EADv7XgX9kdaTIlY+ccWR9Eg5MPIYDO1/ucn6T2Pkk
        bJHvP5eQ==;
Received: from p4fdb0aaa.dip0.t-ipconnect.de ([79.219.10.170] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1je0SG-00051s-Jx; Wed, 27 May 2020 18:07:04 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 7/8] blk-mq: add blk_mq_all_tag_iter
Date:   Wed, 27 May 2020 20:06:43 +0200
Message-Id: <20200527180644.514302-8-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527180644.514302-1-hch@lst.de>
References: <20200527180644.514302-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

Add a new blk_mq_all_tag_iter function to iterate over all allocated
scheduler tags and driver tags.  This is more flexible than the existing
blk_mq_all_tag_busy_iter function as it allows the callers to do whatever
they want on allocated request instead of being limited to started
requests.

It will be used to implement draining allocated requests on specified
hctx in this patchset.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
[hch: switch from the two booleans to a more readable flags field and
 consolidate the tags iter functions]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-tag.c | 46 +++++++++++++++++++++++++++++-----------------
 block/blk-mq-tag.h |  2 ++
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 597ff9c27cf63..9f74064768423 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -256,14 +256,17 @@ struct bt_tags_iter_data {
 	struct blk_mq_tags *tags;
 	busy_tag_iter_fn *fn;
 	void *data;
-	bool reserved;
+	unsigned int flags;
 };
 
+#define BT_TAG_ITER_RESERVED		(1 << 0)
+#define BT_TAG_ITER_STARTED		(1 << 1)
+
 static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 {
 	struct bt_tags_iter_data *iter_data = data;
 	struct blk_mq_tags *tags = iter_data->tags;
-	bool reserved = iter_data->reserved;
+	bool reserved = iter_data->flags & BT_TAG_ITER_RESERVED;
 	struct request *rq;
 
 	if (!reserved)
@@ -274,10 +277,12 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	 * test and set the bit before assining ->rqs[].
 	 */
 	rq = tags->rqs[bitnr];
-	if (rq && blk_mq_request_started(rq))
-		return iter_data->fn(rq, iter_data->data, reserved);
-
-	return true;
+	if (!rq)
+		return true;
+	if ((iter_data->flags & BT_TAG_ITER_STARTED) &&
+	    !blk_mq_request_started(rq))
+		return true;
+	return iter_data->fn(rq, iter_data->data, reserved);
 }
 
 /**
@@ -290,17 +295,16 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
  *		@reserved) where rq is a pointer to a request. Return true
  *		to continue iterating tags, false to stop.
  * @data:	Will be passed as second argument to @fn.
- * @reserved:	Indicates whether @bt is the breserved_tags member or the
- *		bitmap_tags member of struct blk_mq_tags.
+ * @flags:	BT_TAG_ITER_*
  */
 static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
-			     busy_tag_iter_fn *fn, void *data, bool reserved)
+			     busy_tag_iter_fn *fn, void *data, unsigned int flags)
 {
 	struct bt_tags_iter_data iter_data = {
 		.tags = tags,
 		.fn = fn,
 		.data = data,
-		.reserved = reserved,
+		.flags = flags,
 	};
 
 	if (tags->rqs)
@@ -308,21 +312,28 @@ static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
 }
 
 /**
- * blk_mq_all_tag_busy_iter - iterate over all started requests in a tag map
+ * blk_mq_all_tag_iter - iterate over all requests in a tag map
  * @tags:	Tag map to iterate over.
- * @fn:		Pointer to the function that will be called for each started
+ * @fn:		Pointer to the function that will be called for each
  *		request. @fn will be called as follows: @fn(rq, @priv,
  *		reserved) where rq is a pointer to a request. 'reserved'
  *		indicates whether or not @rq is a reserved request. Return
  *		true to continue iterating tags, false to stop.
  * @priv:	Will be passed as second argument to @fn.
  */
-static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
-		busy_tag_iter_fn *fn, void *priv)
+static void __blk_mq_all_tag_iter(struct blk_mq_tags *tags,
+		busy_tag_iter_fn *fn, void *priv, unsigned int flags)
 {
 	if (tags->nr_reserved_tags)
-		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv, true);
-	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false);
+		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv,
+				 flags | BT_TAG_ITER_RESERVED);
+	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, flags);
+}
+
+void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
+		void *priv)
+{
+	return __blk_mq_all_tag_iter(tags, fn, priv, 0);
 }
 
 /**
@@ -342,7 +353,8 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 
 	for (i = 0; i < tagset->nr_hw_queues; i++) {
 		if (tagset->tags && tagset->tags[i])
-			blk_mq_all_tag_busy_iter(tagset->tags[i], fn, priv);
+			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
+					      BT_TAG_ITER_STARTED);
 	}
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 8a741752af8b9..d38e48f2a0a4a 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -34,6 +34,8 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv);
+void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
+		void *priv);
 
 static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
 						 struct blk_mq_hw_ctx *hctx)
-- 
2.26.2

