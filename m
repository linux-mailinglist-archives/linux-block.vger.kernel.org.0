Return-Path: <linux-block+bounces-151-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E76C7EB86A
	for <lists+linux-block@lfdr.de>; Tue, 14 Nov 2023 22:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EED81C20B3D
	for <lists+linux-block@lfdr.de>; Tue, 14 Nov 2023 21:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9F12FC43;
	Tue, 14 Nov 2023 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-block@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268D62FC4B
	for <linux-block@vger.kernel.org>; Tue, 14 Nov 2023 21:18:47 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126F310C;
	Tue, 14 Nov 2023 13:18:46 -0800 (PST)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1cc2f17ab26so45872395ad.0;
        Tue, 14 Nov 2023 13:18:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699996725; x=1700601525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ga3scwKkF9qdx4A7qJSd8RHB1gIKlvpQqaon9XQUKgo=;
        b=UhSpvO8Z59/YVN2Ib4iF9oTuaL3bVh5zr2P5MSDYlqdZcCT4wXYTTTR7rpVNVKEyCa
         zEOPJRjwLhkyR8922XdQZJol4SCnDBK9BbgLTxl/nDO4jT1m80kp/1ORVPcHPXbESZpj
         FxIXB74f1KM37kR0qmPbOQaeMw4HCsYDYJ6WtWC7y4lTzOp4du1A7JmjHPjyelPr37TR
         sAoYp7SP9Nk2MtelKFREE5mT1xwP/974X4LXSavyFybkYQR2W1P9Nlbf3N8AIrDdkkdh
         4mC3WRuKAO1GACIyynFDGDE2SLXRxj27VCr0uV1LDqIp800VR0fO2yKmijIvs2xkZy+/
         Z0Gw==
X-Gm-Message-State: AOJu0Yy4hZmwYQdI6qGPF+AkNf9wE9K8vjjaZTdUbIiNk6Ft1ArGLpT0
	4xPedAfsfEuXNprAk+VgmG4=
X-Google-Smtp-Source: AGHT+IGpVL8qlxt+SMe76aCZCYpbUMzJ4XdAOgyg+UBWsG9lfmZB1jdRk9YL/pZskk/OU92qXqg9Xg==
X-Received: by 2002:a17:902:9343:b0:1cc:6d2c:fb59 with SMTP id g3-20020a170902934300b001cc6d2cfb59mr3550760plp.28.1699996725353;
        Tue, 14 Nov 2023 13:18:45 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:2278:ad72:cefb:4d49])
        by smtp.gmail.com with ESMTPSA id ix7-20020a170902f80700b001c71ec1866fsm6169288plb.258.2023.11.14.13.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 13:18:44 -0800 (PST)
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
Subject: [PATCH v15 10/19] scsi: core: Retry unaligned zoned writes
Date: Tue, 14 Nov 2023 13:16:18 -0800
Message-ID: <20231114211804.1449162-11-bvanassche@acm.org>
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

If zoned writes (REQ_OP_WRITE) for a sequential write required zone have
a starting LBA that differs from the write pointer, e.g. because zoned
writes have been reordered, then the storage device will respond with an
UNALIGNED WRITE COMMAND error. Send commands that failed with an
unaligned write error to the SCSI error handler if zone write locking is
disabled. The SCSI error handler will sort SCSI commands per LBA before
resubmitting these.

If zone write locking is disabled, increase the number of retries for
write commands sent to a sequential zone to the maximum number of
outstanding commands because in the worst case the number of times
reordered zoned writes have to be retried is (number of outstanding
writes per sequential zone) - 1.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/constants.c  |  1 +
 drivers/scsi/scsi_error.c | 17 +++++++++++++++++
 drivers/scsi/scsi_lib.c   |  1 +
 drivers/scsi/sd.c         |  6 ++++++
 include/scsi/scsi.h       |  1 +
 5 files changed, 26 insertions(+)

diff --git a/drivers/scsi/constants.c b/drivers/scsi/constants.c
index 340785536998..8ddb30741999 100644
--- a/drivers/scsi/constants.c
+++ b/drivers/scsi/constants.c
@@ -419,6 +419,7 @@ EXPORT_SYMBOL(scsi_hostbyte_string);
 
 #define scsi_mlreturn_name(result)	{ result, #result }
 static const struct value_name_pair scsi_mlreturn_arr[] = {
+	scsi_mlreturn_name(NEEDS_DELAYED_RETRY),
 	scsi_mlreturn_name(NEEDS_RETRY),
 	scsi_mlreturn_name(SUCCESS),
 	scsi_mlreturn_name(FAILED),
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 3a2643293abf..4e9a35866a0d 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -699,6 +699,23 @@ enum scsi_disposition scsi_check_sense(struct scsi_cmnd *scmd)
 		fallthrough;
 
 	case ILLEGAL_REQUEST:
+		/*
+		 * Unaligned write command. This may indicate that zoned writes
+		 * have been received by the device in the wrong order. If zone
+		 * write locking is disabled, retry after all pending commands
+		 * have completed.
+		 */
+		if (sshdr.asc == 0x21 && sshdr.ascq == 0x04 &&
+		    !req->q->limits.use_zone_write_lock &&
+		    blk_rq_is_seq_zoned_write(req) &&
+		    scsi_cmd_retry_allowed(scmd)) {
+			SCSI_LOG_ERROR_RECOVERY(1,
+				sdev_printk(KERN_WARNING, scmd->device,
+				"Retrying unaligned write at LBA %#llx.\n",
+				scsi_get_lba(scmd)));
+			return NEEDS_DELAYED_RETRY;
+		}
+
 		if (sshdr.asc == 0x20 || /* Invalid command operation code */
 		    sshdr.asc == 0x21 || /* Logical block address out of range */
 		    sshdr.asc == 0x22 || /* Invalid function */
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index cf3864f72093..2e28a1aeedd0 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1442,6 +1442,7 @@ static void scsi_complete(struct request *rq)
 	case ADD_TO_MLQUEUE:
 		scsi_queue_insert(cmd, SCSI_MLQUEUE_DEVICE_BUSY);
 		break;
+	case NEEDS_DELAYED_RETRY:
 	default:
 		scsi_eh_scmd_add(cmd);
 		break;
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index d52ea605ada8..7e71f9f42036 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1276,6 +1276,12 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 	cmd->transfersize = sdp->sector_size;
 	cmd->underflow = nr_blocks << 9;
 	cmd->allowed = sdkp->max_retries;
+	/*
+	 * Increase the number of allowed retries for zoned writes if zone
+	 * write locking is disabled.
+	 */
+	if (!rq->q->limits.use_zone_write_lock && blk_rq_is_seq_zoned_write(rq))
+		cmd->allowed += rq->q->nr_requests;
 	cmd->sdb.length = nr_blocks * sdp->sector_size;
 
 	SCSI_LOG_HLQUEUE(1,
diff --git a/include/scsi/scsi.h b/include/scsi/scsi.h
index 4498f845b112..5eb8b6e3f85a 100644
--- a/include/scsi/scsi.h
+++ b/include/scsi/scsi.h
@@ -93,6 +93,7 @@ static inline int scsi_status_is_check_condition(int status)
  * Internal return values.
  */
 enum scsi_disposition {
+	NEEDS_DELAYED_RETRY	= 0x2000,
 	NEEDS_RETRY		= 0x2001,
 	SUCCESS			= 0x2002,
 	FAILED			= 0x2003,

