Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368EC68E85C
	for <lists+linux-block@lfdr.de>; Wed,  8 Feb 2023 07:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjBHGfV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 8 Feb 2023 01:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBHGfU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Feb 2023 01:35:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE264390D
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 22:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=bDGDzKFtbxH2Ng34jyi/x8XQrNvP8m0/elwQdSdL6B0=; b=RYOist5eI+HBP4M/kqLIzUxmz2
        inR2mL7V0+ZWWa6nDbkkJqIs3FaNZ+2vbe37dbKiJ/Q8XIZ0wnXv0Ex1/AalnGeR3sPu1jCurYug2
        SbCMhFEubRGDfYJGutol0MZ4b3AiNQt05mIMHsdvwR2y7lMm6yXKnjgKY1K9y8Bec2u0tOPxdzLUJ
        LHd51jO+0mDgc+5p/pm+pvji9fzbHUf3QqiEmtGfVp6/DJtO26oGSRI0eF7jrRA/0PQ+mlsVw9F3I
        Nmynd50fQxpDFFx7MER89aIfB/TlM9x6DssN376Ar+KWkAxgdWuBd2vfqgopw1ZE854WGIqnVNiwJ
        Ivew0ftA==;
Received: from [2001:4bb8:182:9f5b:510d:dd63:820f:b5db] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPe33-00EJq7-Ur; Wed, 08 Feb 2023 06:35:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] blk-cgroup: delay calling blkcg_exit_disk until disk_release
Date:   Wed,  8 Feb 2023 07:35:14 +0100
Message-Id: <20230208063514.171485-1-hch@lst.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While del_gendisk ensures there is no outstanding I/O on the queue,
it can't prevent block layer users from building new I/O.

This leads to a NULL ->root_blkg reference in bio_associate_blkg when
allocating a new bio on a shut down file system.  Delay freeing the
blk-cgroup subsystems from del_gendisk until disk_release to make
sure the blkg and throttle information is still avaіlable for bio
submitters, even if those bios will immediately fail.

This now can cause a case where disk_release is called on a disk
that hasn't been added.  That's mostly harmless, except for a case
in blk_throttl_exit that now needs to check for a NULL ->td pointer.

Fixes: 178fa7d49815 ("blk-cgroup: delay blk-cgroup initialization until add_disk")
Reported-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-throttle.c | 3 ++-
 block/genhd.c        | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 902203bdddb4b4..e7bd7050d68402 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2411,7 +2411,8 @@ void blk_throtl_exit(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 
-	BUG_ON(!q->td);
+	if (!q->td)
+		return;
 	del_timer_sync(&q->td->service_queue.pending_timer);
 	throtl_shutdown_wq(q);
 	blkcg_deactivate_policy(disk, &blkcg_policy_throtl);
diff --git a/block/genhd.c b/block/genhd.c
index 7e031559bf514c..65373738c70b02 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -668,8 +668,6 @@ void del_gendisk(struct gendisk *disk)
 	rq_qos_exit(q);
 	blk_mq_unquiesce_queue(q);
 
-	blkcg_exit_disk(disk);
-
 	/*
 	 * If the disk does not own the queue, allow using passthrough requests
 	 * again.  Else leave the queue frozen to fail all I/O.
@@ -1166,6 +1164,8 @@ static void disk_release(struct device *dev)
 	might_sleep();
 	WARN_ON_ONCE(disk_live(disk));
 
+	blkcg_exit_disk(disk);
+
 	/*
 	 * To undo the all initialization from blk_mq_init_allocated_queue in
 	 * case of a probe failure where add_disk is never called we have to
-- 
2.39.1

