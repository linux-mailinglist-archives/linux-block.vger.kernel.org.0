Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134A36370C8
	for <lists+linux-block@lfdr.de>; Thu, 24 Nov 2022 04:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiKXDGx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 23 Nov 2022 22:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKXDGw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 22:06:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3155C8C94
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 19:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669259153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gtwZw4U/AqC79Gw3Y+Hxa1/m/X8wBYy7by61ckvdplY=;
        b=bG+Lcx+A36Uf71m9hMN+D3xXFHjXJbDgzf8O/U2kbwcd8U6wMVJ1p6Zyo4kgrr0Hni51ti
        YuRLNUPEDRyi1t4tK56fXWoVECUmpL+pzGz6XSisxe85fIXPYicTUdbUFFTBv9vnPnqeaS
        EB5mGR7C76Ya0wtjDJG61s7BWuIX/tY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-AvxG4BCLPO6yySNLaSqDdw-1; Wed, 23 Nov 2022 22:05:49 -0500
X-MC-Unique: AvxG4BCLPO6yySNLaSqDdw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC42A3C025C3;
        Thu, 24 Nov 2022 03:05:48 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 623F6C15BA5;
        Thu, 24 Nov 2022 03:05:45 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Dan Carpenter <error27@gmail.com>,
        Ming Lei <ming.lei@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH V2 6/6] ublk_drv: add mechanism for supporting unprivileged ublk device
Date:   Thu, 24 Nov 2022 11:04:54 +0800
Message-Id: <20221124030454.476152-7-ming.lei@redhat.com>
In-Reply-To: <20221124030454.476152-1-ming.lei@redhat.com>
References: <20221124030454.476152-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

unprivileged ublk device is helpful for container use case, such
as: ublk device created in one unprivileged container can be controlled
and accessed by this container only.

Implement this feature by adding flag of UBLK_F_UNPRIVILEGED_DEV, and if
this flag isn't set, any control command has been run from privileged
user. Otherwise, any control command can be sent from any unprivileged
user, but the user has to be permitted to access the ublk char device
to be controlled.

In case of UBLK_F_UNPRIVILEGED_DEV:

1) for command UBLK_CMD_ADD_DEV, it is always allowed, and user needs
to provide owner's uid/gid in this command, so that udev can set correct
ownership for the created ublk device, since the device owner uid/gid
can be queried via command of UBLK_CMD_GET_DEV_INFO.

2) for other control commands, they can only be run successfully if the
current user is allowed to access the specified ublk char device, for
running the permission check, path of the ublk char device has to be
provided by these commands.

Also add one control of command UBLK_CMD_GET_DEV_INFO2 which always
include the char dev path in payload since userspace may not have
knowledge if this device is created in unprivileged mode.

For applying this mechanism, system administrator needs to take
the following policies:

1) chmod 0666 /dev/ublk-control

2) change ownership of ublkcN & ublkbN
- chown owner_uid:owner_gid /dev/ublkcN
- chown owner_uid:owner_gid /dev/ublkbN

Both can be done via one simple udev rule.

Userspace:

	https://github.com/ming1/ubdsrv/tree/unprivileged-ublk

'ublk add -t $TYPE --un_privileged=1' is for creating one un-privileged
ublk device if the user is un-privileged.

Link: https://lore.kernel.org/linux-block/YoOr6jBfgVm8GvWg@stefanha-x1.localdomain/
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 Documentation/block/ublk.rst  |  18 ++---
 drivers/block/ublk_drv.c      | 147 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h |  36 ++++++++-
 3 files changed, 184 insertions(+), 17 deletions(-)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index ba45c46cc0da..403ffd0f4511 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -180,6 +180,15 @@ managing and controlling ublk devices with help of several control commands:
   double-write since the driver may issue the same I/O request twice. It
   might be useful to a read-only FS or a VM backend.
 
+Unprivileged ublk device is supported by passing UBLK_F_UNPRIVILEGED_DEV.
+Once the flag is set, all control commands can be sent by unprivileged
+user. Except for command of ``UBLK_CMD_ADD_DEV``, permission check on
+the specified char device(``/dev/ublkc*``) is done for all other control
+commands by ublk driver, for doing that, path of the char device has to
+be provided in these commands' payload from ublk server. With this way,
+ublk device becomes container-ware, and device created in one container
+can be controlled/accessed just inside this container.
+
 Data plane
 ----------
 
@@ -254,15 +263,6 @@ with specified IO tag in the command data:
 Future development
 ==================
 
