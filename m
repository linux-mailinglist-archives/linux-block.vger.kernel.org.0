Return-Path: <linux-block+bounces-24515-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 120EAB0AAAF
	for <lists+linux-block@lfdr.de>; Fri, 18 Jul 2025 21:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A004E6B70
	for <lists+linux-block@lfdr.de>; Fri, 18 Jul 2025 19:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC53156678;
	Fri, 18 Jul 2025 19:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pdSepMqV"
X-Original-To: linux-block@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3319B18E20
	for <linux-block@vger.kernel.org>; Fri, 18 Jul 2025 19:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752866904; cv=none; b=caSUxfMREelzWYGHud9atWK9E+p1SWEH9bHwwH+aVtl9lhXBkRduG8XLjAhxpSNZU/A1pQQLgCO9lIHy5FoWYJtvzdUMMudw+c0Ag1CAde3t1ljcqYklXagZOMpiZVHeMpqTxRP3OSn3Ae1T5Cj8w16IrSpaUnVI5qUDcCT5wJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752866904; c=relaxed/simple;
	bh=rvHSQtmZA2qDxUXqlRk4D+JKx2+bQWHTxNKDKCGmzYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WISRbWIKfJ6b+N8rt3dRn1qtYNEArrBHBBA7kacOSF5Iw2K1+Pe3/FfQeGv5lOsn8po2KF8xNBH1Qctm/3UNrtByTOnuOhxqzaywA8skDNvTBdi5/FCoZg/u6ijxlVzKz/Mee6Ynql8/oHPabC698herrbvIM9/bOSsaNn2hJW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pdSepMqV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aMGTaa/hbE31Sq/Q4GXytLUjjRsoYxmv1QrjszDbO1A=; b=pdSepMqVej0fp9+OvWaUTnPuHD
	Z+idGq0Rth4ukCE1j/+vN/RdQLWPw/VEIRZ8Zm3t1goDZKwlCOlxFl8GdOgdPHrM4+RtnKukXVmCf
	NCDMFUhS64ej6702BoijqpEoaPHNZ7WawzfewzuFOEtGKm+tNhDwJLak67AOlY8MqY4FthXH45mNp
	nAZNVE/aav37gAPeEYx8ggQmfiQYNkugmouZ2NUXJpnMNR54CuNppiqk1FQf1Q58jabDVc/NqxOYX
	zWzz3dEuxWjp6nZnMXXEf10W9ipQ7lKrjUAjrWBdM6mIlZCAIysmC3FMcOJI2/5HFbS3zs4nZ8xb4
	O8QVW1EA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucqkl-0000000DYwR-3pFC;
	Fri, 18 Jul 2025 19:28:19 +0000
