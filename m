Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE58575485
	for <lists+linux-block@lfdr.de>; Thu, 14 Jul 2022 20:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240491AbiGNSI1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 14 Jul 2022 14:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240490AbiGNSIT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:19 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE19B67C94
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:18 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id o18so2266037pgu.9
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uX+YFPa8om6DeYjG8kuXHthPhLt3y2nl9cS8CJMnCvA=;
        b=QwFJRSNd6z9RBXfOVnyNysEIPLtNhyRc9mwq3weo9QL70NK4JZ2zokvmhtvBZldLux
         JgjB6dzO1vmV/jpAQ1rY1zU0o8auiWtO3YY+GGSgN8nuzRaPihZH2Es0c6fFsvaA/l2W
         cRofxOX5NzRdi+oNUo84QGcXxxSN5qDK9k5z0WNSO84KlueJqtQhMqq0JMGHyO0SeJG1
         W8VaBjFt0gPZP2XxgJgWf2BLB/JHqm9HFoNxILhlG/EICCMtUz/4wOmkCkQR/elqzrW4
         gv5bj1OROs3WhEGXtCGtAApItIrqMIamzvr32O8aT8Dak0mcgo9HSmLdE5NF5lj99m2M
         a0bg==
X-Gm-Message-State: AJIora8QwciLq7hwl86BP13Iev9iU5VBCW1G6ZfNseXq+XwvPEgTzQ/x
        +U8AD/7fDlv6/DbAA6pio4E=
X-Google-Smtp-Source: AGRyM1uAnyNv2HahFWTRmfM4cL6mZ16TOrVZ2mVzJaZ1TaWFQ4kHhxdzvNlWwiqwcs3gqNk9mIBA6A==
X-Received: by 2002:a63:3286:0:b0:415:cfd5:32bb with SMTP id y128-20020a633286000000b00415cfd532bbmr8513955pgy.148.1657822098182;
        Thu, 14 Jul 2022 11:08:18 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:17 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v3 26/63] dm/dm-integrity: Combine request operation and flags
Date:   Thu, 14 Jul 2022 11:06:52 -0700
Message-Id: <20220714180729.1065367-27-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
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

Combine the request operation type and request flags into a single
argument. Improve static type checking by using the enum req_op type for
variables that represent a request operation and the new blk_opf_t type for
variables that represent request flags.

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/dm-integrity.c | 63 +++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 2ccc103dea1e..c60f9b2ece2d 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -551,13 +551,14 @@ static int sb_mac(struct dm_integrity_c *ic, bool wr)
 	return 0;
 }
 
-static int sync_rw_sb(struct dm_integrity_c *ic, int op, int op_flags)
+static int sync_rw_sb(struct dm_integrity_c *ic, blk_opf_t opf)
 {
 	struct dm_io_request io_req;
 	struct dm_io_region io_loc;
+	const enum req_op op = opf & REQ_OP_MASK;
 	int r;
 
-	io_req.bi_opf = op | op_flags;
+	io_req.bi_opf = opf;
 	io_req.mem.type = DM_IO_KMEM;
 	io_req.mem.ptr.addr = ic->sb;
 	io_req.notify.fn = NULL;
@@ -1049,8 +1050,9 @@ static void complete_journal_io(unsigned long error, void *context)
 	complete_journal_op(comp);
 }
 
