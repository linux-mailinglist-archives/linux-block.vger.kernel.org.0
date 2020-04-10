Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31BB61A3FDD
	for <lists+linux-block@lfdr.de>; Fri, 10 Apr 2020 05:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgDJDvD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 9 Apr 2020 23:51:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729062AbgDJDvC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Apr 2020 23:51:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AC48212CC;
        Fri, 10 Apr 2020 03:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490662;
        bh=apxGS9wORaO6rpyZeP55Ya2+HXN69AzSilbDx3ckv/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mm9SWhDqHlTgDWU/qGp8ULzH2Ts7kblr62FuiNr6AXRyWLo11vRuFRU3oiw4gHQv8
         HkaLcPX2acTQbaZha+dE2KXKbZQUpy7lSlp1xUabmh7CGFtNupX2mMPBjBOSVbvjGK
         iTOD+aJcuWS/FMKTUMy9CGyK7kfMEdOZ4hbMIVDg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        Pradeep P V K <ppvk@codeaurora.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 15/22] block: Fix use-after-free issue accessing struct io_cq
Date:   Thu,  9 Apr 2020 23:50:37 -0400
Message-Id: <20200410035044.9698-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410035044.9698-1-sashal@kernel.org>
References: <20200410035044.9698-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sahitya Tummala <stummala@codeaurora.org>

[ Upstream commit 30a2da7b7e225ef6c87a660419ea04d3cef3f6a7 ]

There is a potential race between ioc_release_fn() and
ioc_clear_queue() as shown below, due to which below kernel
crash is observed. It also can result into use-after-free
issue.

context#1:				context#2:
ioc_release_fn()			__ioc_clear_queue() gets the same icq
->spin_lock(&ioc->lock);		->spin_lock(&ioc->lock);
->ioc_destroy_icq(icq);
  ->list_del_init(&icq->q_node);
  ->call_rcu(&icq->__rcu_head,
  	icq_free_icq_rcu);
->spin_unlock(&ioc->lock);
					->ioc_destroy_icq(icq);
					  ->hlist_del_init(&icq->ioc_node);
					  This results into below crash as this memory
					  is now used by icq->__rcu_head in context#1.
					  There is a chance that icq could be free'd
					  as well.

22150.386550:   <6> Unable to handle kernel write to read-only memory
at virtual address ffffffaa8d31ca50
...
Call trace:
22150.607350:   <2>  ioc_destroy_icq+0x44/0x110
22150.611202:   <2>  ioc_clear_queue+0xac/0x148
22150.615056:   <2>  blk_cleanup_queue+0x11c/0x1a0
22150.619174:   <2>  __scsi_remove_device+0xdc/0x128
22150.623465:   <2>  scsi_forget_host+0x2c/0x78
22150.627315:   <2>  scsi_remove_host+0x7c/0x2a0
22150.631257:   <2>  usb_stor_disconnect+0x74/0xc8
22150.635371:   <2>  usb_unbind_interface+0xc8/0x278
22150.639665:   <2>  device_release_driver_internal+0x198/0x250
22150.644897:   <2>  device_release_driver+0x24/0x30
22150.649176:   <2>  bus_remove_device+0xec/0x140
22150.653204:   <2>  device_del+0x270/0x460
22150.656712:   <2>  usb_disable_device+0x120/0x390
22150.660918:   <2>  usb_disconnect+0xf4/0x2e0
22150.664684:   <2>  hub_event+0xd70/0x17e8
22150.668197:   <2>  process_one_work+0x210/0x480
22150.672222:   <2>  worker_thread+0x32c/0x4c8

Fix this by adding a new ICQ_DESTROYED flag in ioc_destroy_icq() to
indicate this icq is once marked as destroyed. Also, ensure
__ioc_clear_queue() is accessing icq within rcu_read_lock/unlock so
that icq doesn't get free'd up while it is still using it.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Co-developed-by: Pradeep P V K <ppvk@codeaurora.org>
Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-ioc.c           | 7 +++++++
 include/linux/iocontext.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index f23311e4b201f..e56a480b6f929 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -87,6 +87,7 @@ static void ioc_destroy_icq(struct io_cq *icq)
 	 * making it impossible to determine icq_cache.  Record it in @icq.
 	 */
 	icq->__rcu_icq_cache = et->icq_cache;
+	icq->flags |= ICQ_DESTROYED;
 	call_rcu(&icq->__rcu_head, icq_free_icq_rcu);
 }
 
@@ -230,15 +231,21 @@ static void __ioc_clear_queue(struct list_head *icq_list)
 {
 	unsigned long flags;
 
+	rcu_read_lock();
 	while (!list_empty(icq_list)) {
 		struct io_cq *icq = list_entry(icq_list->next,
 					       struct io_cq, q_node);
 		struct io_context *ioc = icq->ioc;
 
 		spin_lock_irqsave(&ioc->lock, flags);
+		if (icq->flags & ICQ_DESTROYED) {
+			spin_unlock_irqrestore(&ioc->lock, flags);
+			continue;
+		}
 		ioc_destroy_icq(icq);
 		spin_unlock_irqrestore(&ioc->lock, flags);
 	}
+	rcu_read_unlock();
 }
 
 /**
diff --git a/include/linux/iocontext.h b/include/linux/iocontext.h
index dba15ca8e60bc..1dcd9198beb7f 100644
--- a/include/linux/iocontext.h
+++ b/include/linux/iocontext.h
@@ -8,6 +8,7 @@
 
 enum {
 	ICQ_EXITED		= 1 << 2,
+	ICQ_DESTROYED		= 1 << 3,
 };
 
 /*
-- 
2.20.1

