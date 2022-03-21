Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4374E2ACB
	for <lists+linux-block@lfdr.de>; Mon, 21 Mar 2022 15:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349090AbiCUOaU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 21 Mar 2022 10:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349440AbiCUO37 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Mar 2022 10:29:59 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4331557B21
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 07:25:23 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id c2so10408719pga.10
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 07:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eJN4rSp81QMOseaNx/QepgZxezZlQQt9vNJia9NxfV8=;
        b=bSJzjq0aWHwQaZYRhu1aUexYauucvAGyjx7hphnX/Q5q08EKukctJbx9VvreqDCXdL
         mEpPfyl63qwmlxXVTE81jUuqDOq7nSyR/kqIH8TxvWOACy5ji50cHdgZlhwatKBkFyPp
         5uvvqWRPzC18o/2Mq3D4iJySLmGaDfHmPO+Kn9A34vCy+KsL8GL5WEnWxuqSlxZoXg4G
         h2unW6KOuUbDFg9kXiOJcR6rydJ0X3Q3UagbrNT0rr1bCl5C7f8iBu5Miigs0/nSTvDB
         O5q54Aeni6IK1ePYZ0nKzSmdS1WRwjfL2jjbV95/p/uvq7D20BTQ2mNB1Qf2EMg8LhdG
         Digg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eJN4rSp81QMOseaNx/QepgZxezZlQQt9vNJia9NxfV8=;
        b=Kr1kmy2B7GVevVCibyAPlgVTVGydoqmGs8cm8qWBFEypiax610TadfU15yERhiCTCO
         k1at8+lsqYvoU+Ni4gQcXJFG3mwDscAZI/hYrkzmzLeOOy/ZXOp2gpF7Sj4nhjoB4WPm
         k9Rybho0Jks0Dvr2pWNfNcApO/QqPvianH2X3xbkGUjSUxvLgREyLXqMkW+cNtU+9mb7
         vjMlwYfrUN5g3+N7SidWdCkulH6fGxMHdbRagQdgCwJ1ajN5Tp8ThnP+8o7qPYGOXCvC
         G7GZrg/D7KaXaHJnfciTn64jKN79BfkEKi/88lL3DDJK10qvUnUErFkjbSdOXN2k3vIh
         awLg==
X-Gm-Message-State: AOAM533s25va4Wp8JZWtOkLzgyiClXZxoevpiHS2coWsXSZEerpOpp76
        +Ey0aHmB4wyv9XlNQ1pc8aM=
X-Google-Smtp-Source: ABdhPJwu0JLsXJ+KGdPnDlowHZOZ3+qycFQyLZI04J+WMhIze12/zRgCsoGWb62gnPn/3NV83UTqHg==
X-Received: by 2002:a63:520c:0:b0:382:2953:a338 with SMTP id g12-20020a63520c000000b003822953a338mr13315871pgb.610.1647872722766;
        Mon, 21 Mar 2022 07:25:22 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id e6-20020a056a001a8600b004f78e446ff5sm20503225pfv.15.2022.03.21.07.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 07:25:22 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, mgurtovoy@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v2 2/2] virtio-blk: support mq_ops->queue_rqs()
Date:   Mon, 21 Mar 2022 23:24:41 +0900
Message-Id: <20220321142441.132888-3-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220321142441.132888-1-suwan.kim027@gmail.com>
References: <20220321142441.132888-1-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch supports mq_ops->queue_rqs() hook. It has an advantage of
batch submission to virtio-blk driver. It also helps polling I/O because
polling uses batched completion of block layer. Batch submission in
queue_rqs() can boost polling performance.

In queue_rqs(), it iterates plug->mq_list, collects requests that
belong to same HW queue and adds requests into virtqueue until it
encounters a request from other HW queue or sees the end of the list.
Then, virtio-blk kicks virtqueue to submit requests.

If there is an error, it inserts error request to requeue_list and
passes it to ordinary block layer path.

For verification, I did fio test.
(io_uring, randread, direct=1, bs=4K, iodepth=64 numjobs=N)
I set 4 vcpu and 2 virtio-blk queues for VM and run fio test 5 times.
It shows about 1-4% improvement.

                                 |   numjobs=2   |    numjobs=4
      -----------------------------------------------------------
        fio without queue_rqs()  |   282K IOPS   |    245K IOPS
      -----------------------------------------------------------
        fio with queue_rqs()     |   294K IOPS   |    249K IOPS