Date: Fri, 18 Jul 2025 20:28:19 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Subject: [RFC][PATCH 2/3] scsi: switch ->bios_param() to passing gendisk
Message-ID: <20250718192819.GG2580412@ZenIV>
References: <20250718192642.GE2580412@ZenIV>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718192642.GE2580412@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Instances are passed struct block_device *bdev argument; the only thing
it is used for (if it's used in the first place) is bdev->bd_disk.
Might as well pass that in the first place...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/scsi/scsi_mid_low_api.rst   | 4 ++--
 drivers/ata/libata-scsi.c                 | 4 ++--
 drivers/message/fusion/mptscsih.c         | 2 +-
 drivers/message/fusion/mptscsih.h         | 2 +-
 drivers/scsi/3w-9xxx.c                    | 2 +-
 drivers/scsi/3w-sas.c                     | 2 +-
 drivers/scsi/3w-xxxx.c                    | 2 +-
 drivers/scsi/BusLogic.c                   | 4 ++--
 drivers/scsi/BusLogic.h                   | 2 +-
 drivers/scsi/aacraid/linit.c              | 6 +++---
 drivers/scsi/advansys.c                   | 2 +-
 drivers/scsi/aha152x.c                    | 4 ++--
 drivers/scsi/aha1542.c                    | 2 +-
 drivers/scsi/aha1740.c                    | 2 +-
 drivers/scsi/aic7xxx/aic79xx_osm.c        | 4 ++--
 drivers/scsi/aic7xxx/aic7xxx_osm.c        | 4 ++--
 drivers/scsi/arcmsr/arcmsr_hba.c          | 6 +++---
 drivers/scsi/atp870u.c                    | 2 +-
 drivers/scsi/fdomain.c                    | 4 ++--
 drivers/scsi/imm.c                        | 2 +-
 drivers/scsi/initio.c                     | 4 ++--
 drivers/scsi/ipr.c                        | 8 ++++----
 drivers/scsi/ips.c                        | 2 +-
 drivers/scsi/ips.h                        | 2 +-
 drivers/scsi/libsas/sas_scsi_host.c       | 2 +-
 drivers/scsi/megaraid.c                   | 4 ++--
 drivers/scsi/megaraid.h                   | 2 +-
 drivers/scsi/megaraid/megaraid_sas_base.c | 4 ++--
 drivers/scsi/mpi3mr/mpi3mr_os.c           | 4 ++--
 drivers/scsi/mpt3sas/mpt3sas_scsih.c      | 4 ++--
 drivers/scsi/mvumi.c                      | 2 +-
 drivers/scsi/myrb.c                       | 2 +-
 drivers/scsi/pcmcia/sym53c500_cs.c        | 2 +-
 drivers/scsi/ppa.c                        | 2 +-
 drivers/scsi/qla1280.c                    | 2 +-
 drivers/scsi/qlogicfas408.c               | 2 +-
 drivers/scsi/qlogicfas408.h               | 2 +-
 drivers/scsi/scsicam.c                    | 6 +++---
 drivers/scsi/sd.c                         | 4 ++--
 drivers/scsi/stex.c                       | 2 +-
 drivers/scsi/storvsc_drv.c                | 2 +-
 drivers/scsi/wd719x.c                     | 2 +-
 include/linux/libata.h                    | 2 +-
 include/scsi/libsas.h                     | 2 +-
 include/scsi/scsi_host.h                  | 2 +-
 include/scsi/scsicam.h                    | 2 +-
 46 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/Documentation/scsi/scsi_mid_low_api.rst b/Documentation/scsi/scsi_mid_low_api.rst
index 96c8230d638e..634f5c28a849 100644
--- a/Documentation/scsi/scsi_mid_low_api.rst
+++ b/Documentation/scsi/scsi_mid_low_api.rst
@@ -623,7 +623,7 @@ Details::
     *      bios_param - fetch head, sector, cylinder info for a disk
     *      @sdev: pointer to scsi device context (defined in
     *             include/scsi/scsi_device.h)
-    *      @bdev: pointer to block device context (defined in fs.h)
+    *      @disk: pointer to gendisk (defined in blkdev.h)
     *      @capacity:  device size (in 512 byte sectors)
     *      @params: three element array to place output:
     *              params[0] number of heads (max 255)
@@ -643,7 +643,7 @@ Details::
     *
     *      Optionally defined in: LLD
     **/
-	int bios_param(struct scsi_device * sdev, struct block_device *bdev,
+	int bios_param(struct scsi_device * sdev, struct gendisk *disk,
 		    sector_t capacity, int params[3])
 
 
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a21c9895408d..75d0d3081acb 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -351,7 +351,7 @@ EXPORT_SYMBOL_GPL(ata_common_sdev_groups);
 /**
  *	ata_std_bios_param - generic bios head/sector/cylinder calculator used by sd.
  *	@sdev: SCSI device for which BIOS geometry is to be determined
- *	@bdev: block device associated with @sdev
+ *	@unused: gendisk associated with @sdev
  *	@capacity: capacity of SCSI device
  *	@geom: location to which geometry will be output
  *
@@ -366,7 +366,7 @@ EXPORT_SYMBOL_GPL(ata_common_sdev_groups);
  *	RETURNS:
  *	Zero.
  */
-int ata_std_bios_param(struct scsi_device *sdev, struct block_device *bdev,
+int ata_std_bios_param(struct scsi_device *sdev, struct gendisk *unused,
 		       sector_t capacity, int geom[])
 {
 	geom[0] = 255;
diff --git a/drivers/message/fusion/mptscsih.c b/drivers/message/fusion/mptscsih.c
index 3a64dc7a7e27..3304f8824cf7 100644
--- a/drivers/message/fusion/mptscsih.c
+++ b/drivers/message/fusion/mptscsih.c
@@ -2074,7 +2074,7 @@ mptscsih_taskmgmt_complete(MPT_ADAPTER *ioc, MPT_FRAME_HDR *mf,
  *	This is anyones guess quite frankly.
  */
 int
-mptscsih_bios_param(struct scsi_device * sdev, struct block_device *bdev,
+mptscsih_bios_param(struct scsi_device * sdev, struct gendisk *unused,
 		sector_t capacity, int geom[])
 {
 	int		heads;
diff --git a/drivers/message/fusion/mptscsih.h b/drivers/message/fusion/mptscsih.h
index 8c2bb2331fc1..f9678d48100c 100644
--- a/drivers/message/fusion/mptscsih.h
+++ b/drivers/message/fusion/mptscsih.h
@@ -123,7 +123,7 @@ extern int mptscsih_abort(struct scsi_cmnd * SCpnt);
 extern int mptscsih_dev_reset(struct scsi_cmnd * SCpnt);
 extern int mptscsih_bus_reset(struct scsi_cmnd * SCpnt);
 extern int mptscsih_host_reset(struct scsi_cmnd *SCpnt);
-extern int mptscsih_bios_param(struct scsi_device * sdev, struct block_device *bdev, sector_t capacity, int geom[]);
+extern int mptscsih_bios_param(struct scsi_device * sdev, struct gendisk *unused, sector_t capacity, int geom[]);
 extern int mptscsih_io_done(MPT_ADAPTER *ioc, MPT_FRAME_HDR *mf, MPT_FRAME_HDR *r);
 extern int mptscsih_taskmgmt_complete(MPT_ADAPTER *ioc, MPT_FRAME_HDR *mf, MPT_FRAME_HDR *r);
 extern int mptscsih_scandv_complete(MPT_ADAPTER *ioc, MPT_FRAME_HDR *mf, MPT_FRAME_HDR *r);
diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
index 883d4a12a172..a377a6f6900a 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -1695,7 +1695,7 @@ static int twa_reset_sequence(TW_Device_Extension *tw_dev, int soft_reset)
 } /* End twa_reset_sequence() */
 
 /* This funciton returns unit geometry in cylinders/heads/sectors */
-static int twa_scsi_biosparam(struct scsi_device *sdev, struct block_device *bdev, sector_t capacity, int geom[])
+static int twa_scsi_biosparam(struct scsi_device *sdev, struct gendisk *unused, sector_t capacity, int geom[])
 {
 	int heads, sectors, cylinders;
 
diff --git a/drivers/scsi/3w-sas.c b/drivers/scsi/3w-sas.c
index e057ab9c7b90..9bced6bca16e 100644
--- a/drivers/scsi/3w-sas.c
+++ b/drivers/scsi/3w-sas.c
@@ -1404,7 +1404,7 @@ static int twl_reset_device_extension(TW_Device_Extension *tw_dev, int ioctl_res
 } /* End twl_reset_device_extension() */
 
 /* This funciton returns unit geometry in cylinders/heads/sectors */
-static int twl_scsi_biosparam(struct scsi_device *sdev, struct block_device *bdev, sector_t capacity, int geom[])
+static int twl_scsi_biosparam(struct scsi_device *sdev, struct gendisk *unused, sector_t capacity, int geom[])
 {
 	int heads, sectors;
 
diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index 89bd56f78ef9..0306a228c702 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -1340,7 +1340,7 @@ static int tw_reset_device_extension(TW_Device_Extension *tw_dev)
 } /* End tw_reset_device_extension() */
 
 /* This funciton returns unit geometry in cylinders/heads/sectors */
-static int tw_scsi_biosparam(struct scsi_device *sdev, struct block_device *bdev,
+static int tw_scsi_biosparam(struct scsi_device *sdev, struct gendisk *unused,
 			     sector_t capacity, int geom[])
 {
 	int heads, sectors, cylinders;
diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index 743be2ef6d1a..8b17d8103e90 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -3240,7 +3240,7 @@ static int blogic_resetadapter(struct blogic_adapter *adapter, bool hard_reset)
   the BIOS, and a warning may be displayed.
 */
 
-static int blogic_diskparam(struct scsi_device *sdev, struct block_device *dev,
+static int blogic_diskparam(struct scsi_device *sdev, struct gendisk *disk,
 		sector_t capacity, int *params)
 {
 	struct blogic_adapter *adapter =
@@ -3261,7 +3261,7 @@ static int blogic_diskparam(struct scsi_device *sdev, struct block_device *dev,
 		diskparam->sectors = 32;
 	}
 	diskparam->cylinders = (unsigned long) capacity / (diskparam->heads * diskparam->sectors);
-	buf = scsi_bios_ptable(dev->bd_disk);
+	buf = scsi_bios_ptable(disk);
 	if (buf == NULL)
 		return 0;
 	/*
diff --git a/drivers/scsi/BusLogic.h b/drivers/scsi/BusLogic.h
index 61bf26d4fc10..79de815e33b0 100644
--- a/drivers/scsi/BusLogic.h
+++ b/drivers/scsi/BusLogic.h
@@ -1273,7 +1273,7 @@ static inline void blogic_incszbucket(unsigned int *cmdsz_buckets,
 
 static const char *blogic_drvr_info(struct Scsi_Host *);
 static int blogic_qcmd(struct Scsi_Host *h, struct scsi_cmnd *);
-static int blogic_diskparam(struct scsi_device *, struct block_device *, sector_t, int *);
+static int blogic_diskparam(struct scsi_device *, struct gendisk *, sector_t, int *);
 static int blogic_sdev_configure(struct scsi_device *,
 				 struct queue_limits *lim);
 static void blogic_qcompleted_ccb(struct blogic_ccb *);
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 2264a97d91a0..ea66196ef7c7 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -273,7 +273,7 @@ struct aac_driver_ident* aac_get_driver_ident(int devtype)
 /**
  *	aac_biosparm	-	return BIOS parameters for disk
  *	@sdev: The scsi device corresponding to the disk
- *	@bdev: the block device corresponding to the disk
+ *	@disk: the gendisk corresponding to the disk
  *	@capacity: the sector capacity of the disk
  *	@geom: geometry block to fill in
  *
@@ -292,7 +292,7 @@ struct aac_driver_ident* aac_get_driver_ident(int devtype)
  *	be displayed.
  */
 
-static int aac_biosparm(struct scsi_device *sdev, struct block_device *bdev,
+static int aac_biosparm(struct scsi_device *sdev, struct gendisk *disk,
 			sector_t capacity, int *geom)
 {
 	struct diskparm *param = (struct diskparm *)geom;
@@ -324,7 +324,7 @@ static int aac_biosparm(struct scsi_device *sdev, struct block_device *bdev,
 	 *	entry whose end_head matches one of the standard geometry
 	 *	translations ( 64/32, 128/32, 255/63 ).
 	 */
-	buf = scsi_bios_ptable(bdev->bd_disk);
+	buf = scsi_bios_ptable(disk);
 	if (!buf)
 		return 0;
 	if (*(__le16 *)(buf + 0x40) == cpu_to_le16(MSDOS_LABEL_MAGIC)) {
diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index 3a2c336307c0..063e1b5818d3 100644
--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -7096,7 +7096,7 @@ static int advansys_reset(struct scsi_cmnd *scp)
  * ip[2]: cylinders
  */
 static int
-advansys_biosparam(struct scsi_device *sdev, struct block_device *bdev,
+advansys_biosparam(struct scsi_device *sdev, struct gendisk *unused,
 		   sector_t capacity, int ip[])
 {
 	struct asc_board *boardp = shost_priv(sdev->host);
diff --git a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
index e94c0a19c435..182aa80ec4c6 100644
--- a/drivers/scsi/aha152x.c
+++ b/drivers/scsi/aha152x.c
@@ -1246,7 +1246,7 @@ int aha152x_host_reset_host(struct Scsi_Host *shpnt)
  * Return the "logical geometry"
  *
  */
-static int aha152x_biosparam(struct scsi_device *sdev, struct block_device *bdev,
+static int aha152x_biosparam(struct scsi_device *sdev, struct gendisk *disk,
 		sector_t capacity, int *info_array)
 {
 	struct Scsi_Host *shpnt = sdev->host;
@@ -1261,7 +1261,7 @@ static int aha152x_biosparam(struct scsi_device *sdev, struct block_device *bdev
 		int info[3];
 
 		/* try to figure out the geometry from the partition table */
-		if (scsicam_bios_param(bdev, capacity, info) < 0 ||
+		if (scsicam_bios_param(disk, capacity, info) < 0 ||
 		    !((info[0] == 64 && info[1] == 32) || (info[0] == 255 && info[1] == 63))) {
 			if (EXT_TRANS) {
 				printk(KERN_NOTICE
diff --git a/drivers/scsi/aha1542.c b/drivers/scsi/aha1542.c
index 389499d3e00a..371e8300f029 100644
--- a/drivers/scsi/aha1542.c
+++ b/drivers/scsi/aha1542.c
@@ -992,7 +992,7 @@ static int aha1542_host_reset(struct scsi_cmnd *cmd)
 }
 
 static int aha1542_biosparam(struct scsi_device *sdev,
-		struct block_device *bdev, sector_t capacity, int geom[])
+		struct gendisk *unused, sector_t capacity, int geom[])
 {
 	struct aha1542_hostdata *aha1542 = shost_priv(sdev->host);
 
diff --git a/drivers/scsi/aha1740.c b/drivers/scsi/aha1740.c
index be7ebbbb9ba8..b234621f6b37 100644
--- a/drivers/scsi/aha1740.c
+++ b/drivers/scsi/aha1740.c
@@ -510,7 +510,7 @@ static void aha1740_getconfig(unsigned int base, unsigned int *irq_level,
 }
 
 static int aha1740_biosparam(struct scsi_device *sdev,
-			     struct block_device *dev,
+			     struct gendisk *unused,
 			     sector_t capacity, int* ip)
 {
 	int size = capacity;
diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/aic79xx_osm.c
index 2cff19e95fec..c3d1b9dd24ae 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -720,7 +720,7 @@ ahd_linux_sdev_configure(struct scsi_device *sdev, struct queue_limits *lim)
  * Return the disk geometry for the given SCSI device.
  */
 static int
-ahd_linux_biosparam(struct scsi_device *sdev, struct block_device *bdev,
+ahd_linux_biosparam(struct scsi_device *sdev, struct gendisk *disk,
 		    sector_t capacity, int geom[])
 {
 	int	 heads;
@@ -731,7 +731,7 @@ ahd_linux_biosparam(struct scsi_device *sdev, struct block_device *bdev,
 
 	ahd = *((struct ahd_softc **)sdev->host->hostdata);
 
-	if (scsi_partsize(bdev->bd_disk, capacity, geom))
+	if (scsi_partsize(disk, capacity, geom))
 		return 0;
 
 	heads = 64;
diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
index 05bdb73d1157..8b2b98666d61 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -683,7 +683,7 @@ ahc_linux_sdev_configure(struct scsi_device *sdev, struct queue_limits *lim)
  * Return the disk geometry for the given SCSI device.
  */
 static int
-ahc_linux_biosparam(struct scsi_device *sdev, struct block_device *bdev,
+ahc_linux_biosparam(struct scsi_device *sdev, struct gendisk *disk,
 		    sector_t capacity, int geom[])
 {
 	int	 heads;
@@ -696,7 +696,7 @@ ahc_linux_biosparam(struct scsi_device *sdev, struct block_device *bdev,
 	ahc = *((struct ahc_softc **)sdev->host->hostdata);
 	channel = sdev_channel(sdev);
 
-	if (scsi_partsize(bdev->bd_disk, capacity, geom))
+	if (scsi_partsize(disk, capacity, geom))
 		return 0;
 
 	heads = 64;
diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 6968da9fb67c..f0c5a30ce51b 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -112,7 +112,7 @@ static int arcmsr_iop_confirm(struct AdapterControlBlock *acb);
 static int arcmsr_abort(struct scsi_cmnd *);
 static int arcmsr_bus_reset(struct scsi_cmnd *);
 static int arcmsr_bios_param(struct scsi_device *sdev,
-		struct block_device *bdev, sector_t capacity, int *info);
+		struct gendisk *disk, sector_t capacity, int *info);
 static int arcmsr_queue_command(struct Scsi_Host *h, struct scsi_cmnd *cmd);
 static int arcmsr_probe(struct pci_dev *pdev,
 				const struct pci_device_id *id);
@@ -377,11 +377,11 @@ static irqreturn_t arcmsr_do_interrupt(int irq, void *dev_id)
 }
 
 static int arcmsr_bios_param(struct scsi_device *sdev,
-		struct block_device *bdev, sector_t capacity, int *geom)
+		struct gendisk *disk, sector_t capacity, int *geom)
 {
 	int heads, sectors, cylinders, total_capacity;
 
-	if (scsi_partsize(bdev->bd_disk, capacity, geom))
+	if (scsi_partsize(disk, capacity, geom))
 		return 0;
 
 	total_capacity = capacity;
diff --git a/drivers/scsi/atp870u.c b/drivers/scsi/atp870u.c
index 401242912855..df6f40b51deb 100644
--- a/drivers/scsi/atp870u.c
+++ b/drivers/scsi/atp870u.c
@@ -1692,7 +1692,7 @@ static int atp870u_show_info(struct seq_file *m, struct Scsi_Host *HBAptr)
 }
 
 
-static int atp870u_biosparam(struct scsi_device *disk, struct block_device *dev,
+static int atp870u_biosparam(struct scsi_device *disk, struct gendisk *unused,
 			sector_t capacity, int *ip)
 {
 	int heads, sectors, cylinders;
diff --git a/drivers/scsi/fdomain.c b/drivers/scsi/fdomain.c
index 4a3716dc644c..c0b2a980db34 100644
--- a/drivers/scsi/fdomain.c
+++ b/drivers/scsi/fdomain.c
@@ -469,10 +469,10 @@ static int fdomain_host_reset(struct scsi_cmnd *cmd)
 }
 
 static int fdomain_biosparam(struct scsi_device *sdev,
-			     struct block_device *bdev,	sector_t capacity,
+			     struct gendisk *disk, sector_t capacity,
 			     int geom[])
 {
-	unsigned char *p = scsi_bios_ptable(bdev->bd_disk);
+	unsigned char *p = scsi_bios_ptable(disk);
 
 	if (p && p[65] == 0xaa && p[64] == 0x55 /* Partition table valid */
 	    && p[4]) {	 /* Partition type */
diff --git a/drivers/scsi/imm.c b/drivers/scsi/imm.c
index 0821cf994b98..5c602c057798 100644
--- a/drivers/scsi/imm.c
+++ b/drivers/scsi/imm.c
@@ -954,7 +954,7 @@ static DEF_SCSI_QCMD(imm_queuecommand)
  * be done in sd.c.  Even if it gets fixed there, this will still
  * work.
  */
-static int imm_biosparam(struct scsi_device *sdev, struct block_device *dev,
+static int imm_biosparam(struct scsi_device *sdev, struct gendisk *unused,
 			 sector_t capacity, int ip[])
 {
 	ip[0] = 0x40;
diff --git a/drivers/scsi/initio.c b/drivers/scsi/initio.c
index 8648bd965287..ed34ad92c807 100644
--- a/drivers/scsi/initio.c
+++ b/drivers/scsi/initio.c
@@ -2645,7 +2645,7 @@ static int i91u_bus_reset(struct scsi_cmnd * cmnd)
 /**
  *	i91u_biosparam			-	return the "logical geometry
  *	@sdev: SCSI device
- *	@dev: Matching block device
+ *	@unused: Matching gendisk
  *	@capacity: Sector size of drive
  *	@info_array: Return space for BIOS geometry
  *
@@ -2655,7 +2655,7 @@ static int i91u_bus_reset(struct scsi_cmnd * cmnd)
  *	FIXME: limited to 2^32 sector devices.
  */
 
-static int i91u_biosparam(struct scsi_device *sdev, struct block_device *dev,
+static int i91u_biosparam(struct scsi_device *sdev, struct gendisk *unused,
 		sector_t capacity, int *info_array)
 {
 	struct initio_host *host;		/* Point to Host adapter control block */
diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index b29bec6abd72..36710df9b723 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -4644,10 +4644,10 @@ ATTRIBUTE_GROUPS(ipr_dev);
 
 /**
  * ipr_biosparam - Return the HSC mapping
- * @sdev:			scsi device struct
- * @block_device:	block device pointer
+ * @sdev:		scsi device struct
+ * @unused:		gendisk pointer
  * @capacity:		capacity of the device
- * @parm:			Array containing returned HSC values.
+ * @parm:		Array containing returned HSC values.
  *
  * This function generates the HSC parms that fdisk uses.
  * We want to make sure we return something that places partitions
@@ -4657,7 +4657,7 @@ ATTRIBUTE_GROUPS(ipr_dev);
  * 	0 on success
  **/
 static int ipr_biosparam(struct scsi_device *sdev,
-			 struct block_device *block_device,
+			 struct gendisk *unused,
 			 sector_t capacity, int *parm)
 {
 	int heads, sectors;
diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index 94adb6ac02a4..3393a288fd23 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -1123,7 +1123,7 @@ static DEF_SCSI_QCMD(ips_queue)
 /*   Set bios geometry for the controller                                   */
 /*                                                                          */
 /****************************************************************************/
-static int ips_biosparam(struct scsi_device *sdev, struct block_device *bdev,
+static int ips_biosparam(struct scsi_device *sdev, struct gendisk *unused,
 			 sector_t capacity, int geom[])
 {
 	ips_ha_t *ha = (ips_ha_t *) sdev->host->hostdata;
diff --git a/drivers/scsi/ips.h b/drivers/scsi/ips.h
index 8ac932ec4444..30a4d4a580e9 100644
--- a/drivers/scsi/ips.h
+++ b/drivers/scsi/ips.h
@@ -398,7 +398,7 @@
    /*
     * Scsi_Host Template
     */
-   static int ips_biosparam(struct scsi_device *sdev, struct block_device *bdev,
+   static int ips_biosparam(struct scsi_device *sdev, struct gendisk *unused,
 		sector_t capacity, int geom[]);
    static int ips_sdev_configure(struct scsi_device *SDptr,
 				 struct queue_limits *lim);
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 928723c90b75..ffa5b49aaf08 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -845,7 +845,7 @@ int sas_change_queue_depth(struct scsi_device *sdev, int depth)
 EXPORT_SYMBOL_GPL(sas_change_queue_depth);
 
 int sas_bios_param(struct scsi_device *scsi_dev,
-			  struct block_device *bdev,
+			  struct gendisk *unused,
 			  sector_t capacity, int *hsc)
 {
 	hsc[0] = 255;
diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index c7581c7829af..a00622c0c526 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -2780,7 +2780,7 @@ static inline void mega_create_proc_entry(int index, struct proc_dir_entry *pare
  * Return the disk geometry for a particular disk
  */
 static int
-megaraid_biosparam(struct scsi_device *sdev, struct block_device *bdev,
+megaraid_biosparam(struct scsi_device *sdev, struct gendisk *disk,
 		    sector_t capacity, int geom[])
 {
 	adapter_t	*adapter;
@@ -2813,7 +2813,7 @@ megaraid_biosparam(struct scsi_device *sdev, struct block_device *bdev,
 			geom[2] = cylinders;
 	}
 	else {
-		if (scsi_partsize(bdev->bd_disk, capacity, geom))
+		if (scsi_partsize(disk, capacity, geom))
 			return 0;
 
 		dev_info(&adapter->dev->dev,
diff --git a/drivers/scsi/megaraid.h b/drivers/scsi/megaraid.h
index 013fbfb911b9..d6bfd26a8843 100644
--- a/drivers/scsi/megaraid.h
+++ b/drivers/scsi/megaraid.h
@@ -975,7 +975,7 @@ static void mega_free_scb(adapter_t *, scb_t *);
 static int megaraid_abort(struct scsi_cmnd *);
 static int megaraid_reset(struct scsi_cmnd *);
 static int megaraid_abort_and_reset(adapter_t *, struct scsi_cmnd *, int);
-static int megaraid_biosparam(struct scsi_device *, struct block_device *,
+static int megaraid_biosparam(struct scsi_device *, struct gendisk *,
 		sector_t, int []);
 
 static int mega_build_sglist (adapter_t *adapter, scb_t *scb,
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 9179f8aee964..fd1047cc00e0 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3137,12 +3137,12 @@ static int megasas_reset_target(struct scsi_cmnd *scmd)
 /**
  * megasas_bios_param - Returns disk geometry for a disk
  * @sdev:		device handle
- * @bdev:		block device
+ * @unused:		gendisk
  * @capacity:		drive capacity
  * @geom:		geometry parameters
  */
 static int
-megasas_bios_param(struct scsi_device *sdev, struct block_device *bdev,
+megasas_bios_param(struct scsi_device *sdev, struct gendisk *unused,
 		 sector_t capacity, int geom[])
 {
 	int heads;
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index ce444efd859e..1355823cbbc0 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -4013,7 +4013,7 @@ int mpi3mr_issue_tm(struct mpi3mr_ioc *mrioc, u8 tm_type,
 /**
  * mpi3mr_bios_param - BIOS param callback
  * @sdev: SCSI device reference
- * @bdev: Block device reference
+ * @unused: gendisk reference
  * @capacity: Capacity in logical sectors
  * @params: Parameter array
  *
@@ -4022,7 +4022,7 @@ int mpi3mr_issue_tm(struct mpi3mr_ioc *mrioc, u8 tm_type,
  * Return: 0 always
  */
 static int mpi3mr_bios_param(struct scsi_device *sdev,
-	struct block_device *bdev, sector_t capacity, int params[])
+	struct gendisk *unused, sector_t capacity, int params[])
 {
 	int heads;
 	int sectors;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 508861e88d9f..d52ecbdb4564 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -2746,7 +2746,7 @@ scsih_sdev_configure(struct scsi_device *sdev, struct queue_limits *lim)
 /**
  * scsih_bios_param - fetch head, sector, cylinder info for a disk
  * @sdev: scsi device struct
- * @bdev: pointer to block device context
+ * @unused: pointer to gendisk
  * @capacity: device size (in 512 byte sectors)
  * @params: three element array to place output:
  *              params[0] number of heads (max 255)
@@ -2754,7 +2754,7 @@ scsih_sdev_configure(struct scsi_device *sdev, struct queue_limits *lim)
  *              params[2] number of cylinders
  */
 static int
-scsih_bios_param(struct scsi_device *sdev, struct block_device *bdev,
+scsih_bios_param(struct scsi_device *sdev, struct gendisk *unused,
 	sector_t capacity, int params[])
 {
 	int		heads;
diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 96549e7f5705..bdc2f2f17753 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -2142,7 +2142,7 @@ static enum scsi_timeout_action mvumi_timed_out(struct scsi_cmnd *scmd)
 }
 
 static int
-mvumi_bios_param(struct scsi_device *sdev, struct block_device *bdev,
+mvumi_bios_param(struct scsi_device *sdev, struct gendisk *unused,
 			sector_t capacity, int geom[])
 {
 	int heads, sectors;
diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index 486db5b2f05d..b8453c0333dc 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -1745,7 +1745,7 @@ static void myrb_sdev_destroy(struct scsi_device *sdev)
 	kfree(sdev->hostdata);
 }
 
-static int myrb_biosparam(struct scsi_device *sdev, struct block_device *bdev,
+static int myrb_biosparam(struct scsi_device *sdev, struct gendisk *unused,
 		sector_t capacity, int geom[])
 {
 	struct myrb_hba *cb = shost_priv(sdev->host);
diff --git a/drivers/scsi/pcmcia/sym53c500_cs.c b/drivers/scsi/pcmcia/sym53c500_cs.c
index 278c78d066c4..a3b505240351 100644
--- a/drivers/scsi/pcmcia/sym53c500_cs.c
+++ b/drivers/scsi/pcmcia/sym53c500_cs.c
@@ -597,7 +597,7 @@ SYM53C500_host_reset(struct scsi_cmnd *SCpnt)
 
 static int 
 SYM53C500_biosparm(struct scsi_device *disk,
-    struct block_device *dev,
+    struct gendisk *unused,
     sector_t capacity, int *info_array)
 {
 	int size;
diff --git a/drivers/scsi/ppa.c b/drivers/scsi/ppa.c
index 1ed3171f1797..ea682f3044b6 100644
--- a/drivers/scsi/ppa.c
+++ b/drivers/scsi/ppa.c
@@ -845,7 +845,7 @@ static DEF_SCSI_QCMD(ppa_queuecommand)
  * be done in sd.c.  Even if it gets fixed there, this will still
  * work.
  */
-static int ppa_biosparam(struct scsi_device *sdev, struct block_device *dev,
+static int ppa_biosparam(struct scsi_device *sdev, struct gendisk *unused,
 	      sector_t capacity, int ip[])
 {
 	ip[0] = 0x40;
diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 6af018f1ca22..ef841f643171 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -1023,7 +1023,7 @@ qla1280_eh_adapter_reset(struct scsi_cmnd *cmd)
 }
 
 static int
-qla1280_biosparam(struct scsi_device *sdev, struct block_device *bdev,
+qla1280_biosparam(struct scsi_device *sdev, struct gendisk *unused,
 		  sector_t capacity, int geom[])
 {
 	int heads, sectors, cylinders;
diff --git a/drivers/scsi/qlogicfas408.c b/drivers/scsi/qlogicfas408.c
index 3e065d5fc80c..1ce469b7db99 100644
--- a/drivers/scsi/qlogicfas408.c
+++ b/drivers/scsi/qlogicfas408.c
@@ -492,7 +492,7 @@ DEF_SCSI_QCMD(qlogicfas408_queuecommand)
  *	Return bios parameters
  */
 
-int qlogicfas408_biosparam(struct scsi_device *disk, struct block_device *dev,
+int qlogicfas408_biosparam(struct scsi_device *disk, struct gendisk *unused,
 			   sector_t capacity, int ip[])
 {
 /* This should mimic the DOS Qlogic driver's behavior exactly */
diff --git a/drivers/scsi/qlogicfas408.h b/drivers/scsi/qlogicfas408.h
index a971db11d293..83ef86c71f2f 100644
--- a/drivers/scsi/qlogicfas408.h
+++ b/drivers/scsi/qlogicfas408.h
@@ -106,7 +106,7 @@ struct qlogicfas408_priv {
 irqreturn_t qlogicfas408_ihandl(int irq, void *dev_id);
 int qlogicfas408_queuecommand(struct Scsi_Host *h, struct scsi_cmnd * cmd);
 int qlogicfas408_biosparam(struct scsi_device * disk,
-			   struct block_device *dev,
+			   struct gendisk *unused,
 			   sector_t capacity, int ip[]);
 int qlogicfas408_abort(struct scsi_cmnd * cmd);
 extern int qlogicfas408_host_reset(struct scsi_cmnd *cmd);
diff --git a/drivers/scsi/scsicam.c b/drivers/scsi/scsicam.c
index 3ff2cf51d5b0..887de505bcf9 100644
--- a/drivers/scsi/scsicam.c
+++ b/drivers/scsi/scsicam.c
@@ -205,7 +205,7 @@ static int setsize(unsigned long capacity, unsigned int *cyls, unsigned int *hds
 
 /**
  * scsicam_bios_param - Determine geometry of a disk in cylinders/heads/sectors.
- * @bdev: which device
+ * @disk: which device
  * @capacity: size of the disk in sectors
  * @ip: return value: ip[0]=heads, ip[1]=sectors, ip[2]=cylinders
  *
@@ -215,13 +215,13 @@ static int setsize(unsigned long capacity, unsigned int *cyls, unsigned int *hds
  *
  * Returns : -1 on failure, 0 on success.
  */
-int scsicam_bios_param(struct block_device *bdev, sector_t capacity, int *ip)
+int scsicam_bios_param(struct gendisk *disk, sector_t capacity, int *ip)
 {
 	u64 capacity64 = capacity;	/* Suppress gcc warning */
 	int ret = 0;
 
 	/* try to infer mapping from partition table */
-	if (scsi_partsize(bdev->bd_disk, capacity, ip))
+	if (scsi_partsize(disk, capacity, ip))
 		return 0;
 
 	if (capacity64 < (1ULL << 32)) {
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index eeaa6af294b8..0dd2a092170a 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1609,9 +1609,9 @@ static int sd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 
 	/* override with calculated, extended default, or driver values */
 	if (host->hostt->bios_param)
-		host->hostt->bios_param(sdp, bdev, capacity, diskinfo);
+		host->hostt->bios_param(sdp, bdev->bd_disk, capacity, diskinfo);
 	else
-		scsicam_bios_param(bdev, capacity, diskinfo);
+		scsicam_bios_param(bdev->bd_disk, capacity, diskinfo);
 
 	geo->heads = diskinfo[0];
 	geo->sectors = diskinfo[1];
diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
index 63ed7f9aaa93..d8ad02c29320 100644
--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -1457,7 +1457,7 @@ static void stex_reset_work(struct work_struct *work)
 }
 
 static int stex_biosparam(struct scsi_device *sdev,
-	struct block_device *bdev, sector_t capacity, int geom[])
+	struct gendisk *unused, sector_t capacity, int geom[])
 {
 	int heads = 255, sectors = 63;
 
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index d9e59204a9c3..dc51ea352198 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1615,7 +1615,7 @@ static int storvsc_sdev_configure(struct scsi_device *sdevice,
 	return 0;
 }
 
-static int storvsc_get_chs(struct scsi_device *sdev, struct block_device * bdev,
+static int storvsc_get_chs(struct scsi_device *sdev, struct gendisk *unused,
 			   sector_t capacity, int *info)
 {
 	sector_t nsect = capacity;
diff --git a/drivers/scsi/wd719x.c b/drivers/scsi/wd719x.c
index 5a380eecfc75..0c9987828774 100644
--- a/drivers/scsi/wd719x.c
+++ b/drivers/scsi/wd719x.c
@@ -544,7 +544,7 @@ static int wd719x_host_reset(struct scsi_cmnd *cmd)
 	return wd719x_chip_init(wd) == 0 ? SUCCESS : FAILED;
 }
 
-static int wd719x_biosparam(struct scsi_device *sdev, struct block_device *bdev,
+static int wd719x_biosparam(struct scsi_device *sdev, struct gendisk *unused,
 			    sector_t capacity, int geom[])
 {
 	if (capacity >= 0x200000) {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1e5aec839041..1baf1df88b02 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1187,7 +1187,7 @@ extern void ata_qc_complete(struct ata_queued_cmd *qc);
 extern u64 ata_qc_get_active(struct ata_port *ap);
 extern void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd);
 extern int ata_std_bios_param(struct scsi_device *sdev,
-			      struct block_device *bdev,
+			      struct gendisk *unused,
 			      sector_t capacity, int geom[]);
 extern void ata_scsi_unlock_native_capacity(struct scsi_device *sdev);
 extern int ata_scsi_sdev_init(struct scsi_device *sdev);
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index ba460b6c0374..9c6e90829dbd 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -685,7 +685,7 @@ extern int sas_queuecommand(struct Scsi_Host *, struct scsi_cmnd *);
 extern int sas_target_alloc(struct scsi_target *);
 int sas_sdev_configure(struct scsi_device *dev, struct queue_limits *lim);
 extern int sas_change_queue_depth(struct scsi_device *, int new_depth);
-extern int sas_bios_param(struct scsi_device *, struct block_device *,
+extern int sas_bios_param(struct scsi_device *, struct gendisk *,
 			  sector_t capacity, int *hsc);
 int sas_execute_internal_abort_single(struct domain_device *device,
 				      u16 tag, unsigned int qid,
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index c53812b9026f..f5a243261236 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -318,7 +318,7 @@ struct scsi_host_template {
 	 *
 	 * Status: OPTIONAL
 	 */
-	int (* bios_param)(struct scsi_device *, struct block_device *,
+	int (* bios_param)(struct scsi_device *, struct gendisk *,
 			sector_t, int []);
 
 	/*
diff --git a/include/scsi/scsicam.h b/include/scsi/scsicam.h
index 67f4e8835bc8..1131f51ed2c8 100644
--- a/include/scsi/scsicam.h
+++ b/include/scsi/scsicam.h
@@ -14,7 +14,7 @@
 #ifndef SCSICAM_H
 #define SCSICAM_H
 struct gendisk;
-int scsicam_bios_param(struct block_device *bdev, sector_t capacity, int *ip);
+int scsicam_bios_param(struct gendisk *disk, sector_t capacity, int *ip);
 bool scsi_partsize(struct gendisk *disk, sector_t capacity, int geom[3]);
 unsigned char *scsi_bios_ptable(struct gendisk *disk);
 #endif /* def SCSICAM_H */
-- 
2.39.5


