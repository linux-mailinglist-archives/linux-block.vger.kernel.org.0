Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE51537F93
	for <lists+linux-block@lfdr.de>; Mon, 30 May 2022 16:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiE3NyJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 30 May 2022 09:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238667AbiE3NxM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 May 2022 09:53:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD0E8A06F;
        Mon, 30 May 2022 06:37:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE29060F99;
        Mon, 30 May 2022 13:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37885C3411A;
        Mon, 30 May 2022 13:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653917852;
        bh=aD2bwhTaBdhLJlZgj84uncUpqKZ/Ttho7VUAKt9ILjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S/L2dHskkKGX7y268KAv8rESvV+Vh96rX75hx8QJYrYpq34esQjD2k7JBJzAU7PBo
         uN6jkiOvBZtJBllws3EGL8ZCu+qOGMAqVN1FNHUxcvV+tgSW4skOQrGepWAnssrB4D
         Jyq2X8dXYshGhrJDmkSsbpir8qj4r7PJGZR+urKlbwBFtSthr1AWu06fzY0sOHQ27P
         Ucnf5p/6QUVLcKVZBk9DnRcCZiD/l2xfQOiJTSbwilUhdBIgxhyFFlDmx5x3Q6+h3/
         xiZvsxD80Uvs2Omzj4FcmH0epxN/1QiZTVthjJRa43Ijpi28BO87OHQnhU2Yt8w4O0
         COeT/eFyRddxQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Laibin Qiu <qiulaibin@huawei.com>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        tj@kernel.org, cgroups@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.17 117/135] blk-throttle: Set BIO_THROTTLED when bio has been throttled
Date:   Mon, 30 May 2022 09:31:15 -0400
Message-Id: <20220530133133.1931716-117-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530133133.1931716-1-sashal@kernel.org>
References: <20220530133133.1931716-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Laibin Qiu <qiulaibin@huawei.com>

[ Upstream commit 5a011f889b4832aa80c2a872a5aade5c48d2756f ]

1.In current process, all bio will set the BIO_THROTTLED flag
after __blk_throtl_bio().

2.If bio needs to be throttled, it will start the timer and
stop submit bio directly. Bio will submit in
blk_throtl_dispatch_work_fn() when the timer expires.But in
the current process, if bio is throttled. The BIO_THROTTLED
will be set to bio after timer start. If the bio has been
completed, it may cause use-after-free blow.

BUG: KASAN: use-after-free in blk_throtl_bio+0x12f0/0x2c70
Read of size 2 at addr ffff88801b8902d4 by task fio/26380

 dump_stack+0x9b/0xce
 print_address_description.constprop.6+0x3e/0x60
 kasan_report.cold.9+0x22/0x3a
 blk_throtl_bio+0x12f0/0x2c70
 submit_bio_checks+0x701/0x1550
 submit_bio_noacct+0x83/0xc80
 submit_bio+0xa7/0x330
 mpage_readahead+0x380/0x500
 read_pages+0x1c1/0xbf0
 page_cache_ra_unbounded+0x471/0x6f0
 do_page_cache_ra+0xda/0x110
 ondemand_readahead+0x442/0xae0
 page_cache_async_ra+0x210/0x300
 generic_file_buffered_read+0x4d9/0x2130
 generic_file_read_iter+0x315/0x490
 blkdev_read_iter+0x113/0x1b0
 aio_read+0x2ad/0x450
 io_submit_one+0xc8e/0x1d60
 __se_sys_io_submit+0x125/0x350
 do_syscall_64+0x2d/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Allocated by task 26380:
 kasan_save_stack+0x19/0x40
 __kasan_kmalloc.constprop.2+0xc1/0xd0
 kmem_cache_alloc+0x146/0x440
 mempool_alloc+0x125/0x2f0
 bio_alloc_bioset+0x353/0x590
 mpage_alloc+0x3b/0x240
 do_mpage_readpage+0xddf/0x1ef0
 mpage_readahead+0x264/0x500
 read_pages+0x1c1/0xbf0
 page_cache_ra_unbounded+0x471/0x6f0
 do_page_cache_ra+0xda/0x110
 ondemand_readahead+0x442/0xae0
 page_cache_async_ra+0x210/0x300
 generic_file_buffered_read+0x4d9/0x2130
 generic_file_read_iter+0x315/0x490
 blkdev_read_iter+0x113/0x1b0
 aio_read+0x2ad/0x450
 io_submit_one+0xc8e/0x1d60
 __se_sys_io_submit+0x125/0x350
 do_syscall_64+0x2d/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 0:
 kasan_save_stack+0x19/0x40
 kasan_set_track+0x1c/0x30
 kasan_set_free_info+0x1b/0x30
 __kasan_slab_free+0x111/0x160
 kmem_cache_free+0x94/0x460
 mempool_free+0xd6/0x320
 bio_free+0xe0/0x130
 bio_put+0xab/0xe0
 bio_endio+0x3a6/0x5d0
 blk_update_request+0x590/0x1370
 scsi_end_request+0x7d/0x400
 scsi_io_completion+0x1aa/0xe50
 scsi_softirq_done+0x11b/0x240
 blk_mq_complete_request+0xd4/0x120
 scsi_mq_done+0xf0/0x200
 virtscsi_vq_done+0xbc/0x150
 vring_interrupt+0x179/0x390
 __handle_irq_event_percpu+0xf7/0x490
 handle_irq_event_percpu+0x7b/0x160
 handle_irq_event+0xcc/0x170
 handle_edge_irq+0x215/0xb20
 common_interrupt+0x60/0x120
 asm_common_interrupt+0x1e/0x40

Fix this by move BIO_THROTTLED set into the queue_lock.

Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20220301123919.2381579-1-qiulaibin@huawei.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-throttle.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 87769b337fc5..e1b253775a56 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2167,13 +2167,14 @@ bool __blk_throtl_bio(struct bio *bio)
 	}
 
 out_unlock:
-	spin_unlock_irq(&q->queue_lock);
 	bio_set_flag(bio, BIO_THROTTLED);
 
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	if (throttled || !td->track_bio_latency)
 		bio->bi_issue.value |= BIO_ISSUE_THROTL_SKIP_LATENCY;
 #endif
+	spin_unlock_irq(&q->queue_lock);
+
 	rcu_read_unlock();
 	return throttled;
 }
-- 
2.35.1