-static void rw_journal_sectors(struct dm_integrity_c *ic, int op, int op_flags,
-			       unsigned sector, unsigned n_sectors, struct journal_completion *comp)
+static void rw_journal_sectors(struct dm_integrity_c *ic, blk_opf_t opf,
+			       unsigned sector, unsigned n_sectors,
+			       struct journal_completion *comp)
 {
 	struct dm_io_request io_req;
 	struct dm_io_region io_loc;
@@ -1066,7 +1068,7 @@ static void rw_journal_sectors(struct dm_integrity_c *ic, int op, int op_flags,
 	pl_index = sector >> (PAGE_SHIFT - SECTOR_SHIFT);
 	pl_offset = (sector << SECTOR_SHIFT) & (PAGE_SIZE - 1);
 
-	io_req.bi_opf = op | op_flags;
+	io_req.bi_opf = opf;
 	io_req.mem.type = DM_IO_PAGE_LIST;
 	if (ic->journal_io)
 		io_req.mem.ptr.pl = &ic->journal_io[pl_index];
@@ -1086,7 +1088,8 @@ static void rw_journal_sectors(struct dm_integrity_c *ic, int op, int op_flags,
 
 	r = dm_io(&io_req, 1, &io_loc, NULL);
 	if (unlikely(r)) {
-		dm_integrity_io_error(ic, op == REQ_OP_READ ? "reading journal" : "writing journal", r);
+		dm_integrity_io_error(ic, (opf & REQ_OP_MASK) == REQ_OP_READ ?
+				      "reading journal" : "writing journal", r);
 		if (comp) {
 			WARN_ONCE(1, "asynchronous dm_io failed: %d", r);
 			complete_journal_io(-1UL, comp);
@@ -1094,15 +1097,16 @@ static void rw_journal_sectors(struct dm_integrity_c *ic, int op, int op_flags,
 	}
 }
 
-static void rw_journal(struct dm_integrity_c *ic, int op, int op_flags, unsigned section,
-		       unsigned n_sections, struct journal_completion *comp)
+static void rw_journal(struct dm_integrity_c *ic, blk_opf_t opf,
+		       unsigned section, unsigned n_sections,
+		       struct journal_completion *comp)
 {
 	unsigned sector, n_sectors;
 
 	sector = section * ic->journal_section_sectors;
 	n_sectors = n_sections * ic->journal_section_sectors;
 
-	rw_journal_sectors(ic, op, op_flags, sector, n_sectors, comp);
+	rw_journal_sectors(ic, opf, sector, n_sectors, comp);
 }
 
 static void write_journal(struct dm_integrity_c *ic, unsigned commit_start, unsigned commit_sections)
@@ -1127,7 +1131,7 @@ static void write_journal(struct dm_integrity_c *ic, unsigned commit_start, unsi
 			for (i = 0; i < commit_sections; i++)
 				rw_section_mac(ic, commit_start + i, true);
 		}
-		rw_journal(ic, REQ_OP_WRITE, REQ_FUA | REQ_SYNC, commit_start,
+		rw_journal(ic, REQ_OP_WRITE | REQ_FUA | REQ_SYNC, commit_start,
 			   commit_sections, &io_comp);
 	} else {
 		unsigned to_end;
@@ -1139,7 +1143,8 @@ static void write_journal(struct dm_integrity_c *ic, unsigned commit_start, unsi
 			crypt_comp_1.in_flight = (atomic_t)ATOMIC_INIT(0);
 			encrypt_journal(ic, true, commit_start, to_end, &crypt_comp_1);
 			if (try_wait_for_completion(&crypt_comp_1.comp)) {
-				rw_journal(ic, REQ_OP_WRITE, REQ_FUA, commit_start, to_end, &io_comp);
+				rw_journal(ic, REQ_OP_WRITE | REQ_FUA,
+					   commit_start, to_end, &io_comp);
 				reinit_completion(&crypt_comp_1.comp);
 				crypt_comp_1.in_flight = (atomic_t)ATOMIC_INIT(0);
 				encrypt_journal(ic, true, 0, commit_sections - to_end, &crypt_comp_1);
@@ -1150,17 +1155,17 @@ static void write_journal(struct dm_integrity_c *ic, unsigned commit_start, unsi
 				crypt_comp_2.in_flight = (atomic_t)ATOMIC_INIT(0);
 				encrypt_journal(ic, true, 0, commit_sections - to_end, &crypt_comp_2);
 				wait_for_completion_io(&crypt_comp_1.comp);
-				rw_journal(ic, REQ_OP_WRITE, REQ_FUA, commit_start, to_end, &io_comp);
+				rw_journal(ic, REQ_OP_WRITE | REQ_FUA, commit_start, to_end, &io_comp);
 				wait_for_completion_io(&crypt_comp_2.comp);
 			}
 		} else {
 			for (i = 0; i < to_end; i++)
 				rw_section_mac(ic, commit_start + i, true);
-			rw_journal(ic, REQ_OP_WRITE, REQ_FUA, commit_start, to_end, &io_comp);
+			rw_journal(ic, REQ_OP_WRITE | REQ_FUA, commit_start, to_end, &io_comp);
 			for (i = 0; i < commit_sections - to_end; i++)
 				rw_section_mac(ic, i, true);
 		}
-		rw_journal(ic, REQ_OP_WRITE, REQ_FUA, 0, commit_sections - to_end, &io_comp);
+		rw_journal(ic, REQ_OP_WRITE | REQ_FUA, 0, commit_sections - to_end, &io_comp);
 	}
 
 	wait_for_completion_io(&io_comp.comp);
@@ -2622,7 +2627,7 @@ static void recalc_write_super(struct dm_integrity_c *ic)
 	if (dm_integrity_failed(ic))
 		return;
 
-	r = sync_rw_sb(ic, REQ_OP_WRITE, 0);
+	r = sync_rw_sb(ic, REQ_OP_WRITE);
 	if (unlikely(r))
 		dm_integrity_io_error(ic, "writing superblock", r);
 }
@@ -2795,7 +2800,7 @@ static void bitmap_block_work(struct work_struct *w)
 	if (bio_list_empty(&waiting))
 		return;
 
-	rw_journal_sectors(ic, REQ_OP_WRITE, REQ_FUA | REQ_SYNC,
+	rw_journal_sectors(ic, REQ_OP_WRITE | REQ_FUA | REQ_SYNC,
 			   bbs->idx * (BITMAP_BLOCK_SIZE >> SECTOR_SHIFT),
 			   BITMAP_BLOCK_SIZE >> SECTOR_SHIFT, NULL);
 
@@ -2841,7 +2846,7 @@ static void bitmap_flush_work(struct work_struct *work)
 	block_bitmap_op(ic, ic->journal, 0, limit, BITMAP_OP_CLEAR);
 	block_bitmap_op(ic, ic->may_write_bitmap, 0, limit, BITMAP_OP_CLEAR);
 
-	rw_journal_sectors(ic, REQ_OP_WRITE, REQ_FUA | REQ_SYNC, 0,
+	rw_journal_sectors(ic, REQ_OP_WRITE | REQ_FUA | REQ_SYNC, 0,
 			   ic->n_bitmap_blocks * (BITMAP_BLOCK_SIZE >> SECTOR_SHIFT), NULL);
 
 	spin_lock_irq(&ic->endio_wait.lock);
@@ -2913,7 +2918,7 @@ static void replay_journal(struct dm_integrity_c *ic)
 
 	if (!ic->just_formatted) {
 		DEBUG_print("reading journal\n");
-		rw_journal(ic, REQ_OP_READ, 0, 0, ic->journal_sections, NULL);
+		rw_journal(ic, REQ_OP_READ, 0, ic->journal_sections, NULL);
 		if (ic->journal_io)
 			DEBUG_bytes(lowmem_page_address(ic->journal_io[0].page), 64, "read journal");
 		if (ic->journal_io) {
@@ -3108,7 +3113,7 @@ static void dm_integrity_postsuspend(struct dm_target *ti)
 		/* set to 0 to test bitmap replay code */
 		init_journal(ic, 0, ic->journal_sections, 0);
 		ic->sb->flags &= ~cpu_to_le32(SB_FLAG_DIRTY_BITMAP);
-		r = sync_rw_sb(ic, REQ_OP_WRITE, REQ_FUA);
+		r = sync_rw_sb(ic, REQ_OP_WRITE | REQ_FUA);
 		if (unlikely(r))
 			dm_integrity_io_error(ic, "writing superblock", r);
 #endif
@@ -3131,23 +3136,23 @@ static void dm_integrity_resume(struct dm_target *ti)
 		if (ic->provided_data_sectors > old_provided_data_sectors &&
 		    ic->mode == 'B' &&
 		    ic->sb->log2_blocks_per_bitmap_bit == ic->log2_blocks_per_bitmap_bit) {
-			rw_journal_sectors(ic, REQ_OP_READ, 0, 0,
+			rw_journal_sectors(ic, REQ_OP_READ, 0,
 					   ic->n_bitmap_blocks * (BITMAP_BLOCK_SIZE >> SECTOR_SHIFT), NULL);
 			block_bitmap_op(ic, ic->journal, old_provided_data_sectors,
 					ic->provided_data_sectors - old_provided_data_sectors, BITMAP_OP_SET);
-			rw_journal_sectors(ic, REQ_OP_WRITE, REQ_FUA | REQ_SYNC, 0,
+			rw_journal_sectors(ic, REQ_OP_WRITE | REQ_FUA | REQ_SYNC, 0,
 					   ic->n_bitmap_blocks * (BITMAP_BLOCK_SIZE >> SECTOR_SHIFT), NULL);
 		}
 
 		ic->sb->provided_data_sectors = cpu_to_le64(ic->provided_data_sectors);
-		r = sync_rw_sb(ic, REQ_OP_WRITE, REQ_FUA);
+		r = sync_rw_sb(ic, REQ_OP_WRITE | REQ_FUA);
 		if (unlikely(r))
 			dm_integrity_io_error(ic, "writing superblock", r);
 	}
 
 	if (ic->sb->flags & cpu_to_le32(SB_FLAG_DIRTY_BITMAP)) {
 		DEBUG_print("resume dirty_bitmap\n");
-		rw_journal_sectors(ic, REQ_OP_READ, 0, 0,
+		rw_journal_sectors(ic, REQ_OP_READ, 0,
 				   ic->n_bitmap_blocks * (BITMAP_BLOCK_SIZE >> SECTOR_SHIFT), NULL);
 		if (ic->mode == 'B') {
 			if (ic->sb->log2_blocks_per_bitmap_bit == ic->log2_blocks_per_bitmap_bit &&
@@ -3166,7 +3171,7 @@ static void dm_integrity_resume(struct dm_target *ti)
 				block_bitmap_op(ic, ic->recalc_bitmap, 0, ic->provided_data_sectors, BITMAP_OP_SET);
 				block_bitmap_op(ic, ic->may_write_bitmap, 0, ic->provided_data_sectors, BITMAP_OP_SET);
 				block_bitmap_op(ic, ic->journal, 0, ic->provided_data_sectors, BITMAP_OP_SET);
-				rw_journal_sectors(ic, REQ_OP_WRITE, REQ_FUA | REQ_SYNC, 0,
+				rw_journal_sectors(ic, REQ_OP_WRITE | REQ_FUA | REQ_SYNC, 0,
 						   ic->n_bitmap_blocks * (BITMAP_BLOCK_SIZE >> SECTOR_SHIFT), NULL);
 				ic->sb->flags |= cpu_to_le32(SB_FLAG_RECALCULATING);
 				ic->sb->recalc_sector = cpu_to_le64(0);
@@ -3182,7 +3187,7 @@ static void dm_integrity_resume(struct dm_target *ti)
 			replay_journal(ic);
 			ic->sb->flags &= ~cpu_to_le32(SB_FLAG_DIRTY_BITMAP);
 		}
-		r = sync_rw_sb(ic, REQ_OP_WRITE, REQ_FUA);
+		r = sync_rw_sb(ic, REQ_OP_WRITE | REQ_FUA);
 		if (unlikely(r))
 			dm_integrity_io_error(ic, "writing superblock", r);
 	} else {
@@ -3194,7 +3199,7 @@ static void dm_integrity_resume(struct dm_target *ti)
 		if (ic->mode == 'B') {
 			ic->sb->flags |= cpu_to_le32(SB_FLAG_DIRTY_BITMAP);
 			ic->sb->log2_blocks_per_bitmap_bit = ic->log2_blocks_per_bitmap_bit;
-			r = sync_rw_sb(ic, REQ_OP_WRITE, REQ_FUA);
+			r = sync_rw_sb(ic, REQ_OP_WRITE | REQ_FUA);
 			if (unlikely(r))
 				dm_integrity_io_error(ic, "writing superblock", r);
 
@@ -3210,7 +3215,7 @@ static void dm_integrity_resume(struct dm_target *ti)
 				block_bitmap_op(ic, ic->may_write_bitmap, le64_to_cpu(ic->sb->recalc_sector),
 						ic->provided_data_sectors - le64_to_cpu(ic->sb->recalc_sector), BITMAP_OP_SET);
 			}
-			rw_journal_sectors(ic, REQ_OP_WRITE, REQ_FUA | REQ_SYNC, 0,
+			rw_journal_sectors(ic, REQ_OP_WRITE | REQ_FUA | REQ_SYNC, 0,
 					   ic->n_bitmap_blocks * (BITMAP_BLOCK_SIZE >> SECTOR_SHIFT), NULL);
 		}
 	}
@@ -4251,7 +4256,7 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 		goto bad;
 	}
 
-	r = sync_rw_sb(ic, REQ_OP_READ, 0);
+	r = sync_rw_sb(ic, REQ_OP_READ);
 	if (r) {
 		ti->error = "Error reading superblock";
 		goto bad;
@@ -4495,7 +4500,7 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 			ti->error = "Error initializing journal";
 			goto bad;
 		}
-		r = sync_rw_sb(ic, REQ_OP_WRITE, REQ_FUA);
+		r = sync_rw_sb(ic, REQ_OP_WRITE | REQ_FUA);
 		if (r) {
 			ti->error = "Error initializing superblock";
 			goto bad;
