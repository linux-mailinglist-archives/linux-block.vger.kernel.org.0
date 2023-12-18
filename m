Return-Path: <linux-block+bounces-1255-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AAD817A65
	for <lists+linux-block@lfdr.de>; Mon, 18 Dec 2023 19:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937A91F24F67
	for <lists+linux-block@lfdr.de>; Mon, 18 Dec 2023 18:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E007144F;
	Mon, 18 Dec 2023 18:58:05 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3245174E23;
	Mon, 18 Dec 2023 18:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c699b44dddso1133975a12.1;
        Mon, 18 Dec 2023 10:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702925883; x=1703530683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TB+ig0WMe6VgVRdj/Yzge+HqFjz0R9pg2KftpXjuBxI=;
        b=cJeMzVbh9nLSK8SX8g1qXMMpaT8uqO8Ooniuw29lY1z3n2NckS79bQ5UaGJCNWcxhj
         +PFXJRb/3Oqao7vBv+hPbiETOY1a+VJj0QpOjqKVyflj3VRMtKTuL/G7K5+/CjNUbArC
         EcHsNs2Dye7fEzxKV7tyZSRqhZmKlQyxrpTZzdalJmuVXhgZqlj2dCTu5Tc3XlQwgm3X
         zJrja9gTSGY2vH80WzLNmUNes4PtM0uUMP5ASu7CEsXcUp12XXsu+X62WViM/AI+/XK8
         qUhlbnAlDf8PgekWlBTT0AQVq5k/8HRvhC3/WAS7HCZWIdW4w1869o/Dri1vgAn15ted
         gGAg==
X-Gm-Message-State: AOJu0YwTDEl3pk71lIY2TKHxj2/sCBzNu7xihgDil+XRYj/F9jbp5Kzu
	GMN7bW3ySOI1c+Xx3p/OBdA=
X-Google-Smtp-Source: AGHT+IGC0uU03gGqvTWdn3MPUk9+SQmWbAyjx5EOVY9pu4HJJr1udnjIp3rLGPlbYqgblO+4+4V4ow==
X-Received: by 2002:a05:6a20:1586:b0:190:53c1:fed1 with SMTP id h6-20020a056a20158600b0019053c1fed1mr10053992pzj.40.1702925883426;
        Mon, 18 Dec 2023 10:58:03 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id n20-20020a056a0007d400b006d45707d8edsm3918397pfu.7.2023.12.18.10.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 10:58:02 -0800 (PST)
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
	Douglas Gilbert <dgilbert@interlog.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v7 18/19] scsi: scsi_debug: Implement GET STREAM STATUS
Date: Mon, 18 Dec 2023 10:56:41 -0800
Message-ID: <20231218185705.2002516-19-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231218185705.2002516-1-bvanassche@acm.org>
References: <20231218185705.2002516-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the GET STREAM STATUS SCSI command. Report that the first
five stream indexes correspond to permanent streams.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Tested-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 50 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 4e18265a05da..b2146f24f396 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -533,6 +533,8 @@ static int resp_write_scat(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_start_stop(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_readcap16(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_get_lba_status(struct scsi_cmnd *, struct sdebug_dev_info *);
+static int resp_get_stream_status(struct scsi_cmnd *scp,
+				  struct sdebug_dev_info *devip);
 static int resp_report_tgtpgs(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_unmap(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_rsup_opcodes(struct scsi_cmnd *, struct sdebug_dev_info *);
@@ -607,6 +609,9 @@ static const struct opcode_info_t sa_in_16_iarr[] = {
 	{0, 0x9e, 0x12, F_SA_LOW | F_D_IN, resp_get_lba_status, NULL,
 	    {16,  0x12, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 	     0xff, 0xff, 0xff, 0, 0xc7} },	/* GET LBA STATUS(16) */
+	{0, 0x9e, 0x16, F_SA_LOW | F_D_IN, resp_get_stream_status, NULL,
+	    {16, 0x16, 0, 0, 0xff, 0xff, 0, 0, 0, 0, 0xff, 0xff, 0xff, 0xff,
+	     0, 0} },	/* GET STREAM STATUS */
 };
 
 static const struct opcode_info_t vl_iarr[] = {	/* VARIABLE LENGTH */
@@ -4581,6 +4586,51 @@ static int resp_get_lba_status(struct scsi_cmnd *scp,
 	return fill_from_dev_buffer(scp, arr, SDEBUG_GET_LBA_STATUS_LEN);
 }
 
+static int resp_get_stream_status(struct scsi_cmnd *scp,
+				  struct sdebug_dev_info *devip)
+{
+	u16 starting_stream_id, stream_id;
+	const u8 *cmd = scp->cmnd;
+	u32 alloc_len, offset;
+	u8 arr[256] = {};
+	struct scsi_stream_status_header *h = (void *)arr;
+
+	starting_stream_id = get_unaligned_be16(cmd + 4);
+	alloc_len = get_unaligned_be32(cmd + 10);
+
+	if (alloc_len < 8) {
+		mk_sense_invalid_fld(scp, SDEB_IN_CDB, 10, -1);
+		return check_condition_result;
+	}
+
+	if (starting_stream_id >= MAXIMUM_NUMBER_OF_STREAMS) {
+		mk_sense_invalid_fld(scp, SDEB_IN_CDB, 4, -1);
+		return check_condition_result;
+	}
+
+	/*
+	 * The GET STREAM STATUS command only reports status information
+	 * about open streams. Treat the non-permanent stream as open.
+	 */
+	put_unaligned_be16(MAXIMUM_NUMBER_OF_STREAMS,
+			   &h->number_of_open_streams);
+
+	for (offset = 8, stream_id = starting_stream_id;
+	     offset + 8 <= min_t(u32, alloc_len, sizeof(arr)) &&
+		     stream_id < MAXIMUM_NUMBER_OF_STREAMS;
+	     offset += 8, stream_id++) {
+		struct scsi_stream_status *stream_status = (void *)arr + offset;
+
+		stream_status->perm = stream_id < PERMANENT_STREAM_COUNT;
+		put_unaligned_be16(stream_id,
+				   &stream_status->stream_identifier);
+		stream_status->rel_lifetime = stream_id + 1;
+	}
+	put_unaligned_be32(offset - 8, &h->len); /* PARAMETER DATA LENGTH */
+
+	return fill_from_dev_buffer(scp, arr, min(offset, alloc_len));
+}
+
 static int resp_sync_cache(struct scsi_cmnd *scp,
 			   struct sdebug_dev_info *devip)
 {

