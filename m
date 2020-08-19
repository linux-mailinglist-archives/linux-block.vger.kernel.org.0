Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B215249E00
	for <lists+linux-block@lfdr.de>; Wed, 19 Aug 2020 14:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgHSMeL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 19 Aug 2020 08:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgHSMeH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Aug 2020 08:34:07 -0400
X-Greylist: delayed 78 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Aug 2020 05:34:05 PDT
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858FFC061757
        for <linux-block@vger.kernel.org>; Wed, 19 Aug 2020 05:34:05 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by laurent.telenet-ops.be with bizsmtp
        id HQa42300H4C55Sk01Qa4fQ; Wed, 19 Aug 2020 14:34:04 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8NI4-0002EB-9D; Wed, 19 Aug 2020 14:34:04 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8NI4-0004zN-6W; Wed, 19 Aug 2020 14:34:04 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3] block: Make request_queue.rpm_status an enum
Date:   Wed, 19 Aug 2020 14:34:03 +0200
Message-Id: <20200819123403.19136-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

request_queue.rpm_status is assigned values of the rpm_status enum only,
so reflect that in its type.

Note that including <linux/pm.h> is (currently) a no-op, as it is
already included through <linux/genhd.h> and <linux/device.h>, but it is
better to play it safe.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
v3:
  - #include <linux/pm.h>, as requested by Bart,

v2:
  - Add Acked-by.
---
 include/linux/blkdev.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bb5636cc17b91a75..0a1730b30ad210b4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -24,6 +24,7 @@
 #include <linux/percpu-refcount.h>
 #include <linux/scatterlist.h>
 #include <linux/blkzoned.h>
+#include <linux/pm.h>
 
 struct module;
 struct scsi_ioctl_command;
@@ -458,7 +459,7 @@ struct request_queue {
 
 #ifdef CONFIG_PM
 	struct device		*dev;
-	int			rpm_status;
+	enum rpm_status		rpm_status;
 	unsigned int		nr_pending;
 #endif
 
-- 
2.17.1

