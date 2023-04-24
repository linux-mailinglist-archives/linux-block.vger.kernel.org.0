Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CFA6D110D
	for <lists+linux-block@lfdr.de>; Thu, 30 Mar 2023 23:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjC3VuA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 30 Mar 2023 17:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjC3Vt7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 17:49:59 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F42E192
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 14:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680212997; x=1711748997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tth4YVQZjZLkSdNcy5IQTp64dcRMHLiTkznSTq5hsSE=;
  b=nDtyYK61khe9tXYI4fBL2zUKMQwsjk7nSFomkL3Ns7KGnQoSQD050xQJ
   r0l1IER0aIw/qlIl8qe4Ahwzo8/CK4plw8vqm4TBYR/KqKyGNQn3OeGO2
   0qjRfhyfyEPD/6/5KdyotXHeGzB8Ap8bDkC/o4xrBw/Gy6KTndeNKOMpw
   pTtrkgKdmhaxqAnLmzSklVgwSCi0IqiWcnUvGbj+ClGHQzyKX+1anLVxB
   py4dX60yfarGP6Edei90rQAW3zmWEdRHj2NliOFe2DlrxVhqKsLJxAvKy
   K7Z55zQj6T5T8wbk8vev7kaA9tF2s30B8OKbGXcwKjv8Sd97tX8EEb1wx
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,306,1673884800"; 
   d="scan'208";a="331371072"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2023 05:49:57 +0800
IronPort-SDR: EBX2+L97V2pUmbn+ibodf11LRf+9Iw4Sa+uev9tmhaEf9ZuWt1idaB9/TlJ24v0fe1fDZc75i3
 MmCHr6WC6BVooXHw6k7n+L0kgEfZyWBavtCTHWr/jSNO3mwYDJMSQmjGOIGxLai4W35lt70l5q
 KaAeOn5IhS/5V9U3W1MXwqqMHL+OthWAt2GP0eDJUDtLSlq3ANzUh2draMSfePp0vOm9oSbLf5
 86xTyjc7tuyiHDZfYoFWWKrnUg9CZz7fYnErPyVaHhhtcsjXwQJK36pmzB40E1P7rzdrfGYEce
 tQg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 14:06:05 -0700
IronPort-SDR: xhO8+mTs0ss8Zi5BY5+vzSwcqSOUQ4/iKFPkKksKd0OAvlaXYhZaGjlJ2HzHjVMx3NV359eIP7
 mwaI/3/4JPmX3q58UWPUmQuO+X7Wj3tqLTGb5wL/iC+VJo+qdzt/j6aCcR2OJoxIwTeuwgLjMW
 FArlpubkw2QEHREcp8Dm4zXXLD7kVWIgYJDAtFWolWKs2MNhc/7DA6ym+T4eV20bsrOBFYSG11
 AoBsT4l3h9cJ9W31DMZGw/7DehBQ7FA06elGnADzbfqdmcb42TRiQowADCQrj/BwAitRPv0jE9
 zYM=
WDCIronportException: Internal
Received: from unknown (HELO oryx.wdc.com) ([10.225.167.80])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Mar 2023 14:49:56 -0700
From:   Dmitry Fomichev <dmitry.fomichev@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
Cc:     virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: [PATCH v2 1/2] virtio-blk: migrate to the latest patchset version
Date:   Thu, 30 Mar 2023 17:49:52 -0400
Message-Id: <20230330214953.1088216-2-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330214953.1088216-1-dmitry.fomichev@wdc.com>
References: <20230330214953.1088216-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The merged patch series to support zoned block devices in virtio-blk
is not the most up to date version. The merged patch can be found at

https://lore.kernel.org/linux-block/20221016034127.330942-3-dmitry.fomichev@wdc.com/

, but the latest and reviewed version is

https://lore.kernel.org/linux-block/20221110053952.3378990-3-dmitry.fomichev@wdc.com/

The differences between the two are mostly cleanups, but there is one
change that is very important in terms of compatibility with the
approved virtio-zbd specification.

Before it was approved, the OASIS virtio spec had a change in
VIRTIO_BLK_T_ZONE_APPEND request layout that is not reflected in the
current virtio-blk driver code. In the running code, the status is
the first byte of the in-header that is followed by some pad bytes
and the u64 that carries the sector at which the data has been written
to the zone back to the driver, aka the append sector.

