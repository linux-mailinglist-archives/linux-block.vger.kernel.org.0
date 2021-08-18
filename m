Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06ECE3EFCDF
	for <lists+linux-block@lfdr.de>; Wed, 18 Aug 2021 08:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238161AbhHRGfv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 18 Aug 2021 02:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237947AbhHRGfu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 02:35:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613A3C061764
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 23:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+dtCc/IfR7NVRb2PlBRqCQbtFOe5sRZZZtHyOGBNP88=; b=WzdsmlnpqpEF6gyNnFNEDclAvx
        Tso3NcRyelL8kgm7Rn5XR35sOJTyMYpUQfsa9ehBffVO8xmA0MOVSu7fKPuUt/zcDSbi4XcSRhMLj
        F2IUd7WRUaKuAXbwTvufE7b+VCkwmNCAxGxVTg6kPmZw86qRt7an2I3w6W8hmJTc0dhCLNZpHVSFL
        xTjHzH6DLZREvwcCbwmwh6Nnw/RZmAh3HzW0anKrCR75TmOhJxuwBCjbRKpfu1cIpptYtui1GUU3w
        jmF3UqWoPWM+kmAKdMh+p57FmYTdHdGUwm8yOfP1aRBLYG9aL4DGBpCi6ppRvizMKGF5gfG05nhdh
        Ci03fz6w==;
Received: from 213-225-12-39.nat.highway.a1.net ([213.225.12.39] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGF8c-003ReT-TW; Wed, 18 Aug 2021 06:33:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Hillf Danton <hdanton@sina.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "Reviewed-by : Tyler Hicks" <tyhicks@linux.microsoft.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 6/7] loop: move loop device deletion out of loop_ctl_mutex
Date:   Wed, 18 Aug 2021 08:24:54 +0200
Message-Id: <20210818062455.211065-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818062455.211065-1-hch@lst.de>
References: <20210818062455.211065-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To avoid complex lock ordering issues always delete loop devices outside
of loop_ctl_mutex.  In loop_control_remove the Lo_deleting state can
be used to prevent further lookups, and given that module unload is
synchronized vs new opens of the control device and thus ioctls there
is no need for locks there at all.

Based on patches from Hillf Danton <hdanton@sina.com> and
Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>.

Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index e93baff664c9..043673bda8b3 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2480,7 +2480,11 @@ static int loop_control_remove(int idx)
 	mutex_unlock(&lo->lo_mutex);
 
 	idr_remove(&loop_index_idr, lo->lo_number);
+	mutex_unlock(&loop_ctl_mutex);
+
 	loop_remove(lo);
+	return 0;
+
 out_unlock_ctrl:
 	mutex_unlock(&loop_ctl_mutex);
 	return ret;
@@ -2611,11 +2615,12 @@ static void __exit loop_exit(void)
 	unregister_blkdev(LOOP_MAJOR, "loop");
 	misc_deregister(&loop_misc);
 
-	mutex_lock(&loop_ctl_mutex);
+	/*
+	 * No need for loop_ctl_mutex given that no new ioctls and thus
+	 * additions and removals can happen in parallel to module unloading.
+	 */
 	idr_for_each_entry(&loop_index_idr, lo, id)
 		loop_remove(lo);
-	mutex_unlock(&loop_ctl_mutex);
-
 	idr_destroy(&loop_index_idr);
 }
 
-- 
2.30.2

