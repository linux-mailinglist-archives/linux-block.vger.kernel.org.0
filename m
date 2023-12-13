Return-Path: <linux-block+bounces-1015-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB17880EA14
	for <lists+linux-block@lfdr.de>; Tue, 12 Dec 2023 12:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE8CEB21129
	for <lists+linux-block@lfdr.de>; Tue, 12 Dec 2023 11:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4669C5DF2F;
	Tue, 12 Dec 2023 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIPs+xaP"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8E61FC1;
	Tue, 12 Dec 2023 03:12:16 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d2e6e14865so24558625ad.0;
        Tue, 12 Dec 2023 03:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702379536; x=1702984336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kk71sp729csxdUViLno20l6lcdfkMyL/Wdv2yhvpzTA=;
        b=DIPs+xaPr2h+wojsYMYPLe4VRNQiZ+F0Om1/bK28wnBz7QtOZYQtxT+46OKFRPopF/
         Emq2Rrg/INWW6Lv4IOwCnSywRtZbvLd7gznCEgx7Bngb64jmk+QHL9HoYtSrVquwUAxl
         YNVCT+UiG95+KtgYj9djEgf6Mw3sTzny4E+7AyOgWSXe8Z+S5N24RGlNPlx6ghmoLwCA
         4gsX2lVRF+XwbLaUkB1tzjuXovGB2ufXjawBtPEXcqIeuoMOk8ILyCjcHi5H6fNalB4U
         EEIJy7WuOMGNOMT81KgFSCyyE3ljytfzSwsxZ/h3uqs5x91sfZpupcZ+/3XEf0Zx3qjZ
         yi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702379536; x=1702984336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kk71sp729csxdUViLno20l6lcdfkMyL/Wdv2yhvpzTA=;
        b=nWTKQFLwUVyVNg6hhgB1d5nrApyIKDfy9wpEmNYiB6UutOGWc908nqCF2J8qmYYmzB
         Ghm4qgBS/+8zW/ePaj6VfxAai5re5yWB9Bw8SQQ2/Tfgv4vXNFx7xJS8TjeneWIvxE6w
         9vXZc4QYhrY1pB+0/tJ/XMjGpBKhzaqSu1KONLnpI6SZKGbZNCWbFRQN7rxFf7ABKVeG
         5wOJmxf0X0AwdMoAnDD9fIX9JB6ZKSVv52EadgJ0WUI2mIh5pREIkdPundp4vy1d0cYS
         +8u30w3B7MAYK0P6Xebbbmv40cQ3/HVTyHn328NElchD4Pa6+Cb9ozAuUOJ8hQaah6aH
         /ApQ==
X-Gm-Message-State: AOJu0Yyz69auDjJDiIuRRisp8hsCx6o5OSfLLWD76x+4KMixzsPdgkdQ
	sc5mvgvZB7wtiYbLbc4IHZE=
X-Google-Smtp-Source: AGHT+IH+ypC0oT6XrZH3uyP+6+iEZx9SsOkdE5qJlw+adVZmAWQ+SlcAzutITFQmVX46kV8vnEcdig==
X-Received: by 2002:a17:902:6b02:b0:1d0:90bf:cbb7 with SMTP id o2-20020a1709026b0200b001d090bfcbb7mr2387161plk.66.1702379535806;
        Tue, 12 Dec 2023 03:12:15 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902ee5500b001d0511c990csm8345453plo.237.2023.12.12.03.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 03:12:15 -0800 (PST)
From: Hongyu Jin <hongyu.jin.cn@gmail.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	axboe@kernel.dk,
	ebiggers@kernel.org
Cc: zhiguo.niu@unisoc.com,
	ke.wang@unisoc.com,
	yibin.ding@unisoc.com,
	hongyu.jin@unisoc.com,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH v4 1/5] block: Fix bio IO priority setting
Date: Tue, 12 Dec 2023 19:11:46 +0800
Message-Id: <20231212111150.18155-2-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212111150.18155-1-hongyu.jin.cn@gmail.com>
References: <ZXeJ9jAKEQ31OXLP@redhat.com>
 <20231212111150.18155-1-hongyu.jin.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongyu Jin <hongyu.jin@unisoc.com>

Move bio_set_ioprio() into submit_bio():
1. Only call bio_set_ioprio() once to set the priority of original bio,
   the bio that cloned and splited from original bio will auto inherit
   the priority of original bio in clone process.

2. The IO priority can be passed to module that implement
   struct gendisk::fops::submit_bio, help resolve some
   of the IO priority loss issues.

This patch depends on commit 82b74cac2849 ("blk-ioprio: Convert from
rqos policy to direct call")

Fixes: a78418e6a04c ("block: Always initialize bio IO priority on submit")

Co-developed-by: Yibin Ding <yibin.ding@unisoc.com>
Signed-off-by: Yibin Ding <yibin.ding@unisoc.com>
Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
---
 block/blk-core.c | 10 ++++++++++
 block/blk-mq.c   | 11 -----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fdf25b8d6e78..68158c327aea 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -49,6 +49,7 @@
 #include "blk-pm.h"
 #include "blk-cgroup.h"
 #include "blk-throttle.h"
+#include "blk-ioprio.h"
 
 struct dentry *blk_debugfs_root;
 
@@ -809,6 +810,14 @@ void submit_bio_noacct(struct bio *bio)
 }
 EXPORT_SYMBOL(submit_bio_noacct);
 
+static void bio_set_ioprio(struct bio *bio)
+{
+	/* Nobody set ioprio so far? Initialize it based on task's nice value */
+	if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) == IOPRIO_CLASS_NONE)
+		bio->bi_ioprio = get_current_ioprio();
+	blkcg_set_ioprio(bio);
+}
+
 /**
  * submit_bio - submit a bio to the block device layer for I/O
  * @bio: The &struct bio which describes the I/O
@@ -831,6 +840,7 @@ void submit_bio(struct bio *bio)
 		count_vm_events(PGPGOUT, bio_sectors(bio));
 	}
 
+	bio_set_ioprio(bio);
 	submit_bio_noacct(bio);
 }
 EXPORT_SYMBOL(submit_bio);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e2d11183f62e..a6e2609df9c9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -40,7 +40,6 @@
 #include "blk-stat.h"
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
-#include "blk-ioprio.h"
 
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
 static DEFINE_PER_CPU(call_single_data_t, blk_cpu_csd);
@@ -2922,14 +2921,6 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 	return rq;
 }
 
-static void bio_set_ioprio(struct bio *bio)
-{
-	/* Nobody set ioprio so far? Initialize it based on task's nice value */
-	if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) == IOPRIO_CLASS_NONE)
-		bio->bi_ioprio = get_current_ioprio();
-	blkcg_set_ioprio(bio);
-}
-
 /**
  * blk_mq_submit_bio - Create and send a request to block device.
  * @bio: Bio pointer.
@@ -2963,8 +2954,6 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (!bio_integrity_prep(bio))
 		return;
 
-	bio_set_ioprio(bio);
-
 	rq = blk_mq_get_cached_request(q, plug, &bio, nr_segs);
 	if (!rq) {
 		if (!bio)
-- 
2.34.1


