Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0220F3E0C46
	for <lists+linux-block@lfdr.de>; Thu,  5 Aug 2021 04:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238140AbhHECHG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 4 Aug 2021 22:07:06 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7784 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238097AbhHECHF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Aug 2021 22:07:05 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GgBn02GDZzYlDd;
        Thu,  5 Aug 2021 10:06:44 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 10:06:51 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 5 Aug 2021
 10:06:50 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <houtao1@huawei.com>
Subject: [PATCH] nbd: call genl_unregister_family() first in nbd_cleanup()
Date:   Thu, 5 Aug 2021 10:19:46 +0800
Message-ID: <20210805021946.978686-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Else there may be race between module removal and handling of
netlink command and will lead to oops as shown below:

  BUG: kernel NULL pointer dereference, address: 0000000000000098
  Oops: 0002 [#1] SMP PTI
  CPU: 1 PID: 31299 Comm: nbd-client Tainted: G            E     5.14.0-rc4
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
  RIP: 0010:down_write+0x1a/0x50
  Call Trace:
   start_creating+0x89/0x130
   debugfs_create_dir+0x1b/0x130
   nbd_start_device+0x13d/0x390 [nbd]
   nbd_genl_connect+0x42f/0x748 [nbd]
   genl_family_rcv_msg_doit.isra.0+0xec/0x150
   genl_rcv_msg+0xe5/0x1e0
   netlink_rcv_skb+0x55/0x100
   genl_rcv+0x29/0x40
   netlink_unicast+0x1a8/0x250
   netlink_sendmsg+0x21b/0x430
   ____sys_sendmsg+0x2a4/0x2d0
   ___sys_sendmsg+0x81/0xc0
   __sys_sendmsg+0x62/0xb0
   __x64_sys_sendmsg+0x1f/0x30
   do_syscall_64+0x3b/0xc0
   entry_SYSCALL_64_after_hwframe+0x44/0xae
  Modules linked in: nbd(E-)

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 drivers/block/nbd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 9a7c9a425ab0..0993d108d868 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2492,6 +2492,12 @@ static void __exit nbd_cleanup(void)
 	struct nbd_device *nbd;
 	LIST_HEAD(del_list);
 
+	/*
+	 * Unregister netlink interface first to waiting
+	 * for the completion of netlink commands.
+	 */
+	genl_unregister_family(&nbd_genl_family);
+
 	nbd_dbg_close();
 
 	mutex_lock(&nbd_index_mutex);
@@ -2510,7 +2516,6 @@ static void __exit nbd_cleanup(void)
 	destroy_workqueue(nbd_del_wq);
 
 	idr_destroy(&nbd_index_idr);
-	genl_unregister_family(&nbd_genl_family);
 	unregister_blkdev(NBD_MAJOR, "nbd");
 }
 
-- 
2.29.2