-Container-aware ublk deivice
-----------------------------
-
-ublk driver doesn't handle any IO logic. Its function is well defined
-for now and very limited userspace interfaces are needed, which is also
-well defined too. It is possible to make ublk devices container-aware block
-devices in future as Stefan Hajnoczi suggested [#stefan]_, by removing
-ADMIN privilege.
-
 Zero copy
 ---------
 
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index b12dd5ebe975..33b621283e77 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -42,6 +42,7 @@
 #include <linux/mm.h>
 #include <asm/page.h>
 #include <linux/task_work.h>
+#include <linux/namei.h>
 #include <uapi/linux/ublk_cmd.h>
 
 #define UBLK_MINORS		(1U << MINORBITS)
@@ -51,7 +52,8 @@
 		| UBLK_F_URING_CMD_COMP_IN_TASK \
 		| UBLK_F_NEED_GET_DATA \
 		| UBLK_F_USER_RECOVERY \
-		| UBLK_F_USER_RECOVERY_REISSUE)
+		| UBLK_F_USER_RECOVERY_REISSUE \
+		| UBLK_F_UNPRIVILEGED_DEV)
 
 /* All UBLK_PARAM_TYPE_* should be included here */
 #define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | \
@@ -1641,15 +1643,33 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 			__func__, header->queue_id);
 		return -EINVAL;
 	}
+
 	if (copy_from_user(&info, argp, sizeof(info)))
 		return -EFAULT;
-	ublk_dump_dev_info(&info);
+
+	if (info.flags & UBLK_F_UNPRIVILEGED_DEV) {
+		/*
+		 * user needs to provide proper owner_uid/owner_gid,
+		 * which will be provided to udev rule for setting
+		 * ownership on the ublk device to be created.
+		 */
+		;
+	} else {
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+
+		if (info.owner_uid != 0 || info.owner_gid != 0)
+			return -EINVAL;
+	}
+
 	if (header->dev_id != info.dev_id) {
 		pr_warn("%s: dev id not match %u %u\n",
 			__func__, header->dev_id, info.dev_id);
 		return -EINVAL;
 	}
 
+	ublk_dump_dev_info(&info);
+
 	ret = mutex_lock_killable(&ublk_ctl_mutex);
 	if (ret)
 		return ret;
@@ -1982,6 +2002,114 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 	return ret;
 }
 
+/*
+ * All control commands are sent via /dev/ublk-control, so we have to check
+ * the destination device's permission
+ */
+static int ublk_char_dev_permission(struct ublk_device *ub,
+		const char *dev_path, int mask)
+{
+	int err;
+	struct path path;
+	struct kstat stat;
+
+	err = kern_path(dev_path, LOOKUP_FOLLOW, &path);
+	if (err)
+		return err;
+
+	err = vfs_getattr(&path, &stat, STATX_TYPE, AT_STATX_SYNC_AS_STAT);
+	if (err)
+		goto exit;
+
+	if (stat.rdev != ub->cdev_dev.devt || !S_ISCHR(stat.mode))
+		goto exit;
+
+	err = inode_permission(&init_user_ns,
+			d_backing_inode(path.dentry), mask);
+exit:
+	path_put(&path);
+	return err;
+}
+
+static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
+		struct io_uring_cmd *cmd)
+{
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	bool unprivileged = ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV;
+	void __user *argp = (void __user *)(unsigned long)header->addr;
+	char *dev_path = NULL;
+	int ret = 0;
+	int mask;
+
+	if (!unprivileged) {
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		/*
+		 * The new added command of UBLK_CMD_GET_DEV_INFO2 includes
+		 * char_dev_path in payload too, since userspace may not
+		 * know if the specified device is created as unprivileged
+		 * mode.
+		 */
+		if (cmd->cmd_op != UBLK_CMD_GET_DEV_INFO2)
+			return 0;
+	}
+
+	/*
+	 * User has to provide the char device path for unprivileged ublk
+	 *
+	 * header->addr always points to the dev path buffer, and
+	 * header->dev_path_len records length of dev path buffer.
+	 */
+	if (!header->dev_path_len || header->dev_path_len > PATH_MAX)
+		return -EINVAL;
+
+	if (header->len < header->dev_path_len)
+		return -EINVAL;
+
+	dev_path = kmalloc(header->dev_path_len, GFP_KERNEL);
+	if (!dev_path)
+		return -ENOMEM;
+
+	ret = -EFAULT;
+	if (copy_from_user(dev_path, argp, header->dev_path_len))
+		goto exit;
+	dev_path[header->dev_path_len] = 0;
+
+	ret = -EINVAL;
+	switch (cmd->cmd_op) {
+	case UBLK_CMD_GET_DEV_INFO:
+	case UBLK_CMD_GET_DEV_INFO2:
+	case UBLK_CMD_GET_QUEUE_AFFINITY:
+	case UBLK_CMD_GET_PARAMS:
+		mask = MAY_READ;
+		break;
+	case UBLK_CMD_START_DEV:
+	case UBLK_CMD_STOP_DEV:
+	case UBLK_CMD_ADD_DEV:
+	case UBLK_CMD_DEL_DEV:
+	case UBLK_CMD_SET_PARAMS:
+	case UBLK_CMD_START_USER_RECOVERY:
+	case UBLK_CMD_END_USER_RECOVERY:
+		mask = MAY_READ | MAY_WRITE;
+		break;
+	default:
+		goto exit;
+	}
+
+	ret = ublk_char_dev_permission(ub, dev_path, mask);
+	if (!ret) {
+		header->len -= header->dev_path_len;
+		header->addr += header->dev_path_len;
+	}
+	pr_devel("%s: dev id %d cmd_op %x uid %d gid %d path %s ret %d\n",
+			__func__, ub->ub_number, cmd->cmd_op,
+			ub->dev_info.owner_uid, ub->dev_info.owner_gid,
+			dev_path, ret);
+exit:
+	kfree(dev_path);
+	return ret;
+}
+
 static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
