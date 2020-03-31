Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE796199293
	for <lists+linux-block@lfdr.de>; Tue, 31 Mar 2020 11:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbgCaJmr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 31 Mar 2020 05:42:47 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34167 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730273AbgCaJmr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 05:42:47 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02V9f56U024517;
        Tue, 31 Mar 2020 11:41:05 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 10/23] floppy: cleanup: make reset_fdc_info() not rely on current_fdc anymore
Date:   Tue, 31 Mar 2020 11:40:41 +0200
Message-Id: <20200331094054.24441-11-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200331094054.24441-1-w@1wt.eu>
References: <20200331094054.24441-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now the fdc is passed in argument so that the function does not
use current_fdc anymore.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/block/floppy.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index b1729daa2e2e..6c98f8d169a9 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -838,19 +838,19 @@ static void twaddle(int fdc, int drive)
 }
 
 /*
- * Reset all driver information about the current fdc.
+ * Reset all driver information about the specified fdc.
  * This is needed after a reset, and after a raw command.
  */
-static void reset_fdc_info(int mode)
+static void reset_fdc_info(int fdc, int mode)
 {
 	int drive;
 
-	fdc_state[current_fdc].spec1 = fdc_state[current_fdc].spec2 = -1;
-	fdc_state[current_fdc].need_configure = 1;
-	fdc_state[current_fdc].perp_mode = 1;
-	fdc_state[current_fdc].rawcmd = 0;
+	fdc_state[fdc].spec1 = fdc_state[fdc].spec2 = -1;
+	fdc_state[fdc].need_configure = 1;
+	fdc_state[fdc].perp_mode = 1;
+	fdc_state[fdc].rawcmd = 0;
 	for (drive = 0; drive < N_DRIVE; drive++)
-		if (FDC(drive) == current_fdc &&
+		if (FDC(drive) == fdc &&
 		    (mode || drive_state[drive].track != NEED_1_RECAL))
 			drive_state[drive].track = NEED_2_RECAL;
 }
@@ -874,7 +874,7 @@ static void set_fdc(int drive)
 	set_dor(1 - current_fdc, ~8, 0);
 #endif
 	if (fdc_state[current_fdc].rawcmd == 2)
-		reset_fdc_info(1);
+		reset_fdc_info(current_fdc, 1);
 	if (fdc_inb(current_fdc, FD_STATUS) != STATUS_READY)
 		fdc_state[current_fdc].reset = 1;
 }
@@ -1800,7 +1800,7 @@ static void reset_fdc(void)
 
 	do_floppy = reset_interrupt;
 	fdc_state[current_fdc].reset = 0;
-	reset_fdc_info(0);
+	reset_fdc_info(current_fdc, 0);
 
 	/* Pseudo-DMA may intercept 'reset finished' interrupt.  */
 	/* Irrelevant for systems with true DMA (i386).          */
@@ -4890,7 +4890,7 @@ static int floppy_grab_irq_and_dma(void)
 	}
 	for (current_fdc = 0; current_fdc < N_FDC; current_fdc++) {
 		if (fdc_state[current_fdc].address != -1) {
-			reset_fdc_info(1);
+			reset_fdc_info(current_fdc, 1);
 			fdc_outb(fdc_state[current_fdc].dor, current_fdc, FD_DOR);
 		}
 	}
-- 
2.20.1

