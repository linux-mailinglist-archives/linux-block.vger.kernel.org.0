Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAE753C3E3
	for <lists+linux-block@lfdr.de>; Fri,  3 Jun 2022 06:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239140AbiFCE4a (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 3 Jun 2022 00:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiFCE43 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 00:56:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9646836E10
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 21:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=G7ujCyVKhyPvJA4wlrg6HvpaYnbtQW+4ddquSb/OwFo=; b=c49+D/B4dN8Nq+IAUTczruaXtG
        1jtli1V9P943T+WAcZ6xWRwxot4ymM4PtkZVLJNw7Ixb+shMpT4H7+J6wAdJ0SeRmw43CDld+b5Ar
        wRpvV0I/8hXE3aLYkx7BFbsnjgy5EIM+sxuFNZC+sAoZCAehUbhoDLf+BeVwoZuByvi+kQT3ksxZO
        K9jEmR7hPkU3URfmFuThmVEDRol52NP1/WqDXGuHoZtjFpn/oBuv5DGk6fth9QSlJoC+PzzpZ0X5+
        f9d44Qu6kqfu/JglG+OKkaBkuEWvbZSS9+omtOaUGSsrTUkRtRoc1C9gEQ8fkSRpAjiHmR7vrK8hh
        Cre2SUVg==;
Received: from [2001:4bb8:185:a81e:9865:e17e:4c0c:3e17] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwzMJ-005qSE-S9; Fri, 03 Jun 2022 04:56:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 11/13] block/023: convert to use _configure_null_blk
Date:   Fri,  3 Jun 2022 06:55:56 +0200
Message-Id: <20220603045558.466760-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603045558.466760-1-hch@lst.de>
References: <20220603045558.466760-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Switch to use _configure_null_blk so that built-in null_blk can be
supported, which implies not using the default nullb0 device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/block/023 | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/block/023 b/tests/block/023
index 0f20f4a..b82f217 100755
--- a/tests/block/023
+++ b/tests/block/023
@@ -21,10 +21,11 @@ test() {
 
 	local queue_mode
 	for queue_mode in 0 2; do
-		if _init_null_blk gb=1 queue_mode="$queue_mode"; then
+		if _configure_null_blk nullb1 size=1048576 \
+				queue_mode="$queue_mode" power=1; then
 			echo "Queue mode $queue_mode"
-			dd if=/dev/nullb0 of=/dev/null iflag=direct bs=64k status=none
-			dd if=/dev/null of=/dev/nullb0 oflag=direct bs=64k status=none
+			dd if=/dev/nullb1 of=/dev/null iflag=direct bs=64k status=none
+			dd if=/dev/null of=/dev/nullb1 oflag=direct bs=64k status=none
 			_exit_null_blk
 		fi
 	done
-- 
2.30.2

