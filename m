Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841F4414F2E
	for <lists+linux-block@lfdr.de>; Wed, 22 Sep 2021 19:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbhIVRfR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 22 Sep 2021 13:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbhIVRfQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 13:35:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD747C061574
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 10:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PHU/tmKdz/LioYZ0QtEvwChzQveuI5d+FV8MRyA1YBg=; b=q1Y4LaCGdPJ0CCgvCsOm7VrnyW
        XZgTLEuqY/4AB3JJjQrNa6K5AKYceUG47khGvW2iYNHcLkzyCGtuSjNQxpdKRbIJo+zB7F0KLakQi
        HGS/xyOpN96l/S1rM6M/kSujlu+IKaq2MXq7NyOSEVbxS0kCn875bGP48SJ7crMQejm27Uo0CSDi0
        jBNJZW52dqyxFd51SUdFXT24lIb8qZmxMmg6KiOOjCyxm1X0vebbXUHkk6yxUQ+ZT0+MitDYFggGc
        yAi1DWiolC6EKyzxrOBXBQCGzJ5RKIlixMzwnB+7r+WnwNa5RIuuO04a27aE6JF3TeaBvGxlPdKzd
        1mbJAJRg==;
Received: from [2001:4bb8:184:72db:3a8e:1992:6715:6960] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mT63m-004zNk-4m; Wed, 22 Sep 2021 17:30:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/4] block: keep q_usage_counter in atomic mode after del_gendisk
Date:   Wed, 22 Sep 2021 19:22:22 +0200
Message-Id: <20210922172222.2453343-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210922172222.2453343-1-hch@lst.de>
References: <20210922172222.2453343-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Don't switch back to percpu mode to avoid the double RCU grace period
when tearing down SCSI devices.  After removing the disk only passthrough
commands can be send anyway.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 9 ++++++++-
 block/blk.h    | 1 +
 block/genhd.c  | 3 ++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 108a352051be5..bc026372de439 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -188,9 +188,11 @@ void blk_mq_freeze_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue);
 
-void blk_mq_unfreeze_queue(struct request_queue *q)
+void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
 {
 	mutex_lock(&q->mq_freeze_lock);
+	if (force_atomic)
+		q->q_usage_counter.data->force_atomic = true;
 	q->mq_freeze_depth--;
 	WARN_ON_ONCE(q->mq_freeze_depth < 0);
 	if (!q->mq_freeze_depth) {
@@ -199,6 +201,11 @@ void blk_mq_unfreeze_queue(struct request_queue *q)
 	}
 	mutex_unlock(&q->mq_freeze_lock);
 }
+
+void blk_mq_unfreeze_queue(struct request_queue *q)
+{
+	__blk_mq_unfreeze_queue(q, false);
+}
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
 
 /*
diff --git a/block/blk.h b/block/blk.h
index e2ed2257709ae..6c3c00a8fe19d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -51,6 +51,7 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
 void blk_freeze_queue(struct request_queue *q);
+void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 void blk_queue_start_drain(struct request_queue *q);
 
 #define BIO_INLINE_VECS 4
diff --git a/block/genhd.c b/block/genhd.c
index b3c33495d7208..edd013a820879 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -596,7 +596,8 @@ void del_gendisk(struct gendisk *disk)
 	/*
 	 * Allow using passthrough request again after the queue is torn down.
 	 */
-	blk_mq_unfreeze_queue(q);
+	blk_queue_flag_clear(QUEUE_FLAG_INIT_DONE, q);
+	__blk_mq_unfreeze_queue(q, true);
 
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
 		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
-- 
2.30.2

