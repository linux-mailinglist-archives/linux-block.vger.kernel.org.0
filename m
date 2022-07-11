Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A470560D7F
	for <lists+linux-block@lfdr.de>; Thu, 30 Jun 2022 01:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiF2Xd3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 Jun 2022 19:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiF2XdY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:33:24 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509D59FD7
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:13 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id k14so15493657plh.4
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NVDfdgNTkEDi5z4I5/2vuTWxeQxLpCAtny3/x4KvOwM=;
        b=N/9mL1DdGro2TkmOcruD5whSYUMQ2I8HnWKNTAtWkQwX/f2c06cFpXMrj34D5ZJUx7
         uAH4lGAqfmIRnDulOdQd+BaNOE1bg/o+x2jrB5BclYzK1NNXtDCWx/94MhUztZIjNROu
         HpCT1YuGcscoJvbhknzS2ijDMfQ2swa2GDEdMxgDMGYRRE+pQQXw1fl/JL2x7Jbr2opO
         BuVYgKIwCD3i+NvEhPFMkUB/6EsWMgMyRvlNtHsuDGBu6MHSwbC/rylrNtdwm/ApSPwO
         kwLrfEViWRGycctxF7XiOJs6q5uDWRsqkFpqBiRJ0hHZUq8NKYfd4MQE+6jmnTEwuuFR
         iOrg==
X-Gm-Message-State: AJIora+iLeZsB2dwcXn8YEm8xo6nG9y5nef7gs0yz/f/HbbvRCEjYlSm
        qsxBJCeuwKDPGIZ6JqNPa9+jpJJ2pPDApQ==
X-Google-Smtp-Source: AGRyM1vWSVHH3wAACUjyuoDw/0Ba+gAQ6aOqH8Ar5sa/WSTirbsiNk7YtcF37KQcr8EQWHi2EXTJyw==
X-Received: by 2002:a17:902:9348:b0:167:8e92:272f with SMTP id g8-20020a170902934800b001678e92272fmr11319844plp.77.1656545590059;
        Wed, 29 Jun 2022 16:33:10 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:33:09 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 50/63] fs/btrfs: Use the enum req_op and blk_opf_t types
Date:   Wed, 29 Jun 2022 16:31:32 -0700
Message-Id: <20220629233145.2779494-51-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for
variables that represent request flags.

Cc: David Sterba <dsterba@suse.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/btrfs/check-integrity.c |  4 ++--
 fs/btrfs/compression.c     |  6 +++---
 fs/btrfs/compression.h     |  2 +-
 fs/btrfs/extent_io.c       | 18 +++++++++---------
 fs/btrfs/inode.c           |  4 ++--
 fs/btrfs/raid56.c          |  4 ++--
 6 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 5d20137b7b67..98c6e5feab19 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -152,7 +152,7 @@ struct btrfsic_block {
 	struct btrfsic_block *next_in_same_bio;
 	void *orig_bio_private;
 	bio_end_io_t *orig_bio_end_io;
-	int submit_bio_bh_rw;
+	blk_opf_t submit_bio_bh_rw;
 	u64 flush_gen; /* only valid if !never_written */
 };
 
@@ -1681,7 +1681,7 @@ static void btrfsic_process_written_block(struct btrfsic_dev_state *dev_state,
 					  u64 dev_bytenr, char **mapped_datav,
 					  unsigned int num_pages,
 					  struct bio *bio, int *bio_is_patched,
-					  int submit_bio_bh_rw)
+					  blk_opf_t submit_bio_bh_rw)
 {
 	int is_metadata;
 	struct btrfsic_block *block;
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index f4564f32f6d9..a82b9f17f476 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -455,7 +455,7 @@ static blk_status_t submit_compressed_bio(struct btrfs_fs_info *fs_info,
 
 
 static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_bytenr,
-					unsigned int opf, bio_end_io_t endio_func,
+					blk_opf_t opf, bio_end_io_t endio_func,
 					u64 *next_stripe_start)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
@@ -505,7 +505,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				 unsigned int compressed_len,
 				 struct page **compressed_pages,
 				 unsigned int nr_pages,
-				 unsigned int write_flags,
+				 blk_opf_t write_flags,
 				 struct cgroup_subsys_state *blkcg_css,
 				 bool writeback)
 {
@@ -517,7 +517,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	blk_status_t ret;
 	int skip_sum = inode->flags & BTRFS_INODE_NODATASUM;
 	const bool use_append = btrfs_use_zone_append(inode, disk_start);
-	const unsigned int bio_op = use_append ? REQ_OP_ZONE_APPEND : REQ_OP_WRITE;
+	const enum req_op bio_op = use_append ? REQ_OP_ZONE_APPEND : REQ_OP_WRITE;
 
 	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
 	       IS_ALIGNED(len, fs_info->sectorsize));
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 2707404389a5..2b56d63e01ce 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -99,7 +99,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				  unsigned int compressed_len,
 				  struct page **compressed_pages,
 				  unsigned int nr_pages,
