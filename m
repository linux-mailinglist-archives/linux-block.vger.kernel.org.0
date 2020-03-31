Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A063F19929A
	for <lists+linux-block@lfdr.de>; Tue, 31 Mar 2020 11:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbgCaJnM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 31 Mar 2020 05:43:12 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34180 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730273AbgCaJnM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 05:43:12 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02V9f65m024527;
        Tue, 31 Mar 2020 11:41:06 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 20/23] floppy: cleanup: make next_valid_format() not rely on current_drive anymore
Date:   Tue, 31 Mar 2020 11:40:51 +0200
Message-Id: <20200331094054.24441-21-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200331094054.24441-1-w@1wt.eu>
References: <20200331094054.24441-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now the drive is passed in argument so that the function does not
use current_drive anymore.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/block/floppy.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index b9a3a04c2636..f53810ba486d 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -2058,18 +2058,18 @@ static void success_and_wakeup(void)
  * ==========================
  */
 
-static int next_valid_format(void)
+static int next_valid_format(int drive)
 {
 	int probed_format;
 
-	probed_format = drive_state[current_drive].probed_format;
+	probed_format = drive_state[drive].probed_format;
 	while (1) {
-		if (probed_format >= 8 || !drive_params[current_drive].autodetect[probed_format]) {
-			drive_state[current_drive].probed_format = 0;
+		if (probed_format >= 8 || !drive_params[drive].autodetect[probed_format]) {
+			drive_state[drive].probed_format = 0;
 			return 1;
 		}
-		if (floppy_type[drive_params[current_drive].autodetect[probed_format]].sect) {
-			drive_state[current_drive].probed_format = probed_format;
+		if (floppy_type[drive_params[drive].autodetect[probed_format]].sect) {
+			drive_state[drive].probed_format = probed_format;
 			return 0;
 		}
 		probed_format++;
@@ -2082,7 +2082,7 @@ static void bad_flp_intr(void)
 
 	if (probing) {
 		drive_state[current_drive].probed_format++;
-		if (!next_valid_format())
+		if (!next_valid_format(current_drive))
 			return;
 	}
 	err_count = ++(*errors);
@@ -2884,7 +2884,7 @@ static void redo_fd_request(void)
 	if (!_floppy) {	/* Autodetection */
 		if (!probing) {
 			drive_state[current_drive].probed_format = 0;
-			if (next_valid_format()) {
+			if (next_valid_format(current_drive)) {
 				DPRINT("no autodetectable formats\n");
 				_floppy = NULL;
 				request_done(0);
-- 
2.20.1

