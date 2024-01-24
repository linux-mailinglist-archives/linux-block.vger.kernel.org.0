Return-Path: <linux-block+bounces-2245-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF8A83A16B
	for <lists+linux-block@lfdr.de>; Wed, 24 Jan 2024 06:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DCF428A9AC
	for <lists+linux-block@lfdr.de>; Wed, 24 Jan 2024 05:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5D0E56D;
	Wed, 24 Jan 2024 05:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXflC051"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A9C168AF;
	Wed, 24 Jan 2024 05:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706074579; cv=none; b=qh/MYqppCxX5p3oCgIqslbHg1iILdwQnbRUySaxZQ7NXXpE/QVLJyEvYz9M1o74tczM7DbXdtbKVXSUFlLbugVVAiar180MYd2o5/KpcGzt5prMAxHwq1bcxtsaP5X/c5a2tr0CtrR/VkDVAqr6SBq0PqU7jTxWF5G05xdMrjr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706074579; c=relaxed/simple;
	bh=cOfhSVrFL+m6Aa228LrkSkkAFcw3sxj2wmJIIoNHJB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mSn9xjpYjDukWKDnn3PyK5y0YjbQwdRxEoyigjEvqf0d7yqA0sgTUlOn4ttQGYbYR4fynbpoz4gN1d7kbotlHQA65ZwcufiM4b8Qo9k5xuy//eHUjitb9lqy+KKrUdyikfaNxIVwvPsNg5Un+jDAkIcBH9dZfdyGbuuP1vS8z6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXflC051; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d7881b1843so381585ad.3;
        Tue, 23 Jan 2024 21:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706074577; x=1706679377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcq1cljO8rsP7YGNii3GrZLAj0KVi0PhS4WrxheUkJ8=;
        b=HXflC051fQ8iqaFqc+jSs0qWsOi1QhT5yAikkxydh8d2E7c+GZphPebISzoADWVvvS
         JLYlyiRiCiazz5yro/HXafKICwUw/8+w7qqAhHzxMN6HCwmfkv1tQQ+6SvNj4a1fZhJt
         AGaBK+8+ORZdDSzqaFRtC/Q32yPGJQZ/8k2G50fxF8res7GEQtUgyAOUQ5hb3qUXt9h4
         jIpO/58nzQpJ/ricG1b3oavIE6qTvcdYA/mlqvTelZjcxHk0r7IoSPmwpYOTn0knaH6p
         2niPw7Baw6BGEnyCxnb7Kf3oJu3Ex+sTYTVARajeXTeWJdfd8EnPmnb/Fjsbp93Uf/Uf
         R4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706074577; x=1706679377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcq1cljO8rsP7YGNii3GrZLAj0KVi0PhS4WrxheUkJ8=;
        b=VVA7e9QeTqc+vkTUQCSzYjJgVlCSBegHziHSlrMBKtidcuQESbaY6uzFhtNVOHhnY8
         286Du4itqobdL3QDd2qqBCw4EUGtTIlGSW6jlocMZsn9LXw7ojvcgRhPvLf82haSa5Mh
         l/25OBVl5FmaGI7cewlVqC4ZU3x/CBIZBXrWQ23xSglNn0IqXIxpIDASh1esivQzdA8l
         +O4phjKl8tjbv4SlJT4iYpMn4S5yh6Kcx3wrzbBeqTxYWxfa1QogX7lgh1ayP2sUdCNq
         Sl6qi4w+iC8X2iJueow5dv8Zf6yiLc0dEQGnTViZj15iyISkd7wRiWSBBhRme2vPIDvR
         TfMw==
X-Gm-Message-State: AOJu0YxzIZ5yyEttD7WwIQO5HQSJn989vJg+Z+uURd0AdAeio6eVXyQL
	DpuVR2ATz0Lh8NjI17npk9MOYqvB8zXB8A2cbEAO9Fd0rw7O3bxV
X-Google-Smtp-Source: AGHT+IEW6DjJtR9w+xD/ThwP55edkfnziwEX5y4jnwOrbJvbjEQbkb0dO9HhpzB3DayK7qPONmEykg==
X-Received: by 2002:a17:902:d4c9:b0:1d4:477c:4753 with SMTP id o9-20020a170902d4c900b001d4477c4753mr372395plg.42.1706074577020;
        Tue, 23 Jan 2024 21:36:17 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id kt6-20020a170903088600b001d755acec64sm4015663plb.189.2024.01.23.21.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 21:36:16 -0800 (PST)
