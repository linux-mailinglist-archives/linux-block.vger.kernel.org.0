Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B544834AA
	for <lists+linux-block@lfdr.de>; Mon,  3 Jan 2022 17:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbiACQYO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 3 Jan 2022 11:24:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59238 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiACQYO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Jan 2022 11:24:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 346886114A;
        Mon,  3 Jan 2022 16:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B453C36AEB;
        Mon,  3 Jan 2022 16:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641227053;
        bh=ZpPAlBJcc3DZqp5X0mPY52nCNgGaZNTEWY4IM4UoSLE=;
        h=From:To:Cc:Subject:Date:From;
        b=rodw9dbRmhNY8eCt1HQnqyGzCtkqqhvemZ/Ddjj19bZ6ny1aPCyu/qmCYtspuXSW6
         X7IuIW2SCZ7Bc80A0FtL8KLxlRHFEwDGWZgArW4RpQ0pMh7aSHT7c6xryO3YP5BZmB
         7saorrapxcuvnUkHf5n60HFuZYvmcO8C2P34rGlA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] pktcdvd: convert to use attribute groups
Date:   Mon,  3 Jan 2022 17:24:08 +0100
Message-Id: <20220103162408.742003-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11936; h=from:subject; bh=ZpPAlBJcc3DZqp5X0mPY52nCNgGaZNTEWY4IM4UoSLE=; b=owGbwMvMwCRo6H6F97bub03G02pJDImXlVUzVp87KBNm5JzrtU1vZ9TSBRxmE0wr/hte4l5ZLqsW NyulI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACZy/wPDgh1yjGw6Ac4SD6q+Fp2wNs vfcj3alGHBmhmLNQr5N2z6tHHWtY4/arJmE4/rAQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no need to create kobject children of the pktcdvd device just
to display a subdirectory name.  Instead, use a named attribute group
which removes the extra kobjects and also fixes the userspace race where
the device is created yet tools like libudev can not see the attributes
as they think the subdirectories are some other sort of device.

Cc: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/pktcdvd.c | 275 ++++++++++++++++++++--------------------
 include/linux/pktcdvd.h |  10 --
 2 files changed, 134 insertions(+), 151 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index b53f648302c1..435e20f892f1 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -113,57 +113,10 @@ static sector_t get_zone(sector_t sector, struct pktcdvd_device *pd)
 	return (sector + pd->offset) & ~(sector_t)(pd->settings.size - 1);
 }
 
-/*
- * create and register a pktcdvd kernel object.
- */
-static struct pktcdvd_kobj* pkt_kobj_create(struct pktcdvd_device *pd,
-					const char* name,
-					struct kobject* parent,
-					struct kobj_type* ktype)
-{
-	struct pktcdvd_kobj *p;
-	int error;
-
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return NULL;
-	p->pd = pd;
-	error = kobject_init_and_add(&p->kobj, ktype, parent, "%s", name);
-	if (error) {
-		kobject_put(&p->kobj);
-		return NULL;
-	}
-	kobject_uevent(&p->kobj, KOBJ_ADD);
-	return p;
-}
-/*
- * remove a pktcdvd kernel object.
- */
-static void pkt_kobj_remove(struct pktcdvd_kobj *p)
-{
-	if (p)
-		kobject_put(&p->kobj);
-}
-/*
- * default release function for pktcdvd kernel objects.
- */
-static void pkt_kobj_release(struct kobject *kobj)
-{
-	kfree(to_pktcdvdkobj(kobj));
-}
-
-
 /**********************************************************
- *
  * sysfs interface for pktcdvd
  * by (C) 2006  Thomas Maier <balagi@justmail.de>
- *
- **********************************************************/
-
-#define DEF_ATTR(_obj,_name,_mode) \
-	static struct attribute _obj = { .name = _name, .mode = _mode }
-
-/**********************************************************
+ 
   /sys/class/pktcdvd/pktcdvd[0-7]/
                      stat/reset
                      stat/packets_started
@@ -176,75 +129,94 @@ static void pkt_kobj_release(struct kobject *kobj)
                      write_queue/congestion_on
  **********************************************************/
 
