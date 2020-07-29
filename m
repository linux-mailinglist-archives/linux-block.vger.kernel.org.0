Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546F6231817
	for <lists+linux-block@lfdr.de>; Wed, 29 Jul 2020 05:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgG2D2y (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Jul 2020 23:28:54 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:33463 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726299AbgG2D2y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 23:28:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U47BqI9_1595993331;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U47BqI9_1595993331)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 Jul 2020 11:28:51 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, baolin.wang@linux.alibaba.com,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] block: Remove redundant blk_mq_sched_allow_merge() validation
Date:   Wed, 29 Jul 2020 11:28:34 +0800
Message-Id: <6137e782ccc9040bffd61895cc98cd12f2ccd549.1595987955.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1595987955.git.baolin.wang@linux.alibaba.com>
References: <cover.1595987955.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1595987955.git.baolin.wang@linux.alibaba.com>
References: <cover.1595987955.git.baolin.wang@linux.alibaba.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Only software queue and kyber IO scheduler will call blk_mq_bio_list_merge()
to merge a bio, and kyber IO scheduler did not implement the ops->allow_merge().
Thus we can remove the redundant blk_mq_sched_allow_merge() in
blk_mq_bio_list_merge() function.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-mq-sched.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index b8db72c..cc34f69 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -403,14 +403,10 @@ bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
 
 		switch (blk_try_merge(rq, bio)) {
 		case ELEVATOR_BACK_MERGE:
-			if (blk_mq_sched_allow_merge(q, rq, bio))
-				merged = bio_attempt_back_merge(rq, bio,
-						nr_segs);
+			merged = bio_attempt_back_merge(rq, bio, nr_segs);
 			break;
 		case ELEVATOR_FRONT_MERGE:
-			if (blk_mq_sched_allow_merge(q, rq, bio))
-				merged = bio_attempt_front_merge(rq, bio,
-						nr_segs);
+			merged = bio_attempt_front_merge(rq, bio, nr_segs);
 			break;
 		case ELEVATOR_DISCARD_MERGE:
 			merged = bio_attempt_discard_merge(q, rq, bio);
-- 
1.8.3.1

