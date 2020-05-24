Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13E21E006C
	for <lists+linux-block@lfdr.de>; Sun, 24 May 2020 18:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgEXQKp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 24 May 2020 12:10:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39352 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbgEXQKp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 May 2020 12:10:45 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jctD1-0007Av-Bf; Sun, 24 May 2020 16:10:43 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] loop: remove redundant assignment to variable error
Date:   Sun, 24 May 2020 17:10:43 +0100
Message-Id: <20200524161043.20292-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable error is being assigned a value that is never
read so the assignment is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/block/loop.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c20d01c08e5c..060da16b3743 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1136,8 +1136,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	if (error)
 		goto out_unlock;
 
-	error = 0;
-
 	set_device_ro(bdev, (lo->lo_flags & LO_FLAGS_READ_ONLY) != 0);
 
 	lo->use_dio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
-- 
2.25.1

