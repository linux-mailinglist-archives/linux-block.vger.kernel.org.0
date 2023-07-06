Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E06749D17
	for <lists+linux-block@lfdr.de>; Thu,  6 Jul 2023 15:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjGFNJl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 6 Jul 2023 09:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjGFNJj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jul 2023 09:09:39 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25551BEB
        for <linux-block@vger.kernel.org>; Thu,  6 Jul 2023 06:09:33 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbc0609cd6so6814085e9.1
        for <linux-block@vger.kernel.org>; Thu, 06 Jul 2023 06:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688648972; x=1691240972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EOry6f369fvQkUnyMG3t5Th65xx1GNMnGXjzZ7Sktk=;
        b=dfywl8JPlp9ZCl8GxiDO4TDStloyouxD0OECa20lsBhiqESxahTL1UltyGErsPsSrW
         BgA2s15zimiozXfVDDUZqaJLgrpqT4KL0n5hY8/eP/y/bn6y8DNmoD9e8WiO6iPeGevs
         twSLcPrQF6G5UmqTLVe3x88w3VKoNXzFJVCcgAlZ30R6J15qbgb6uyxh6cjpsuC0HiS3
         ZxxcYcf63FlnCp188xLXGfTmU+wZKbz91rLR0EODjORS85x/0yKTxQMQU6njBs7lavnm
         3EP869ulePPDC/NopKaXUrML9ziS0uQp9c63qdrc2rugGOSw2H1YZg1BRNCMqH8rcla/
         3fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688648972; x=1691240972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EOry6f369fvQkUnyMG3t5Th65xx1GNMnGXjzZ7Sktk=;
        b=ESAru7p7Jv2aooRC++f5SDO7JolzPlcyA0t7+XOXjpLPZvPtXcZPjFlw+xBN3TT7Qr
         Tnja/I8uRcJ8bNxbDjvhk5fMtJ2s6TeV57D1OS3BTuMQFL8d9SdBVZPwgWdWnk1LsNuk
         tkExFG9kADqqsdneo+ZscnGlncnGV2o0ddOGw6xP9jnl4jQ9E6fym2HtobDy7Ol77Iq1
         EKdC8fAJKdX12ggORX6750CgAoUEKureHlYkLgzlpS5P0WtGVYPmTKIGP3C0t609haba
         NLrERRxJd/dLbOC4tabIreJGddqdsjkQ7cZy6leFnLq8FFGSMRPjhLOzXGK+8iOjGjSA
         1w0g==
X-Gm-Message-State: ABy/qLZHvQ0wR/REi3uLQBccpQkgrz34KvP1QhbLLYeTayg5odcMg+TX
        CS2vX2C//1Xe/Z5TrufRUmrPkQ==
X-Google-Smtp-Source: APBJJlF28sEGzv3qCuU6Oj80fuFn9epz7A2lwvCAcKMBkp9tmHBgQntxQ/V6rj02mg3WOK89sFEyoQ==
X-Received: by 2002:a1c:4b18:0:b0:3fb:ab76:164b with SMTP id y24-20020a1c4b18000000b003fbab76164bmr1292940wma.13.1688648972313;
        Thu, 06 Jul 2023 06:09:32 -0700 (PDT)
Received: from localhost ([147.161.155.79])
        by smtp.gmail.com with ESMTPSA id y4-20020a1c4b04000000b003fa999cefc0sm2062661wma.36.2023.07.06.06.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:09:32 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org (open list),
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        Andreas Hindborg <a.hindborg@samsung.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        gost.dev@samsung.com, Jens Axboe <axboe@kernel.dk>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH v6 1/3] ublk: add opcode offsets for DRV_IN/DRV_OUT
Date:   Thu,  6 Jul 2023 15:09:28 +0200
Message-ID: <20230706130930.64283-2-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706130930.64283-1-nmi@metaspace.dk>
References: <20230706130930.64283-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

Ublk zoned storage support relies on DRV_IN handling for zone report.
Prepare for this change by adding offsets for the DRV_IN/DRV_OUT commands.

Also add parenthesis to existing opcodes for better macro hygiene.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 include/uapi/linux/ublk_cmd.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 4b8558db90e1..2ebb8d5d827a 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -229,12 +229,22 @@ struct ublksrv_ctrl_dev_info {
 	__u64   reserved2;
 };
 
-#define		UBLK_IO_OP_READ		0
+#define		UBLK_IO_OP_READ			0
 #define		UBLK_IO_OP_WRITE		1
 #define		UBLK_IO_OP_FLUSH		2
-#define		UBLK_IO_OP_DISCARD	3
-#define		UBLK_IO_OP_WRITE_SAME	4
-#define		UBLK_IO_OP_WRITE_ZEROES	5
+#define		UBLK_IO_OP_DISCARD		3
+#define		UBLK_IO_OP_WRITE_SAME		4
+#define		UBLK_IO_OP_WRITE_ZEROES		5
+/*
+ * Passthrough (driver private) operation codes range between
+ * __UBLK_IO_OP_DRV_IN_START and __UBLK_IO_OP_DRV_IN_END for REQ_OP_DRV_IN type
+ * operations and between __UBLK_IO_OP_DRV_OUT_START and
+ * __UBLK_IO_OP_DRV_OUT_END for REQ_OP_DRV_OUT type operations.
+ */
+#define		__UBLK_IO_OP_DRV_IN_START	32
+#define		__UBLK_IO_OP_DRV_IN_END		96
+#define		__UBLK_IO_OP_DRV_OUT_START	__UBLK_IO_OP_DRV_IN_END
+#define		__UBLK_IO_OP_DRV_OUT_END	160
 
 #define		UBLK_IO_F_FAILFAST_DEV		(1U << 8)
 #define		UBLK_IO_F_FAILFAST_TRANSPORT	(1U << 9)
-- 
2.41.0

