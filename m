Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1C7297483
	for <lists+linux-block@lfdr.de>; Fri, 23 Oct 2020 18:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465752AbgJWQds (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 23 Oct 2020 12:33:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:32774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S465514AbgJWQdr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:47 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 000ED24641;
        Fri, 23 Oct 2020 16:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470827;
        bh=kgtiFfCJTukdztBKrgaViUkGzaEuu7+QoSys6J4D4sM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YIQ+hkqmTrReQxWOiyFNCiuAvL+nLglsNdUkkVNme+SB26jpE5p50ZWEmLD3hsm03
         ktGcUcY6pCodvrfhjVPRXFPbrQybMPyTaoaMpzS4U/3wExBtMdDlfkFsZ1ZwJoMVi+
         Y7I9pXmXji14r4E32nZ+nazo2jx/sVGPU3umMhOA=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00e-002Avb-SD; Fri, 23 Oct 2020 18:33:44 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/56] block: blk-mq: fix a kernel-doc markup
Date:   Fri, 23 Oct 2020 18:32:54 +0200
Message-Id: <da771fd9e5281537f39c6e927a199b681ff6204f.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix a typo:
	blk_mq_run_hw_queue -> blk_mq_run_hw_queues

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 696450257ac1..bca2e3962262 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1664,7 +1664,7 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 EXPORT_SYMBOL(blk_mq_run_hw_queue);
 
 /**
- * blk_mq_run_hw_queue - Run all hardware queues in a request queue.
+ * blk_mq_run_hw_queues - Run all hardware queues in a request queue.
  * @q: Pointer to the request queue to run.
  * @async: If we want to run the queue asynchronously.
  */
-- 
2.26.2

