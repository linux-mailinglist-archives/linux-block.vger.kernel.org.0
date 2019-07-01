Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18558599DA
	for <lists+linux-block@lfdr.de>; Fri, 28 Jun 2019 14:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfF1MBo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 28 Jun 2019 08:01:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:54764 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726574AbfF1MBo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 08:01:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D5F49B62B;
        Fri, 28 Jun 2019 12:01:42 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 23/37] bcache: avoid a deadlock in bcache_reboot()
Date:   Fri, 28 Jun 2019 19:59:46 +0800
Message-Id: <20190628120000.40753-24-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190628120000.40753-1-colyli@suse.de>
References: <20190628120000.40753-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is quite frequently to observe deadlock in bcache_reboot() happens
and hang the system reboot process. The reason is, in bcache_reboot()
when calling bch_cache_set_stop() and bcache_device_stop() the mutex
bch_register_lock is held. But in the process to stop cache set and
bcache device, bch_register_lock will be acquired again. If this mutex
is held here, deadlock will happen inside the stopping process. The
aftermath of the deadlock is, whole system reboot gets hung.

The fix is to avoid holding bch_register_lock for the following loops
in bcache_reboot(),
       list_for_each_entry_safe(c, tc, &bch_cache_sets, list)
                bch_cache_set_stop(c);

        list_for_each_entry_safe(dc, tdc, &uncached_devices, list)
                bcache_device_stop(&dc->disk);

