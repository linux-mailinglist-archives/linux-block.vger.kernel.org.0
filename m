Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF5E78269F
	for <lists+linux-block@lfdr.de>; Mon, 21 Aug 2023 11:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjHUJ5h (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 21 Aug 2023 05:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjHUJ5g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Aug 2023 05:57:36 -0400
Received: from out-49.mta1.migadu.com (out-49.mta1.migadu.com [IPv6:2001:41d0:203:375::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2FFA9
        for <linux-block@vger.kernel.org>; Mon, 21 Aug 2023 02:57:35 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692611853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HTQQLcZjy5SOyzVREu6p8o8uUAQapiAefMRwTkFEijM=;
        b=N3xaoeoc/ub7B7aT+bcMxfGMMOZ4MaMCof7Tj9Fam2czFP1dDEkSYNQZPY6gFgtIn5PgbU
        4t6Xk1VOKTbfF7PROi3MAcfecOdsQ1dM3mtrRiDT1qHZ1da6wM1r2W0ahfSQW5CvfE8UmK
        Mn560Q2cidZVTJxkY1MukQ+s7n72wv4=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH 1/3] blk-mq: fix tags leak when shrink nr_hw_queues
Date:   Mon, 21 Aug 2023 17:56:00 +0800
Message-ID: <20230821095602.70742-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Although we don't need to realloc set->tags[] when shrink nr_hw_queues,
we need to free them. Or these tags will be leaked.

How to reproduce:
1. mount -t configfs configfs /mnt
2. modprobe null_blk nr_devices=0 submit_queues=8
3. mkdir /mnt/nullb/nullb0
4. echo 1 > /mnt/nullb/nullb0/power
5. echo 4 > /mnt/nullb/nullb0/submit_queues
6. rmdir /mnt/nullb/nullb0

In step 4, will alloc 9 tags (8 submit queues and 1 poll queue), then
in step 5, new_nr_hw_queues = 5 (4 submit queues and 1 poll queue).
At last in step 6, only these 5 tags are freed, the other 4 tags leaked.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f14b8669ac69..8af29a3b1400 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4386,9 +4386,13 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
 				       int new_nr_hw_queues)
 {
 	struct blk_mq_tags **new_tags;
+	int i;
 
-	if (set->nr_hw_queues >= new_nr_hw_queues)
+	if (set->nr_hw_queues >= new_nr_hw_queues) {
+		for (i = new_nr_hw_queues; i < set->nr_hw_queues; i++)
+			__blk_mq_free_map_and_rqs(set, i);
 		goto done;
+	}
 
 	new_tags = kcalloc_node(new_nr_hw_queues, sizeof(struct blk_mq_tags *),
 				GFP_KERNEL, set->numa_node);
-- 
2.41.0

