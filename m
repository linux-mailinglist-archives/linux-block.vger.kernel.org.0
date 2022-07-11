Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABE5560D60
	for <lists+linux-block@lfdr.de>; Thu, 30 Jun 2022 01:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiF2Xcb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 Jun 2022 19:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiF2Xca (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:30 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B93B01
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:29 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id jb13so15477804plb.9
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7DfLTEMn3Ih7dDFf6gpUT3BfxogY91v1jzIyEti14TI=;
        b=Qa/sbv8qeGA1YP0eAZVGdE7SQETBGmZW/EUIdrr50eJiuKuVEgExGP3KhsYoaGoouH
         AzPwMnZRpmlCuu9pS251Lx6O85BCjixCtWkZ4WQMwHdChfUdyEMO6LXiom8y9kA/+eZu
         mBUbAWN5VMSwvDVrsqrz7mSmIjmEG5F3euhE/D0OyAfeId521QVQ5NVhTzP9GYnsQNoN
         D+8osw+0A1+BGg4xMF1zYncfsRAT/tGnD7hlVeHQqO3/l//srTQr+c0I5ggi84P3DOnL
         D5SoKcMz6SUVqIkpy1YGXbq1NfjMk9lZ2nIi1bqJ1V6Z2MrRn2EXGYjkwTwrAM2dZwAa
         CsEg==
X-Gm-Message-State: AJIora/9srtC5o7nfR8TczmDle5czqHIaWAFQ/a3AkY9zg1z5O6uo5kh
        CVEeGvm1mWgwRGB4PZrtuPA=
X-Google-Smtp-Source: AGRyM1vqendlvdkPQSf+TTethA/QX91PXYde8E7m+73U6JJErgPUbPyxaoTIzGZkKCoYa4XbihrQwg==
X-Received: by 2002:a17:903:10c:b0:16a:1166:4ee9 with SMTP id y12-20020a170903010c00b0016a11664ee9mr11203312plc.138.1656545549367;
        Wed, 29 Jun 2022 16:32:29 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:28 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v2 23/63] dm/core: Combine request operation type and flags
Date:   Wed, 29 Jun 2022 16:31:05 -0700
Message-Id: <20220629233145.2779494-24-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve kernel code uniformity by combining the request operation type and
flags into a single variable. Change 'int rw' into 'enum req_op op' because
the name 'op' is what is used in the block layer to hold a request type.
Use the blk_opf_t and enum req_op types where appropriate to improve static
type checking.

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/dm-bufio.c | 19 ++++++++++---------
 drivers/md/dm-io.c    | 36 +++++++++++++++++-------------------
 drivers/md/dm.c       | 10 +++++-----
 3 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 1b7acda45c78..dc01ce33265b 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -577,12 +577,12 @@ static void dmio_complete(unsigned long error, void *context)
 	b->end_io(b, unlikely(error != 0) ? BLK_STS_IOERR : 0);
 }
 
