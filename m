Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 844C243EE2
	for <lists+linux-block@lfdr.de>; Thu, 13 Jun 2019 17:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbfFMPxj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 13 Jun 2019 11:53:39 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:55950 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731602AbfFMJAJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 05:00:09 -0400
Received: from ramsan ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id Q8zU2000G3XaVaC018zV7m; Thu, 13 Jun 2019 10:59:55 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hbLZw-0000Wz-Fs; Thu, 13 Jun 2019 10:59:28 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hbKBT-0003Vp-Fd; Thu, 13 Jun 2019 09:30:07 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jim Paris <jim@jtan.com>, Geoff Levand <geoff@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] block/ps3vram: Use %llu to format sector_t after LBDAF removal
Date:   Thu, 13 Jun 2019 09:30:06 +0200
Message-Id: <20190613073006.13459-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The removal of CONFIG_LBDAF changed the type of sector_t from "unsigned
long" to "u64" aka "unsigned long long" on 64-bit platforms, leading to
a compiler warning regression:

    drivers/block/ps3vram.c: In function ‘ps3vram_probe’:
    drivers/block/ps3vram.c:770:23: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘sector_t {aka long long unsigned int}’ [-Wformat=]

Fix this by using "%llu" instead.

Fixes: 72deb455b5ec619f ("block: remove CONFIG_LBDAF")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/block/ps3vram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index 4c7f51b1eda94727..4628e1a27a2b7133 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -767,7 +767,7 @@ static int ps3vram_probe(struct ps3_system_bus_device *dev)
 	strlcpy(gendisk->disk_name, DEVICE_NAME, sizeof(gendisk->disk_name));
 	set_capacity(gendisk, priv->size >> 9);
 
-	dev_info(&dev->core, "%s: Using %lu MiB of GPU memory\n",
+	dev_info(&dev->core, "%s: Using %llu MiB of GPU memory\n",
 		 gendisk->disk_name, get_capacity(gendisk) >> 11);
 
 	device_add_disk(&dev->core, gendisk, NULL);
-- 
2.17.1

