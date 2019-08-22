Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA26B98CCA
	for <lists+linux-block@lfdr.de>; Thu, 22 Aug 2019 09:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbfHVH7o (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 22 Aug 2019 03:59:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731267AbfHVH7n (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Aug 2019 03:59:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 84CE5285AE;
        Thu, 22 Aug 2019 07:59:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.70.39.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27AA15D6A7;
        Thu, 22 Aug 2019 07:59:40 +0000 (UTC)
From:   xiubli@redhat.com
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     mchristi@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>
Subject: [PATCH 2/2 v3] nbd: fix possible page fault for nbd disk
Date:   Thu, 22 Aug 2019 13:29:23 +0530
Message-Id: <20190822075923.11996-3-xiubli@redhat.com>
In-Reply-To: <20190822075923.11996-1-xiubli@redhat.com>
References: <20190822075923.11996-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 22 Aug 2019 07:59:43 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

When the NBD_CFLAG_DESTROY_ON_DISCONNECT flag is set and at the same
time when the socket is closed due to the server daemon is restarted,
just before the last DISCONNET is totally done if we start a new connection
by using the old nbd_index, there will be crashing randomly, like:

<3>[  110.151949] block nbd1: Receive control failed (result -32)
<1>[  110.152024] BUG: unable to handle page fault for address: 0000058000000840
<1>[  110.152063] #PF: supervisor read access in kernel mode
<1>[  110.152083] #PF: error_code(0x0000) - not-present page
<6>[  110.152094] PGD 0 P4D 0
<4>[  110.152106] Oops: 0000 [#1] SMP PTI
<4>[  110.152120] CPU: 0 PID: 6698 Comm: kworker/u5:1 Kdump: loaded Not tainted 5.3.0-rc4+ #2
<4>[  110.152136] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
<4>[  110.152166] Workqueue: knbd-recv recv_work [nbd]
<4>[  110.152187] RIP: 0010:__dev_printk+0xd/0x67
<4>[  110.152206] Code: 10 e8 c5 fd ff ff 48 8b 4c 24 18 65 48 33 0c 25 28 00 [...]
<4>[  110.152244] RSP: 0018:ffffa41581f13d18 EFLAGS: 00010206
<4>[  110.152256] RAX: ffffa41581f13d30 RBX: ffff96dd7374e900 RCX: 0000000000000000
<4>[  110.152271] RDX: ffffa41581f13d20 RSI: 00000580000007f0 RDI: ffffffff970ec24f
<4>[  110.152285] RBP: ffffa41581f13d80 R08: ffff96dd7fc17908 R09: 0000000000002e56
<4>[  110.152299] R10: ffffffff970ec24f R11: 0000000000000003 R12: ffff96dd7374e900
<4>[  110.152313] R13: 0000000000000000 R14: ffff96dd7374e9d8 R15: ffff96dd6e3b02c8
<4>[  110.152329] FS:  0000000000000000(0000) GS:ffff96dd7fc00000(0000) knlGS:0000000000000000
<4>[  110.152362] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[  110.152383] CR2: 0000058000000840 CR3: 0000000067cc6002 CR4: 00000000001606f0
<4>[  110.152401] Call Trace:
<4>[  110.152422]  _dev_err+0x6c/0x83
<4>[  110.152435]  nbd_read_stat.cold+0xda/0x578 [nbd]
<4>[  110.152448]  ? __switch_to_asm+0x34/0x70
<4>[  110.152468]  ? __switch_to_asm+0x40/0x70
<4>[  110.152478]  ? __switch_to_asm+0x34/0x70
<4>[  110.152491]  ? __switch_to_asm+0x40/0x70
<4>[  110.152501]  ? __switch_to_asm+0x34/0x70
<4>[  110.152511]  ? __switch_to_asm+0x40/0x70
<4>[  110.152522]  ? __switch_to_asm+0x34/0x70
<4>[  110.152533]  recv_work+0x35/0x9e [nbd]
<4>[  110.152547]  process_one_work+0x19d/0x340
<4>[  110.152558]  worker_thread+0x50/0x3b0
<4>[  110.152568]  kthread+0xfb/0x130
<4>[  110.152577]  ? process_one_work+0x340/0x340
<4>[  110.152609]  ? kthread_park+0x80/0x80
<4>[  110.152637]  ret_from_fork+0x35/0x40

This is very easy to reproduce by running the nbd-runner.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 drivers/block/nbd.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 8c2f17b99224..a25b59725c6e 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -26,6 +26,7 @@
 #include <linux/ioctl.h>
 #include <linux/mutex.h>
 #include <linux/compiler.h>
+#include <linux/completion.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -80,6 +81,9 @@ struct link_dead_args {
 #define NBD_RT_DESTROY_ON_DISCONNECT	6
 #define NBD_RT_DISCONNECT_ON_CLOSE	7
 
+#define NBD_DESTROY_ON_DISCONNECT	0
+#define NBD_DISCONNECT_REQUESTED	1
+
 struct nbd_config {
 	u32 flags;
 	unsigned long runtime_flags;
@@ -112,6 +116,9 @@ struct nbd_device {
 	struct list_head list;
 	struct task_struct *task_recv;
 	struct task_struct *task_setup;
+
+	struct completion destroy_complete;
+	unsigned long flags;
 };
 
 #define NBD_CMD_REQUEUED	1
@@ -222,6 +229,16 @@ static void nbd_dev_remove(struct nbd_device *nbd)
 		disk->private_data = NULL;
 		put_disk(disk);
 	}
+
+	/*
+	 * Place this in the last just before the nbd is freed to
+	 * make sure that the disk and the related kobject are also
+	 * totally removed to avoid duplicate creation of the same
+	 * one.
+	 */
+	if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags))
+		complete(&nbd->destroy_complete);
+
 	kfree(nbd);
 }
 
