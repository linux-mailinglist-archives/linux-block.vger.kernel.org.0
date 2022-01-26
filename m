Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203DB49CEE6
	for <lists+linux-block@lfdr.de>; Wed, 26 Jan 2022 16:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiAZPuw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 26 Jan 2022 10:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbiAZPuw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jan 2022 10:50:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E018C06161C
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 07:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=teJGW7Ajz7529ByUSOvWAvIbJP0X5QVM599c4p16P0U=; b=NDtzMXnaOXd6n22TP5lwUzz+YZ
        7vQ188ZSxCxcvb4VcE29KBH0zUunIoThpZI4mnSk2P9huWjCZViJn9e6hKZ4w4GR9/VASNx7KRomo
        ZneRyNUUOge63zs+f56vNEWAPGAN2PsBodTQ+89xN7cYmUtEJfkXz+r5MJehs2tjFJg3ZkPlpXb8f
        glgSM9GW9+oDsKrN/Vgi0/8xmyU59kX0nyYCtzxPJk0ZjQggqaSAKHNnudCtIxHJGMHEd1jA0mpVA
        SVE7z2h1VwwdOSGO35ECWIu2XX8iRrVkksz5lPid0PeNrmhzO8NpNUFY4Ch2slsMFnFhKqhKMWELU
        /aZGz4Xg==;
Received: from [2001:4bb8:180:4c4c:c422:bb0a:5a5f:dce0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCkZM-00CQ6A-EG; Wed, 26 Jan 2022 15:50:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/8] loop: initialize the worker tracking fields once
Date:   Wed, 26 Jan 2022 16:50:34 +0100
Message-Id: <20220126155040.1190842-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126155040.1190842-1-hch@lst.de>
References: <20220126155040.1190842-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no need to reinitialize idle_worker_list, worker_tree and timer
every time a loop device is configured.  Just initialize them once at
allocation time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b268bca6e4fb7..6ec55a5d9dfc4 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1052,10 +1052,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 
 	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
 	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
-	INIT_LIST_HEAD(&lo->idle_worker_list);
-	lo->worker_tree = RB_ROOT;
-	timer_setup(&lo->timer, loop_free_idle_workers_timer,
-		TIMER_DEFERRABLE);
 	lo->use_dio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
 	lo->lo_device = bdev;
 	lo->lo_backing_file = file;
@@ -1957,6 +1953,9 @@ static int loop_add(int i)
 	lo = kzalloc(sizeof(*lo), GFP_KERNEL);
 	if (!lo)
 		goto out;
+	lo->worker_tree = RB_ROOT;
+	INIT_LIST_HEAD(&lo->idle_worker_list);
+	timer_setup(&lo->timer, loop_free_idle_workers_timer, TIMER_DEFERRABLE);
 	lo->lo_state = Lo_unbound;
 
 	err = mutex_lock_killable(&loop_ctl_mutex);
-- 
2.30.2

