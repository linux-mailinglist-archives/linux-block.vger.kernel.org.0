Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5971D650B5D
	for <lists+linux-block@lfdr.de>; Mon, 19 Dec 2022 13:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbiLSMWF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 19 Dec 2022 07:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbiLSMWC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Dec 2022 07:22:02 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA5EDEDA
        for <linux-block@vger.kernel.org>; Mon, 19 Dec 2022 04:22:00 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so6255714wms.2
        for <linux-block@vger.kernel.org>; Mon, 19 Dec 2022 04:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=83YPDTP/ucX9QhARND/pfyriM0SMWhWxUyPFVEXHzvQ=;
        b=I3joW4OO6Ml79U/9y/i8PiKZrW+vuL5Q/N1ADrsLMJCsGKdEqSQzgzB/5mZmYqqVfh
         svWxqtkaqKLqQ9w6nc7pFvShcW5cybMbqsbphD0CDtaDkRdNUdJXkOjh+AKObpa5xazZ
         T7MeftUSdOYroNT+UaKGTvvnk1Xv8cumGm41BzH/0Zruyu6mCrz7M5iRZ8uZJlb6h0AD
         qIklf1x4AWtuM30zy1jY1+qDDvIjxXhOk+eMs3JEIIDyX4BfXan2aef2TmIO+3Ub2154
         BGDaBrLxgFs/4xdUFHJ1Orll6W2+8GPNfANgKdBTT7HGfI9JIy9sbqdHoKpH5sH9KVU2
         +3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83YPDTP/ucX9QhARND/pfyriM0SMWhWxUyPFVEXHzvQ=;
        b=L+0m4xKgqsnctsplimfo2DQoJLGjjqJtNmAHNrX4hhm5jdb+xWgQWl1sE7nPi5l9ma
         mW0fUp3JiXMkYUY+FYdWAk+cyCHsVGMWbkKw3/3JaRDRUeG4DAx9L2IwU2ZDzpuyFMaU
         HEa2WvOk98w2JwnISckgPEBqYkJbSsh+CZihjbVGqXXzxJANaXrayHp3dx21hTn16hHu
         MZDBiXYoUQT2iZwK0HZCuyccfw3bZENFhpYNWEKxW01omqAjBArSH8OlbDAgsgIUVpNJ
         X71aRmrymyE67uc5uFzcTnjCgQWuiqnZEQgDuWYP66YIihoDSAqGlTBMz9ZixcSEiAXq
         9/rg==
X-Gm-Message-State: ANoB5pk2hOG4gDb6SFPUJsMPhovN6ZMLLxcjs8yHvv/y+qJJeNplbfah
        6cpvSS9bpOuR3UCWo8FKQRKIrErpe99AL27zwD8=
X-Google-Smtp-Source: AA0mqf7zIA/2eVdMTBULenjjjOP6Rl2w/fLcDKR72QwRjHnPLxh9yYhw+jUq0caGGfqQ0sqS0OGbEw==
X-Received: by 2002:a7b:c5c4:0:b0:3d1:f234:12cc with SMTP id n4-20020a7bc5c4000000b003d1f23412ccmr31701058wmk.33.1671452518814;
        Mon, 19 Dec 2022 04:21:58 -0800 (PST)
Received: from localhost.localdomain (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
        by smtp.gmail.com with ESMTPSA id f24-20020a1c6a18000000b003b95ed78275sm11830868wmc.20.2022.12.19.04.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 04:21:58 -0800 (PST)
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-block@vger.kernel.org,
        Alvaro Karsz <alvaro.karsz@solid-run.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v5] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Date:   Mon, 19 Dec 2022 14:21:55 +0200
Message-Id: <20221219122155.333099-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Implement the VIRTIO_BLK_F_LIFETIME feature for Virtio block devices.

This commit introduces a new ioctl command, VIRTIO_BLK_IOCTL_GET_LIFETIME.

VIRTIO_BLK_IOCTL_GET_LIFETIME ioctl asks for the block device to provide
lifetime information by sending a VIRTIO_BLK_T_GET_LIFETIME command to
the device.

lifetime information fields:

- pre_eol_info: specifies the percentage of reserved blocks that are
		consumed.
		optional values following virtio spec:
		*) 0 - undefined.
		*) 1 - normal, < 80% of reserved blocks are consumed.
		*) 2 - warning, 80% of reserved blocks are consumed.
		*) 3 - urgent, 90% of reserved blocks are consumed.

- device_lifetime_est_typ_a: this field refers to wear of SLC cells and
			     is provided in increments of 10used, and so
			     on, thru to 11 meaning estimated lifetime
			     exceeded. All values above 11 are reserved.

- device_lifetime_est_typ_b: this field refers to wear of MLC cells and is
			     provided with the same semantics as
			     device_lifetime_est_typ_a.

