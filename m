Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EE54DACC3
	for <lists+linux-block@lfdr.de>; Wed, 16 Mar 2022 09:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354615AbiCPIqr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 16 Mar 2022 04:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354595AbiCPIqp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 04:46:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147F964BD7
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 01:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=G/i2VL4ZSrXtxk8zMKc9LlK7I2p8DCMTRMVUqNb3p6Q=; b=MwJTlvsrdITMs0uPh4xl/aoZtW
        j42Mg4+aRF0NgTJKGYs3fTq0eWNk6XkJPh5tHFqm8zKHh8BcNbCisbpcXJAn2CPAj1kIu6rIUTGI0
        g1WStyR/Q/kWyBpeoNmXN09gHx5cV4uNigwR2LPnRU/lYrndB4dtV67VU0eMEK8C7gpUe8UhNB+JO
        gzChj1BPAG6R7KW1YLD5F9YnAV9h4hyvT8JVp5QhIpkfoXV3BrI8AWIFtKY6EbDswYim5drdbHVK9
        ELFlJiMdzyVBsPdfVFnLEkx3Ac10j+GkLk6fPghHK36JAkS4d8vWTe1FxZ/aC/CZo4xGhHQx58st8
        /eNAudAQ==;
Received: from [46.140.54.162] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUPHb-00CC9y-P9; Wed, 16 Mar 2022 08:45:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/8] loop: initialize the worker tracking fields once
Date:   Wed, 16 Mar 2022 09:45:13 +0100
Message-Id: <20220316084519.2850118-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220316084519.2850118-1-hch@lst.de>
References: <20220316084519.2850118-1-hch@lst.de>
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

There is no need to reinitialize idle_worker_list, worker_tree and timer
every time a loop device is configured.  Just initialize them once at
allocation time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Tested-by: Darrick J. Wong <djwong@kernel.org>
---
 drivers/block/loop.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 64227e659efc4..2d344fefda6b8 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1057,10 +1057,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 
 	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
 	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
-	INIT_LIST_HEAD(&lo->idle_worker_list);
-	lo->worker_tree = RB_ROOT;
-	timer_setup(&lo->timer, loop_free_idle_workers_timer,
-		TIMER_DEFERRABLE);
 	lo->use_dio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
 	lo->lo_device = bdev;
 	lo->lo_backing_file = file;
@@ -1973,6 +1969,9 @@ static int loop_add(int i)
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

