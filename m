Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A324E10A4E0
	for <lists+linux-block@lfdr.de>; Tue, 26 Nov 2019 20:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfKZTyo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 26 Nov 2019 14:54:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:40276 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726618AbfKZTyo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Nov 2019 14:54:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 882D6B061;
        Tue, 26 Nov 2019 19:54:41 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@google.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hou Tao <houtao1@huawei.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Hannes Reinecke <hare@suse.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 rebase 04/10] cdrom: export autoclose logic as a separate function
Date:   Tue, 26 Nov 2019 20:54:23 +0100
Message-Id: <80d5a59f37de16b6157987122001bc03f040bac8.1574797504.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1574797504.git.msuchanek@suse.de>
References: <cover.1574797504.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This allows the sr driver to call it without blocking other processes
accessing the device. This solves a issue with process waiting in open()
on broken drive to close the tray blocking out all access to the device,
including nonblocking access to determine drive status.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v2: new patch
v3:
 - change IOCTL to export
 - fix the logic about reporting cdroms inability to close tray
v4:
 - move the autoclose code to the open code, align debug messages with
 the open code
---
 drivers/cdrom/cdrom.c | 85 ++++++++++++++++++++++++++++++-------------
 include/linux/cdrom.h |  1 +
 2 files changed, 61 insertions(+), 25 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index b2bc0c8f9a69..38e6db879de0 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -1067,6 +1067,56 @@ static int cdrom_tray_close(struct cdrom_device_info *cdi)
 	return cdrom_wait_for_status_change(cdi, &ret);
 }
 
+int cdrom_autoclose(struct cdrom_device_info *cdi)
+{
+	int ret;
+	const struct cdrom_device_ops *cdo = cdi->ops;
+
+	cd_dbg(CD_OPEN, "entering cdrom_autoclose\n");
+	if (!cdo->drive_status)
+		return -EOPNOTSUPP;
+
+	ret = cdo->drive_status(cdi, CDSL_CURRENT);
+	cd_dbg(CD_OPEN, "drive_status=%d\n", ret);
+
+	if (ret == CDS_TRAY_OPEN) {
+		cd_dbg(CD_OPEN, "the tray is open...\n");
+		if (CDROM_CAN(CDC_CLOSE_TRAY)) {
+			if (!(cdi->options & CDO_AUTO_CLOSE))
+				return -ENOMEDIUM;
+			cd_dbg(CD_OPEN, "trying to close the tray\n");
+			ret = cdrom_tray_close(cdi);
+			if (ret == -ERESTARTSYS)
+				return ret;
+			if (ret) {
+				cd_dbg(CD_OPEN, "bummer. tried to close the tray but failed.\n");
+				return -ENOMEDIUM;
+			}
+			ret = cdo->drive_status(cdi, CDSL_CURRENT);
+			if (ret == CDS_NO_DISC)
+				cd_dbg(CD_OPEN, "tray might not contain a medium\n");
+		} else {
+			cd_dbg(CD_OPEN, "bummer. this drive can't close the tray.\n");
+			return -ENOMEDIUM;
+		}
+	}
+
+	if (ret == CDS_DRIVE_NOT_READY) {
+		int poll_res;
+
+		cd_dbg(CD_OPEN, "waiting for drive to become ready...\n");
+		poll_res = cdrom_wait_for_status_change(cdi, &ret);
+		if (poll_res == -ERESTARTSYS)
+			return poll_res;
+	}
+
+	if (ret != CDS_DISC_OK)
+		return -ENOMEDIUM;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cdrom_autoclose);
+
 static int open_for_common(struct cdrom_device_info *cdi, tracktype *tracks)
 {
 	int ret;
@@ -1080,35 +1130,20 @@ static int open_for_common(struct cdrom_device_info *cdi, tracktype *tracks)
 		cd_dbg(CD_OPEN, "drive_status=%d\n", ret);
 		if (ret == CDS_TRAY_OPEN) {
 			cd_dbg(CD_OPEN, "the tray is open...\n");
-			if (CDROM_CAN(CDC_CLOSE_TRAY)) {
-				if (!(cdi->options & CDO_AUTO_CLOSE))
-					return -ENOMEDIUM;
-				cd_dbg(CD_OPEN, "trying to close the tray\n");
-				ret = cdrom_tray_close(cdi);
-				if (ret == -ERESTARTSYS)
-					return ret;
-				if (ret) {
-					cd_dbg(CD_OPEN, "bummer. tried to close the tray but failed.\n");
-					return -ENOMEDIUM;
-				}
-				ret = cdo->drive_status(cdi, CDSL_CURRENT);
-				if (ret == CDS_NO_DISC)
-					cd_dbg(CD_OPEN, "tray might not contain a medium\n");
-			} else {
-				cd_dbg(CD_OPEN, "bummer. this drive can't close the tray.\n");
-				return -ENOMEDIUM;
-			}
+			return -ENOMEDIUM;
 		}
 		if (ret == CDS_DRIVE_NOT_READY) {
-			int poll_res;
-
-			cd_dbg(CD_OPEN, "waiting for drive to become ready...\n");
-			poll_res = cdrom_wait_for_status_change(cdi, &ret);
-			if (poll_res == -ERESTARTSYS)
-				return poll_res;
+			cd_dbg(CD_OPEN, "the drive is not ready...\n");
+			return -ENOMEDIUM;
 		}
-		if (ret != CDS_DISC_OK)
+		if (ret == CDS_NO_DISC) {
+			cd_dbg(CD_OPEN, "tray might not contain a medium...\n");
 			return -ENOMEDIUM;
+		}
+		if (ret != CDS_DISC_OK) {
+			cd_dbg(CD_OPEN, "drive returned status %i...\n", ret);
+			return -ENOMEDIUM;
+		}
 	}
 	cdrom_count_tracks(cdi, tracks);
 	if (tracks->error == CDS_NO_DISC) {
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index 528271c60018..ea0415ba9f9d 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -126,6 +126,7 @@ extern void init_cdrom_command(struct packet_command *cgc,
 			       void *buffer, int len, int type);
 extern int cdrom_dummy_generic_packet(struct cdrom_device_info *cdi,
 				      struct packet_command *cgc);
+int cdrom_autoclose(struct cdrom_device_info *cdi);
 
 /* The SCSI spec says there could be 256 slots. */
 #define CDROM_MAX_SLOTS	256
-- 
2.23.0

