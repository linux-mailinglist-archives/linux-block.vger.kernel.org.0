Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A1C1BA5E1
	for <lists+linux-block@lfdr.de>; Mon, 27 Apr 2020 16:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgD0OLk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 27 Apr 2020 10:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbgD0OLh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 10:11:37 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C3FC09B051
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2020 07:11:35 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r26so20661433wmh.0
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2020 07:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VZKbV7HG7aMogTGjfn4wt84nVgjfeE14afRT58MxeG8=;
        b=TawhlGKpzGcW/LcUPra2ef5axZbZc0JSqNGr4MTvXxJDVax+BypuAa/gK4+23gNDw+
         H9jk7rGHN55P1XX48vBS4/7tcyGXaLfDt9TRnEpKmzNn4nSBTyfHhi6XUR4DQO1Ldua3
         XJvScgoVOoHuJNOYyjbsNyMz4sF2WFbfz7xcHVYwt5N4ebn9WHnZxchA6NMloBeUHoqA
         pXr/hiKKu5gMjafRP1PXvntL5ZSMzOVR03DazPHksodiI6pufVyK8wY2XyfTHrlVP4Y1
         t9PZWFY2WiodseLv4v9+Wjh5Fa6xAvvc18xJghtljX1YJG60tsoy+0pxF3sfEX2gylYd
         Xpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VZKbV7HG7aMogTGjfn4wt84nVgjfeE14afRT58MxeG8=;
        b=gh/JjVmiofAaz45bABCewjBk4UB16GBKIpjGqFzDP2ifWIbXYQiRt4PRYI9WYcomAy
         6IFXPMWudx/O0KY5U4sz/koGQuahoJNrM3aWodG1untfae0Lu9BAumRCMtaqN9upTyss
         TOg9NyAhKLT+3D9QC+ZCA/wtY58VjlG8sS6l4kLZzAvTVPQ9oMXYjLIQd/zkR4PAt9E7
         1kkJROwsY+3Kc/Kc6VW0gzKXDF2v9KmZI5yqJF5TT81zR3J0TXPLxUVwmLwHfhR7QE5V
         gT0nzK5UHxyR2Ri40w3EGDgOnzGfhA0LA1UdXs7se4c7BIY3Fz8Slrnoc9Jk437NedZs
         duUg==
X-Gm-Message-State: AGi0PuY8uaP2xPG6697p95RNqDHqzVRN4SXD7IkMZhkh84b/t/tuCrEo
        fbnfEZerdRHHDmD9TX8IzrjsTvcjeVx3src=
X-Google-Smtp-Source: APiQypIXI9E1Lzapp0vg2EHIUa2HVAwfcd5Ufk1LyPnQXn80h3gmFwIrYiAkomIeNpzApRlyeh7WjQ==
X-Received: by 2002:a05:600c:441a:: with SMTP id u26mr28101090wmn.154.1587996693978;
        Mon, 27 Apr 2020 07:11:33 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id o3sm21499756wru.68.2020.04.27.07.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 07:11:33 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v13 18/25] block/rnbd: client: sysfs interface functions
Date:   Mon, 27 Apr 2020 16:10:13 +0200
Message-Id: <20200427141020.655-19-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
References: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

