Return-Path: <linux-block+bounces-140-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2837EB617
	for <lists+linux-block@lfdr.de>; Tue, 14 Nov 2023 19:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1C41C20B21
	for <lists+linux-block@lfdr.de>; Tue, 14 Nov 2023 18:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411BF3FB20;
	Tue, 14 Nov 2023 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-block@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA52B21357
	for <linux-block@vger.kernel.org>; Tue, 14 Nov 2023 18:04:45 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EF2D50;
	Tue, 14 Nov 2023 10:04:33 -0800 (PST)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6c10f098a27so4680534b3a.2;
        Tue, 14 Nov 2023 10:04:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699985073; x=1700589873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrcMRVgoYbthv1/FFt3aRCjeeEnijopEtjBuXOLk8i4=;
        b=HLhiXW+G37hw9RQC7WJ23fVxbCQ7yyCpqKzZH1AOVrQ7ORlbhda0bVkjxkuUcPaPOd
         SOR2qFAjG1jrEif/pcbrb6R7ys3rmXFFCQL97hODp7TFA9pAjba2j5zSjlelo3Lu7rai
         QT80Orak18EPEKe8L+5f94P2x4IZtnRKdOWd5eY+ykeVElPkwfAqUfHa1NoplfsD1qhs
         Wj7rsuP+iSWxRjuZVw8gj47E5wvZaYzhnlqDH23e7rfEsL/B3ewOv/RhjQzWNro4koBz
         QEePB71Sak94PW2wd34itn/5lpi2fhhP633GJMQF5lXYDnQDwyJJ5AkvTvo7mS3de+Yz
         y0PQ==
X-Gm-Message-State: AOJu0Yxc1F/r3GTugj54pKDDf6Df3X5jam5IKh9zFMzuHrx8spK9oTz7
	muLQRtMWWy5o8xC14klM7NA=
X-Google-Smtp-Source: AGHT+IFIA+7Qn9y6sdXM0PCQDeJiHzslY43h3MnvT7p6QgWniyg4q0JVTR1CFLUZYnU7neKkSdzKFA==
X-Received: by 2002:a05:6a00:93a4:b0:6b2:5d32:58c with SMTP id ka36-20020a056a0093a400b006b25d32058cmr9440742pfb.22.1699985072830;
        Tue, 14 Nov 2023 10:04:32 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:2278:ad72:cefb:4d49])
        by smtp.gmail.com with ESMTPSA id bq4-20020a056a02044400b0059d6f5196fasm5101937pgb.78.2023.11.14.10.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 10:04:32 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Yu Kuai <yukuai1@huaweicloud.com>,
	Ed Tsai <ed.tsai@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v5 1/3] block: Introduce flag BLK_MQ_F_DISABLE_FAIR_TAG_SHARING
Date: Tue, 14 Nov 2023 10:04:15 -0800
Message-ID: <20231114180426.1184601-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231114180426.1184601-1-bvanassche@acm.org>
References: <20231114180426.1184601-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fair sharing algorithm has a negative performance impact for storage
devices for which the full queue depth is required to reach peak
performance, e.g. UFS devices. This is because it takes long after a
request queue became inactive until tags are reassigned to the active
request queue(s). Since making tag sharing fair is not needed if the
request processing latency is similar for all request queues, introduce
the hctx / tag set flag BLK_MQ_F_DISABLE_FAIR_TAG_SHARING.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Ed Tsai <ed.tsai@mediatek.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-debugfs.c | 1 +
 block/blk-mq.h         | 3 ++-
 include/linux/blk-mq.h | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 5cbeb9344f2f..f41408103106 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -198,6 +198,7 @@ static const char *const hctx_flag_name[] = {
 	HCTX_FLAG_NAME(NO_SCHED),
 	HCTX_FLAG_NAME(STACKING),
 	HCTX_FLAG_NAME(TAG_HCTX_SHARED),
+	HCTX_FLAG_NAME(DISABLE_FAIR_TAG_SHARING),
 };
 #undef HCTX_FLAG_NAME
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index f75a9ecfebde..eda6bd0611ea 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -416,7 +416,8 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 {
 	unsigned int depth, users;
 
-	if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
+	if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED) ||
+	    (hctx->flags & BLK_MQ_F_DISABLE_FAIR_TAG_SHARING))
 		return true;
 
 	/*
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1ab3081c82ed..b12a0be839aa 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -662,6 +662,7 @@ enum {
 	 * or shared hwqs instead of 'mq-deadline'.
 	 */
 	BLK_MQ_F_NO_SCHED_BY_DEFAULT	= 1 << 7,
+	BLK_MQ_F_DISABLE_FAIR_TAG_SHARING = 1 << 8,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
 	BLK_MQ_F_ALLOC_POLICY_BITS = 1,
 