This layout turned out to be problematic for implementing in QEMU and
the request status byte has been eventually made the last byte of the
in-header. The current code doesn't expect that and this causes the
append sector value always come as zero to the block layer. This needs
to be fixed ASAP.

Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/block/virtio_blk.c      | 238 +++++++++++++++++++++-----------
 include/uapi/linux/virtio_blk.h |  18 +--
 2 files changed, 166 insertions(+), 90 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2723eede6f21..4f0dbbb3d4a5 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -96,16 +96,14 @@ struct virtblk_req {
 
 		/*
 		 * The zone append command has an extended in header.
-		 * The status field in zone_append_in_hdr must have
-		 * the same offset in virtblk_req as the non-zoned
-		 * status field above.
+		 * The status field in zone_append_in_hdr must always
+		 * be the last byte.
 		 */
 		struct {
+			__virtio64 sector;
 			u8 status;
-			u8 reserved[7];
-			__le64 append_sector;
-		} zone_append_in_hdr;
-	};
+		} zone_append;
+	} in_hdr;
 
 	size_t in_hdr_len;
 
@@ -154,7 +152,7 @@ static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr)
 			sgs[num_out + num_in++] = vbr->sg_table.sgl;
 	}
 
-	sg_init_one(&in_hdr, &vbr->status, vbr->in_hdr_len);
+	sg_init_one(&in_hdr, &vbr->in_hdr.status, vbr->in_hdr_len);
 	sgs[num_out + num_in++] = &in_hdr;
 
 	return virtqueue_add_sgs(vq, sgs, num_out, num_in, vbr, GFP_ATOMIC);
@@ -242,11 +240,14 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 				      struct request *req,
 				      struct virtblk_req *vbr)
 {
-	size_t in_hdr_len = sizeof(vbr->status);
+	size_t in_hdr_len = sizeof(vbr->in_hdr.status);
 	bool unmap = false;
 	u32 type;
 	u64 sector = 0;
 
+	if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED) && op_is_zone_mgmt(req_op(req)))
+		return BLK_STS_NOTSUPP;
+
 	/* Set fields for all request types */
 	vbr->out_hdr.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
 
@@ -287,7 +288,7 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 	case REQ_OP_ZONE_APPEND:
 		type = VIRTIO_BLK_T_ZONE_APPEND;
 		sector = blk_rq_pos(req);
-		in_hdr_len = sizeof(vbr->zone_append_in_hdr);
+		in_hdr_len = sizeof(vbr->in_hdr.zone_append);
 		break;
 	case REQ_OP_ZONE_RESET:
 		type = VIRTIO_BLK_T_ZONE_RESET;
@@ -297,7 +298,10 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 		type = VIRTIO_BLK_T_ZONE_RESET_ALL;
 		break;
 	case REQ_OP_DRV_IN:
-		/* Out header already filled in, nothing to do */
+		/*
+		 * Out header has already been prepared by the caller (virtblk_get_id()
+		 * or virtblk_submit_zone_report()), nothing to do here.
+		 */
 		return 0;
 	default:
 		WARN_ON_ONCE(1);
@@ -318,16 +322,28 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 	return 0;
 }
 
+/*
+ * The status byte is always the last byte of the virtblk request
+ * in-header. This helper fetches its value for all in-header formats
+ * that are currently defined.
+ */
+static inline u8 virtblk_vbr_status(struct virtblk_req *vbr)
+{
+	return *((u8 *)&vbr->in_hdr + vbr->in_hdr_len - 1);
+}
+
 static inline void virtblk_request_done(struct request *req)
 {
 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
-	blk_status_t status = virtblk_result(vbr->status);
+	blk_status_t status = virtblk_result(virtblk_vbr_status(vbr));
+	struct virtio_blk *vblk = req->mq_hctx->queue->queuedata;
 
 	virtblk_unmap_data(req, vbr);
 	virtblk_cleanup_cmd(req);
 
 	if (req_op(req) == REQ_OP_ZONE_APPEND)
-		req->__sector = le64_to_cpu(vbr->zone_append_in_hdr.append_sector);
+		req->__sector = virtio64_to_cpu(vblk->vdev,
+						vbr->in_hdr.zone_append.sector);
 
 	blk_mq_end_request(req, status);
 }
