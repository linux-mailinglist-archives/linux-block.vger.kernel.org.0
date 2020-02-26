Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECF116F8F1
	for <lists+linux-block@lfdr.de>; Wed, 26 Feb 2020 09:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgBZIIE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 26 Feb 2020 03:08:04 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31564 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbgBZIID (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Feb 2020 03:08:03 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 01Q87iE5001960;
        Wed, 26 Feb 2020 09:07:44 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 12/16] floppy: remove incomplete support for second FDC from ARM code
Date:   Wed, 26 Feb 2020 09:07:28 +0100
Message-Id: <20200226080732.1913-2-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200226080732.1913-1-w@1wt.eu>
References: <20200224212352.8640-1-w@1wt.eu>
 <20200226080732.1913-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The ARM code was written with the apparent hope to one day support
a second FDC except that the code was incomplete and only touches
the first one, which is also reflected by N_FDC==1. However this
made its fd_outb() macro artificially depend on the global or local
"fdc" variable.

Let's get rid of this and make it explicit it doesn't rely on this
variable anymore.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/arm/include/asm/floppy.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/floppy.h b/arch/arm/include/asm/floppy.h
index 4655652..f683953 100644
--- a/arch/arm/include/asm/floppy.h
+++ b/arch/arm/include/asm/floppy.h
@@ -50,17 +50,16 @@ static inline int fd_dma_setup(void *data, unsigned int length,
  * to a non-zero track, and then restoring it to track 0.  If an error occurs,
  * then there is no floppy drive present.       [to be put back in again]
  */
-static unsigned char floppy_selects[2][4] =
+static unsigned char floppy_selects[4] =
 {
 	{ 0x10, 0x21, 0x23, 0x33 },
-	{ 0x10, 0x21, 0x23, 0x33 }
 };
 
 #define fd_setdor(dor)								\
 do {										\
 	int new_dor = (dor);							\
 	if (new_dor & 0xf0)							\
-		new_dor = (new_dor & 0x0c) | floppy_selects[fdc][new_dor & 3];	\
+		new_dor = (new_dor & 0x0c) | floppy_selects[new_dor & 3];	\
 	else									\
 		new_dor &= 0x0c;						\
 	outb(new_dor, FD_DOR);							\
@@ -84,9 +83,9 @@ do {										\
  */
 static void driveswap(int *ints, int dummy, int dummy2)
 {
-	floppy_selects[0][0] ^= floppy_selects[0][1];
-	floppy_selects[0][1] ^= floppy_selects[0][0];
-	floppy_selects[0][0] ^= floppy_selects[0][1];
+	floppy_selects[0] ^= floppy_selects[1];
+	floppy_selects[1] ^= floppy_selects[0];
+	floppy_selects[0] ^= floppy_selects[1];
 }
 
 #define EXTRA_FLOPPY_PARAMS ,{ "driveswap", &driveswap, NULL, 0, 0 }
-- 
2.9.0

