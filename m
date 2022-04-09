Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81EB4FA3FA
	for <lists+linux-block@lfdr.de>; Sat,  9 Apr 2022 06:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240920AbiDIE4G (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 9 Apr 2022 00:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241246AbiDIEzb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Apr 2022 00:55:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC7FBC856;
        Fri,  8 Apr 2022 21:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=lTB3LIlofJfzp5KujAOXuh07LxC0Nf6YEWOtuNxxhyY=; b=C0/EZiE5vXySiqiaR4lBvJuEun
        PCkY/ivUhVSq0xZoAuTVkd2q0WdTP70v6IpmHQ/nr8sL06I0WApI6WB4Nc+BbTwxAexvvl3o5Ltp3
        NtnBftYhjSPcpEVgAsuShaR7m9KbWMRIWCDXyDwu8QO3RK/4EmffFxBCB2g7UXEp1y2leacInCz+W
        UTrT+NDk4VRd1AMJLFu+mpvUpIkM7YRkxENQ4fhPoNiM5RKk5R/iGUTs4IdJSAgoOKNJMsH7MttHB
        e3x6X6lyJLvnR+0gfPxkVm1chSgZ4D2Gc+Jlqd61ZtPmRE05FoHvGDrQ/zbOvv7XIwtnu+Jwn9F73
        97nxUNyA==;
Received: from 213-147-167-116.nat.highway.webapn.at ([213.147.167.116] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nd34y-0021Vo-16; Sat, 09 Apr 2022 04:52:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@oss.oracle.com, linux-mm@kvack.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Coly Li <colyli@suse.de>
Subject: [PATCH 22/27] block: refactor discard bio size limiting
Date:   Sat,  9 Apr 2022 06:50:38 +0200
Message-Id: <20220409045043.23593-23-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220409045043.23593-1-hch@lst.de>
References: <20220409045043.23593-1-hch@lst.de>
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

Move all the logic to limit the discard bio size into a common helper
so that it is better documented.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Acked-by: Coly Li <colyli@suse.de>
---
 block/blk-lib.c | 59 ++++++++++++++++++++++++-------------------------
 block/blk.h     | 14 ------------
 2 files changed, 29 insertions(+), 44 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 237d60d8b5857..2ae32a722851c 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -10,6 +10,32 @@
 
 #include "blk.h"
 
+static sector_t bio_discard_limit(struct block_device *bdev, sector_t sector)
+{
+	unsigned int discard_granularity =
+		bdev_get_queue(bdev)->limits.discard_granularity;
+	sector_t granularity_aligned_sector;
+
+	if (bdev_is_partition(bdev))
+		sector += bdev->bd_start_sect;
+
+	granularity_aligned_sector =
+		round_up(sector, discard_granularity >> SECTOR_SHIFT);
+
+	/*
+	 * Make sure subsequent bios start aligned to the discard granularity if
+	 * it needs to be split.
+	 */
+	if (granularity_aligned_sector != sector)
+		return granularity_aligned_sector - sector;
+
+	/*
+	 * Align the bio size to the discard granularity to make splitting the bio
+	 * at discard granularity boundaries easier in the driver if needed.
+	 */
+	return round_down(UINT_MAX, discard_granularity) >> SECTOR_SHIFT;
+}
+
 int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, int flags,
 		struct bio **biop)
@@ -17,7 +43,7 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	struct request_queue *q = bdev_get_queue(bdev);
 	struct bio *bio = *biop;
 	unsigned int op;
-	sector_t bs_mask, part_offset = 0;
+	sector_t bs_mask;
 
 	if (bdev_read_only(bdev))
 		return -EPERM;
@@ -48,36 +74,9 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	if (!nr_sects)
 		return -EINVAL;
 
-	/* In case the discard request is in a partition */
-	if (bdev_is_partition(bdev))
-		part_offset = bdev->bd_start_sect;
-
 	while (nr_sects) {
-		sector_t granularity_aligned_lba, req_sects;
-		sector_t sector_mapped = sector + part_offset;
-
-		granularity_aligned_lba = round_up(sector_mapped,
-				q->limits.discard_granularity >> SECTOR_SHIFT);
-
-		/*
-		 * Check whether the discard bio starts at a discard_granularity
-		 * aligned LBA,
-		 * - If no: set (granularity_aligned_lba - sector_mapped) to
-		 *   bi_size of the first split bio, then the second bio will
-		 *   start at a discard_granularity aligned LBA on the device.
-		 * - If yes: use bio_aligned_discard_max_sectors() as the max
-		 *   possible bi_size of the first split bio. Then when this bio
-		 *   is split in device drive, the split ones are very probably
-		 *   to be aligned to discard_granularity of the device's queue.
-		 */
-		if (granularity_aligned_lba == sector_mapped)
-			req_sects = min_t(sector_t, nr_sects,
-					  bio_aligned_discard_max_sectors(q));
-		else
-			req_sects = min_t(sector_t, nr_sects,
-					  granularity_aligned_lba - sector_mapped);
-
-		WARN_ON_ONCE((req_sects << 9) > UINT_MAX);
+		sector_t req_sects =
+			min(nr_sects, bio_discard_limit(bdev, sector));
 
 		bio = blk_next_bio(bio, bdev, 0, op, gfp_mask);
 		bio->bi_iter.bi_sector = sector;
diff --git a/block/blk.h b/block/blk.h
index 8ccbc6e076369..1fdc1d28e6d60 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -346,20 +346,6 @@ static inline unsigned int bio_allowed_max_sectors(struct request_queue *q)
 	return round_down(UINT_MAX, queue_logical_block_size(q)) >> 9;
 }
 
-/*
- * The max bio size which is aligned to q->limits.discard_granularity. This
- * is a hint to split large discard bio in generic block layer, then if device
- * driver needs to split the discard bio into smaller ones, their bi_size can
- * be very probably and easily aligned to discard_granularity of the device's
- * queue.
- */
-static inline unsigned int bio_aligned_discard_max_sectors(
-					struct request_queue *q)
-{
-	return round_down(UINT_MAX, q->limits.discard_granularity) >>
-			SECTOR_SHIFT;
-}
-
 /*
  * Internal io_context interface
  */
-- 
2.30.2

