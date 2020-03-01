Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99971174F53
	for <lists+linux-block@lfdr.de>; Sun,  1 Mar 2020 20:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgCAT5A (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 1 Mar 2020 14:57:00 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:32076 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgCAT47 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 1 Mar 2020 14:56:59 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 021Ju5wk011202;
        Sun, 1 Mar 2020 20:56:05 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        Ian Molton <spyro@f2s.com>,
        Russell King <linux@armlinux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 2/6] floppy: remove incomplete support for second FDC from ARM code
Date:   Sun,  1 Mar 2020 20:55:51 +0100
Message-Id: <20200301195555.11154-3-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200301195555.11154-1-w@1wt.eu>
References: <20200301195555.11154-1-w@1wt.eu>
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

Cc: Ian Molton <spyro@f2s.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/arm/include/asm/floppy.h | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/floppy.h b/arch/arm/include/asm/floppy.h
index 4655652..7e58979 100644
--- a/arch/arm/include/asm/floppy.h
+++ b/arch/arm/include/asm/floppy.h
@@ -50,17 +50,13 @@ static inline int fd_dma_setup(void *data, unsigned int length,
  * to a non-zero track, and then restoring it to track 0.  If an error occurs,
  * then there is no floppy drive present.       [to be put back in again]
  */
-static unsigned char floppy_selects[2][4] =
-{
-	{ 0x10, 0x21, 0x23, 0x33 },
-	{ 0x10, 0x21, 0x23, 0x33 }
-};
+static unsigned char floppy_selects[4] = { 0x10, 0x21, 0x23, 0x33 };
 
 #define fd_setdor(dor)								\
 do {										\
 	int new_dor = (dor);							\
 	if (new_dor & 0xf0)							\
-		new_dor = (new_dor & 0x0c) | floppy_selects[fdc][new_dor & 3];	\
+		new_dor = (new_dor & 0x0c) | floppy_selects[new_dor & 3];	\
 	else									\
 		new_dor &= 0x0c;						\
 	outb(new_dor, FD_DOR);							\
@@ -84,9 +80,7 @@ do {										\
  */
 static void driveswap(int *ints, int dummy, int dummy2)
 {
-	floppy_selects[0][0] ^= floppy_selects[0][1];
-	floppy_selects[0][1] ^= floppy_selects[0][0];
-	floppy_selects[0][0] ^= floppy_selects[0][1];
+	swap(floppy_selects[0], floppy_selects[1]);
 }
 
 #define EXTRA_FLOPPY_PARAMS ,{ "driveswap", &driveswap, NULL, 0, 0 }
-- 
2.9.0