-DEF_ATTR(kobj_pkt_attr_st1, "reset", 0200);
-DEF_ATTR(kobj_pkt_attr_st2, "packets_started", 0444);
-DEF_ATTR(kobj_pkt_attr_st3, "packets_finished", 0444);
-DEF_ATTR(kobj_pkt_attr_st4, "kb_written", 0444);
-DEF_ATTR(kobj_pkt_attr_st5, "kb_read", 0444);
-DEF_ATTR(kobj_pkt_attr_st6, "kb_read_gather", 0444);
-
-static struct attribute *kobj_pkt_attrs_stat[] = {
-	&kobj_pkt_attr_st1,
-	&kobj_pkt_attr_st2,
-	&kobj_pkt_attr_st3,
-	&kobj_pkt_attr_st4,
-	&kobj_pkt_attr_st5,
-	&kobj_pkt_attr_st6,
-	NULL
-};
+static ssize_t packets_started_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct pktcdvd_device *pd = dev_get_drvdata(dev);
 
-DEF_ATTR(kobj_pkt_attr_wq1, "size", 0444);
-DEF_ATTR(kobj_pkt_attr_wq2, "congestion_off", 0644);
-DEF_ATTR(kobj_pkt_attr_wq3, "congestion_on",  0644);
+	return sysfs_emit(buf, "%lu\n", pd->stats.pkt_started);
+}
+static DEVICE_ATTR_RO(packets_started);
 
-static struct attribute *kobj_pkt_attrs_wqueue[] = {
-	&kobj_pkt_attr_wq1,
-	&kobj_pkt_attr_wq2,
-	&kobj_pkt_attr_wq3,
-	NULL
-};
+static ssize_t packets_finished_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct pktcdvd_device *pd = dev_get_drvdata(dev);
 
-static ssize_t kobj_pkt_show(struct kobject *kobj,
-			struct attribute *attr, char *data)
+	return sysfs_emit(buf, "%lu\n", pd->stats.pkt_ended);
+}
+static DEVICE_ATTR_RO(packets_finished);
+
+static ssize_t kb_written_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
-	struct pktcdvd_device *pd = to_pktcdvdkobj(kobj)->pd;
-	int n = 0;
-	int v;
-	if (strcmp(attr->name, "packets_started") == 0) {
-		n = sprintf(data, "%lu\n", pd->stats.pkt_started);
+	struct pktcdvd_device *pd = dev_get_drvdata(dev);
 
-	} else if (strcmp(attr->name, "packets_finished") == 0) {
-		n = sprintf(data, "%lu\n", pd->stats.pkt_ended);
+	return sysfs_emit(buf, "%lu\n", pd->stats.secs_w >> 1);
+}
+static DEVICE_ATTR_RO(kb_written);
 
-	} else if (strcmp(attr->name, "kb_written") == 0) {
-		n = sprintf(data, "%lu\n", pd->stats.secs_w >> 1);
+static ssize_t kb_read_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct pktcdvd_device *pd = dev_get_drvdata(dev);
 
-	} else if (strcmp(attr->name, "kb_read") == 0) {
-		n = sprintf(data, "%lu\n", pd->stats.secs_r >> 1);
+	return sysfs_emit(buf, "%lu\n", pd->stats.secs_r >> 1);
+}
+static DEVICE_ATTR_RO(kb_read);
 
-	} else if (strcmp(attr->name, "kb_read_gather") == 0) {
-		n = sprintf(data, "%lu\n", pd->stats.secs_rg >> 1);
+static ssize_t kb_read_gather_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct pktcdvd_device *pd = dev_get_drvdata(dev);
 
-	} else if (strcmp(attr->name, "size") == 0) {
-		spin_lock(&pd->lock);
-		v = pd->bio_queue_size;
-		spin_unlock(&pd->lock);
-		n = sprintf(data, "%d\n", v);
+	return sysfs_emit(buf, "%lu\n", pd->stats.secs_rg >> 1);
+}
+static DEVICE_ATTR_RO(kb_read_gather);
 
