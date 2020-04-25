Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EB01B8800
	for <lists+linux-block@lfdr.de>; Sat, 25 Apr 2020 19:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgDYRJy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 25 Apr 2020 13:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726177AbgDYRJy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Apr 2020 13:09:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248B5C09B04D
        for <linux-block@vger.kernel.org>; Sat, 25 Apr 2020 10:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UtWavAobnnQnQUbQorSVYwQDQWRO1X5A24RowNDNgVU=; b=UAocA4us/+SCctnHokskbrVws0
        pizveHsEQPHp5vH1TkmW6Ahcy9adGvUpy4nkZaXT0NzWSVgo3M+Q6Mfn+mriqddFSwXWIoHu3hO2M
        qfS//JAaxPeCgY+znK6zCnFOh1R0OnO8baim7Ai7ljUz6o5vWDJLzEQRWjUx0SHTkuE6Q6VSXoHyS
        /2JpPloqqDMHAdDKvaMyw5Wzh5KSmZ88gnyFTZgLB7IuMkSU25EU4f9SvUdtwW9fOF1pa91LWlHdB
        rhacG0cmB0VBKONLN9WZOpThQWcC8STA5CO5gtczocIE7wJuNEbeX0uU739lxFehp/pHhRON2K+ra
        qh1kQzEw==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSOJN-0001j3-M0; Sat, 25 Apr 2020 17:09:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 03/11] block: replace BIO_QUEUE_ENTERED with BIO_CGROUP_ACCT
Date:   Sat, 25 Apr 2020 19:09:36 +0200
Message-Id: <20200425170944.968861-4-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200425170944.968861-1-hch@lst.de>
References: <20200425170944.968861-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

BIO_QUEUE_ENTERED is only used for cgroup accounting now, so rename
the flag and move setting it into the cgroup code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c          | 10 ----------
 include/linux/blk-cgroup.h | 10 ++++++----
 include/linux/blk_types.h  |  2 +-
 3 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index c49eb3bdd0be8..a04e991b5ded9 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -336,16 +336,6 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
 		/* there isn't chance to merge the splitted bio */
 		split->bi_opf |= REQ_NOMERGE;
 
-		/*
-		 * Since we're recursing into make_request here, ensure
-		 * that we mark this bio as already having entered the queue.
-		 * If not, and the queue is going away, we can get stuck
-		 * forever on waiting for the queue reference to drop. But
-		 * that will never happen, as we're already holding a
-		 * reference to it.
-		 */
-		bio_set_flag(*bio, BIO_QUEUE_ENTERED);
-
 		bio_chain(split, *bio);
 		trace_block_split(q, split, (*bio)->bi_iter.bi_sector);
 		generic_make_request(*bio);
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 35f8ffe92b702..4deb8bb7b6afa 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -607,12 +607,14 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 		u64_stats_update_begin(&bis->sync);
 
 		/*
-		 * If the bio is flagged with BIO_QUEUE_ENTERED it means this
-		 * is a split bio and we would have already accounted for the
-		 * size of the bio.
+		 * If the bio is flagged with BIO_CGROUP_ACCT it means this is a
+		 * split bio and we would have already accounted for the size of
+		 * the bio.
 		 */
-		if (!bio_flagged(bio, BIO_QUEUE_ENTERED))
+		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
+			bio_set_flag(bio, BIO_CGROUP_ACCT);
 			bis->cur.bytes[rwd] += bio->bi_iter.bi_size;
+		}
 		bis->cur.ios[rwd]++;
 
 		u64_stats_update_end(&bis->sync);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 31eb92876be7c..431e59d05550f 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -220,7 +220,7 @@ enum {
 				 * throttling rules. Don't do it again. */
 	BIO_TRACE_COMPLETION,	/* bio_endio() should trace the final completion
 				 * of this bio. */
-	BIO_QUEUE_ENTERED,	/* can use blk_queue_enter_live() */
+	BIO_CGROUP_ACCT,		/* has been accounted to a cgroup */
 	BIO_TRACKED,		/* set if bio goes through the rq_qos path */
 	BIO_FLAG_LAST
 };
-- 
2.26.1

