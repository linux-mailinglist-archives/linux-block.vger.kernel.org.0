Return-Path: <linux-block+bounces-1246-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083DA817A47
	for <lists+linux-block@lfdr.de>; Mon, 18 Dec 2023 19:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BC781C21F92
	for <lists+linux-block@lfdr.de>; Mon, 18 Dec 2023 18:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53E972048;
	Mon, 18 Dec 2023 18:57:44 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7F91EB3F;
	Mon, 18 Dec 2023 18:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5c6839373f8so2283898a12.0;
        Mon, 18 Dec 2023 10:57:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702925862; x=1703530662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YL4JpXg+7aZ8VFMlENsPTAhR/w0OMGmrTl+lQ70Zyg=;
        b=lJLAk55b3eaMw1KV3ogroBcpjWFkkj9l+h+lMJJu0j5oeT1rBV4qrZWzSJ+qLGhGOb
         4GnUQVXvYLsWEaGSQ02JdaCPxcFh5tBggS+H3zKvQnAS85LhEqQCgoxupn4xYblUa/YI
         dEHz35YIRAbQQT7zFHEStsET+71TQJ/asf8xp501zux8YeC6kYgK+DVDU4y5qhP3iNTw
         2xfz8OdFCsJglzLez/kRFQxRcOmrAr5y4Yfnm2xd5wicWL5KSxeqY/27E/WUH8S9Ke3x
         icPgwwssBl/hfJny1kghcus5pBODibqFjEb1wMxkfEGHymjwjDjkNTbkwPEcnuf+1HRT
         7Nrw==
X-Gm-Message-State: AOJu0Yy8JY0CxtpJZHSgMWbfa595kqqu3bU7jvu4a5smKuW5XUsHc7cu
	6vgLRPNgeX8VKuRcme2fh/Q=
X-Google-Smtp-Source: AGHT+IF3FR7kZ36CebIJXuLTPpCVPu5G+Awv5KhfxxrQMt2iUzIEluE5x1E/3HvDWJcUZdYGkHEMuQ==
X-Received: by 2002:a05:6a21:7889:b0:194:7c07:5f55 with SMTP id bf9-20020a056a21788900b001947c075f55mr1300506pzc.54.1702925862508;
        Mon, 18 Dec 2023 10:57:42 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id n20-20020a056a0007d400b006d45707d8edsm3918397pfu.7.2023.12.18.10.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 10:57:41 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Avri Altman <avri.altman@wdc.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v7 09/19] scsi: core: Query the Block Limits Extension VPD page
Date: Mon, 18 Dec 2023 10:56:32 -0800
Message-ID: <20231218185705.2002516-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231218185705.2002516-1-bvanassche@acm.org>
References: <20231218185705.2002516-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse the Reduced Stream Control Supported (RSCS) bit from the block
limits extension VPD page. The RSCS bit is defined in SBC-5 r05
(https://www.t10.org/cgi-bin/ac.pl?t=f&f=sbc5r05.pdf).

Reviewed-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Daejun Park <daejun7.park@samsung.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi.c        |  2 ++
 drivers/scsi/scsi_sysfs.c  | 10 ++++++++++
 drivers/scsi/sd.c          | 13 +++++++++++++
 drivers/scsi/sd.h          |  1 +
 include/scsi/scsi_device.h |  1 +
 5 files changed, 27 insertions(+)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 76d369343c7a..74cc3369dd8d 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -499,6 +499,8 @@ void scsi_attach_vpd(struct scsi_device *sdev)
 			scsi_update_vpd_page(sdev, 0xb1, &sdev->vpd_pgb1);
 		if (vpd_buf->data[i] == 0xb2)
 			scsi_update_vpd_page(sdev, 0xb2, &sdev->vpd_pgb2);
+		if (vpd_buf->data[i] == 0xb7)
+			scsi_update_vpd_page(sdev, 0xb7, &sdev->vpd_pgb7);
 	}
 	kfree(vpd_buf);
 }
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 24f6eefb6803..93652a786a46 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -449,6 +449,7 @@ static void scsi_device_dev_release(struct device *dev)
 	struct scsi_vpd *vpd_pg80 = NULL, *vpd_pg83 = NULL;
 	struct scsi_vpd *vpd_pg0 = NULL, *vpd_pg89 = NULL;
 	struct scsi_vpd *vpd_pgb0 = NULL, *vpd_pgb1 = NULL, *vpd_pgb2 = NULL;
