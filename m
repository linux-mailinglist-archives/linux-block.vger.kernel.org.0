Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B20E8169CF6
	for <lists+linux-block@lfdr.de>; Mon, 24 Feb 2020 05:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgBXE2s (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 23 Feb 2020 23:28:48 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10676 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727189AbgBXE2s (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Feb 2020 23:28:48 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4B66135868A9B0D695E2;
        Mon, 24 Feb 2020 12:28:45 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 24 Feb 2020
 12:28:34 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <linux-block@vger.kernel.org>, <osandov@fb.com>
CC:     <sunke32@huawei.com>
Subject: [PATCH blktests] nbd/003: improve the test
Date:   Mon, 24 Feb 2020 12:27:28 +0800
Message-ID: <20200224042728.31886-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Modify the DESCRIPTION, remove the umount and add rm.

Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 tests/nbd/003 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nbd/003 b/tests/nbd/003
index 57fb63a..49ca30e 100644
--- a/tests/nbd/003
+++ b/tests/nbd/003
@@ -7,7 +7,7 @@
 
 . tests/nbd/rc
 
-DESCRIPTION="mount/unmount concurrently with NBD_CLEAR_SOCK"
+DESCRIPTION="connected by ioctl, mount/unmount concurrently with NBD_CLEAR_SOCK"
 QUICK=1
 
 requires() {
@@ -23,8 +23,8 @@ test() {
 
 	mkdir -p "${TMPDIR}/mnt"
 	src/mount_clear_sock /dev/nbd0 "${TMPDIR}/mnt" ext4 5000
-	umount "${TMPDIR}/mnt" > /dev/null 2>&1
 
 	nbd-client -d /dev/nbd0 >> "$FULL" 2>&1
+	rm -rf "${TMPDIR}/mnt"
 	_stop_nbd_server
 }
-- 
2.13.6