From: Hongyu Jin <hongyu.jin.cn@gmail.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	axboe@kernel.dk,
	ebiggers@kernel.org
Cc: zhiguo.niu@unisoc.com,
	ke.wang@unisoc.com,
	yibin.ding@unisoc.com,
	hongyu.jin@unisoc.com,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH v8 3/5] dm-bufio: Support I/O priority
Date: Wed, 24 Jan 2024 13:35:54 +0800
Message-Id: <20240124053556.126468-4-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124053556.126468-1-hongyu.jin.cn@gmail.com>
References: <20231221103139.15699-6-hongyu.jin.cn@gmail.com>
 <20240124053556.126468-1-hongyu.jin.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongyu Jin <hongyu.jin@unisoc.com>

Some I/O will dispatch from kworker with different io_context settings
than the submitting task, we may need to specify a priority to avoid
losing priority.

Add I/O priority parameter for dm_bufio_read() and
dm_bufio_prefetch().

Co-developed-by: Yibin Ding <yibin.ding@unisoc.com>
Signed-off-by: Yibin Ding <yibin.ding@unisoc.com>
Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
---
 drivers/md/dm-bufio.c                         | 39 +++++++++++--------
 drivers/md/dm-ebs-target.c                    |  8 ++--
 drivers/md/dm-integrity.c                     |  2 +-
 drivers/md/dm-snap-persistent.c               |  4 +-
 drivers/md/dm-verity-fec.c                    |  4 +-
 drivers/md/dm-verity-target.c                 |  5 ++-
 drivers/md/persistent-data/dm-block-manager.c |  6 +--
 include/linux/dm-bufio.h                      |  5 ++-
 8 files changed, 40 insertions(+), 33 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index f5541b8f6320..31b7351398a8 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1292,7 +1292,8 @@ static void dmio_complete(unsigned long error, void *context)
 }
 
 static void use_dmio(struct dm_buffer *b, enum req_op op, sector_t sector,
-		     unsigned int n_sectors, unsigned int offset)
+		     unsigned int n_sectors, unsigned int offset,
+		     unsigned short ioprio)
 {
 	int r;
 	struct dm_io_request io_req = {
@@ -1315,7 +1316,7 @@ static void use_dmio(struct dm_buffer *b, enum req_op op, sector_t sector,
 		io_req.mem.ptr.vma = (char *)b->data + offset;
 	}
 
-	r = dm_io(&io_req, 1, &region, NULL, IOPRIO_DEFAULT);
+	r = dm_io(&io_req, 1, &region, NULL, ioprio);
 	if (unlikely(r))
 		b->end_io(b, errno_to_blk_status(r));
 }
@@ -1331,7 +1332,8 @@ static void bio_complete(struct bio *bio)
 }
 
 static void use_bio(struct dm_buffer *b, enum req_op op, sector_t sector,
-		    unsigned int n_sectors, unsigned int offset)
+		    unsigned int n_sectors, unsigned int offset,
+		    unsigned short ioprio)
 {
 	struct bio *bio;
 	char *ptr;
@@ -1339,13 +1341,14 @@ static void use_bio(struct dm_buffer *b, enum req_op op, sector_t sector,
 
 	bio = bio_kmalloc(1, GFP_NOWAIT | __GFP_NORETRY | __GFP_NOWARN);
 	if (!bio) {
-		use_dmio(b, op, sector, n_sectors, offset);
+		use_dmio(b, op, sector, n_sectors, offset, ioprio);
 		return;
 	}
 	bio_init(bio, b->c->bdev, bio->bi_inline_vecs, 1, op);
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_end_io = bio_complete;
 	bio->bi_private = b;
+	bio->bi_ioprio = ioprio;
 
 	ptr = (char *)b->data + offset;
 	len = n_sectors << SECTOR_SHIFT;
@@ -1368,7 +1371,7 @@ static inline sector_t block_to_sector(struct dm_bufio_client *c, sector_t block
 	return sector;
 }
 
-static void submit_io(struct dm_buffer *b, enum req_op op,
+static void submit_io(struct dm_buffer *b, enum req_op op, unsigned short ioprio,
 		      void (*end_io)(struct dm_buffer *, blk_status_t))
 {
 	unsigned int n_sectors;
@@ -1398,9 +1401,9 @@ static void submit_io(struct dm_buffer *b, enum req_op op,
 	}
 
 	if (b->data_mode != DATA_MODE_VMALLOC)
-		use_bio(b, op, sector, n_sectors, offset);
+		use_bio(b, op, sector, n_sectors, offset, ioprio);
 	else
-		use_dmio(b, op, sector, n_sectors, offset);
+		use_dmio(b, op, sector, n_sectors, offset, ioprio);
 }
 
 /*
@@ -1456,7 +1459,7 @@ static void __write_dirty_buffer(struct dm_buffer *b,
 	b->write_end = b->dirty_end;
 
 	if (!write_list)
-		submit_io(b, REQ_OP_WRITE, write_endio);
+		submit_io(b, REQ_OP_WRITE, IOPRIO_DEFAULT, write_endio);
 	else
 		list_add_tail(&b->write_list, write_list);
 }
@@ -1470,7 +1473,7 @@ static void __flush_write_list(struct list_head *write_list)
 		struct dm_buffer *b =
 			list_entry(write_list->next, struct dm_buffer, write_list);
 		list_del(&b->write_list);
-		submit_io(b, REQ_OP_WRITE, write_endio);
+		submit_io(b, REQ_OP_WRITE, IOPRIO_DEFAULT, write_endio);
 		cond_resched();
 	}
 	blk_finish_plug(&plug);
@@ -1852,7 +1855,8 @@ static void read_endio(struct dm_buffer *b, blk_status_t status)
  * and uses dm_bufio_mark_buffer_dirty to write new data back).
  */
 static void *new_read(struct dm_bufio_client *c, sector_t block,
-		      enum new_flag nf, struct dm_buffer **bp)
+		      enum new_flag nf, struct dm_buffer **bp,
+		      unsigned short ioprio)
 {
 	int need_submit = 0;
 	struct dm_buffer *b;
@@ -1905,7 +1909,7 @@ static void *new_read(struct dm_bufio_client *c, sector_t block,
 		return NULL;
 
 	if (need_submit)
-		submit_io(b, REQ_OP_READ, read_endio);
+		submit_io(b, REQ_OP_READ, ioprio, read_endio);
 
 	if (nf != NF_GET)	/* we already tested this condition above */
 		wait_on_bit_io(&b->state, B_READING, TASK_UNINTERRUPTIBLE);
@@ -1926,17 +1930,17 @@ static void *new_read(struct dm_bufio_client *c, sector_t block,
 void *dm_bufio_get(struct dm_bufio_client *c, sector_t block,
 		   struct dm_buffer **bp)
 {
-	return new_read(c, block, NF_GET, bp);
+	return new_read(c, block, NF_GET, bp, IOPRIO_DEFAULT);
 }
 EXPORT_SYMBOL_GPL(dm_bufio_get);
 
 void *dm_bufio_read(struct dm_bufio_client *c, sector_t block,
-		    struct dm_buffer **bp)
+		    struct dm_buffer **bp, unsigned short ioprio)
 {
 	if (WARN_ON_ONCE(dm_bufio_in_request()))
 		return ERR_PTR(-EINVAL);
 
-	return new_read(c, block, NF_READ, bp);
+	return new_read(c, block, NF_READ, bp, ioprio);
 }
 EXPORT_SYMBOL_GPL(dm_bufio_read);
 
@@ -1946,12 +1950,13 @@ void *dm_bufio_new(struct dm_bufio_client *c, sector_t block,
 	if (WARN_ON_ONCE(dm_bufio_in_request()))
 		return ERR_PTR(-EINVAL);
 
-	return new_read(c, block, NF_FRESH, bp);
+	return new_read(c, block, NF_FRESH, bp, IOPRIO_DEFAULT);
 }
 EXPORT_SYMBOL_GPL(dm_bufio_new);
 
 void dm_bufio_prefetch(struct dm_bufio_client *c,
-		       sector_t block, unsigned int n_blocks)
+		       sector_t block, unsigned int n_blocks,
+		       unsigned short ioprio)
 {
 	struct blk_plug plug;
 
@@ -1987,7 +1992,7 @@ void dm_bufio_prefetch(struct dm_bufio_client *c,
 			dm_bufio_unlock(c);
 
 			if (need_submit)
-				submit_io(b, REQ_OP_READ, read_endio);
+				submit_io(b, REQ_OP_READ, ioprio, read_endio);
 			dm_bufio_release(b);
 
 			cond_resched();
diff --git a/drivers/md/dm-ebs-target.c b/drivers/md/dm-ebs-target.c
index 435b45201f4d..8198c8a7b416 100644
--- a/drivers/md/dm-ebs-target.c
+++ b/drivers/md/dm-ebs-target.c
@@ -84,7 +84,7 @@ static int __ebs_rw_bvec(struct ebs_c *ec, enum req_op op, struct bio_vec *bv,
 
 		/* Avoid reading for writes in case bio vector's page overwrites block completely. */
 		if (op == REQ_OP_READ || buf_off || bv_len < dm_bufio_get_block_size(ec->bufio))
-			ba = dm_bufio_read(ec->bufio, block, &b);
+			ba = dm_bufio_read(ec->bufio, block, &b, IOPRIO_DEFAULT);
 		else
 			ba = dm_bufio_new(ec->bufio, block, &b);
 
@@ -194,13 +194,13 @@ static void __ebs_process_bios(struct work_struct *ws)
 	bio_list_for_each(bio, &bios) {
 		block1 = __sector_to_block(ec, bio->bi_iter.bi_sector);
 		if (bio_op(bio) == REQ_OP_READ)
-			dm_bufio_prefetch(ec->bufio, block1, __nr_blocks(ec, bio));
+			dm_bufio_prefetch(ec->bufio, block1, __nr_blocks(ec, bio), IOPRIO_DEFAULT);
 		else if (bio_op(bio) == REQ_OP_WRITE && !(bio->bi_opf & REQ_PREFLUSH)) {
 			block2 = __sector_to_block(ec, bio_end_sector(bio));
 			if (__block_mod(bio->bi_iter.bi_sector, ec->u_bs))
-				dm_bufio_prefetch(ec->bufio, block1, 1);
+				dm_bufio_prefetch(ec->bufio, block1, 1, IOPRIO_DEFAULT);
 			if (__block_mod(bio_end_sector(bio), ec->u_bs) && block2 != block1)
-				dm_bufio_prefetch(ec->bufio, block2, 1);
+				dm_bufio_prefetch(ec->bufio, block2, 1, IOPRIO_DEFAULT);
 		}
 	}
 
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index ed45411eb68d..42abc5c316f1 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1418,7 +1418,7 @@ static int dm_integrity_rw_tag(struct dm_integrity_c *ic, unsigned char *tag, se
 		if (unlikely(r))
 			return r;
 
-		data = dm_bufio_read(ic->bufio, *metadata_block, &b);
+		data = dm_bufio_read(ic->bufio, *metadata_block, &b, IOPRIO_DEFAULT);
 		if (IS_ERR(data))
 			return PTR_ERR(data);
 
diff --git a/drivers/md/dm-snap-persistent.c b/drivers/md/dm-snap-persistent.c
index 568d10842b1f..a2072b95e28c 100644
--- a/drivers/md/dm-snap-persistent.c
+++ b/drivers/md/dm-snap-persistent.c
@@ -524,7 +524,7 @@ static int read_exceptions(struct pstore *ps,
 
 				if (unlikely(pf_chunk >= dm_bufio_get_device_size(client)))
 					break;
-				dm_bufio_prefetch(client, pf_chunk, 1);
+				dm_bufio_prefetch(client, pf_chunk, 1, IOPRIO_DEFAULT);
 				prefetch_area++;
 				if (unlikely(!prefetch_area))
 					break;
@@ -533,7 +533,7 @@ static int read_exceptions(struct pstore *ps,
 
 		chunk = area_location(ps, ps->current_area);
 
-		area = dm_bufio_read(client, chunk, &bp);
+		area = dm_bufio_read(client, chunk, &bp, IOPRIO_DEFAULT);
 		if (IS_ERR(area)) {
 			r = PTR_ERR(area);
 			goto ret_destroy_bufio;
diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index b475200d8586..49db19e537f9 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -69,7 +69,7 @@ static u8 *fec_read_parity(struct dm_verity *v, u64 rsb, int index,
 	block = div64_u64_rem(position, v->fec->io_size, &rem);
 	*offset = (unsigned int)rem;
 
-	res = dm_bufio_read(v->fec->bufio, block, buf);
+	res = dm_bufio_read(v->fec->bufio, block, buf, IOPRIO_DEFAULT);
 	if (IS_ERR(res)) {
 		DMERR("%s: FEC %llu: parity read failed (block %llu): %ld",
 		      v->data_dev->name, (unsigned long long)rsb,
@@ -248,7 +248,7 @@ static int fec_read_bufs(struct dm_verity *v, struct dm_verity_io *io,
 			bufio = v->bufio;
 		}
 
-		bbuf = dm_bufio_read(bufio, block, &buf);
+		bbuf = dm_bufio_read(bufio, block, &buf, IOPRIO_DEFAULT);
 		if (IS_ERR(bbuf)) {
 			DMWARN_LIMIT("%s: FEC %llu: read failed (%llu): %ld",
 				     v->data_dev->name,
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 14e58ae70521..4758bfe2c156 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -308,7 +308,7 @@ static int verity_verify_level(struct dm_verity *v, struct dm_verity_io *io,
 			return -EAGAIN;
 		}
 	} else
-		data = dm_bufio_read(v->bufio, hash_block, &buf);
+		data = dm_bufio_read(v->bufio, hash_block, &buf, IOPRIO_DEFAULT);
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
@@ -719,7 +719,8 @@ static void verity_prefetch_io(struct work_struct *work)
 		}
 no_prefetch_cluster:
 		dm_bufio_prefetch(v->bufio, hash_block_start,
-				  hash_block_end - hash_block_start + 1);
+				  hash_block_end - hash_block_start + 1,
+				  IOPRIO_DEFAULT);
 	}
 
 	kfree(pw);
diff --git a/drivers/md/persistent-data/dm-block-manager.c b/drivers/md/persistent-data/dm-block-manager.c
index 0e010e1204aa..86a4f73d2f3d 100644
--- a/drivers/md/persistent-data/dm-block-manager.c
+++ b/drivers/md/persistent-data/dm-block-manager.c
@@ -474,7 +474,7 @@ int dm_bm_read_lock(struct dm_block_manager *bm, dm_block_t b,
 	void *p;
 	int r;
 
-	p = dm_bufio_read(bm->bufio, b, (struct dm_buffer **) result);
+	p = dm_bufio_read(bm->bufio, b, (struct dm_buffer **) result, IOPRIO_DEFAULT);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
 
@@ -510,7 +510,7 @@ int dm_bm_write_lock(struct dm_block_manager *bm,
 	if (dm_bm_is_read_only(bm))
 		return -EPERM;
 
-	p = dm_bufio_read(bm->bufio, b, (struct dm_buffer **) result);
+	p = dm_bufio_read(bm->bufio, b, (struct dm_buffer **) result, IOPRIO_DEFAULT);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
 
@@ -624,7 +624,7 @@ EXPORT_SYMBOL_GPL(dm_bm_flush);
 
 void dm_bm_prefetch(struct dm_block_manager *bm, dm_block_t b)
 {
-	dm_bufio_prefetch(bm->bufio, b, 1);
+	dm_bufio_prefetch(bm->bufio, b, 1, IOPRIO_DEFAULT);
 }
 
 bool dm_bm_is_read_only(struct dm_block_manager *bm)
diff --git a/include/linux/dm-bufio.h b/include/linux/dm-bufio.h
index 75e7d8cbb532..256a246c7b97 100644
--- a/include/linux/dm-bufio.h
+++ b/include/linux/dm-bufio.h
@@ -62,7 +62,7 @@ void dm_bufio_set_sector_offset(struct dm_bufio_client *c, sector_t start);
  * it dirty.
  */
 void *dm_bufio_read(struct dm_bufio_client *c, sector_t block,
-		    struct dm_buffer **bp);
+		    struct dm_buffer **bp, unsigned short ioprio);
 
 /*
  * Like dm_bufio_read, but return buffer from cache, don't read
@@ -84,7 +84,8 @@ void *dm_bufio_new(struct dm_bufio_client *c, sector_t block,
  * I/O to finish.
  */
 void dm_bufio_prefetch(struct dm_bufio_client *c,
-		       sector_t block, unsigned int n_blocks);
+		       sector_t block, unsigned int n_blocks,
+		       unsigned short ioprio);
 
 /*
  * Release a reference obtained with dm_bufio_{read,get,new}. The data
-- 
2.34.1


