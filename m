Return-Path: <linux-block+bounces-734-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A3D80554C
	for <lists+linux-block@lfdr.de>; Tue,  5 Dec 2023 13:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A301F213E9
	for <lists+linux-block@lfdr.de>; Tue,  5 Dec 2023 12:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC5852F73;
	Tue,  5 Dec 2023 12:57:53 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9A4A0;
	Tue,  5 Dec 2023 04:57:48 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sl0tr1Plpz4f3lCn;
	Tue,  5 Dec 2023 20:57:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DCA8D1A0B90;
	Tue,  5 Dec 2023 20:57:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgA3iA5HHm9l7uI9Cw--.19151S4;
	Tue, 05 Dec 2023 20:57:44 +0800 (CST)
From: Li Lingfeng <lilingfeng@huaweicloud.com>
To: josef@toxicpanda.com
Cc: linux-kernel@vger.kernel.org,
	hch@lst.de,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	axboe@kernel.dk,
	chaitanya.kulkarni@wdc.com,
	yukuai1@huaweicloud.com,
	houtao1@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	lilingfeng@huaweicloud.com,
	lilingfeng3@huawei.com
Subject: [PATCH -next v2] nbd: get config_lock before sock_shutdown
Date: Tue,  5 Dec 2023 20:56:41 +0800
Message-Id: <20231205125641.1913393-1-lilingfeng@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3iA5HHm9l7uI9Cw--.19151S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWry3XF15CrWDZF4rtr48Xrb_yoW5Xw4rpF
	43CFs8Gr45X3WSga9xJ34xWry5G3saga17Gry7u3WSvrZ7CrWxurn5KFy3Cr1DJr9xXF45
	XFyFgFnYya98JrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267
	AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyU
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUkrcfUUUUU=
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/

From: Zhong Jinghua <zhongjinghua@huawei.com>

Config->socks in sock_shutdown may trigger a UAF problem.
The reason is that sock_shutdown does not hold the config_lock,
so that nbd_ioctl can release config->socks at this time.

T0: NBD_DO_IT
T1: NBD_SET_SOCK

T0						T1

nbd_ioctl
  mutex_lock(&nbd->config_lock)
  // get lock
  __nbd_ioctl
	nbd_start_device_ioctl
	  nbd_start_device
	  mutex_unlock(&nbd->config_lock)
	  // relase lock
	  wait_event_interruptible
	  (kill, enter sock_shutdown)
	  sock_shutdown
					nbd_ioctl
					  mutex_lock(&nbd->config_lock)
					  // get lock
					  __nbd_ioctl
					    nbd_add_socket
					      krealloc
						kfree(p)
					        //config->socks is NULL
	    nbd_sock *nsock = config->socks // error

Fix it by moving config_lock up before sock_shutdown.

Link: https://lore.kernel.org/all/ab998dda-80ba-7d8b-0cae-36665826deb5@huaweicloud.com/
Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
v1->v2:
  Make comment more detailed.

 drivers/block/nbd.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 855fdf5c3b4e..7a044b4726b4 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -92,6 +92,11 @@ struct nbd_config {
 	unsigned long runtime_flags;
 	u64 dead_conn_timeout;
 
+	/*
+	 * Anyone who tries to get config->socks needs to be
+	 * protected by config_lock since it may be released
+	 * by krealloc in nbd_add_socket.
+	 */
 	struct nbd_sock **socks;
 	int num_connections;
 	atomic_t live_connections;
@@ -876,6 +881,10 @@ static void recv_work(struct work_struct *work)
 	nbd_mark_nsock_dead(nbd, nsock, 1);
 	mutex_unlock(&nsock->tx_lock);
 
+	/*
+	 * recv_work will not get config_lock here if recv_workq is flushed
+	 * in ioctl since nbd_open is holding config_refs.
+	 */
 	nbd_config_put(nbd);
 	atomic_dec(&config->recv_threads);
 	wake_up(&config->recv_wq);
@@ -1417,13 +1426,21 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd)
 	mutex_unlock(&nbd->config_lock);
 	ret = wait_event_interruptible(config->recv_wq,
 					 atomic_read(&config->recv_threads) == 0);
+
+	/*
+	 * Get config_lock before sock_shutdown to prevent UAF since nbd_add_socket
+	 * may release config->socks concurrently.
+	 *
+	 * config_lock can be got before flush_workqueue since recv_work will not
+	 * get it in the current scenario.
+	 */
+	mutex_lock(&nbd->config_lock);
 	if (ret) {
 		sock_shutdown(nbd);
 		nbd_clear_que(nbd);
 	}
 
 	flush_workqueue(nbd->recv_workq);
-	mutex_lock(&nbd->config_lock);
 	nbd_bdev_reset(nbd);
 	/* user requested, ignore socket errors */
 	if (test_bit(NBD_RT_DISCONNECT_REQUESTED, &config->runtime_flags))
-- 
2.39.2


