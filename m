Return-Path: <linux-block+bounces-2618-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 479C3842F05
	for <lists+linux-block@lfdr.de>; Tue, 30 Jan 2024 22:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50AB31C20C97
	for <lists+linux-block@lfdr.de>; Tue, 30 Jan 2024 21:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1167D7B3F4;
	Tue, 30 Jan 2024 21:49:56 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668CC78664;
	Tue, 30 Jan 2024 21:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651396; cv=none; b=LXOzYV+469a41hqdkSifDAujjeWO6mLbeBIo70lxYWZ//NzfDCw5SjVHIHHEuFP9MXRM6eVWeuSw4zv/dO67xZ46jsf14E9den+XkQ/JC3m5YUvT0nZOQL6LA0JGk4oK+X0OHsy1e2OM0m1QtBp02siWoXR7aEhto7aM6D7+97o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651396; c=relaxed/simple;
	bh=DGN3Zi9M92lvWrSc8IC/h6v3WnDaS+4QhlcwqZUhpvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEod4ogpJ8A3CawBtE3gZNpuy+jjCe8ieZdc4rAdzJFtdY1X4XFEi2PkRwCX89I2IOMJ26074ivi/lP9C3dNlLkC/ck8m3oCQwe6fongVtTvpJrk+0fnuDas8vzmKJlJLHVIZsODUs4erhPs+JpOrUbc8DX/Ix3Y/KdEkfe7mX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d8b276979aso2118612a12.2;
        Tue, 30 Jan 2024 13:49:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651394; x=1707256194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRTNclYtPkcsvXEXiBgDCJwPGtdfO/dHMSrVBF5CNYo=;
        b=dUnmPZ/ZpBanPQe1uP7/DrskRSi0sF/wYDoc4jjAtWbpdJK/H9WNqm6qM7xiIQPHEE
         S65nfu9PqcogUCN6MlrD2fid2+TT3JUAOn54Vior+SNoseuccta4eBWOkkNWR95vyEr3
         GDZhZzb6c20GDSS4CnluKc/5KKJYSoCcs5cUCGVyJOCm/Gs43Yvh6nvCiVtTdbI5Q58h
         L5CZwaoA3ng+yEGHMdXj8izO7Hxt02iXIM5eDWe5OUrkafypXgagO8/BfRGZR8AewmbG
         DV/1ajYePj3C3tJUGAQKQq1g1eBj2I208mKMr6ZIKgn35pPDRhOD4O19SWeFtpARCQuU
         drmg==
X-Gm-Message-State: AOJu0YxnG4VoI15Gv0kCdunioslKC35qSuDxMx13PPrVzCATiHidDmVX
	Cba3uvQJA83B6FOK0/eHoYoWYQqplhSrSCI6MauD+hD9F7PVcuBT
X-Google-Smtp-Source: AGHT+IFo6sZkKfGRWl/aPYun/3JlbvdTaF7rm6cFAVidrYg/SqaRT7frYIj4DBeWpLQjyrg323lymA==
X-Received: by 2002:a05:6a20:1988:b0:19e:3172:b8ac with SMTP id bz8-20020a056a20198800b0019e3172b8acmr550787pzb.22.1706651393735;
        Tue, 30 Jan 2024 13:49:53 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:f45c:fd18:bfa0:e084])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7998e000000b006db87354a8fsm8285597pfh.119.2024.01.30.13.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:49:53 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v9 11/19] scsi: sd: Translate data lifetime information
Date: Tue, 30 Jan 2024 13:48:37 -0800
Message-ID: <20240130214911.1863909-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240130214911.1863909-1-bvanassche@acm.org>
References: <20240130214911.1863909-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently T10 standardized SBC constrained streams. This mechanism allows
to pass data lifetime information to SCSI devices in the group number
field. Add support for translating write hint information into a
permanent stream number in the sd driver. Use WRITE(10) instead of
WRITE(6) if data lifetime information is present because the WRITE(6)
command does not have a GROUP NUMBER field.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/sd.c | 98 +++++++++++++++++++++++++++++++++++++++++++++--
 drivers/scsi/sd.h |  4 +-
 2 files changed, 98 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 463b201a3109..997de4daa8c4 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -47,6 +47,7 @@
 #include <linux/blkpg.h>
 #include <linux/blk-pm.h>
 #include <linux/delay.h>
