Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1907361AB
	for <lists+linux-block@lfdr.de>; Tue, 20 Jun 2023 04:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjFTC4f (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 19 Jun 2023 22:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFTC4e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2023 22:56:34 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFA210C8
        for <linux-block@vger.kernel.org>; Mon, 19 Jun 2023 19:56:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QlWVZ5w3vz4f4PWS
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 10:56:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLBUFZFk5hRpMA--.62381S4;
        Tue, 20 Jun 2023 10:56:22 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
        virtualization@lists.linux-foundation.org,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, houtao1@huawei.com
Subject: [PATCH] virtio_pmem: do flush synchronously
Date:   Tue, 20 Jun 2023 11:28:38 +0800
Message-Id: <20230620032838.1598793-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLBUFZFk5hRpMA--.62381S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJF48Ar1DXrWUKw18AF15CFg_yoW5AFy3pr
        90gay3Kr4UGFs3Canrta1UKFyfZa1kGFZrWFWruw4xAFZFyF1DKw1UXa4Fqa45tryrGFW7
        XFWkJw1jqa47AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
        Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

The following warning was reported when doing fsync on a pmem device:

 ------------[ cut here ]------------
 WARNING: CPU: 2 PID: 384 at block/blk-core.c:751 submit_bio_noacct+0x340/0x520
 Modules linked in:
 CPU: 2 PID: 384 Comm: mkfs.xfs Not tainted 6.4.0-rc7+ #154
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
 RIP: 0010:submit_bio_noacct+0x340/0x520
 ......
 Call Trace:
  <TASK>
  ? asm_exc_invalid_op+0x1b/0x20
  ? submit_bio_noacct+0x340/0x520
  ? submit_bio_noacct+0xd5/0x520
  submit_bio+0x37/0x60
  async_pmem_flush+0x79/0xa0
  nvdimm_flush+0x17/0x40
  pmem_submit_bio+0x370/0x390
  __submit_bio+0xbc/0x190
  submit_bio_noacct_nocheck+0x14d/0x370
  submit_bio_noacct+0x1ef/0x520
  submit_bio+0x55/0x60
  submit_bio_wait+0x5a/0xc0
  blkdev_issue_flush+0x44/0x60

The root cause is that submit_bio_noacct() needs bio_op() is either
WRITE or ZONE_APPEND for flush bio and async_pmem_flush() doesn't assign
REQ_OP_WRITE when allocating flush bio.

The reason for allocating a new flush bio is to execute the flush
command asynchrously and doesn't want to block the original submit_bio()
invocation. However the original submit_bio() will be blocked anyway,
because the nested submit_bio() for the flush bio just places the flush
bio in current->bio_list and the original submit_bio() only returns
after submitting all bio in bio_list.

So just removing the allocation of new flush bio and do synchronous
flush directly.

Fixes: b4a6bb3a67aa ("block: add a sanity check for non-write flush/fua bios")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
Hi Jens & Dan,

I found Pankaj was working on the optimization of virtio-pmem flush bio
[0], but considering the last status update was 1/12/2022, so could you
please pick the patch up for v6.7 and we can do the flush optimization
later ?

[0]: https://lore.kernel.org/lkml/20220111161937.56272-1-pankaj.gupta.linux@gmail.com/T/

 drivers/nvdimm/nd_virtio.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index c6a648fd8744..a7d510f446e0 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -100,22 +100,6 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 /* The asynchronous flush callback function */
 int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
 {
-	/*
-	 * Create child bio for asynchronous flush and chain with
-	 * parent bio. Otherwise directly call nd_region flush.
-	 */
-	if (bio && bio->bi_iter.bi_sector != -1) {
-		struct bio *child = bio_alloc(bio->bi_bdev, 0, REQ_PREFLUSH,
-					      GFP_ATOMIC);
-
-		if (!child)
-			return -ENOMEM;
-		bio_clone_blkg_association(child, bio);
-		child->bi_iter.bi_sector = -1;
-		bio_chain(child, bio);
-		submit_bio(child);
-		return 0;
-	}
 	if (virtio_pmem_flush(nd_region))
 		return -EIO;
 
-- 
2.29.2

