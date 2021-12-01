Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E355464659
	for <lists+linux-block@lfdr.de>; Wed,  1 Dec 2021 06:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346685AbhLAFVn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 1 Dec 2021 00:21:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37850 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346681AbhLAFVm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Dec 2021 00:21:42 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CDCDB1FD58;
        Wed,  1 Dec 2021 05:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638335901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0k5r3Ppeq7X0JPWJaz4PsLw9OcvoR9EQFZumBQyap1I=;
        b=ZtcBclRvynGj7aJ1bxbsXoHLouToEpEV0mhHt9BBGIU7M3mjw/DXMs1TUHM4/ooeL4TpLg
        OZlLJBWHrkk27wxB6mPtHC+SYpWbYJrIJKBlHhEeCkP4bc3aE1lCO/TPDcv8WEyNiiPbLR
        y384b8A0ZyjMixaw30Pwu8qq2MPbjZc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D23F413425;
        Wed,  1 Dec 2021 05:18:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sFzaJ5wFp2EGbwAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 01 Dec 2021 05:18:20 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 05/17] btrfs: move btrfs_bio_wq_end_io() calls into submit_stripe_bio()
Date:   Wed,  1 Dec 2021 13:17:44 +0800
Message-Id: <20211201051756.53742-6-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211201051756.53742-1-wqu@suse.com>
References: <20211201051756.53742-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a preparation patch for the incoming chunk mapping layer bio
split.

Function btrfs_bio_wq_end_io() is going to remap bio::bi_private and
bio::bi_end_io so that the real endio function will be executed in a
workqueue.

The problem is, remapped bio::bi_private will be a newly allocated
memory, and after the original endio executed, the memory will be freed.

This will not work well with split bio.

So this patch will move all btrfs_bio_wq_end_io() call into one helper
function, btrfs_bio_final_endio_remap(), and call that helper in
submit_stripe_bio().

This refactor also unified all data bio behaviors.

Before this patch, compressed bio no matter if read or write, will
always be delayed using workqueue.

However all data write operations are already delayed using ordered
extent, and all metadata write doesn't need any delayed execution.

Thus this patch will make compressed bios follow the same data
read/write behavior.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c |  4 +---
 fs/btrfs/disk-io.c     |  9 +--------
 fs/btrfs/inode.c       | 20 +++++---------------
 fs/btrfs/volumes.c     | 41 +++++++++++++++++++++++++++++++++++++----
 fs/btrfs/volumes.h     |  9 ++++++++-
 5 files changed, 52 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index cc8d13369f53..8668c5190805 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -429,10 +429,8 @@ static blk_status_t submit_compressed_bio(struct btrfs_fs_info *fs_info,
 {
 	blk_status_t ret;
 
+	btrfs_bio(bio)->endio_type = BTRFS_WQ_ENDIO_DATA;
 	ASSERT(bio->bi_iter.bi_size);
-	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
-	if (ret)
-		return ret;
 	ret = btrfs_map_bio(fs_info, bio, mirror_num);
 	return ret;
 }
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5c598e124c25..ce7c5a16df04 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -920,14 +920,7 @@ blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
 	blk_status_t ret;
 
 	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
-		/*
-		 * called for a read, do the setup so that checksum validation
-		 * can happen in the async kernel threads
-		 */
-		ret = btrfs_bio_wq_end_io(fs_info, bio,
-					  BTRFS_WQ_ENDIO_METADATA);
-		if (ret)
-			goto out_w_error;
+		btrfs_bio(bio)->endio_type = BTRFS_WQ_ENDIO_METADATA;
 		ret = btrfs_map_bio(fs_info, bio, mirror_num);
 	} else if (!should_async_write(fs_info, BTRFS_I(inode))) {
 		ret = btree_csum_one_bio(bio);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 126d2117954c..007a20a9b076 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2511,7 +2511,7 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
-	enum btrfs_wq_endio_type metadata = BTRFS_WQ_ENDIO_DATA;
+	enum btrfs_wq_endio_type endio_type = BTRFS_WQ_ENDIO_DATA;
 	blk_status_t ret = 0;
 	int skip_sum;
 	int async = !atomic_read(&BTRFS_I(inode)->sync_writers);
@@ -2520,7 +2520,7 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 		test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state);
 
 	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
-		metadata = BTRFS_WQ_ENDIO_FREE_SPACE;
+		endio_type = BTRFS_WQ_ENDIO_FREE_SPACE;
 
 	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
 		struct page *page = bio_first_bvec_all(bio)->bv_page;
