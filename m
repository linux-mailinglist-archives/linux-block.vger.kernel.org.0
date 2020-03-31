Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7230E199278
	for <lists+linux-block@lfdr.de>; Tue, 31 Mar 2020 11:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbgCaJlq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 31 Mar 2020 05:41:46 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34098 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730375AbgCaJlp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 05:41:45 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02V9f6lI024522;
        Tue, 31 Mar 2020 11:41:06 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 15/23] floppy: cleanup: make need_more_output() not rely on current_fdc anymore
Date:   Tue, 31 Mar 2020 11:40:46 +0200
Message-Id: <20200331094054.24441-16-w@1wt.eu>
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
 drivers/block/floppy.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 4aaf84217b53..aa2d840bf06b 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -1184,9 +1184,9 @@ static int result(int fdc)
 
 #define MORE_OUTPUT -2
 /* does the fdc need more output? */
-static int need_more_output(void)
+static int need_more_output(int fdc)
 {
-	int status = wait_til_ready(current_fdc);
+	int status = wait_til_ready(fdc);
 
 	if (status < 0)
 		return -1;
@@ -1194,7 +1194,7 @@ static int need_more_output(void)
 	if (is_ready_state(status))
 		return MORE_OUTPUT;
 
-	return result(current_fdc);
+	return result(fdc);
 }
 
 /* Set perpendicular mode as required, based on data rate, if supported.
@@ -1244,7 +1244,7 @@ static int fdc_configure(void)
 {
 	/* Turn on FIFO */
 	output_byte(current_fdc, FD_CONFIGURE);
-	if (need_more_output() != MORE_OUTPUT)
+	if (need_more_output(current_fdc) != MORE_OUTPUT)
 		return 0;
 	output_byte(current_fdc, 0);
 	output_byte(current_fdc, 0x10 | (no_fifo & 0x20) | (fifo_depth & 0xf));
@@ -1302,7 +1302,7 @@ static void fdc_specify(void)
 			/* chose the default rate table, not the one
 			 * where 1 = 2 Mbps */
 			output_byte(current_fdc, FD_DRIVESPEC);
-			if (need_more_output() == MORE_OUTPUT) {
+			if (need_more_output(current_fdc) == MORE_OUTPUT) {
 				output_byte(current_fdc, UNIT(current_drive));
 				output_byte(current_fdc, 0xc0);
 			}
@@ -4324,7 +4324,7 @@ static char __init get_fdc_version(void)
 	}
 
 	output_byte(current_fdc, FD_PERPENDICULAR);
-	if (need_more_output() == MORE_OUTPUT) {
+	if (need_more_output(current_fdc) == MORE_OUTPUT) {
 		output_byte(current_fdc, 0);
 	} else {
 		pr_info("FDC %d is an 82072A\n", current_fdc);
-- 
2.20.1

