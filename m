Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76A17F373C
	for <lists+linux-block@lfdr.de>; Thu,  7 Nov 2019 19:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfKGS32 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 7 Nov 2019 13:29:28 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:39771 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfKGS32 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Nov 2019 13:29:28 -0500
Received: by mail-il1-f193.google.com with SMTP id a7so2302357ild.6
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2019 10:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fnApKBH47QIWo6OKAZ33mYWPD6FrkPgDTdpsV9Rrqxc=;
        b=zN9sdaHspwa+N+RzPkh3Qw2MEKS/SdmKz3S+H1OSRfU43Wfk3Yt6XmRngykipFzQIK
         t973EG2Vk+SSwlMD4C+eT1YUfPd3ZUXAoqkqP88ZY0zAYdgBdyL7tmb1R0MoUj/W3gW9
         1oTmKaaOUadsDACawQb9zaa4zUL1Rx9tfcoy9ADyNy2047aZ70XeMNOK1gaOp/7Sw7lh
         qLOQUv/xlDzQZbrwILzZTaRTX8PdqDVtafzpmpf+qrjWgWSrgrbc2dhnLc8Jm5x4n5p+
         4Qran5g243kO9fOTaux2HCnLb/ZGCAeukcYY1gKfH7iaiHJ7AY3lAYBzsb65+nC8XI4S
         e7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fnApKBH47QIWo6OKAZ33mYWPD6FrkPgDTdpsV9Rrqxc=;
        b=JoKiUpHz/12zLdafuZmqj8IVvmXBojEubCFzq8deyyqrPO28oQsxxnoXgQV+DNgWH2
         G8QrCv7RrX/jt+BNUnfOQUb29F3U+jQaR25vXMdHAJy6C20zDrPhVEkje5np6HvCF0dt
         Ja/1aSjRwg3YUqOCWdXKCQyItgfjWeViPiQb+r+E04Gv3VoHXQ8mxI31qoWiQMZr0tgS
         gRoHhhkTiS1wMiiERenmUkX/ZOGlk67C0zLgNn/Kz1JX59avVeNVUQAKxnkcwJbPadsn
         gAhsBgvjj5+dLGmD9AxFV+X1m7LhFQ+zJNPTJjtIbda3UwIN+0YqQrZ2qbQoNPR386Y3
         JIDw==
X-Gm-Message-State: APjAAAXGxCn72onb+97HUB+YB5MAjxZi6k+J1lRlx0mMwC+rqF4Ia2OC
        WxVNvQdNltN/fR0lY7iz1okQS7zaxW8=
X-Google-Smtp-Source: APXvYqyTJWavrcheLQUOqw5Zva98FWpIYPs6nkQN8jF1ELugw9yngqopAuYwjVtoGke/ZTwbUIlnzg==
X-Received: by 2002:a92:405a:: with SMTP id n87mr6518614ila.16.1573151367057;
        Thu, 07 Nov 2019 10:29:27 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p6sm243727iog.55.2019.11.07.10.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 10:29:25 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] io-wq: io_wqe_run_queue() doesn't need to use list_empty_careful()
Date:   Thu,  7 Nov 2019 11:29:18 -0700
Message-Id: <20191107182920.21196-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191107182920.21196-1-axboe@kernel.dk>
References: <20191107182920.21196-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We hold the wqe lock at this point (which is also annotated), so there's
no need to use the careful variant of list_empty().

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io-wq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index ba40a7ee31c3..9b375009a553 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -338,8 +338,7 @@ static void io_worker_handle_work(struct io_worker *worker)
 static inline bool io_wqe_run_queue(struct io_wqe *wqe)
 	__must_hold(wqe->lock)
 {
-	if (!list_empty_careful(&wqe->work_list) &&
-	    !(wqe->flags & IO_WQE_FLAG_STALLED))
+	if (!list_empty(&wqe->work_list) && !(wqe->flags & IO_WQE_FLAG_STALLED))
 		return true;
 	return false;
 }
-- 
2.24.0

