Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878791E36D1
	for <lists+linux-block@lfdr.de>; Wed, 27 May 2020 06:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgE0EDM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 27 May 2020 00:03:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:57420 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbgE0EDL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 00:03:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 79A93AE2C;
        Wed, 27 May 2020 04:03:12 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH v2 4/5] bcache: asynchronous devices registration
Date:   Wed, 27 May 2020 12:01:54 +0800
Message-Id: <20200527040155.43690-5-colyli@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200527040155.43690-1-colyli@suse.de>
References: <20200527040155.43690-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When there is a lot of data cached on cache device, the bcach internal
btree can take a very long to validate during the backing device and
cache device registration. In my test, it may takes 55+ minutes to check
all the internal btree nodes.

The problem is that the registration is invoked by udev rules and the
udevd has 180 seconds timeout by default. If the btree node checking
time is longer than udevd timeout, the registering  process will be
killed by udevd with SIGKILL. If the registering process has pending
sigal, creating kthread for bcache will fail and the device registration
will fail. The result is, for bcache device which cached a lot of data
on cache device, the bcache device node like /dev/bcache<N> won't create
always due to the very long btree checking time.

A solution to avoid the udevd 180 seconds timeout is to register devices
in an asynchronous way. Which is, after writing cache or backing device
path into /sys/fs/bcache/register_async, the kernel code will create a
kworker and move all the btree node checking (for cache device) or dirty
data counting (for cached device) in the kwork context. Then the kworder
is scheduled on system_wq and the registration code just returned to
user space udev rule task. By this asynchronous way, the udev task for
bcache rule will complete in seconds, no matter how long time spent in
the kworker context, it won't be killed by udevd for a timeout.

After all the checking and counting are done asynchronously in the
kworker, the bcache device will eventually be created successfully.

This patch does the above chagne and add a register sysfs file
/sys/fs/bcache/register_async. Writing the registering device path into
this sysfs file will do the asynchronous registration.

The register_async interface is for very rare condition and won't be
used for common users. In future I plan to make the asynchronous
registration as default behavior, which depends on feedback for this
patch.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 100 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index a10a3c78f4ff..b971d8e916d5 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2327,6 +2327,7 @@ static ssize_t bch_pending_bdevs_cleanup(struct kobject *k,
 
 kobj_attribute_write(register,		register_bcache);
 kobj_attribute_write(register_quiet,	register_bcache);
+kobj_attribute_write(register_async,	register_bcache);
 kobj_attribute_write(pendings_cleanup,	bch_pending_bdevs_cleanup);
 
 static bool bch_is_open_backing(struct block_device *bdev)
@@ -2362,6 +2363,83 @@ static bool bch_is_open(struct block_device *bdev)
 	return bch_is_open_cache(bdev) || bch_is_open_backing(bdev);
 }
 
+struct async_reg_args {
+	struct work_struct reg_work;
+	char *path;
+	struct cache_sb *sb;
+	struct cache_sb_disk *sb_disk;
+	struct block_device *bdev;
+};
+
+static void register_bdev_worker(struct work_struct *work)
+{
+	int fail = false;
+	struct async_reg_args *args =
+		container_of(work, struct async_reg_args, reg_work);
+	struct cached_dev *dc;
+
+	dc = kzalloc(sizeof(*dc), GFP_KERNEL);
+	if (!dc) {
+		fail = true;
+		put_page(virt_to_page(args->sb_disk));
+		blkdev_put(args->bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
+		goto out;
+	}
+
+	mutex_lock(&bch_register_lock);
+	if (register_bdev(args->sb, args->sb_disk, args->bdev, dc) < 0)
+		fail = true;
+	mutex_unlock(&bch_register_lock);
+
+out:
+	if (fail)
+		pr_info("error %s: fail to register backing device\n",
+			args->path);
+	kfree(args->sb);
+	kfree(args->path);
+	kfree(args);
+	module_put(THIS_MODULE);
+}
+
+static void register_cache_worker(struct work_struct *work)
+{
+	int fail = false;
+	struct async_reg_args *args =
+		container_of(work, struct async_reg_args, reg_work);
+	struct cache *ca;
+
+	ca = kzalloc(sizeof(*ca), GFP_KERNEL);
+	if (!ca) {
+		fail = true;
+		put_page(virt_to_page(args->sb_disk));
+		blkdev_put(args->bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
+		goto out;
+	}
+
+	/* blkdev_put() will be called in bch_cache_release() */
+	if (register_cache(args->sb, args->sb_disk, args->bdev, ca) != 0)
+		fail = true;
+
+out:
+	if (fail)
+		pr_info("error %s: fail to register cache device\n",
+			args->path);
+	kfree(args->sb);
+	kfree(args->path);
+	kfree(args);
+	module_put(THIS_MODULE);
+}
+
+static void register_device_aync(struct async_reg_args *args)
+{
+	if (SB_IS_BDEV(args->sb))
+		INIT_WORK(&args->reg_work, register_bdev_worker);
+	else
+		INIT_WORK(&args->reg_work, register_cache_worker);
+
+	queue_work(system_wq, &args->reg_work);
+}
+
 static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 			       const char *buffer, size_t size)
 {
@@ -2424,6 +2502,26 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 		goto out_blkdev_put;
 
 	err = "failed to register device";
+	if (attr == &ksysfs_register_async) {
+		/* register in asynchronous way */
+		struct async_reg_args *args =
+			kzalloc(sizeof(struct async_reg_args), GFP_KERNEL);
+
+		if (!args) {
+			ret = -ENOMEM;
+			err = "cannot allocate memory";
+			goto out_put_sb_page;
+		}
+
+		args->path	= path;
+		args->sb	= sb;
+		args->sb_disk	= sb_disk;
+		args->bdev	= bdev;
+		register_device_aync(args);
+		/* No wait and returns to user space */
+		goto async_done;
+	}
+
 	if (SB_IS_BDEV(sb)) {
 		struct cached_dev *dc = kzalloc(sizeof(*dc), GFP_KERNEL);
 
@@ -2451,6 +2549,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 	kfree(sb);
 	kfree(path);
 	module_put(THIS_MODULE);
+async_done:
 	return size;
 
 out_put_sb_page:
@@ -2666,6 +2765,7 @@ static int __init bcache_init(void)
 	static const struct attribute *files[] = {
 		&ksysfs_register.attr,
 		&ksysfs_register_quiet.attr,
+		&ksysfs_register_async.attr,
 		&ksysfs_pendings_cleanup.attr,
 		NULL
 	};
-- 
2.25.0