@@ -355,7 +371,7 @@ static int virtblk_handle_req(struct virtio_blk_vq *vq,
 
 		if (likely(!blk_should_fake_timeout(req->q)) &&
 		    !blk_mq_complete_request_remote(req) &&
-		    !blk_mq_add_to_batch(req, iob, vbr->status,
+		    !blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr),
 					 virtblk_complete_batch))
 			virtblk_request_done(req);
 		req_done++;
@@ -550,7 +566,6 @@ static void virtio_queue_rqs(struct request **rqlist)
 #ifdef CONFIG_BLK_DEV_ZONED
 static void *virtblk_alloc_report_buffer(struct virtio_blk *vblk,
 					  unsigned int nr_zones,
-					  unsigned int zone_sectors,
 					  size_t *buflen)
 {
 	struct request_queue *q = vblk->disk->queue;
@@ -558,7 +573,7 @@ static void *virtblk_alloc_report_buffer(struct virtio_blk *vblk,
 	void *buf;
 
 	nr_zones = min_t(unsigned int, nr_zones,
-			 get_capacity(vblk->disk) >> ilog2(zone_sectors));
+			 get_capacity(vblk->disk) >> ilog2(vblk->zone_sectors));
 
 	bufsize = sizeof(struct virtio_blk_zone_report) +
 		nr_zones * sizeof(struct virtio_blk_zone_descriptor);
@@ -592,7 +607,7 @@ static int virtblk_submit_zone_report(struct virtio_blk *vblk,
 		return PTR_ERR(req);
 
 	vbr = blk_mq_rq_to_pdu(req);
-	vbr->in_hdr_len = sizeof(vbr->status);
+	vbr->in_hdr_len = sizeof(vbr->in_hdr.status);
 	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_ZONE_REPORT);
 	vbr->out_hdr.sector = cpu_to_virtio64(vblk->vdev, sector);
 
@@ -601,7 +616,7 @@ static int virtblk_submit_zone_report(struct virtio_blk *vblk,
 		goto out;
 
 	blk_execute_rq(req, false);
-	err = blk_status_to_errno(virtblk_result(vbr->status));
+	err = blk_status_to_errno(virtblk_result(vbr->in_hdr.status));
 out:
 	blk_mq_free_request(req);
 	return err;
@@ -609,29 +624,72 @@ static int virtblk_submit_zone_report(struct virtio_blk *vblk,
 
 static int virtblk_parse_zone(struct virtio_blk *vblk,
 			       struct virtio_blk_zone_descriptor *entry,
-			       unsigned int idx, unsigned int zone_sectors,
-			       report_zones_cb cb, void *data)
+			       unsigned int idx, report_zones_cb cb, void *data)
 {
 	struct blk_zone zone = { };
 
-	if (entry->z_type != VIRTIO_BLK_ZT_SWR &&
-	    entry->z_type != VIRTIO_BLK_ZT_SWP &&
-	    entry->z_type != VIRTIO_BLK_ZT_CONV) {
-		dev_err(&vblk->vdev->dev, "invalid zone type %#x\n",
-			entry->z_type);
-		return -EINVAL;
+	zone.start = virtio64_to_cpu(vblk->vdev, entry->z_start);
+	if (zone.start + vblk->zone_sectors <= get_capacity(vblk->disk))
+		zone.len = vblk->zone_sectors;
+	else
+		zone.len = get_capacity(vblk->disk) - zone.start;
+	zone.capacity = virtio64_to_cpu(vblk->vdev, entry->z_cap);
+	zone.wp = virtio64_to_cpu(vblk->vdev, entry->z_wp);
+
+	switch (entry->z_type) {
+	case VIRTIO_BLK_ZT_SWR:
+		zone.type = BLK_ZONE_TYPE_SEQWRITE_REQ;
+		break;
+	case VIRTIO_BLK_ZT_SWP:
+		zone.type = BLK_ZONE_TYPE_SEQWRITE_PREF;
+		break;
+	case VIRTIO_BLK_ZT_CONV:
+		zone.type = BLK_ZONE_TYPE_CONVENTIONAL;
+		break;
+	default:
+		dev_err(&vblk->vdev->dev, "zone %llu: invalid type %#x\n",
+			zone.start, entry->z_type);
+		return -EIO;
 	}
 
-	zone.type = entry->z_type;
-	zone.cond = entry->z_state;
-	zone.len = zone_sectors;
-	zone.capacity = le64_to_cpu(entry->z_cap);
-	zone.start = le64_to_cpu(entry->z_start);
-	if (zone.cond == BLK_ZONE_COND_FULL)
+	switch (entry->z_state) {
+	case VIRTIO_BLK_ZS_EMPTY:
+		zone.cond = BLK_ZONE_COND_EMPTY;
+		break;
+	case VIRTIO_BLK_ZS_CLOSED:
+		zone.cond = BLK_ZONE_COND_CLOSED;
+		break;
+	case VIRTIO_BLK_ZS_FULL:
+		zone.cond = BLK_ZONE_COND_FULL;
 		zone.wp = zone.start + zone.len;
-	else
-		zone.wp = le64_to_cpu(entry->z_wp);
+		break;
+	case VIRTIO_BLK_ZS_EOPEN:
+		zone.cond = BLK_ZONE_COND_EXP_OPEN;
+		break;
+	case VIRTIO_BLK_ZS_IOPEN:
+		zone.cond = BLK_ZONE_COND_IMP_OPEN;
+		break;
+	case VIRTIO_BLK_ZS_NOT_WP:
+		zone.cond = BLK_ZONE_COND_NOT_WP;
+		break;
+	case VIRTIO_BLK_ZS_RDONLY:
+		zone.cond = BLK_ZONE_COND_READONLY;
+		zone.wp = ULONG_MAX;
+		break;
+	case VIRTIO_BLK_ZS_OFFLINE:
+		zone.cond = BLK_ZONE_COND_OFFLINE;
+		zone.wp = ULONG_MAX;
+		break;
+	default:
+		dev_err(&vblk->vdev->dev, "zone %llu: invalid condition %#x\n",
+			zone.start, entry->z_state);
+		return -EIO;
+	}
 
+	/*
+	 * The callback below checks the validity of the reported
+	 * entry data, no need to further validate it here.
+	 */
 	return cb(&zone, idx, data);
 }
 
@@ -641,39 +699,47 @@ static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
 {
 	struct virtio_blk *vblk = disk->private_data;
 	struct virtio_blk_zone_report *report;
-	unsigned int zone_sectors = vblk->zone_sectors;
-	unsigned int nz, i;
-	int ret, zone_idx = 0;
+	unsigned long long nz, i;
 	size_t buflen;
+	unsigned int zone_idx = 0;
+	int ret;
 
 	if (WARN_ON_ONCE(!vblk->zone_sectors))
 		return -EOPNOTSUPP;
 
-	report = virtblk_alloc_report_buffer(vblk, nr_zones,
-					     zone_sectors, &buflen);
+	report = virtblk_alloc_report_buffer(vblk, nr_zones, &buflen);
 	if (!report)
 		return -ENOMEM;
 
+	mutex_lock(&vblk->vdev_mutex);
+
+	if (!vblk->vdev) {
+		ret = -ENXIO;
+		goto fail_report;
+	}
+
 	while (zone_idx < nr_zones && sector < get_capacity(vblk->disk)) {
 		memset(report, 0, buflen);
 
 		ret = virtblk_submit_zone_report(vblk, (char *)report,
 						 buflen, sector);
-		if (ret) {
-			if (ret > 0)
-				ret = -EIO;
-			goto out_free;
-		}
-		nz = min((unsigned int)le64_to_cpu(report->nr_zones), nr_zones);
+		if (ret)
+			goto fail_report;
+
+		nz = min_t(u64, virtio64_to_cpu(vblk->vdev, report->nr_zones),
+			   nr_zones);
 		if (!nz)
 			break;
 
 		for (i = 0; i < nz && zone_idx < nr_zones; i++) {
 			ret = virtblk_parse_zone(vblk, &report->zones[i],
-						 zone_idx, zone_sectors, cb, data);
+						 zone_idx, cb, data);
 			if (ret)
-				goto out_free;
-			sector = le64_to_cpu(report->zones[i].z_start) + zone_sectors;
+				goto fail_report;
+
+			sector = virtio64_to_cpu(vblk->vdev,
+						 report->zones[i].z_start) +
+				 vblk->zone_sectors;
 			zone_idx++;
 		}
 	}
@@ -682,7 +748,8 @@ static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
 		ret = zone_idx;
 	else
 		ret = -EINVAL;
-out_free:
+fail_report:
+	mutex_unlock(&vblk->vdev_mutex);
 	kvfree(report);
 	return ret;
 }
@@ -691,20 +758,28 @@ static void virtblk_revalidate_zones(struct virtio_blk *vblk)
 {
 	u8 model;
 
-	if (!vblk->zone_sectors)
-		return;
-
 	virtio_cread(vblk->vdev, struct virtio_blk_config,
 		     zoned.model, &model);
-	if (!blk_revalidate_disk_zones(vblk->disk, NULL))
-		set_capacity_and_notify(vblk->disk, 0);
+	switch (model) {
+	default:
+		dev_err(&vblk->vdev->dev, "unknown zone model %d\n", model);
+		fallthrough;
+	case VIRTIO_BLK_Z_NONE:
+	case VIRTIO_BLK_Z_HA:
+		disk_set_zoned(vblk->disk, BLK_ZONED_NONE);
+		return;
+	case VIRTIO_BLK_Z_HM:
+		WARN_ON_ONCE(!vblk->zone_sectors);
+		if (!blk_revalidate_disk_zones(vblk->disk, NULL))
+			set_capacity_and_notify(vblk->disk, 0);
+	}
 }
 
 static int virtblk_probe_zoned_device(struct virtio_device *vdev,
 				       struct virtio_blk *vblk,
 				       struct request_queue *q)
 {
-	u32 v;
+	u32 v, wg;
 	u8 model;
 	int ret;
 
@@ -713,16 +788,11 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
 
 	switch (model) {
 	case VIRTIO_BLK_Z_NONE:
+	case VIRTIO_BLK_Z_HA:
+		/* Present the host-aware device as non-zoned */
 		return 0;
 	case VIRTIO_BLK_Z_HM:
 		break;
-	case VIRTIO_BLK_Z_HA:
-		/*
-		 * Present the host-aware device as a regular drive.
-		 * TODO It is possible to add an option to make it appear
-		 * in the system as a zoned drive.
-		 */
-		return 0;
 	default:
 		dev_err(&vdev->dev, "unsupported zone model %d\n", model);
 		return -EINVAL;
@@ -735,32 +805,31 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
 
 	virtio_cread(vdev, struct virtio_blk_config,
 		     zoned.max_open_zones, &v);
-	disk_set_max_open_zones(vblk->disk, le32_to_cpu(v));
-
-	dev_dbg(&vdev->dev, "max open zones = %u\n", le32_to_cpu(v));
+	disk_set_max_open_zones(vblk->disk, v);
+	dev_dbg(&vdev->dev, "max open zones = %u\n", v);
 
 	virtio_cread(vdev, struct virtio_blk_config,
 		     zoned.max_active_zones, &v);
-	disk_set_max_active_zones(vblk->disk, le32_to_cpu(v));
-	dev_dbg(&vdev->dev, "max active zones = %u\n", le32_to_cpu(v));
+	disk_set_max_active_zones(vblk->disk, v);
+	dev_dbg(&vdev->dev, "max active zones = %u\n", v);
 
 	virtio_cread(vdev, struct virtio_blk_config,
-		     zoned.write_granularity, &v);
-	if (!v) {
+		     zoned.write_granularity, &wg);
+	if (!wg) {
 		dev_warn(&vdev->dev, "zero write granularity reported\n");
 		return -ENODEV;
 	}
-	blk_queue_physical_block_size(q, le32_to_cpu(v));
-	blk_queue_io_min(q, le32_to_cpu(v));
+	blk_queue_physical_block_size(q, wg);
+	blk_queue_io_min(q, wg);
 
-	dev_dbg(&vdev->dev, "write granularity = %u\n", le32_to_cpu(v));
+	dev_dbg(&vdev->dev, "write granularity = %u\n", wg);
 
 	/*
 	 * virtio ZBD specification doesn't require zones to be a power of
 	 * two sectors in size, but the code in this driver expects that.
 	 */
-	virtio_cread(vdev, struct virtio_blk_config, zoned.zone_sectors, &v);
-	vblk->zone_sectors = le32_to_cpu(v);
+	virtio_cread(vdev, struct virtio_blk_config, zoned.zone_sectors,
+		     &vblk->zone_sectors);
 	if (vblk->zone_sectors == 0 || !is_power_of_2(vblk->zone_sectors)) {
 		dev_err(&vdev->dev,
 			"zoned device with non power of two zone size %u\n",
@@ -783,8 +852,15 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
 			dev_warn(&vdev->dev, "zero max_append_sectors reported\n");
 			return -ENODEV;
 		}
-		blk_queue_max_zone_append_sectors(q, le32_to_cpu(v));
-		dev_dbg(&vdev->dev, "max append sectors = %u\n", le32_to_cpu(v));
+		if ((v << SECTOR_SHIFT) < wg) {
+			dev_err(&vdev->dev,
+				"write granularity %u exceeds max_append_sectors %u limit\n",
+				wg, v);
+			return -ENODEV;
+		}
+
+		blk_queue_max_zone_append_sectors(q, v);
+		dev_dbg(&vdev->dev, "max append sectors = %u\n", v);
 	}
 
 	return ret;
@@ -794,6 +870,7 @@ static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
 {
 	return virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED);
 }
+
 #else
 
 /*
@@ -801,9 +878,11 @@ static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
  * We only need to define a few symbols to avoid compilation errors.
  */
 #define virtblk_report_zones       NULL
+
 static inline void virtblk_revalidate_zones(struct virtio_blk *vblk)
 {
 }
+
 static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
 			struct virtio_blk *vblk, struct request_queue *q)
 {
@@ -831,7 +910,7 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
 		return PTR_ERR(req);
 
 	vbr = blk_mq_rq_to_pdu(req);
-	vbr->in_hdr_len = sizeof(vbr->status);
+	vbr->in_hdr_len = sizeof(vbr->in_hdr.status);
 	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_ID);
 	vbr->out_hdr.sector = 0;
 
@@ -840,7 +919,7 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
 		goto out;
 
 	blk_execute_rq(req, false);
-	err = blk_status_to_errno(virtblk_result(vbr->status));
+	err = blk_status_to_errno(virtblk_result(vbr->in_hdr.status));
 out:
 	blk_mq_free_request(req);
 	return err;
@@ -1504,9 +1583,6 @@ static int virtblk_probe(struct virtio_device *vdev)
 			goto out_cleanup_disk;
 	}
 
-	dev_info(&vdev->dev, "blk config size: %zu\n",
-		sizeof(struct virtio_blk_config));
-
 	err = device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
 	if (err)
 		goto out_cleanup_disk;
diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index 5af2a0300bb9..3744e4da1b2a 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -140,11 +140,11 @@ struct virtio_blk_config {
 
 	/* Zoned block device characteristics (if VIRTIO_BLK_F_ZONED) */
 	struct virtio_blk_zoned_characteristics {
-		__le32 zone_sectors;
-		__le32 max_open_zones;
-		__le32 max_active_zones;
-		__le32 max_append_sectors;
-		__le32 write_granularity;
+		__virtio32 zone_sectors;
+		__virtio32 max_open_zones;
+		__virtio32 max_active_zones;
+		__virtio32 max_append_sectors;
+		__virtio32 write_granularity;
 		__u8 model;
 		__u8 unused2[3];
 	} zoned;
@@ -241,11 +241,11 @@ struct virtio_blk_outhdr {
  */
 struct virtio_blk_zone_descriptor {
 	/* Zone capacity */
-	__le64 z_cap;
+	__virtio64 z_cap;
 	/* The starting sector of the zone */
-	__le64 z_start;
+	__virtio64 z_start;
 	/* Zone write pointer position in sectors */
-	__le64 z_wp;
+	__virtio64 z_wp;
 	/* Zone type */
 	__u8 z_type;
 	/* Zone state */
@@ -254,7 +254,7 @@ struct virtio_blk_zone_descriptor {
 };
 
 struct virtio_blk_zone_report {
-	__le64 nr_zones;
+	__virtio64 nr_zones;
 	__u8 reserved[56];
 	struct virtio_blk_zone_descriptor zones[];
 };
-- 
2.34.1

