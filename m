Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039EE560D77
	for <lists+linux-block@lfdr.de>; Thu, 30 Jun 2022 01:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiF2XdI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 Jun 2022 19:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbiF2XdF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:33:05 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336279FF3
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:58 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id i64so16486443pfc.8
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E+7fz1kpwun+FM+ENLhLC8EM6umBuEasV+oUHoRPE00=;
        b=XOrPQrD0jvtTSzabN2YMCASZlZQ4j7mTqbL1dl4yO3hqgVq+9M+xQloT3fQOBM3KRm
         o7XeMxkxFN57uh/DOl0mh7sjdj4QinclgRonlGedLzn8Qx7lLlW8d2pCLGOgEqC+qPAm
         im1T46+bXSBRMZGO6VLONheRGKqFEXvnQwf8QjryxP81vZE6mMgjObc9uJTGHfbOo3jD
         KLlIAe0pPZU7XGR98Ia/iwaUnVDw4xaU+vbHn0dd90AblIGPfO2rNcgPlSL75JKb4uAg
         rQ9LgObkyU28aj7v5YTBLlfJCgGNlUYFpybUAtLk9HvwzeU1H42YV2pVOZBBukOQwFCf
         GN7A==
X-Gm-Message-State: AJIora9CEVcndpMiFVblkAsUq7/DtVPUcsMiUJnkay7A6abZ12sg9Jg+
        tni+miEr14vRDdNJumHAUKI=
X-Google-Smtp-Source: AGRyM1tjha+saKLZVEPXLsDV7H/+E25OEL5OlPTmMQhFpkK2XtbHWdXZSTHc3G7CG/t++9o5rsBtfQ==
X-Received: by 2002:a63:cd52:0:b0:3fe:30ec:825d with SMTP id a18-20020a63cd52000000b003fe30ec825dmr4885138pgj.82.1656545578086;
        Wed, 29 Jun 2022 16:32:58 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:57 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH v2 42/63] scsi/device_handlers: Use the new blk_opf_t type
Date:   Wed, 29 Jun 2022 16:31:24 -0700
Message-Id: <20220629233145.2779494-43-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for variables
that represent request flags.

Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/device_handler/scsi_dh_alua.c  | 4 ++--
 drivers/scsi/device_handler/scsi_dh_emc.c   | 2 +-
 drivers/scsi/device_handler/scsi_dh_hp_sw.c | 4 ++--
 drivers/scsi/device_handler/scsi_dh_rdac.c  | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
index 1d9be771f3ee..610a51538f03 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -127,7 +127,7 @@ static int submit_rtpg(struct scsi_device *sdev, unsigned char *buff,
 		       int bufflen, struct scsi_sense_hdr *sshdr, int flags)
 {
 	u8 cdb[MAX_COMMAND_SIZE];
-	int req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
+	blk_opf_t req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
 		REQ_FAILFAST_DRIVER;
 
 	/* Prepare the command. */
@@ -157,7 +157,7 @@ static int submit_stpg(struct scsi_device *sdev, int group_id,
 	u8 cdb[MAX_COMMAND_SIZE];
 	unsigned char stpg_data[8];
 	int stpg_len = 8;
-	int req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
+	blk_opf_t req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
 		REQ_FAILFAST_DRIVER;
 
 	/* Prepare the data buffer */
diff --git a/drivers/scsi/device_handler/scsi_dh_emc.c b/drivers/scsi/device_handler/scsi_dh_emc.c
index bd28ec6cfb72..2e21ab447873 100644
--- a/drivers/scsi/device_handler/scsi_dh_emc.c
+++ b/drivers/scsi/device_handler/scsi_dh_emc.c
@@ -239,7 +239,7 @@ static int send_trespass_cmd(struct scsi_device *sdev,
 	unsigned char cdb[MAX_COMMAND_SIZE];
 	int err, res = SCSI_DH_OK, len;
 	struct scsi_sense_hdr sshdr;
-	u64 req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
+	blk_opf_t req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
 		REQ_FAILFAST_DRIVER;
 
 	if (csdev->flags & CLARIION_SHORT_TRESPASS) {
diff --git a/drivers/scsi/device_handler/scsi_dh_hp_sw.c b/drivers/scsi/device_handler/scsi_dh_hp_sw.c
index 4a3f7831a2d6..0d2cfa60aa06 100644
--- a/drivers/scsi/device_handler/scsi_dh_hp_sw.c
+++ b/drivers/scsi/device_handler/scsi_dh_hp_sw.c
@@ -83,7 +83,7 @@ static int hp_sw_tur(struct scsi_device *sdev, struct hp_sw_dh_data *h)
 	unsigned char cmd[6] = { TEST_UNIT_READY };
 	struct scsi_sense_hdr sshdr;
 	int ret = SCSI_DH_OK, res;
-	u64 req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
+	blk_opf_t req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
 		REQ_FAILFAST_DRIVER;
 
 retry:
@@ -121,7 +121,7 @@ static int hp_sw_start_stop(struct hp_sw_dh_data *h)
 	struct scsi_device *sdev = h->sdev;
 	int res, rc = SCSI_DH_OK;
 	int retry_cnt = HP_SW_RETRIES;
-	u64 req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
+	blk_opf_t req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
 		REQ_FAILFAST_DRIVER;
 
 retry:
diff --git a/drivers/scsi/device_handler/scsi_dh_rdac.c b/drivers/scsi/device_handler/scsi_dh_rdac.c
index 66652ab409cc..bf8754741f85 100644
--- a/drivers/scsi/device_handler/scsi_dh_rdac.c
+++ b/drivers/scsi/device_handler/scsi_dh_rdac.c
@@ -536,7 +536,7 @@ static void send_mode_select(struct work_struct *work)
 	unsigned char cdb[MAX_COMMAND_SIZE];
 	struct scsi_sense_hdr sshdr;
 	unsigned int data_size;
-	u64 req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
+	blk_opf_t req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
 		REQ_FAILFAST_DRIVER;
 
 	spin_lock(&ctlr->ms_lock);
