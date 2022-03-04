Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A496A4CD872
	for <lists+linux-block@lfdr.de>; Fri,  4 Mar 2022 17:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiCDQEf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 4 Mar 2022 11:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiCDQEe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Mar 2022 11:04:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60E213D90E;
        Fri,  4 Mar 2022 08:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QQVlxFrmrrWNi3IoqP7GqjAW18JlQybNg4y9LNyfDyU=; b=sFw6O/bHTUm8R2CubCC4k0yNz2
        rGwvlRmyZN3HHJFoIC1Vg8/h8xB0E0vZ1zMf+Q/kbGmf7xZ/QAx+Ywxa8jb7zoszYnba0Ulwxq9JV
        QGrrI4Cuzu6g2ULwZHxX6QAvWNN+0YcoUl5fYqXax1AUUyn9Dqe3RHfYaflsibdXM5ldUAP/OthP7
        BKBr6m+Cscw7vzUJ4olljT4NkLyNIth6ZcVFp+4UCkRuAVhXVlObdZSfC+gQhkqZ1e0mk2l0QMfTg
        KYSFXCuo/Iizh/3kEuzuhLLr8PkyaHEmf+HyHo75G91ECMxdMKm7CbgEibn7WC48lKL/gUMZmPgRI
        j4nC7Q9Q==;
Received: from [2001:4bb8:180:5296:7360:567:acd5:aaa2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQAP2-00Atyx-WF; Fri, 04 Mar 2022 16:03:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 01/14] blk-mq: do not include passthrough requests in I/O accounting
Date:   Fri,  4 Mar 2022 17:03:18 +0100
Message-Id: <20220304160331.399757-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220304160331.399757-1-hch@lst.de>
References: <20220304160331.399757-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I/O accounting buckets I/O into the read/write/discard categories into
which passthrough I/O does not fit at all.  It also accounts to the
block_device, which may not even exist for passthrough I/O.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 11 ++++++++---
 block/blk.h    |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a05ce77250316..ab4b646551334 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -883,10 +883,15 @@ static inline void blk_account_io_done(struct request *req, u64 now)
 
 static void __blk_account_io_start(struct request *rq)
 {
-	/* passthrough requests can hold bios that do not have ->bi_bdev set */
-	if (rq->bio && rq->bio->bi_bdev)
+	/*
+	 * All non-passthrough requests are created from a bio with one
+	 * exception: when a flush command that is part of a flush sequence
+	 * generated by the state machine in blk-flush.c is cloned onto the
+	 * lower device by dm-multipath we can get here without a bio.
+	 */
+	if (rq->bio)
 		rq->part = rq->bio->bi_bdev;
-	else if (rq->q->disk)
+	else
 		rq->part = rq->q->disk->part0;
 
 	part_stat_lock();
diff --git a/block/blk.h b/block/blk.h
index ebaa59ca46ca6..6f21859c7f0ff 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -325,7 +325,7 @@ int blk_dev_init(void);
  */
 static inline bool blk_do_io_stat(struct request *rq)
 {
-	return (rq->rq_flags & RQF_IO_STAT) && rq->q->disk;
+	return (rq->rq_flags & RQF_IO_STAT) && !blk_rq_is_passthrough(rq);
 }
 
 void update_io_ticks(struct block_device *part, unsigned long now, bool end);
-- 
2.30.2

