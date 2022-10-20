Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50AB605E4F
	for <lists+linux-block@lfdr.de>; Thu, 20 Oct 2022 12:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiJTK5B (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 20 Oct 2022 06:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiJTK47 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 06:56:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8324B1E098C
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 03:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QXhUEnI1nKUkMPj9QThMIf1xQX59ugM0hriEmPF3uGU=; b=maC2VIuMNWn050fcBiqZ/Fv8Tc
        Kpik5p5IggZWGG95sVWKIwrAfb8LkiFjOCOQM7fvrxiGufsL7XTXtpSFVT0o4ysWP6XfxDdz5VqTt
        d9SwT7wLEoLu/NMrBpnGXcGyjbGFFwsMm7hBfg9YRHL9OOcjdUUxH64+i67R5NMBygvu/AGo16gi/
        E6c+teYvm9SNwRg09ZCHKOqt+pOimIaQNEfqskAH0B3mQSLifuC5mztNYcMLddNXTbMQD0sUnmTas
        GOD8+VbCH0N75e+yU9RooffDJ7gZjxvirgTff2DhdRrHwq0rcudvm+RHQBqSAU+RMkA63zL35eQK2
        BKVkqQwA==;
Received: from [88.128.92.117] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olTE2-00DqkZ-6k; Thu, 20 Oct 2022 10:56:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 5/8] blk-mq: add tagset quiesce interface
Date:   Thu, 20 Oct 2022 12:56:05 +0200
Message-Id: <20221020105608.1581940-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221020105608.1581940-1-hch@lst.de>
References: <20221020105608.1581940-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chao Leng <lengchao@huawei.com>

Drivers that have shared tagsets may need to quiesce potentially a lot
of request queues that all share a single tagset (e.g. nvme). Add an
interface to quiesce all the queues on a given tagset. This interface is
useful because it can speedup the quiesce by doing it in parallel.

Because some queues should not need to be quiesced(e.g. nvme connect_q)
when quiesce the tagset. So introduce QUEUE_FLAG_SKIP_TAGSET_QUIESCE to
tagset quiesce interface to skip the queue.

Signed-off-by: Chao Leng <lengchao@huawei.com>
[hch: simplify for the per-tag_set srcu_struct]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c         | 25 +++++++++++++++++++++++++
 include/linux/blk-mq.h |  2 ++
 include/linux/blkdev.h |  3 +++
 3 files changed, 30 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index cf8f9f9a96c35..b0d2dd56bfdf2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -313,6 +313,31 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
 
+void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
+{
+	struct request_queue *q;
+
+	mutex_lock(&set->tag_list_lock);
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		if (!blk_queue_skip_tagset_quiesce(q))
+			blk_mq_quiesce_queue_nowait(q);
+	}
+	blk_mq_wait_quiesce_done(set);
+	mutex_unlock(&set->tag_list_lock);
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_tagset);
+
+void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
+{
+	struct request_queue *q;
+
+	mutex_lock(&set->tag_list_lock);
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		blk_mq_unquiesce_queue(q);
+	mutex_unlock(&set->tag_list_lock);
+}
+EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
+
 void blk_mq_wake_waiters(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index dfd565c4fb84e..35747949f7739 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -882,6 +882,8 @@ void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
 void blk_mq_quiesce_queue(struct request_queue *q);
 void blk_mq_wait_quiesce_done(struct blk_mq_tag_set *set);
+void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set);
+void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set);
 void blk_mq_unquiesce_queue(struct request_queue *q);
 void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
 void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b15b6a011c028..854b4745cdd1f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -571,6 +571,7 @@ struct request_queue {
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
 #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
+#define QUEUE_FLAG_SKIP_TAGSET_QUIESCE	31 /* quiesce_tagset skip the queue*/
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1UL << QUEUE_FLAG_IO_STAT) |		\
 				 (1UL << QUEUE_FLAG_SAME_COMP) |	\
@@ -610,6 +611,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_pm_only(q)	atomic_read(&(q)->pm_only)
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
 #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
+#define blk_queue_skip_tagset_quiesce(q) \
+	test_bit(QUEUE_FLAG_SKIP_TAGSET_QUIESCE, &(q)->queue_flags)
 
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
-- 
2.30.2

