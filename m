Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5A0BF1F21
	for <lists+linux-block@lfdr.de>; Wed,  6 Nov 2019 20:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfKFTkr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 6 Nov 2019 14:40:47 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:36470 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbfKFTkq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Nov 2019 14:40:46 -0500
Received: by mail-il1-f194.google.com with SMTP id s75so22873874ilc.3
        for <linux-block@vger.kernel.org>; Wed, 06 Nov 2019 11:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RpXSGKQxRQoGOXn6wQCl4ajg6gRDD0w1jwQM/eWxsW4=;
        b=Hb+bY0l8j5NYpY6DvqttZ/wltt/ZyvzDmt3I/XuBnEXRvRdwowQxhSyOWBxRVgVTjO
         dtEbV78dWZT/mTe9H5AiAcgyD0r4BOLGGjIuNvvLpZTqu/QnX38Eqf7HwfWaPvstcdjx
         pAJoRs1ah0P0gawjygeZDrkG/iARSAePSiJlUJlw0QJmwsKsLezc+bCjHb37ZDfoOxeQ
         T/xQT8aBWfS8E/BfkV/iMLL64YLatPB1NgcgjoYVz6lh52KJ/fJZ2kgpfyfGQgdf+QEI
         T/YQrY/hrNo9GYLNPLf4QNmf9hyLMrPUmwC79fLGJLVVsn92+e1IBPiGocEg+qehSrFo
         zHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RpXSGKQxRQoGOXn6wQCl4ajg6gRDD0w1jwQM/eWxsW4=;
        b=GhUWyZM+eXoELpZKfovQYvj+G9DQgyKHHxQVfteFitqXuvsY6dXBhFs2oqPaKjy8J6
         ClC3sIz6EAH+Mrc7U55Sjxe0JYFkhYeAGqcxH3LxycDbvWcQ1CRK0VYmIh/vXtroIK6R
         JyeH3yAmB8tbcJBhHoiSGbwat6CMnU5eVMPeowWK/w0mocrnPvSTo/ULlKFIxkAfmypU
         h9/VvennNhQRZeVfv+hZ6uViK9jJMy+CJDRH9pOpHVNJUWcUaVeWsEQvb8YkcW7wb5sj
         iQG7DnY8YN15uF4ql/ZnAl8G12RzboUdKO8nPkqg0fUZ63TpQQQb+Yv3lmx1EONH6vzk
         NYqQ==
X-Gm-Message-State: APjAAAVuXTsvJJOvCY++KCjpcK7Llrp4/wdmNMuhKuH7+vpIXymi89fI
        5nFom8yEBVuLdRR6QGWrGBK32BhhtDA=
X-Google-Smtp-Source: APXvYqwVvpb8EJlpCAfjgjJ0PkA6s9MYAo5ZN/Wolxw+beiLk1ejzU3AyZLEsVJbzlQqy/x+FAT3hg==
X-Received: by 2002:a92:5cdd:: with SMTP id d90mr5002115ilg.48.1573069245978;
        Wed, 06 Nov 2019 11:40:45 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k22sm911298iot.34.2019.11.06.11.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 11:40:44 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] io-wq: pass in io_wq to work handler
Date:   Wed,  6 Nov 2019 12:40:39 -0700
Message-Id: <20191106194040.26723-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191106194040.26723-1-axboe@kernel.dk>
References: <20191106194040.26723-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is the io_wq that the work is executing on. No functional changes
in this patch, we'll need this in a future patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io-wq.c    | 8 ++++----
 fs/io-wq.h    | 2 +-
 fs/io_uring.c | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index ba40a7ee31c3..4ebbdd068ebf 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -318,7 +318,7 @@ static void io_worker_handle_work(struct io_worker *worker)
 			work->flags |= IO_WQ_WORK_HAS_MM;
 
 		old_work = work;
-		work->func(&work);
+		work->func(wq, &work);
 
 		spin_lock_irq(&wqe->lock);
 		worker->cur_work = NULL;
@@ -685,7 +685,7 @@ static enum io_wq_cancel io_wqe_cancel_cb_work(struct io_wqe *wqe,
 
 	if (found) {
 		work->flags |= IO_WQ_WORK_CANCEL;
-		work->func(&work);
+		work->func(wqe->wq, &work);
 		return IO_WQ_CANCEL_OK;
 	}
 
@@ -757,7 +757,7 @@ static enum io_wq_cancel io_wqe_cancel_work(struct io_wqe *wqe,
 
 	if (found) {
 		work->flags |= IO_WQ_WORK_CANCEL;
-		work->func(&work);
+		work->func(wqe->wq, &work);
 		return IO_WQ_CANCEL_OK;
 	}
 
@@ -801,7 +801,7 @@ struct io_wq_flush_data {
 	struct completion done;
 };
 
-static void io_wq_flush_func(struct io_wq_work **workptr)
+static void io_wq_flush_func(struct io_wq *wq, struct io_wq_work **workptr)
 {
 	struct io_wq_work *work = *workptr;
 	struct io_wq_flush_data *data;
diff --git a/fs/io-wq.h b/fs/io-wq.h
index 3de192dc73fc..9fe8c97bcbd2 100644
--- a/fs/io-wq.h
+++ b/fs/io-wq.h
@@ -21,7 +21,7 @@ enum io_wq_cancel {
 
 struct io_wq_work {
 	struct list_head list;
-	void (*func)(struct io_wq_work **);
+	void (*func)(struct io_wq *, struct io_wq_work **);
 	unsigned flags;
 	struct files_struct *files;
 };
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6c13411896b5..ad452be9f3bc 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -369,7 +369,7 @@ struct io_submit_state {
 	unsigned int		ios_left;
 };
 
-static void io_wq_submit_work(struct io_wq_work **workptr);
+static void io_wq_submit_work(struct io_wq *wq, struct io_wq_work **workptr);
 static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
 				 long res);
 static void __io_free_req(struct io_kiocb *req);
@@ -1930,7 +1930,7 @@ static void io_poll_complete(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	io_commit_cqring(ctx);
 }
 
-static void io_poll_complete_work(struct io_wq_work **workptr)
+static void io_poll_complete_work(struct io_wq *wq, struct io_wq_work **workptr)
 {
 	struct io_wq_work *work = *workptr;
 	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
@@ -2436,7 +2436,7 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	return 0;
 }
 
-static void io_wq_submit_work(struct io_wq_work **workptr)
+static void io_wq_submit_work(struct io_wq *wq, struct io_wq_work **workptr)
 {
 	struct io_wq_work *work = *workptr;
 	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
-- 
2.24.0

