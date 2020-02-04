Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 429F815213C
	for <lists+linux-block@lfdr.de>; Tue,  4 Feb 2020 20:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgBDThQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 4 Feb 2020 14:37:16 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:38346 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgBDThQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Feb 2020 14:37:16 -0500
Received: by mail-vk1-f202.google.com with SMTP id h197so6237197vka.5
        for <linux-block@vger.kernel.org>; Tue, 04 Feb 2020 11:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bOYykdGyEwLVePDzOkgL79k9V9HNutxercPdQBvYEZo=;
        b=WCXOdwFBOV7WwP9es+bVVn5HvO3QP22jf7symCGYwMS4Sp9u0zhxgUkFk9qJEw4OS5
         VnLPfRuK0QM30SywQiZS0JOjnIKg7dPsB2Er5SEw+qnP697/xol5eVrZk2xZYC7inZq2
         A9/z6fnSE2S9meQxw5N6my263ukaH4+lsy5u/otGczNaoPwQk4CilolFvt2ZvKViwnNU
         yLOpnZyIAmGmsOEhbC06KpiYUqrrLtud5RSOcOR5TG9GyT6QJ0WRnrAknRSDSeLq+oIc
         JKucULGK4Jmc8uXjn+3td9SX3R6GEKZr9LtRJs8V82Z+3HYhdAesGXYS2e72RsX/rjaI
         fAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bOYykdGyEwLVePDzOkgL79k9V9HNutxercPdQBvYEZo=;
        b=IX/vSGj85EKh8vNqfLHk4cMESJnUsd9uedYIOaUOpG9/+07bA+fiAGwsl3xzryiSIR
         6OnUVPiQVol9hUhgIbTtSrg7R3Tp7jvOkpiyGKj4sGt/OxPOKiqTV+WGiNkQOFN/8EAQ
         XlXRVcwC648CxyGi0qLl/dOpy27nYzUrPFhV1mnOOVKeir9nqFNpPnQO8dofILilLkX5
         uRLAKsiyCs/Ssp6QcjzJmkQPAUqsoPJn0WadQHWZk6OKt0jb9aYm8FBrYDUpC/buvI9x
         OYix//iqSPbTlwunda1DEmZBBxMxL43mbIi35ZSpYc/THu7YlaCufs0AOVdp/MRcfrGf
         VvIQ==
X-Gm-Message-State: APjAAAWcmxTn3UR5VcPlp+xuUoIgMYrCc6iHMKkxjpCzbORzwplnUhwv
        FjB74e+/w6OPoa/oXDedu5jRaBI6mQ==
X-Google-Smtp-Source: APXvYqxsBJ450rR2WsKYmQiAz1XK7OefPHziYVK/Ufte9i3SQvIef9RFobk/w4jMq3ocySVNfwD+zihNnw==
X-Received: by 2002:a1f:3a8a:: with SMTP id h132mr18646495vka.95.1580845034920;
 Tue, 04 Feb 2020 11:37:14 -0800 (PST)
Date:   Tue,  4 Feb 2020 11:37:11 -0800
In-Reply-To: <CAKUOC8Xvxa8nixstFOdjuf7_sCZNV6EqSDxTAQZjLhvf86LESA@mail.gmail.com>
Message-Id: <20200204193711.257285-1-sqazi@google.com>
Mime-Version: 1.0
References: <CAKUOC8Xvxa8nixstFOdjuf7_sCZNV6EqSDxTAQZjLhvf86LESA@mail.gmail.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] block: Limit number of items taken from the I/O scheduler in
 one go
From:   Salman Qazi <sqazi@google.com>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Salman Qazi <sqazi@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Flushes bypass the I/O scheduler and get added to hctx->dispatch
in blk_mq_sched_bypass_insert.  This can happen while a kworker is running
hctx->run_work work item and is past the point in
blk_mq_sched_dispatch_requests where hctx->dispatch is checked.

The blk_mq_do_dispatch_sched call is not guaranteed to end in bounded time,
because the I/O scheduler can feed an arbitrary number of commands.

Since we have only one hctx->run_work, the commands waiting in
hctx->dispatch will wait an arbitrary length of time for run_work to be
rerun.

A similar phenomenon exists with dispatches from the software queue.

The solution is to poll hctx->dispatch in blk_mq_do_dispatch_sched and
blk_mq_do_dispatch_ctx and return from the run_work handler and let it
rerun.

Signed-off-by: Salman Qazi <sqazi@google.com>
---
 block/blk-mq-sched.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index ca22afd47b3d..d1b8b31bc3d4 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -97,6 +97,9 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
 			break;
 
+		if (!list_empty_careful(&hctx->dispatch))
+			break;
+
 		if (!blk_mq_get_dispatch_budget(hctx))
 			break;
 
@@ -140,6 +143,9 @@ static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 	do {
 		struct request *rq;
 
+		if (!list_empty_careful(&hctx->dispatch))
+			break;
+
 		if (!sbitmap_any_bit_set(&hctx->ctx_map))
 			break;
 
-- 
2.25.0.341.g760bfbb309-goog

