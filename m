Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9FF559233
	for <lists+linux-block@lfdr.de>; Fri, 24 Jun 2022 07:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiFXFZW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 24 Jun 2022 01:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiFXFZU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 01:25:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E7D69254
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 22:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xYh8DadyNn8sTOe3EShJn45tY9NKvnyoNRPgwCgvCdw=; b=L5y2hb/j1oOKkuSy7hZVPCIUvJ
        ZWy/lSrjntadduPCx1/Hx++LwUJbsCsSI+mazYybvQKcNEF2/fGNMzdWTLRXGX/79GeaUVgRY/72I
        w9vhWgGM3YeGuJae00rWskimWK1oFvpyBQQLeTN6b2/Z9Grp2Kl2pVHyN6ZfCjnLBdvbwO182h3xD
        +tNl43eMx6wzRLKMr3luca3h1hvvVPtRUwWnPlvBVmVzyYcLkJ/gswOhmCybj2ukAjYyjQZ3sSydB
        1nmz+R6+TWBvoQM03nDJz42mLbLtQzLMB9I0fRImGf/qZDynpTaTiRKobx52XtK0EDP9gydDCbSIK
        SAku1+pA==;
Received: from [2001:4bb8:189:7251:508b:56d3:aa35:3dd8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4boj-000cAK-SV; Fri, 24 Jun 2022 05:25:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/6] block: remove a superflous queue kobject reference
Date:   Fri, 24 Jun 2022 07:25:06 +0200
Message-Id: <20220624052510.3996673-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220624052510.3996673-1-hch@lst.de>
References: <20220624052510.3996673-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

kobject_add already adds a referene to the parent that is dropped
on deletion, so don't bother grabbing another one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-sysfs.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e4df5ccebf0d0..520ff9aa6dd45 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -805,14 +805,13 @@ int blk_register_queue(struct gendisk *disk)
 
 	mutex_lock(&q->sysfs_dir_lock);
 
-	ret = kobject_add(&q->kobj, kobject_get(&dev->kobj), "%s", "queue");
+	ret = kobject_add(&q->kobj, &dev->kobj, "%s", "queue");
 	if (ret < 0)
 		goto unlock;
 
 	ret = sysfs_create_group(&q->kobj, &queue_attr_group);
 	if (ret) {
 		kobject_del(&q->kobj);
-		kobject_put(&dev->kobj);
 		goto unlock;
 	}
 
@@ -876,7 +875,6 @@ int blk_register_queue(struct gendisk *disk)
 	mutex_unlock(&q->sysfs_lock);
 	mutex_unlock(&q->sysfs_dir_lock);
 	kobject_del(&q->kobj);
-	kobject_put(&dev->kobj);
 
 	return ret;
 }
@@ -934,6 +932,4 @@ void blk_unregister_queue(struct gendisk *disk)
 	q->sched_debugfs_dir = NULL;
 	q->rqos_debugfs_dir = NULL;
 	mutex_unlock(&q->debugfs_mutex);
-
-	kobject_put(&disk_to_dev(disk)->kobj);
 }
-- 
2.30.2

