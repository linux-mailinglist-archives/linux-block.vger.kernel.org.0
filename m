Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478DE3D9DDA
	for <lists+linux-block@lfdr.de>; Thu, 29 Jul 2021 08:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbhG2GuS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 29 Jul 2021 02:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbhG2GuR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jul 2021 02:50:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE30C061757;
        Wed, 28 Jul 2021 23:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XrLBDon1Dv4zG9RyykaITymZjKWEJkCMoVLyfWPGjKg=; b=Ko2aP9SZlKbnUj2CimGlG6Xvg2
        0yUJTVZth7YbJIGxmGTOpyU7nP0VFFOX8XEI8ZB/9xLgFl3VliufuaOY48P9ORycW561KgIi1OPEP
        AXuwb7ILp/Gdux0pywMu+XU0cUCgCTHMRr94B4v+sKLrXc/rh7DkjoybGjDdki+EJFqzb37DZWx+z
        87cvOJv7dHxRWTzrwIbtkExrC+9JTAwnVNmd99DDhpDyrYIiIQRUACnAsM347Df+Fa3MhWpSgCiph
        OUxx5AR/dbe0rt/jrKr7Ay60o6/VEIifbqoAwOIhpofb7lHTTAYwdIDlMxX5sL98IwfUWE0aKqRqf
        LTKDZ2zA==;
Received: from [2001:4bb8:184:87c5:8c88:c313:79e2:b780] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8zrI-00Gnfh-MI; Thu, 29 Jul 2021 06:49:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 1/4] bsg: simplify device registration
Date:   Thu, 29 Jul 2021 08:48:42 +0200
Message-Id: <20210729064845.1044147-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210729064845.1044147-1-hch@lst.de>
References: <20210729064845.1044147-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the per-device cdev_device_interface to store the bsg data in
the char device inode, and thus remove the need to embedd the
bsg_class_device structure in the request_queue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bsg-lib.c            |  11 +-
 block/bsg.c                | 304 +++++++++----------------------------
 drivers/scsi/scsi_bsg.c    |   5 +-
 drivers/scsi/scsi_priv.h   |  11 +-
 drivers/scsi/scsi_sysfs.c  |  24 ++-
 include/linux/blkdev.h     |   6 -
 include/linux/bsg-lib.h    |   1 +
 include/linux/bsg.h        |  21 +--
 include/scsi/scsi_device.h |   2 +
 9 files changed, 108 insertions(+), 277 deletions(-)

diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index a89d80102304..fe43f5fda6e5 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -6,6 +6,7 @@
  *  Copyright (C) 2011   Red Hat, Inc.  All rights reserved.
  *  Copyright (C) 2011   Mike Christie
  */
+#include <linux/bsg.h>
 #include <linux/slab.h>
 #include <linux/blk-mq.h>
 #include <linux/delay.h>
@@ -19,6 +20,7 @@
 
 struct bsg_set {
 	struct blk_mq_tag_set	tag_set;
+	struct bsg_device	*bd;
 	bsg_job_fn		*job_fn;
 	bsg_timeout_fn		*timeout_fn;
 };
@@ -327,7 +329,7 @@ void bsg_remove_queue(struct request_queue *q)
 		struct bsg_set *bset =
 			container_of(q->tag_set, struct bsg_set, tag_set);
 
-		bsg_unregister_queue(q);
+		bsg_unregister_queue(bset->bd);
 		blk_cleanup_queue(q);
 		blk_mq_free_tag_set(&bset->tag_set);
 		kfree(bset);
