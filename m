Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8983C208A
	for <lists+linux-block@lfdr.de>; Fri,  9 Jul 2021 10:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhGIIOH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 9 Jul 2021 04:14:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45430 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231490AbhGIIOG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Jul 2021 04:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625818282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SrR2xOhsWwMcxQ7gA7t7ElNB6dEuVROBnVSLBdn7FcE=;
        b=cRu8uCYfYg4KxQNzY7L0wwKS8+aZY9VKbkO0dUo8bz0jp58X4Gd/5fsTHPoQ2278Iro2uH
        0LciL8DrcaQCiLBDXc10ide9QgQrpM0xNPfVCHLG27pKRqE+vgW/1RZct/+v4Po918oq4n
        i8oEmrGeNajFpYb0aJZWH3S8ayxafcA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-pVL0D9-uO_-Xmp8BVC4Ijg-1; Fri, 09 Jul 2021 04:11:20 -0400
X-MC-Unique: pVL0D9-uO_-Xmp8BVC4Ijg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A12A192FDA0;
        Fri,  9 Jul 2021 08:11:18 +0000 (UTC)
Received: from localhost (ovpn-13-13.pek2.redhat.com [10.72.13.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C07D05D6D3;
        Fri,  9 Jul 2021 08:11:17 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org
Cc:     Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 07/10] virtio: blk/scsi: replace blk_mq_virtio_map_queues with blk_mq_dev_map_queues
Date:   Fri,  9 Jul 2021 16:10:02 +0800
Message-Id: <20210709081005.421340-8-ming.lei@redhat.com>
In-Reply-To: <20210709081005.421340-1-ming.lei@redhat.com>
References: <20210709081005.421340-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace blk_mq_virtio_map_queues with blk_mq_dev_map_queues which is more
generic from blk-mq viewpoint, so we can unify all map queue
implementation.

Meantime we can pass 'use_manage_irq' info to blk-mq via
blk_mq_dev_map_queues(), this info needn't be 100% accurate, and what
we need is that true has to be passed in if the hba really uses managed
irq.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/virtio_blk.c | 12 ++++++++++--
 drivers/scsi/virtio_scsi.c | 11 ++++++++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index e4bd3b1fc3c2..9188b5bcbe78 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -677,12 +677,20 @@ static int virtblk_init_request(struct blk_mq_tag_set *set, struct request *rq,
 	return 0;
 }
 
+static const struct cpumask *virtblk_get_vq_affinity(void *dev_data,
+		int offset, int queue)
+{
+	struct virtio_device *vdev = dev_data;
+
+	return virtio_get_vq_affinity(vdev, offset + queue);
+}
+
 static int virtblk_map_queues(struct blk_mq_tag_set *set)
 {
 	struct virtio_blk *vblk = set->driver_data;
 
-	return blk_mq_virtio_map_queues(&set->map[HCTX_TYPE_DEFAULT],
-					vblk->vdev, 0);
+	return blk_mq_dev_map_queues(&set->map[HCTX_TYPE_DEFAULT], vblk->vdev,
+				     0, virtblk_get_vq_affinity, true, true);
 }
 
 static const struct blk_mq_ops virtio_mq_ops = {
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index fd69a03d6137..c4b97a0926df 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -712,12 +712,21 @@ static int virtscsi_abort(struct scsi_cmnd *sc)
 	return virtscsi_tmf(vscsi, cmd);
 }
 
+static const struct cpumask *virtscsi_get_vq_affinity(void *dev_data,
+		int offset, int queue)
+{
+	struct virtio_device *vdev = dev_data;
+
+	return virtio_get_vq_affinity(vdev, offset + queue);
+}
+
 static int virtscsi_map_queues(struct Scsi_Host *shost)
 {
 	struct virtio_scsi *vscsi = shost_priv(shost);
 	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
 
-	return blk_mq_virtio_map_queues(qmap, vscsi->vdev, 2);
+	return blk_mq_dev_map_queues(qmap, vscsi->vdev, 2,
+			virtscsi_get_vq_affinity, true, true);
 }
 
 static void virtscsi_commit_rqs(struct Scsi_Host *shost, u16 hwq)
-- 
2.31.1