A module range variable 'bcache_is_reboot' is added, it sets to true
in bcache_reboot(). In register_bcache(), if bcache_is_reboot is checked
to be true, reject the registration by returning -EBUSY immediately.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 40 +++++++++++++++++++++++++++++++++++++++-
 drivers/md/bcache/sysfs.c | 26 ++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 791cb930b353..a88238ad5da1 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -40,6 +40,7 @@ static const char invalid_uuid[] = {
 
 static struct kobject *bcache_kobj;
 struct mutex bch_register_lock;
+bool bcache_is_reboot;
 LIST_HEAD(bch_cache_sets);
 static LIST_HEAD(uncached_devices);
 
@@ -49,6 +50,7 @@ static wait_queue_head_t unregister_wait;
 struct workqueue_struct *bcache_wq;
 struct workqueue_struct *bch_journal_wq;
 
+
 #define BTREE_MAX_PAGES		(256 * 1024 / PAGE_SIZE)
 /* limitation of partitions number on single bcache device */
 #define BCACHE_MINORS		128
@@ -2335,6 +2337,11 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 	if (!try_module_get(THIS_MODULE))
 		return -EBUSY;
 
+	/* For latest state of bcache_is_reboot */
+	smp_mb();
+	if (bcache_is_reboot)
+		return -EBUSY;
+
 	path = kstrndup(buffer, size, GFP_KERNEL);
 	if (!path)
 		goto err;
@@ -2464,6 +2471,9 @@ static ssize_t bch_pending_bdevs_cleanup(struct kobject *k,
 
 static int bcache_reboot(struct notifier_block *n, unsigned long code, void *x)
 {
+	if (bcache_is_reboot)
+		return NOTIFY_DONE;
+
 	if (code == SYS_DOWN ||
 	    code == SYS_HALT ||
 	    code == SYS_POWER_OFF) {
@@ -2476,19 +2486,45 @@ static int bcache_reboot(struct notifier_block *n, unsigned long code, void *x)
 
 		mutex_lock(&bch_register_lock);
 
+		if (bcache_is_reboot)
+			goto out;
+
+		/* New registration is rejected since now */
+		bcache_is_reboot = true;
+		/*
+		 * Make registering caller (if there is) on other CPU
+		 * core know bcache_is_reboot set to true earlier
+		 */
+		smp_mb();
+
 		if (list_empty(&bch_cache_sets) &&
 		    list_empty(&uncached_devices))
 			goto out;
 
+		mutex_unlock(&bch_register_lock);
+
 		pr_info("Stopping all devices:");
 
+		/*
+		 * The reason bch_register_lock is not held to call
+		 * bch_cache_set_stop() and bcache_device_stop() is to
+		 * avoid potential deadlock during reboot, because cache
+		 * set or bcache device stopping process will acqurie
+		 * bch_register_lock too.
+		 *
+		 * We are safe here because bcache_is_reboot sets to
+		 * true already, register_bcache() will reject new
+		 * registration now. bcache_is_reboot also makes sure
+		 * bcache_reboot() won't be re-entered on by other thread,
+		 * so there is no race in following list iteration by
+		 * list_for_each_entry_safe().
+		 */
 		list_for_each_entry_safe(c, tc, &bch_cache_sets, list)
 			bch_cache_set_stop(c);
 
 		list_for_each_entry_safe(dc, tdc, &uncached_devices, list)
 			bcache_device_stop(&dc->disk);
 
-		mutex_unlock(&bch_register_lock);
 
 		/*
 		 * Give an early chance for other kthreads and
@@ -2616,6 +2652,8 @@ static int __init bcache_init(void)
 	bch_debug_init();
 	closure_debug_init();
 
+	bcache_is_reboot = false;
+
 	return 0;
 err:
 	bcache_exit();
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index dddb8d4048ce..d62e28643109 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -16,6 +16,8 @@
 #include <linux/sort.h>
 #include <linux/sched/clock.h>
 
+extern bool bcache_is_reboot;
+
 /* Default is 0 ("writethrough") */
 static const char * const bch_cache_modes[] = {
 	"writethrough",
@@ -267,6 +269,10 @@ STORE(__cached_dev)
 	struct cache_set *c;
 	struct kobj_uevent_env *env;
 
+	/* no user space access if system is rebooting */
+	if (bcache_is_reboot)
+		return -EBUSY;
+
 #define d_strtoul(var)		sysfs_strtoul(var, dc->var)
 #define d_strtoul_nonzero(var)	sysfs_strtoul_clamp(var, dc->var, 1, INT_MAX)
 #define d_strtoi_h(var)		sysfs_hatoi(var, dc->var)
@@ -407,6 +413,10 @@ STORE(bch_cached_dev)
 	struct cached_dev *dc = container_of(kobj, struct cached_dev,
 					     disk.kobj);
 
+	/* no user space access if system is rebooting */
+	if (bcache_is_reboot)
+		return -EBUSY;
+
 	mutex_lock(&bch_register_lock);
 	size = __cached_dev_store(kobj, attr, buf, size);
 
@@ -510,6 +520,10 @@ STORE(__bch_flash_dev)
 					       kobj);
 	struct uuid_entry *u = &d->c->uuids[d->id];
 
+	/* no user space access if system is rebooting */
+	if (bcache_is_reboot)
+		return -EBUSY;
+
 	sysfs_strtoul(data_csum,	d->data_csum);
 
 	if (attr == &sysfs_size) {
@@ -745,6 +759,10 @@ STORE(__bch_cache_set)
 	struct cache_set *c = container_of(kobj, struct cache_set, kobj);
 	ssize_t v;
 
+	/* no user space access if system is rebooting */
+	if (bcache_is_reboot)
+		return -EBUSY;
+
 	if (attr == &sysfs_unregister)
 		bch_cache_set_unregister(c);
 
@@ -864,6 +882,10 @@ STORE(bch_cache_set_internal)
 {
 	struct cache_set *c = container_of(kobj, struct cache_set, internal);
 
+	/* no user space access if system is rebooting */
+	if (bcache_is_reboot)
+		return -EBUSY;
+
 	return bch_cache_set_store(&c->kobj, attr, buf, size);
 }
 
@@ -1049,6 +1071,10 @@ STORE(__bch_cache)
 	struct cache *ca = container_of(kobj, struct cache, kobj);
 	ssize_t v;
 
+	/* no user space access if system is rebooting */
+	if (bcache_is_reboot)
+		return -EBUSY;
+
 	if (attr == &sysfs_discard) {
 		bool v = strtoul_or_return(buf);
 
-- 
2.16.4

