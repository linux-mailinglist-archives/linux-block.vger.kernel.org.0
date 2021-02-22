Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507F0321076
	for <lists+linux-block@lfdr.de>; Mon, 22 Feb 2021 06:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhBVFbw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 22 Feb 2021 00:31:52 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29632 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhBVFbv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 00:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613971910; x=1645507910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X4RV9jRF76XZsdN/jdiib9/lI789l3/ugU7F/hAYw2g=;
  b=mr/a/CwSwosyWxTBClcKvamrO5QN4ySX981gfvokp/nCVQDX55haNmwL
   FwJfisL+spKV/DsnPopNFSkp5Vxx1J8KzaLRW0LWWJW6U34FSZQDX3vXB
   koNQCKyuVmzRH55u33KEp7b4Fmv45qfF32VD4bvaiE3UcmnHoJCymDLn8
   kA1ZQiR6jlOL1kU0kzIgsurz8mmorw09f1rhQN/Rq0sv4hRpOGeSNxspx
   N5uLo44s957xHAJicwyDiH+6IFUN74AvxW8tsynW+KGWacStM2INY6Djd
   l0AIGJSeSaB24srUJyM7t8drsZ8stHvHParllYJ3mzpoyevyCgTPqQ49h
   A==;
IronPort-SDR: 9SXO38M2Q8DQQa9BexSYlqXCr8Dw91wCUm7zJgl5tegIrrCQif1DufVxTaH/8UlkXVLD930xP9
 1AlcErKJTZRlmyGpJIbCMlwtPOkg0CwexxjZbRp+29fg0JiabH4+8ahr42YLtV7h5MEGuk0/Eh
 s0bux+bF9LZFenArjr66YdWmkJjmbq6VSrR1qNcQCmG39krqIOdA4kUcUR8CvbQihbpd0kgHBS
 D22aEfV8TFyVBcuFMFb9y7JOjye4J6V4J4S5vJR6mdp3nlGgf3xyTHwNGDIUyQw8pLJx44nMv5
 9o0=
X-IronPort-AV: E=Sophos;i="5.81,196,1610380800"; 
   d="scan'208";a="164956456"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2021 13:30:45 +0800
IronPort-SDR: OjBMut9v/Up+6nYt7At615UJDZuWsgrbvd6h3byifiu88wTWrz8Yz/9DlEpH7S1rP3KEOLgfe3
 ZpaQi54XotO1I5EHvntL/BdMcnReLLsDRBWvIhHeeFWOoqUD8m61lkU52cwcYh8gz7fhXYFHjb
 rRio/KsCnMus8FydlYy5bcxht+UIdeStS+wnDKg598vz18jTF1GVI4bJ1bGG8+mIKbktfzNjVx
 ZIpnq2/792gLx3PHdy2nYVAdBofh+biq2WLZS2y9UuNct+OqU4r2tLSx6eOsbdRDsjJo7V/QDD
 iWBNDR8wfMW8SQ8iGE+y+DcA
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2021 21:14:05 -0800
IronPort-SDR: g2ONloCcWDi46zc3uzvUM+1hy0YtzGTDT3DW9X2UumKOcAk8wL36viExpNEEpy1Vt/JuWbr8og
 +j4qOr1P3UopNLsBlAlfCcuBujeulxrtImvEJn55gUWORF/z+QbPTwo71DuyPAMO3ZtDnIb2q6
 b2+ZgoCUCxWrafLLWgjK+GK5theeqyWEJr7rD5KQB6pgT+seWHgCwcz3QqdJt+XdL9ATBksQf8
 sJKETc+UYSgjDl1YFkG9e8ctE0AAKhJPhxMNvja80+YPn0ZywUnKzesvd3tGrm95Fxa9zpvUE0
 3W8=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Feb 2021 21:30:45 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     paolo.valente@linaro.org, axboe@kernel.dk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        akpm@linux-foundation.org, hare@suse.de, colyli@suse.de,
        tj@kernel.org, rdunlap@infradead.org, jack@suse.cz, hch@lst.de
Subject: [PATCH V3 5/5] block: get rid of the trace rq insert wrapper
Date:   Sun, 21 Feb 2021 21:29:59 -0800
Message-Id: <20210222052959.23155-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210222052959.23155-1-chaitanya.kulkarni@wdc.com>
References: <20210222052959.23155-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Get rid of the wrapper for trace_block_rq_insert() and call the function
directly.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bfq-iosched.c   | 4 +++-
 block/blk-core.c      | 1 +
 block/blk-mq-sched.c  | 6 ------
 block/blk-mq-sched.h  | 1 -
 block/kyber-iosched.c | 4 +++-
 block/mq-deadline.c   | 4 +++-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index b398dde53af9..ec482e6641ff 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -125,6 +125,8 @@
 #include <linux/delay.h>
 #include <linux/backing-dev.h>
 
+#include <trace/events/block.h>
+
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-tag.h"
@@ -5621,7 +5623,7 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	spin_unlock_irq(&bfqd->lock);
 
-	blk_mq_sched_request_inserted(rq);
+	trace_block_rq_insert(rq);
 
 	spin_lock_irq(&bfqd->lock);
 	bfqq = bfq_init_rq(rq);
diff --git a/block/blk-core.c b/block/blk-core.c
index 5e752840b41a..fc60ff208497 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -59,6 +59,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(block_rq_remap);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_bio_complete);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_split);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_unplug);
+EXPORT_TRACEPOINT_SYMBOL_GPL(block_rq_insert);
 
 DEFINE_IDA(blk_queue_ida);
 
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index deff4e826e23..ddb65e9e6fd9 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -384,12 +384,6 @@ bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_mq_sched_try_insert_merge);
 
-void blk_mq_sched_request_inserted(struct request *rq)
-{
-	trace_block_rq_insert(rq);
-}
-EXPORT_SYMBOL_GPL(blk_mq_sched_request_inserted);
-
 static bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx,
 				       bool has_sched,
 				       struct request *rq)
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 0476360f05f1..5b18ab915c65 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -7,7 +7,6 @@
 
 void blk_mq_sched_assign_ioc(struct request *rq);
 
-void blk_mq_sched_request_inserted(struct request *rq);
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs, struct request **merged_request);
 bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index c25c41d0d061..f13da10953bf 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -13,6 +13,8 @@
 #include <linux/module.h>
 #include <linux/sbitmap.h>
 
+#include <trace/events/block.h>
+
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-debugfs.h"
@@ -602,7 +604,7 @@ static void kyber_insert_requests(struct blk_mq_hw_ctx *hctx,
 			list_move_tail(&rq->queuelist, head);
 		sbitmap_set_bit(&khd->kcq_map[sched_domain],
 				rq->mq_ctx->index_hw[hctx->type]);
-		blk_mq_sched_request_inserted(rq);
+		trace_block_rq_insert(rq);
 		spin_unlock(&kcq->lock);
 	}
 }
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index b57470e154c8..f3631a287466 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -18,6 +18,8 @@
 #include <linux/rbtree.h>
 #include <linux/sbitmap.h>
 
+#include <trace/events/block.h>
+
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-debugfs.h"
@@ -496,7 +498,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	if (blk_mq_sched_try_insert_merge(q, rq))
 		return;
 
-	blk_mq_sched_request_inserted(rq);
+	trace_block_rq_insert(rq);
 
 	if (at_head || blk_rq_is_passthrough(rq)) {
 		if (at_head)
-- 
2.22.1