For polling I/O performance, I also did fio test as below.
(io_uring, hipri, randread, direct=1, bs=512, iodepth=64 numjobs=4)
I set 4 vcpu and 2 poll queues for VM.
It shows upto 7% improvement in polling I/O.

                                      |   IOPS   |  avg latency
      -----------------------------------------------------------
        fio poll without queue_rqs()  |   413K   |   619.72us
      -----------------------------------------------------------
        fio poll with queue_rqs()     |   445K   |   581.2 usec

Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/block/virtio_blk.c | 93 ++++++++++++++++++++++++++++++++++----
 1 file changed, 84 insertions(+), 9 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index cd3e11bb8559..b129d9b277ce 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -311,6 +311,28 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
 		virtqueue_notify(vq->vq);
 }
 
+static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
+					struct virtio_blk *vblk,
+					struct request *req,
+					struct virtblk_req *vbr, int *num)
+{
+	blk_status_t status;
+
+	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
+	if (unlikely(status))
+		return status;
+
+	blk_mq_start_request(req);
+
+	*num = virtblk_map_data(hctx, req, vbr);
+	if (unlikely(*num < 0)) {
+		virtblk_cleanup_cmd(req);
+		return BLK_STS_RESOURCE;
+	}
+
+	return BLK_STS_OK;
+}
+
 static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 			   const struct blk_mq_queue_data *bd)
 {
@@ -324,18 +346,10 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	blk_status_t status;
 	int err;
 
-	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
+	status = virtblk_prep_rq(hctx, vblk, req, vbr, &num);
 	if (unlikely(status))
 		return status;
 
-	blk_mq_start_request(req);
-
-	num = virtblk_map_data(hctx, req, vbr);
-	if (unlikely(num < 0)) {
-		virtblk_cleanup_cmd(req);
-		return BLK_STS_RESOURCE;
-	}
-
 	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
 	err = virtblk_add_req(vblk->vqs[qid].vq, vbr, vbr->sg_table.sgl, num);
 	if (err) {
@@ -367,6 +381,66 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
+static bool virtblk_prep_rq_batch(struct virtio_blk_vq *vq, struct request *req)
+{
+	struct virtio_blk *vblk = req->mq_hctx->queue->queuedata;
+	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
+	unsigned long flags;
+	int num, err;
+
+	req->mq_hctx->tags->rqs[req->tag] = req;
+
+	if (virtblk_prep_rq(req->mq_hctx, vblk, req, vbr, &num) != BLK_STS_OK)
+		return false;
+
+	spin_lock_irqsave(&vq->lock, flags);
+	err = virtblk_add_req(vq->vq, vbr, vbr->sg_table.sgl, num);
+	if (err) {
+		spin_unlock_irqrestore(&vq->lock, flags);
+		virtblk_unmap_data(req, vbr);
+		virtblk_cleanup_cmd(req);
+		return false;
+	}
+	spin_unlock_irqrestore(&vq->lock, flags);
+
+	return true;
+}
+
+static void virtio_queue_rqs(struct request **rqlist)
+{
+	struct request *req, *next, *prev = NULL;
+	struct request *requeue_list = NULL;
+
+	rq_list_for_each_safe(rqlist, req, next) {
+		struct virtio_blk_vq *vq = req->mq_hctx->driver_data;
+		unsigned long flags;
+		bool kick;
+
+		if (!virtblk_prep_rq_batch(vq, req)) {
+			rq_list_move(rqlist, &requeue_list, req, prev);
+			req = prev;
+
+			if (!req)
+				continue;
+		}
+
+		if (!next || req->mq_hctx != next->mq_hctx) {
+			spin_lock_irqsave(&vq->lock, flags);
+			kick = virtqueue_kick_prepare(vq->vq);
+			spin_unlock_irqrestore(&vq->lock, flags);
+			if (kick)
+				virtqueue_notify(vq->vq);
+
+			req->rq_next = NULL;
+			*rqlist = next;
+			prev = NULL;
+		} else
+			prev = req;
+	}
+
+	*rqlist = requeue_list;
+}
+
 /* return id (s/n) string for *disk to *id_str
  */
 static int virtblk_get_id(struct gendisk *disk, char *id_str)
@@ -823,6 +897,7 @@ static int virtblk_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 
 static const struct blk_mq_ops virtio_mq_ops = {
 	.queue_rq	= virtio_queue_rq,
+	.queue_rqs	= virtio_queue_rqs,
 	.commit_rqs	= virtio_commit_rqs,
 	.init_hctx	= virtblk_init_hctx,
 	.complete	= virtblk_request_done,
-- 
2.26.3

