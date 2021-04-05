Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4772D3544AD
	for <lists+linux-block@lfdr.de>; Mon,  5 Apr 2021 18:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbhDEQF4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 5 Apr 2021 12:05:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238994AbhDEQFQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Apr 2021 12:05:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6ECCA613F3;
        Mon,  5 Apr 2021 16:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617638709;
        bh=8dX0nKeBPMPFDBL15Iezv+br/Y1ueaIaFrJnbJY55H4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rkedb5h7TfFxqD86Ju1eVIMtV5xe8CZVMrOXE6tRzCOS2jxmL6b14SBDKoq65obbb
         /Oeg4gdiEqB4SMwhRvDtq95hxMjx2KKdDLt6bzmafd6Au2SgGG0mjUV9aav2q/wlM7
         OQXep6wYN7kiZ3NmvwBNy1nQP0zeYK6upXOlnbEs9blQD3lZBFhoSDG+MOEXm9ORfC
         ouS7GcH1FZNsXpK8Qny2rPlqEIKmKXiMmOYwUq+k3iig6FpNz17T9ILOuAwriqYCy8
         65OTqxCPgu7VZaFY6ZlX9celRpmtTKBVilnPz06voyN91PfLtnlJzS/6eQyp0+7dht
         4zyqyOTuWg0GQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yufen Yu <yuyufen@huawei.com>, Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 08/13] block: only update parent bi_status when bio fail
Date:   Mon,  5 Apr 2021 12:04:53 -0400
Message-Id: <20210405160459.268794-8-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210405160459.268794-1-sashal@kernel.org>
References: <20210405160459.268794-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Yufen Yu <yuyufen@huawei.com>

[ Upstream commit 3edf5346e4f2ce2fa0c94651a90a8dda169565ee ]

For multiple split bios, if one of the bio is fail, the whole
should return error to application. But we found there is a race
between bio_integrity_verify_fn and bio complete, which return
io success to application after one of the bio fail. The race as
following:

split bio(READ)          kworker

nvme_complete_rq
blk_update_request //split error=0
  bio_endio
    bio_integrity_endio
      queue_work(kintegrityd_wq, &bip->bip_work);

                         bio_integrity_verify_fn
                         bio_endio //split bio
                          __bio_chain_endio
                             if (!parent->bi_status)

                               <interrupt entry>
                               nvme_irq
                                 blk_update_request //parent error=7
                                 req_bio_endio
                                    bio->bi_status = 7 //parent bio
                               <interrupt exit>

                               parent->bi_status = 0
                        parent->bi_end_io() // return bi_status=0

The bio has been split as two: split and parent. When split
bio completed, it depends on kworker to do endio, while
bio_integrity_verify_fn have been interrupted by parent bio
complete irq handler. Then, parent bio->bi_status which have
been set in irq handler will overwrite by kworker.

In fact, even without the above race, we also need to conside
the concurrency beteen mulitple split bio complete and update
the same parent bi_status. Normally, multiple split bios will
be issued to the same hctx and complete from the same irq
vector. But if we have updated queue map between multiple split
bios, these bios may complete on different hw queue and different
irq vector. Then the concurrency update parent bi_status may
cause the final status error.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20210331115359.1125679-1-yuyufen@huawei.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 24704bc2ad6f..cb38d6f3acce 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -305,7 +305,7 @@ static struct bio *__bio_chain_endio(struct bio *bio)
 {
 	struct bio *parent = bio->bi_private;
 
-	if (!parent->bi_status)
+	if (bio->bi_status && !parent->bi_status)
 		parent->bi_status = bio->bi_status;
 	bio_put(bio);
 	return parent;
-- 
2.30.2

