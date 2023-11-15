Return-Path: <linux-block+bounces-149-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFAD7EB868
	for <lists+linux-block@lfdr.de>; Tue, 14 Nov 2023 22:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3091C20B29
	for <lists+linux-block@lfdr.de>; Tue, 14 Nov 2023 21:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF392FC50;
	Tue, 14 Nov 2023 21:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-block@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966682FC3F
	for <linux-block@vger.kernel.org>; Tue, 14 Nov 2023 21:18:37 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9612AF0;
	Tue, 14 Nov 2023 13:18:36 -0800 (PST)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1cc2fc281cdso47167325ad.0;
        Tue, 14 Nov 2023 13:18:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699996716; x=1700601516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVWi2Q1sV9spaxry37mpQP98JceOEq6IkdRxW6ewZhs=;
        b=QoQYuBFEoHVC4QE0z09vVrjHq9ybM9jAINOBhrDotJG1xijnOUUBkIPW3OvMSXmcN9
         p3w6LJPQO5YhHOFJ3tuTQ2qyKLLrBz8h2pkyqh3/SlTDefjSC+p4PsV2Nnh5wG/y2DUL
         mSqrsZDlRhl83RRIk4OmsyScgtj4eJdesgmZut1ofuyFGTjvjw02f2tve+3wXnjUTHlE
         ay2yHoa2rSnXKGuxHiqtUm0/O0G2WOG+ztSnovsYR+WEftTCQxhSxCvSDcPNQZfNgg8g
         rSbXBeoXvyV8jFwZ9honwNI2dLRgF92GKubVweimaOejoaCipKyajYUuy0G6/6JDHuiG
         Fo5Q==
X-Gm-Message-State: AOJu0YyQUo+7m89s8TQElkOcG0I7MS54Xgvg+f5SHjSLpHldaFWcMrib
	3ICzb4rIgEprljmc0hOeD1M=
X-Google-Smtp-Source: AGHT+IEp9+kqkeTpv4Xkg1juZDhsct2JPEvKd7Xw3fYoiyHC5+VwP3N5Q+HgdM1Q86Mj/INBMQF9vA==
X-Received: by 2002:a17:902:8542:b0:1cc:ef37:664a with SMTP id d2-20020a170902854200b001ccef37664amr3088361plo.31.1699996716016;
        Tue, 14 Nov 2023 13:18:36 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:2278:ad72:cefb:4d49])
        by smtp.gmail.com with ESMTPSA id ix7-20020a170902f80700b001c71ec1866fsm6169288plb.258.2023.11.14.13.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 13:18:35 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v15 08/19] scsi: sd: Support sorting commands by LBA before resubmitting
Date: Tue, 14 Nov 2023 13:16:16 -0800
Message-ID: <20231114211804.1449162-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231114211804.1449162-1-bvanassche@acm.org>
References: <20231114211804.1449162-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support sorting SCSI commands by LBA before the SCSI error handler
resubmits these commands. This is necessary when resubmitting zoned writes
(REQ_OP_WRITE) if multiple writes have been queued for a single zone.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/sd.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 530918cbfce2..63bb01ddadde 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -47,6 +47,7 @@
 #include <linux/blkpg.h>
 #include <linux/blk-pm.h>
 #include <linux/delay.h>
+#include <linux/list_sort.h>
 #include <linux/major.h>
 #include <linux/mutex.h>
 #include <linux/string_helpers.h>
@@ -2058,6 +2059,38 @@ static int sd_eh_action(struct scsi_cmnd *scmd, int eh_disp)
 	return eh_disp;
 }
 
+static int sd_cmp_sector(void *priv, const struct list_head *_a,
+			 const struct list_head *_b)
+{
+	struct scsi_cmnd *a = list_entry(_a, typeof(*a), eh_entry);
+	struct scsi_cmnd *b = list_entry(_b, typeof(*b), eh_entry);
+	struct request *rq_a = scsi_cmd_to_rq(a);
+	struct request *rq_b = scsi_cmd_to_rq(b);
+	bool use_zwl_a = rq_a->q->limits.use_zone_write_lock;
+	bool use_zwl_b = rq_b->q->limits.use_zone_write_lock;
+
+	/*
+	 * Order the commands that need zone write locking after the commands
+	 * that do not need zone write locking. Order the commands that do not
+	 * need zone write locking by LBA. Do not reorder the commands that
+	 * need zone write locking. See also the comment above the list_sort()
+	 * definition.
+	 */
+	if (use_zwl_a || use_zwl_b)
+		return use_zwl_a > use_zwl_b;
+	return blk_rq_pos(rq_a) > blk_rq_pos(rq_b);
+}
+
+static void sd_prepare_resubmit(struct list_head *cmd_list)
+{
+	/*
+	 * Sort pending SCSI commands in starting sector order. This is
+	 * important if one of the SCSI devices associated with @shost is a
+	 * zoned block device for which zone write locking is disabled.
+	 */
+	list_sort(NULL, cmd_list, sd_cmp_sector);
+}
+
 static unsigned int sd_completed_bytes(struct scsi_cmnd *scmd)
 {
 	struct request *req = scsi_cmd_to_rq(scmd);
@@ -4014,6 +4047,7 @@ static struct scsi_driver sd_template = {
 	.done			= sd_done,
 	.eh_action		= sd_eh_action,
 	.eh_reset		= sd_eh_reset,
+	.eh_prepare_resubmit	= sd_prepare_resubmit,
 };
 
 /**

