Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE6955EADF
	for <lists+linux-block@lfdr.de>; Tue, 28 Jun 2022 19:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiF1RTB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Jun 2022 13:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiF1RTA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 13:19:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36282FFD8
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 10:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=F2ryPHY6L42yA5UvmNp82+RRd7gswRVifieebMlwWPA=; b=VjEQGVfCx8qfBzZ/Cm+UAGpeL6
        ufRbznXTeYbDx53IvU7YDI+HZyEL3GYlwGIHD1H/wVx0K8eXd/RoWeNmqyEcbdAjINvdn1cXIP//Y
        v0paoEOcectROSbLH3HnfJXxBTm4znGMdW6FSdIGqxZvDA7n6yCq8VbH80qJZ1vMdB7L84YwgIs6M
        Uelq563GTLL3MRPJeGTRrR3etdWMnAhwl7jx7YaG8v6G27MYySrUzXnSPPa7WIu7CfkOh14QqWrPa
        Uz5kxwgtObLkwrRY0wl+jKYGkbsOrg0TnMEbyWEoViikps5rgnrLLAhOEcPbyeF8vJNZdMF5TYIeM
        vwETmfVA==;
Received: from [2001:4bb8:199:3788:e965:1541:b076:2977] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o6Erb-007NTB-1a; Tue, 28 Jun 2022 17:18:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 2/6] block: remove a superflous queue kobject reference
Date:   Tue, 28 Jun 2022 19:18:46 +0200
Message-Id: <20220628171850.1313069-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220628171850.1313069-1-hch@lst.de>
References: <20220628171850.1313069-1-hch@lst.de>
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

kobject_add already adds a reference to the parent that is dropped
on deletion, so don't bother grabbing another one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-sysfs.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 5f3f73115988c..f9373da591b83 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -812,14 +812,13 @@ int blk_register_queue(struct gendisk *disk)
 
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
 
@@ -883,7 +882,6 @@ int blk_register_queue(struct gendisk *disk)
 	mutex_unlock(&q->sysfs_lock);
 	mutex_unlock(&q->sysfs_dir_lock);
 	kobject_del(&q->kobj);
-	kobject_put(&dev->kobj);
 
 	return ret;
 }
@@ -941,6 +939,4 @@ void blk_unregister_queue(struct gendisk *disk)
 	q->sched_debugfs_dir = NULL;
 	q->rqos_debugfs_dir = NULL;
 	mutex_unlock(&q->debugfs_mutex);
-
-	kobject_put(&disk_to_dev(disk)->kobj);
 }
-- 
2.30.2