-static void use_dmio(struct dm_buffer *b, int rw, sector_t sector,
+static void use_dmio(struct dm_buffer *b, enum req_op op, sector_t sector,
 		     unsigned n_sectors, unsigned offset)
 {
 	int r;
 	struct dm_io_request io_req = {
-		.bi_opf = rw,
+		.bi_opf = op,
 		.notify.fn = dmio_complete,
 		.notify.context = b,
 		.client = b->c->dm_io,
@@ -615,7 +615,7 @@ static void bio_complete(struct bio *bio)
 	b->end_io(b, status);
 }
 
-static void use_bio(struct dm_buffer *b, int rw, sector_t sector,
+static void use_bio(struct dm_buffer *b, enum req_op op, sector_t sector,
 		    unsigned n_sectors, unsigned offset)
 {
 	struct bio *bio;
@@ -629,10 +629,10 @@ static void use_bio(struct dm_buffer *b, int rw, sector_t sector,
 	bio = bio_kmalloc(vec_size, GFP_NOWAIT | __GFP_NORETRY | __GFP_NOWARN);
 	if (!bio) {
 dmio:
-		use_dmio(b, rw, sector, n_sectors, offset);
+		use_dmio(b, op, sector, n_sectors, offset);
 		return;
 	}
-	bio_init(bio, b->c->bdev, bio->bi_inline_vecs, vec_size, rw);
+	bio_init(bio, b->c->bdev, bio->bi_inline_vecs, vec_size, op);
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_end_io = bio_complete;
 	bio->bi_private = b;
@@ -668,7 +668,8 @@ static inline sector_t block_to_sector(struct dm_bufio_client *c, sector_t block
 	return sector;
 }
 
-static void submit_io(struct dm_buffer *b, int rw, void (*end_io)(struct dm_buffer *, blk_status_t))
+static void submit_io(struct dm_buffer *b, enum req_op op,
+		      void (*end_io)(struct dm_buffer *, blk_status_t))
 {
 	unsigned n_sectors;
 	sector_t sector;
@@ -678,7 +679,7 @@ static void submit_io(struct dm_buffer *b, int rw, void (*end_io)(struct dm_buff
 
 	sector = block_to_sector(b->c, b->block);
 
-	if (rw != REQ_OP_WRITE) {
+	if (op != REQ_OP_WRITE) {
 		n_sectors = b->c->block_size >> SECTOR_SHIFT;
 		offset = 0;
 	} else {
@@ -697,9 +698,9 @@ static void submit_io(struct dm_buffer *b, int rw, void (*end_io)(struct dm_buff
 	}
 
 	if (b->data_mode != DATA_MODE_VMALLOC)
-		use_bio(b, rw, sector, n_sectors, offset);
+		use_bio(b, op, sector, n_sectors, offset);
 	else
-		use_dmio(b, rw, sector, n_sectors, offset);
+		use_dmio(b, op, sector, n_sectors, offset);
 }
 
 /*----------------------------------------------------------------
diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
index 0606e00d1817..783564533459 100644
--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -293,7 +293,7 @@ static void km_dp_init(struct dpages *dp, void *data)
 /*-----------------------------------------------------------------
  * IO routines that accept a list of pages.
  *---------------------------------------------------------------*/
-static void do_region(int op, int op_flags, unsigned region,
+static void do_region(const blk_opf_t opf, unsigned region,
 		      struct dm_io_region *where, struct dpages *dp,
 		      struct io *io)
 {
@@ -306,6 +306,7 @@ static void do_region(int op, int op_flags, unsigned region,
 	struct request_queue *q = bdev_get_queue(where->bdev);
 	sector_t num_sectors;
 	unsigned int special_cmd_max_sectors;
+	const enum req_op op = opf & REQ_OP_MASK;
 
 	/*
 	 * Reject unsupported discard and write same requests.
@@ -339,8 +340,8 @@ static void do_region(int op, int op_flags, unsigned region,
 						(PAGE_SIZE >> SECTOR_SHIFT)));
 		}
 
-		bio = bio_alloc_bioset(where->bdev, num_bvecs, op | op_flags,
-				       GFP_NOIO, &io->client->bios);
+		bio = bio_alloc_bioset(where->bdev, num_bvecs, opf, GFP_NOIO,
+				       &io->client->bios);
 		bio->bi_iter.bi_sector = where->sector + (where->count - remaining);
 		bio->bi_end_io = endio;
 		store_io_and_region_in_bio(bio, io, region);
@@ -368,7 +369,7 @@ static void do_region(int op, int op_flags, unsigned region,
 	} while (remaining);
 }
 
-static void dispatch_io(int op, int op_flags, unsigned int num_regions,
+static void dispatch_io(blk_opf_t opf, unsigned int num_regions,
 			struct dm_io_region *where, struct dpages *dp,
 			struct io *io, int sync)
 {
@@ -378,7 +379,7 @@ static void dispatch_io(int op, int op_flags, unsigned int num_regions,
 	BUG_ON(num_regions > DM_IO_MAX_REGIONS);
 
 	if (sync)
-		op_flags |= REQ_SYNC;
+		opf |= REQ_SYNC;
 
 	/*
 	 * For multiple regions we need to be careful to rewind
@@ -386,8 +387,8 @@ static void dispatch_io(int op, int op_flags, unsigned int num_regions,
 	 */
 	for (i = 0; i < num_regions; i++) {
 		*dp = old_pages;
-		if (where[i].count || (op_flags & REQ_PREFLUSH))
-			do_region(op, op_flags, i, where + i, dp, io);
+		if (where[i].count || (opf & REQ_PREFLUSH))
+			do_region(opf, i, where + i, dp, io);
 	}
 
 	/*
@@ -411,13 +412,13 @@ static void sync_io_complete(unsigned long error, void *context)
 }
 
 static int sync_io(struct dm_io_client *client, unsigned int num_regions,
-		   struct dm_io_region *where, int op, int op_flags,
-		   struct dpages *dp, unsigned long *error_bits)
+		   struct dm_io_region *where, blk_opf_t opf, struct dpages *dp,
+		   unsigned long *error_bits)
 {
 	struct io *io;
 	struct sync_io sio;
 
-	if (num_regions > 1 && !op_is_write(op)) {
+	if (num_regions > 1 && !op_is_write(opf)) {
 		WARN_ON(1);
 		return -EIO;
 	}
@@ -434,7 +435,7 @@ static int sync_io(struct dm_io_client *client, unsigned int num_regions,
 	io->vma_invalidate_address = dp->vma_invalidate_address;
 	io->vma_invalidate_size = dp->vma_invalidate_size;
 
-	dispatch_io(op, op_flags, num_regions, where, dp, io, 1);
+	dispatch_io(opf, num_regions, where, dp, io, 1);
 
 	wait_for_completion_io(&sio.wait);
 
@@ -445,12 +446,12 @@ static int sync_io(struct dm_io_client *client, unsigned int num_regions,
 }
 
 static int async_io(struct dm_io_client *client, unsigned int num_regions,
-		    struct dm_io_region *where, int op, int op_flags,
+		    struct dm_io_region *where, blk_opf_t opf,
 		    struct dpages *dp, io_notify_fn fn, void *context)
 {
 	struct io *io;
 
-	if (num_regions > 1 && !op_is_write(op)) {
+	if (num_regions > 1 && !op_is_write(opf)) {
 		WARN_ON(1);
 		fn(1, context);
 		return -EIO;
@@ -466,7 +467,7 @@ static int async_io(struct dm_io_client *client, unsigned int num_regions,
 	io->vma_invalidate_address = dp->vma_invalidate_address;
 	io->vma_invalidate_size = dp->vma_invalidate_size;
 
-	dispatch_io(op, op_flags, num_regions, where, dp, io, 0);
+	dispatch_io(opf, num_regions, where, dp, io, 0);
 	return 0;
 }
 
@@ -519,13 +520,10 @@ int dm_io(struct dm_io_request *io_req, unsigned num_regions,
 
 	if (!io_req->notify.fn)
 		return sync_io(io_req->client, num_regions, where,
-			       io_req->bi_opf & REQ_OP_MASK,
-			       io_req->bi_opf & ~REQ_OP_MASK, &dp,
-			       sync_error_bits);
+			       io_req->bi_opf, &dp, sync_error_bits);
 
 	return async_io(io_req->client, num_regions, where,
-			io_req->bi_opf & REQ_OP_MASK,
-			io_req->bi_opf & ~REQ_OP_MASK, &dp, io_req->notify.fn,
+			io_req->bi_opf, &dp, io_req->notify.fn,
 			io_req->notify.context);
 }
 EXPORT_SYMBOL(dm_io);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index c6e004157da3..438b8791265c 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -716,7 +716,7 @@ static void dm_put_live_table_fast(struct mapped_device *md) __releases(RCU)
 }
 
 static inline struct dm_table *dm_get_live_table_bio(struct mapped_device *md,
-						     int *srcu_idx, unsigned bio_opf)
+					int *srcu_idx, blk_opf_t bio_opf)
 {
 	if (bio_opf & REQ_NOWAIT)
 		return dm_get_live_table_fast(md);
@@ -725,7 +725,7 @@ static inline struct dm_table *dm_get_live_table_bio(struct mapped_device *md,
 }
 
 static inline void dm_put_live_table_bio(struct mapped_device *md, int srcu_idx,
-					 unsigned bio_opf)
+					 blk_opf_t bio_opf)
 {
 	if (bio_opf & REQ_NOWAIT)
 		dm_put_live_table_fast(md);
@@ -1511,7 +1511,7 @@ static void __send_changing_extent_only(struct clone_info *ci, struct dm_target
 
 static bool is_abnormal_io(struct bio *bio)
 {
-	unsigned int op = bio_op(bio);
+	enum req_op op = bio_op(bio);
 
 	if (op != REQ_OP_READ && op != REQ_OP_WRITE && op != REQ_OP_FLUSH) {
 		switch (op) {
@@ -1625,7 +1625,7 @@ static blk_status_t __split_and_process_bio(struct clone_info *ci)
 	 * Only support bio polling for normal IO, and the target io is
 	 * exactly inside the dm_io instance (verified in dm_poll_dm_io)
 	 */
-	ci->submit_as_polled = ci->bio->bi_opf & REQ_POLLED;
+	ci->submit_as_polled = !!(ci->bio->bi_opf & REQ_POLLED);
 
 	len = min_t(sector_t, max_io_len(ti, ci->sector), ci->sector_count);
 	setup_split_accounting(ci, len);
@@ -1722,7 +1722,7 @@ static void dm_submit_bio(struct bio *bio)
 	struct mapped_device *md = bio->bi_bdev->bd_disk->private_data;
 	int srcu_idx;
 	struct dm_table *map;
-	unsigned bio_opf = bio->bi_opf;
+	blk_opf_t bio_opf = bio->bi_opf;
 
 	map = dm_get_live_table_bio(md, &srcu_idx, bio_opf);
 