The data received from the device will be sent as is to the user.
No data check/decode is done by virtblk.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
--
v2:
	- Remove (void *) casting.
	- Fix comments format in virtio_blk.h.
	- Set ioprio value for legacy devices for REQ_OP_DRV_IN
	  operations.

v3:
	- Initialize struct virtio_blk_lifetime to 0 instead of memset.
	- Rename ioctl from VBLK_LIFETIME to VBLK_GET_LIFETIME.
	- Return EOPNOTSUPP insted of ENOTTY if ioctl is not supported.
	- Check if process is CAP_SYS_ADMIN capable in lifetime ioctl.
	- Check if vdev is not NULL before accessing it in lifetime ioctl.

v4:
	- Create a dedicated virtio_blk_ioctl.h header for the ioctl command
	  and add this file to MAINTAINERS.
	- Rename the ioctl to VIRTIO_BLK_IOCTL_GET_LIFETIME.
	- Document in virtio_blk_ioctl.h which backend device can supply
	  this lifetime information.

v5:
	- Rebase patch on top of mst tree.
	- Add a comment explaining the capable(CAP_SYS_ADMIN) part.
--
---
 MAINTAINERS                           |   1 +
 drivers/block/virtio_blk.c            | 102 +++++++++++++++++++++++++-
 include/uapi/linux/virtio_blk.h       |  28 +++++++
 include/uapi/linux/virtio_blk_ioctl.h |  44 +++++++++++
 4 files changed, 173 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/linux/virtio_blk_ioctl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4aee796cc..3250f7753 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21724,6 +21724,7 @@ F:	drivers/block/virtio_blk.c
 F:	drivers/scsi/virtio_scsi.c
 F:	drivers/vhost/scsi.c
 F:	include/uapi/linux/virtio_blk.h
+F:	include/uapi/linux/virtio_blk_ioctl.h
 F:	include/uapi/linux/virtio_scsi.h
 
 VIRTIO CONSOLE DRIVER
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 3c9dae237..1e03bfa9f 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -9,6 +9,7 @@
 #include <linux/interrupt.h>
 #include <linux/virtio.h>
 #include <linux/virtio_blk.h>
+#include <linux/virtio_blk_ioctl.h>
 #include <linux/scatterlist.h>
 #include <linux/string_helpers.h>
 #include <linux/idr.h>
@@ -112,6 +113,18 @@ struct virtblk_req {
 	struct scatterlist sg[];
 };
 
