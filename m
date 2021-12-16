Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0DD47773C
	for <lists+linux-block@lfdr.de>; Thu, 16 Dec 2021 17:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbhLPQLD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 16 Dec 2021 11:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239086AbhLPQLB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Dec 2021 11:11:01 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3973C06173F
        for <linux-block@vger.kernel.org>; Thu, 16 Dec 2021 08:11:01 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id p23so35834747iod.7
        for <linux-block@vger.kernel.org>; Thu, 16 Dec 2021 08:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pf9fb3BzOHZeasMBnE2TZjTYGuhuTLpt0IzZchAOoCI=;
        b=NQwSmOIKRYtCZ8O7JeCgLi0TwGt6NJBkzli3xzYCC5hRJyGz+pXE0z4kPWP8dK2s8K
         CThR58m6+8l47kQcItx8B/u5vuGliCy1XJHLA0LeHIxkdpzTFo9RYo3zzhc0BwZpboyH
         VT5KIfY6etuxkW5JKNfQRkql/fawtfZUE15S8wUZwWx24qCDc5Xmhkf22vPl9EMxcwHP
         5d+i8zdAsRogqDbcFXzuatpCbDabWAW+D5mpeQr0rAeZiUA45r36+6gt9Yp0eundGRjD
         zSELaljHEoVnrB0BtOlHiPB/uV3hAd0mSqM8i4nfKkHK193AwSEXjk1JReNmRO815ZO5
         zqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pf9fb3BzOHZeasMBnE2TZjTYGuhuTLpt0IzZchAOoCI=;
        b=G2F3QjQjqA/Sn36c/jF4dThFAlF3G6B3oLrUbo6n3CQ7DiT4pO3Y+MQDYyzXbBbvLT
         ailGfbS0ZB72OEwa12y21712tRQPtBCFwUvpaO1qhjFKA/xFPpD30JPZwmtGxQRQpqQm
         ujZ7grCOZSw1V0IrSUQ/ajZWHRtaZqe5AqP2TbTHuIEGnPnlQ/TrGwunoWwzQpcblvwp
         xfRTdzV5UIpAAcUggUGpf4eak15RE2G90IjyJhix2dbqO9EAY4894RN7jDH/yF41VSqV
         odO53mNOh4fdbrMeVt343u3TmiuEqvsAm7Kpd7p1lKQVfdh6ygVWvW9H3RcZx43G5LIY
         i69Q==
X-Gm-Message-State: AOAM533F28z/5YL0m8tw6ecAcfhoeV9xHG+9dQaFFaHjtkOr5IQ4Ynso
        j8EwiKn5qGFDjYkwcMU8fTc+Lg==
X-Google-Smtp-Source: ABdhPJxrCl8DAdI5vuBFBvDjOLDjTPwNTli9HWjp3v8EKYMdhUi4Z8uByjZ/rJmfHoPwXonA3F8HOg==
X-Received: by 2002:a5e:8a41:: with SMTP id o1mr9801431iom.131.1639671061064;
        Thu, 16 Dec 2021 08:11:01 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id q8sm3228064iow.47.2021.12.16.08.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 08:11:00 -0800 (PST)
Subject: [PATCH v2 4/4] nvme: add support for mq_ops->queue_rqs()
To:     io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc:     Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
References: <20211216160537.73236-1-axboe@kernel.dk>
 <20211216160537.73236-5-axboe@kernel.dk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <37e91ddf-6658-e587-7895-edc1c9b2e83b@kernel.dk>
Date:   Thu, 16 Dec 2021 09:11:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211216160537.73236-5-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Added the prev check suggested by Max.

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6be6b1ab4285..58d97660374a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -981,6 +981,64 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
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
@@ -1678,6 +1736,7 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
 
 static const struct blk_mq_ops nvme_mq_ops = {
 	.queue_rq	= nvme_queue_rq,
+	.queue_rqs	= nvme_queue_rqs,
 	.complete	= nvme_pci_complete_rq,
 	.commit_rqs	= nvme_commit_rqs,
 	.init_hctx	= nvme_init_hctx,

-- 
Jens Axboe

