Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77E55EB70A
	for <lists+linux-block@lfdr.de>; Tue, 27 Sep 2022 03:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiI0Bo0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 26 Sep 2022 21:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiI0BoZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Sep 2022 21:44:25 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4331FA6C2D
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 18:44:24 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w20so7777112ply.12
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 18:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KOdha0xZ2/QYkK5YkfhyDv4n+7NP1qIjesr4vuNTao8=;
        b=IZ47anjuWzzeW6tFN95y9yhaayVusdQv6KbEijleZbt5Iw+sz8JmacG50WtnEERZ+T
         ukyS5F4ahFzGOZK+L3qTcdJexGtnST2bu8ZaKa9WT/utuzrcw2o4cFJtsy8euWpKfEnx
         rvXyTqA4TZKRalJzpTIHilAYUmbH08J08UcL9DEgRm38E9mVgaInmLOetIV5qET5M320
         GfRVwa+ng63clk9+PkTDvTFIobCDuQXpIlTz2yxPbQHKwvG5PpO89F9AjtZ24/VgOIho
         tiyCKV7/xq7YI0KwHz3GIYPrUcj0KkG5fgwsHcUPzP5uFBbmQmk0DNOd+Hp8+2Av5AKp
         fvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KOdha0xZ2/QYkK5YkfhyDv4n+7NP1qIjesr4vuNTao8=;
        b=XrZf/14Pv38et/ObtiPbQmfQZvYUJ8c6pgXdaDPTjXRnlgcJHq8eevjoWnTvo4EU75
         uMOdoqsqDEA52JiQKmC/4lazZHgEKugx78x1pOqL146iX9BMvDiNpQFnm5aZBHG5u/dD
         neSW2DyE9gaT16K2bO5vgKUoR/0Bt1T1crnC8xGV5sy5jSnd7HJDWWiA9mbaFYos5Izb
         c8PMHAmud43vk66iEP2u+iAPwP2NZjXZFjBfL2NPx+fXFusLQI4X0Bxxn4OoslB2NSYu
         X8rKu+sacVD0RaXy1rf3Wki2gCATTB+QGed6xkqlD00AVqOETNQFnnM6XZevYBdcATzJ
         /E4g==
X-Gm-Message-State: ACrzQf0tNR+VNURHSyRiBcLRL/o5PEztrTRPbO812E94wjrFXbJTRy5e
        1sEcvSqy3IUP6rvyA+hGJ9pTaq/RpVkO6w==
X-Google-Smtp-Source: AMsMyM4q9iQ/NKVm6hjlVj+kedzuR0z7pDReUN/KpszmAjSVIxz1HZxq3fyW05GGm8DEzlY8kHoU6w==
X-Received: by 2002:a17:90b:180a:b0:202:ae1f:328a with SMTP id lw10-20020a17090b180a00b00202ae1f328amr1816502pjb.78.1664243063538;
        Mon, 26 Sep 2022 18:44:23 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id o2-20020aa79782000000b00537d60286c9sm183062pfp.113.2022.09.26.18.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 18:44:23 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/5] block: enable batched allocation for blk_mq_alloc_request()
Date:   Mon, 26 Sep 2022 19:44:16 -0600
Message-Id: <20220927014420.71141-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927014420.71141-1-axboe@kernel.dk>
References: <20220927014420.71141-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The filesystem IO path can take advantage of allocating batches of
requests, if the underlying submitter tells the block layer about it
through the blk_plug. For passthrough IO, the exported API is the
blk_mq_alloc_request() helper, and that one does not allow for
request caching.

Wire up request caching for blk_mq_alloc_request(), which is generally
done without having a bio available upfront.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 80 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 71 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c11949d66163..d3a9f8b9c7ee 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -510,25 +510,87 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 					alloc_time_ns);
 }
 
-struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
-		blk_mq_req_flags_t flags)
+static struct request *blk_mq_rq_cache_fill(struct request_queue *q,
+					    struct blk_plug *plug,
+					    blk_opf_t opf,
+					    blk_mq_req_flags_t flags)
 {
 	struct blk_mq_alloc_data data = {
 		.q		= q,
 		.flags		= flags,
 		.cmd_flags	= opf,
-		.nr_tags	= 1,
+		.nr_tags	= plug->nr_ios,
+		.cached_rq	= &plug->cached_rq,
 	};
 	struct request *rq;
-	int ret;
 
-	ret = blk_queue_enter(q, flags);
-	if (ret)
-		return ERR_PTR(ret);
+	if (blk_queue_enter(q, flags))
+		return NULL;
+
+	plug->nr_ios = 1;
 
 	rq = __blk_mq_alloc_requests(&data);
-	if (!rq)
-		goto out_queue_exit;
+	if (unlikely(!rq))
+		blk_queue_exit(q);
+	return rq;
+}
+
+static struct request *blk_mq_alloc_cached_request(struct request_queue *q,
+						   blk_opf_t opf,
+						   blk_mq_req_flags_t flags)
+{
+	struct blk_plug *plug = current->plug;
+	struct request *rq;
+
+	if (!plug)
+		return NULL;
+	if (rq_list_empty(plug->cached_rq)) {
+		if (plug->nr_ios == 1)
+			return NULL;
+		rq = blk_mq_rq_cache_fill(q, plug, opf, flags);
+		if (rq)
+			goto got_it;
+		return NULL;
+	}
+	rq = rq_list_peek(&plug->cached_rq);
+	if (!rq || rq->q != q)
+		return NULL;
+
+	if (blk_mq_get_hctx_type(opf) != rq->mq_hctx->type)
+		return NULL;
+	if (op_is_flush(rq->cmd_flags) != op_is_flush(opf))
+		return NULL;
+
+	plug->cached_rq = rq_list_next(rq);
+got_it:
+	rq->cmd_flags = opf;
+	INIT_LIST_HEAD(&rq->queuelist);
+	return rq;
+}
+
+struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
+		blk_mq_req_flags_t flags)
+{
+	struct request *rq;
+
+	rq = blk_mq_alloc_cached_request(q, opf, flags);
+	if (!rq) {
+		struct blk_mq_alloc_data data = {
+			.q		= q,
+			.flags		= flags,
+			.cmd_flags	= opf,
+			.nr_tags	= 1,
+		};
+		int ret;
+
+		ret = blk_queue_enter(q, flags);
+		if (ret)
+			return ERR_PTR(ret);
+
+		rq = __blk_mq_alloc_requests(&data);
+		if (!rq)
+			goto out_queue_exit;
+	}
 	rq->__data_len = 0;
 	rq->__sector = (sector_t) -1;
 	rq->bio = rq->biotail = NULL;
-- 
2.35.1