@@ -1994,17 +2122,21 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 	if (!(issue_flags & IO_URING_F_SQE128))
 		goto out;
 
-	ret = -EPERM;
-	if (!capable(CAP_SYS_ADMIN))
-		goto out;
-
 	if (cmd->cmd_op != UBLK_CMD_ADD_DEV) {
 		ret = -ENODEV;
 		ub = ublk_get_device_from_id(header->dev_id);
 		if (!ub)
 			goto out;
+
+		ret = ublk_ctrl_uring_cmd_permission(ub, cmd);
+	} else {
+		/* ADD_DEV permission check is done in command handler */
+		ret = 0;
 	}
 
+	if (ret)
+		goto put_dev;
+
 	switch (cmd->cmd_op) {
 	case UBLK_CMD_START_DEV:
 		ret = ublk_ctrl_start_dev(ub, cmd);
@@ -2013,6 +2145,7 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		ret = ublk_ctrl_stop_dev(ub);
 		break;
 	case UBLK_CMD_GET_DEV_INFO:
+	case UBLK_CMD_GET_DEV_INFO2:
 		ret = ublk_ctrl_get_dev_info(ub, cmd);
 		break;
 	case UBLK_CMD_ADD_DEV:
@@ -2040,6 +2173,8 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		ret = -ENOTSUPP;
 		break;
 	}
+
+ put_dev:
 	if (ub)
 		ublk_put_device(ub);
  out:
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 4e38b9aa0293..ae80bfef3b9f 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -19,6 +19,8 @@
 #define	UBLK_CMD_GET_PARAMS	0x09
 #define	UBLK_CMD_START_USER_RECOVERY	0x10
 #define	UBLK_CMD_END_USER_RECOVERY	0x11
+#define	UBLK_CMD_GET_DEV_INFO2		0x12
+
 /*
  * IO commands, issued by ublk server, and handled by ublk driver.
  *
@@ -79,6 +81,27 @@
 
 #define UBLK_F_USER_RECOVERY_REISSUE	(1UL << 4)
 
+/*
+ * Unprivileged user can create /dev/ublkcN and /dev/ublkbN.
+ *
+ * /dev/ublk-control needs to be available for unprivileged user, and it
+ * can be done via udev rule to make all control commands available to
+ * unprivileged user. Except for the command of UBLK_CMD_ADD_DEV, all
+ * other commands are only allowed for the owner of the specified device.
+ *
+ * When userspace sends UBLK_CMD_ADD_DEV, the device pair's owner_uid and
+ * owner_gid need to be provided via ublksrv_ctrl_dev_info, and the two
+ * ids need to match with ublk server's uid/gid, otherwise the created
+ * ublk device can't be started successfully.
+ *
+ * We still need udev rule to set correct OWNER/GROUP with the stored
+ * owner_uid and owner_gid.
+ *
+ * Then ublk server can be run as unprivileged user, and /dev/ublkbN can
+ * be accessed by user of owner_uid/owner_gid.
+ */
+#define UBLK_F_UNPRIVILEGED_DEV	(1UL << 5)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
@@ -98,7 +121,15 @@ struct ublksrv_ctrl_cmd {
 	__u64	addr;
 
 	/* inline data */
-	__u64	data[2];
+	__u64	data[1];
+
+	/*
+	 * Used for UBLK_F_UNPRIVILEGED_DEV and UBLK_CMD_GET_DEV_INFO2
+	 * only, include null char
+	 */
+	__u16	dev_path_len;
+	__u16	pad;
+	__u32	reserved;
 };
 
 struct ublksrv_ctrl_dev_info {
@@ -118,7 +149,8 @@ struct ublksrv_ctrl_dev_info {
 	/* For ublksrv internal use, invisible to ublk driver */
 	__u64	ublksrv_flags;
 
-	__u64	reserved0;
+	__u32	owner_uid;
+	__u32	owner_gid;
 	__u64	reserved1;
 	__u64   reserved2;
 };
-- 
2.31.1

