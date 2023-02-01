Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6DB686729
	for <lists+linux-block@lfdr.de>; Wed,  1 Feb 2023 14:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjBANlu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 1 Feb 2023 08:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbjBANlu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Feb 2023 08:41:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C68645F6A;
        Wed,  1 Feb 2023 05:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=JZLy6HxZ/+odfuZXsAIt7ubeGUaUjPIIWPu5GfwyLGo=; b=YGRhxTaZidvDgii4a4ZtZEcF7T
        HkTutzU1vdbn16sAtHSgbYkpFVKl+QfEV/4ozAwmuHleIVMi8P9ABZZbQRqFy77FNJ/73sq2+eeoe
        fmg3l37MP8kTKo6u2mBB+3RPIcXYlc0alwa345rDdPfREtcUW8bkb+mQj38xtIHWFtSIajMWzAid/
        etSXCP5lhhQysaBTwoedZiZGxDFcFza7Cuta1QPBD3CoOhFG5tyzD8i1UK9LXW4JZHMBpOiTzynB0
        CCKr0QcSwNXSYNf42AYhmZc5DEyBjI3tnMsCJVM//PP0lp6PjT+vcCUWgUcH305o0yFbuSbRA9Q9K
        X/Ocu7zA==;
Received: from [2001:4bb8:19a:272a:3635:31c6:c223:d428] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNDMv-00C7Vb-TA; Wed, 01 Feb 2023 13:41:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: [PATCH 07/19] blk-cgroup: store a gendisk to throttle in struct task_struct
Date:   Wed,  1 Feb 2023 14:41:11 +0100
Message-Id: <20230201134123.2656505-8-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230201134123.2656505-1-hch@lst.de>
References: <20230201134123.2656505-1-hch@lst.de>
MIME-Version: 1.0
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

Switch from a request_queue pointer and reference to a gendisk once
for the throttle information in struct task_struct.

Move the check for the dead disk to the latest place now that is is
unbundled from the reference grab.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
---
 block/blk-cgroup.c    | 37 +++++++++++++++++++------------------
 include/linux/sched.h |  2 +-
 kernel/fork.c         |  2 +-
 mm/swapfile.c         |  2 +-
 4 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0e368387497d27..83fb519fd7d539 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1362,9 +1362,9 @@ static void blkcg_bind(struct cgroup_subsys_state *root_css)
 
 static void blkcg_exit(struct task_struct *tsk)
 {
-	if (tsk->throttle_queue)
-		blk_put_queue(tsk->throttle_queue);
-	tsk->throttle_queue = NULL;
+	if (tsk->throttle_disk)
+		put_disk(tsk->throttle_disk);
+	tsk->throttle_disk = NULL;
 }
 
 struct cgroup_subsys io_cgrp_subsys = {
@@ -1815,29 +1815,32 @@ static void blkcg_maybe_throttle_blkg(struct blkcg_gq *blkg, bool use_memdelay)
  *
  * This is only called if we've been marked with set_notify_resume().  Obviously
  * we can be set_notify_resume() for reasons other than blkcg throttling, so we
- * check to see if current->throttle_queue is set and if not this doesn't do
+ * check to see if current->throttle_disk is set and if not this doesn't do
  * anything.  This should only ever be called by the resume code, it's not meant
  * to be called by people willy-nilly as it will actually do the work to
  * throttle the task if it is setup for throttling.
  */
 void blkcg_maybe_throttle_current(void)
 {
-	struct request_queue *q = current->throttle_queue;
+	struct gendisk *disk = current->throttle_disk;
 	struct blkcg *blkcg;
 	struct blkcg_gq *blkg;
 	bool use_memdelay = current->use_memdelay;
 
-	if (!q)
+	if (!disk)
 		return;
 
-	current->throttle_queue = NULL;
+	current->throttle_disk = NULL;
 	current->use_memdelay = false;
 
+	if (test_bit(GD_DEAD, &disk->state))
+		goto out_put_disk;
+
 	rcu_read_lock();
 	blkcg = css_to_blkcg(blkcg_css());
 	if (!blkcg)
 		goto out;
-	blkg = blkg_lookup(blkcg, q);
+	blkg = blkg_lookup(blkcg, disk->queue);
 	if (!blkg)
 		goto out;
 	if (!blkg_tryget(blkg))
@@ -1846,11 +1849,12 @@ void blkcg_maybe_throttle_current(void)
 
 	blkcg_maybe_throttle_blkg(blkg, use_memdelay);
 	blkg_put(blkg);
-	blk_put_queue(q);
+	put_disk(disk);
 	return;
 out:
 	rcu_read_unlock();
-	blk_put_queue(q);
+out_put_disk:
+	put_disk(disk);
 }
 
 /**
@@ -1872,18 +1876,15 @@ void blkcg_maybe_throttle_current(void)
  */
 void blkcg_schedule_throttle(struct gendisk *disk, bool use_memdelay)
 {
-	struct request_queue *q = disk->queue;
-
 	if (unlikely(current->flags & PF_KTHREAD))
 		return;
 
-	if (current->throttle_queue != q) {
-		if (!blk_get_queue(q))
-			return;
+	if (current->throttle_disk != disk) {
+		get_device(disk_to_dev(disk));
 
-		if (current->throttle_queue)
-			blk_put_queue(current->throttle_queue);
-		current->throttle_queue = q;
+		if (current->throttle_disk)
+			put_disk(current->throttle_disk);
+		current->throttle_disk = disk;
 	}
 
 	if (use_memdelay)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 853d08f7562bda..6f6ce9ca709798 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1436,7 +1436,7 @@ struct task_struct {
 #endif
 
 #ifdef CONFIG_BLK_CGROUP
-	struct request_queue		*throttle_queue;
+	struct gendisk			*throttle_disk;
 #endif
 
 #ifdef CONFIG_UPROBES
diff --git a/kernel/fork.c b/kernel/fork.c
index 9f7fe354189785..d9c97704b7c9a4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1044,7 +1044,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 #endif
 
 #ifdef CONFIG_BLK_CGROUP
-	tsk->throttle_queue = NULL;
+	tsk->throttle_disk = NULL;
 	tsk->use_memdelay = 0;
 #endif
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 908a529bca12c9..3e0a742fb7bbff 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3642,7 +3642,7 @@ void __cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
 	 * We've already scheduled a throttle, avoid taking the global swap
 	 * lock.
 	 */
-	if (current->throttle_queue)
+	if (current->throttle_disk)
 		return;
 
 	spin_lock(&swap_avail_lock);
-- 
2.39.0

