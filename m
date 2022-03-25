Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950E94E6E4A
	for <lists+linux-block@lfdr.de>; Fri, 25 Mar 2022 07:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358474AbiCYGmH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 25 Mar 2022 02:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358484AbiCYGmF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Mar 2022 02:42:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8159A7304B
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 23:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WVzkkbrxtQ7e/ZumjaGTdVP8sQaRQ+9gjayHQfTr2lE=; b=otGWFn+bbfMs4Q/U2GJAEN+wlV
        rKbNJs5E+Z7y4+RN/fU8Gt9hha+6zpefEy3QzsNqs2n5s4ziXQntybetYHd3oj7CdMR7Xn/nsVxoI
        vE7dzEe/U/2euPaoKvgvOW0moU9Upk7uhPdb4sAxAFxuXuPSHyGdBw9LIaOVMw1zfPRznXDtPq3zC
        Fy2gH2SqkDn2BOZJqQy+M95TNxOqfi1ktl6j9nYakUR2wqyoa76jeUvXYzAtiwBXh9CZLuUBpQoas
        vqRsK0Ah/5sRKUtVE2MobeHL4C5S09PXmYXHsrK+qTt9uu/WgrWHau6vXRRh0v9HS8h4v/jwbpUZb
        qMAnJm2g==;
Received: from 089144194144.atnat0003.highway.a1.net ([89.144.194.144] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXdcI-001HPl-Ik; Fri, 25 Mar 2022 06:40:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH 10/14] loop: only freeze the queue in __loop_clr_fd when needed
Date:   Fri, 25 Mar 2022 07:39:25 +0100
Message-Id: <20220325063929.1773899-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220325063929.1773899-1-hch@lst.de>
References: <20220325063929.1773899-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

->release is only called after all outstanding I/O has completed, so only
freeze the queue when clearing the backing file of a live loop device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Tested-by: Darrick J. Wong <djwong@kernel.org>
---
 drivers/block/loop.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c57acbcf9be6a..a5dd259958ee2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1144,8 +1144,13 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	if (test_bit(QUEUE_FLAG_WC, &lo->lo_queue->queue_flags))
 		blk_queue_write_cache(lo->lo_queue, false, false);
 
-	/* freeze request queue during the transition */
-	blk_mq_freeze_queue(lo->lo_queue);
+	/*
+	 * Freeze the request queue when unbinding on a live file descriptor and
+	 * thus an open device.  When called from ->release we are guaranteed
+	 * that there is no I/O in progress already.
+	 */
+	if (!release)
+		blk_mq_freeze_queue(lo->lo_queue);
 
 	destroy_workqueue(lo->workqueue);
 	loop_free_idle_workers(lo, true);
@@ -1170,7 +1175,8 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	mapping_set_gfp_mask(filp->f_mapping, gfp);
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
-	blk_mq_unfreeze_queue(lo->lo_queue);
+	if (!release)
+		blk_mq_unfreeze_queue(lo->lo_queue);
 
 	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
 
-- 
2.30.2