+static inline int virtblk_ioctl_result(struct virtblk_req *vbr)
+{
+	switch (vbr->status) {
+	case VIRTIO_BLK_S_OK:
+		return 0;
+	case VIRTIO_BLK_S_UNSUPP:
+		return -EOPNOTSUPP;
+	default:
+		return -EIO;
+	}
+}
+
 static inline blk_status_t virtblk_result(u8 status)
 {
 	switch (status) {
@@ -840,6 +853,90 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
 	return ret;
 }
 
+/* Get lifetime information from device */
+static int virtblk_ioctl_lifetime(struct virtio_blk *vblk, unsigned long arg)
+{
+	struct request_queue *q = vblk->disk->queue;
+	struct request *req = NULL;
+	struct virtblk_req *vbr;
+	struct virtio_blk_lifetime lifetime = {};
+	int ret;
+
+	/* It's not clear whether exposing lifetime info to userspace
+	 * has any security implications but out of abundance of caution
+	 * we limit it to privileged users.
+	 */
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	/* The virtio_blk_lifetime struct fields follow virtio spec.
+	 * There is no check/decode on values received from the device.
+	 * The data is sent as is to the user.
+	 */
+
+	/* This ioctl is allowed only if VIRTIO_BLK_F_LIFETIME
+	 * feature is negotiated.
+	 */
+	if (!virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_LIFETIME))
+		return -EOPNOTSUPP;
+
+	req = blk_mq_alloc_request(q, REQ_OP_DRV_IN, 0);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	/* Write the correct type */
+	vbr = blk_mq_rq_to_pdu(req);
+	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_LIFETIME);
+	vbr->out_hdr.sector = 0;
+
+	ret = blk_rq_map_kern(q, req, &lifetime, sizeof(lifetime), GFP_KERNEL);
+	if (ret)
+		goto out;
+
+	blk_execute_rq(req, false);
+
+	ret = virtblk_ioctl_result(blk_mq_rq_to_pdu(req));
+	if (ret)
+		goto out;
+
+	/* Pass the data to the user */
+	if (copy_to_user((void __user *)arg, &lifetime, sizeof(lifetime))) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+out:
+	blk_mq_free_request(req);
+	return ret;
+}
+
+static int virtblk_ioctl(struct block_device *bd, fmode_t mode,
+			 unsigned int cmd, unsigned long arg)
+{
+	struct virtio_blk *vblk = bd->bd_disk->private_data;
+	int ret;
+
+	mutex_lock(&vblk->vdev_mutex);
+
+	if (!vblk->vdev) {
+		ret = -ENXIO;
+		goto exit;
+	}
+
+	switch (cmd) {
+	case VIRTIO_BLK_IOCTL_GET_LIFETIME:
+		ret = virtblk_ioctl_lifetime(vblk, arg);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+exit:
+	mutex_unlock(&vblk->vdev_mutex);
+	return ret;
+}
+
 static void virtblk_free_disk(struct gendisk *disk)
 {
 	struct virtio_blk *vblk = disk->private_data;
@@ -853,6 +950,7 @@ static const struct block_device_operations virtblk_fops = {
 	.owner  	= THIS_MODULE,
 	.getgeo		= virtblk_getgeo,
 	.free_disk	= virtblk_free_disk,
+	.ioctl		= virtblk_ioctl,
 	.report_zones	= virtblk_report_zones,
 };
 
@@ -1582,7 +1680,7 @@ static unsigned int features_legacy[] = {
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
-	VIRTIO_BLK_F_SECURE_ERASE,
+	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_LIFETIME,
 }
 ;
 static unsigned int features[] = {
@@ -1590,7 +1688,7 @@ static unsigned int features[] = {
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
-	VIRTIO_BLK_F_SECURE_ERASE,
+	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_LIFETIME,
 #ifdef CONFIG_BLK_DEV_ZONED
 	VIRTIO_BLK_F_ZONED,
 #endif /* CONFIG_BLK_DEV_ZONED */
diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index 3744e4da1..f4d5ee7c6 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -40,6 +40,7 @@
 #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
 #define VIRTIO_BLK_F_DISCARD	13	/* DISCARD is supported */
 #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
+#define VIRTIO_BLK_F_LIFETIME	15	/* Storage lifetime information is supported */
 #define VIRTIO_BLK_F_SECURE_ERASE	16 /* Secure Erase is supported */
 #define VIRTIO_BLK_F_ZONED		17	/* Zoned block device */
 
@@ -176,6 +177,9 @@ struct virtio_blk_config {
 /* Get device ID command */
 #define VIRTIO_BLK_T_GET_ID    8
 
+/* Get lifetime information command */
+#define VIRTIO_BLK_T_GET_LIFETIME 10
+
 /* Discard command */
 #define VIRTIO_BLK_T_DISCARD	11
 
@@ -304,6 +308,30 @@ struct virtio_blk_discard_write_zeroes {
 	__le32 flags;
 };
 
+/* Get lifetime information struct for each request */
+struct virtio_blk_lifetime {
+	/*
+	 * specifies the percentage of reserved blocks that are consumed.
+	 * optional values following virtio spec:
+	 * 0 - undefined
+	 * 1 - normal, < 80% of reserved blocks are consumed
+	 * 2 - warning, 80% of reserved blocks are consumed
+	 * 3 - urgent, 90% of reserved blocks are consumed
+	 */
+	__le16 pre_eol_info;
+	/*
+	 * this field refers to wear of SLC cells and is provided in increments of 10used,
+	 * and so on, thru to 11 meaning estimated lifetime exceeded. All values above 11
+	 * are reserved
+	 */
+	__le16 device_lifetime_est_typ_a;
+	/*
+	 * this field refers to wear of MLC cells and is provided with the same semantics as
+	 * device_lifetime_est_typ_a
+	 */
+	__le16 device_lifetime_est_typ_b;
+};
+
 #ifndef VIRTIO_BLK_NO_LEGACY
 struct virtio_scsi_inhdr {
 	__virtio32 errors;
diff --git a/include/uapi/linux/virtio_blk_ioctl.h b/include/uapi/linux/virtio_blk_ioctl.h
new file mode 100644
index 000000000..f87afb6be
--- /dev/null
+++ b/include/uapi/linux/virtio_blk_ioctl.h
@@ -0,0 +1,44 @@
+#ifndef _LINUX_VIRTIO_BLK_IOCTL_H
+#define _LINUX_VIRTIO_BLK_IOCTL_H
+/* This header is BSD licensed so anyone can use the definitions to implement
+ * compatible drivers/servers.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of IBM nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+#include <linux/ioctl.h>
+#include <linux/virtio_blk.h>
+
+/*
+ * The virtio_blk_lifetime fields can be reported by eMMC and UFS storage devices,
+ * which can predict and measure wear over time.
+ * eMMC/UFS storage devices are common in embedded systems, making this ioctl beneficial mostly
+ * for embedded systems using these type of storage as virtio-blk backend.
+ *
+ * Please note that virtio_blk_lifetime fields are little endian as defined in the virtio spec.
+ * Caller must convert the fields to the cpu endianness.
+ */
+#define VIRTIO_BLK_IOCTL_GET_LIFETIME   _IOR('r', 0, struct virtio_blk_lifetime)
+
+#endif /* _LINUX_VIRTIO_BLK_IOCTL_H */
-- 
2.32.0

