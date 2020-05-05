Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9110C1C5828
	for <lists+linux-block@lfdr.de>; Tue,  5 May 2020 16:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgEEOHc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 5 May 2020 10:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729186AbgEEOHc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 May 2020 10:07:32 -0400
X-Greylist: delayed 253 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 May 2020 07:07:31 PDT
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02697C061A0F
        for <linux-block@vger.kernel.org>; Tue,  5 May 2020 07:07:31 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:bd97:8453:3b10:1832])
        by andre.telenet-ops.be with bizsmtp
        id b27V2200l3VwRR30127VQa; Tue, 05 May 2020 16:07:29 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jVyEL-0000Wi-IF; Tue, 05 May 2020 16:07:29 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jVyEL-0007eQ-GG; Tue, 05 May 2020 16:07:29 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] MAINTAINERS: Add missing header files to BLOCK LAYER section
Date:   Tue,  5 May 2020 16:07:28 +0200
Message-Id: <20200505140728.29369-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The various <linux/blk*.h> header files are part of the Block Layer.
Add them to the corresponding section in the MAINTAINERS file, so
scripts/get_maintainer.pl will pick them up.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f3fd61cde5125f74..16644a41d42737fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3136,6 +3136,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
 F:	block/
 F:	drivers/block/
+F:	include/linux/blk*
 F:	kernel/trace/blktrace.c
 F:	lib/sbitmap.c
 
-- 
2.17.1

