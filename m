Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE7F475D6E
	for <lists+linux-block@lfdr.de>; Wed, 15 Dec 2021 17:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244820AbhLOQaO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Dec 2021 11:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244814AbhLOQaN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Dec 2021 11:30:13 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E31C061574
        for <linux-block@vger.kernel.org>; Wed, 15 Dec 2021 08:30:13 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id p65so31154063iof.3
        for <linux-block@vger.kernel.org>; Wed, 15 Dec 2021 08:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b7apqfi26aowPUwnOpzYHc1ZM0VpWPqRuNaIQ/bur6s=;
        b=M7fxNqT76tXtnlBF9BZ+hX0bQpwmKUUAYMyyhfSQuPH2vQx87Kk4wHbAwwQIwiVxaw
         bS6mo6SrIM9PzRP6J94eN8oBlRrScY5x1i3KdB4wfJhHgc9V1vZEzSN1WMOEgc0DUe8x
         q1WNRrnPaN9HI/s9cYVYlmd9BbTWrPRCudgAkVpsON3i2dUnkP2PSWFlaVA8CpmuBbuJ
         LSWVi4qM2Q+XfMp9vsz6mbF3eqB+4WW3pXnPomyUh8AB4rK1WR9qG432wA2msx3DK5+J
         WsUFoKqQV0QUzIIe3WkNGD79cLOhHfU8qfw9AZpFWNFmTu2uA1SGHFN9JKVmhN+1H5Su
         pIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b7apqfi26aowPUwnOpzYHc1ZM0VpWPqRuNaIQ/bur6s=;
        b=qjD9X/1A6EVaA/1XOrV7cf9YKJ4s+sZotgT7ZCpqg1EgRkuP/h9hA1X9bWY206X7Gp
         xkabzrdS4qldpE+vxFFR2TgVcNvCBPiLYYSkbdCjOOCpntAfn5gr1ngsj2j92uMnZ+/7
         7VOjB6y7h8n1b58uTqnJpAeFhv8Mgi7oO6cBRDEOuKDkUw3LxMIsslnq+laCKVzz4tX5
         aMdSg0LZCmPV8W2YqJOhAdtpC5N7Ds7keoO8VuVaeO4Vct34Ni5nejXHrqwnyQHK6f86
         k43orIJ/Dvpc1CEO1VYujl6p7yvpOuv+Y4gAnqKX9GVGpwLzgvSco+sf76Xw/z1wgdhk
         z2Vw==
X-Gm-Message-State: AOAM531nkUJ/NxMmxXXNGMzUyegguIYCwPNo/RM0IfTrZLJzx3l5xkz3
        J86MpvplV8rRvIDKECA0F0Oa1iAJ0hbpfQ==
X-Google-Smtp-Source: ABdhPJzECfbN3WUtuMm815oEq2LR3vcHNBbqikX5HpWMbeKbddSzGiHReUS5RkbHtkiWcmMDpgdVbw==
X-Received: by 2002:a05:6638:2720:: with SMTP id m32mr6313805jav.298.1639585812467;
        Wed, 15 Dec 2021 08:30:12 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d12sm1338528ilg.85.2021.12.15.08.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 08:30:11 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] block: add completion handler for fast path
Date:   Wed, 15 Dec 2021 09:30:07 -0700
Message-Id: <20211215163009.15269-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211215163009.15269-1-axboe@kernel.dk>
References: <20211215163009.15269-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The batched completions only deal with non-partial requests anyway,
and it doesn't deal with any requests that have errors. Add a completion
handler that assumes it's a full request and that it's all being ended
successfully.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f24394cb2004..efa9b93b4ddb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -709,6 +709,47 @@ static void blk_print_req_error(struct request *req, blk_status_t status)
 		IOPRIO_PRIO_CLASS(req->ioprio));
 }
 
+/*
+ * Fully end IO on a request. Does not support partial completions, or
+ * errors.
+ */
+static void blk_complete_request(struct request *req)
+{
+	const bool is_flush = (req->rq_flags & RQF_FLUSH_SEQ) != 0;
+	int total_bytes = blk_rq_bytes(req);
+	struct bio *bio = req->bio;
+
+	trace_block_rq_complete(req, BLK_STS_OK, total_bytes);
+
+	if (!bio)
+		return;
+
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ)
+		req->q->integrity.profile->complete_fn(req, total_bytes);
+#endif
+
+	blk_account_io_completion(req, total_bytes);
+
+	do {
+		struct bio *next = bio->bi_next;
+
+		/* Completion has already been traced */
+		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
+		if (!is_flush)
+			bio_endio(bio);
+		bio = next;
+	} while (bio);
+
+	/*
+	 * Reset counters so that the request stacking driver
+	 * can find how many bytes remain in the request
+	 * later.
+	 */
+	req->bio = NULL;
+	req->__data_len = 0;
+}
+
 /**
  * blk_update_request - Complete multiple bytes without completing the request
  * @req:      the request being processed
@@ -922,7 +963,7 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
 		prefetch(rq->bio);
 		prefetch(rq->rq_next);
 
-		blk_update_request(rq, BLK_STS_OK, blk_rq_bytes(rq));
+		blk_complete_request(rq);
 		if (iob->need_ts)
 			__blk_mq_end_request_acct(rq, now);
 
-- 
2.34.1