+	struct scsi_vpd *vpd_pgb7 = NULL;
 	unsigned long flags;
 
 	might_sleep();
@@ -494,6 +495,8 @@ static void scsi_device_dev_release(struct device *dev)
 				       lockdep_is_held(&sdev->inquiry_mutex));
 	vpd_pgb2 = rcu_replace_pointer(sdev->vpd_pgb2, vpd_pgb2,
 				       lockdep_is_held(&sdev->inquiry_mutex));
+	vpd_pgb7 = rcu_replace_pointer(sdev->vpd_pgb7, vpd_pgb7,
+				       lockdep_is_held(&sdev->inquiry_mutex));
 	mutex_unlock(&sdev->inquiry_mutex);
 
 	if (vpd_pg0)
@@ -510,6 +513,8 @@ static void scsi_device_dev_release(struct device *dev)
 		kfree_rcu(vpd_pgb1, rcu);
 	if (vpd_pgb2)
 		kfree_rcu(vpd_pgb2, rcu);
+	if (vpd_pgb7)
+		kfree_rcu(vpd_pgb7, rcu);
 	kfree(sdev->inquiry);
 	kfree(sdev);
 
@@ -921,6 +926,7 @@ sdev_vpd_pg_attr(pg89);
 sdev_vpd_pg_attr(pgb0);
 sdev_vpd_pg_attr(pgb1);
 sdev_vpd_pg_attr(pgb2);
+sdev_vpd_pg_attr(pgb7);
 sdev_vpd_pg_attr(pg0);
 
 static ssize_t show_inquiry(struct file *filep, struct kobject *kobj,
@@ -1295,6 +1301,9 @@ static umode_t scsi_sdev_bin_attr_is_visible(struct kobject *kobj,
 	if (attr == &dev_attr_vpd_pgb2 && !sdev->vpd_pgb2)
 		return 0;
 
+	if (attr == &dev_attr_vpd_pgb7 && !sdev->vpd_pgb7)
+		return 0;
+
 	return S_IRUGO;
 }
 
@@ -1347,6 +1356,7 @@ static struct bin_attribute *scsi_sdev_bin_attrs[] = {
 	&dev_attr_vpd_pgb0,
 	&dev_attr_vpd_pgb1,
 	&dev_attr_vpd_pgb2,
+	&dev_attr_vpd_pgb7,
 	&dev_attr_inquiry,
 	NULL
 };
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 530918cbfce2..56c4310a741b 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3103,6 +3103,18 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
 	rcu_read_unlock();
 }
 
+/* Parse the Block Limits Extension VPD page (0xb7) */
+static void sd_read_block_limits_ext(struct scsi_disk *sdkp)
+{
+	struct scsi_vpd *vpd;
+
+	rcu_read_lock();
+	vpd = rcu_dereference(sdkp->device->vpd_pgb7);
+	if (vpd && vpd->len >= 2)
+		sdkp->rscs = vpd->data[5] & 1;
+	rcu_read_unlock();
+}
+
 /**
  * sd_read_block_characteristics - Query block dev. characteristics
  * @sdkp: disk to query
@@ -3457,6 +3469,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 		if (scsi_device_supports_vpd(sdp)) {
 			sd_read_block_provisioning(sdkp);
 			sd_read_block_limits(sdkp);
+			sd_read_block_limits_ext(sdkp);
 			sd_read_block_characteristics(sdkp);
 			sd_zbc_read_zones(sdkp, buffer);
 			sd_read_cpr(sdkp);
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 409dda5350d1..e4539122f2a2 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -151,6 +151,7 @@ struct scsi_disk {
 	unsigned	urswrz : 1;
 	unsigned	security : 1;
 	unsigned	ignore_medium_access_errors : 1;
+	bool		rscs : 1; /* reduced stream control support */
 };
 #define to_scsi_disk(obj) container_of(obj, struct scsi_disk, disk_dev)
 
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 10480eb582b2..a1588f3965f9 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -153,6 +153,7 @@ struct scsi_device {
 	struct scsi_vpd __rcu *vpd_pgb0;
 	struct scsi_vpd __rcu *vpd_pgb1;
 	struct scsi_vpd __rcu *vpd_pgb2;
+	struct scsi_vpd __rcu *vpd_pgb7;
 
 	struct scsi_target      *sdev_target;
 

