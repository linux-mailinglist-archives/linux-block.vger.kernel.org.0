Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A9753C3D9
	for <lists+linux-block@lfdr.de>; Fri,  3 Jun 2022 06:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbiFCE4F (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 3 Jun 2022 00:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiFCE4E (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 00:56:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F1436E10
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 21:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5MUNTIHS7zg2+YSvCs7EnS39OLOi6aSeNGIMsOorwM4=; b=HcCrKgS5qSVSMKDiAK8BhU+EAS
        /qMprE7lKhHdVgF+zHp8cvXW6zIYnNehzMrocnmr3lf1aff06ueF7jL1SxCpcbkfjbCcDCGEnDFuh
        msKRBdch/Dd3JGAF3lqjBrQ+xN7myWll5lvEDhdaeOK014atIrNDaJlin9inV0nAFfXGjRtBMsatO
        tozJ6+SxzbSs5Nf8/VtlueJiNKXEPRuu5bgWwYZ9cWJ6rzVrjJomvD+yIxfgirvwJTz4nv7t/wgz+
        dEpPYu+eezwiOaPuOjvJfDOYjB7LVg/3E9P/qVBbib3wgHRayj7KwjtUacM0EFsPaRc9FuWi0dyD6
        dXmieCNg==;
Received: from [2001:4bb8:185:a81e:9865:e17e:4c0c:3e17] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwzLv-005qON-9R; Fri, 03 Jun 2022 04:56:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 01/13] common/null_blk: remove explicit queue_mode=2 parameters
Date:   Fri,  3 Jun 2022 06:55:46 +0200
Message-Id: <20220603045558.466760-2-hch@lst.de>
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

queue_mode 2 (aka blk-mq) is the default in null_blk, so remove the
extra explicitly parameter.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/block/006 | 2 +-
 tests/block/010 | 4 ++--
 tests/block/014 | 2 +-
 tests/block/015 | 2 +-
 tests/block/016 | 2 +-
 tests/block/017 | 3 +--
 tests/block/018 | 3 +--
 tests/block/020 | 2 +-
 tests/block/022 | 2 +-
 tests/block/024 | 3 +--
 tests/block/029 | 2 +-
 tests/block/030 | 2 +-
 tests/block/031 | 2 +-
 13 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/tests/block/006 b/tests/block/006
index 0b8a3c0..7ca1021 100755
--- a/tests/block/006
+++ b/tests/block/006
@@ -24,7 +24,7 @@ test() {
 	_divide_timeout 2
 	FIO_PERF_FIELDS=("read iops")
 
-	if ! _init_null_blk queue_mode=2 submit_queues=2 blocking=1; then
+	if ! _init_null_blk submit_queues=2 blocking=1; then
 		return 1
 	fi
 
diff --git a/tests/block/010 b/tests/block/010
index b81208e..ed56135 100644
--- a/tests/block/010
+++ b/tests/block/010
@@ -49,7 +49,7 @@ test() {
 
 	_divide_timeout 2
 
-	if ! _init_null_blk queue_mode=2 submit_queues=16 nr_devices=32; then
+	if ! _init_null_blk submit_queues=16 nr_devices=32; then
 		return 1
 	fi
 
@@ -58,7 +58,7 @@ test() {
 	run_fio_job
 
 	_exit_null_blk
-	if ! _init_null_blk queue_mode=2 submit_queues=16 nr_devices=32 shared_tags=1; then
+	if ! _init_null_blk submit_queues=16 nr_devices=32 shared_tags=1; then
 		return 1
 	fi
 
diff --git a/tests/block/014 b/tests/block/014
index 04c34fa..449046a 100755
--- a/tests/block/014
+++ b/tests/block/014
@@ -18,7 +18,7 @@ test() {
 
 	# The format is "<interval>,<probability>,<space>,<times>". Here, we
 	# fail 50% of I/Os.
-	if ! _init_null_blk queue_mode=2 timeout='1,50,0,-1'; then
+	if ! _init_null_blk timeout='1,50,0,-1'; then
 		return 1
 	fi
 
diff --git a/tests/block/015 b/tests/block/015
index 79102a2..2e5cf35 100755
--- a/tests/block/015
+++ b/tests/block/015
@@ -20,7 +20,7 @@ test() {
 
 	# The format is "<interval>,<probability>,<space>,<times>". Here, we
 	# requeue 10% of the time.
-	if ! _init_null_blk queue_mode=2 requeue='1,10,0,-1'; then
+	if ! _init_null_blk requeue='1,10,0,-1'; then
 		return 1
 	fi
 
diff --git a/tests/block/016 b/tests/block/016
index c70b7d0..2b7a05f 100755
--- a/tests/block/016
+++ b/tests/block/016
@@ -20,7 +20,7 @@ requires() {
 test() {
 	echo "Running ${TEST_NAME}"
 
-	if ! _init_null_blk queue_mode=2 irqmode=2 completion_nsec=2000000000; then
+	if ! _init_null_blk irqmode=2 completion_nsec=2000000000; then
 		return 1
 	fi
 
diff --git a/tests/block/017 b/tests/block/017
index e4a9259..c84b661 100755
--- a/tests/block/017
+++ b/tests/block/017
@@ -27,8 +27,7 @@ show_inflight() {
 test() {
 	echo "Running ${TEST_NAME}"
 
-	if ! _init_null_blk queue_mode=2 irqmode=2 \
-	     completion_nsec=500000000; then
+	if ! _init_null_blk irqmode=2 completion_nsec=500000000; then
 		return 1
 	fi
 
diff --git a/tests/block/018 b/tests/block/018
index 7312723..a80ecbc 100755
--- a/tests/block/018
+++ b/tests/block/018
@@ -33,8 +33,7 @@ test() {
 
 	echo "Running ${TEST_NAME}"
 
-	if ! _init_null_blk queue_mode=2 irqmode=2 \
-	     completion_nsec=1000000000; then
+	if ! _init_null_blk irqmode=2 completion_nsec=1000000000; then
 		return 1
 	fi
 
diff --git a/tests/block/020 b/tests/block/020
index b4887a2..eef63cb 100755
--- a/tests/block/020
+++ b/tests/block/020
@@ -20,7 +20,7 @@ requires() {
 test() {
 	echo "Running ${TEST_NAME}"
 
-	if ! _init_null_blk queue_mode=2 irqmode=2 completion_nsec=2000000 \
+	if ! _init_null_blk irqmode=2 completion_nsec=2000000 \
 	     submit_queues=4 hw_queue_depth=1; then
 		return 1
 	fi
diff --git a/tests/block/022 b/tests/block/022
index 30b2a68..10851ff 100755
--- a/tests/block/022
+++ b/tests/block/022
@@ -28,7 +28,7 @@ test() {
 	echo "Running ${TEST_NAME}"
 	: "${TIMEOUT:=30}"
 
-	if ! _init_null_blk shared_tags=1 nr_devices=0 queue_mode=2; then
+	if ! _init_null_blk shared_tags=1 nr_devices=0; then
 		return 1
 	fi
 
diff --git a/tests/block/024 b/tests/block/024
index b40a869..6808db0 100755
--- a/tests/block/024
+++ b/tests/block/024
@@ -37,8 +37,7 @@ test() {
 
 	# The maximum value for CONFIG_HZ is 1000. I.e., a tick is one
 	# millisecond. So, make each I/O take half a millisecond.
-	if ! _init_null_blk queue_mode=2 irqmode=2 \
-	     completion_nsec=500000; then
+	if ! _init_null_blk irqmode=2 completion_nsec=500000; then
 		return 1
 	fi
 
diff --git a/tests/block/029 b/tests/block/029
index 0c4fe08..dcf4024 100755
--- a/tests/block/029
+++ b/tests/block/029
@@ -31,7 +31,7 @@ test() {
 	local sq=/sys/kernel/config/nullb/nullb0/submit_queues
 
 	: "${TIMEOUT:=30}"
-	_init_null_blk nr_devices=0 queue_mode=2 &&
+	_init_null_blk nr_devices=0 &&
 	_configure_null_blk nullb0 completion_nsec=0 blocksize=512 \
 			    size=16 memory_backed=1 power=1 &&
 	if { echo 1 >$sq; } 2>/dev/null; then
diff --git a/tests/block/030 b/tests/block/030
index d2e5286..f08f772 100755
--- a/tests/block/030
+++ b/tests/block/030
@@ -22,7 +22,7 @@ test() {
 	: "${TIMEOUT:=30}"
 	# Legend: init_hctx=<interval>,<probability>,<space>,<times>
 	# Set <space> to $(nproc) + 1 to make loading of null_blk succeed.
-	if ! _init_null_blk nr_devices=0 queue_mode=2 \
+	if ! _init_null_blk nr_devices=0 \
 	     "init_hctx=$(nproc),100,$(($(nproc) + 1)),-1"; then
 		echo "Loading null_blk failed"
 		return 1
diff --git a/tests/block/031 b/tests/block/031
index cb4ba67..d253af8 100755
--- a/tests/block/031
+++ b/tests/block/031
@@ -18,7 +18,7 @@ test() {
 	local fio_status bs=512
 
 	: "${TIMEOUT:=30}"
-	if ! _init_null_blk nr_devices=0 queue_mode=2 shared_tag_bitmap=1; then
+	if ! _init_null_blk nr_devices=0 shared_tag_bitmap=1; then
 		echo "Loading null_blk failed"
 		return 1
 	fi
-- 
2.30.2

