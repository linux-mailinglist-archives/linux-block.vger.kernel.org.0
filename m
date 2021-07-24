Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05FE3D45E7
	for <lists+linux-block@lfdr.de>; Sat, 24 Jul 2021 09:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbhGXGvL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 24 Jul 2021 02:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbhGXGvL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Jul 2021 02:51:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132FDC061575;
        Sat, 24 Jul 2021 00:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TXLjCGBzNCraw3wgHQUk1fiA2PWPevl08M+7WuaBaFo=; b=tvo/hjLrPXk4ow3N4spaEcAink
        JOLpHRy/BKDW7juInnFZaAXqsxGVN8JVGVGj+7ecaZall11LZ5d2/BYfKSYr6KoTsmN+xSMiv8HqF
        86pPAwPkvGzGexSCiAEFPQCslGIs/yOuXRKe+/qCX36ptWRDEL8q/ytl+pmnUSw3iy+tvFt/NQsHi
        OPx+PHPnHtkK9G45owCilucCGfNhaxM6E0p6acr9Wus7A2iZayxXqjejUlomyrpI6aL1wErWSQqye
        TBnCE98vwZK1YQDpCHhJ1ByD7o8Fg5m+JknEupSccqYBjN8xrvRTr96Kn1y7FoycYihv4gLXQbddJ
        SdYCSoFA==;
Received: from [2001:4bb8:184:87c5:85d0:a26b:ef67:d32c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7C7K-00C5U9-Jl; Sat, 24 Jul 2021 07:30:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc:     Doug Gilbert <dgilbert@interlog.com>,
        =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 18/24] scsi_ioctl: move the "block layer" SCSI ioctl handling to drivers/scsi
Date:   Sat, 24 Jul 2021 09:20:27 +0200
Message-Id: <20210724072033.1284840-19-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210724072033.1284840-1-hch@lst.de>
References: <20210724072033.1284840-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Merge the ioctl handling in block/scsi_ioctl.c into its only caller in
drivers/scsi/scsi_ioctl.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/Makefile            |   1 -
 block/scsi_ioctl.c        | 796 --------------------------------------
 drivers/scsi/scsi_ioctl.c | 740 ++++++++++++++++++++++++++++++++++-
 include/linux/blkdev.h    |  11 -
 include/scsi/scsi_ioctl.h |   6 +
 5 files changed, 741 insertions(+), 813 deletions(-)
 delete mode 100644 block/scsi_ioctl.c

diff --git a/block/Makefile b/block/Makefile
index f37d532c8da5..640afba070fd 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -12,7 +12,6 @@ obj-$(CONFIG_BLOCK) := bio.o elevator.o blk-core.o blk-sysfs.o \
 			disk-events.o
 
 obj-$(CONFIG_BOUNCE)		+= bounce.o
-obj-$(CONFIG_BLK_SCSI_REQUEST)	+= scsi_ioctl.o
 obj-$(CONFIG_BLK_DEV_BSG_COMMON) += bsg.o
 obj-$(CONFIG_BLK_DEV_BSGLIB)	+= bsg-lib.o
 obj-$(CONFIG_BLK_CGROUP)	+= blk-cgroup.o
diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
deleted file mode 100644
index 3642e145108a..000000000000
--- a/block/scsi_ioctl.c
+++ /dev/null
@@ -1,796 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2001 Jens Axboe <axboe@suse.de>
- */
-#include <linux/compat.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/module.h>
-#include <linux/blkdev.h>
-#include <linux/capability.h>
-#include <linux/completion.h>
-#include <linux/cdrom.h>
-#include <linux/ratelimit.h>
-#include <linux/slab.h>
-#include <linux/times.h>
-#include <linux/uio.h>
-#include <linux/uaccess.h>
-
-#include <scsi/scsi.h>
-#include <scsi/scsi_ioctl.h>
-#include <scsi/scsi_cmnd.h>
-#include <scsi/sg.h>
-
-static int sg_get_version(int __user *p)
-{
-	static const int sg_version_num = 30527;
-	return put_user(sg_version_num, p);
-}
-
-static int sg_get_timeout(struct request_queue *q)
-{
-	return jiffies_to_clock_t(q->sg_timeout);
-}
-
-static int sg_set_timeout(struct request_queue *q, int __user *p)
-{
-	int timeout, err = get_user(timeout, p);
-
-	if (!err)
-		q->sg_timeout = clock_t_to_jiffies(timeout);
-
-	return err;
-}
-
-static int sg_get_reserved_size(struct request_queue *q, int __user *p)
-{
-	int val = min(q->sg_reserved_size, queue_max_bytes(q));
-
-	return put_user(val, p);
-}
-
-static int sg_set_reserved_size(struct request_queue *q, int __user *p)
-{
-	int size, err = get_user(size, p);
-
-	if (err)
-		return err;
-
-	if (size < 0)
-		return -EINVAL;
-
-	q->sg_reserved_size = min_t(unsigned int, size, queue_max_bytes(q));
-	return 0;
-}
-
-/*
- * will always return that we are ATAPI even for a real SCSI drive, I'm not
- * so sure this is worth doing anything about (why would you care??)
- */
-static int sg_emulated_host(struct request_queue *q, int __user *p)
-{
-	return put_user(1, p);
-}
-
-/*
- * Check if the given command is allowed.
- *
- * For unprivileged users only a small set of whitelisted command is allowed so
- * that they can't format the drive or update the firmware.
- */
-bool scsi_cmd_allowed(unsigned char *cmd, fmode_t mode)
-{
-	/* root can do any command. */
-	if (capable(CAP_SYS_RAWIO))
-		return true;
-
-	/* Anybody who can open the device can do a read-safe command */
-	switch (cmd[0]) {
-	/* Basic read-only commands */
-	case TEST_UNIT_READY:
-	case REQUEST_SENSE:
-	case READ_6:
-	case READ_10:
-	case READ_12:
-	case READ_16:
-	case READ_BUFFER:
-	case READ_DEFECT_DATA:
-	case READ_CAPACITY: /* also GPCMD_READ_CDVD_CAPACITY */
-	case READ_LONG:
-	case INQUIRY:
-	case MODE_SENSE:
-	case MODE_SENSE_10:
-	case LOG_SENSE:
-	case START_STOP:
-	case GPCMD_VERIFY_10:
-	case VERIFY_16:
-	case REPORT_LUNS:
-	case SERVICE_ACTION_IN_16:
-	case RECEIVE_DIAGNOSTIC:
-	case MAINTENANCE_IN: /* also GPCMD_SEND_KEY, which is a write command */
-	case GPCMD_READ_BUFFER_CAPACITY:
-	/* Audio CD commands */
-	case GPCMD_PLAY_CD:
-	case GPCMD_PLAY_AUDIO_10:
-	case GPCMD_PLAY_AUDIO_MSF:
-	case GPCMD_PLAY_AUDIO_TI:
-	case GPCMD_PAUSE_RESUME:
-	/* CD/DVD data reading */
-	case GPCMD_READ_CD:
-	case GPCMD_READ_CD_MSF:
-	case GPCMD_READ_DISC_INFO:
-	case GPCMD_READ_DVD_STRUCTURE:
-	case GPCMD_READ_HEADER:
-	case GPCMD_READ_TRACK_RZONE_INFO:
-	case GPCMD_READ_SUBCHANNEL:
-	case GPCMD_READ_TOC_PMA_ATIP:
-	case GPCMD_REPORT_KEY:
-	case GPCMD_SCAN:
-	case GPCMD_GET_CONFIGURATION:
-	case GPCMD_READ_FORMAT_CAPACITIES:
-	case GPCMD_GET_EVENT_STATUS_NOTIFICATION:
-	case GPCMD_GET_PERFORMANCE:
-	case GPCMD_SEEK:
-	case GPCMD_STOP_PLAY_SCAN:
-	/* ZBC */
-	case ZBC_IN:
-		return true;
-	/* Basic writing commands */
-	case WRITE_6:
-	case WRITE_10:
-	case WRITE_VERIFY:
-	case WRITE_12:
-	case WRITE_VERIFY_12:
-	case WRITE_16:
-	case WRITE_LONG:
-	case WRITE_LONG_2:
-	case WRITE_SAME:
-	case WRITE_SAME_16:
-	case WRITE_SAME_32:
-	case ERASE:
-	case GPCMD_MODE_SELECT_10:
-	case MODE_SELECT:
-	case LOG_SELECT:
-	case GPCMD_BLANK:
-	case GPCMD_CLOSE_TRACK:
-	case GPCMD_FLUSH_CACHE:
-	case GPCMD_FORMAT_UNIT:
-	case GPCMD_REPAIR_RZONE_TRACK:
-	case GPCMD_RESERVE_RZONE_TRACK:
-	case GPCMD_SEND_DVD_STRUCTURE:
-	case GPCMD_SEND_EVENT:
-	case GPCMD_SEND_OPC:
-	case GPCMD_SEND_CUE_SHEET:
-	case GPCMD_SET_SPEED:
-	case GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL:
-	case GPCMD_LOAD_UNLOAD:
-	case GPCMD_SET_STREAMING:
-	case GPCMD_SET_READ_AHEAD:
-	/* ZBC */
-	case ZBC_OUT:
-		return (mode & FMODE_WRITE);
-	default:
-		return false;
-	}
-}
-EXPORT_SYMBOL(scsi_cmd_allowed);
-
-static int blk_fill_sghdr_rq(struct request_queue *q, struct request *rq,
-			     struct sg_io_hdr *hdr, fmode_t mode)
-{
-	struct scsi_request *req = scsi_req(rq);
-
-	if (copy_from_user(req->cmd, hdr->cmdp, hdr->cmd_len))
-		return -EFAULT;
-	if (!scsi_cmd_allowed(req->cmd, mode))
-		return -EPERM;
-
-	/*
-	 * fill in request structure
-	 */
-	req->cmd_len = hdr->cmd_len;
-
-	rq->timeout = msecs_to_jiffies(hdr->timeout);
-	if (!rq->timeout)
-		rq->timeout = q->sg_timeout;
-	if (!rq->timeout)
-		rq->timeout = BLK_DEFAULT_SG_TIMEOUT;
-	if (rq->timeout < BLK_MIN_SG_TIMEOUT)
-		rq->timeout = BLK_MIN_SG_TIMEOUT;
-
-	return 0;
-}
-
-static int blk_complete_sghdr_rq(struct request *rq, struct sg_io_hdr *hdr,
-				 struct bio *bio)
-{
-	struct scsi_request *req = scsi_req(rq);
-	int r, ret = 0;
-
-	/*
-	 * fill in all the output members
-	 */
-	hdr->status = req->result & 0xff;
-	hdr->masked_status = status_byte(req->result);
-	hdr->msg_status = COMMAND_COMPLETE;
-	hdr->host_status = host_byte(req->result);
-	hdr->driver_status = 0;
-	if (scsi_status_is_check_condition(hdr->status))
-		hdr->driver_status = DRIVER_SENSE;
-	hdr->info = 0;
-	if (hdr->masked_status || hdr->host_status || hdr->driver_status)
-		hdr->info |= SG_INFO_CHECK;
-	hdr->resid = req->resid_len;
-	hdr->sb_len_wr = 0;
-
-	if (req->sense_len && hdr->sbp) {
-		int len = min((unsigned int) hdr->mx_sb_len, req->sense_len);
-
-		if (!copy_to_user(hdr->sbp, req->sense, len))
-			hdr->sb_len_wr = len;
-		else
-			ret = -EFAULT;
-	}
-
-	r = blk_rq_unmap_user(bio);
-	if (!ret)
-		ret = r;
-
-	return ret;
-}
-
-static int sg_io(struct request_queue *q, struct gendisk *bd_disk,
-		struct sg_io_hdr *hdr, fmode_t mode)
-{
-	unsigned long start_time;
-	ssize_t ret = 0;
-	int writing = 0;
-	int at_head = 0;
-	struct request *rq;
-	struct scsi_request *req;
-	struct bio *bio;
-
-	if (hdr->interface_id != 'S')
-		return -EINVAL;
-
-	if (hdr->dxfer_len > (queue_max_hw_sectors(q) << 9))
-		return -EIO;
-
-	if (hdr->dxfer_len)
-		switch (hdr->dxfer_direction) {
-		default:
-			return -EINVAL;
-		case SG_DXFER_TO_DEV:
-			writing = 1;
-			break;
-		case SG_DXFER_TO_FROM_DEV:
-		case SG_DXFER_FROM_DEV:
-			break;
-		}
-	if (hdr->flags & SG_FLAG_Q_AT_HEAD)
-		at_head = 1;
-
-	ret = -ENOMEM;
-	rq = blk_get_request(q, writing ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN, 0);
-	if (IS_ERR(rq))
-		return PTR_ERR(rq);
-	req = scsi_req(rq);
-
-	if (hdr->cmd_len > BLK_MAX_CDB) {
-		req->cmd = kzalloc(hdr->cmd_len, GFP_KERNEL);
-		if (!req->cmd)
-			goto out_put_request;
-	}
-
-	ret = blk_fill_sghdr_rq(q, rq, hdr, mode);
-	if (ret < 0)
-		goto out_free_cdb;
-
-	ret = 0;
-	if (hdr->iovec_count) {
-		struct iov_iter i;
-		struct iovec *iov = NULL;
-
-		ret = import_iovec(rq_data_dir(rq), hdr->dxferp,
-				   hdr->iovec_count, 0, &iov, &i);
-		if (ret < 0)
-			goto out_free_cdb;
-
-		/* SG_IO howto says that the shorter of the two wins */
-		iov_iter_truncate(&i, hdr->dxfer_len);
-
-		ret = blk_rq_map_user_iov(q, rq, NULL, &i, GFP_KERNEL);
-		kfree(iov);
-	} else if (hdr->dxfer_len)
-		ret = blk_rq_map_user(q, rq, NULL, hdr->dxferp, hdr->dxfer_len,
-				      GFP_KERNEL);
-
-	if (ret)
-		goto out_free_cdb;
-
-	bio = rq->bio;
-	req->retries = 0;
-
-	start_time = jiffies;
-
-	blk_execute_rq(bd_disk, rq, at_head);
-
-	hdr->duration = jiffies_to_msecs(jiffies - start_time);
-
-	ret = blk_complete_sghdr_rq(rq, hdr, bio);
-
-out_free_cdb:
-	scsi_req_free_cmd(req);
-out_put_request:
-	blk_put_request(rq);
-	return ret;
-}
-
-/**
- * sg_scsi_ioctl  --  handle deprecated SCSI_IOCTL_SEND_COMMAND ioctl
- * @q:		request queue to send scsi commands down
- * @disk:	gendisk to operate on (option)
- * @mode:	mode used to open the file through which the ioctl has been
- *		submitted
- * @sic:	userspace structure describing the command to perform
- *
- * Send down the scsi command described by @sic to the device below
- * the request queue @q.  If @file is non-NULL it's used to perform
- * fine-grained permission checks that allow users to send down
- * non-destructive SCSI commands.  If the caller has a struct gendisk
- * available it should be passed in as @disk to allow the low level
- * driver to use the information contained in it.  A non-NULL @disk
- * is only allowed if the caller knows that the low level driver doesn't
- * need it (e.g. in the scsi subsystem).
- *
- * Notes:
- *   -  This interface is deprecated - users should use the SG_IO
- *      interface instead, as this is a more flexible approach to
- *      performing SCSI commands on a device.
- *   -  The SCSI command length is determined by examining the 1st byte
- *      of the given command. There is no way to override this.
- *   -  Data transfers are limited to PAGE_SIZE
- *   -  The length (x + y) must be at least OMAX_SB_LEN bytes long to
- *      accommodate the sense buffer when an error occurs.
- *      The sense buffer is truncated to OMAX_SB_LEN (16) bytes so that
- *      old code will not be surprised.
- *   -  If a Unix error occurs (e.g. ENOMEM) then the user will receive
- *      a negative return and the Unix error code in 'errno'.
- *      If the SCSI command succeeds then 0 is returned.
- *      Positive numbers returned are the compacted SCSI error codes (4
- *      bytes in one int) where the lowest byte is the SCSI status.
- */
-int sg_scsi_ioctl(struct request_queue *q, struct gendisk *disk, fmode_t mode,
-		struct scsi_ioctl_command __user *sic)
-{
-	enum { OMAX_SB_LEN = 16 };	/* For backward compatibility */
-	struct request *rq;
-	struct scsi_request *req;
-	int err;
-	unsigned int in_len, out_len, bytes, opcode, cmdlen;
-	char *buffer = NULL;
-
-	if (!sic)
-		return -EINVAL;
-
-	/*
-	 * get in an out lengths, verify they don't exceed a page worth of data
-	 */
-	if (get_user(in_len, &sic->inlen))
-		return -EFAULT;
-	if (get_user(out_len, &sic->outlen))
-		return -EFAULT;
-	if (in_len > PAGE_SIZE || out_len > PAGE_SIZE)
-		return -EINVAL;
-	if (get_user(opcode, sic->data))
-		return -EFAULT;
-
-	bytes = max(in_len, out_len);
-	if (bytes) {
-		buffer = kzalloc(bytes, GFP_NOIO | GFP_USER | __GFP_NOWARN);
-		if (!buffer)
-			return -ENOMEM;
-
-	}
-
-	rq = blk_get_request(q, in_len ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN, 0);
-	if (IS_ERR(rq)) {
-		err = PTR_ERR(rq);
-		goto error_free_buffer;
-	}
-	req = scsi_req(rq);
-
-	cmdlen = COMMAND_SIZE(opcode);
-
-	/*
-	 * get command and data to send to device, if any
-	 */
-	err = -EFAULT;
-	req->cmd_len = cmdlen;
-	if (copy_from_user(req->cmd, sic->data, cmdlen))
-		goto error;
-
-	if (in_len && copy_from_user(buffer, sic->data + cmdlen, in_len))
-		goto error;
-
-	err = -EPERM;
-	if (!scsi_cmd_allowed(req->cmd, mode))
-		goto error;
-
-	/* default.  possible overriden later */
-	req->retries = 5;
-
-	switch (opcode) {
-	case SEND_DIAGNOSTIC:
-	case FORMAT_UNIT:
-		rq->timeout = FORMAT_UNIT_TIMEOUT;
-		req->retries = 1;
-		break;
-	case START_STOP:
-		rq->timeout = START_STOP_TIMEOUT;
-		break;
-	case MOVE_MEDIUM:
-		rq->timeout = MOVE_MEDIUM_TIMEOUT;
-		break;
-	case READ_ELEMENT_STATUS:
-		rq->timeout = READ_ELEMENT_STATUS_TIMEOUT;
-		break;
-	case READ_DEFECT_DATA:
-		rq->timeout = READ_DEFECT_DATA_TIMEOUT;
-		req->retries = 1;
-		break;
-	default:
-		rq->timeout = BLK_DEFAULT_SG_TIMEOUT;
-		break;
-	}
-
-	if (bytes) {
-		err = blk_rq_map_kern(q, rq, buffer, bytes, GFP_NOIO);
-		if (err)
-			goto error;
-	}
-
-	blk_execute_rq(disk, rq, 0);
-
-	err = req->result & 0xff;	/* only 8 bit SCSI status */
-	if (err) {
-		if (req->sense_len && req->sense) {
-			bytes = (OMAX_SB_LEN > req->sense_len) ?
-				req->sense_len : OMAX_SB_LEN;
-			if (copy_to_user(sic->data, req->sense, bytes))
-				err = -EFAULT;
-		}
-	} else {
-		if (copy_to_user(sic->data, buffer, out_len))
-			err = -EFAULT;
-	}
-	
-error:
-	blk_put_request(rq);
-
-error_free_buffer:
-	kfree(buffer);
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(sg_scsi_ioctl);
-
-/* Send basic block requests */
-static int __blk_send_generic(struct request_queue *q, struct gendisk *bd_disk,
-			      int cmd, int data)
-{
-	struct request *rq;
-	int err;
-
-	rq = blk_get_request(q, REQ_OP_DRV_OUT, 0);
-	if (IS_ERR(rq))
-		return PTR_ERR(rq);
-	rq->timeout = BLK_DEFAULT_SG_TIMEOUT;
-	scsi_req(rq)->cmd[0] = cmd;
-	scsi_req(rq)->cmd[4] = data;
-	scsi_req(rq)->cmd_len = 6;
-	blk_execute_rq(bd_disk, rq, 0);
-	err = scsi_req(rq)->result ? -EIO : 0;
-	blk_put_request(rq);
-
-	return err;
-}
-
-static inline int blk_send_start_stop(struct request_queue *q,
-				      struct gendisk *bd_disk, int data)
-{
-	return __blk_send_generic(q, bd_disk, GPCMD_START_STOP_UNIT, data);
-}
-
-int put_sg_io_hdr(const struct sg_io_hdr *hdr, void __user *argp)
-{
-#ifdef CONFIG_COMPAT
-	if (in_compat_syscall()) {
-		struct compat_sg_io_hdr hdr32 =  {
-			.interface_id	 = hdr->interface_id,
-			.dxfer_direction = hdr->dxfer_direction,
-			.cmd_len	 = hdr->cmd_len,
-			.mx_sb_len	 = hdr->mx_sb_len,
-			.iovec_count	 = hdr->iovec_count,
-			.dxfer_len	 = hdr->dxfer_len,
-			.dxferp		 = (uintptr_t)hdr->dxferp,
-			.cmdp		 = (uintptr_t)hdr->cmdp,
-			.sbp		 = (uintptr_t)hdr->sbp,
-			.timeout	 = hdr->timeout,
-			.flags		 = hdr->flags,
-			.pack_id	 = hdr->pack_id,
-			.usr_ptr	 = (uintptr_t)hdr->usr_ptr,
-			.status		 = hdr->status,
-			.masked_status	 = hdr->masked_status,
-			.msg_status	 = hdr->msg_status,
-			.sb_len_wr	 = hdr->sb_len_wr,
-			.host_status	 = hdr->host_status,
-			.driver_status	 = hdr->driver_status,
-			.resid		 = hdr->resid,
-			.duration	 = hdr->duration,
-			.info		 = hdr->info,
-		};
-
-		if (copy_to_user(argp, &hdr32, sizeof(hdr32)))
-			return -EFAULT;
-
-		return 0;
-	}
-#endif
-
-	if (copy_to_user(argp, hdr, sizeof(*hdr)))
-		return -EFAULT;
-
-	return 0;
-}
-EXPORT_SYMBOL(put_sg_io_hdr);
-
-int get_sg_io_hdr(struct sg_io_hdr *hdr, const void __user *argp)
-{
-#ifdef CONFIG_COMPAT
-	struct compat_sg_io_hdr hdr32;
-
-	if (in_compat_syscall()) {
-		if (copy_from_user(&hdr32, argp, sizeof(hdr32)))
-			return -EFAULT;
-
-		*hdr = (struct sg_io_hdr) {
-			.interface_id	 = hdr32.interface_id,
-			.dxfer_direction = hdr32.dxfer_direction,
-			.cmd_len	 = hdr32.cmd_len,
-			.mx_sb_len	 = hdr32.mx_sb_len,
-			.iovec_count	 = hdr32.iovec_count,
-			.dxfer_len	 = hdr32.dxfer_len,
-			.dxferp		 = compat_ptr(hdr32.dxferp),
-			.cmdp		 = compat_ptr(hdr32.cmdp),
-			.sbp		 = compat_ptr(hdr32.sbp),
-			.timeout	 = hdr32.timeout,
-			.flags		 = hdr32.flags,
-			.pack_id	 = hdr32.pack_id,
-			.usr_ptr	 = compat_ptr(hdr32.usr_ptr),
-			.status		 = hdr32.status,
-			.masked_status	 = hdr32.masked_status,
-			.msg_status	 = hdr32.msg_status,
-			.sb_len_wr	 = hdr32.sb_len_wr,
-			.host_status	 = hdr32.host_status,
-			.driver_status	 = hdr32.driver_status,
-			.resid		 = hdr32.resid,
-			.duration	 = hdr32.duration,
-			.info		 = hdr32.info,
-		};
-
-		return 0;
-	}
-#endif
-
-	if (copy_from_user(hdr, argp, sizeof(*hdr)))
-		return -EFAULT;
-
-	return 0;
-}
-EXPORT_SYMBOL(get_sg_io_hdr);
-
-#ifdef CONFIG_COMPAT
-struct compat_cdrom_generic_command {
-	unsigned char	cmd[CDROM_PACKET_SIZE];
-	compat_caddr_t	buffer;
-	compat_uint_t	buflen;
-	compat_int_t	stat;
-	compat_caddr_t	sense;
-	unsigned char	data_direction;
-	unsigned char	pad[3];
-	compat_int_t	quiet;
-	compat_int_t	timeout;
-	compat_caddr_t	unused;
-};
-#endif
-
-static int scsi_get_cdrom_generic_arg(struct cdrom_generic_command *cgc,
-				      const void __user *arg)
-{
-#ifdef CONFIG_COMPAT
-	if (in_compat_syscall()) {
-		struct compat_cdrom_generic_command cgc32;
-
-		if (copy_from_user(&cgc32, arg, sizeof(cgc32)))
-			return -EFAULT;
-
-		*cgc = (struct cdrom_generic_command) {
-			.buffer		= compat_ptr(cgc32.buffer),
-			.buflen		= cgc32.buflen,
-			.stat		= cgc32.stat,
-			.sense		= compat_ptr(cgc32.sense),
-			.data_direction	= cgc32.data_direction,
-			.quiet		= cgc32.quiet,
-			.timeout	= cgc32.timeout,
-			.unused		= compat_ptr(cgc32.unused),
-		};
-		memcpy(&cgc->cmd, &cgc32.cmd, CDROM_PACKET_SIZE);
-		return 0;
-	}
-#endif
-	if (copy_from_user(cgc, arg, sizeof(*cgc)))
-		return -EFAULT;
-
-	return 0;
-}
-
-static int scsi_put_cdrom_generic_arg(const struct cdrom_generic_command *cgc,
-				      void __user *arg)
-{
-#ifdef CONFIG_COMPAT
-	if (in_compat_syscall()) {
-		struct compat_cdrom_generic_command cgc32 = {
-			.buffer		= (uintptr_t)(cgc->buffer),
-			.buflen		= cgc->buflen,
-			.stat		= cgc->stat,
-			.sense		= (uintptr_t)(cgc->sense),
-			.data_direction	= cgc->data_direction,
-			.quiet		= cgc->quiet,
-			.timeout	= cgc->timeout,
-			.unused		= (uintptr_t)(cgc->unused),
-		};
-		memcpy(&cgc32.cmd, &cgc->cmd, CDROM_PACKET_SIZE);
-
-		if (copy_to_user(arg, &cgc32, sizeof(cgc32)))
-			return -EFAULT;
-
-		return 0;
-	}
-#endif
-	if (copy_to_user(arg, cgc, sizeof(*cgc)))
-		return -EFAULT;
-
-	return 0;
-}
-
-static int scsi_cdrom_send_packet(struct request_queue *q,
-				  struct gendisk *bd_disk,
-				  fmode_t mode, void __user *arg)
-{
-	struct cdrom_generic_command cgc;
-	struct sg_io_hdr hdr;
-	int err;
-
-	err = scsi_get_cdrom_generic_arg(&cgc, arg);
-	if (err)
-		return err;
-
-	cgc.timeout = clock_t_to_jiffies(cgc.timeout);
-	memset(&hdr, 0, sizeof(hdr));
-	hdr.interface_id = 'S';
-	hdr.cmd_len = sizeof(cgc.cmd);
-	hdr.dxfer_len = cgc.buflen;
-	switch (cgc.data_direction) {
-		case CGC_DATA_UNKNOWN:
-			hdr.dxfer_direction = SG_DXFER_UNKNOWN;
-			break;
-		case CGC_DATA_WRITE:
-			hdr.dxfer_direction = SG_DXFER_TO_DEV;
-			break;
-		case CGC_DATA_READ:
-			hdr.dxfer_direction = SG_DXFER_FROM_DEV;
-			break;
-		case CGC_DATA_NONE:
-			hdr.dxfer_direction = SG_DXFER_NONE;
-			break;
-		default:
-			return -EINVAL;
-	}
-
-	hdr.dxferp = cgc.buffer;
-	hdr.sbp = cgc.sense;
-	if (hdr.sbp)
-		hdr.mx_sb_len = sizeof(struct request_sense);
-	hdr.timeout = jiffies_to_msecs(cgc.timeout);
-	hdr.cmdp = ((struct cdrom_generic_command __user*) arg)->cmd;
-	hdr.cmd_len = sizeof(cgc.cmd);
-
-	err = sg_io(q, bd_disk, &hdr, mode);
-	if (err == -EFAULT)
-		return -EFAULT;
-
-	if (hdr.status)
-		return -EIO;
-
-	cgc.stat = err;
-	cgc.buflen = hdr.resid;
-	if (scsi_put_cdrom_generic_arg(&cgc, arg))
-		return -EFAULT;
-
-	return err;
-}
-
-int scsi_cmd_ioctl(struct request_queue *q, struct gendisk *bd_disk, fmode_t mode,
-		   unsigned int cmd, void __user *arg)
-{
-	int err;
-
-	if (!q)
-		return -ENXIO;
-
-	switch (cmd) {
-		/*
-		 * new sgv3 interface
-		 */
-		case SG_GET_VERSION_NUM:
-			err = sg_get_version(arg);
-			break;
-		case SG_SET_TIMEOUT:
-			err = sg_set_timeout(q, arg);
-			break;
-		case SG_GET_TIMEOUT:
-			err = sg_get_timeout(q);
-			break;
-		case SG_GET_RESERVED_SIZE:
-			err = sg_get_reserved_size(q, arg);
-			break;
-		case SG_SET_RESERVED_SIZE:
-			err = sg_set_reserved_size(q, arg);
-			break;
-		case SG_EMULATED_HOST:
-			err = sg_emulated_host(q, arg);
-			break;
-		case SG_IO: {
-			struct sg_io_hdr hdr;
-
-			err = get_sg_io_hdr(&hdr, arg);
-			if (err)
-				break;
-			err = sg_io(q, bd_disk, &hdr, mode);
-			if (err == -EFAULT)
-				break;
-
-			if (put_sg_io_hdr(&hdr, arg))
-				err = -EFAULT;
-			break;
-		}
-		case CDROM_SEND_PACKET:
-			err = scsi_cdrom_send_packet(q, bd_disk, mode, arg);
-			break;
-
-		/*
-		 * old junk scsi send command ioctl
-		 */
-		case SCSI_IOCTL_SEND_COMMAND:
-			printk(KERN_WARNING "program %s is using a deprecated SCSI ioctl, please convert it to SG_IO\n", current->comm);
-			err = -EINVAL;
-			if (!arg)
-				break;
-
-			err = sg_scsi_ioctl(q, bd_disk, mode, arg);
-			break;
-		case CDROMCLOSETRAY:
-			err = blk_send_start_stop(q, bd_disk, 0x03);
-			break;
-		case CDROMEJECT:
-			err = blk_send_start_stop(q, bd_disk, 0x02);
-			break;
-		default:
-			err = -ENOTTY;
-	}
-
-	return err;
-}
-EXPORT_SYMBOL(scsi_cmd_ioctl);
diff --git a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
index 7739575b5229..e2c85b7a54f5 100644
--- a/drivers/scsi/scsi_ioctl.c
+++ b/drivers/scsi/scsi_ioctl.c
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
+#include <linux/cdrom.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -189,6 +190,706 @@ static int scsi_ioctl_get_pci(struct scsi_device *sdev, void __user *arg)
 		? -EFAULT: 0;
 }
 