-	} else if (strcmp(attr->name, "congestion_off") == 0) {
-		spin_lock(&pd->lock);
-		v = pd->write_congestion_off;
-		spin_unlock(&pd->lock);
-		n = sprintf(data, "%d\n", v);
+static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t len)
+{
+	struct pktcdvd_device *pd = dev_get_drvdata(dev);
 
-	} else if (strcmp(attr->name, "congestion_on") == 0) {
-		spin_lock(&pd->lock);
-		v = pd->write_congestion_on;
-		spin_unlock(&pd->lock);
-		n = sprintf(data, "%d\n", v);
+	if (len > 0) {
+		pd->stats.pkt_started = 0;
+		pd->stats.pkt_ended = 0;
+		pd->stats.secs_w = 0;
+		pd->stats.secs_rg = 0;
+		pd->stats.secs_r = 0;
 	}
+	return len;
+}
+static DEVICE_ATTR_WO(reset);
+
+static struct attribute *pkt_stat_attrs[] = {
+	&dev_attr_packets_finished.attr,
+	&dev_attr_packets_started.attr,
+	&dev_attr_kb_read.attr,
+	&dev_attr_kb_written.attr,
+	&dev_attr_kb_read_gather.attr,
+	&dev_attr_reset.attr,
+	NULL,
+};
+
+static const struct attribute_group pkt_stat_group = {
+	.name = "stat",
+	.attrs = pkt_stat_attrs,
+};
+
+static ssize_t size_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct pktcdvd_device *pd = dev_get_drvdata(dev);
+	int n;
+
+	spin_lock(&pd->lock);
+	n = sysfs_emit(buf, "%d\n", pd->bio_queue_size);
+	spin_unlock(&pd->lock);
 	return n;
 }
+static DEVICE_ATTR_RO(size);
 
 static void init_write_congestion_marks(int* lo, int* hi)
 {
@@ -263,30 +235,56 @@ static void init_write_congestion_marks(int* lo, int* hi)
 	}
 }
 
-static ssize_t kobj_pkt_store(struct kobject *kobj,
-			struct attribute *attr,
-			const char *data, size_t len)
+static ssize_t congestion_off_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
 {
-	struct pktcdvd_device *pd = to_pktcdvdkobj(kobj)->pd;
-	int val;
+	struct pktcdvd_device *pd = dev_get_drvdata(dev);
+	int n;
 
-	if (strcmp(attr->name, "reset") == 0 && len > 0) {
-		pd->stats.pkt_started = 0;
-		pd->stats.pkt_ended = 0;
-		pd->stats.secs_w = 0;
-		pd->stats.secs_rg = 0;
-		pd->stats.secs_r = 0;
+	spin_lock(&pd->lock);
+	n = sysfs_emit(buf, "%d\n", pd->write_congestion_off);
+	spin_unlock(&pd->lock);
+	return n;
+}
+
+static ssize_t congestion_off_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t len)
+{
+	struct pktcdvd_device *pd = dev_get_drvdata(dev);
+	int val;
 
-	} else if (strcmp(attr->name, "congestion_off") == 0
-		   && sscanf(data, "%d", &val) == 1) {
+	if (sscanf(buf, "%d", &val) == 1) {
 		spin_lock(&pd->lock);
 		pd->write_congestion_off = val;
 		init_write_congestion_marks(&pd->write_congestion_off,
 					&pd->write_congestion_on);
 		spin_unlock(&pd->lock);
+	}
+	return len;
+}
+static DEVICE_ATTR_RW(congestion_off);
+
+static ssize_t congestion_on_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct pktcdvd_device *pd = dev_get_drvdata(dev);
+	int n;
 
