Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87341650411
	for <lists+linux-block@lfdr.de>; Sun, 18 Dec 2022 18:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiLRRNL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 18 Dec 2022 12:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbiLRRLC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Dec 2022 12:11:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188B213E9C;
        Sun, 18 Dec 2022 08:23:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAF4860C40;
        Sun, 18 Dec 2022 16:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55837C433D2;
        Sun, 18 Dec 2022 16:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671380633;
        bh=PFXo/H9XbYNJh+1q5k+Qi4mEA3PvRNfZqjQ98IO1cY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bXBpW2TU+wKy/m8aw2FulzCnxqEiAl1OLBuhIl0DHXbzsSzDjL8KFEN4M3P04TA3j
         gy3ARpmw5eqVzk+gGWSuYGuxAhaGSXstteRr1KzeSUx9w4Rei1m35Qjl9ynFuP3dmL
         vCIEseswtyMVUP4pjXbvbTEg298GqrqXV3iCMLBopI3JABvsx8DtQSaBYodnqFCIBV
         RICgKcZMzGCxHrwO2YRsPjajpSnlZdDLzeirzxEZ448Whavm+GjKT954WXJh9oVQtK
         qH7AH2jfn8+rjM83F87vzt0dDm3oQkgV7gVQMfTHIbly3tJLeOLwM8BXZuM7CGTSUN
         L7r/AhPVexfBQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ye Bin <yebin10@huawei.com>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 17/20] blk-mq: fix possible memleak when register 'hctx' failed
Date:   Sun, 18 Dec 2022 11:23:02 -0500
Message-Id: <20221218162305.935724-17-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221218162305.935724-1-sashal@kernel.org>
References: <20221218162305.935724-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit 4b7a21c57b14fbcd0e1729150189e5933f5088e9 ]

There's issue as follows when do fault injection test:
unreferenced object 0xffff888132a9f400 (size 512):
  comm "insmod", pid 308021, jiffies 4324277909 (age 509.733s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 f4 a9 32 81 88 ff ff  ...........2....
    08 f4 a9 32 81 88 ff ff 00 00 00 00 00 00 00 00  ...2............
  backtrace:
    [<00000000e8952bb4>] kmalloc_node_trace+0x22/0xa0
    [<00000000f9980e0f>] blk_mq_alloc_and_init_hctx+0x3f1/0x7e0
    [<000000002e719efa>] blk_mq_realloc_hw_ctxs+0x1e6/0x230
    [<000000004f1fda40>] blk_mq_init_allocated_queue+0x27e/0x910
    [<00000000287123ec>] __blk_mq_alloc_disk+0x67/0xf0
    [<00000000a2a34657>] 0xffffffffa2ad310f
    [<00000000b173f718>] 0xffffffffa2af824a
    [<0000000095a1dabb>] do_one_initcall+0x87/0x2a0
    [<00000000f32fdf93>] do_init_module+0xdf/0x320
    [<00000000cbe8541e>] load_module+0x3006/0x3390
    [<0000000069ed1bdb>] __do_sys_finit_module+0x113/0x1b0
    [<00000000a1a29ae8>] do_syscall_64+0x35/0x80
    [<000000009cd878b0>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

Fault injection context as follows:
 kobject_add
 blk_mq_register_hctx
 blk_mq_sysfs_register
 blk_register_queue
 device_add_disk
 null_add_dev.part.0 [null_blk]

As 'blk_mq_register_hctx' may already add some objects when failed halfway,
but there isn't do fallback, caller don't know which objects add failed.
To solve above issue just do fallback when add objects failed halfway in
'blk_mq_register_hctx'.

Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20221117022940.873959-1-yebin@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq-sysfs.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 5b64d9d7d147..fc9362e0a118 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -380,7 +380,7 @@ static int blk_mq_register_hctx(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 	struct blk_mq_ctx *ctx;
-	int i, ret;
+	int i, j, ret;
 
 	if (!hctx->nr_ctx)
 		return 0;
@@ -392,9 +392,16 @@ static int blk_mq_register_hctx(struct blk_mq_hw_ctx *hctx)
 	hctx_for_each_ctx(hctx, ctx, i) {
 		ret = kobject_add(&ctx->kobj, &hctx->kobj, "cpu%u", ctx->cpu);
 		if (ret)
-			break;
+			goto out;
 	}
 
+	return 0;
+out:
+	hctx_for_each_ctx(hctx, ctx, j) {
+		if (j < i)
+			kobject_del(&ctx->kobj);
+	}
+	kobject_del(&hctx->kobj);
 	return ret;
 }
 
-- 
2.35.1