+#include <linux/rw_hint.h>
 #include <linux/major.h>
 #include <linux/mutex.h>
 #include <linux/string_helpers.h>
@@ -1080,12 +1081,38 @@ static blk_status_t sd_setup_flush_cmnd(struct scsi_cmnd *cmd)
 	return BLK_STS_OK;
 }
 
+/**
+ * sd_group_number() - Compute the GROUP NUMBER field
+ * @cmd: SCSI command for which to compute the value of the six-bit GROUP NUMBER
+ *	field.
+ *
+ * From SBC-5 r05 (https://www.t10.org/cgi-bin/ac.pl?t=f&f=sbc5r05.pdf):
+ * 0: no relative lifetime.
+ * 1: shortest relative lifetime.
+ * 2: second shortest relative lifetime.
+ * 3 - 0x3d: intermediate relative lifetimes.
+ * 0x3e: second longest relative lifetime.
+ * 0x3f: longest relative lifetime.
+ */
+static u8 sd_group_number(struct scsi_cmnd *cmd)
+{
+	const struct request *rq = scsi_cmd_to_rq(cmd);
+	struct scsi_disk *sdkp = scsi_disk(rq->q->disk);
+
+	if (!sdkp->rscs)
+		return 0;
+
+	return min3((u32)rq->write_hint, (u32)sdkp->permanent_stream_count,
+		    0x3fu);
+}
+
 static blk_status_t sd_setup_rw32_cmnd(struct scsi_cmnd *cmd, bool write,
 				       sector_t lba, unsigned int nr_blocks,
 				       unsigned char flags, unsigned int dld)
 {
 	cmd->cmd_len = SD_EXT_CDB_SIZE;
 	cmd->cmnd[0]  = VARIABLE_LENGTH_CMD;
+	cmd->cmnd[6]  = sd_group_number(cmd);
 	cmd->cmnd[7]  = 0x18; /* Additional CDB len */
 	cmd->cmnd[9]  = write ? WRITE_32 : READ_32;
 	cmd->cmnd[10] = flags;
@@ -1104,7 +1131,7 @@ static blk_status_t sd_setup_rw16_cmnd(struct scsi_cmnd *cmd, bool write,
 	cmd->cmd_len  = 16;
 	cmd->cmnd[0]  = write ? WRITE_16 : READ_16;
 	cmd->cmnd[1]  = flags | ((dld >> 2) & 0x01);
-	cmd->cmnd[14] = (dld & 0x03) << 6;
+	cmd->cmnd[14] = ((dld & 0x03) << 6) | sd_group_number(cmd);
 	cmd->cmnd[15] = 0;
 	put_unaligned_be64(lba, &cmd->cmnd[2]);
 	put_unaligned_be32(nr_blocks, &cmd->cmnd[10]);
@@ -1119,7 +1146,7 @@ static blk_status_t sd_setup_rw10_cmnd(struct scsi_cmnd *cmd, bool write,
 	cmd->cmd_len = 10;
 	cmd->cmnd[0] = write ? WRITE_10 : READ_10;
 	cmd->cmnd[1] = flags;
-	cmd->cmnd[6] = 0;
+	cmd->cmnd[6] = sd_group_number(cmd);
 	cmd->cmnd[9] = 0;
 	put_unaligned_be32(lba, &cmd->cmnd[2]);
 	put_unaligned_be16(nr_blocks, &cmd->cmnd[7]);
@@ -1256,7 +1283,7 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 		ret = sd_setup_rw16_cmnd(cmd, write, lba, nr_blocks,
 					 protect | fua, dld);
 	} else if ((nr_blocks > 0xff) || (lba > 0x1fffff) ||
-		   sdp->use_10_for_rw || protect) {
+		   sdp->use_10_for_rw || protect || rq->write_hint) {
 		ret = sd_setup_rw10_cmnd(cmd, write, lba, nr_blocks,
 					 protect | fua);
 	} else {
@@ -3059,6 +3086,70 @@ sd_read_cache_type(struct scsi_disk *sdkp, unsigned char *buffer)
 	sdkp->DPOFUA = 0;
 }
 
+static bool sd_is_perm_stream(struct scsi_disk *sdkp, unsigned int stream_id)
+{
+	u8 cdb[16] = { SERVICE_ACTION_IN_16, SAI_GET_STREAM_STATUS };
+	struct {
+		struct scsi_stream_status_header h;
+		struct scsi_stream_status s;
+	} buf;
+	struct scsi_device *sdev = sdkp->device;
+	struct scsi_sense_hdr sshdr;
+	const struct scsi_exec_args exec_args = {
+		.sshdr = &sshdr,
+	};
+	int res;
+
+	put_unaligned_be16(stream_id, &cdb[4]);
+	put_unaligned_be32(sizeof(buf), &cdb[10]);
+
+	res = scsi_execute_cmd(sdev, cdb, REQ_OP_DRV_IN, &buf, sizeof(buf),
+			       SD_TIMEOUT, sdkp->max_retries, &exec_args);
+	if (res < 0)
+		return false;
+	if (scsi_status_is_check_condition(res) && scsi_sense_valid(&sshdr))
+		sd_print_sense_hdr(sdkp, &sshdr);
+	if (res)
+		return false;
+	if (get_unaligned_be32(&buf.h.len) < sizeof(struct scsi_stream_status))
+		return false;
+	return buf.h.stream_status[0].perm;
+}
+
+static void sd_read_io_hints(struct scsi_disk *sdkp, unsigned char *buffer)
+{
+	struct scsi_device *sdp = sdkp->device;
+	const struct scsi_io_group_descriptor *desc, *start, *end;
+	struct scsi_sense_hdr sshdr;
+	struct scsi_mode_data data;
+	int res;
+
+	res = scsi_mode_sense(sdp, /*dbd=*/0x8, /*modepage=*/0x0a,
+			      /*subpage=*/0x05, buffer, SD_BUF_SIZE, SD_TIMEOUT,
+			      sdkp->max_retries, &data, &sshdr);
+	if (res < 0)
+		return;
+	start = (void *)buffer + data.header_length + 16;
+	end = (void *)buffer + ALIGN_DOWN(data.header_length + data.length,
+					  sizeof(*end));
+	/*
+	 * From "SBC-5 Constrained Streams with Data Lifetimes": Device severs
+	 * should assign the lowest numbered stream identifiers to permanent
+	 * streams.
+	 */
+	for (desc = start; desc < end; desc++)
+		if (!desc->st_enble || !sd_is_perm_stream(sdkp, desc - start))
+			break;
+	sdkp->permanent_stream_count = desc - start;
+	if (sdkp->rscs && sdkp->permanent_stream_count < 2)
+		sd_printk(KERN_INFO, sdkp,
+			  "Unexpected: RSCS has been set and the permanent stream count is %u\n",
+			  sdkp->permanent_stream_count);
+	else if (sdkp->permanent_stream_count)
+		sd_printk(KERN_INFO, sdkp, "permanent stream count = %d\n",
+			  sdkp->permanent_stream_count);
+}
+
 /*
  * The ATO bit indicates whether the DIF application tag is available
  * for use by the operating system.
@@ -3539,6 +3630,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 
 		sd_read_write_protect_flag(sdkp, buffer);
 		sd_read_cache_type(sdkp, buffer);
+		sd_read_io_hints(sdkp, buffer);
 		sd_read_app_tag_own(sdkp, buffer);
 		sd_read_write_same(sdkp, buffer);
 		sd_read_security(sdkp, buffer);
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index e4539122f2a2..5c4285a582b2 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -125,6 +125,8 @@ struct scsi_disk {
 	unsigned int	physical_block_size;
 	unsigned int	max_medium_access_timeouts;
 	unsigned int	medium_access_timed_out;
+			/* number of permanent streams */
+	u16		permanent_stream_count;
 	u8		media_present;
 	u8		write_prot;
 	u8		protection_type;/* Data Integrity Field */
@@ -151,7 +153,7 @@ struct scsi_disk {
 	unsigned	urswrz : 1;
 	unsigned	security : 1;
 	unsigned	ignore_medium_access_errors : 1;
-	bool		rscs : 1; /* reduced stream control support */
+	unsigned	rscs : 1; /* reduced stream control support */
 };
 #define to_scsi_disk(obj) container_of(obj, struct scsi_disk, disk_dev)
 

