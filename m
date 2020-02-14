Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4DDD15F2E9
	for <lists+linux-block@lfdr.de>; Fri, 14 Feb 2020 19:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbgBNPvh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 14 Feb 2020 10:51:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730388AbgBNPvg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Feb 2020 10:51:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6675124676;
        Fri, 14 Feb 2020 15:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695496;
        bh=SW0AGWU43L1UZ/wqfndLFzbkWOYuZ1G2GYhqzyIz6A0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y4A/imC88DFEaP+elpPnKpPLn5s9EeEAeEuufV6EeF2HdUebfyOsxU0XFGhRjIJq+
         S4XQC/gT37cEBuL6bETcU7SLKGb6WBNxHwcAHtRnoE17X4Cdsxbg9pxSfgpwlmsbh4
         DQALTEVVCauGO6C4/W026/ZwHg9jpvVDs28cm+w8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 124/542] drivers/block/zram/zram_drv.c: fix error return codes not being returned in writeback_store
Date:   Fri, 14 Feb 2020 10:41:56 -0500
Message-Id: <20200214154854.6746-124-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 3b82a051c10143639a378dcd12019f2353cc9054 ]

Currently when an error code -EIO or -ENOSPC in the for-loop of
writeback_store the error code is being overwritten by a ret = len
assignment at the end of the function and the error codes are being
lost.  Fix this by assigning ret = len at the start of the function and
remove the assignment from the end, hence allowing ret to be preserved
when error codes are assigned to it.

Addresses Coverity ("Unused value")

Link: http://lkml.kernel.org/r/20191128122958.178290-1-colin.king@canonical.com
Fixes: a939888ec38b ("zram: support idle/huge page writeback")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 4285e75e52c34..1bf4a908a0bd9 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -626,7 +626,7 @@ static ssize_t writeback_store(struct device *dev,
 	struct bio bio;
 	struct bio_vec bio_vec;
 	struct page *page;
-	ssize_t ret;
+	ssize_t ret = len;
 	int mode;
 	unsigned long blk_idx = 0;
 
@@ -762,7 +762,6 @@ static ssize_t writeback_store(struct device *dev,
 
 	if (blk_idx)
 		free_block_bdev(zram, blk_idx);
-	ret = len;
 	__free_page(page);
 release_init_lock:
 	up_read(&zram->init_lock);
-- 
2.20.1

