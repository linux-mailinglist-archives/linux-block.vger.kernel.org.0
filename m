Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDD576A407
	for <lists+linux-block@lfdr.de>; Tue,  1 Aug 2023 00:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjGaWPb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 31 Jul 2023 18:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjGaWPa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Jul 2023 18:15:30 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE22173B
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 15:15:28 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1bb7b8390e8so30650065ad.2
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 15:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690841728; x=1691446528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dgVJwigdvLnC3PLQrDWBl0zwhzVQqSuEsytYp17x/Y=;
        b=exfpQyE5hJkTIvkUx7zYPuwdlcGHf6p6MqWvS28d4x7ws1Ea/Trq8dKBe6sKBts0je
         sLhnEfRf+DHNlysy3voSwHqTyWqeD7y8upBbcxWQjem1tfZ0yWx7PfSaWhDcgH5voyfM
         30EN0mB+fPBjAeuixG5gn4aG5uv2gp2BEMMPASTDnQIAZVX8mQLBe8gDuv3Gjy9FR2hM
         nf7IfaTn7N/3xplCqtloyp1srMCRsL7O64OyYTIFk0anXvhdUWxLCMYlxpoZISf6LDcx
         nZxwk1BdXMB50L6lvHZmLvBIkFSNFYL2TG3jWGJkaryFyli98Et/QTGUElr5PrFyMcpK
         sWIQ==
X-Gm-Message-State: ABy/qLbut1Rh2NWslprNSighvbOyu+xSjCYIu3Qm3TADavd7i3hyHAem
        o6Wqeml17I35P3LBYUPsKnk=
X-Google-Smtp-Source: APBJJlGBxLCFY+YJMJmRVWgC9LQDBcRP3r4IAHDd39rzHlEdGUNj6FBNToNd2nyTuSSKynGIsPwKfg==
X-Received: by 2002:a17:902:a601:b0:1b8:5b70:2988 with SMTP id u1-20020a170902a60100b001b85b702988mr8861832plq.30.1690841728086;
        Mon, 31 Jul 2023 15:15:28 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9346:70e3:158a:281c])
        by smtp.gmail.com with ESMTPSA id jn13-20020a170903050d00b001b895a18472sm9000888plb.117.2023.07.31.15.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 15:15:27 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Douglas Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v5 5/7] scsi: scsi_debug: Support injecting unaligned write errors
Date:   Mon, 31 Jul 2023 15:14:41 -0700
Message-ID: <20230731221458.437440-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
In-Reply-To: <20230731221458.437440-1-bvanassche@acm.org>
References: <20230731221458.437440-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Allow user space software, e.g. a blktests test, to inject unaligned
write errors.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 57c6242bfb26..051b0605f11f 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -181,6 +181,7 @@ static const char *sdebug_version_date = "20210520";
 #define SDEBUG_OPT_NO_CDB_NOISE		0x4000
 #define SDEBUG_OPT_HOST_BUSY		0x8000
 #define SDEBUG_OPT_CMD_ABORT		0x10000
+#define SDEBUG_OPT_UNALIGNED_WRITE	0x20000
 #define SDEBUG_OPT_ALL_NOISE (SDEBUG_OPT_NOISE | SDEBUG_OPT_Q_NOISE | \
 			      SDEBUG_OPT_RESET_NOISE)
 #define SDEBUG_OPT_ALL_INJECTING (SDEBUG_OPT_RECOVERED_ERR | \
@@ -188,7 +189,8 @@ static const char *sdebug_version_date = "20210520";
 				  SDEBUG_OPT_DIF_ERR | SDEBUG_OPT_DIX_ERR | \
 				  SDEBUG_OPT_SHORT_TRANSFER | \
 				  SDEBUG_OPT_HOST_BUSY | \
-				  SDEBUG_OPT_CMD_ABORT)
+				  SDEBUG_OPT_CMD_ABORT | \
+				  SDEBUG_OPT_UNALIGNED_WRITE)
 #define SDEBUG_OPT_RECOV_DIF_DIX (SDEBUG_OPT_RECOVERED_ERR | \
 				  SDEBUG_OPT_DIF_ERR | SDEBUG_OPT_DIX_ERR)
 
@@ -3587,6 +3589,14 @@ static int resp_write_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 	struct sdeb_store_info *sip = devip2sip(devip, true);
 	u8 *cmd = scp->cmnd;
 
+	if (unlikely(sdebug_opts & SDEBUG_OPT_UNALIGNED_WRITE &&
+		     atomic_read(&sdeb_inject_pending))) {
+		atomic_set(&sdeb_inject_pending, 0);
+		mk_sense_buffer(scp, ILLEGAL_REQUEST, LBA_OUT_OF_RANGE,
+				UNALIGNED_WRITE_ASCQ);
+		return check_condition_result;
+	}
+
 	switch (cmd[0]) {
 	case WRITE_16:
 		ei_lba = 0;
