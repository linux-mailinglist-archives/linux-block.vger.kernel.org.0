Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2CB8E364D
	for <lists+linux-block@lfdr.de>; Thu, 24 Oct 2019 17:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503001AbfJXPQr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 24 Oct 2019 11:16:47 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:60340 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502987AbfJXPQr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 11:16:47 -0400
Received: from ramsan ([84.195.182.253])
        by laurent.telenet-ops.be with bizsmtp
        id HTGl2100C5USYZQ01TGlib; Thu, 24 Oct 2019 17:16:45 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNeqz-0006xo-9u; Thu, 24 Oct 2019 17:16:45 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNeqz-0007ag-8I; Thu, 24 Oct 2019 17:16:45 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jens Axboe <axboe@kernel.dk>, Jiri Kosina <trivial@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] block: mtip32xx: Spelling s/configration/configuration/
Date:   Thu, 24 Oct 2019 17:16:41 +0200
Message-Id: <20191024151641.29135-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix misspelling of "configuration".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/block/mtip32xx/mtip32xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 964f78cfffa0a189..f6bafa9a68b9dfae 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -129,7 +129,7 @@ struct mtip_compat_ide_task_request_s {
 /*
  * This function check_for_surprise_removal is called
  * while card is removed from the system and it will
- * read the vendor id from the configration space
+ * read the vendor id from the configuration space
  *
  * @pdev Pointer to the pci_dev structure.
  *
-- 
2.17.1

