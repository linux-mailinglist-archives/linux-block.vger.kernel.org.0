Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0AD3E5129
	for <lists+linux-block@lfdr.de>; Tue, 10 Aug 2021 04:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbhHJCwm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 9 Aug 2021 22:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21235 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232968AbhHJCwl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Aug 2021 22:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628563939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fPS24zQtD5ukmY7OUfjzRLEB76LF1GkMpwYhbqWcREo=;
        b=JiLVphvPnXbPw1nS/vDyil+IxDEP/bNEyrLyzSW00ph0Xe14rWR9fJimQIPOpDikhqLu+e
        rCDL5715M32bNfj2Jbv9l0mjyr2IVsO7pYHivE/4YNzM5QgiadBMsK5dj0rs3TT9YZGzLt
        +Y73XngSS5tRheuERCUSTs/TPa8Wwrw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-dIosHQAcPiGmnP1T9rn8Jw-1; Mon, 09 Aug 2021 22:52:18 -0400
X-MC-Unique: dIosHQAcPiGmnP1T9rn8Jw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 494AC801AE7;
        Tue, 10 Aug 2021 02:52:17 +0000 (UTC)
Received: from localhost (ovpn-13-190.pek2.redhat.com [10.72.13.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6651A60BF1;
        Tue, 10 Aug 2021 02:52:11 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: [PATCH V2 1/1] block: return ELEVATOR_DISCARD_MERGE if possible
Date:   Tue, 10 Aug 2021 10:52:07 +0800
Message-Id: <20210810025207.438057-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When merging one bio to request, if they are discard IO and the queue
supports multi-range discard, we need to return ELEVATOR_DISCARD_MERGE
because both block core and related drivers(nvme, virtio-blk) can't
handle mixed discard io merge(traditional IO merge together with
discard merge) well.

Fix the issue by trying to return ELEVATOR_DISCARD_MERGE first in this
situation, so both blk-mq and drivers just need to handle multi-range discard.

In theory, the fixes should be 1e739730c5b9 ("block: optionally merge
discontiguous discard bios into a single request"). The reason why it
isn't be triggered before 2705dfb20947 ("block: fix discard request merge")
is that the nr_segment of each bio is exactly 1 for multi-range device.

Fixes: 2705dfb20947 ("block: fix discard request merge")
Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bfq-iosched.c      |  3 +++
 block/blk-merge.c        | 16 ----------------
 block/elevator.c         |  3 +++
 block/mq-deadline-main.c |  2 ++
 include/linux/blkdev.h   | 16 ++++++++++++++++
 5 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 727955918563..673a634eadd9 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2361,6 +2361,9 @@ static int bfq_request_merge(struct request_queue *q, struct request **req,
 	__rq = bfq_find_rq_fmerge(bfqd, bio, q);
 	if (__rq && elv_bio_merge_ok(__rq, bio)) {
 		*req = __rq;
+
+		if (blk_discard_mergable(__rq))
+			return ELEVATOR_DISCARD_MERGE;
 		return ELEVATOR_FRONT_MERGE;
 	}
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index a11b3b53717e..f8707ff7e2fc 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -705,22 +705,6 @@ static void blk_account_io_merge_request(struct request *req)
 	}
 }
 
-/*
- * Two cases of handling DISCARD merge:
- * If max_discard_segments > 1, the driver takes every bio
- * as a range and send them to controller together. The ranges
- * needn't to be contiguous.
- * Otherwise, the bios/requests will be handled as same as
- * others which should be contiguous.
- */
-static inline bool blk_discard_mergable(struct request *req)
-{
-	if (req_op(req) == REQ_OP_DISCARD &&
-	    queue_max_discard_segments(req->q) > 1)
-		return true;
-	return false;
-}
-
 static enum elv_merge blk_try_req_merge(struct request *req,
 					struct request *next)
 {
diff --git a/block/elevator.c b/block/elevator.c
index 52ada14cfe45..a5fe2615ec0f 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -336,6 +336,9 @@ enum elv_merge elv_merge(struct request_queue *q, struct request **req,
 	__rq = elv_rqhash_find(q, bio->bi_iter.bi_sector);
 	if (__rq && elv_bio_merge_ok(__rq, bio)) {
 		*req = __rq;
+
+		if (blk_discard_mergable(__rq))
+			return ELEVATOR_DISCARD_MERGE;
 		return ELEVATOR_BACK_MERGE;
 	}
 
diff --git a/block/mq-deadline-main.c b/block/mq-deadline-main.c
index 6f612e6dc82b..294be0c0db65 100644
--- a/block/mq-deadline-main.c
+++ b/block/mq-deadline-main.c
@@ -677,6 +677,8 @@ static int dd_request_merge(struct request_queue *q, struct request **rq,
 
 		if (elv_bio_merge_ok(__rq, bio)) {
 			*rq = __rq;
+			if (blk_discard_mergable(__rq))
+				return ELEVATOR_DISCARD_MERGE;
 			return ELEVATOR_FRONT_MERGE;
 		}
 	}
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3177181c4326..87f00292fd7a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1521,6 +1521,22 @@ static inline int queue_limit_discard_alignment(struct queue_limits *lim, sector
 	return offset << SECTOR_SHIFT;
 }
 
+/*
+ * Two cases of handling DISCARD merge:
+ * If max_discard_segments > 1, the driver takes every bio
+ * as a range and send them to controller together. The ranges
+ * needn't to be contiguous.
+ * Otherwise, the bios/requests will be handled as same as
+ * others which should be contiguous.
+ */
+static inline bool blk_discard_mergable(struct request *req)
+{
+	if (req_op(req) == REQ_OP_DISCARD &&
+	    queue_max_discard_segments(req->q) > 1)
+		return true;
+	return false;
+}
+
 static inline int bdev_discard_alignment(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
-- 
2.31.1

