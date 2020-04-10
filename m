Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 892AE1A4519
	for <lists+linux-block@lfdr.de>; Fri, 10 Apr 2020 12:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDJKTY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 10 Apr 2020 06:19:24 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34489 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgDJKTY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Apr 2020 06:19:24 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 03AAJ90a014695;
        Fri, 10 Apr 2020 12:19:09 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 26/23] floppy: cleanup: get rid of current_reqD in favor of current_drive
Date:   Fri, 10 Apr 2020 12:19:03 +0200
Message-Id: <20200410101904.14652-2-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200410101904.14652-1-w@1wt.eu>
References: <20200331094054.24441-23-w@1wt.eu>
 <20200410101904.14652-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This macro equals -1 and is used as an alternative for current_drive when
calling reschedule_timeout(), which in turn needs to remap it. This only
adds obfuscation, let's simply use current_drive.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/block/floppy.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index b102f55dfa5d..20646d4c5437 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -668,16 +668,12 @@ static struct output_log {
 
 static int output_log_pos;
 
-#define current_reqD -1
 #define MAXTIMEOUT -2
 
 static void __reschedule_timeout(int drive, const char *message)
 {
 	unsigned long delay;
 
-	if (drive == current_reqD)
-		drive = current_drive;
-
 	if (drive < 0 || drive >= N_DRIVE) {
 		delay = 20UL * HZ;
 		drive = 0;
@@ -1960,7 +1956,7 @@ static void floppy_ready(void)
 
 static void floppy_start(void)
 {
-	reschedule_timeout(current_reqD, "floppy start");
+	reschedule_timeout(current_drive, "floppy start");
 
 	scandrives();
 	debug_dcl(drive_params[current_drive].flags,
@@ -2874,7 +2870,7 @@ static void redo_fd_request(void)
 	}
 	drive = (long)current_req->rq_disk->private_data;
 	set_fdc(drive);
-	reschedule_timeout(current_reqD, "redo fd request");
+	reschedule_timeout(current_drive, "redo fd request");
 
 	set_floppy(drive);
 	raw_cmd = &default_raw_cmd;
-- 
2.20.1

