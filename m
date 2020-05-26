Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6147C1A26B8
	for <lists+linux-block@lfdr.de>; Wed,  8 Apr 2020 18:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbgDHQH1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 8 Apr 2020 12:07:27 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:44505 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbgDHQH1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Apr 2020 12:07:27 -0400
Received: by mail-oi1-f179.google.com with SMTP id r21so415775oij.11
        for <linux-block@vger.kernel.org>; Wed, 08 Apr 2020 09:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=99bGb9kPLJIKPGAYnWeUQM+upQBOmhTKAuXfLDA02as=;
        b=aL8VsGjuULtKfOLQ4xJAOYPOZmY0Fm4LmPDtmN2EaK+l6PCc9odZkH+cahGM56TX7V
         RRRVicea4VeZOdbhSkDKFRCH58KpGUJ7CNOXzRWeuJNXr7aH2Mg1BkRpLSkVcDhAuWap
         3QS1w5M7oxl5CLQ+/jYNLGia4XietUIz9CYHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=99bGb9kPLJIKPGAYnWeUQM+upQBOmhTKAuXfLDA02as=;
        b=G46mwDjAYiaJWSOVxCyi3g3nCU2kzzs/IgSzV9ogxgEjw65r0X5FkBcqP7H5HihSz1
         2s/Mj9+iVzYFBT5zmaLEU/PcWrTpEblNgNK4SVVgkDSbHY1i2KIMU3ry/K96EaiMO6n4
         aQXCVPvY/aORwYGC4Q8zM5NfqFzfo91OEkV+s78ZWO0g353Rn5Y0ofOZ5xfSVB///4lk
         4+6Wva2ImLExqhHhsOxn6ePFIMsOQp0e5KajtYOfUtm6YJmzSP0piSYQ9N0DYzVkS3K2
         ZaGUlIPpXeYyj2DzPkBhubc3ai1LELjRWfbhQLxQrRQq3XtIcWSFglq2nNC73Q2or+48
         K6iQ==
X-Gm-Message-State: AGi0PuZU/+wZ+UxzFoSduwj7r/6/4S0lXJkvvCb3Lo5elcqSAymbLp/E
        DEEvgf75QUkHFdadgeXSQnLRAIhg3FDgNg==
X-Google-Smtp-Source: APiQypLwTROlMgk5kYCTxCFF56//DDLXDI3u7/I38vnrWOWWHtwiZKkjylcUiWynghi29M6bg7W1mQ==
X-Received: by 2002:a17:90a:178e:: with SMTP id q14mr208304pja.132.1586358273435;
        Wed, 08 Apr 2020 08:04:33 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id d85sm1468083pfd.157.2020.04.08.08.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 08:04:32 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     paolo.valente@linaro.org, groeck@chromium.org,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, sqazi@google.com,
        Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        John Garry <john.garry@huawei.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] blk-mq: Add blk_mq_delay_run_hw_queues() API call
Date:   Wed,  8 Apr 2020 08:04:00 -0700
Message-Id: <20200408080255.v4.2.I4c665d70212a5b33e103fec4d5019a59b4c05577@changeid>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
In-Reply-To: <20200408150402.21208-1-dianders@chromium.org>
References: <20200408150402.21208-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We have:
* blk_mq_run_hw_queue()
* blk_mq_delay_run_hw_queue()
* blk_mq_run_hw_queues()

...but not blk_mq_delay_run_hw_queues(), presumably because nobody
needed it before now.  Since we need it for a later patch in this
series, add it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4: None
Changes in v3:
- ("blk-mq: Add blk_mq_delay_run_hw_queues() API call") new for v3

Changes in v2: None

 block/blk-mq.c         | 19 +++++++++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2cd8d2b49ff4..ea0cd970a3ff 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1537,6 +1537,25 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async)
 }
 EXPORT_SYMBOL(blk_mq_run_hw_queues);
 
+/**
+ * blk_mq_delay_run_hw_queues - Run all hardware queues asynchronously.
+ * @q: Pointer to the request queue to run.
+ * @msecs: Microseconds of delay to wait before running the queues.
+ */
+void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs)
+{
+	struct blk_mq_hw_ctx *hctx;
+	int i;
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		if (blk_mq_hctx_stopped(hctx))
+			continue;
+
+		blk_mq_delay_run_hw_queue(hctx, msecs);
+	}
+}
+EXPORT_SYMBOL(blk_mq_delay_run_hw_queues);
+
 /**
  * blk_mq_queue_stopped() - check whether one or more hctxs have been stopped
  * @q: request queue.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 11cfd6470b1a..405f8c196517 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -503,6 +503,7 @@ void blk_mq_unquiesce_queue(struct request_queue *q);
 void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
 void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_run_hw_queues(struct request_queue *q, bool async);
+void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs);
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv);
 void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset);
-- 
2.26.0.292.g33ef6b2f38-goog

