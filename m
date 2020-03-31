Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96A4F199298
	for <lists+linux-block@lfdr.de>; Tue, 31 Mar 2020 11:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbgCaJnH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 31 Mar 2020 05:43:07 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34177 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730273AbgCaJnH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 05:43:07 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02V9f76u024532;
        Tue, 31 Mar 2020 11:41:07 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 23/23] floppy: cleanup: add a few comments about expectations in certain functions
Date:   Tue, 31 Mar 2020 11:40:54 +0200
Message-Id: <20200331094054.24441-24-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200331094054.24441-1-w@1wt.eu>
References: <20200331094054.24441-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The locking in the driver is far from being obvious, with unlocking
automatically happening at end of operations scheduled by interrupt,
especially for the error paths where one does not necessarily expect
that such an interrupt may be triggered. Let's add a few comments
about what to expect at certain places to avoid misdetecting bugs
which are not.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/block/floppy.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 77bb9a5fcd33..07218f8b17f9 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -1791,7 +1791,9 @@ static void reset_interrupt(void)
 
 /*
  * reset is done by pulling bit 2 of DOR low for a while (old FDCs),
- * or by setting the self clearing bit 7 of STATUS (newer FDCs)
+ * or by setting the self clearing bit 7 of STATUS (newer FDCs).
+ * This WILL trigger an interrupt, causing the handlers in the current
+ * cont's ->redo() to be called via reset_interrupt().
  */
 static void reset_fdc(void)
 {
@@ -2003,6 +2005,9 @@ static const struct cont_t intr_cont = {
 	.done		= (done_f)empty
 };
 
+/* schedules handler, waiting for completion. May be interrupted, will then
+ * return -EINTR, in which case the driver will automatically be unlocked.
+ */
 static int wait_til_done(void (*handler)(void), bool interruptible)
 {
 	int ret;
@@ -2842,6 +2847,9 @@ static int set_next_request(void)
 	return current_req != NULL;
 }
 
+/* Starts or continues processing request. Will automatically unlock the
+ * driver at end of request.
+ */
 static void redo_fd_request(void)
 {
 	int drive;
@@ -2916,6 +2924,7 @@ static const struct cont_t rw_cont = {
 	.done		= request_done
 };
 
+/* schedule the request and automatically unlock the driver on completion */
 static void process_fd_request(void)
 {
 	cont = &rw_cont;
@@ -3005,6 +3014,9 @@ static int user_reset_fdc(int drive, int arg, bool interruptible)
 	if (arg == FD_RESET_ALWAYS)
 		fdc_state[current_fdc].reset = 1;
 	if (fdc_state[current_fdc].reset) {
+		/* note: reset_fdc will take care of unlocking the driver
+		 * on completion.
+		 */
 		cont = &reset_cont;
 		ret = wait_til_done(reset_fdc, interruptible);
 		if (ret == -EINTR)
-- 
2.20.1

