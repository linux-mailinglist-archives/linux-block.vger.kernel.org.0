Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05C14F0D23
	for <lists+linux-block@lfdr.de>; Wed,  6 Nov 2019 04:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbfKFDjC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 5 Nov 2019 22:39:02 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:35948 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfKFDjC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Nov 2019 22:39:02 -0500
Received: by mail-qv1-f65.google.com with SMTP id f12so869778qvu.3
        for <linux-block@vger.kernel.org>; Tue, 05 Nov 2019 19:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=SjoP27lHR88FYKm4shB3004Uie/nn9CxC3Um/D8R2ec=;
        b=FHv1vBIUdaghEQEt5KhNdGEBHtttn/edORwuTHqby7FDLm/wVzsI5wbzRMl1rUt5lY
         zkzW2p1qXgFcecHPOmG6/6YkkJDd1BLXvoSPGNA0nnjnKAUphFiu+K/pH311Wv2OfZqH
         whQQN4tFxiRJVWSLz4L/UIiRxtUP/ka/7kNFsaR8RxAoAH7qcYSI0zYzxNuM7jYNp2Sn
         CFeh7yQSwg1LkE540Sb5TN5ZH/Pw+CmO/crWQuzHlAS2XPUNMhYLc574jXo72fUUUsfY
         CUoHMEPIQ4kCIZtDYIaYgz2Hg5sZjVxwKZSDd2pfHJfOlSMYb3G8m2T95tWYmsTAEOib
         KoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=SjoP27lHR88FYKm4shB3004Uie/nn9CxC3Um/D8R2ec=;
        b=Ba48DeMNk3X9hjB/HFwLYh5NFoqMquGV5ek0Nk1uFYkHZe5F20PJabG6EAwgQ8soxT
         UG8Cpj6jV4iTaEZIuEdymEl5RoDUOHlOEHBROWT/98cBReeTyMBCQfx1Bm+fSQ1msYm6
         ITX8f3AxDPvUejI4f8z87yyURI7cDcTudEB819SR4JlVMp9i3UxVCYHlKJ37hzpFylIx
         DVC8Q17J/IYjU60xkTtFpbgV7JrbRde7yZZx2D+Y3vj6OEKt+0xigwppf+xNFrAo1H3o
         DRTngzWP5AVwsNR7pc/yFqaaEDATHfncUnnivnTfmlJrA1qV+uAPBcQ8DIWWGgoPrCUV
         WKBw==
X-Gm-Message-State: APjAAAUeyxgygE78Qktfgc4ubPK6L1+1+OJ8b+3R4OxRhMXTHjnJCP5e
        VaU1XVeXwnu0/NG4ciMWzVfYTeiCFuk=
X-Google-Smtp-Source: APXvYqwMwIo5dMyod601KTfXGGjvrvVkOehYgj9sKQMWj0+tbUb776im45YSuhSV7di2oIaLyll1qg==
X-Received: by 2002:a63:a0f:: with SMTP id 15mr310909pgk.316.1573011167586;
        Tue, 05 Nov 2019 19:32:47 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id 74sm21923652pgb.62.2019.11.05.19.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 19:32:46 -0800 (PST)
To:     io-uring@vger.kernel.org
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: fixup a few spots where link failure isn't flagged
Message-ID: <b10f96d7-ecc4-e835-555e-739f22d3e505@kernel.dk>
Date:   Tue, 5 Nov 2019 20:32:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If a request fails, we need to ensure we set REQ_F_FAIL_LINK on it if
REQ_F_LINK is set. Any failure in the chain should break the chain.

We were missing a few spots where this should be done. It might be nice
to generalize this somewhat at some point, as long as we factor in the
fact that failure looks different for each request type.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

--


diff --git a/fs/io_uring.c b/fs/io_uring.c
index bda27b52fd5b..4edc94aab17e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1672,6 +1672,8 @@ static int io_send_recvmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	}
 
 	io_cqring_add_event(req->ctx, sqe->user_data, ret);
+	if (ret < 0 && (req->flags & REQ_F_LINK))
+		req->flags |= REQ_F_FAIL_LINK;
 	io_put_req(req, nxt);
 	return 0;
 }
@@ -1787,6 +1789,8 @@ static int io_poll_remove(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	spin_unlock_irq(&ctx->completion_lock);
 
 	io_cqring_add_event(req->ctx, sqe->user_data, ret);
+	if (ret < 0 && (req->flags & REQ_F_LINK))
+		req->flags |= REQ_F_FAIL_LINK;
 	io_put_req(req, NULL);
 	return 0;
 }
@@ -1994,6 +1998,8 @@ static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
 	io_cqring_ev_posted(ctx);
+	if (req->flags & REQ_F_LINK)
+		req->flags |= REQ_F_FAIL_LINK;
 	io_put_req(req, NULL);
 	return HRTIMER_NORESTART;
 }
@@ -2035,6 +2041,8 @@ static int io_timeout_remove(struct io_kiocb *req,
 		io_commit_cqring(ctx);
 		spin_unlock_irq(&ctx->completion_lock);
 		io_cqring_ev_posted(ctx);
+		if (req->flags & REQ_F_LINK)
+			req->flags |= REQ_F_FAIL_LINK;
 		io_put_req(req, NULL);
 		return 0;
 	}
@@ -2328,6 +2336,8 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
 	io_put_req(req, NULL);
 
 	if (ret) {
+		if (req->flags & REQ_F_LINK)
+			req->flags |= REQ_F_FAIL_LINK;
 		io_cqring_add_event(ctx, sqe->user_data, ret);
 		io_put_req(req, NULL);
 	}

-- 
Jens Axboe

