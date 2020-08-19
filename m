Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EF1249E36
	for <lists+linux-block@lfdr.de>; Wed, 19 Aug 2020 14:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgHSMi0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 19 Aug 2020 08:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbgHSMht (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Aug 2020 08:37:49 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF656C061757
        for <linux-block@vger.kernel.org>; Wed, 19 Aug 2020 05:37:48 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by laurent.telenet-ops.be with bizsmtp
        id HQYk2300Q4C55Sk01QYkUN; Wed, 19 Aug 2020 14:32:44 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8NGm-0002Di-Af; Wed, 19 Aug 2020 14:32:44 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8NGm-0004wu-9f; Wed, 19 Aug 2020 14:32:44 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] MAINTAINERS: Add missing header files to BLOCK LAYER section
Date:   Wed, 19 Aug 2020 14:32:43 +0200
Message-Id: <20200819123243.18983-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The various <linux/blk*.h> header files are part of the Block Layer.
Add them to the corresponding section in the MAINTAINERS file, so
scripts/get_maintainer.pl will pick them up.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
v2:
  - Add Reviewed-by.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 65141ec0a394a3f5..39d71867685be94b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3207,6 +3207,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
 F:	block/
 F:	drivers/block/
+F:	include/linux/blk*
 F:	kernel/trace/blktrace.c
 F:	lib/sbitmap.c
 
-- 
2.17.1

