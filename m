Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABF91252E
	for <lists+linux-block@lfdr.de>; Fri,  3 May 2019 01:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfEBXeV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 2 May 2019 19:34:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52738 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfEBXeV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 May 2019 19:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=y3Z2JLe8Y2OukuGcH7zQg112MrhChQjE69dmfni0bko=; b=FNwL4caxgzrWqZIbHisa5sY+S/
        3eaVde+h09Yy2lNd9BrlSjti/w47Go+s+cebhshfq/XfjOTDenm8QpJtXpgkedhSk8NYaYqgydVZm
        hJS3Ux55gB1IIk533hvqGkIPHsYv8WLaq7GglKP7InhFg61HrxaI4Ro/QPLI6ra0NHWJ+oY1YSeEB
        MppcZFo2lmcOd7hwhRVfQ6kx7ErwF6/bisEivfwK17/xhBuAWUqsNdxZ3XAhKJr/9eG2OD1zUjRw9
        1FN1cs5xInVTyU6Jn86165lHyBhboceZYNeipWKoO/Wgh67SuUDRM2IBJh/1Qead/wlJtwDhjLRaD
        4OOGflJQ==;
Received: from [12.246.51.142] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMLDY-0002n5-LY; Thu, 02 May 2019 23:34:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 8/8] block: never take page references for ITER_BVEC
Date:   Thu,  2 May 2019 19:33:32 -0400
Message-Id: <20190502233332.28720-9-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502233332.28720-1-hch@lst.de>
References: <20190502233332.28720-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we pass pages through an iov_iter we always already have a reference
in the caller.  Thus remove the ITER_BVEC_FLAG_NO_REF and don't take
reference to pages by default for bvec backed iov_iters.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c          | 14 +-------------
 drivers/block/loop.c | 16 ++++------------
 fs/io_uring.c        |  3 ---
 include/linux/uio.h  |  8 --------
 4 files changed, 5 insertions(+), 36 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 3938e179a530..e999d530d863 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -846,15 +846,6 @@ int bio_add_page(struct bio *bio, struct page *page,
 }
 EXPORT_SYMBOL(bio_add_page);
 
-static void bio_get_pages(struct bio *bio)
-{
-	struct bvec_iter_all iter_all;
-	struct bio_vec *bvec;
-
-	bio_for_each_segment_all(bvec, bio, iter_all)
-		get_page(bvec->bv_page);
-}
-
 void bio_release_pages(struct bio *bio)
 {
 	struct bvec_iter_all iter_all;
@@ -967,11 +958,8 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 			ret = __bio_iov_iter_get_pages(bio, iter);
 	} while (!ret && iov_iter_count(iter) && !bio_full(bio));
 
-	if (iov_iter_bvec_no_ref(iter))
+	if (is_bvec)
 		bio_set_flag(bio, BIO_NO_PAGE_REF);
-	else if (is_bvec)
-		bio_get_pages(bio);
-
 	return bio->bi_vcnt ? 0 : ret;
 }
 
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 102d79575895..c20710e617c2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -264,20 +264,12 @@ lo_do_transfer(struct loop_device *lo, int cmd,
 	return ret;
 }
 
-static inline void loop_iov_iter_bvec(struct iov_iter *i,
-		unsigned int direction, const struct bio_vec *bvec,
-		unsigned long nr_segs, size_t count)
-{
-	iov_iter_bvec(i, direction, bvec, nr_segs, count);
-	i->type |= ITER_BVEC_FLAG_NO_REF;
-}
-
 static int lo_write_bvec(struct file *file, struct bio_vec *bvec, loff_t *ppos)
 {
 	struct iov_iter i;
 	ssize_t bw;
 
-	loop_iov_iter_bvec(&i, WRITE, bvec, 1, bvec->bv_len);
+	iov_iter_bvec(&i, WRITE, bvec, 1, bvec->bv_len);
 
 	file_start_write(file);
 	bw = vfs_iter_write(file, &i, ppos, 0);
@@ -355,7 +347,7 @@ static int lo_read_simple(struct loop_device *lo, struct request *rq,
 	ssize_t len;
 
 	rq_for_each_segment(bvec, rq, iter) {
-		loop_iov_iter_bvec(&i, READ, &bvec, 1, bvec.bv_len);
+		iov_iter_bvec(&i, READ, &bvec, 1, bvec.bv_len);
 		len = vfs_iter_read(lo->lo_backing_file, &i, &pos, 0);
 		if (len < 0)
 			return len;
@@ -396,7 +388,7 @@ static int lo_read_transfer(struct loop_device *lo, struct request *rq,
 		b.bv_offset = 0;
 		b.bv_len = bvec.bv_len;
 
-		loop_iov_iter_bvec(&i, READ, &b, 1, b.bv_len);
+		iov_iter_bvec(&i, READ, &b, 1, b.bv_len);
 		len = vfs_iter_read(lo->lo_backing_file, &i, &pos, 0);
 		if (len < 0) {
 			ret = len;
@@ -563,7 +555,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	}
 	atomic_set(&cmd->ref, 2);
 
-	loop_iov_iter_bvec(&iter, rw, bvec, nr_bvec, blk_rq_bytes(rq));
+	iov_iter_bvec(&iter, rw, bvec, nr_bvec, blk_rq_bytes(rq));
 	iter.iov_offset = offset;
 
 	cmd->iocb.ki_pos = pos;
diff --git a/fs/io_uring.c b/fs/io_uring.c
index f65f85d89217..f7eb63a5b3db 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -853,9 +853,6 @@ static int io_import_fixed(struct io_ring_ctx *ctx, int rw,
 	iov_iter_bvec(iter, rw, imu->bvec, imu->nr_bvecs, offset + len);
 	if (offset)
 		iov_iter_advance(iter, offset);
-
-	/* don't drop a reference to these pages */
-	iter->type |= ITER_BVEC_FLAG_NO_REF;
 	return 0;
 }
 
diff --git a/include/linux/uio.h b/include/linux/uio.h
index f184af1999a8..bace8fd40d0c 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -23,9 +23,6 @@ struct kvec {
 };
 
 enum iter_type {
-	/* set if ITER_BVEC doesn't hold a bv_page ref */
-	ITER_BVEC_FLAG_NO_REF = 2,
-
 	/* iter types */
 	ITER_IOVEC = 4,
 	ITER_KVEC = 8,
@@ -93,11 +90,6 @@ static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 	return i->type & (READ | WRITE);
 }
 
-static inline bool iov_iter_bvec_no_ref(const struct iov_iter *i)
-{
-	return (i->type & ITER_BVEC_FLAG_NO_REF) != 0;
-}
-
 /*
  * Total number of bytes covered by an iovec.
  *
-- 
2.20.1

