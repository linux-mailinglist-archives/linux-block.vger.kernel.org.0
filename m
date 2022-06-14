Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4285254ACF1
	for <lists+linux-block@lfdr.de>; Tue, 14 Jun 2022 11:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242985AbiFNJKA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 14 Jun 2022 05:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351197AbiFNJJ6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 05:09:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4060A40A16
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 02:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6sMaAlVsc/iZlKKSIsbFVmTUCNZbHnyP1/iODlYDZbQ=; b=dqDymwYlznGKKk53A6BCDplbqt
        NaJTWuykH5Pwi6ouG9591Z9td2pwSsgzmApXtBAKQyIQSCaYbeSiEe8R7iB5WkUmxoYuQMPTdMqA5
        3qOZo/KMBMziBIR8HNyE3EUrPf+I4DjynbfAKnQCJKWLabU0mbgp4IZ1q8WlTpx+9FBQNT0GH/9vO
        Pt6pZiwiag/6re6IZarIVgUwjQjjwre8bgLDcxrVLg64g0eO8doKMiJhOr1il8U5F6qMOF+1t9RzF
        rWn68NiCqB0EqKWK8y7ixBY2qzapG6rxltd/qcRI/AgquGoVUkNj1F0mSKXvxZbP9bwPjtLvyJX+a
        71/w/QyQ==;
Received: from [2001:4bb8:180:36f6:1fed:6d48:cf16:d13c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o12Yd-008Zl3-In; Tue, 14 Jun 2022 09:09:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 6/6] block: move blk_queue_get_max_sectors to blk.h
Date:   Tue, 14 Jun 2022 11:09:34 +0200
Message-Id: <20220614090934.570632-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220614090934.570632-1-hch@lst.de>
References: <20220614090934.570632-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_queue_get_max_sectors is private to the block layer, so move it out
of blkdev.h.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h            | 13 +++++++++++++
 include/linux/blkdev.h | 13 -------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 434017701403f..8e79296ee97a2 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -159,6 +159,19 @@ static inline bool blk_discard_mergable(struct request *req)
 	return false;
 }
 
+static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
+						     int op)
+{
+	if (unlikely(op == REQ_OP_DISCARD || op == REQ_OP_SECURE_ERASE))
+		return min(q->limits.max_discard_sectors,
+			   UINT_MAX >> SECTOR_SHIFT);
+
+	if (unlikely(op == REQ_OP_WRITE_ZEROES))
+		return q->limits.max_write_zeroes_sectors;
+
+	return q->limits.max_sectors;
+}
+
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 void blk_flush_integrity(void);
 bool __bio_integrity_endio(struct bio *);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 05e60ee269d91..5ef2f061feb08 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -920,19 +920,6 @@ static inline unsigned int bio_zone_is_seq(struct bio *bio)
 }
 #endif /* CONFIG_BLK_DEV_ZONED */
 
-static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
-						     int op)
-{
-	if (unlikely(op == REQ_OP_DISCARD || op == REQ_OP_SECURE_ERASE))
-		return min(q->limits.max_discard_sectors,
-			   UINT_MAX >> SECTOR_SHIFT);
-
-	if (unlikely(op == REQ_OP_WRITE_ZEROES))
-		return q->limits.max_write_zeroes_sectors;
-
-	return q->limits.max_sectors;
-}
-
 /*
  * Return how much of the chunk is left to be used for I/O at a given offset.
  */
-- 
2.30.2

