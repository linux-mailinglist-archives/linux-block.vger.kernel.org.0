Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0214F41C8
	for <lists+linux-block@lfdr.de>; Tue,  5 Apr 2022 23:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiDET61 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 5 Apr 2022 15:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455099AbiDEP7h (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Apr 2022 11:59:37 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C221EC60F
        for <linux-block@vger.kernel.org>; Tue,  5 Apr 2022 08:09:59 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q19so11251778pgm.6
        for <linux-block@vger.kernel.org>; Tue, 05 Apr 2022 08:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OsQBgV6RiDL/nIj8RCzA65E63c+7TZ8ZOHwvD/MmE7E=;
        b=Ix1UePss6t0Um+MzbqPiPQpVI1kkwW7Nvw0JuEmUfmWcYtWe3gj7c5hq+VYo0fnZ1G
         qN+sNyOMgAfCygz7QTi6KaJCXPOoszTccS4RFbDSjwklKys8VGITjH+qN9mXX6kHobVr
         70ylOzmuRk6vluH1C0+jrwm7nUZZWhoO0Cdl6Mt/Ogq/+IFrHKOE39ftVcYl8ayA2tiM
         d/k5m9+V7+60RvR7uQ2ZZYpEGTG1TQYGjUf8sKEvjBqKiwUUmzjSuug3GDsm/fLfl1zr
         O83wntj1nOeqP3fNUY3GX9ZcvjBZT6TPd0qL4OmSVNl3/NKdk1I87wx9hS+usum7rzyJ
         UHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OsQBgV6RiDL/nIj8RCzA65E63c+7TZ8ZOHwvD/MmE7E=;
        b=KwUsP9zIQM0Ac2uBS0E6vpfAQSQ/eWYN6GZvEzOrdlzECw75vlfeD0nxDT7HVr7qQh
         hfipkfjqcV8BpRpikSV0fYwgjYRqnQY9yVyLLaGXgDV5Ax7kDC2G2KVuAwNQ2bSouMPn
         oGVBCs2bx7N9/g6OAePy8uIhsXGxHuDwslaZvYOxTK+6n2J+FYyaAdmw0yOJC5MXfBy0
         hu4NVsmQ0jaMpDgyBQ8SkJCkKVQrFdDsfrlXj+cm3OPoFTo2CBGcUDf2/vcj/QHz5RjB
         SIB0ZbPiSn/dp2C4uLOu3qQ+38BmWV0f/NWodrOk4vpW+fWp057pL7x2I9fMS8tXHkP1
         +qzA==
X-Gm-Message-State: AOAM5304+dJ9zZa9GklzNIC+HhzgrAEfjz2+NALLJAXApqC4w+j9lKnP
        D4sdtbmMHwbUWLTOdYTmS5g=
X-Google-Smtp-Source: ABdhPJzEkkahnalvcQKATWLmiliTl8ZWKl7MAsmNKnk33fG7QbsAWC2XgSA0IWNz6TVRsK4VLeNpKQ==
X-Received: by 2002:a63:1e52:0:b0:380:ae84:256e with SMTP id p18-20020a631e52000000b00380ae84256emr3322335pgm.84.1649171399484;
        Tue, 05 Apr 2022 08:09:59 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id y2-20020a056a00190200b004fa865d1fd3sm16071772pfi.86.2022.04.05.08.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 08:09:58 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, mgurtovoy@nvidia.com, dongli.zhang@oracle.com,
        hch@infradead.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v5 2/2] virtio-blk: support mq_ops->queue_rqs()
Date:   Wed,  6 Apr 2022 00:09:24 +0900
Message-Id: <20220405150924.147021-3-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220405150924.147021-1-suwan.kim027@gmail.com>
References: <20220405150924.147021-1-suwan.kim027@gmail.com>
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
belong to same HW queue until it encounters a request from other
HW queue or sees the end of the list.
Then, virtio-blk adds requests into virtqueue and kicks virtqueue
to submit requests.

If there is an error, it inserts error request to requeue_list and
passes it to ordinary block layer path.

For verification, I did fio test.
(io_uring, randread, direct=1, bs=4K, iodepth=64 numjobs=N)
I set 4 vcpu and 2 virtio-blk queues for VM and run fio test 5 times.
It shows about 2% improvement.

                                 |   numjobs=2   |   numjobs=4
      -----------------------------------------------------------
        fio without queue_rqs()  |   291K IOPS   |   238K IOPS
      -----------------------------------------------------------
        fio with queue_rqs()     |   295K IOPS   |   243K IOPS

