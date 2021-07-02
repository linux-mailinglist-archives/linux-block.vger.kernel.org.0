Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28463B9F86
	for <lists+linux-block@lfdr.de>; Fri,  2 Jul 2021 13:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhGBLOX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 2 Jul 2021 07:14:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58442 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbhGBLOX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Jul 2021 07:14:23 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lzH5J-0002z5-UC; Fri, 02 Jul 2021 11:11:50 +0000
From:   Colin King <colin.king@canonical.com>
To:     tim@cyberelk.net, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] paride: remove redudant space character check
Date:   Fri,  2 Jul 2021 12:11:49 +0100
Message-Id: <20210702111149.15517-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The check for variable l being a space character is always false, l can
never be a space character. The check is redundant and can be removed.

Addresses-Coverity: ("Logically dead code")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/block/paride/pg.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/paride/pg.c b/drivers/block/paride/pg.c
index 3b5882bfb736..2f7aa8521395 100644
--- a/drivers/block/paride/pg.c
+++ b/drivers/block/paride/pg.c
@@ -429,8 +429,6 @@ static void xs(char *buf, char *targ, int len)
 		if (c != ' ' && c != l)
 			l = *targ++ = c;
 	}
-	if (l == ' ')
-		targ--;
 	*targ = '\0';
 }
 
-- 
2.31.1

