Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8DA72D07D
	for <lists+linux-block@lfdr.de>; Mon, 12 Jun 2023 22:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbjFLUdY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 12 Jun 2023 16:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbjFLUdX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 16:33:23 -0400
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F2C10F5
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 13:33:22 -0700 (PDT)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5445ef3ef1eso3349186a12.2
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 13:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686602001; x=1689194001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5x+hvU6mLO5SBhoAWule2OzZmYU1RVF158u1Z2pevWA=;
        b=OpVxNRt827PzzT6lWyRsqNnOzfKhRQgth1PrgQQVhsCPWsSatV4JWuRqp5Zlbl27Vc
         ArHACutME4tB1Ybfjhf9QGUqj0ve2dBgewXSwZs3oga3wmkao343YH0R9dVJ6DPK1UP4
         y1sHS9KZXE6xgM1Mm8eCDCZTw6w9Qe0sXjw/YkqqQUiou/V1JDgU1pokhjkedgZ4XRLM
         7kEb6zmqCerwrUKc+Hz5g+SX2B1sk4Honb9dnQAbRRmg4sl1JSUCcVsrkVa9PRt0Iw9i
         9vEFFmnxp6aKY7ZmA190n1x/UDpAnTxH7xN9W0ZlVpxm28sqNoOHxsFwNf+xsoae4G3R
         wcbg==
X-Gm-Message-State: AC+VfDyx0nRX4RtaHPe0yJsbD28y0EziySt/PqTrqIbtmLNDI9Tmv9Q4
        mCPBfeWp0r2RI48UmcVVte0ATfcuzdzTRQ==
X-Google-Smtp-Source: ACHHUZ5yKVE35qfo3jbunEfHX9ENPHVajo+aUhl/Ehz+Scb4cjhfTpljq90c55IwRq/x07wvTKq6EQ==
X-Received: by 2002:a17:90b:e12:b0:25b:f113:19b5 with SMTP id ge18-20020a17090b0e1200b0025bf11319b5mr2694829pjb.40.1686602001552;
        Mon, 12 Jun 2023 13:33:21 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id ji1-20020a170903324100b001b016313b1dsm3324767plb.86.2023.06.12.13.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 13:33:20 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sandeep Dhavale <dhavale@google.com>,
        Juan Yescas <jyescas@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v6 2/8] block: Prepare for supporting sub-page limits
Date:   Mon, 12 Jun 2023 13:33:08 -0700
Message-Id: <20230612203314.17820-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612203314.17820-1-bvanassche@acm.org>
References: <20230612203314.17820-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce variables that represent the lower configuration bounds. This
patch does not change any functionality.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Tested-by: Sandeep Dhavale <dhavale@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-settings.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 1d8d2ae7bdf4..95d6e836c4a7 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -123,10 +123,11 @@ EXPORT_SYMBOL(blk_queue_bounce_limit);
 void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_sectors)
 {
 	struct queue_limits *limits = &q->limits;
+	unsigned int min_max_hw_sectors = PAGE_SIZE >> SECTOR_SHIFT;
 	unsigned int max_sectors;
 
-	if ((max_hw_sectors << 9) < PAGE_SIZE) {
-		max_hw_sectors = 1 << (PAGE_SHIFT - 9);
+	if (max_hw_sectors < min_max_hw_sectors) {
+		max_hw_sectors = min_max_hw_sectors;
 		pr_info("%s: set to minimum %u\n", __func__, max_hw_sectors);
 	}
 
@@ -281,8 +282,10 @@ EXPORT_SYMBOL_GPL(blk_queue_max_discard_segments);
  **/
 void blk_queue_max_segment_size(struct request_queue *q, unsigned int max_size)
 {
-	if (max_size < PAGE_SIZE) {
-		max_size = PAGE_SIZE;
+	unsigned int min_max_segment_size = PAGE_SIZE;
+
+	if (max_size < min_max_segment_size) {
+		max_size = min_max_segment_size;
 		pr_info("%s: set to minimum %u\n", __func__, max_size);
 	}
 
