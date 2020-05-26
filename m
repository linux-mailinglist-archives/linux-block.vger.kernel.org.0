Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7583F1B8453
	for <lists+linux-block@lfdr.de>; Sat, 25 Apr 2020 09:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgDYHzx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 25 Apr 2020 03:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726035AbgDYHzx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Apr 2020 03:55:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B705C09B049
        for <linux-block@vger.kernel.org>; Sat, 25 Apr 2020 00:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=QRSbladImqpG0qRZzcmSBTq43meBv+lGZdXTt1vOGjo=; b=Uv4E4jqDzLHkqrSs6v9degTn4Q
        hyaHHwC+0zbmgzc1FIo2+18xW79Jm+YsDmE0vOBIwEoL4r1yRuRvOb7fG4Lpr/k6RvO5nTjBPyM9Z
        zflaVvbv3gMZ8MeUXwO8vIY3idZnrWQC1O7ifMNvduDc3nWdAGku/oRCtz68UhCDu4VqqFRcpBYAB
        G+X4z9N/kjia6GOEcGWbeyctOsTZfflYIV+NNNueAW7KyPjDQi4qErQzCmV6EFFPSC+Gx/ilNLUY6
        45ewK1fMjBtLJo2scYGL6ZLbwt+M2YGUh1BAqkxKabRwhM9zJeCqBAAstS8xzSePLH7jRV1uyfUXW
        bPb/ZjAw==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSFfE-0001uJ-TB; Sat, 25 Apr 2020 07:55:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v2] block: remove create_io_context
Date:   Sat, 25 Apr 2020 09:55:51 +0200
Message-Id: <20200425075551.721581-1-hch@lst.de>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

create_io_context just has a single caller, which also happens to not
even use the return value.  Just open code it there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Changes since v1:

 - add a commit log

 block/blk-core.c | 11 ++++++-----
 block/blk.h      | 20 --------------------
 2 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 311596d5dbc41..38e984d95e84b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -963,12 +963,13 @@ generic_make_request_checks(struct bio *bio)
 	}
 
 	/*
-	 * Various block parts want %current->io_context and lazy ioc
-	 * allocation ends up trading a lot of pain for a small amount of
-	 * memory.  Just allocate it upfront.  This may fail and block
-	 * layer knows how to live with it.
+	 * Various block parts want %current->io_context, so allocate it up
+	 * front rather than dealing with lots of pain to allocate it only
+	 * where needed. This may fail and the block layer knows how to live
+	 * with it.
 	 */
-	create_io_context(GFP_ATOMIC, q->node);
+	if (unlikely(!current->io_context))
+		create_task_io_context(current, GFP_ATOMIC, q->node);
 
 	if (!blkcg_bio_issue_check(q, bio))
 		return false;
diff --git a/block/blk.h b/block/blk.h
index 204963bb03e89..73bd3b1c69384 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -303,26 +303,6 @@ void ioc_clear_queue(struct request_queue *q);
 
 int create_task_io_context(struct task_struct *task, gfp_t gfp_mask, int node);
 
-/**
- * create_io_context - try to create task->io_context
- * @gfp_mask: allocation mask
- * @node: allocation node
- *
- * If %current->io_context is %NULL, allocate a new io_context and install
- * it.  Returns the current %current->io_context which may be %NULL if
- * allocation failed.
- *
- * Note that this function can't be called with IRQ disabled because
- * task_lock which protects %current->io_context is IRQ-unsafe.
- */
-static inline struct io_context *create_io_context(gfp_t gfp_mask, int node)
-{
-	WARN_ON_ONCE(irqs_disabled());
-	if (unlikely(!current->io_context))
-		create_task_io_context(current, gfp_mask, node);
-	return current->io_context;
-}
-
 /*
  * Internal throttling interface
  */
-- 
2.26.1

