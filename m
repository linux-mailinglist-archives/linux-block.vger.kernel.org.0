Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1D01D620E
	for <lists+linux-block@lfdr.de>; Sat, 16 May 2020 17:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgEPPei (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 16 May 2020 11:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgEPPei (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 11:34:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5378EC061A0C
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 08:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=A/iLjTXl6Yo0g+V4GlFl2DU66NSqKI4Vap7SsHFWzh0=; b=dDANQI+huZ5Lqv7HR7UGso50pw
        Ww+4wVLIAC8CKPo1biVDFMP8XDyYI6hZVr6jXIBlZ0NHWarNOgms8AAqGS60pybPe0lNQMIojVHob
        Ei258SYvPuSD5fej7cOmkv8euEe4dnvxu7V9O5Y4nlbJsCQwCLr6tApNSpcrqKZvYC8yFPfAQkfw+
        ifWJDL7etFpkgnsV0+4g4ryqQw1xfB8cJtzYlDCUPbh+L95rzdeEYn07StSx7ZXixau5NLxiB2jZU
        gC+n7Ec3qPHg0DpBbvnmHJskO7yVTU9u02gd4Xeggap45UmRzU/FlifbS8yOCN6t0yJbymJddR2aU
        LEqvIv9A==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZypf-00050z-KG; Sat, 16 May 2020 15:34:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/4] blk-mq: move the call to blk_queue_enter_live out of blk_mq_get_request
Date:   Sat, 16 May 2020 17:34:27 +0200
Message-Id: <20200516153430.294324-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200516153430.294324-1-hch@lst.de>
References: <20200516153430.294324-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move the blk_queue_enter_live calls into the callers, where they can
successively be cleaned up.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4f8adef7fd0d9..d2962863e629f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -342,8 +342,6 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	bool clear_ctx_on_error = false;
 	u64 alloc_time_ns = 0;
 
-	blk_queue_enter_live(q);
-
 	/* alloc_time includes depth and tag waits */
 	if (blk_queue_rq_alloc_time(q))
 		alloc_time_ns = ktime_get_ns();
@@ -379,7 +377,6 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	if (tag == BLK_MQ_TAG_FAIL) {
 		if (clear_ctx_on_error)
 			data->ctx = NULL;
-		blk_queue_exit(q);
 		return NULL;
 	}
 
@@ -409,11 +406,14 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 	if (ret)
 		return ERR_PTR(ret);
 
+	blk_queue_enter_live(q);
 	rq = blk_mq_get_request(q, NULL, &alloc_data);
 	blk_queue_exit(q);
 
-	if (!rq)
+	if (!rq) {
+		blk_queue_exit(q);
 		return ERR_PTR(-EWOULDBLOCK);
+	}
 
 	rq->__data_len = 0;
 	rq->__sector = (sector_t) -1;
@@ -458,11 +458,14 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
 	alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
 
+	blk_queue_enter_live(q);
 	rq = blk_mq_get_request(q, NULL, &alloc_data);
 	blk_queue_exit(q);
 
-	if (!rq)
+	if (!rq) {
+		blk_queue_exit(q);
 		return ERR_PTR(-EWOULDBLOCK);
+	}
 
 	return rq;
 }
@@ -2043,8 +2046,10 @@ blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	rq_qos_throttle(q, bio);
 
 	data.cmd_flags = bio->bi_opf;
+	blk_queue_enter_live(q);
 	rq = blk_mq_get_request(q, bio, &data);
 	if (unlikely(!rq)) {
+		blk_queue_exit(q);
 		rq_qos_cleanup(q, bio);
 		if (bio->bi_opf & REQ_NOWAIT)
 			bio_wouldblock_error(bio);
-- 
2.26.2

