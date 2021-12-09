Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CFA46E28C
	for <lists+linux-block@lfdr.de>; Thu,  9 Dec 2021 07:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhLIGfX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 9 Dec 2021 01:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbhLIGfW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Dec 2021 01:35:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2055C061746
        for <linux-block@vger.kernel.org>; Wed,  8 Dec 2021 22:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Knk8zEqgtQpznfQ3J5s6XEsNZ6asBz7rY43kwgqAXE4=; b=VlW40Op4IvLPIG/ZIJdWnCvf/C
        jloaKGivgv7X0EYT011xFh29dykrnHLz4sH99XVM1SO97iTGgJAs7nrTjdvfDwOJsm5zE/P/L8dHv
        A4UfRAYVo6WFe+arrwaIqBcfG82Ya0z6LaC9vbIynMvJTgwqo61PwByS29edDiP4bqBJ2TjxUuEG5
        eCD7JhhYOB9OXYJBjCrtYov9b4ZYEnU4hjy68ui9ujglSXk+6IxARquklPAzJ3T62WClf26Q96kkN
        Y5E71ad7hc+bix7wSpJzL05GDyseUXRNlKzibYTlUP5q6UQsxRws3bSl1mZOLpDdl7bqr48lNDBwl
        SdCuU/Ow==;
Received: from [2001:4bb8:180:a1c8:2d0e:135:af53:41f8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvCy2-0096Ut-DR; Thu, 09 Dec 2021 06:31:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org
Subject: [PATCH 11/11] block: only build the icq tracking code when needed
Date:   Thu,  9 Dec 2021 07:31:31 +0100
Message-Id: <20211209063131.18537-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209063131.18537-1-hch@lst.de>
References: <20211209063131.18537-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Only bfq needs to code to track icq, so make it conditional.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/Kconfig             |  3 ++
 block/Kconfig.iosched     |  1 +
 block/blk-ioc.c           | 68 +++++++++++++++++++++++----------------
 block/blk.h               |  6 ++++
 include/linux/iocontext.h |  6 ++--
 5 files changed, 55 insertions(+), 29 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index c6ce41a5e5b27..d5d4197b7ed2d 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -35,6 +35,9 @@ config BLK_CGROUP_RWSTAT
 config BLK_DEV_BSG_COMMON
 	tristate
 
+config BLK_ICQ
+	bool
+
 config BLK_DEV_BSGLIB
 	bool "Block layer SG support v4 helper lib"
 	select BLK_DEV_BSG_COMMON
diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 885fee86dfcae..6155161460862 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -18,6 +18,7 @@ config MQ_IOSCHED_KYBER
 
 config IOSCHED_BFQ
 	tristate "BFQ I/O scheduler"
+	select BLK_ICQ
 	help
 	BFQ I/O scheduler for BLK-MQ. BFQ distributes the bandwidth of
 	of the device among all processes according to their weights,
diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index dc7fb064fd5f7..87bdc9ca82959 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -19,6 +19,7 @@
  */
 static struct kmem_cache *iocontext_cachep;
 
+#ifdef CONFIG_BLK_ICQ
 /**
  * get_io_context - increment reference count to io_context
  * @ioc: io_context to get
@@ -162,6 +163,42 @@ static bool ioc_delay_free(struct io_context *ioc)
 	return false;
 }
 
+/**
+ * ioc_clear_queue - break any ioc association with the specified queue
+ * @q: request_queue being cleared
+ *
+ * Walk @q->icq_list and exit all io_cq's.
+ */
+void ioc_clear_queue(struct request_queue *q)
+{
+	LIST_HEAD(icq_list);
+
+	spin_lock_irq(&q->queue_lock);
+	list_splice_init(&q->icq_list, &icq_list);
+	spin_unlock_irq(&q->queue_lock);
+
+	rcu_read_lock();
+	while (!list_empty(&icq_list)) {
+		struct io_cq *icq =
+			list_entry(icq_list.next, struct io_cq, q_node);
+
+		spin_lock_irq(&icq->ioc->lock);
+		if (!(icq->flags & ICQ_DESTROYED))
+			ioc_destroy_icq(icq);
+		spin_unlock_irq(&icq->ioc->lock);
+	}
+	rcu_read_unlock();
+}
+#else /* CONFIG_BLK_ICQ */
+static inline void ioc_exit_icqs(struct io_context *ioc)
+{
+}
+static inline bool ioc_delay_free(struct io_context *ioc)
+{
+	return false;
+}
+#endif /* CONFIG_BLK_ICQ */
+
 /**
  * put_io_context - put a reference of io_context
  * @ioc: io_context to put
@@ -193,33 +230,6 @@ void exit_io_context(struct task_struct *task)
 	}
 }
 
-/**
- * ioc_clear_queue - break any ioc association with the specified queue
- * @q: request_queue being cleared
- *
- * Walk @q->icq_list and exit all io_cq's.
- */
-void ioc_clear_queue(struct request_queue *q)
-{
-	LIST_HEAD(icq_list);
-
-	spin_lock_irq(&q->queue_lock);
-	list_splice_init(&q->icq_list, &icq_list);
-	spin_unlock_irq(&q->queue_lock);
-
-	rcu_read_lock();
-	while (!list_empty(&icq_list)) {
-		struct io_cq *icq =
-			list_entry(icq_list.next, struct io_cq, q_node);
-
-		spin_lock_irq(&icq->ioc->lock);
-		if (!(icq->flags & ICQ_DESTROYED))
-			ioc_destroy_icq(icq);
-		spin_unlock_irq(&icq->ioc->lock);
-	}
-	rcu_read_unlock();
-}
-
 static struct io_context *alloc_io_context(gfp_t gfp_flags, int node)
 {
 	struct io_context *ioc;
@@ -231,10 +241,12 @@ static struct io_context *alloc_io_context(gfp_t gfp_flags, int node)
 
 	atomic_long_set(&ioc->refcount, 1);
 	atomic_set(&ioc->active_ref, 1);
+#ifdef CONFIG_BLK_ICQ
 	spin_lock_init(&ioc->lock);
 	INIT_RADIX_TREE(&ioc->icq_tree, GFP_ATOMIC);
 	INIT_HLIST_HEAD(&ioc->icq_list);
 	INIT_WORK(&ioc->release_work, ioc_release_fn);
+#endif
 	return ioc;
 }
 
@@ -300,6 +312,7 @@ int __copy_io(unsigned long clone_flags, struct task_struct *tsk)
 	return 0;
 }
 