-				  unsigned int write_flags,
+				  blk_opf_t write_flags,
 				  struct cgroup_subsys_state *blkcg_css,
 				  bool writeback);
 void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 04e36343da3a..60a20df353e7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3357,7 +3357,7 @@ static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 static int alloc_new_bio(struct btrfs_inode *inode,
 			 struct btrfs_bio_ctrl *bio_ctrl,
 			 struct writeback_control *wbc,
-			 unsigned int opf,
+			 blk_opf_t opf,
 			 bio_end_io_t end_io_func,
 			 u64 disk_bytenr, u32 offset, u64 file_offset,
 			 enum btrfs_compression_type compress_type)
@@ -3437,7 +3437,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
  * @prev_bio_flags:  flags of previous bio to see if we can merge the current one
  * @compress_type:   compress type for current bio
  */
-static int submit_extent_page(unsigned int opf,
+static int submit_extent_page(blk_opf_t opf,
 			      struct writeback_control *wbc,
 			      struct btrfs_bio_ctrl *bio_ctrl,
 			      struct page *page, u64 disk_bytenr,
@@ -3615,7 +3615,7 @@ __get_extent_map(struct inode *inode, struct page *page, size_t pg_offset,
  */
 static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		      struct btrfs_bio_ctrl *bio_ctrl,
-		      unsigned int read_flags, u64 *prev_em_start)
+		      blk_opf_t read_flags, u64 *prev_em_start)
 {
 	struct inode *inode = page->mapping->host;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -3983,8 +3983,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	int saved_ret = 0;
 	int ret = 0;
 	int nr = 0;
-	u32 opf = REQ_OP_WRITE;
-	const unsigned int write_flags = wbc_to_write_flags(wbc);
+	enum req_op op = REQ_OP_WRITE;
+	const blk_opf_t write_flags = wbc_to_write_flags(wbc);
 	bool has_error = false;
 	bool compressed;
 
@@ -4058,7 +4058,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		iosize = min(min(em_end, end + 1), dirty_range_end) - cur;
 
 		if (btrfs_use_zone_append(inode, em->block_start))
-			opf = REQ_OP_ZONE_APPEND;
+			op = REQ_OP_ZONE_APPEND;
 
 		free_extent_map(em);
 		em = NULL;
@@ -4094,7 +4094,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		 */
 		btrfs_page_clear_dirty(fs_info, page, cur, iosize);
 
-		ret = submit_extent_page(opf | write_flags, wbc,
+		ret = submit_extent_page(op | write_flags, wbc,
 					 &epd->bio_ctrl, page,
 					 disk_bytenr, iosize,
 					 cur - page_offset(page),
@@ -4575,7 +4575,7 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct page *page = eb->pages[0];
-	unsigned int write_flags = wbc_to_write_flags(wbc) | REQ_META;
+	blk_opf_t write_flags = wbc_to_write_flags(wbc) | REQ_META;
 	bool no_dirty_ebs = false;
 	int ret;
 
@@ -4620,7 +4620,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 {
 	u64 disk_bytenr = eb->start;
 	int i, num_pages;
-	unsigned int write_flags = wbc_to_write_flags(wbc) | REQ_META;
+	blk_opf_t write_flags = wbc_to_write_flags(wbc) | REQ_META;
 	int ret = 0;
 
 	prepare_eb_write(eb);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 05e0c4a5affd..f8378c949be4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -485,7 +485,7 @@ struct async_chunk {
 	struct page *locked_page;
 	u64 start;
 	u64 end;
-	unsigned int write_flags;
+	blk_opf_t write_flags;
 	struct list_head extents;
 	struct cgroup_subsys_state *blkcg_css;
 	struct btrfs_work work;
@@ -1435,7 +1435,7 @@ static int cow_file_range_async(struct btrfs_inode *inode,
 	int i;
 	bool should_compress;
 	unsigned nofs_flag;
-	const unsigned int write_flags = wbc_to_write_flags(wbc);
+	const blk_opf_t write_flags = wbc_to_write_flags(wbc);
 
 	unlock_extent(&inode->io_tree, start, end);
 
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index a5b623ee6fac..c520412d1f86 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1136,7 +1136,7 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 			      unsigned int stripe_nr,
 			      unsigned int sector_nr,
 			      unsigned long bio_max_len,
-			      unsigned int opf)
+			      enum req_op op)
 {
 	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
 	struct bio *last = bio_list->tail;
@@ -1181,7 +1181,7 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 
 	/* put a new bio on the list */
 	bio = bio_alloc(stripe->dev->bdev, max(bio_max_len >> PAGE_SHIFT, 1UL),
-			opf, GFP_NOFS);
+			op, GFP_NOFS);
 	bio->bi_iter.bi_sector = disk_start >> 9;
 	bio->bi_private = rbio;
 
