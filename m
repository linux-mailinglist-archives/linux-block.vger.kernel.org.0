Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504A553FF5A
	for <lists+linux-block@lfdr.de>; Tue,  7 Jun 2022 14:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244193AbiFGMsS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 7 Jun 2022 08:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244190AbiFGMsG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jun 2022 08:48:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DAF19030
        for <linux-block@vger.kernel.org>; Tue,  7 Jun 2022 05:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2W4S3a1VuQDwEOsgchh+sd14l85+LMpS0eeU2cEnqkk=; b=Cx8cgw2sFOrmacgGhGPeFwEEpQ
        BMQ1cXi7EjkrB+Sv5t/TWk0QSAqWpgtHK2Q1tQGLaSiVZop8sp9lGaD8kAwWNUAwoqt1QJXhT4WzS
        x5EW6lYw8yXX6lr0GFQMnHg72NKMnIloTjwxlXaoibMBy4/LBvy7N/u1/aBQ72MIQjroUX0loGgx/
        s3chclR98h3cRU6VixpejVpiek5ZRCDleIPFQo4CiqAjdcXw686exMB60nBqrF/DYNk+fK/i+2K/r
        gbZknjqdmy752jfLFhfZlsAHDAWYtUYN2sqchQpqA14g7ra647v6yz3u7t4J3fT0m+DmHgzMyvHnC
        SkY3GDKg==;
Received: from [2001:4bb8:190:726c:b34a:228:52ee:6d34] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyYcv-007Sfq-2d; Tue, 07 Jun 2022 12:48:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 08/13] block/018: convert to use _configure_null_blk
Date:   Tue,  7 Jun 2022 14:47:34 +0200
Message-Id: <20220607124739.1259977-9-hch@lst.de>
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
 tests/block/018 | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tests/block/018 b/tests/block/018
index a80ecbc..e7ac445 100755
--- a/tests/block/018
+++ b/tests/block/018
@@ -15,13 +15,13 @@ requires() {
 }
 
 init_times() {
-	init_read_ms="$(awk '{ print $4 }' /sys/block/nullb0/stat)"
-	init_write_ms="$(awk '{ print $8 }' /sys/block/nullb0/stat)"
+	init_read_ms="$(awk '{ print $4 }' /sys/block/nullb1/stat)"
+	init_write_ms="$(awk '{ print $8 }' /sys/block/nullb1/stat)"
 }
 
 show_times() {
-	read_ms="$(awk '{ print $4 }' /sys/block/nullb0/stat)"
-	write_ms="$(awk '{ print $8 }' /sys/block/nullb0/stat)"
+	read_ms="$(awk '{ print $4 }' /sys/block/nullb1/stat)"
+	write_ms="$(awk '{ print $8 }' /sys/block/nullb1/stat)"
 
 	# Print rounded to the nearest second
 	printf 'read %d s\n' $(((read_ms - init_read_ms + 500) / 1000))
@@ -33,22 +33,23 @@ test() {
 
 	echo "Running ${TEST_NAME}"
 
-	if ! _init_null_blk irqmode=2 completion_nsec=1000000000; then
+	if ! _configure_null_blk nullb1 irqmode=2 completion_nsec=1000000000 \
+			power=1; then
 		return 1
 	fi
 
 	init_times
 	show_times
 
-	dd if=/dev/nullb0 of=/dev/null bs=4096 iflag=direct count=1 status=none
+	dd if=/dev/nullb1 of=/dev/null bs=4096 iflag=direct count=1 status=none
 	show_times
 
-	dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1 status=none
+	dd if=/dev/zero of=/dev/nullb1 bs=4096 oflag=direct count=1 status=none
 	show_times
 
-	dd if=/dev/nullb0 of=/dev/null bs=4096 iflag=direct count=1 status=none &
-	dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1 status=none &
-	dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1 status=none &
+	dd if=/dev/nullb1 of=/dev/null bs=4096 iflag=direct count=1 status=none &
+	dd if=/dev/zero of=/dev/nullb1 bs=4096 oflag=direct count=1 status=none &
+	dd if=/dev/zero of=/dev/nullb1 bs=4096 oflag=direct count=1 status=none &
 	wait
 	show_times
 
-- 
2.30.2