@@ -2532,10 +2532,7 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 	}
 
 	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
-		ret = btrfs_bio_wq_end_io(fs_info, bio, metadata);
-		if (ret)
-			goto out;
-
+		btrfs_bio(bio)->endio_type = endio_type;
 		if (bio_flags & EXTENT_BIO_COMPRESSED) {
 			ret = btrfs_submit_compressed_read(inode, bio,
 							   mirror_num,
@@ -8090,10 +8087,6 @@ static blk_status_t submit_dio_repair_bio(struct inode *inode, struct bio *bio,
 
 	BUG_ON(bio_op(bio) == REQ_OP_WRITE);
 
-	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
-	if (ret)
-		return ret;
-
 	refcount_inc(&dip->refs);
 	ret = btrfs_map_bio(fs_info, bio, mirror_num);
 	if (ret)
@@ -8219,11 +8212,8 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 	if (async_submit)
 		async_submit = !atomic_read(&BTRFS_I(inode)->sync_writers);
 
-	if (!write) {
-		ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
-		if (ret)
-			goto err;
-	}
+	if (!write)
+		btrfs_bio(bio)->endio_type = BTRFS_WQ_ENDIO_DATA;
 
 	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
 		goto map;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3dc759996f55..af01d54502ab 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6725,10 +6725,31 @@ static void btrfs_end_bio(struct bio *bio)
 	}
 }
 
-static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bio *bio,
-			      u64 physical, struct btrfs_device *dev)
+/*
+ * Endio remaps which can't handle cloned bio needs to go here.
+ *
+ * Currently it's only btrfs_bio_wq_end_io().
+ */
+static int btrfs_bio_final_endio_remap(struct btrfs_fs_info *fs_info,
+				       struct bio *bio)
+{
+	blk_status_t sts;
+
+	/* For write bio, we don't to put their endio into wq */
+	if (btrfs_op(bio) == BTRFS_MAP_WRITE)
+		return 0;
+
+	sts = btrfs_bio_wq_end_io(fs_info, bio, btrfs_bio(bio)->endio_type);
+	if (sts != BLK_STS_OK)
+		return blk_status_to_errno(sts);
+	return 0;
+}
+
+static int submit_stripe_bio(struct btrfs_io_context *bioc, struct bio *bio,
+			     u64 physical, struct btrfs_device *dev)
 {
 	struct btrfs_fs_info *fs_info = bioc->fs_info;
+	int ret;
 
 	bio->bi_private = bioc;
 	btrfs_bio(bio)->device = dev;
@@ -6755,9 +6776,14 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bio *bio,
 		dev->devid, bio->bi_iter.bi_size);
 	bio_set_dev(bio, dev->bdev);
 
-	btrfs_bio_counter_inc_noblocked(fs_info);
+	/* Do the final endio remap if needed */
+	ret = btrfs_bio_final_endio_remap(fs_info, bio);
+	if (ret < 0)
+		return ret;
 
+	btrfs_bio_counter_inc_noblocked(fs_info);
 	btrfsic_submit_bio(bio);
+	return ret;
 }
 
 static void bioc_error(struct btrfs_io_context *bioc, struct bio *bio, u64 logical)
@@ -6845,9 +6871,16 @@ static int submit_one_mapped_range(struct btrfs_fs_info *fs_info, struct bio *bi
 		else
 			bio = first_bio;
 
-		submit_stripe_bio(bioc, bio, bioc->stripes[dev_nr].physical, dev);
+		ret = submit_stripe_bio(bioc, bio,
+					bioc->stripes[dev_nr].physical, dev);
+		if (ret < 0)
+			goto error;
 	}
 	return 0;
+error:
+	for (; dev_nr < total_devs; dev_nr++)
+		bioc_error(bioc, first_bio, logical);
+	return ret;
 }
 
 blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index f9178d2c2fd6..f88f39042558 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -328,7 +328,14 @@ struct btrfs_fs_devices {
  * Mostly for btrfs specific features like csum and mirror_num.
  */
 struct btrfs_bio {
-	unsigned int mirror_num;
+	u16 mirror_num;
+
+	/*
+	 * To tell which workqueue the bio's endio should be exeucted in.
+	 *
+	 * Only for read bios.
+	 */
+	u16 endio_type;
 
 	/* @device is for stripe IO submission. */
 	struct btrfs_device *device;
-- 
2.34.1