+#ifdef CONFIG_BLK_ICQ
 /**
  * ioc_lookup_icq - lookup io_cq from ioc
  * @q: the associated request_queue
@@ -428,6 +441,7 @@ struct io_cq *ioc_find_get_icq(struct request_queue *q)
 	return icq;
 }
 EXPORT_SYMBOL_GPL(ioc_find_get_icq);
+#endif /* CONFIG_BLK_ICQ */
 
 static int __init blk_ioc_init(void)
 {
diff --git a/block/blk.h b/block/blk.h
index 7ccb7c7d86b38..8bd43b3ad33d5 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -366,7 +366,13 @@ static inline unsigned int bio_aligned_discard_max_sectors(
  */
 struct io_cq *ioc_find_get_icq(struct request_queue *q);
 struct io_cq *ioc_lookup_icq(struct request_queue *q);
+#ifdef CONFIG_BLK_ICQ
 void ioc_clear_queue(struct request_queue *q);
+#else
+static inline void ioc_clear_queue(struct request_queue *q)
+{
+}
+#endif /* CONFIG_BLK_ICQ */
 
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 extern ssize_t blk_throtl_sample_time_show(struct request_queue *q, char *page);
diff --git a/include/linux/iocontext.h b/include/linux/iocontext.h
index 648331f35fc66..14f7eaf1b4437 100644
--- a/include/linux/iocontext.h
+++ b/include/linux/iocontext.h
@@ -100,16 +100,18 @@ struct io_context {
 	atomic_long_t refcount;
 	atomic_t active_ref;
 
+	unsigned short ioprio;
+
+#ifdef CONFIG_BLK_ICQ
 	/* all the fields below are protected by this lock */
 	spinlock_t lock;
 
-	unsigned short ioprio;
-
 	struct radix_tree_root	icq_tree;
 	struct io_cq __rcu	*icq_hint;
 	struct hlist_head	icq_list;
 
 	struct work_struct release_work;
+#endif /* CONFIG_BLK_ICQ */
 };
 
 struct task_struct;
-- 
2.30.2

