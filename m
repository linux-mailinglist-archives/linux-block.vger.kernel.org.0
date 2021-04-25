Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F5A36A5F1
	for <lists+linux-block@lfdr.de>; Sun, 25 Apr 2021 10:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhDYI7Q (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 25 Apr 2021 04:59:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41773 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229694AbhDYI7O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Apr 2021 04:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619341114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nlKUIawhhdfke5e91nvF9IFytrIJPg/rQRLeCbz+53s=;
        b=ABeue2HGJuqycUxWpaNpotL06DTjpfyfEaCOTsrdYQGdErZuJVerb/4Nbvzq3IBsLc3QOU
        yB0GlF0e21W1s7JtpEVVcsR81k5OlA3JB9xrMlvStpFkCnIIimTfcwlGHPtEtvNf2Bmled
        0JykcRD/15LuMmrZ3usNmSELe5RYvJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-liBRZltwP2y6AS6-HBKHbA-1; Sun, 25 Apr 2021 04:58:31 -0400
X-MC-Unique: liBRZltwP2y6AS6-HBKHbA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F23F1898297;
        Sun, 25 Apr 2021 08:58:29 +0000 (UTC)
Received: from localhost (ovpn-13-143.pek2.redhat.com [10.72.13.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCA7F690F5;
        Sun, 25 Apr 2021 08:58:28 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5/8] blk-mq: blk_mq_complete_request_locally
Date:   Sun, 25 Apr 2021 16:57:50 +0800
Message-Id: <20210425085753.2617424-6-ming.lei@redhat.com>
In-Reply-To: <20210425085753.2617424-1-ming.lei@redhat.com>
References: <20210425085753.2617424-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add blk_mq_complete_request_locally() for completing request via
blk_mq_tagset_busy_iter(), so that we can avoid request UAF related
with queue releasing, or request freeing.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 16 ++++++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 927189a55575..e3d1067b10c3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -681,6 +681,22 @@ void blk_mq_complete_request(struct request *rq)
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
+/**
+ * blk_mq_complete_request_locally - end I/O on a request locally
+ * @rq:		the request being processed
+ *
+ * Description:
+ *	Complete a request by calling the ->complete_rq directly,
+ *	and it is usually used in error handling via
+ *	blk_mq_tagset_busy_iter().
+ **/
+void blk_mq_complete_request_locally(struct request *rq)
+{
+	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
+	rq->q->mq_ops->complete(rq);
+}
+EXPORT_SYMBOL(blk_mq_complete_request_locally);
+
 static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
 	__releases(hctx->srcu)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2c473c9b8990..f630bf9e497e 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -511,6 +511,7 @@ void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 void blk_mq_complete_request(struct request *rq);
 bool blk_mq_complete_request_remote(struct request *rq);
+void blk_mq_complete_request_locally(struct request *rq);
 bool blk_mq_queue_stopped(struct request_queue *q);
 void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx);
 void blk_mq_start_hw_queue(struct blk_mq_hw_ctx *hctx);
-- 
2.29.2

