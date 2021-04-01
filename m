Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51049350C95
	for <lists+linux-block@lfdr.de>; Thu,  1 Apr 2021 04:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbhDACVg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 31 Mar 2021 22:21:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52950 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232492AbhDACVD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Mar 2021 22:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617243662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KDza9GMR0g51Q4QW3D29i4jQKERkvxzcClCgUKEHYuk=;
        b=VN5Qv7xzVXmWd2RPdGNP0KUvrmUxnJGuK3YR5IMHKYF+2jY6/SrWHuFz0yByB5Rrg3FuFq
        7WD8dTz9q/upDpyhISgHSbt763XWVJDq82FA6IaW3DFmDup/hqlKKLfVeVRxt8LdpyKxxA
        D5uDUOsqUy42gxZ8Ky1unnYH8xOA76k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-q8oGcjNVPRCr7O7Fze8xgg-1; Wed, 31 Mar 2021 22:20:58 -0400
X-MC-Unique: q8oGcjNVPRCr7O7Fze8xgg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 538851853027;
        Thu,  1 Apr 2021 02:20:57 +0000 (UTC)
Received: from localhost (ovpn-12-93.pek2.redhat.com [10.72.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B600B23FC;
        Thu,  1 Apr 2021 02:20:44 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 04/12] block: add req flag of REQ_POLL_CTX
Date:   Thu,  1 Apr 2021 10:19:19 +0800
Message-Id: <20210401021927.343727-5-ming.lei@redhat.com>
In-Reply-To: <20210401021927.343727-1-ming.lei@redhat.com>
References: <20210401021927.343727-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add one req flag REQ_POLL_CTX which will be used in the following patch for
supporting bio based IO polling.

Exactly this flag can help us to do:

1) request flag is cloned in bio_fast_clone(), so if we mark one FS bio
as REQ_POLL_CTX, all bios cloned from this FS bio will be marked as
REQ_POLL_CTX too.

2) create per-task io polling context if the bio based queue supports
polling and the submitted bio is HIPRI. Per-task io poll context will be
created during submit_bio() before marking this HIPRI bio as REQ_POLL_CTX.
Then we can avoid to create such io polling context if one cloned bio with
REQ_POLL_CTX is submitted from another kernel context.

3) for supporting bio based io polling, we need to poll IOs from all
underlying queues of the bio device, this way help us to recognize which
IO needs to polled in bio based style, which will be applied in
following patch.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c          | 28 ++++++++++++++++++++++++++--
 include/linux/blk_types.h |  4 ++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 8a21a8c010a6..a777ba4fe06f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -840,11 +840,30 @@ static inline bool blk_queue_support_bio_poll(struct request_queue *q)
 static inline void blk_bio_poll_preprocess(struct request_queue *q,
 		struct bio *bio)
 {
+	bool mq;
+
 	if (!(bio->bi_opf & REQ_HIPRI))
 		return;
 
-	if (!blk_queue_poll(q) || (!queue_is_mq(q) && !blk_get_bio_poll_ctx()))
+	/*
+	 * Can't support bio based IO polling without per-task poll ctx
+	 *
+	 * We have created per-task io poll context, and mark this
+	 * bio as REQ_POLL_CTX, so: 1) if any cloned bio from this bio is
+	 * submitted from another kernel context, we won't create bio
+	 * poll context for it, and that bio can be completed by IRQ;
+	 * 2) If such bio is submitted from current context, we will
+	 * complete it via blk_poll(); 3) If driver knows that one
+	 * underlying bio allocated from driver is for FS bio, meantime
+	 * it is submitted in current context, driver can mark such bio
+	 * as REQ_HIPRI & REQ_POLL_CTX manually, so the bio can be completed
+	 * via blk_poll too.
+	 */
+	mq = queue_is_mq(q);
+	if (!blk_queue_poll(q) || (!mq && !blk_get_bio_poll_ctx()))
 		bio->bi_opf &= ~REQ_HIPRI;
+	else if (!mq)
+		bio->bi_opf |= REQ_POLL_CTX;
 }
 
 static noinline_for_stack bool submit_bio_checks(struct bio *bio)
@@ -900,7 +919,12 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 	if (unlikely(!current->io_context))
 		create_task_io_context(current, GFP_ATOMIC, q->node);
 
-	if (blk_queue_support_bio_poll(q) && (bio->bi_opf & REQ_HIPRI))
+	/*
+	 * If REQ_POLL_CTX isn't set for this HIPRI bio, we think it
+	 * originated from FS and allocate io polling context.
+	 */
+	if (blk_queue_support_bio_poll(q) && (bio->bi_opf & REQ_HIPRI) &&
+			!(bio->bi_opf & REQ_POLL_CTX))
 		blk_create_io_poll_context(q);
 
 	blk_bio_poll_preprocess(q, bio);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index db026b6ec15a..99160d588c2d 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -394,6 +394,9 @@ enum req_flag_bits {
 
 	__REQ_HIPRI,
 
+	/* for marking IOs originated from same FS bio in same context */
+	__REQ_POLL_CTX,
+
 	/* for driver use */
 	__REQ_DRV,
 	__REQ_SWAP,		/* swapping request. */
@@ -418,6 +421,7 @@ enum req_flag_bits {
 
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
 #define REQ_HIPRI		(1ULL << __REQ_HIPRI)
+#define REQ_POLL_CTX			(1ULL << __REQ_POLL_CTX)
 
 #define REQ_DRV			(1ULL << __REQ_DRV)
 #define REQ_SWAP		(1ULL << __REQ_SWAP)
-- 
2.29.2

