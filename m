Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E765D3DB47D
	for <lists+linux-block@lfdr.de>; Fri, 30 Jul 2021 09:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237567AbhG3H2A (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 30 Jul 2021 03:28:00 -0400
Received: from verein.lst.de ([213.95.11.211]:59863 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230311AbhG3H17 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jul 2021 03:27:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E45F967373; Fri, 30 Jul 2021 09:27:52 +0200 (CEST)
Date:   Fri, 30 Jul 2021 09:27:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     hch@lst.de, "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Kai.Makisara@kolumbus.fi, dgilbert@interlog.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-next@vger.kernel.org, broonie@kernel.org,
        sfr@canb.auug.org.au, lkft-triage@lists.linaro.org
Subject: Re: [PATCH 14/24] bsg: move bsg_scsi_ops to drivers/scsi/
Message-ID: <20210730072752.GB23847@lst.de>
References: <20210724072033.1284840-1-hch@lst.de> <20210724072033.1284840-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210724072033.1284840-15-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 29, 2021 at 10:47:45AM +0200, Anders Roxell wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> > Move the SCSI-specific bsg code in the SCSI midlayer instead of in the
> > common bsg code.  This just keeps the common bsg code block/ and also
> > allows building it as a module.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> [ Please ignore if its already been reported ]
> 
> When building arm's defconfig 'footbridge_defconfig' on linux-next tag next-20210728 I see the following error.

Can you try this patch on top?

---
From d92a8160ce3fbe64a250482522ca0456277781f9 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 5 Jul 2021 15:02:43 +0200
Subject: cdrom: move the guts of cdrom_read_cdda_bpc into the sr driver

cdrom_read_cdda_bpc relies on sending SCSI command to the low level
driver using a REQ_OP_SCSI_IN request.  This isn't generic block
layer functionality, so some the actual low-level code into the sr
driver and call it through a new read_cdda_bpc method in the
cdrom_device_ops structure.

With this the CDROM code does not have to pull in
scsi_normalize_sense and this depend on CONFIG_SCSI_COMMON.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/cdrom/cdrom.c | 71 +++++--------------------------------------
 drivers/scsi/sr.c     | 56 +++++++++++++++++++++++++++++++++-
 include/linux/cdrom.h |  6 ++--
 3 files changed, 67 insertions(+), 66 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 8882b311bafd..bd2e5b1560f5 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -629,7 +629,7 @@ int register_cdrom(struct gendisk *disk, struct cdrom_device_info *cdi)
 	if (CDROM_CAN(CDC_MRW_W))
 		cdi->exit = cdrom_mrw_exit;
 
-	if (cdi->disk)
+	if (cdi->ops->read_cdda_bpc)
 		cdi->cdda_method = CDDA_BPC_FULL;
 	else
 		cdi->cdda_method = CDDA_OLD;
@@ -2159,81 +2159,26 @@ static int cdrom_read_cdda_old(struct cdrom_device_info *cdi, __u8 __user *ubuf,
 static int cdrom_read_cdda_bpc(struct cdrom_device_info *cdi, __u8 __user *ubuf,
 			       int lba, int nframes)
 {
-	struct request_queue *q = cdi->disk->queue;
-	struct request *rq;
-	struct scsi_request *req;
-	struct bio *bio;
-	unsigned int len;
+	int max_frames = (queue_max_sectors(cdi->disk->queue) << 9) /
+			  CD_FRAMESIZE_RAW;
 	int nr, ret = 0;
 
-	if (!q)
-		return -ENXIO;
-
-	if (!blk_queue_scsi_passthrough(q)) {
-		WARN_ONCE(true,
-			  "Attempt read CDDA info through a non-SCSI queue\n");
-		return -EINVAL;
-	}
-
 	cdi->last_sense = 0;
 
 	while (nframes) {
-		nr = nframes;
 		if (cdi->cdda_method == CDDA_BPC_SINGLE)
 			nr = 1;
-		if (nr * CD_FRAMESIZE_RAW > (queue_max_sectors(q) << 9))
-			nr = (queue_max_sectors(q) << 9) / CD_FRAMESIZE_RAW;
-
-		len = nr * CD_FRAMESIZE_RAW;
-
-		rq = blk_get_request(q, REQ_OP_DRV_IN, 0);
-		if (IS_ERR(rq)) {
-			ret = PTR_ERR(rq);
-			break;
-		}
-		req = scsi_req(rq);
-
-		ret = blk_rq_map_user(q, rq, NULL, ubuf, len, GFP_KERNEL);
-		if (ret) {
-			blk_put_request(rq);
-			break;
-		}
-
-		req->cmd[0] = GPCMD_READ_CD;
-		req->cmd[1] = 1 << 2;
-		req->cmd[2] = (lba >> 24) & 0xff;
-		req->cmd[3] = (lba >> 16) & 0xff;
-		req->cmd[4] = (lba >>  8) & 0xff;
-		req->cmd[5] = lba & 0xff;
-		req->cmd[6] = (nr >> 16) & 0xff;
-		req->cmd[7] = (nr >>  8) & 0xff;
-		req->cmd[8] = nr & 0xff;
-		req->cmd[9] = 0xf8;
-
-		req->cmd_len = 12;
-		rq->timeout = 60 * HZ;
-		bio = rq->bio;
-
-		blk_execute_rq(cdi->disk, rq, 0);
-		if (scsi_req(rq)->result) {
-			struct scsi_sense_hdr sshdr;
-
-			ret = -EIO;
-			scsi_normalize_sense(req->sense, req->sense_len,
-					     &sshdr);
-			cdi->last_sense = sshdr.sense_key;
-		}
-
-		if (blk_rq_unmap_user(bio))
-			ret = -EFAULT;
-		blk_put_request(rq);
+		else
+			nr = min(nframes, max_frames);
 
+		ret = cdi->ops->read_cdda_bpc(cdi, ubuf, lba, nr,
+					      &cdi->last_sense);
 		if (ret)
 			break;
 
 		nframes -= nr;
 		lba += nr;
-		ubuf += len;
+		ubuf += (nr * CD_FRAMESIZE_RAW);
 	}
 
 	return ret;
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index b98e77fe700b..6203a8b58d40 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -120,6 +120,8 @@ static void get_capabilities(struct scsi_cd *);
 static unsigned int sr_check_events(struct cdrom_device_info *cdi,
 				    unsigned int clearing, int slot);
 static int sr_packet(struct cdrom_device_info *, struct packet_command *);
+static int sr_read_cdda_bpc(struct cdrom_device_info *cdi, void __user *ubuf,
+		u32 lba, u32 nr, u8 *last_sense);
 
 static const struct cdrom_device_ops sr_dops = {
 	.open			= sr_open,
@@ -133,8 +135,9 @@ static const struct cdrom_device_ops sr_dops = {
 	.get_mcn		= sr_get_mcn,
 	.reset			= sr_reset,
 	.audio_ioctl		= sr_audio_ioctl,
-	.capability		= SR_CAPABILITIES,
 	.generic_packet		= sr_packet,
+	.read_cdda_bpc		= sr_read_cdda_bpc,
+	.capability		= SR_CAPABILITIES,
 };
 
 static void sr_kref_release(struct kref *kref);
@@ -951,6 +954,57 @@ static int sr_packet(struct cdrom_device_info *cdi,
 	return cgc->stat;
 }
 
+static int sr_read_cdda_bpc(struct cdrom_device_info *cdi, void __user *ubuf,
+		u32 lba, u32 nr, u8 *last_sense)
+{
+	struct gendisk *disk = cdi->disk;
+	u32 len = nr * CD_FRAMESIZE_RAW;
+	struct scsi_request *req;
+	struct request *rq;
+	struct bio *bio;
+	int ret;
+
+	rq = blk_get_request(disk->queue, REQ_OP_DRV_IN, 0);
+	if (IS_ERR(rq))
+		return PTR_ERR(rq);
+	req = scsi_req(rq);
+
+	ret = blk_rq_map_user(disk->queue, rq, NULL, ubuf, len, GFP_KERNEL);
+	if (ret)
+		goto out_put_request;
+
+	req->cmd[0] = GPCMD_READ_CD;
+	req->cmd[1] = 1 << 2;
+	req->cmd[2] = (lba >> 24) & 0xff;
+	req->cmd[3] = (lba >> 16) & 0xff;
+	req->cmd[4] = (lba >>  8) & 0xff;
+	req->cmd[5] = lba & 0xff;
+	req->cmd[6] = (nr >> 16) & 0xff;
+	req->cmd[7] = (nr >>  8) & 0xff;
+	req->cmd[8] = nr & 0xff;
+	req->cmd[9] = 0xf8;
+	req->cmd_len = 12;
+	rq->timeout = 60 * HZ;
+	bio = rq->bio;
+
+	blk_execute_rq(disk, rq, 0);
+	if (scsi_req(rq)->result) {
+		struct scsi_sense_hdr sshdr;
+
+		scsi_normalize_sense(req->sense, req->sense_len,
+				     &sshdr);
+		*last_sense = sshdr.sense_key;
+		ret = -EIO;
+	}
+
+	if (blk_rq_unmap_user(bio))
+		ret = -EFAULT;
+out_put_request:
+	blk_put_request(rq);
+	return ret;
+}
+
+
 /**
  *	sr_kref_release - Called to free the scsi_cd structure
  *	@kref: pointer to embedded kref
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index f48d0a31deae..c4fef00abdf3 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -86,11 +86,13 @@ struct cdrom_device_ops {
 	/* play stuff */
 	int (*audio_ioctl) (struct cdrom_device_info *,unsigned int, void *);
 
-/* driver specifications */
-	const int capability;   /* capability flags */
 	/* handle uniform packets for scsi type devices (scsi,atapi) */
 	int (*generic_packet) (struct cdrom_device_info *,
 			       struct packet_command *);
+	int (*read_cdda_bpc)(struct cdrom_device_info *cdi, void __user *ubuf,
+			       u32 lba, u32 nframes, u8 *last_sense);
+/* driver specifications */
+	const int capability;   /* capability flags */
 };
 
 int cdrom_multisession(struct cdrom_device_info *cdi,
-- 
2.30.2

