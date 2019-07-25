Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5146175587
	for <lists+linux-block@lfdr.de>; Thu, 25 Jul 2019 19:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387856AbfGYRY1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 25 Jul 2019 13:24:27 -0400
Received: from ale.deltatee.com ([207.54.116.67]:39710 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391102AbfGYRXw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jul 2019 13:23:52 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hqhSw-0001Jf-Ch; Thu, 25 Jul 2019 11:23:51 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hqhSw-0001nf-6g; Thu, 25 Jul 2019 11:23:42 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 25 Jul 2019 11:23:32 -0600
Message-Id: <20190725172335.6825-14-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725172335.6825-1-logang@deltatee.com>
References: <20190725172335.6825-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, Chaitanya.Kulkarni@wdc.com, maxg@mellanox.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,MYRULES_NO_TEXT autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [PATCH v6 13/16] nvmet-configfs: introduce passthru configfs interface
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When CONFIG_NVME_TARGET_PASSTHRU as 'passthru' directory will
be added to each subsystem. The directory is similar to a namespace
and has two attributes: device_path and enable. The user must set the
path to the nvme controller's char device and write '1' to enable the
subsystem to use passthru.

Any given subsystem is prevented from enabling both a regular namespace
and the passthru device. If one is enabled, enabling the other will
produce an error.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/configfs.c | 99 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h    |  1 +
 2 files changed, 100 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 98613a45bd3b..b15d64c19f58 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -615,6 +615,103 @@ static const struct config_item_type nvmet_namespaces_type = {
 	.ct_owner		= THIS_MODULE,
 };
 
+#ifdef CONFIG_NVME_TARGET_PASSTHRU
+
+static ssize_t nvmet_passthru_device_path_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+
+	return snprintf(page, PAGE_SIZE, "%s\n", subsys->passthru_ctrl_path);
+}
+
+static ssize_t nvmet_passthru_device_path_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	int ret = -ENOMEM;
+	size_t len;
+
+	mutex_lock(&subsys->lock);
+
+	ret = -EBUSY;
+	if (subsys->passthru_ctrl)
+		goto out_unlock;
+
+	ret = -EINVAL;
+	len = strcspn(page, "\n");
+	if (!len)
+		goto out_unlock;
+
+	kfree(subsys->passthru_ctrl_path);
+	ret = -ENOMEM;
+	subsys->passthru_ctrl_path = kstrndup(page, len, GFP_KERNEL);
+	if (!subsys->passthru_ctrl_path)
+		goto out_unlock;
+
+	mutex_unlock(&subsys->lock);
+
+	return count;
+out_unlock:
+	mutex_unlock(&subsys->lock);
+	return ret;
+}
+CONFIGFS_ATTR(nvmet_passthru_, device_path);
+
+static ssize_t nvmet_passthru_enable_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+
+	return sprintf(page, "%d\n", subsys->passthru_ctrl ? 1 : 0);
+}
+
+static ssize_t nvmet_passthru_enable_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	bool enable;
+	int ret = 0;
+
+	if (strtobool(page, &enable))
+		return -EINVAL;
+
+	if (enable)
+		ret = nvmet_passthru_ctrl_enable(subsys);
+	else
+		nvmet_passthru_ctrl_disable(subsys);
+
+	return ret ? ret : count;
+}
+CONFIGFS_ATTR(nvmet_passthru_, enable);
+
+static struct configfs_attribute *nvmet_passthru_attrs[] = {
+	&nvmet_passthru_attr_device_path,
+	&nvmet_passthru_attr_enable,
+	NULL,
+};
+
+static const struct config_item_type nvmet_passthru_type = {
+	.ct_attrs		= nvmet_passthru_attrs,
+	.ct_owner		= THIS_MODULE,
+};
+
+static void nvmet_add_passthru_group(struct nvmet_subsys *subsys)
+{
+	config_group_init_type_name(&subsys->passthru_group,
+				    "passthru", &nvmet_passthru_type);
+	configfs_add_default_group(&subsys->passthru_group,
+				   &subsys->group);
+}
+
+#else /* CONFIG_NVME_TARGET_PASSTHRU */
+
+static void nvmet_add_passthru_group(struct nvmet_subsys *subsys)
+{
+}
+
+#endif /* CONFIG_NVME_TARGET_PASSTHRU */
+
 static int nvmet_port_subsys_allow_link(struct config_item *parent,
 		struct config_item *target)
 {
@@ -915,6 +1012,8 @@ static struct config_group *nvmet_subsys_make(struct config_group *group,
 	configfs_add_default_group(&subsys->allowed_hosts_group,
 			&subsys->group);
 
+	nvmet_add_passthru_group(subsys);
+
 	return &subsys->group;
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 004949b6b666..fdcfadb7eb61 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -232,6 +232,7 @@ struct nvmet_subsys {
 	struct nvme_ctrl	*passthru_ctrl;
 	char			*passthru_ctrl_path;
 	bool			passthru_connected;
+	struct config_group	passthru_group;
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
 };
 
-- 
2.20.1

