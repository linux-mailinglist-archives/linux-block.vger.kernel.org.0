Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58A3C6F8F3
	for <lists+linux-block@lfdr.de>; Mon, 22 Jul 2019 07:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfGVFkX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 22 Jul 2019 01:40:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfGVFkX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 01:40:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 869A4308A9E2;
        Mon, 22 Jul 2019 05:40:22 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CB6E5DA2E;
        Mon, 22 Jul 2019 05:40:18 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Ming Lei <ming.lei@redhat.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/5] blk-mq: introduce blk_mq_tagset_wait_completed_request()
Date:   Mon, 22 Jul 2019 13:39:51 +0800
Message-Id: <20190722053954.25423-3-ming.lei@redhat.com>
In-Reply-To: <20190722053954.25423-1-ming.lei@redhat.com>
References: <20190722053954.25423-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 22 Jul 2019 05:40:22 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk-mq may schedule to call queue's complete function on remote CPU via
IPI, but doesn't provide any way to synchronize the request's complete
fn.

In some driver's EH(such as NVMe), hardware queue's resource may be freed &
re-allocated. If the completed request's complete fn is run finally after the
hardware queue's resource is released, kernel crash will be triggered.

Prepare for fixing this kind of issue by introducing
blk_mq_tagset_wait_completed_request().

Cc: Max Gurtovoy <maxg@mellanox.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c     | 32 ++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index da19f0bc8876..008388e82b5c 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 
 #include <linux/blk-mq.h>
+#include <linux/delay.h>
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-tag.h"
@@ -354,6 +355,37 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 
+static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
+		void *data, bool reserved)
+{
+	unsigned *count = data;
+
+	if (blk_mq_request_completed(rq))
+		(*count)++;
+	return true;
+}
+
+/**
+ * blk_mq_tagset_wait_completed_request - wait until all completed req's
+ * complete funtion is run
+ * @tagset:	Tag set to drain completed request
+ *
+ * Note: This function has to be run after all IO queues are shutdown
+ */
+void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset)
+{
+	while (true) {
+		unsigned count = 0;
+
+		blk_mq_tagset_busy_iter(tagset,
+				blk_mq_tagset_count_completed_rqs, &count);
+		if (!count)
+			break;
+		msleep(5);
+	}
+}
+EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
+
 /**
  * blk_mq_queue_tag_busy_iter - iterate over all requests with a driver tag
  * @q:		Request queue to examine.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index baac2926e54a..ee0719b649b6 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -322,6 +322,7 @@ bool blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_run_hw_queues(struct request_queue *q, bool async);
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv);
+void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset);
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
 void blk_freeze_queue_start(struct request_queue *q);
-- 
2.20.1