+static int sg_get_version(int __user *p)
+{
+	static const int sg_version_num = 30527;
+	return put_user(sg_version_num, p);
+}
+
+static int sg_get_timeout(struct request_queue *q)
+{
+	return jiffies_to_clock_t(q->sg_timeout);
+}
+
+static int sg_set_timeout(struct request_queue *q, int __user *p)
+{
+	int timeout, err = get_user(timeout, p);
+
+	if (!err)
+		q->sg_timeout = clock_t_to_jiffies(timeout);
+
+	return err;
+}
+
+static int sg_get_reserved_size(struct request_queue *q, int __user *p)
+{
+	int val = min(q->sg_reserved_size, queue_max_bytes(q));
+
+	return put_user(val, p);
+}
+
+static int sg_set_reserved_size(struct request_queue *q, int __user *p)
+{
+	int size, err = get_user(size, p);
+
+	if (err)
+		return err;
+
+	if (size < 0)
+		return -EINVAL;
+
+	q->sg_reserved_size = min_t(unsigned int, size, queue_max_bytes(q));
+	return 0;
+}
+
+/*
+ * will always return that we are ATAPI even for a real SCSI drive, I'm not
+ * so sure this is worth doing anything about (why would you care??)
+ */
+static int sg_emulated_host(struct request_queue *q, int __user *p)
+{
+	return put_user(1, p);
+}
+
+/* Send basic block requests */
+static int __blk_send_generic(struct request_queue *q, struct gendisk *bd_disk,
+			      int cmd, int data)
+{
+	struct request *rq;
+	int err;
+
+	rq = blk_get_request(q, REQ_OP_DRV_OUT, 0);
+	if (IS_ERR(rq))
+		return PTR_ERR(rq);
+	rq->timeout = BLK_DEFAULT_SG_TIMEOUT;
+	scsi_req(rq)->cmd[0] = cmd;
+	scsi_req(rq)->cmd[4] = data;
+	scsi_req(rq)->cmd_len = 6;
+	blk_execute_rq(bd_disk, rq, 0);
+	err = scsi_req(rq)->result ? -EIO : 0;
+	blk_put_request(rq);
+
+	return err;
+}
+
+static inline int blk_send_start_stop(struct request_queue *q,
+				      struct gendisk *bd_disk, int data)
+{
+	return __blk_send_generic(q, bd_disk, GPCMD_START_STOP_UNIT, data);
+}
+
+/*
+ * Check if the given command is allowed.
+ *
+ * For unprivileged users only a small set of whitelisted command is allowed so
+ * that they can't format the drive or update the firmware.
+ */
+bool scsi_cmd_allowed(unsigned char *cmd, fmode_t mode)
+{
+	/* root can do any command. */
+	if (capable(CAP_SYS_RAWIO))
+		return true;
+
+	/* Anybody who can open the device can do a read-safe command */
+	switch (cmd[0]) {
+	/* Basic read-only commands */
+	case TEST_UNIT_READY:
+	case REQUEST_SENSE:
+	case READ_6:
+	case READ_10:
+	case READ_12:
+	case READ_16:
+	case READ_BUFFER:
+	case READ_DEFECT_DATA:
+	case READ_CAPACITY: /* also GPCMD_READ_CDVD_CAPACITY */
+	case READ_LONG:
+	case INQUIRY:
+	case MODE_SENSE:
+	case MODE_SENSE_10:
+	case LOG_SENSE:
+	case START_STOP:
+	case GPCMD_VERIFY_10:
+	case VERIFY_16:
+	case REPORT_LUNS:
+	case SERVICE_ACTION_IN_16:
+	case RECEIVE_DIAGNOSTIC:
+	case MAINTENANCE_IN: /* also GPCMD_SEND_KEY, which is a write command */
+	case GPCMD_READ_BUFFER_CAPACITY:
+	/* Audio CD commands */
+	case GPCMD_PLAY_CD:
+	case GPCMD_PLAY_AUDIO_10:
+	case GPCMD_PLAY_AUDIO_MSF:
+	case GPCMD_PLAY_AUDIO_TI:
+	case GPCMD_PAUSE_RESUME:
+	/* CD/DVD data reading */
+	case GPCMD_READ_CD:
+	case GPCMD_READ_CD_MSF:
+	case GPCMD_READ_DISC_INFO:
+	case GPCMD_READ_DVD_STRUCTURE:
+	case GPCMD_READ_HEADER:
+	case GPCMD_READ_TRACK_RZONE_INFO:
+	case GPCMD_READ_SUBCHANNEL:
+	case GPCMD_READ_TOC_PMA_ATIP:
+	case GPCMD_REPORT_KEY:
+	case GPCMD_SCAN:
+	case GPCMD_GET_CONFIGURATION:
+	case GPCMD_READ_FORMAT_CAPACITIES:
+	case GPCMD_GET_EVENT_STATUS_NOTIFICATION:
+	case GPCMD_GET_PERFORMANCE:
+	case GPCMD_SEEK:
+	case GPCMD_STOP_PLAY_SCAN:
+	/* ZBC */
+	case ZBC_IN:
+		return true;
+	/* Basic writing commands */
+	case WRITE_6:
+	case WRITE_10:
+	case WRITE_VERIFY:
+	case WRITE_12:
+	case WRITE_VERIFY_12:
+	case WRITE_16:
+	case WRITE_LONG:
+	case WRITE_LONG_2:
+	case WRITE_SAME:
+	case WRITE_SAME_16:
+	case WRITE_SAME_32:
+	case ERASE:
+	case GPCMD_MODE_SELECT_10:
+	case MODE_SELECT:
+	case LOG_SELECT:
+	case GPCMD_BLANK:
+	case GPCMD_CLOSE_TRACK:
+	case GPCMD_FLUSH_CACHE:
+	case GPCMD_FORMAT_UNIT:
+	case GPCMD_REPAIR_RZONE_TRACK:
+	case GPCMD_RESERVE_RZONE_TRACK:
+	case GPCMD_SEND_DVD_STRUCTURE:
+	case GPCMD_SEND_EVENT:
+	case GPCMD_SEND_OPC:
+	case GPCMD_SEND_CUE_SHEET:
+	case GPCMD_SET_SPEED:
+	case GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL:
+	case GPCMD_LOAD_UNLOAD:
+	case GPCMD_SET_STREAMING:
+	case GPCMD_SET_READ_AHEAD:
+	/* ZBC */
+	case ZBC_OUT:
+		return (mode & FMODE_WRITE);
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL(scsi_cmd_allowed);
+
+static int scsi_fill_sghdr_rq(struct request_queue *q, struct request *rq,
+		struct sg_io_hdr *hdr, fmode_t mode)
+{
+	struct scsi_request *req = scsi_req(rq);
+
+	if (copy_from_user(req->cmd, hdr->cmdp, hdr->cmd_len))
+		return -EFAULT;
+	if (!scsi_cmd_allowed(req->cmd, mode))
+		return -EPERM;
+
+	/*
+	 * fill in request structure
+	 */
+	req->cmd_len = hdr->cmd_len;
+
+	rq->timeout = msecs_to_jiffies(hdr->timeout);
+	if (!rq->timeout)
+		rq->timeout = q->sg_timeout;
+	if (!rq->timeout)
+		rq->timeout = BLK_DEFAULT_SG_TIMEOUT;
+	if (rq->timeout < BLK_MIN_SG_TIMEOUT)
+		rq->timeout = BLK_MIN_SG_TIMEOUT;
+
+	return 0;
+}
+
+static int scsi_complete_sghdr_rq(struct request *rq, struct sg_io_hdr *hdr,
+		struct bio *bio)
+{
+	struct scsi_request *req = scsi_req(rq);
+	int r, ret = 0;
+
+	/*
+	 * fill in all the output members
+	 */
+	hdr->status = req->result & 0xff;
+	hdr->masked_status = status_byte(req->result);
+	hdr->msg_status = COMMAND_COMPLETE;
+	hdr->host_status = host_byte(req->result);
+	hdr->driver_status = 0;
+	if (scsi_status_is_check_condition(hdr->status))
+		hdr->driver_status = DRIVER_SENSE;
+	hdr->info = 0;
+	if (hdr->masked_status || hdr->host_status || hdr->driver_status)
+		hdr->info |= SG_INFO_CHECK;
+	hdr->resid = req->resid_len;
+	hdr->sb_len_wr = 0;
+
+	if (req->sense_len && hdr->sbp) {
+		int len = min((unsigned int) hdr->mx_sb_len, req->sense_len);
+
+		if (!copy_to_user(hdr->sbp, req->sense, len))
+			hdr->sb_len_wr = len;
+		else
+			ret = -EFAULT;
+	}
+
+	r = blk_rq_unmap_user(bio);
+	if (!ret)
+		ret = r;
+
+	return ret;
+}
+
+static int sg_io(struct request_queue *q, struct gendisk *bd_disk,
+		struct sg_io_hdr *hdr, fmode_t mode)
+{
+	unsigned long start_time;
+	ssize_t ret = 0;
+	int writing = 0;
+	int at_head = 0;
+	struct request *rq;
+	struct scsi_request *req;
+	struct bio *bio;
+
+	if (hdr->interface_id != 'S')
+		return -EINVAL;
+
+	if (hdr->dxfer_len > (queue_max_hw_sectors(q) << 9))
+		return -EIO;
+
+	if (hdr->dxfer_len)
+		switch (hdr->dxfer_direction) {
+		default:
+			return -EINVAL;
+		case SG_DXFER_TO_DEV:
+			writing = 1;
+			break;
+		case SG_DXFER_TO_FROM_DEV:
+		case SG_DXFER_FROM_DEV:
+			break;
+		}
+	if (hdr->flags & SG_FLAG_Q_AT_HEAD)
+		at_head = 1;
+
+	ret = -ENOMEM;
+	rq = blk_get_request(q, writing ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN, 0);
+	if (IS_ERR(rq))
+		return PTR_ERR(rq);
+	req = scsi_req(rq);
+
+	if (hdr->cmd_len > BLK_MAX_CDB) {
+		req->cmd = kzalloc(hdr->cmd_len, GFP_KERNEL);
+		if (!req->cmd)
+			goto out_put_request;
+	}
+
+	ret = scsi_fill_sghdr_rq(q, rq, hdr, mode);
+	if (ret < 0)
+		goto out_free_cdb;
+
+	ret = 0;
+	if (hdr->iovec_count) {
+		struct iov_iter i;
+		struct iovec *iov = NULL;
+
+		ret = import_iovec(rq_data_dir(rq), hdr->dxferp,
+				   hdr->iovec_count, 0, &iov, &i);
+		if (ret < 0)
+			goto out_free_cdb;
+
+		/* SG_IO howto says that the shorter of the two wins */
+		iov_iter_truncate(&i, hdr->dxfer_len);
+
+		ret = blk_rq_map_user_iov(q, rq, NULL, &i, GFP_KERNEL);
+		kfree(iov);
+	} else if (hdr->dxfer_len)
+		ret = blk_rq_map_user(q, rq, NULL, hdr->dxferp, hdr->dxfer_len,
+				      GFP_KERNEL);
+
+	if (ret)
+		goto out_free_cdb;
+
+	bio = rq->bio;
+	req->retries = 0;
+
+	start_time = jiffies;
+
+	blk_execute_rq(bd_disk, rq, at_head);
+
+	hdr->duration = jiffies_to_msecs(jiffies - start_time);
+
+	ret = scsi_complete_sghdr_rq(rq, hdr, bio);
+
+out_free_cdb:
+	scsi_req_free_cmd(req);
+out_put_request:
+	blk_put_request(rq);
+	return ret;
+}
+
+/**
+ * sg_scsi_ioctl  --  handle deprecated SCSI_IOCTL_SEND_COMMAND ioctl
+ * @q:		request queue to send scsi commands down
+ * @disk:	gendisk to operate on (option)
+ * @mode:	mode used to open the file through which the ioctl has been
+ *		submitted
+ * @sic:	userspace structure describing the command to perform
+ *
+ * Send down the scsi command described by @sic to the device below
+ * the request queue @q.  If @file is non-NULL it's used to perform
+ * fine-grained permission checks that allow users to send down
+ * non-destructive SCSI commands.  If the caller has a struct gendisk
+ * available it should be passed in as @disk to allow the low level
+ * driver to use the information contained in it.  A non-NULL @disk
+ * is only allowed if the caller knows that the low level driver doesn't
+ * need it (e.g. in the scsi subsystem).
+ *
+ * Notes:
+ *   -  This interface is deprecated - users should use the SG_IO
+ *      interface instead, as this is a more flexible approach to
+ *      performing SCSI commands on a device.
+ *   -  The SCSI command length is determined by examining the 1st byte
+ *      of the given command. There is no way to override this.
+ *   -  Data transfers are limited to PAGE_SIZE
+ *   -  The length (x + y) must be at least OMAX_SB_LEN bytes long to
+ *      accommodate the sense buffer when an error occurs.
+ *      The sense buffer is truncated to OMAX_SB_LEN (16) bytes so that
+ *      old code will not be surprised.
+ *   -  If a Unix error occurs (e.g. ENOMEM) then the user will receive
+ *      a negative return and the Unix error code in 'errno'.
+ *      If the SCSI command succeeds then 0 is returned.
+ *      Positive numbers returned are the compacted SCSI error codes (4
+ *      bytes in one int) where the lowest byte is the SCSI status.
+ */
+int sg_scsi_ioctl(struct request_queue *q, struct gendisk *disk, fmode_t mode,
+		struct scsi_ioctl_command __user *sic)
+{
+	enum { OMAX_SB_LEN = 16 };	/* For backward compatibility */
+	struct request *rq;
+	struct scsi_request *req;
+	int err;
+	unsigned int in_len, out_len, bytes, opcode, cmdlen;
+	char *buffer = NULL;
+
+	if (!sic)
+		return -EINVAL;
+
+	/*
+	 * get in an out lengths, verify they don't exceed a page worth of data
+	 */
+	if (get_user(in_len, &sic->inlen))
+		return -EFAULT;
+	if (get_user(out_len, &sic->outlen))
+		return -EFAULT;
+	if (in_len > PAGE_SIZE || out_len > PAGE_SIZE)
+		return -EINVAL;
+	if (get_user(opcode, sic->data))
+		return -EFAULT;
+
+	bytes = max(in_len, out_len);
+	if (bytes) {
+		buffer = kzalloc(bytes, GFP_NOIO | GFP_USER | __GFP_NOWARN);
+		if (!buffer)
+			return -ENOMEM;
+
+	}
+
+	rq = blk_get_request(q, in_len ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN, 0);
+	if (IS_ERR(rq)) {
+		err = PTR_ERR(rq);
+		goto error_free_buffer;
+	}
+	req = scsi_req(rq);
+
+	cmdlen = COMMAND_SIZE(opcode);
+
+	/*
+	 * get command and data to send to device, if any
+	 */
+	err = -EFAULT;
+	req->cmd_len = cmdlen;
+	if (copy_from_user(req->cmd, sic->data, cmdlen))
+		goto error;
+
+	if (in_len && copy_from_user(buffer, sic->data + cmdlen, in_len))
+		goto error;
+
+	err = -EPERM;
+	if (!scsi_cmd_allowed(req->cmd, mode))
+		goto error;
+
+	/* default.  possible overriden later */
+	req->retries = 5;
+
+	switch (opcode) {
+	case SEND_DIAGNOSTIC:
+	case FORMAT_UNIT:
+		rq->timeout = FORMAT_UNIT_TIMEOUT;
+		req->retries = 1;
+		break;
+	case START_STOP:
+		rq->timeout = START_STOP_TIMEOUT;
+		break;
+	case MOVE_MEDIUM:
+		rq->timeout = MOVE_MEDIUM_TIMEOUT;
+		break;
+	case READ_ELEMENT_STATUS:
+		rq->timeout = READ_ELEMENT_STATUS_TIMEOUT;
+		break;
+	case READ_DEFECT_DATA:
+		rq->timeout = READ_DEFECT_DATA_TIMEOUT;
+		req->retries = 1;
+		break;
+	default:
+		rq->timeout = BLK_DEFAULT_SG_TIMEOUT;
+		break;
+	}
+
+	if (bytes) {
+		err = blk_rq_map_kern(q, rq, buffer, bytes, GFP_NOIO);
+		if (err)
+			goto error;
+	}
+
+	blk_execute_rq(disk, rq, 0);
+
+	err = req->result & 0xff;	/* only 8 bit SCSI status */
+	if (err) {
+		if (req->sense_len && req->sense) {
+			bytes = (OMAX_SB_LEN > req->sense_len) ?
+				req->sense_len : OMAX_SB_LEN;
+			if (copy_to_user(sic->data, req->sense, bytes))
+				err = -EFAULT;
+		}
+	} else {
+		if (copy_to_user(sic->data, buffer, out_len))
+			err = -EFAULT;
+	}
+	
+error:
+	blk_put_request(rq);
+
+error_free_buffer:
+	kfree(buffer);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(sg_scsi_ioctl);
+
+int put_sg_io_hdr(const struct sg_io_hdr *hdr, void __user *argp)
+{
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall()) {
+		struct compat_sg_io_hdr hdr32 =  {
+			.interface_id	 = hdr->interface_id,
+			.dxfer_direction = hdr->dxfer_direction,
+			.cmd_len	 = hdr->cmd_len,
+			.mx_sb_len	 = hdr->mx_sb_len,
+			.iovec_count	 = hdr->iovec_count,
+			.dxfer_len	 = hdr->dxfer_len,
+			.dxferp		 = (uintptr_t)hdr->dxferp,
+			.cmdp		 = (uintptr_t)hdr->cmdp,
+			.sbp		 = (uintptr_t)hdr->sbp,
+			.timeout	 = hdr->timeout,
+			.flags		 = hdr->flags,
+			.pack_id	 = hdr->pack_id,
+			.usr_ptr	 = (uintptr_t)hdr->usr_ptr,
+			.status		 = hdr->status,
+			.masked_status	 = hdr->masked_status,
+			.msg_status	 = hdr->msg_status,
+			.sb_len_wr	 = hdr->sb_len_wr,
+			.host_status	 = hdr->host_status,
+			.driver_status	 = hdr->driver_status,
+			.resid		 = hdr->resid,
+			.duration	 = hdr->duration,
+			.info		 = hdr->info,
+		};
+
+		if (copy_to_user(argp, &hdr32, sizeof(hdr32)))
+			return -EFAULT;
+
+		return 0;
+	}
+#endif
+
+	if (copy_to_user(argp, hdr, sizeof(*hdr)))
+		return -EFAULT;
+
+	return 0;
+}
+EXPORT_SYMBOL(put_sg_io_hdr);
+
+int get_sg_io_hdr(struct sg_io_hdr *hdr, const void __user *argp)
+{
+#ifdef CONFIG_COMPAT
+	struct compat_sg_io_hdr hdr32;
+
+	if (in_compat_syscall()) {
+		if (copy_from_user(&hdr32, argp, sizeof(hdr32)))
+			return -EFAULT;
+
+		*hdr = (struct sg_io_hdr) {
+			.interface_id	 = hdr32.interface_id,
+			.dxfer_direction = hdr32.dxfer_direction,
+			.cmd_len	 = hdr32.cmd_len,
+			.mx_sb_len	 = hdr32.mx_sb_len,
+			.iovec_count	 = hdr32.iovec_count,
+			.dxfer_len	 = hdr32.dxfer_len,
+			.dxferp		 = compat_ptr(hdr32.dxferp),
+			.cmdp		 = compat_ptr(hdr32.cmdp),
+			.sbp		 = compat_ptr(hdr32.sbp),
+			.timeout	 = hdr32.timeout,
+			.flags		 = hdr32.flags,
+			.pack_id	 = hdr32.pack_id,
+			.usr_ptr	 = compat_ptr(hdr32.usr_ptr),
+			.status		 = hdr32.status,
+			.masked_status	 = hdr32.masked_status,
+			.msg_status	 = hdr32.msg_status,
+			.sb_len_wr	 = hdr32.sb_len_wr,
+			.host_status	 = hdr32.host_status,
+			.driver_status	 = hdr32.driver_status,
+			.resid		 = hdr32.resid,
+			.duration	 = hdr32.duration,
+			.info		 = hdr32.info,
+		};
+
+		return 0;
+	}
+#endif
+
+	if (copy_from_user(hdr, argp, sizeof(*hdr)))
+		return -EFAULT;
+
+	return 0;
+}
+EXPORT_SYMBOL(get_sg_io_hdr);
+
+#ifdef CONFIG_COMPAT
+struct compat_cdrom_generic_command {
+	unsigned char	cmd[CDROM_PACKET_SIZE];
+	compat_caddr_t	buffer;
+	compat_uint_t	buflen;
+	compat_int_t	stat;
+	compat_caddr_t	sense;
+	unsigned char	data_direction;
+	unsigned char	pad[3];
+	compat_int_t	quiet;
+	compat_int_t	timeout;
+	compat_caddr_t	unused;
+};
+#endif
+
+static int scsi_get_cdrom_generic_arg(struct cdrom_generic_command *cgc,
+				      const void __user *arg)
+{
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall()) {
+		struct compat_cdrom_generic_command cgc32;
+
+		if (copy_from_user(&cgc32, arg, sizeof(cgc32)))
+			return -EFAULT;
+
+		*cgc = (struct cdrom_generic_command) {
+			.buffer		= compat_ptr(cgc32.buffer),
+			.buflen		= cgc32.buflen,
+			.stat		= cgc32.stat,
+			.sense		= compat_ptr(cgc32.sense),
+			.data_direction	= cgc32.data_direction,
+			.quiet		= cgc32.quiet,
+			.timeout	= cgc32.timeout,
+			.unused		= compat_ptr(cgc32.unused),
+		};
+		memcpy(&cgc->cmd, &cgc32.cmd, CDROM_PACKET_SIZE);
+		return 0;
+	}
+#endif
+	if (copy_from_user(cgc, arg, sizeof(*cgc)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int scsi_put_cdrom_generic_arg(const struct cdrom_generic_command *cgc,
+				      void __user *arg)
+{
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall()) {
+		struct compat_cdrom_generic_command cgc32 = {
+			.buffer		= (uintptr_t)(cgc->buffer),
+			.buflen		= cgc->buflen,
+			.stat		= cgc->stat,
+			.sense		= (uintptr_t)(cgc->sense),
+			.data_direction	= cgc->data_direction,
+			.quiet		= cgc->quiet,
+			.timeout	= cgc->timeout,
+			.unused		= (uintptr_t)(cgc->unused),
+		};
+		memcpy(&cgc32.cmd, &cgc->cmd, CDROM_PACKET_SIZE);
+
+		if (copy_to_user(arg, &cgc32, sizeof(cgc32)))
+			return -EFAULT;
+
+		return 0;
+	}
+#endif
+	if (copy_to_user(arg, cgc, sizeof(*cgc)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int scsi_cdrom_send_packet(struct request_queue *q,
+				  struct gendisk *bd_disk,
+				  fmode_t mode, void __user *arg)
+{
+	struct cdrom_generic_command cgc;
+	struct sg_io_hdr hdr;
+	int err;
+
+	err = scsi_get_cdrom_generic_arg(&cgc, arg);
+	if (err)
+		return err;
+
+	cgc.timeout = clock_t_to_jiffies(cgc.timeout);
+	memset(&hdr, 0, sizeof(hdr));
+	hdr.interface_id = 'S';
+	hdr.cmd_len = sizeof(cgc.cmd);
+	hdr.dxfer_len = cgc.buflen;
+	switch (cgc.data_direction) {
+		case CGC_DATA_UNKNOWN:
+			hdr.dxfer_direction = SG_DXFER_UNKNOWN;
+			break;
+		case CGC_DATA_WRITE:
+			hdr.dxfer_direction = SG_DXFER_TO_DEV;
+			break;
+		case CGC_DATA_READ:
+			hdr.dxfer_direction = SG_DXFER_FROM_DEV;
+			break;
+		case CGC_DATA_NONE:
+			hdr.dxfer_direction = SG_DXFER_NONE;
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	hdr.dxferp = cgc.buffer;
+	hdr.sbp = cgc.sense;
+	if (hdr.sbp)
+		hdr.mx_sb_len = sizeof(struct request_sense);
+	hdr.timeout = jiffies_to_msecs(cgc.timeout);
+	hdr.cmdp = ((struct cdrom_generic_command __user*) arg)->cmd;
+	hdr.cmd_len = sizeof(cgc.cmd);
+
+	err = sg_io(q, bd_disk, &hdr, mode);
+	if (err == -EFAULT)
+		return -EFAULT;
+
+	if (hdr.status)
+		return -EIO;
+
+	cgc.stat = err;
+	cgc.buflen = hdr.resid;
+	if (scsi_put_cdrom_generic_arg(&cgc, arg))
+		return -EFAULT;
+
+	return err;
+}
+
 /**
  * scsi_ioctl - Dispatch ioctl to scsi device
  * @sdev: scsi device receiving ioctl
@@ -225,13 +926,42 @@ int scsi_ioctl(struct scsi_device *sdev, struct gendisk *disk, fmode_t mode,
 		break;
 	}
 
-	if (cmd != SCSI_IOCTL_GET_IDLUN && cmd != SCSI_IOCTL_GET_BUS_NUMBER) {
-		error = scsi_cmd_ioctl(q, disk, mode, cmd, arg);
-		if (error != -ENOTTY)
+	switch (cmd) {
+	case SG_GET_VERSION_NUM:
+		return sg_get_version(arg);
+	case SG_SET_TIMEOUT:
+		return sg_set_timeout(q, arg);
+	case SG_GET_TIMEOUT:
+		return sg_get_timeout(q);
+	case SG_GET_RESERVED_SIZE:
+		return sg_get_reserved_size(q, arg);
+	case SG_SET_RESERVED_SIZE:
+		return sg_set_reserved_size(q, arg);
+	case SG_EMULATED_HOST:
+		return sg_emulated_host(q, arg);
+	case SG_IO: {
+		struct sg_io_hdr hdr;
+
+		error = get_sg_io_hdr(&hdr, arg);
+		if (error)
 			return error;
-	}
 
-	switch (cmd) {
+		error = sg_io(q, disk, &hdr, mode);
+		if (error == -EFAULT)
+			return error;
+
+		if (put_sg_io_hdr(&hdr, arg))
+			return -EFAULT;
+		return 0;
+	}
+	case SCSI_IOCTL_SEND_COMMAND:
+		return sg_scsi_ioctl(q, disk, mode, arg);
+	case CDROM_SEND_PACKET:
+		return scsi_cdrom_send_packet(q, disk, mode, arg);
+	case CDROMCLOSETRAY:
+		return blk_send_start_stop(q, disk, 0x03);
+	case CDROMEJECT:
+		return blk_send_start_stop(q, disk, 0x02);
 	case SCSI_IOCTL_GET_IDLUN: {
 		struct scsi_idlun v = {
 			.dev_id = (sdev->id & 0xff)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e28679e63373..8c617a5a5d61 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -28,8 +28,6 @@
 #include <linux/sbitmap.h>
 
 struct module;
-struct scsi_ioctl_command;
-
 struct request_queue;
 struct elevator_queue;
 struct blk_trace;
@@ -888,13 +886,6 @@ extern blk_status_t blk_insert_cloned_request(struct request_queue *q,
 				     struct request *rq);
 int blk_rq_append_bio(struct request *rq, struct bio *bio);
 extern void blk_queue_split(struct bio **);
-extern int scsi_cmd_ioctl(struct request_queue *, struct gendisk *, fmode_t,
-			  unsigned int, void __user *);
-extern int sg_scsi_ioctl(struct request_queue *, struct gendisk *, fmode_t,
-			 struct scsi_ioctl_command __user *);
-extern int get_sg_io_hdr(struct sg_io_hdr *hdr, const void __user *argp);
-extern int put_sg_io_hdr(const struct sg_io_hdr *hdr, void __user *argp);
-
 extern int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags);
 extern void blk_queue_exit(struct request_queue *q);
 extern void blk_sync_queue(struct request_queue *q);
@@ -1343,8 +1334,6 @@ static inline int sb_issue_zeroout(struct super_block *sb, sector_t block,
 				    gfp_mask, 0);
 }
 
-bool scsi_cmd_allowed(unsigned char *cmd, fmode_t mode);
-
 static inline bool bdev_is_partition(struct block_device *bdev)
 {
 	return bdev->bd_partno;
diff --git a/include/scsi/scsi_ioctl.h b/include/scsi/scsi_ioctl.h
index defbe8084eb8..b3918fded464 100644
--- a/include/scsi/scsi_ioctl.h
+++ b/include/scsi/scsi_ioctl.h
@@ -20,6 +20,7 @@
 
 struct gendisk;
 struct scsi_device;
+struct sg_io_hdr;
 
 /*
  * Structures used for scsi_ioctl et al.
@@ -46,6 +47,11 @@ int scsi_ioctl_block_when_processing_errors(struct scsi_device *sdev,
 		int cmd, bool ndelay);
 int scsi_ioctl(struct scsi_device *sdev, struct gendisk *disk, fmode_t mode,
 		int cmd, void __user *arg);
+int sg_scsi_ioctl(struct request_queue *q, struct gendisk *disk, fmode_t mode,
+			 struct scsi_ioctl_command __user *argp);
+int get_sg_io_hdr(struct sg_io_hdr *hdr, const void __user *argp);
+int put_sg_io_hdr(const struct sg_io_hdr *hdr, void __user *argp);
+bool scsi_cmd_allowed(unsigned char *cmd, fmode_t mode);
 
 #endif /* __KERNEL__ */
 #endif /* _SCSI_IOCTL_H */
-- 
2.30.2