@@ -230,8 +247,8 @@ static void nbd_put(struct nbd_device *nbd)
 	if (refcount_dec_and_mutex_lock(&nbd->refs,
 					&nbd_index_mutex)) {
 		idr_remove(&nbd_index_idr, nbd->index);
-		mutex_unlock(&nbd_index_mutex);
 		nbd_dev_remove(nbd);
+		mutex_unlock(&nbd_index_mutex);
 	}
 }
 
@@ -1103,6 +1120,7 @@ static int nbd_disconnect(struct nbd_device *nbd)
 
 	dev_info(disk_to_dev(nbd->disk), "NBD_DISCONNECT\n");
 	set_bit(NBD_RT_DISCONNECT_REQUESTED, &config->runtime_flags);
+	set_bit(NBD_DISCONNECT_REQUESTED, &nbd->flags);
 	send_disconnects(nbd);
 	return 0;
 }
@@ -1596,6 +1614,7 @@ static int nbd_dev_add(int index)
 	nbd->tag_set.flags = BLK_MQ_F_SHOULD_MERGE |
 		BLK_MQ_F_BLOCKING;
 	nbd->tag_set.driver_data = nbd;
+	init_completion(&nbd->destroy_complete);
 
 	err = blk_mq_alloc_tag_set(&nbd->tag_set);
 	if (err)
@@ -1761,6 +1780,16 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 		mutex_unlock(&nbd_index_mutex);
 		return -EINVAL;
 	}
+
+	if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags) &&
+	    test_bit(NBD_DISCONNECT_REQUESTED, &nbd->flags)) {
+		mutex_unlock(&nbd_index_mutex);
+
+		/* Wait untill the recv_work exit */
+		wait_for_completion(&nbd->destroy_complete);
+		goto again;
+	}
+
 	if (!refcount_inc_not_zero(&nbd->refs)) {
 		mutex_unlock(&nbd_index_mutex);
 		if (index == -1)
@@ -1817,7 +1846,10 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 		if (flags & NBD_CFLAG_DESTROY_ON_DISCONNECT) {
 			set_bit(NBD_RT_DESTROY_ON_DISCONNECT,
 				&config->runtime_flags);
+			set_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags);
 			put_dev = true;
+		} else {
+			clear_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags);
 		}
 		if (flags & NBD_CFLAG_DISCONNECT_ON_CLOSE) {
 			set_bit(NBD_RT_DISCONNECT_ON_CLOSE,
@@ -1987,10 +2019,12 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 			if (!test_and_set_bit(NBD_RT_DESTROY_ON_DISCONNECT,
 					      &config->runtime_flags))
 				put_dev = true;
+			set_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags);
 		} else {
 			if (test_and_clear_bit(NBD_RT_DESTROY_ON_DISCONNECT,
 					       &config->runtime_flags))
 				refcount_inc(&nbd->refs);
+			clear_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags);
 		}
 
 		if (flags & NBD_CFLAG_DISCONNECT_ON_CLOSE) {
-- 
2.21.0

