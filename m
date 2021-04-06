Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A6C355E35
	for <lists+linux-block@lfdr.de>; Tue,  6 Apr 2021 23:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbhDFVtW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 6 Apr 2021 17:49:22 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:43691 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbhDFVtW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 17:49:22 -0400
Received: by mail-pl1-f171.google.com with SMTP id v8so8260814plz.10
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 14:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aE1huiJ7bVzpYhecjGYbtf8NDyQNgfJdRgBX5jR2kW0=;
        b=EuRMWTQF9ZXgsLeHBdUg4tjbh9oP2/OF95iUYHBoYbMKQrUAKMwMvb5jL1iwdtLF0J
         4N28GhcXhUGFiYUjbdEkLllvM8OY7CN6ZFSuITRyNueOOMUuW+Ayb3pgNdLn0ETSg/VV
         fRh1ms+Kvg/UWnZtvGndRV7DBPjybv8KeCuUaRl/qPtuPQxvmN9N2sYZ1que7PFbarAB
         M/zsFsqRoXfmIya0leemB83C5sJcdOrR8xcmK+Pf1G8z9Ny6j8OixNCNvbsmb5DAXD2o
         aA7HihRE+mjtwTFYYDjTgWzV3UcflaVcc+dfGMRPXHIoSpKJY2cM6GTSMmeYaNoiraGz
         cZJg==
X-Gm-Message-State: AOAM533ie+WarcYHBw4nRKPGc7Jk1APbeNm3s+OPDOr4gg7szbkbeUdn
        leMNIWKSoc5f2xmXmTc1yW0=
X-Google-Smtp-Source: ABdhPJzNPoruK3IZeMFW7EdKg193LlpipJHbcWQdkzoPCDccQZJPIsjES35SB28oSvN/mxLMt9kYQA==
X-Received: by 2002:a17:90a:af97:: with SMTP id w23mr198944pjq.101.1617745753757;
        Tue, 06 Apr 2021 14:49:13 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:277d:764e:de23:a2e8])
        by smtp.gmail.com with ESMTPSA id my18sm2866062pjb.38.2021.04.06.14.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 14:49:13 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>,
        Khazhy Kumykov <khazhy@google.com>
Subject: [PATCH v6 2/5] blk-mq: Introduce atomic variants of blk_mq_(all_tag|tagset_busy)_iter
Date:   Tue,  6 Apr 2021 14:49:02 -0700
Message-Id: <20210406214905.21622-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210406214905.21622-1-bvanassche@acm.org>
References: <20210406214905.21622-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since in the next patch knowledge is required of whether or not it is
allowed to sleep inside the tag iteration functions, pass this context
information to the tag iteration functions. I have reviewed all callers of
tag iteration functions to verify these annotations by starting from the
output of the following grep command:

    git grep -nHE 'blk_mq_(all_tag|tagset_busy)_iter'

My conclusions from that analysis are as follows:
- Sleeping is allowed in the blk-mq-debugfs code that iterates over tags.
- Since the blk_mq_tagset_busy_iter() calls in the mtip32xx driver are
  preceded by a function that sleeps (blk_mq_quiesce_queue()), sleeping is
  safe in the context of the blk_mq_tagset_busy_iter() calls.
- The same reasoning also applies to the nbd driver.
- All blk_mq_tagset_busy_iter() calls in the NVMe drivers are followed by a
  call to a function that sleeps so sleeping inside blk_mq_tagset_busy_iter()
  when called from the NVMe driver is fine.
- scsi_host_busy(), scsi_host_complete_all_commands() and
  scsi_host_busy_iter() are used by multiple SCSI LLDs so analyzing whether
  or not these functions may sleep is hard. Instead of performing that
  analysis, make it safe to call these functions from atomic context.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Khazhy Kumykov <khazhy@google.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-tag.c        | 38 +++++++++++++++++++++++++++++++++-----
 block/blk-mq-tag.h        |  2 +-
 block/blk-mq.c            |  2 +-
 drivers/scsi/hosts.c      | 16 ++++++++--------
 drivers/scsi/ufs/ufshcd.c |  4 ++--
 include/linux/blk-mq.h    |  2 ++
 6 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 2a37731e8244..d8eaa38a1bd1 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -322,18 +322,19 @@ static void __blk_mq_all_tag_iter(struct blk_mq_tags *tags,
 }
 
 /**
- * blk_mq_all_tag_iter - iterate over all requests in a tag map
+ * blk_mq_all_tag_iter_atomic - iterate over all requests in a tag map
  * @tags:	Tag map to iterate over.
  * @fn:		Pointer to the function that will be called for each
  *		request. @fn will be called as follows: @fn(rq, @priv,
  *		reserved) where rq is a pointer to a request. 'reserved'
  *		indicates whether or not @rq is a reserved request. Return
- *		true to continue iterating tags, false to stop.
+ *		true to continue iterating tags, false to stop. Must not
+ *		sleep.
  * @priv:	Will be passed as second argument to @fn.
  *
- * Caller has to pass the tag map from which requests are allocated.
+ * Does not sleep.
  */
-void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
+void blk_mq_all_tag_iter_atomic(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
 		void *priv)
 {
 	__blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS);
@@ -348,6 +349,8 @@ void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
  *		indicates whether or not @rq is a reserved request. Return
  *		true to continue iterating tags, false to stop.
  * @priv:	Will be passed as second argument to @fn.
