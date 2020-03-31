Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1B11199281
	for <lists+linux-block@lfdr.de>; Tue, 31 Mar 2020 11:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbgCaJmB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 31 Mar 2020 05:42:01 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34117 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730527AbgCaJmA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 05:42:00 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02V9f6U4024523;
        Tue, 31 Mar 2020 11:41:06 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 16/23] floppy: cleanup: make perpendicular_mode() not rely on current_fdc anymore
Date:   Tue, 31 Mar 2020 11:40:47 +0200
Message-Id: <20200331094054.24441-17-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200331094054.24441-1-w@1wt.eu>
References: <20200331094054.24441-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now the fdc is passed in argument so that the function does not
use current_fdc anymore.

It's worth noting that there's still a single raw_cmd pointer
specific to the current fdc. It may make sense to have one per
fdc in the future. In addition, cont->done() still relies on the
current drive and current raw_cmd.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/block/floppy.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index aa2d840bf06b..fcccbb4c143e 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -1200,7 +1200,7 @@ static int need_more_output(int fdc)
 /* Set perpendicular mode as required, based on data rate, if supported.
  * 82077 Now tested. 1Mbps data rate only possible with 82077-1.
  */
-static void perpendicular_mode(void)
+static void perpendicular_mode(int fdc)
 {
 	unsigned char perp_mode;
 
@@ -1215,7 +1215,7 @@ static void perpendicular_mode(void)
 		default:
 			DPRINT("Invalid data rate for perpendicular mode!\n");
 			cont->done(0);
-			fdc_state[current_fdc].reset = 1;
+			fdc_state[fdc].reset = 1;
 					/*
 					 * convenient way to return to
 					 * redo without too much hassle
@@ -1226,12 +1226,12 @@ static void perpendicular_mode(void)
 	} else
 		perp_mode = 0;
 
-	if (fdc_state[current_fdc].perp_mode == perp_mode)
+	if (fdc_state[fdc].perp_mode == perp_mode)
 		return;
-	if (fdc_state[current_fdc].version >= FDC_82077_ORIG) {
-		output_byte(current_fdc, FD_PERPENDICULAR);
-		output_byte(current_fdc, perp_mode);
-		fdc_state[current_fdc].perp_mode = perp_mode;
+	if (fdc_state[fdc].version >= FDC_82077_ORIG) {
+		output_byte(fdc, FD_PERPENDICULAR);
+		output_byte(fdc, perp_mode);
+		fdc_state[fdc].perp_mode = perp_mode;
 	} else if (perp_mode) {
 		DPRINT("perpendicular mode not supported by this FDC.\n");
 	}
@@ -1946,7 +1946,7 @@ static void floppy_ready(void)
 #endif
 
 	if (raw_cmd->flags & (FD_RAW_NEED_SEEK | FD_RAW_NEED_DISK)) {
-		perpendicular_mode();
+		perpendicular_mode(current_fdc);
 		fdc_specify();	/* must be done here because of hut, hlt ... */
 		seek_floppy();
 	} else {
-- 
2.20.1