@@ -396,10 +398,9 @@ struct request_queue *bsg_setup_queue(struct device *dev, const char *name,
 	q->queuedata = dev;
 	blk_queue_rq_timeout(q, BLK_DEFAULT_SG_TIMEOUT);
 
-	ret = bsg_register_queue(q, dev, name, &bsg_transport_ops);
-	if (ret) {
-		printk(KERN_ERR "%s: bsg interface failed to "
-		       "initialize - register queue\n", dev->kobj.name);
+	bset->bd = bsg_register_queue(q, dev, name, &bsg_transport_ops);
+	if (IS_ERR(bset->bd)) {
+		ret = PTR_ERR(bset->bd);
 		goto out_cleanup_queue;
 	}
 
diff --git a/block/bsg.c b/block/bsg.c
index 3dbfd2c6aef3..83a095185d33 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -20,38 +20,29 @@
 #define BSG_DESCRIPTION	"Block layer SCSI generic (bsg) driver"
 #define BSG_VERSION	"0.4"
 
-#define bsg_dbg(bd, fmt, ...) \
-	pr_debug("%s: " fmt, (bd)->name, ##__VA_ARGS__)
-
 struct bsg_device {
 	struct request_queue *queue;
-	spinlock_t lock;
-	struct hlist_node dev_list;
-	refcount_t ref_count;
-	char name[20];
+	const struct bsg_ops *ops;
+	struct device device;
+	struct cdev cdev;
 	int max_queue;
 };
 
+static inline struct bsg_device *to_bsg_device(struct inode *inode)
+{
+	return container_of(inode->i_cdev, struct bsg_device, cdev);
+}
+
 #define BSG_DEFAULT_CMDS	64
 #define BSG_MAX_DEVS		32768
 
-static DEFINE_MUTEX(bsg_mutex);
-static DEFINE_IDR(bsg_minor_idr);
-
-#define BSG_LIST_ARRAY_SIZE	8
-static struct hlist_head bsg_device_list[BSG_LIST_ARRAY_SIZE];
-
+static DEFINE_IDA(bsg_minor_ida);
 static struct class *bsg_class;
 static int bsg_major;
 
-static inline struct hlist_head *bsg_dev_idx_hash(int index)
-{
-	return &bsg_device_list[index & (BSG_LIST_ARRAY_SIZE - 1)];
-}
-
 #define uptr64(val) ((void __user *)(uintptr_t)(val))
 
-static int bsg_sg_io(struct request_queue *q, fmode_t mode, void __user *uarg)
+static int bsg_sg_io(struct bsg_device *bd, fmode_t mode, void __user *uarg)
 {
 	struct request *rq;
 	struct bio *bio;
@@ -61,21 +52,18 @@ static int bsg_sg_io(struct request_queue *q, fmode_t mode, void __user *uarg)
 	if (copy_from_user(&hdr, uarg, sizeof(hdr)))
 		return -EFAULT;
 
-	if (!q->bsg_dev.class_dev)
-		return -ENXIO;
-
 	if (hdr.guard != 'Q')
 		return -EINVAL;
-	ret = q->bsg_dev.ops->check_proto(&hdr);
+	ret = bd->ops->check_proto(&hdr);
 	if (ret)
 		return ret;
 
-	rq = blk_get_request(q, hdr.dout_xfer_len ?
+	rq = blk_get_request(bd->queue, hdr.dout_xfer_len ?
 			REQ_OP_DRV_OUT : REQ_OP_DRV_IN, 0);
 	if (IS_ERR(rq))
 		return PTR_ERR(rq);
 
-	ret = q->bsg_dev.ops->fill_hdr(rq, &hdr, mode);
+	ret = bd->ops->fill_hdr(rq, &hdr, mode);
 	if (ret) {
 		blk_put_request(rq);
 		return ret;
@@ -83,17 +71,17 @@ static int bsg_sg_io(struct request_queue *q, fmode_t mode, void __user *uarg)
 
 	rq->timeout = msecs_to_jiffies(hdr.timeout);
 	if (!rq->timeout)
-		rq->timeout = q->sg_timeout;
+		rq->timeout = rq->q->sg_timeout;
 	if (!rq->timeout)
 		rq->timeout = BLK_DEFAULT_SG_TIMEOUT;
 	if (rq->timeout < BLK_MIN_SG_TIMEOUT)
 		rq->timeout = BLK_MIN_SG_TIMEOUT;
 
 	if (hdr.dout_xfer_len) {
-		ret = blk_rq_map_user(q, rq, NULL, uptr64(hdr.dout_xferp),
+		ret = blk_rq_map_user(rq->q, rq, NULL, uptr64(hdr.dout_xferp),
 				hdr.dout_xfer_len, GFP_KERNEL);
 	} else if (hdr.din_xfer_len) {
-		ret = blk_rq_map_user(q, rq, NULL, uptr64(hdr.din_xferp),
+		ret = blk_rq_map_user(rq->q, rq, NULL, uptr64(hdr.din_xferp),
 				hdr.din_xfer_len, GFP_KERNEL);
 	}
 
@@ -103,171 +91,50 @@ static int bsg_sg_io(struct request_queue *q, fmode_t mode, void __user *uarg)
 	bio = rq->bio;
 
 	blk_execute_rq(NULL, rq, !(hdr.flags & BSG_FLAG_Q_AT_TAIL));
-	ret = rq->q->bsg_dev.ops->complete_rq(rq, &hdr);
+	ret = bd->ops->complete_rq(rq, &hdr);
 	blk_rq_unmap_user(bio);
 
 out_free_rq:
-	rq->q->bsg_dev.ops->free_rq(rq);
+	bd->ops->free_rq(rq);
 	blk_put_request(rq);
 	if (!ret && copy_to_user(uarg, &hdr, sizeof(hdr)))
 		return -EFAULT;
 	return ret;
 }
 
-static struct bsg_device *bsg_alloc_device(void)
-{
-	struct bsg_device *bd;
-
-	bd = kzalloc(sizeof(struct bsg_device), GFP_KERNEL);
-	if (unlikely(!bd))
-		return NULL;
-
-	spin_lock_init(&bd->lock);
-	bd->max_queue = BSG_DEFAULT_CMDS;
-	INIT_HLIST_NODE(&bd->dev_list);
-	return bd;
-}
-
-static int bsg_put_device(struct bsg_device *bd)
-{
-	struct request_queue *q = bd->queue;
-
-	mutex_lock(&bsg_mutex);
-
-	if (!refcount_dec_and_test(&bd->ref_count)) {
-		mutex_unlock(&bsg_mutex);
-		return 0;
-	}
-
-	hlist_del(&bd->dev_list);
-	mutex_unlock(&bsg_mutex);
-
-	bsg_dbg(bd, "tearing down\n");
-
-	/*
-	 * close can always block
-	 */
-	kfree(bd);
-	blk_put_queue(q);
-	return 0;
-}
-
-static struct bsg_device *bsg_add_device(struct inode *inode,
-					 struct request_queue *rq,
-					 struct file *file)
-{
-	struct bsg_device *bd;
-	unsigned char buf[32];
-
-	lockdep_assert_held(&bsg_mutex);
-
-	if (!blk_get_queue(rq))
-		return ERR_PTR(-ENXIO);
-
-	bd = bsg_alloc_device();
-	if (!bd) {
-		blk_put_queue(rq);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	bd->queue = rq;
-
-	refcount_set(&bd->ref_count, 1);
-	hlist_add_head(&bd->dev_list, bsg_dev_idx_hash(iminor(inode)));
-
-	strncpy(bd->name, dev_name(rq->bsg_dev.class_dev), sizeof(bd->name) - 1);
-	bsg_dbg(bd, "bound to <%s>, max queue %d\n",
-		format_dev_t(buf, inode->i_rdev), bd->max_queue);
-
-	return bd;
-}
-
-static struct bsg_device *__bsg_get_device(int minor, struct request_queue *q)
-{
-	struct bsg_device *bd;
-
-	lockdep_assert_held(&bsg_mutex);
-
-	hlist_for_each_entry(bd, bsg_dev_idx_hash(minor), dev_list) {
-		if (bd->queue == q) {
-			refcount_inc(&bd->ref_count);
-			goto found;
-		}
-	}
-	bd = NULL;
-found:
-	return bd;
-}
-
-static struct bsg_device *bsg_get_device(struct inode *inode, struct file *file)
-{
-	struct bsg_device *bd;
-	struct bsg_class_device *bcd;
-
-	/*
-	 * find the class device
-	 */
-	mutex_lock(&bsg_mutex);
-	bcd = idr_find(&bsg_minor_idr, iminor(inode));
-
-	if (!bcd) {
-		bd = ERR_PTR(-ENODEV);
-		goto out_unlock;
-	}
-
-	bd = __bsg_get_device(iminor(inode), bcd->queue);
-	if (!bd)
-		bd = bsg_add_device(inode, bcd->queue, file);
-
-out_unlock:
-	mutex_unlock(&bsg_mutex);
-	return bd;
-}
-
 static int bsg_open(struct inode *inode, struct file *file)
 {
-	struct bsg_device *bd;
-
-	bd = bsg_get_device(inode, file);
-
-	if (IS_ERR(bd))
-		return PTR_ERR(bd);
-
-	file->private_data = bd;
+	if (!blk_get_queue(to_bsg_device(inode)->queue))
+		return -ENXIO;
 	return 0;
 }
 
 static int bsg_release(struct inode *inode, struct file *file)
 {
-	struct bsg_device *bd = file->private_data;
-
-	file->private_data = NULL;
-	return bsg_put_device(bd);
+	blk_put_queue(to_bsg_device(inode)->queue);
+	return 0;
 }
 
 static int bsg_get_command_q(struct bsg_device *bd, int __user *uarg)
 {
-	return put_user(bd->max_queue, uarg);
+	return put_user(READ_ONCE(bd->max_queue), uarg);
 }
 
 static int bsg_set_command_q(struct bsg_device *bd, int __user *uarg)
 {
-	int queue;
+	int max_queue;
 
-	if (get_user(queue, uarg))
+	if (get_user(max_queue, uarg))
 		return -EFAULT;
-	if (queue < 1)
+	if (max_queue < 1)
 		return -EINVAL;
-
-	spin_lock_irq(&bd->lock);
-	bd->max_queue = queue;
-	spin_unlock_irq(&bd->lock);
+	WRITE_ONCE(bd->max_queue, max_queue);
 	return 0;
 }
 
 static long bsg_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	struct bsg_device *bd = file->private_data;
+	struct bsg_device *bd = to_bsg_device(file_inode(file));
 	struct request_queue *q = bd->queue;
 	void __user *uarg = (void __user *) arg;
 	int __user *intp = uarg;
@@ -312,7 +179,7 @@ static long bsg_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case SG_EMULATED_HOST:
 		return put_user(1, intp);
 	case SG_IO:
-		return bsg_sg_io(q, file->f_mode, uarg);
+		return bsg_sg_io(bd, file->f_mode, uarg);
 	case SCSI_IOCTL_SEND_COMMAND:
 		pr_warn_ratelimited("%s: calling unsupported SCSI_IOCTL_SEND_COMMAND\n",
 				current->comm);
@@ -331,83 +198,66 @@ static const struct file_operations bsg_fops = {
 	.llseek		=	default_llseek,
 };
 
-void bsg_unregister_queue(struct request_queue *q)
+void bsg_unregister_queue(struct bsg_device *bd)
 {
-	struct bsg_class_device *bcd = &q->bsg_dev;
-
-	if (!bcd->class_dev)
-		return;
-
-	mutex_lock(&bsg_mutex);
-	idr_remove(&bsg_minor_idr, bcd->minor);
-	if (q->kobj.sd)
-		sysfs_remove_link(&q->kobj, "bsg");
-	device_unregister(bcd->class_dev);
-	bcd->class_dev = NULL;
-	mutex_unlock(&bsg_mutex);
+	if (bd->queue->kobj.sd)
+		sysfs_remove_link(&bd->queue->kobj, "bsg");
+	cdev_device_del(&bd->cdev, &bd->device);
+	ida_simple_remove(&bsg_minor_ida, MINOR(bd->device.devt));
+	kfree(bd);
 }
 EXPORT_SYMBOL_GPL(bsg_unregister_queue);
 
-int bsg_register_queue(struct request_queue *q, struct device *parent,
-		const char *name, const struct bsg_ops *ops)
+struct bsg_device *bsg_register_queue(struct request_queue *q,
+		struct device *parent, const char *name,
+		const struct bsg_ops *ops)
 {
-	struct bsg_class_device *bcd;
-	dev_t dev;
+	struct bsg_device *bd;
 	int ret;
-	struct device *class_dev = NULL;
-
-	/*
-	 * we need a proper transport to send commands, not a stacked device
-	 */
-	if (!queue_is_mq(q))
-		return 0;
 
-	bcd = &q->bsg_dev;
-	memset(bcd, 0, sizeof(*bcd));
-
-	mutex_lock(&bsg_mutex);
+	bd = kzalloc(sizeof(*bd), GFP_KERNEL);
+	if (!bd)
+		return ERR_PTR(-ENOMEM);
+	bd->max_queue = BSG_DEFAULT_CMDS;
+	bd->queue = q;
+	bd->ops = ops;
 
-	ret = idr_alloc(&bsg_minor_idr, bcd, 0, BSG_MAX_DEVS, GFP_KERNEL);
+	ret = ida_simple_get(&bsg_minor_ida, 0, BSG_MAX_DEVS, GFP_KERNEL);
 	if (ret < 0) {
-		if (ret == -ENOSPC) {
-			printk(KERN_ERR "bsg: too many bsg devices\n");
-			ret = -EINVAL;
-		}
-		goto unlock;
-	}
-
-	bcd->minor = ret;
-	bcd->queue = q;
-	bcd->ops = ops;
-	dev = MKDEV(bsg_major, bcd->minor);
-	class_dev = device_create(bsg_class, parent, dev, NULL, "%s", name);
-	if (IS_ERR(class_dev)) {
-		ret = PTR_ERR(class_dev);
-		goto idr_remove;
+		if (ret == -ENOSPC)
+			dev_err(parent, "bsg: too many bsg devices\n");
+		goto out_kfree;
 	}
-	bcd->class_dev = class_dev;
+	bd->device.devt = MKDEV(bsg_major, ret);
+	bd->device.class = bsg_class;
+	bd->device.parent = parent;
+	dev_set_name(&bd->device, "%s", name);
+	device_initialize(&bd->device);
+
+	cdev_init(&bd->cdev, &bsg_fops);
+	bd->cdev.owner = THIS_MODULE;
+	ret = cdev_device_add(&bd->cdev, &bd->device);
+	if (ret)
+		goto out_ida_remove;
 
 	if (q->kobj.sd) {
-		ret = sysfs_create_link(&q->kobj, &bcd->class_dev->kobj, "bsg");
+		ret = sysfs_create_link(&q->kobj, &bd->device.kobj, "bsg");
 		if (ret)
-			goto unregister_class_dev;
+			goto out_device_del;
 	}
 
-	mutex_unlock(&bsg_mutex);
-	return 0;
+	return bd;
 
-unregister_class_dev:
-	device_unregister(class_dev);
-idr_remove:
-	idr_remove(&bsg_minor_idr, bcd->minor);
-unlock:
-	mutex_unlock(&bsg_mutex);
-	return ret;
+out_device_del:
+	cdev_device_del(&bd->cdev, &bd->device);
+out_ida_remove:
+	ida_simple_remove(&bsg_minor_ida, MINOR(bd->device.devt));
+out_kfree:
+	kfree(bd);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(bsg_register_queue);
 
-static struct cdev bsg_cdev;
-
 static char *bsg_devnode(struct device *dev, umode_t *mode)
 {
 	return kasprintf(GFP_KERNEL, "bsg/%s", dev_name(dev));
@@ -415,11 +265,8 @@ static char *bsg_devnode(struct device *dev, umode_t *mode)
 
 static int __init bsg_init(void)
 {
-	int ret, i;
 	dev_t devid;
-
-	for (i = 0; i < BSG_LIST_ARRAY_SIZE; i++)
-		INIT_HLIST_HEAD(&bsg_device_list[i]);
+	int ret;
 
 	bsg_class = class_create(THIS_MODULE, "bsg");
 	if (IS_ERR(bsg_class))
@@ -429,19 +276,12 @@ static int __init bsg_init(void)
 	ret = alloc_chrdev_region(&devid, 0, BSG_MAX_DEVS, "bsg");
 	if (ret)
 		goto destroy_bsg_class;
-
 	bsg_major = MAJOR(devid);
 
-	cdev_init(&bsg_cdev, &bsg_fops);
-	ret = cdev_add(&bsg_cdev, MKDEV(bsg_major, 0), BSG_MAX_DEVS);
-	if (ret)
-		goto unregister_chrdev;
-
 	printk(KERN_INFO BSG_DESCRIPTION " version " BSG_VERSION
 	       " loaded (major %d)\n", bsg_major);
 	return 0;
-unregister_chrdev:
-	unregister_chrdev_region(MKDEV(bsg_major, 0), BSG_MAX_DEVS);
+
 destroy_bsg_class:
 	class_destroy(bsg_class);
 	return ret;
diff --git a/drivers/scsi/scsi_bsg.c b/drivers/scsi/scsi_bsg.c
index 68f60316adf1..c0d41c45c2be 100644
--- a/drivers/scsi/scsi_bsg.c
+++ b/drivers/scsi/scsi_bsg.c
@@ -89,7 +89,8 @@ static const struct bsg_ops scsi_bsg_ops = {
 	.free_rq		= scsi_bsg_free_rq,
 };
 
-int scsi_bsg_register_queue(struct request_queue *q, struct device *parent)
+struct bsg_device *scsi_bsg_register_queue(struct scsi_device *sdev)
 {
-	return bsg_register_queue(q, parent, dev_name(parent), &scsi_bsg_ops);
+	return bsg_register_queue(sdev->request_queue, &sdev->sdev_gendev,
+				  dev_name(&sdev->sdev_gendev), &scsi_bsg_ops);
 }
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 0a0db35bab04..6d9152031a40 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -7,6 +7,7 @@
 #include <scsi/scsi_device.h>
 #include <linux/sbitmap.h>
 
+struct bsg_device;
 struct request_queue;
 struct request;
 struct scsi_cmnd;
@@ -180,15 +181,7 @@ static inline void scsi_dh_add_device(struct scsi_device *sdev) { }
 static inline void scsi_dh_release_device(struct scsi_device *sdev) { }
 #endif
 
-#ifdef CONFIG_BLK_DEV_BSG
-int scsi_bsg_register_queue(struct request_queue *q, struct device *parent);
-#else
-static inline int scsi_bsg_register_queue(struct request_queue *q,
-		struct device *parent)
-{
-	return 0;
-}
-#endif
+struct bsg_device *scsi_bsg_register_queue(struct scsi_device *sdev);
 
 extern int scsi_device_max_queue_depth(struct scsi_device *sdev);
 
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 4ff9ac3296d8..07cee8dc4100 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -13,6 +13,7 @@
 #include <linux/blkdev.h>
 #include <linux/device.h>
 #include <linux/pm_runtime.h>
+#include <linux/bsg.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_device.h>
@@ -1327,7 +1328,6 @@ static int scsi_target_add(struct scsi_target *starget)
 int scsi_sysfs_add_sdev(struct scsi_device *sdev)
 {
 	int error, i;
-	struct request_queue *rq = sdev->request_queue;
 	struct scsi_target *starget = sdev->sdev_target;
 
 	error = scsi_target_add(starget);
@@ -1366,12 +1366,19 @@ int scsi_sysfs_add_sdev(struct scsi_device *sdev)
 	transport_add_device(&sdev->sdev_gendev);
 	sdev->is_visible = 1;
 
-	error = scsi_bsg_register_queue(rq, &sdev->sdev_gendev);
-	if (error)
-		/* we're treating error on bsg register as non-fatal,
-		 * so pretend nothing went wrong */
-		sdev_printk(KERN_INFO, sdev,
-			    "Failed to register bsg queue, errno=%d\n", error);
+	if (IS_ENABLED(CONFIG_BLK_DEV_BSG)) {
+		sdev->bsg_dev = scsi_bsg_register_queue(sdev);
+		if (IS_ERR(sdev->bsg_dev)) {
+			/*
+			 * We're treating error on bsg register as non-fatal, so
+			 * pretend nothing went wrong.
+			 */
+			sdev_printk(KERN_INFO, sdev,
+				    "Failed to register bsg queue, errno=%d\n",
+				    error);
+			sdev->bsg_dev = NULL;
+		}
+	}
 
 	/* add additional host specific attributes */
 	if (sdev->host->hostt->sdev_attrs) {
@@ -1433,7 +1440,8 @@ void __scsi_remove_device(struct scsi_device *sdev)
 			sysfs_remove_groups(&sdev->sdev_gendev.kobj,
 					sdev->host->hostt->sdev_groups);
 
-		bsg_unregister_queue(sdev->request_queue);
+		if (IS_ENABLED(CONFIG_BLK_DEV_BSG) && sdev->bsg_dev)
+			bsg_unregister_queue(sdev->bsg_dev);
 		device_unregister(&sdev->sdev_dev);
 		transport_remove_device(dev);
 		device_del(dev);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8c617a5a5d61..28957ccdd9c2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -18,7 +18,6 @@
 #include <linux/bio.h>
 #include <linux/stringify.h>
 #include <linux/gfp.h>
-#include <linux/bsg.h>
 #include <linux/smp.h>
 #include <linux/rcupdate.h>
 #include <linux/percpu-refcount.h>
@@ -33,7 +32,6 @@ struct elevator_queue;
 struct blk_trace;
 struct request;
 struct sg_io_hdr;
-struct bsg_job;
 struct blkcg_gq;
 struct blk_flush_queue;
 struct pr_ops;
@@ -535,10 +533,6 @@ struct request_queue {
 
 	int			mq_freeze_depth;
 
-#if IS_ENABLED(CONFIG_BLK_DEV_BSG_COMMON)
-	struct bsg_class_device bsg_dev;
-#endif
-
 #ifdef CONFIG_BLK_DEV_THROTTLING
 	/* Throttle data */
 	struct throtl_data *td;
diff --git a/include/linux/bsg-lib.h b/include/linux/bsg-lib.h
index 960988d42f77..6b211323a489 100644
--- a/include/linux/bsg-lib.h
+++ b/include/linux/bsg-lib.h
@@ -12,6 +12,7 @@
 #include <linux/blkdev.h>
 #include <scsi/scsi_request.h>
 
+struct bsg_job;
 struct request;
 struct device;
 struct scatterlist;
diff --git a/include/linux/bsg.h b/include/linux/bsg.h
index b887da20bd41..fa21f79beda2 100644
--- a/include/linux/bsg.h
+++ b/include/linux/bsg.h
@@ -4,10 +4,11 @@
 
 #include <uapi/linux/bsg.h>
 
+struct bsg_device;
+struct device;
 struct request;
 struct request_queue;
 
-#ifdef CONFIG_BLK_DEV_BSG_COMMON
 struct bsg_ops {
 	int	(*check_proto)(struct sg_io_v4 *hdr);
 	int	(*fill_hdr)(struct request *rq, struct sg_io_v4 *hdr,
@@ -16,19 +17,9 @@ struct bsg_ops {
 	void	(*free_rq)(struct request *rq);
 };
 
-struct bsg_class_device {
-	struct device *class_dev;
-	int minor;
-	struct request_queue *queue;
-	const struct bsg_ops *ops;
-};
+struct bsg_device *bsg_register_queue(struct request_queue *q,
+		struct device *parent, const char *name,
+		const struct bsg_ops *ops);
+void bsg_unregister_queue(struct bsg_device *bcd);
 
-int bsg_register_queue(struct request_queue *q, struct device *parent,
-		const char *name, const struct bsg_ops *ops);
-void bsg_unregister_queue(struct request_queue *q);
-#else
-static inline void bsg_unregister_queue(struct request_queue *q)
-{
-}
-#endif /* CONFIG_BLK_DEV_BSG_COMMON */
 #endif /* _LINUX_BSG_H */
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index d1de21f799f4..99082da1b951 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -10,6 +10,7 @@
 #include <linux/atomic.h>
 #include <linux/sbitmap.h>
 
+struct bsg_device;
 struct device;
 struct request_queue;
 struct scsi_cmnd;
@@ -235,6 +236,7 @@ struct scsi_device {
 	size_t			dma_drain_len;
 	void			*dma_drain_buf;
 
+	struct bsg_device	*bsg_dev;
 	unsigned char		access_state;
 	struct mutex		state_mutex;
 	enum scsi_device_state sdev_state;
-- 
2.30.2

