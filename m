Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC16A53FF58
	for <lists+linux-block@lfdr.de>; Tue,  7 Jun 2022 14:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244229AbiFGMsQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 7 Jun 2022 08:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244204AbiFGMsF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jun 2022 08:48:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E0A1A820
        for <linux-block@vger.kernel.org>; Tue,  7 Jun 2022 05:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MSo0KHkZgIYFHJZ42AzFvKbwN7oNudFzfkVTVPAxH7Q=; b=IVafBXRXad32GvYRhNDEl3clBO
        r5RARe45fNs/bhCHVct7ljYWX69eM8u9O31MoB73vDo+cU3vtI084wFNzPiACeNfv2DslRoooFOjP
        IOkO/dNeWLpTCe99Dcof6rxKrxwMmt4barnic6gSUKoBhX59Wi/pm7LAuTz+7Et06wKJNgVCaa2BO
        zhCe8g2MHisHuumCghabiShNDPprVUTWOEsH+JBNjxqhYilI2UyhlnuWFhrdJJO9Pb2y0xdvEXpex
        OvfvIsZQudzg7wM2JxdzXR5EOlliOMPOgaZlL8sVarg4EoXQo8fmF3KIF08HMfc3ccfkBIqy8rC3b
        4yDpyJpw==;
Received: from [2001:4bb8:190:726c:b34a:228:52ee:6d34] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyYcp-007Scu-Hf; Tue, 07 Jun 2022 12:48:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 06/13] block/016: convert to use _configure_null_blk
Date:   Tue,  7 Jun 2022 14:47:32 +0200
Message-Id: <20220607124739.1259977-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607124739.1259977-1-hch@lst.de>
References: <20220607124739.1259977-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Switch to use _configure_null_blk so that built-in null_blk can be
supported, which implies not using the default nullb0 device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/block/016 | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/block/016 b/tests/block/016
index 2b7a05f..775069c 100755
--- a/tests/block/016
+++ b/tests/block/016
@@ -20,21 +20,22 @@ requires() {
 test() {
 	echo "Running ${TEST_NAME}"
 
-	if ! _init_null_blk irqmode=2 completion_nsec=2000000000; then
+	if ! _configure_null_blk nullb1 irqmode=2 completion_nsec=2000000000 \
+			power=1; then
 		return 1
 	fi
 
 	# Start an I/O, which will take two seconds.
-	dd if=/dev/nullb0 of=/dev/null bs=512 iflag=direct count=1 status=none &
+	dd if=/dev/nullb1 of=/dev/null bs=512 iflag=direct count=1 status=none &
 	sleep 0.5
 
 	# This will freeze the queue, and since we have an I/O in flight, it
 	# will stay frozen until the I/O completes.
-	echo 64 > /sys/block/nullb0/queue/nr_requests &
+	echo 64 > /sys/block/nullb1/queue/nr_requests &
 	sleep 0.5
 
 	# Do an I/O, which will wait for the queue to unfreeze.
-	dd if=/dev/nullb0 of=/dev/null bs=512 iflag=direct count=1 status=none &
+	dd if=/dev/nullb1 of=/dev/null bs=512 iflag=direct count=1 status=none &
 	sleep 0.5
 
 	# While dd is blocked, send a signal which we know dd has a handler
-- 
2.30.2

