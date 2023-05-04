Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE596F6C47
	for <lists+linux-block@lfdr.de>; Thu,  4 May 2023 14:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjEDMtv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 4 May 2023 08:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjEDMtt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2023 08:49:49 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2336A60;
        Thu,  4 May 2023 05:49:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QBttk5vflz4f3jq5;
        Thu,  4 May 2023 20:49:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbHdqVNkzuf5Ig--.27873S5;
        Thu, 04 May 2023 20:49:36 +0800 (CST)
From:   linan666@huaweicloud.com
To:     axboe@kernel.dk, linan122@huawei.com, vishal.l.verma@intel.com,
        dan.j.williams@intel.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v2 01/11] block/badblocks: change some members of badblocks to bool
Date:   Thu,  4 May 2023 20:48:18 +0800
Message-Id: <20230504124828.679770-2-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230504124828.679770-1-linan666@huaweicloud.com>
References: <20230504124828.679770-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbHdqVNkzuf5Ig--.27873S5
X-Coremail-Antispam: 1UD129KBjvJXoWxAw45KFW3uryUXw4DGF45KFg_yoW5XF1UpF
        nxGwnayr4jgr1vqF1DZ3W7Aw109w4xJF48J3y7Jw15K34Utwn7ta4kXryrtFWjqr4a9FsI
        vF1FgrWjvry8C3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUm0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrV
        ACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWU
        JVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2
        ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
        AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
        2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
        C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVj
        vjDU0xZFpf9x07jbjjgUUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Li Nan <linan122@huawei.com>

"changed" and "unacked_exist" are used as boolean type. Change the type
of them to bool. And reorder fields to reduce memory hole.

No functional changed intended.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/badblocks.c         | 14 +++++++-------
 include/linux/badblocks.h | 10 +++++-----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 3afb550c0f7b..1b4caa42c5f1 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -141,7 +141,7 @@ static void badblocks_update_acked(struct badblocks *bb)
 	}
 
 	if (!unacked)
-		bb->unacked_exist = 0;
+		bb->unacked_exist = false;
 }
 
 /**
@@ -302,9 +302,9 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 		}
 	}
 
-	bb->changed = 1;
+	bb->changed = true;
 	if (!acknowledged)
-		bb->unacked_exist = 1;
+		bb->unacked_exist = true;
 	else
 		badblocks_update_acked(bb);
 	write_sequnlock_irqrestore(&bb->lock, flags);
@@ -414,7 +414,7 @@ int badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
 	}
 
 	badblocks_update_acked(bb);
-	bb->changed = 1;
+	bb->changed = true;
 out:
 	write_sequnlock_irq(&bb->lock);
 	return rv;
@@ -435,7 +435,7 @@ void ack_all_badblocks(struct badblocks *bb)
 		return;
 	write_seqlock_irq(&bb->lock);
 
-	if (bb->changed == 0 && bb->unacked_exist) {
+	if (bb->changed == false && bb->unacked_exist) {
 		u64 *p = bb->page;
 		int i;
 
@@ -447,7 +447,7 @@ void ack_all_badblocks(struct badblocks *bb)
 				p[i] = BB_MAKE(start, len, 1);
 			}
 		}
-		bb->unacked_exist = 0;
+		bb->unacked_exist = false;
 	}
 	write_sequnlock_irq(&bb->lock);
 }
@@ -493,7 +493,7 @@ ssize_t badblocks_show(struct badblocks *bb, char *page, int unack)
 				length << bb->shift);
 	}
 	if (unack && len == 0)
-		bb->unacked_exist = 0;
+		bb->unacked_exist = false;
 
 	if (read_seqretry(&bb->lock, seq))
 		goto retry;
diff --git a/include/linux/badblocks.h b/include/linux/badblocks.h
index 2426276b9bd3..c2723f97d22d 100644
--- a/include/linux/badblocks.h
+++ b/include/linux/badblocks.h
@@ -27,15 +27,15 @@
 struct badblocks {
 	struct device *dev;	/* set by devm_init_badblocks */
 	int count;		/* count of bad blocks */
-	int unacked_exist;	/* there probably are unacknowledged
-				 * bad blocks.  This is only cleared
-				 * when a read discovers none
-				 */
 	int shift;		/* shift from sectors to block size
 				 * a -ve shift means badblocks are
 				 * disabled.*/
+	bool unacked_exist;	/* there probably are unacknowledged
+				 * bad blocks.  This is only cleared
+				 * when a read discovers none
+				 */
+	bool changed;
 	u64 *page;		/* badblock list */
-	int changed;
 	seqlock_t lock;
 	sector_t sector;
 	sector_t size;		/* in sectors */
-- 
2.31.1

