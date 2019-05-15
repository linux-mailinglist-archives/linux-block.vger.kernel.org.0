Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3887B1E707
	for <lists+linux-block@lfdr.de>; Wed, 15 May 2019 05:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfEODDd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 14 May 2019 23:03:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfEODDd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 May 2019 23:03:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0784D81F1B;
        Wed, 15 May 2019 03:03:33 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE5775C1A3;
        Wed, 15 May 2019 03:03:29 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 2/3] block: don't protect generic_make_request_checks with blk_queue_enter
Date:   Wed, 15 May 2019 11:03:09 +0800
Message-Id: <20190515030310.20393-3-ming.lei@redhat.com>
In-Reply-To: <20190515030310.20393-1-ming.lei@redhat.com>
References: <20190515030310.20393-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 15 May 2019 03:03:33 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now a063057d7c73 ("block: Fix a race between request queue removal and
the block cgroup controller") has been reverted, and blkcg_exit_queue()
won't be called in blk_cleanup_queue() any more.

So don't need to protect generic_make_request_checks() with
blk_queue_enter(), then the total mess can be cleaned.

37f9579f4c31 ("blk-mq: Avoid that submitting a bio concurrently with device
removal triggers a crash") is reverted.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 37 ++++++-------------------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2af1e54870e6..bca63e545f05 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -956,22 +956,8 @@ blk_qc_t generic_make_request(struct bio *bio)
 	 * yet.
 	 */
 	struct bio_list bio_list_on_stack[2];
-	blk_mq_req_flags_t flags = 0;
-	struct request_queue *q = bio->bi_disk->queue;
 	blk_qc_t ret = BLK_QC_T_NONE;
 
-	if (bio->bi_opf & REQ_NOWAIT)
-		flags = BLK_MQ_REQ_NOWAIT;
-	if (bio_flagged(bio, BIO_QUEUE_ENTERED))
-		blk_queue_enter_live(q);
-	else if (blk_queue_enter(q, flags) < 0) {
-		if (!blk_queue_dying(q) && (bio->bi_opf & REQ_NOWAIT))
-			bio_wouldblock_error(bio);
-		else
-			bio_io_error(bio);
-		return ret;
-	}
-
 	if (!generic_make_request_checks(bio))
 		goto out;
 
@@ -1008,22 +994,11 @@ blk_qc_t generic_make_request(struct bio *bio)
 	bio_list_init(&bio_list_on_stack[0]);
 	current->bio_list = bio_list_on_stack;
 	do {
-		bool enter_succeeded = true;
-
-		if (unlikely(q != bio->bi_disk->queue)) {
-			if (q)
-				blk_queue_exit(q);
-			q = bio->bi_disk->queue;
-			flags = 0;
-			if (bio->bi_opf & REQ_NOWAIT)
-				flags = BLK_MQ_REQ_NOWAIT;
-			if (blk_queue_enter(q, flags) < 0) {
-				enter_succeeded = false;
-				q = NULL;
-			}
-		}
+		struct request_queue *q = bio->bi_disk->queue;
+		blk_mq_req_flags_t flags = bio->bi_opf & REQ_NOWAIT ?
+			BLK_MQ_REQ_NOWAIT : 0;
 
-		if (enter_succeeded) {
+		if (likely(blk_queue_enter(q, flags) == 0)) {
 			struct bio_list lower, same;
 
 			/* Create a fresh bio_list for all subordinate requests */
@@ -1031,6 +1006,8 @@ blk_qc_t generic_make_request(struct bio *bio)
 			bio_list_init(&bio_list_on_stack[0]);
 			ret = q->make_request_fn(q, bio);
 
+			blk_queue_exit(q);
+
 			/* sort new bios into those for a lower level
 			 * and those for the same level
 			 */
@@ -1057,8 +1034,6 @@ blk_qc_t generic_make_request(struct bio *bio)
 	current->bio_list = NULL; /* deactivate */
 
 out:
-	if (q)
-		blk_queue_exit(q);
 	return ret;
 }
 EXPORT_SYMBOL(generic_make_request);
-- 
2.20.1

