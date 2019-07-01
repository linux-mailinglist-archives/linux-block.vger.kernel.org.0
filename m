Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4AC521FCD
	for <lists+linux-block@lfdr.de>; Fri, 17 May 2019 23:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfEQVll (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 17 May 2019 17:41:41 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40531 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbfEQVlk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 May 2019 17:41:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id g69so3907784plb.7
        for <linux-block@vger.kernel.org>; Fri, 17 May 2019 14:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/jHW6cMkDx3mVPfEO6LslioW8HEfGg9KsHH7NblluP8=;
        b=C54D+ubtzGZYydcfOL7SEs8biFf9ApAqZiN0+FPzUtHDeqo8wEqU3ZdQJ2ExAfCnPJ
         6OrrAA/5GcP+HzuiLPOCXehXhvJdACpiF6bYJSspsDZ/iln3VnLPjkUdBjd08J0HR8TT
         dAF31ZUS2vkkL5/kkSiArcqAFMWXHnH+C2J2x+TMddQdl4BKpKeSGKLZIlLZlj5wYWRj
         X8VcHJeCWmZ08ytM6yaGmno1ETA2T6EWCC7UNYAeXDHCNomniSBfdwdjfELiIXxN92kR
         O+owbAjgkHNexzN5L/qjNP6zLMzHMsIye8fMwayevGwQkOL43y09bC7OQa76nhN3Jm91
         QivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/jHW6cMkDx3mVPfEO6LslioW8HEfGg9KsHH7NblluP8=;
        b=MlhJis1yCnHl3h514XPNZuFo69AARYwTKQQKcEf6Vc0Uib4u0abRAI6k1LpMffvTPA
         AataL5abdIKhsgKIH+NcUkA0g2d67w3S80wBkHSIwywSHXRnbiLKrGz74FD94vqhrpwS
         7U+HWDK7B9COaAM4j8277aXPwFWbNqgMox9oPnq0olAWBmK0ISsEiFULOGMMTdNr8uDv
         VJ9HLPlQ/7fXqzEdKDYKHZN6R6XlETOrDAj2eCquP6c92Z+P3YnWXDx22DmdPnUQMXQZ
         xqAsGdtdHmfyKAdkeTQWaZI4bMdLO0Lj0QIPTae0u7yVfzFdd2gqZiqxpCxKIamSZJh4
         c0Lw==
X-Gm-Message-State: APjAAAViHb1tGy6lCIiwwm+ARK5XYxjse48koF4wFE3vvq5PvkNoiN7/
        ncCX9y0GRhJZ0OO62RptTEfopQ==
X-Google-Smtp-Source: APXvYqw/pHAEwy6zewJqMf4CyQcBxIRh8CIf5P2ChqsBZmhu22V1LoceofI9tNeceNYWjfGURUUO8g==
X-Received: by 2002:a17:902:42a5:: with SMTP id h34mr37252464pld.178.1558129299912;
        Fri, 17 May 2019 14:41:39 -0700 (PDT)
Received: from x1.localdomain (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id z125sm15885331pfb.75.2019.05.17.14.41.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 14:41:39 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/3] io_uring: punt short reads to async context
Date:   Fri, 17 May 2019 15:41:30 -0600
Message-Id: <20190517214131.5925-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517214131.5925-1-axboe@kernel.dk>
References: <20190517214131.5925-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We can encounter a short read when we're doing buffered reads and the
data is partially cached. Right now we just return the short read, but
that forces the application to read that CQE, then issue another SQE
to finish the read. That read will not be cached, and hence will result
in an async punt.

It's more efficient to do that async punt from within the kernel, as
that will the not need two round trips more to the kernel.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 84cb31e69727..3e7f08094a85 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1089,7 +1089,7 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 	struct iov_iter iter;
 	struct file *file;
 	size_t iov_count;
-	ssize_t ret;
+	ssize_t read_size, ret;
 
 	ret = io_prep_rw(req, s, force_nonblock);
 	if (ret)
@@ -1105,13 +1105,24 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 	if (ret < 0)
 		return ret;
 
+	read_size = ret;
 	iov_count = iov_iter_count(&iter);
 	ret = rw_verify_area(READ, file, &kiocb->ki_pos, iov_count);
 	if (!ret) {
 		ssize_t ret2;
 
-		/* Catch -EAGAIN return for forced non-blocking submission */
 		ret2 = call_read_iter(file, kiocb, &iter);
+		/*
+		 * In case of a short read, punt to async. This can happen
+		 * if we have data partially cached. Alternatively we can
+		 * return the short read, in which case the application will
+		 * need to issue another SQE and wait for it. That SQE will
+		 * need async punt anyway, so it's more efficient to do it
+		 * here.
+		 */
+		if (force_nonblock && ret2 > 0 && ret2 < read_size)
+			ret2 = -EAGAIN;
+		/* Catch -EAGAIN return for forced non-blocking submission */
 		if (!force_nonblock || ret2 != -EAGAIN) {
 			io_rw_done(kiocb, ret2);
 		} else {
-- 
2.17.1