This is the sysfs interface to rnbd block devices on client side:

  /sys/class/rnbd-client/ctl/
    |- map_device
    |  *** maps remote device
    |
    |- devices/
       *** all mapped devices

  /sys/block/rnbd<N>/rnbd/
    |- unmap_device
    |  *** unmaps device
    |
    |- state
    |  *** device state
    |
    |- session
    |  *** session name
    |
    |- mapping_path
       *** path of the dev that was mapped on server

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 636 ++++++++++++++++++++++++++++
 1 file changed, 636 insertions(+)
 create mode 100644 drivers/block/rnbd/rnbd-clt-sysfs.c

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
new file mode 100644
index 000000000000..a4508fcc7ffe
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -0,0 +1,636 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RDMA Network Block Driver
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
+ */
+
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
+
+#include <linux/types.h>
+#include <linux/ctype.h>
+#include <linux/parser.h>
+#include <linux/module.h>
+#include <linux/in6.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
+#include <linux/device.h>
+#include <rdma/ib.h>
+#include <rdma/rdma_cm.h>
+
+#include "rnbd-clt.h"
+
+static struct device *rnbd_dev;
+static struct class *rnbd_dev_class;
+static struct kobject *rnbd_devs_kobj;
+
+enum {
+	RNBD_OPT_ERR		= 0,
+	RNBD_OPT_DEST_PORT	= 1 << 0,
+	RNBD_OPT_PATH		= 1 << 1,
+	RNBD_OPT_DEV_PATH	= 1 << 2,
+	RNBD_OPT_ACCESS_MODE	= 1 << 3,
+	RNBD_OPT_SESSNAME	= 1 << 6,
+};
+
+static const unsigned int rnbd_opt_mandatory[] = {
+	RNBD_OPT_PATH,
+	RNBD_OPT_DEV_PATH,
+	RNBD_OPT_SESSNAME,
+};
+
+static const match_table_t rnbd_opt_tokens = {
+	{RNBD_OPT_PATH,		"path=%s"	},
+	{RNBD_OPT_DEV_PATH,	"device_path=%s"},
+	{RNBD_OPT_DEST_PORT,	"dest_port=%d"  },
+	{RNBD_OPT_ACCESS_MODE,	"access_mode=%s"},
+	{RNBD_OPT_SESSNAME,	"sessname=%s"	},
+	{RNBD_OPT_ERR,		NULL		},
+};
+
+struct rnbd_map_options {
+	char *sessname;
+	struct rtrs_addr *paths;
+	size_t *path_cnt;
+	char *pathname;
+	u16 *dest_port;
+	enum rnbd_access_mode *access_mode;
+};
+
+static int rnbd_clt_parse_map_options(const char *buf, size_t max_path_cnt,
+				       struct rnbd_map_options *opt)
+{
+	char *options, *sep_opt;
+	char *p;
+	substring_t args[MAX_OPT_ARGS];
+	int opt_mask = 0;
+	int token;
+	int ret = -EINVAL;
+	int i, dest_port;
+	int p_cnt = 0;
+
+	options = kstrdup(buf, GFP_KERNEL);
+	if (!options)
+		return -ENOMEM;
+
+	sep_opt = strstrip(options);
+	while ((p = strsep(&sep_opt, " ")) != NULL) {
+		if (!*p)
+			continue;
+
+		token = match_token(p, rnbd_opt_tokens, args);
+		opt_mask |= token;
+
+		switch (token) {
+		case RNBD_OPT_SESSNAME:
+			p = match_strdup(args);
+			if (!p) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			if (strlen(p) > NAME_MAX) {
+				pr_err("map_device: sessname too long\n");
+				ret = -EINVAL;
+				kfree(p);
+				goto out;
+			}
+			strlcpy(opt->sessname, p, NAME_MAX);
+			kfree(p);
+			break;
+
+		case RNBD_OPT_PATH:
+			if (p_cnt >= max_path_cnt) {
+				pr_err("map_device: too many (> %zu) paths provided\n",
+				       max_path_cnt);
+				ret = -ENOMEM;
+				goto out;
+			}
+			p = match_strdup(args);
+			if (!p) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			ret = rtrs_addr_to_sockaddr(p, strlen(p),
+						    *opt->dest_port,
+						    &opt->paths[p_cnt]);
+			if (ret) {
+				pr_err("Can't parse path %s: %d\n", p, ret);
+				kfree(p);
+				goto out;
+			}
+
+			p_cnt++;
+
+			kfree(p);
+			break;
+
+		case RNBD_OPT_DEV_PATH:
+			p = match_strdup(args);
+			if (!p) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			if (strlen(p) > NAME_MAX) {
+				pr_err("map_device: Device path too long\n");
+				ret = -EINVAL;
+				kfree(p);
+				goto out;
+			}
+			strlcpy(opt->pathname, p, NAME_MAX);
+			kfree(p);
+			break;
+
+		case RNBD_OPT_DEST_PORT:
+			if (match_int(args, &dest_port) || dest_port < 0 ||
+			    dest_port > 65535) {
+				pr_err("bad destination port number parameter '%d'\n",
+				       dest_port);
+				ret = -EINVAL;
+				goto out;
+			}
+			*opt->dest_port = dest_port;
+			break;
+
+		case RNBD_OPT_ACCESS_MODE:
+			p = match_strdup(args);
+			if (!p) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			if (!strcmp(p, "ro")) {
+				*opt->access_mode = RNBD_ACCESS_RO;
+			} else if (!strcmp(p, "rw")) {
+				*opt->access_mode = RNBD_ACCESS_RW;
+			} else if (!strcmp(p, "migration")) {
+				*opt->access_mode = RNBD_ACCESS_MIGRATION;
+			} else {
+				pr_err("map_device: Invalid access_mode: '%s'\n",
+				       p);
+				ret = -EINVAL;
+				kfree(p);
+				goto out;
+			}
+
+			kfree(p);
+			break;
+
+		default:
+			pr_err("map_device: Unknown parameter or missing value '%s'\n",
+			       p);
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(rnbd_opt_mandatory); i++) {
+		if ((opt_mask & rnbd_opt_mandatory[i])) {
+			ret = 0;
+		} else {
+			pr_err("map_device: Parameters missing\n");
+			ret = -EINVAL;
+			break;
+		}
+	}
+
+out:
+	*opt->path_cnt = p_cnt;
+	kfree(options);
+	return ret;
+}
+
+static ssize_t state_show(struct kobject *kobj,
+			  struct kobj_attribute *attr, char *page)
+{
+	struct rnbd_clt_dev *dev;
+
+	dev = container_of(kobj, struct rnbd_clt_dev, kobj);
+
+	switch (dev->dev_state) {
+	case DEV_STATE_INIT:
+		return snprintf(page, PAGE_SIZE, "init\n");
+	case DEV_STATE_MAPPED:
+		/* TODO fix cli tool before changing to proper state */
+		return snprintf(page, PAGE_SIZE, "open\n");
+	case DEV_STATE_MAPPED_DISCONNECTED:
+		/* TODO fix cli tool before changing to proper state */
+		return snprintf(page, PAGE_SIZE, "closed\n");
+	case DEV_STATE_UNMAPPED:
+		return snprintf(page, PAGE_SIZE, "unmapped\n");
+	default:
+		return snprintf(page, PAGE_SIZE, "unknown\n");
+	}
+}
+
+static struct kobj_attribute rnbd_clt_state_attr = __ATTR_RO(state);
+
+static ssize_t mapping_path_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *page)
+{
+	struct rnbd_clt_dev *dev;
+
+	dev = container_of(kobj, struct rnbd_clt_dev, kobj);
+
+	return scnprintf(page, PAGE_SIZE, "%s\n", dev->pathname);
+}
+
+static struct kobj_attribute rnbd_clt_mapping_path_attr =
+	__ATTR_RO(mapping_path);
+
+static ssize_t access_mode_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *page)
+{
+	struct rnbd_clt_dev *dev;
+
+	dev = container_of(kobj, struct rnbd_clt_dev, kobj);
+
+	return snprintf(page, PAGE_SIZE, "%s\n",
+			rnbd_access_mode_str(dev->access_mode));
+}
+
+static struct kobj_attribute rnbd_clt_access_mode =
+	__ATTR_RO(access_mode);
+
+static ssize_t rnbd_clt_unmap_dev_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *page)
+{
+	return scnprintf(page, PAGE_SIZE, "Usage: echo <normal|force> > %s\n",
+			 attr->attr.name);
+}
+
+static ssize_t rnbd_clt_unmap_dev_store(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct rnbd_clt_dev *dev;
+	char *opt, *options;
+	bool force;
+	int err;
+
+	opt = kstrdup(buf, GFP_KERNEL);
+	if (!opt)
+		return -ENOMEM;
+
+	options = strstrip(opt);
+	dev = container_of(kobj, struct rnbd_clt_dev, kobj);
+	if (sysfs_streq(options, "normal")) {
+		force = false;
+	} else if (sysfs_streq(options, "force")) {
+		force = true;
+	} else {
+		rnbd_clt_err(dev,
+			      "unmap_device: Invalid value: %s\n",
+			      options);
+		err = -EINVAL;
+		goto out;
+	}
+
+	rnbd_clt_info(dev, "Unmapping device, option: %s.\n",
+		       force ? "force" : "normal");
+
+	/*
+	 * We take explicit module reference only for one reason: do not
+	 * race with lockless rnbd_destroy_sessions().
+	 */
+	if (!try_module_get(THIS_MODULE)) {
+		err = -ENODEV;
+		goto out;
+	}
+	err = rnbd_clt_unmap_device(dev, force, &attr->attr);
+	if (err) {
+		if (err != -EALREADY)
+			rnbd_clt_err(dev, "unmap_device: %d\n",  err);
+		goto module_put;
+	}
+
+	/*
+	 * Here device can be vanished!
+	 */
+
+	err = count;
+
+module_put:
+	module_put(THIS_MODULE);
+out:
+	kfree(opt);
+
+	return err;
+}
+
+static struct kobj_attribute rnbd_clt_unmap_device_attr =
+	__ATTR(unmap_device, 0644, rnbd_clt_unmap_dev_show,
+	       rnbd_clt_unmap_dev_store);
+
+static ssize_t rnbd_clt_resize_dev_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *page)
+{
+	return scnprintf(page, PAGE_SIZE,
+			 "Usage: echo <new size in sectors> > %s\n",
+			 attr->attr.name);
+}
+
+static ssize_t rnbd_clt_resize_dev_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	int ret;
+	unsigned long sectors;
+	struct rnbd_clt_dev *dev;
+
+	dev = container_of(kobj, struct rnbd_clt_dev, kobj);
+
+	ret = kstrtoul(buf, 0, &sectors);
+	if (ret)
+		return ret;
+
+	ret = rnbd_clt_resize_disk(dev, (size_t)sectors);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static struct kobj_attribute rnbd_clt_resize_dev_attr =
+	__ATTR(resize, 0644, rnbd_clt_resize_dev_show,
+	       rnbd_clt_resize_dev_store);
+
+static ssize_t rnbd_clt_remap_dev_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *page)
+{
+	return scnprintf(page, PAGE_SIZE, "Usage: echo <1> > %s\n",
+			 attr->attr.name);
+}
+
+static ssize_t rnbd_clt_remap_dev_store(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct rnbd_clt_dev *dev;
+	char *opt, *options;
+	int err;
+
+	opt = kstrdup(buf, GFP_KERNEL);
+	if (!opt)
+		return -ENOMEM;
+
+	options = strstrip(opt);
+	dev = container_of(kobj, struct rnbd_clt_dev, kobj);
+	if (!sysfs_streq(options, "1")) {
+		rnbd_clt_err(dev,
+			      "remap_device: Invalid value: %s\n",
+			      options);
+		err = -EINVAL;
+		goto out;
+	}
+	err = rnbd_clt_remap_device(dev);
+	if (likely(!err))
+		err = count;
+
+out:
+	kfree(opt);
+
+	return err;
+}
+
+static struct kobj_attribute rnbd_clt_remap_device_attr =
+	__ATTR(remap_device, 0644, rnbd_clt_remap_dev_show,
+	       rnbd_clt_remap_dev_store);
+
+static ssize_t session_show(struct kobject *kobj, struct kobj_attribute *attr,
+			    char *page)
+{
+	struct rnbd_clt_dev *dev;
+
+	dev = container_of(kobj, struct rnbd_clt_dev, kobj);
+
+	return scnprintf(page, PAGE_SIZE, "%s\n", dev->sess->sessname);
+}
+
+static struct kobj_attribute rnbd_clt_session_attr =
+	__ATTR_RO(session);
+
+static struct attribute *rnbd_dev_attrs[] = {
+	&rnbd_clt_unmap_device_attr.attr,
+	&rnbd_clt_resize_dev_attr.attr,
+	&rnbd_clt_remap_device_attr.attr,
+	&rnbd_clt_mapping_path_attr.attr,
+	&rnbd_clt_state_attr.attr,
+	&rnbd_clt_session_attr.attr,
+	&rnbd_clt_access_mode.attr,
+	NULL,
+};
+
+void rnbd_clt_remove_dev_symlink(struct rnbd_clt_dev *dev)
+{
+	/*
+	 * The module_is_live() check is crucial and helps to avoid annoying
+	 * sysfs warning raised in sysfs_remove_link(), when the whole sysfs
+	 * path was just removed, see rnbd_close_sessions().
+	 */
+	if (strlen(dev->blk_symlink_name) && module_is_live(THIS_MODULE))
+		sysfs_remove_link(rnbd_devs_kobj, dev->blk_symlink_name);
+}
+
+static struct kobj_type rnbd_dev_ktype = {
+	.sysfs_ops      = &kobj_sysfs_ops,
+	.default_attrs  = rnbd_dev_attrs,
+};
+
+static int rnbd_clt_add_dev_kobj(struct rnbd_clt_dev *dev)
+{
+	int ret;
+	struct kobject *gd_kobj = &disk_to_dev(dev->gd)->kobj;
+
+	ret = kobject_init_and_add(&dev->kobj, &rnbd_dev_ktype, gd_kobj, "%s",
+				   "rnbd");
+	if (ret)
+		rnbd_clt_err(dev, "Failed to create device sysfs dir, err: %d\n",
+			      ret);
+
+	return ret;
+}
+
+static ssize_t rnbd_clt_map_device_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *page)
+{
+	return scnprintf(page, PAGE_SIZE,
+			 "Usage: echo \"[dest_port=server port number] sessname=<name of the rtrs session> path=<[srcaddr@]dstaddr> [path=<[srcaddr@]dstaddr>] device_path=<full path on remote side> [access_mode=<ro|rw|migration>]\" > %s\n\naddr ::= [ ip:<ipv4> | ip:<ipv6> | gid:<gid> ]\n",
+			 attr->attr.name);
+}
+
+static int rnbd_clt_get_path_name(struct rnbd_clt_dev *dev, char *buf,
+				   size_t len)
+{
+	int ret;
+	char pathname[NAME_MAX], *s;
+
+	strlcpy(pathname, dev->pathname, sizeof(pathname));
+	while ((s = strchr(pathname, '/')))
+		s[0] = '!';
+
+	ret = snprintf(buf, len, "%s", pathname);
+	if (ret >= len)
+		return -ENAMETOOLONG;
+
+	return 0;
+}
+
+static int rnbd_clt_add_dev_symlink(struct rnbd_clt_dev *dev)
+{
+	struct kobject *gd_kobj = &disk_to_dev(dev->gd)->kobj;
+	int ret;
+
+	ret = rnbd_clt_get_path_name(dev, dev->blk_symlink_name,
+				      sizeof(dev->blk_symlink_name));
+	if (ret) {
+		rnbd_clt_err(dev, "Failed to get /sys/block symlink path, err: %d\n",
+			      ret);
+		goto out_err;
+	}
+
+	ret = sysfs_create_link(rnbd_devs_kobj, gd_kobj,
+				dev->blk_symlink_name);
+	if (ret) {
+		rnbd_clt_err(dev, "Creating /sys/block symlink failed, err: %d\n",
+			      ret);
+		goto out_err;
+	}
+
+	return 0;
+
+out_err:
+	dev->blk_symlink_name[0] = '\0';
+	return ret;
+}
+
+static ssize_t rnbd_clt_map_device_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct rnbd_clt_dev *dev;
+	struct rnbd_map_options opt;
+	int ret;
+	char pathname[NAME_MAX];
+	char sessname[NAME_MAX];
+	enum rnbd_access_mode access_mode = RNBD_ACCESS_RW;
+	u16 port_nr = RTRS_PORT;
+
+	struct sockaddr_storage *addrs;
+	struct rtrs_addr paths[6];
+	size_t path_cnt;
+
+	opt.sessname = sessname;
+	opt.paths = paths;
+	opt.path_cnt = &path_cnt;
+	opt.pathname = pathname;
+	opt.dest_port = &port_nr;
+	opt.access_mode = &access_mode;
+	addrs = kcalloc(ARRAY_SIZE(paths) * 2, sizeof(*addrs), GFP_KERNEL);
+	if (!addrs)
+		return -ENOMEM;
+
+	for (path_cnt = 0; path_cnt < ARRAY_SIZE(paths); path_cnt++) {
+		paths[path_cnt].src = &addrs[path_cnt * 2];
+		paths[path_cnt].dst = &addrs[path_cnt * 2 + 1];
+	}
+
+	ret = rnbd_clt_parse_map_options(buf, ARRAY_SIZE(paths), &opt);
+	if (ret)
+		goto out;
+
+	pr_info("Mapping device %s on session %s, (access_mode: %s)\n",
+		pathname, sessname,
+		rnbd_access_mode_str(access_mode));
+
+	dev = rnbd_clt_map_device(sessname, paths, path_cnt, port_nr, pathname,
+				  access_mode);
+	if (IS_ERR(dev)) {
+		ret = PTR_ERR(dev);
+		goto out;
+	}
+
+	ret = rnbd_clt_add_dev_kobj(dev);
+	if (ret)
+		goto unmap_dev;
+
+	ret = rnbd_clt_add_dev_symlink(dev);
+	if (ret)
+		goto unmap_dev;
+
+	kfree(addrs);
+	return count;
+
+unmap_dev:
+	rnbd_clt_unmap_device(dev, true, NULL);
+out:
+	kfree(addrs);
+	return ret;
+}
+
+static struct kobj_attribute rnbd_clt_map_device_attr =
+	__ATTR(map_device, 0644,
+	       rnbd_clt_map_device_show, rnbd_clt_map_device_store);
+
+static struct attribute *default_attrs[] = {
+	&rnbd_clt_map_device_attr.attr,
+	NULL,
+};
+
+static struct attribute_group default_attr_group = {
+	.attrs = default_attrs,
+};
+
+static const struct attribute_group *default_attr_groups[] = {
+	&default_attr_group,
+	NULL,
+};
+
+int rnbd_clt_create_sysfs_files(void)
+{
+	int err;
+
+	rnbd_dev_class = class_create(THIS_MODULE, "rnbd-client");
+	if (IS_ERR(rnbd_dev_class))
+		return PTR_ERR(rnbd_dev_class);
+
+	rnbd_dev = device_create_with_groups(rnbd_dev_class, NULL,
+					      MKDEV(0, 0), NULL,
+					      default_attr_groups, "ctl");
+	if (IS_ERR(rnbd_dev)) {
+		err = PTR_ERR(rnbd_dev);
+		goto cls_destroy;
+	}
+	rnbd_devs_kobj = kobject_create_and_add("devices", &rnbd_dev->kobj);
+	if (!rnbd_devs_kobj) {
+		err = -ENOMEM;
+		goto dev_destroy;
+	}
+
+	return 0;
+
+dev_destroy:
+	device_destroy(rnbd_dev_class, MKDEV(0, 0));
+cls_destroy:
+	class_destroy(rnbd_dev_class);
+
+	return err;
+}
+
+void rnbd_clt_destroy_default_group(void)
+{
+	sysfs_remove_group(&rnbd_dev->kobj, &default_attr_group);
+}
+
+void rnbd_clt_destroy_sysfs_files(void)
+{
+	kobject_del(rnbd_devs_kobj);
+	kobject_put(rnbd_devs_kobj);
+	device_destroy(rnbd_dev_class, MKDEV(0, 0));
+	class_destroy(rnbd_dev_class);
+}
-- 
2.20.1