-	} else if (strcmp(attr->name, "congestion_on") == 0
-		   && sscanf(data, "%d", &val) == 1) {
+	spin_lock(&pd->lock);
+	n = sysfs_emit(buf, "%d\n", pd->write_congestion_on);
+	spin_unlock(&pd->lock);
+	return n;
+}
+
+static ssize_t congestion_on_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t len)
+{
+	struct pktcdvd_device *pd = dev_get_drvdata(dev);
+	int val;
+
+	if (sscanf(buf, "%d", &val) == 1) {
 		spin_lock(&pd->lock);
 		pd->write_congestion_on = val;
 		init_write_congestion_marks(&pd->write_congestion_off,
@@ -295,44 +293,39 @@ static ssize_t kobj_pkt_store(struct kobject *kobj,
 	}
 	return len;
 }
+static DEVICE_ATTR_RW(congestion_on);
 
-static const struct sysfs_ops kobj_pkt_ops = {
-	.show = kobj_pkt_show,
-	.store = kobj_pkt_store
+static struct attribute *pkt_wq_attrs[] = {
+	&dev_attr_congestion_on.attr,
+	&dev_attr_congestion_off.attr,
+	&dev_attr_size.attr,
+	NULL,
 };
-static struct kobj_type kobj_pkt_type_stat = {
-	.release = pkt_kobj_release,
-	.sysfs_ops = &kobj_pkt_ops,
-	.default_attrs = kobj_pkt_attrs_stat
+
+static const struct attribute_group pkt_wq_group = {
+	.name = "write_queue",
+	.attrs = pkt_wq_attrs,
 };
-static struct kobj_type kobj_pkt_type_wqueue = {
-	.release = pkt_kobj_release,
-	.sysfs_ops = &kobj_pkt_ops,
-	.default_attrs = kobj_pkt_attrs_wqueue
+
+static const struct attribute_group *pkt_groups[] = {
+	&pkt_stat_group,
+	&pkt_wq_group,
+	NULL,
 };
 
 static void pkt_sysfs_dev_new(struct pktcdvd_device *pd)
 {
 	if (class_pktcdvd) {
-		pd->dev = device_create(class_pktcdvd, NULL, MKDEV(0, 0), NULL,
-					"%s", pd->name);
+		pd->dev = device_create_with_groups(class_pktcdvd, NULL,
+						    MKDEV(0, 0), pd, pkt_groups,
+						    "%s", pd->name);
 		if (IS_ERR(pd->dev))
 			pd->dev = NULL;
 	}
-	if (pd->dev) {
-		pd->kobj_stat = pkt_kobj_create(pd, "stat",
-					&pd->dev->kobj,
-					&kobj_pkt_type_stat);
-		pd->kobj_wqueue = pkt_kobj_create(pd, "write_queue",
-					&pd->dev->kobj,
-					&kobj_pkt_type_wqueue);
-	}
 }
 
 static void pkt_sysfs_dev_remove(struct pktcdvd_device *pd)
 {
-	pkt_kobj_remove(pd->kobj_stat);
-	pkt_kobj_remove(pd->kobj_wqueue);
 	if (class_pktcdvd)
 		device_unregister(pd->dev);
 }
diff --git a/include/linux/pktcdvd.h b/include/linux/pktcdvd.h
index 174601554b06..fc2ed629be72 100644
--- a/include/linux/pktcdvd.h
+++ b/include/linux/pktcdvd.h
@@ -152,14 +152,6 @@ struct packet_stacked_data
 };
 #define PSD_POOL_SIZE		64
 
-struct pktcdvd_kobj
-{
-	struct kobject		kobj;
-	struct pktcdvd_device	*pd;
-};
-#define to_pktcdvdkobj(_k) \
-  ((struct pktcdvd_kobj*)container_of(_k,struct pktcdvd_kobj,kobj))
-
 struct pktcdvd_device
 {
 	struct block_device	*bdev;		/* dev attached */
@@ -195,8 +187,6 @@ struct pktcdvd_device
 	int			write_congestion_on;
 
 	struct device		*dev;		/* sysfs pktcdvd[0-7] dev */
-	struct pktcdvd_kobj	*kobj_stat;	/* sysfs pktcdvd[0-7]/stat/     */
-	struct pktcdvd_kobj	*kobj_wqueue;	/* sysfs pktcdvd[0-7]/write_queue/ */
 
 	struct dentry		*dfs_d_root;	/* debugfs: devname directory */
 	struct dentry		*dfs_f_info;	/* debugfs: info file */
-- 
2.34.1

