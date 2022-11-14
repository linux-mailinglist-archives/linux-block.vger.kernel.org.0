Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C34F62753E
	for <lists+linux-block@lfdr.de>; Mon, 14 Nov 2022 05:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbiKNE0t (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 13 Nov 2022 23:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbiKNE0r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Nov 2022 23:26:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F4A6588
        for <linux-block@vger.kernel.org>; Sun, 13 Nov 2022 20:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=heKrwr2akRvQ2SQ827TSKtm3MGWsbdYYWveczVGyQCA=; b=eivMRCYNi0AQPQU4tbnexZp0rj
        GZfFvn/2jbgFYyxCmGfykO13NmHOgG5GMk8biaPoYNxHMdtt6JcD5WvvRPesZVNa0YTccm1RQNR/g
        toTRsx4dS4TF/tCvjHA28yr4wxjaizp0J/TL2tHa3FKd8fvoTYEbxc6kXT1DiZLheQ8/PfTFWrs3N
        2/RDR6n1qBrN4OLgfSTYaVwMj54S/NNwWGto5ENrIn0yTjMZf+7PDLbkucFNPt/hBdvtfqWWEBHAO
        +QYLZoSrYm0GIG1HZG6TzgBoTT6KKBpsR1XJSNrENmhs95gNAjaBTISV9bsVMwVFRok3Z9imtdEXF
        wGlY9Ibg==;
Received: from [2001:4bb8:191:2606:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ouR3V-00Fv5R-HJ; Mon, 14 Nov 2022 04:26:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH 2/5] block: factor out a blk_debugfs_remove helper
Date:   Mon, 14 Nov 2022 05:26:34 +0100
Message-Id: <20221114042637.1009333-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221114042637.1009333-1-hch@lst.de>
References: <20221114042637.1009333-1-hch@lst.de>
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

Split the debugfs removal from blk_unregister_queue into a helper so that
the it can be reused for blk_register_queue error handling.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-sysfs.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index bd223a3bef47d..197646d479b4a 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -800,6 +800,19 @@ struct kobj_type blk_queue_ktype = {
 	.release	= blk_release_queue,
 };
 
+static void blk_debugfs_remove(struct gendisk *disk)
+{
+	struct request_queue *q = disk->queue;
+
+	mutex_lock(&q->debugfs_mutex);
+	blk_trace_shutdown(q);
+	debugfs_remove_recursive(q->debugfs_dir);
+	q->debugfs_dir = NULL;
+	q->sched_debugfs_dir = NULL;
+	q->rqos_debugfs_dir = NULL;
+	mutex_unlock(&q->debugfs_mutex);
+}
+
 /**
  * blk_register_queue - register a block layer queue with sysfs
  * @disk: Disk of which the request queue should be registered with sysfs.
@@ -925,11 +938,5 @@ void blk_unregister_queue(struct gendisk *disk)
 	kobject_del(&q->kobj);
 	mutex_unlock(&q->sysfs_dir_lock);
 
-	mutex_lock(&q->debugfs_mutex);
-	blk_trace_shutdown(q);
-	debugfs_remove_recursive(q->debugfs_dir);
-	q->debugfs_dir = NULL;
-	q->sched_debugfs_dir = NULL;
-	q->rqos_debugfs_dir = NULL;
-	mutex_unlock(&q->debugfs_mutex);
+	blk_debugfs_remove(disk);
 }
-- 
2.30.2

