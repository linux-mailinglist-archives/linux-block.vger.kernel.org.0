Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 456F5ADD9F
	for <lists+linux-block@lfdr.de>; Mon,  9 Sep 2019 18:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfIIQ4m (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 9 Sep 2019 12:56:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbfIIQ4l (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Sep 2019 12:56:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA2224E908;
        Mon,  9 Sep 2019 16:56:41 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (dhcp-12-105.nay.redhat.com [10.66.12.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B19E05D9D6;
        Mon,  9 Sep 2019 16:56:40 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@osandov.com
Subject: [PATCH blktests] block/027: remove duplicate --group_reporting=1
Date:   Tue, 10 Sep 2019 00:55:06 +0800
Message-Id: <20190909165506.14716-1-yi.zhang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 09 Sep 2019 16:56:41 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/block/027 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/block/027 b/tests/block/027
index 0ff9e4c..e818bf7 100755
--- a/tests/block/027
+++ b/tests/block/027
@@ -56,7 +56,7 @@ scsi_debug_stress_remove() {
 	local num_jobs=4 runtime=12
 	fio --rw=randread --size=128G --direct=1 --ioengine=libaio \
 		--iodepth=2048 --numjobs=$num_jobs --bs=4k \
-		--group_reporting=1 --group_reporting=1 --runtime=$runtime \
+		--group_reporting=1 --runtime=$runtime \
 		--loops=10000 --cgroup="blktests/${TEST_NAME}" \
 		"${fio_jobs[@]}" > "$FULL" 2>&1 &
 
-- 
2.17.2