For polling I/O performance, I also did fio test as below.
(io_uring, hipri, randread, direct=1, bs=512, iodepth=64 numjobs=4)
I set 4 vcpu and 2 poll queues for VM.
It shows about 2% improvement in polling I/O.

                                      |   IOPS   |  avg latency
      -----------------------------------------------------------
        fio poll without queue_rqs()  |   424K   |   613.05 usec
      -----------------------------------------------------------
        fio poll with queue_rqs()     |   435K   |   601.01 usec

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/block/virtio_blk.c | 114 +++++++++++++++++++++++++++++++------
 1 file changed, 98 insertions(+), 16 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 51eea2a49e11..9260522eaaa6 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -108,8 +108,7 @@ static inline blk_status_t virtblk_result(struct virtblk_req *vbr)
 	}
 }
 
-static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr,
-		struct scatterlist *data_sg, bool have_data)
+static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr)
 {
 	struct scatterlist hdr, status, *sgs[3];
 	unsigned int num_out = 0, num_in = 0;
@@ -117,11 +116,11 @@ static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr,
 	sg_init_one(&hdr, &vbr->out_hdr, sizeof(vbr->out_hdr));
 	sgs[num_out++] = &hdr;
 
-	if (have_data) {
+	if (vbr->sg_table.nents) {
 		if (vbr->out_hdr.type & cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_OUT))
-			sgs[num_out++] = data_sg;
+			sgs[num_out++] = vbr->sg_table.sgl;
 		else
-			sgs[num_out + num_in++] = data_sg;
+			sgs[num_out + num_in++] = vbr->sg_table.sgl;
 	}
 
 	sg_init_one(&status, &vbr->status, sizeof(vbr->status));
@@ -311,6 +310,28 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
 		virtqueue_notify(vq->vq);
 }
 
+static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
+					struct virtio_blk *vblk,
+					struct request *req,
+					struct virtblk_req *vbr)
+{
+	blk_status_t status;
+
+	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
+	if (unlikely(status))
+		return status;
+
+	blk_mq_start_request(req);
+
+	vbr->sg_table.nents = virtblk_map_data(hctx, req, vbr);
+	if (unlikely(vbr->sg_table.nents < 0)) {
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
@@ -318,26 +339,17 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct request *req = bd->rq;
 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
 	unsigned long flags;
-	int num;
 	int qid = hctx->queue_num;
 	bool notify = false;
 	blk_status_t status;
 	int err;
 
-	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
+	status = virtblk_prep_rq(hctx, vblk, req, vbr);
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
-	err = virtblk_add_req(vblk->vqs[qid].vq, vbr, vbr->sg_table.sgl, num);
+	err = virtblk_add_req(vblk->vqs[qid].vq, vbr);
 	if (err) {
 		virtqueue_kick(vblk->vqs[qid].vq);
 		/* Don't stop the queue if -ENOMEM: we may have failed to
@@ -367,6 +379,75 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
+static bool virtblk_prep_rq_batch(struct request *req)
+{
+	struct virtio_blk *vblk = req->mq_hctx->queue->queuedata;
+	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
+
+	req->mq_hctx->tags->rqs[req->tag] = req;
+
+	return virtblk_prep_rq(req->mq_hctx, vblk, req, vbr) == BLK_STS_OK;
+}
+
+static bool virtblk_add_req_batch(struct virtio_blk_vq *vq,
+					struct request **rqlist,
+					struct request **requeue_list)
+{
+	unsigned long flags;
+	int err;
+	bool kick;
+
+	spin_lock_irqsave(&vq->lock, flags);
+
+	while (!rq_list_empty(*rqlist)) {
+		struct request *req = rq_list_pop(rqlist);
+		struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
+
+		err = virtblk_add_req(vq->vq, vbr);
+		if (err) {
+			virtblk_unmap_data(req, vbr);
+			virtblk_cleanup_cmd(req);
+			rq_list_add(requeue_list, req);
+		}
+	}
+
+	kick = virtqueue_kick_prepare(vq->vq);
+	spin_unlock_irqrestore(&vq->lock, flags);
+
+	return kick;
+}
+
+static void virtio_queue_rqs(struct request **rqlist)
+{
+	struct request *req, *next, *prev = NULL;
+	struct request *requeue_list = NULL;
+
+	rq_list_for_each_safe(rqlist, req, next) {
+		struct virtio_blk_vq *vq = req->mq_hctx->driver_data;
+		bool kick;
+
+		if (!virtblk_prep_rq_batch(req)) {
+			rq_list_move(rqlist, &requeue_list, req, prev);
+			req = prev;
+			if (!req)
+				continue;
+		}
+
+		if (!next || req->mq_hctx != next->mq_hctx) {
+			req->rq_next = NULL;
+			kick = virtblk_add_req_batch(vq, rqlist, &requeue_list);
+			if (kick)
+				virtqueue_notify(vq->vq);
+
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
@@ -831,6 +912,7 @@ static int virtblk_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 
 static const struct blk_mq_ops virtio_mq_ops = {
 	.queue_rq	= virtio_queue_rq,
+	.queue_rqs	= virtio_queue_rqs,
 	.commit_rqs	= virtio_commit_rqs,
 	.init_hctx	= virtblk_init_hctx,
 	.complete	= virtblk_request_done,
-- 
2.26.3

