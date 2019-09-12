Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32A82B1296
	for <lists+linux-block@lfdr.de>; Thu, 12 Sep 2019 18:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733118AbfILQJA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Sep 2019 12:09:00 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:38940 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729752AbfILQJA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Sep 2019 12:09:00 -0400
Received: by mail-io1-f45.google.com with SMTP id d25so56076141iob.6
        for <linux-block@vger.kernel.org>; Thu, 12 Sep 2019 09:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=h+09MmTlP3NJ1y6KzMIsEfhCEi38wNlW51tE+ppPvTM=;
        b=xyIFLQhcUVspBDpcmka6wDLVFJcE56T0zqaNh1v9WBBaY3FL9Mj8mdevC1WmcOtJRZ
         i2qCrU0AvnEm4Lohv3OaE/y30k3hR+X6xAfDO8NBNHEc6Mqvj9YbbFPqz7BZtE1E3DF0
         PqmZebGwRsRjkfoA1WLJExLcMEBFJBjoIPGbG70PxBayJch/kjEFVJqxieWeyuXnOj6L
         7JIoMDpTdaBz//KJ0WhrorfLi9wGnmuKnnidmKcn7IoJUc/7BbaR4N/PDP7ivDLcsl2J
         7tSTVC4d1VjhlyWvu6mG4XIKNX05K0cHWypA1SIc5mjcEuTOe34ygJCvkPlwF5It5mf3
         MMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=h+09MmTlP3NJ1y6KzMIsEfhCEi38wNlW51tE+ppPvTM=;
        b=RtTMt4g5Ridurt82BPQsCPau13Xw8ubfTyoL5vTCC+MbhNyRJ8a/xe5LgckqMdPnUa
         FyWgei+7atPfLDlKHUqLdL1bT9FHzvior37RjulUVO5FoceFrW/rWcg2PMaBdvYRqoPW
         HBt8DecewXUtcC016gxwFQpJltM+zKv2yZqI+PxDfbg3+Bdhk82n4fRSJ6iJXzLqT96m
         nadS3yB8PmMAj1p5w9fdRQm+QqSnT5JyKaZa3oS4tatfTsSuVzAOKC5siMHUinTHhcF8
         OkLHBaJq75wIJkQH8Rdizn4Zhn3tBnSxpXPiUHzswMQqbaxtn8zHgGizS8YrtNi5jGfZ
         rnIQ==
X-Gm-Message-State: APjAAAU8Dg2J12q7atuqAsGuWgjxaOiv/X0o4MsUmtgHrVKVpnjIjNS9
        M/572NCfm2eGMnGFns8lTuVEWw==
X-Google-Smtp-Source: APXvYqxvtc1xy3EKvMmQ8THPNgHYa101Uj3xrdkZSiv7TRF6l9zquCKUlKNtikeTcIefgnYDPVMoFw==
X-Received: by 2002:a5d:8890:: with SMTP id d16mr5139152ioo.126.1568304537840;
        Thu, 12 Sep 2019 09:08:57 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g4sm70650501iof.56.2019.09.12.09.08.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 09:08:56 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Lewis Baker <lbaker@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: make sqpoll wakeup possible with getevents
Message-ID: <c9084c96-1771-6b7e-affb-2ac2e09e827d@kernel.dk>
Date:   Thu, 12 Sep 2019 10:08:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The way the logic is setup in io_uring_enter() means that you can't wake
up the SQ poller thread while at the same time waiting (or polling) for
completions afterwards. There's no reason for that to be the case.

Reported-by: Lewis Baker <lbaker@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

--

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 4bc3ee4ea81f..3c8859d417eb 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3356,15 +3356,12 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 	 * Just return the requested submit count, and wake the thread if
 	 * we were asked to.
 	 */
+	ret = 0;
 	if (ctx->flags & IORING_SETUP_SQPOLL) {
 		if (flags & IORING_ENTER_SQ_WAKEUP)
 			wake_up(&ctx->sqo_wait);
 		submitted = to_submit;
-		goto out_ctx;
-	}
-
-	ret = 0;
-	if (to_submit) {
+	} else if (to_submit) {
 		bool block_for_last = false;
 
 		to_submit = min(to_submit, ctx->sq_entries);
@@ -3394,7 +3391,6 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 		}
 	}
 
-out_ctx:
 	io_ring_drop_ctx_refs(ctx, 1);
 out_fput:
 	fdput(f);

-- 
Jens Axboe