+ *
+ * May sleep.
  */
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv)
@@ -362,6 +365,31 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 
+/**
+ * blk_mq_tagset_busy_iter_atomic - iterate over all started requests in a tag set
+ * @tagset:	Tag set to iterate over.
+ * @fn:		Pointer to the function that will be called for each started
+ *		request. @fn will be called as follows: @fn(rq, @priv,
+ *		reserved) where rq is a pointer to a request. 'reserved'
+ *		indicates whether or not @rq is a reserved request. Return
+ *		true to continue iterating tags, false to stop. Must not sleep.
+ * @priv:	Will be passed as second argument to @fn.
+ *
+ * Does not sleep.
+ */
+void blk_mq_tagset_busy_iter_atomic(struct blk_mq_tag_set *tagset,
+		busy_tag_iter_fn *fn, void *priv)
+{
+	int i;
+
+	for (i = 0; i < tagset->nr_hw_queues; i++) {
+		if (tagset->tags && tagset->tags[i])
+			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
+					      BT_TAG_ITER_STARTED);
+	}
+}
+EXPORT_SYMBOL(blk_mq_tagset_busy_iter_atomic);
+
 static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
 		void *data, bool reserved)
 {
@@ -384,7 +412,7 @@ void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset)
 	while (true) {
 		unsigned count = 0;
 
-		blk_mq_tagset_busy_iter(tagset,
+		blk_mq_tagset_busy_iter_atomic(tagset,
 				blk_mq_tagset_count_completed_rqs, &count);
 		if (!count)
 			break;
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 7d3e6b333a4a..0290c308ece9 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -43,7 +43,7 @@ extern void blk_mq_tag_resize_shared_sbitmap(struct blk_mq_tag_set *set,
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv);
-void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
+void blk_mq_all_tag_iter_atomic(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
 		void *priv);
 
 static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d4d7c1caa439..5b170faa6318 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2483,7 +2483,7 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
 		.hctx	= hctx,
 	};
 
-	blk_mq_all_tag_iter(tags, blk_mq_has_request, &data);
+	blk_mq_all_tag_iter_atomic(tags, blk_mq_has_request, &data);
 	return data.has_rq;
 }
 
diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 697c09ef259b..f8863aa88642 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -573,8 +573,8 @@ int scsi_host_busy(struct Scsi_Host *shost)
 {
 	int cnt = 0;
 
-	blk_mq_tagset_busy_iter(&shost->tag_set,
-				scsi_host_check_in_flight, &cnt);
+	blk_mq_tagset_busy_iter_atomic(&shost->tag_set,
+				       scsi_host_check_in_flight, &cnt);
 	return cnt;
 }
 EXPORT_SYMBOL(scsi_host_busy);
@@ -672,8 +672,8 @@ static bool complete_all_cmds_iter(struct request *rq, void *data, bool rsvd)
  */
 void scsi_host_complete_all_commands(struct Scsi_Host *shost, int status)
 {
-	blk_mq_tagset_busy_iter(&shost->tag_set, complete_all_cmds_iter,
-				&status);
+	blk_mq_tagset_busy_iter_atomic(&shost->tag_set, complete_all_cmds_iter,
+				       &status);
 }
 EXPORT_SYMBOL_GPL(scsi_host_complete_all_commands);
 
@@ -694,11 +694,11 @@ static bool __scsi_host_busy_iter_fn(struct request *req, void *priv,
 /**
  * scsi_host_busy_iter - Iterate over all busy commands
  * @shost:	Pointer to Scsi_Host.
- * @fn:		Function to call on each busy command
+ * @fn:		Function to call on each busy command. Must not sleep.
  * @priv:	Data pointer passed to @fn
  *
  * If locking against concurrent command completions is required
- * ithas to be provided by the caller
+ * it has to be provided by the caller.
  **/
 void scsi_host_busy_iter(struct Scsi_Host *shost,
 			 bool (*fn)(struct scsi_cmnd *, void *, bool),
@@ -709,7 +709,7 @@ void scsi_host_busy_iter(struct Scsi_Host *shost,
 		.priv = priv,
 	};
 
-	blk_mq_tagset_busy_iter(&shost->tag_set, __scsi_host_busy_iter_fn,
-				&iter_data);
+	blk_mq_tagset_busy_iter_atomic(&shost->tag_set,
+				       __scsi_host_busy_iter_fn, &iter_data);
 }
 EXPORT_SYMBOL_GPL(scsi_host_busy_iter);
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index c86760788c72..6d2f8f18e2a3 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1380,7 +1380,7 @@ static bool ufshcd_any_tag_in_use(struct ufs_hba *hba)
 	struct request_queue *q = hba->cmd_queue;
 	int busy = 0;
 
-	blk_mq_tagset_busy_iter(q->tag_set, ufshcd_is_busy, &busy);
+	blk_mq_tagset_busy_iter_atomic(q->tag_set, ufshcd_is_busy, &busy);
 	return busy;
 }
 
@@ -6269,7 +6269,7 @@ static irqreturn_t ufshcd_tmc_handler(struct ufs_hba *hba)
 		.pending = ufshcd_readl(hba, REG_UTP_TASK_REQ_DOOR_BELL),
 	};
 
-	blk_mq_tagset_busy_iter(q->tag_set, ufshcd_compl_tm, &ci);
+	blk_mq_tagset_busy_iter_atomic(q->tag_set, ufshcd_compl_tm, &ci);
 	return ci.ncpl ? IRQ_HANDLED : IRQ_NONE;
 }
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2c473c9b8990..dfa0114a49fd 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -526,6 +526,8 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async);
 void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs);
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv);
+void blk_mq_tagset_busy_iter_atomic(struct blk_mq_tag_set *tagset,
+		busy_tag_iter_fn *fn, void *priv);
 void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset);
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
