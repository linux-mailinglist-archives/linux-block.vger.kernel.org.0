Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83023AE724
	for <lists+linux-block@lfdr.de>; Mon, 21 Jun 2021 12:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFUKbg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 21 Jun 2021 06:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhFUKbf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 06:31:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AB4C061574
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 03:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZYTWT1x1aj8+1YwAzNumqNw6wJ39vs/Vr6slb7e5rnE=; b=kIVvw1WbtsLj5cZW3oe2EceZnW
        ZWrdrNSzd7LTbs9uKaLV/LsXytqLn31rYnaeUWo9okud2CqieCPG3b2T0JL5iBBrxTY7NmrywXAsC
        B5VIkWShAM891bQUxi5el/oz3+GGFDHx5aCmCZv5GGwV0zAD+DiOqUpXNYFUtov+rkyhfS9LtkUhY
        2OMi2+tbwNAhWaMzXYdjv21cyiL/FLC6WxVbCg5IjJrL3/u4ItKW9wFzkFgYAfko2NB45QFLruyKv
        prNjMDol6zaph8cUSM5hpfMlyMruNC8gXkddAqyj09zdoB1xMw8BqEyGnmowQMZwtVIpNlAt2IzcX
        Eu3kVkCQ==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvHAM-00Cz3b-RY; Mon, 21 Jun 2021 10:28:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org
Subject: [PATCH 4/9] loop: don't call loop_lookup before adding a loop device
Date:   Mon, 21 Jun 2021 12:15:42 +0200
Message-Id: <20210621101547.3764003-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621101547.3764003-1-hch@lst.de>
References: <20210621101547.3764003-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

loop_add returns the right error if the slot wasn't available.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 8392722d0e12..b1e7e420563b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2219,14 +2219,12 @@ static int loop_lookup(struct loop_device **l, int i)
 static void loop_probe(dev_t dev)
 {
 	int idx = MINOR(dev) >> part_shift;
-	struct loop_device *lo;
 
 	if (max_loop && idx >= max_loop)
 		return;
 
 	mutex_lock(&loop_ctl_mutex);
-	if (loop_lookup(&lo, idx) < 0)
-		loop_add(idx);
+	loop_add(idx);
 	mutex_unlock(&loop_ctl_mutex);
 }
 
@@ -2243,11 +2241,6 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 	ret = -ENOSYS;
 	switch (cmd) {
 	case LOOP_CTL_ADD:
-		ret = loop_lookup(&lo, parm);
-		if (ret >= 0) {
-			ret = -EEXIST;
-			break;
-		}
 		ret = loop_add(parm);
 		break;
 	case LOOP_CTL_REMOVE:
-- 
2.30.2

