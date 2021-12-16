Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A257647795F
	for <lists+linux-block@lfdr.de>; Thu, 16 Dec 2021 17:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbhLPQjH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 16 Dec 2021 11:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbhLPQjH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Dec 2021 11:39:07 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44005C061574
        for <linux-block@vger.kernel.org>; Thu, 16 Dec 2021 08:39:07 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id z26so35864942iod.10
        for <linux-block@vger.kernel.org>; Thu, 16 Dec 2021 08:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xEIyIeQItOxJNAK+GZxR0AU9fLDjbQGibSW3G09wzOM=;
        b=zRA+kbRsHGd+7od2RWLlx3FvBE1xCRl1+3C5MhHDQ+HqHJNy0xJHOFBUOHy1+O/22d
         8LJAxe/jM0DL4lXc3HETGaIjv17lonI5G2vIzdR5O6DOKsu0v9qPob2Nds760/l/SCVl
         3YtccMlZD0Etp5r1+mQtN6VkR+2CZPl7qIw5jLJUIDxb3fSO0QHV1u9Dklaa7vcf8Qmf
         msFaBGJtzHIa0MmvRLZvUJx2ZRI9Qf1xFyoXZU/5DHjXHb39VdfOZ+uQfpXHv/jQs2QD
         YomC17TZGd3Cg2BBGj/dvIoBgUCqOcGHq80iBjaz2DlIwzdnRFL7KJO6UHrw8EJoOgW6
         wbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xEIyIeQItOxJNAK+GZxR0AU9fLDjbQGibSW3G09wzOM=;
        b=PZ2xEhE5XoU69L3lundGEhqVyaA2tL1E8gNPd5LnMk6QlJbKG0M4tiX0aG2vnYpOmw
         Pxg7T/TqSlr+sCHgR2ZWVkGev1V7pl5xCxDpT5fnkpb4VG769bMh49WbyfsVo8mcQwNz
         7ITXMhh+emsCZECESdTtYsKYqyuLTI1c6nM/nHmyno0oKqqh595LOrYUJW4oy7fSUPVV
         w0vWu169An9HflwO4rBeRJvLVv/aavZ9DD4O4L2746bsJ2iab4nM7kIEj39VraZSLHAu
         gHxLapWv0HJt/ixAh/Ak2E/QCV1BMRBetU07XYJ0cMmFlm79MnQeMMkQiF0wqskklRIv
         mI6g==
X-Gm-Message-State: AOAM531l66DtOHryPZ9uWK6e5KekNfhDGbl3TQB5s7xGfBH1QQ8pQ8o4
        8aEa4dlxtHA9kqzDOayb6SnMzw==
X-Google-Smtp-Source: ABdhPJwab3tMpsiybMjm9sus1v4EzqXqt6Hcyi92T+FXmNaQbb7mkeQlqpuplIBRFp6xzC+i0g+knw==
X-Received: by 2002:a05:6638:1923:: with SMTP id p35mr10202987jal.16.1639672746662;
        Thu, 16 Dec 2021 08:39:06 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t17sm71816ilm.46.2021.12.16.08.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 08:39:06 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
Date:   Thu, 16 Dec 2021 09:39:01 -0700
Message-Id: <20211216163901.81845-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216163901.81845-1-axboe@kernel.dk>
References: <20211216163901.81845-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This enables the block layer to send us a full plug list of requests
that need submitting. The block layer guarantees that they all belong
to the same queue, but we do have to check the hardware queue mapping
for each request.

If errors are encountered, leave them in the passed in list. Then the
block layer will handle them individually.

This is good for about a 4% improvement in peak performance, taking us
from 9.6M to 10M IOPS/core.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/pci.c | 59 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7062128c8204..51a903d91d92 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -969,6 +969,64 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
+static void nvme_submit_cmds(struct nvme_queue *nvmeq, struct request **rqlist)
+{
+	spin_lock(&nvmeq->sq_lock);
+	while (!rq_list_empty(*rqlist)) {
+		struct request *req = rq_list_pop(rqlist);
+		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+
+		nvme_sq_copy_cmd(nvmeq, &iod->cmd);
+	}
+	nvme_write_sq_db(nvmeq, true);
+	spin_unlock(&nvmeq->sq_lock);
+}
+
+static bool nvme_prep_rq_batch(struct nvme_queue *nvmeq, struct request *req)
+{
+	/*
+	 * We should not need to do this, but we're still using this to
+	 * ensure we can drain requests on a dying queue.
+	 */
+	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
+		return false;
+	if (unlikely(!nvme_check_ready(&nvmeq->dev->ctrl, req, true)))
+		return false;
+
+	req->mq_hctx->tags->rqs[req->tag] = req;
+	return nvme_prep_rq(nvmeq->dev, req) == BLK_STS_OK;
+}
+
+static void nvme_queue_rqs(struct request **rqlist)
+{
+	struct request *req = rq_list_peek(rqlist), *prev = NULL;
+	struct request *requeue_list = NULL;
+
+	do {
+		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+
+		if (!nvme_prep_rq_batch(nvmeq, req)) {
+			/* detach 'req' and add to remainder list */
+			if (prev)
+				prev->rq_next = req->rq_next;
+			rq_list_add(&requeue_list, req);
+		} else {
+			prev = req;
+		}
+
+		req = rq_list_next(req);
+		if (!req || (prev && req->mq_hctx != prev->mq_hctx)) {
+			/* detach rest of list, and submit */
+			if (prev)
+				prev->rq_next = NULL;
+			nvme_submit_cmds(nvmeq, rqlist);
+			*rqlist = req;
+		}
+	} while (req);
+
+	*rqlist = requeue_list;
+}
+
 static __always_inline void nvme_pci_unmap_rq(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -1670,6 +1728,7 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
 
 static const struct blk_mq_ops nvme_mq_ops = {
 	.queue_rq	= nvme_queue_rq,
+	.queue_rqs	= nvme_queue_rqs,
 	.complete	= nvme_pci_complete_rq,
 	.commit_rqs	= nvme_commit_rqs,
 	.init_hctx	= nvme_init_hctx,
-- 
2.34.1

