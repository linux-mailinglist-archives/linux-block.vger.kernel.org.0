Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6CF540E05
	for <lists+linux-block@lfdr.de>; Tue,  7 Jun 2022 20:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353486AbiFGSv6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 7 Jun 2022 14:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353454AbiFGStK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jun 2022 14:49:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518A719297;
        Tue,  7 Jun 2022 11:03:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E7FE617A7;
        Tue,  7 Jun 2022 18:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B89C3411C;
        Tue,  7 Jun 2022 18:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654624991;
        bh=V6p5BQsO1+EU/j6FqgbS3TxvSYHwUNOeiBDZG2dot3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qZ3gAlVFx54ytPaMmNxozGFDV5lkGumvTVhRkJ2fCBSgGfHnOpnefkkz/j5BrgvvV
         NaeGerqaJukRBFRTBCJQVtmfmr1DFjq/A+eNXaRUPVq7X+2lYDp21nlhMJpIWnqroo
         SCjur5/otmpWw0ly9IpoEITaxzo5cIwjRU/tqrRMiIU4DHGcrXG/D58mqxltIGSDJD
         Pglu0VUtalhNkgIG0Vaz1qiIGs7agXP6160+2GCGvRrz0fI61F1TeCdsRcdqlgZDhd
         1jDQKNK8Vl6nFe5y3Nrgq6Nr3QsDYR2USKVJY7K/pfKH3u0X1DrsjQSBTzYkROwnOS
         gq1hKk5Ty8Hbg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yu Kuai <yukuai3@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH AUTOSEL 4.14 23/25] nbd: fix race between nbd_alloc_config() and module removal
Date:   Tue,  7 Jun 2022 14:02:24 -0400
Message-Id: <20220607180229.482040-23-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220607180229.482040-1-sashal@kernel.org>
References: <20220607180229.482040-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit c55b2b983b0fa012942c3eb16384b2b722caa810 ]

When nbd module is being removing, nbd_alloc_config() may be
called concurrently by nbd_genl_connect(), although try_module_get()
will return false, but nbd_alloc_config() doesn't handle it.

The race may lead to the leak of nbd_config and its related
resources (e.g, recv_workq) and oops in nbd_read_stat() due
to the unload of nbd module as shown below:

  BUG: kernel NULL pointer dereference, address: 0000000000000040
  Oops: 0000 [#1] SMP PTI
  CPU: 5 PID: 13840 Comm: kworker/u17:33 Not tainted 5.14.0+ #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
  Workqueue: knbd16-recv recv_work [nbd]
  RIP: 0010:nbd_read_stat.cold+0x130/0x1a4 [nbd]
  Call Trace:
   recv_work+0x3b/0xb0 [nbd]
   process_one_work+0x1ed/0x390
   worker_thread+0x4a/0x3d0
   kthread+0x12a/0x150
   ret_from_fork+0x22/0x30

Fixing it by checking the return value of try_module_get()
in nbd_alloc_config(). As nbd_alloc_config() may return ERR_PTR(-ENODEV),
assign nbd->config only when nbd_alloc_config() succeeds to ensure
the value of nbd->config is binary (valid or NULL).

Also adding a debug message to check the reference counter
of nbd_config during module removal.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Link: https://lore.kernel.org/r/20220521073749.3146892-3-yukuai3@huawei.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 1c9f866d9338..9596f93d98b2 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1382,15 +1382,20 @@ static struct nbd_config *nbd_alloc_config(void)
 {
 	struct nbd_config *config;
 
+	if (!try_module_get(THIS_MODULE))
+		return ERR_PTR(-ENODEV);
+
 	config = kzalloc(sizeof(struct nbd_config), GFP_NOFS);
-	if (!config)
-		return NULL;
+	if (!config) {
+		module_put(THIS_MODULE);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	atomic_set(&config->recv_threads, 0);
 	init_waitqueue_head(&config->recv_wq);
 	init_waitqueue_head(&config->conn_wait);
 	config->blksize = NBD_DEF_BLKSIZE;
 	atomic_set(&config->live_connections, 0);
-	try_module_get(THIS_MODULE);
 	return config;
 }
 
@@ -1417,12 +1422,13 @@ static int nbd_open(struct block_device *bdev, fmode_t mode)
 			mutex_unlock(&nbd->config_lock);
 			goto out;
 		}
-		config = nbd->config = nbd_alloc_config();
-		if (!config) {
-			ret = -ENOMEM;
+		config = nbd_alloc_config();
+		if (IS_ERR(config)) {
+			ret = PTR_ERR(config);
 			mutex_unlock(&nbd->config_lock);
 			goto out;
 		}
+		nbd->config = config;
 		refcount_set(&nbd->config_refs, 1);
 		refcount_inc(&nbd->refs);
 		mutex_unlock(&nbd->config_lock);
@@ -1803,13 +1809,14 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 		nbd_put(nbd);
 		return -EINVAL;
 	}
-	config = nbd->config = nbd_alloc_config();
-	if (!nbd->config) {
+	config = nbd_alloc_config();
+	if (IS_ERR(config)) {
 		mutex_unlock(&nbd->config_lock);
 		nbd_put(nbd);
 		printk(KERN_ERR "nbd: couldn't allocate config\n");
-		return -ENOMEM;
+		return PTR_ERR(config);
 	}
+	nbd->config = config;
 	refcount_set(&nbd->config_refs, 1);
 	set_bit(NBD_BOUND, &config->runtime_flags);
 
@@ -2334,6 +2341,9 @@ static void __exit nbd_cleanup(void)
 	while (!list_empty(&del_list)) {
 		nbd = list_first_entry(&del_list, struct nbd_device, list);
 		list_del_init(&nbd->list);
+		if (refcount_read(&nbd->config_refs))
+			printk(KERN_ERR "nbd: possibly leaking nbd_config (ref %d)\n",
+					refcount_read(&nbd->config_refs));
 		if (refcount_read(&nbd->refs) != 1)
 			printk(KERN_ERR "nbd: possibly leaking a device\n");
 		nbd_put(nbd);
-- 
2.35.1

