Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3FF7143B3D
	for <lists+linux-block@lfdr.de>; Tue, 21 Jan 2020 11:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgAUKml (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 21 Jan 2020 05:42:41 -0500
Received: from relay.sw.ru ([185.231.240.75]:57226 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728831AbgAUKml (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jan 2020 05:42:41 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104] helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1itqzP-0006P9-Ja; Tue, 21 Jan 2020 13:42:31 +0300
Subject: [PATCH v4 2/7] block: Pass op_flags into blk_queue_get_max_sectors()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, bob.liu@oracle.com, axboe@kernel.dk,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        Chaitanya.Kulkarni@wdc.com, darrick.wong@oracle.com,
        ming.lei@redhat.com, osandov@fb.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        chaitanya.kulkarni@wdc.com, bvanassche@acm.org,
        dhowells@redhat.com, asml.silence@gmail.com, ktkhai@virtuozzo.com
Date:   Tue, 21 Jan 2020 13:42:31 +0300
Message-ID: <157960335141.108120.13282906580976004888.stgit@localhost.localdomain>
In-Reply-To: <157960325642.108120.13626623438131044304.stgit@localhost.localdomain>
References: <157960325642.108120.13626623438131044304.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This preparation patch changes argument type, and now
the function takes full op_flags instead of just op code.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 block/blk-core.c       |    4 ++--
 include/linux/blkdev.h |    8 +++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 50a5de025d5e..ac2634bcda1f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1250,10 +1250,10 @@ EXPORT_SYMBOL(submit_bio);
 static int blk_cloned_rq_check_limits(struct request_queue *q,
 				      struct request *rq)
 {
-	if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, req_op(rq))) {
+	if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, rq->cmd_flags)) {
 		printk(KERN_ERR "%s: over max size limit. (%u > %u)\n",
 			__func__, blk_rq_sectors(rq),
-			blk_queue_get_max_sectors(q, req_op(rq)));
+			blk_queue_get_max_sectors(q, rq->cmd_flags));
 		return -EIO;
 	}
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0f1127d0b043..23a5850f35f6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -989,8 +989,10 @@ static inline struct bio_vec req_bvec(struct request *rq)
 }
 
 static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
-						     int op)
+						     unsigned int op_flags)
 {
+	int op = op_flags & REQ_OP_MASK;
+
 	if (unlikely(op == REQ_OP_DISCARD || op == REQ_OP_SECURE_ERASE))
 		return min(q->limits.max_discard_sectors,
 			   UINT_MAX >> SECTOR_SHIFT);
@@ -1029,10 +1031,10 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
 	if (!q->limits.chunk_sectors ||
 	    req_op(rq) == REQ_OP_DISCARD ||
 	    req_op(rq) == REQ_OP_SECURE_ERASE)
-		return blk_queue_get_max_sectors(q, req_op(rq));
+		return blk_queue_get_max_sectors(q, rq->cmd_flags);
 
 	return min(blk_max_size_offset(q, offset),
-			blk_queue_get_max_sectors(q, req_op(rq)));
+			blk_queue_get_max_sectors(q, rq->cmd_flags));
 }
 
 static inline unsigned int blk_rq_count_bios(struct request *rq)


