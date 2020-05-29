Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBD01E83CF
	for <lists+linux-block@lfdr.de>; Fri, 29 May 2020 18:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgE2Qfj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 29 May 2020 12:35:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:48160 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgE2Qfj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 12:35:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A7EC6ABE2;
        Fri, 29 May 2020 16:35:37 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-block@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>,
        Acshai Manoj <acshai.manoj@microfocus.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Enzo Matsumiya <ematsumiya@suse.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>, Xiao Ni <xni@redhat.com>
Subject: [PATCH v2] block: improve discard bio alignment in __blkdev_issue_discard()
Date:   Sat, 30 May 2020 00:34:18 +0800
Message-Id: <20200529163418.101606-1-colyli@suse.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch improves discard bio split for address and size alignment in
__blkdev_issue_discard(). The aligned discard bio may help underlying
device controller to perform better discard and internal garbage
collection, and avoid unnecessary internal fragment.

Current discard bio split algorithm in __blkdev_issue_discard() may have
non-discarded fregment on device even the discard bio LBA and size are
both aligned to device's discard granularity size.

Here is the example steps on how to reproduce the above problem.
- On a VMWare ESXi 6.5 update3 installation, create a 51GB virtual disk
  with thin mode and give it to a Linux virtual machine.
- Inside the Linux virtual machine, if the 50GB virtual disk shows up as
  /dev/sdb, fill data into the first 50GB by,
	# dd if=/dev/zero of=/dev/sdb bs=4096 count=13107200
- Discard the 50GB range from offset 0 on /dev/sdb,
	# blkdiscard /dev/sdb -o 0 -l 53687091200
- Observe the underlying mapping status of the device
	# sg_get_lba_status /dev/sdb -m 1048 --lba=0
  descriptor LBA: 0x0000000000000000  blocks: 2048  mapped (or unknown)
  descriptor LBA: 0x0000000000000800  blocks: 16773120  deallocated
  descriptor LBA: 0x0000000000fff800  blocks: 2048  mapped (or unknown)
  descriptor LBA: 0x0000000001000000  blocks: 8386560  deallocated
  descriptor LBA: 0x00000000017ff800  blocks: 2048  mapped (or unknown)
  descriptor LBA: 0x0000000001800000  blocks: 8386560  deallocated
  descriptor LBA: 0x0000000001fff800  blocks: 2048  mapped (or unknown)
  descriptor LBA: 0x0000000002000000  blocks: 8386560  deallocated
  descriptor LBA: 0x00000000027ff800  blocks: 2048  mapped (or unknown)
  descriptor LBA: 0x0000000002800000  blocks: 8386560  deallocated
  descriptor LBA: 0x0000000002fff800  blocks: 2048  mapped (or unknown)
  descriptor LBA: 0x0000000003000000  blocks: 8386560  deallocated
  descriptor LBA: 0x00000000037ff800  blocks: 2048  mapped (or unknown)
  descriptor LBA: 0x0000000003800000  blocks: 8386560  deallocated
  descriptor LBA: 0x0000000003fff800  blocks: 2048  mapped (or unknown)
  descriptor LBA: 0x0000000004000000  blocks: 8386560  deallocated
  descriptor LBA: 0x00000000047ff800  blocks: 2048  mapped (or unknown)
  descriptor LBA: 0x0000000004800000  blocks: 8386560  deallocated
  descriptor LBA: 0x0000000004fff800  blocks: 2048  mapped (or unknown)
  descriptor LBA: 0x0000000005000000  blocks: 8386560  deallocated
  descriptor LBA: 0x00000000057ff800  blocks: 2048  mapped (or unknown)
  descriptor LBA: 0x0000000005800000  blocks: 8386560  deallocated
  descriptor LBA: 0x0000000005fff800  blocks: 2048  mapped (or unknown)
  descriptor LBA: 0x0000000006000000  blocks: 6291456  deallocated
  descriptor LBA: 0x0000000006600000  blocks: 0  deallocated

Although the discard bio starts at LBA 0 and has 50<<30 bytes size which
are perfect aligned to the discard granularity, from the above list
these are many 1MB (2048 sectors) internal fragments exist unexpectedly.

The problem is in __blkdev_issue_discard(), an improper algorithm causes
an improper bio size which is not aligned.

 25 int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 26                 sector_t nr_sects, gfp_t gfp_mask, int flags,
 27                 struct bio **biop)
 28 {
 29         struct request_queue *q = bdev_get_queue(bdev);
   [snipped]
 56
 57         while (nr_sects) {
 58                 sector_t req_sects = min_t(sector_t, nr_sects,
 59                                 bio_allowed_max_sectors(q));
 60
 61                 WARN_ON_ONCE((req_sects << 9) > UINT_MAX);
 62
 63                 bio = blk_next_bio(bio, 0, gfp_mask);
 64                 bio->bi_iter.bi_sector = sector;
 65                 bio_set_dev(bio, bdev);
 66                 bio_set_op_attrs(bio, op, 0);
 67
 68                 bio->bi_iter.bi_size = req_sects << 9;
 69                 sector += req_sects;
 70                 nr_sects -= req_sects;
   [snipped]
 79         }
 80
 81         *biop = bio;
 82         return 0;
 83 }
 84 EXPORT_SYMBOL(__blkdev_issue_discard);

At line 58-59, to discard a 50GB range, req_sets is set as return value
of bio_allowed_max_sectors(q), which is 8388607 sectors. In the above
case, the discard granularity is 2048 sectors, although the start LBA
and discard length are aligned to discard granularity, seq_sets never
has chance to be aligned to discard granularity. This is why there are
some still-mapped 2048 sectors segment in every 4 or 8 GB range.

Because queue's max_discard_sectors is aligned to discard granularity,
if req_sects at line 58 is set to a value closest to UINT_MAX and
aligned to q->limits.max_discard_sectors, then all consequent split bios
inside device driver are (almostly) aligned to discard_granularity of
the device queue.

This patch introduces bio_aligned_discard_max_sectors() to return the
closet to UINT_MAX and aligned to q->limits.discard_granularity value,
and replace bio_allowed_max_sectors() with this new inline routine to
decide the split bio length.

But we still need to handle the situation when discard start LBA is not
aligned to q->limits.discard_granularity, otherwise even the length is
aligned, current code may still leave 2048 segment around every 4BG
range. Thereforeto calculate req_sects, firstly the start LBA of discard
request command is checked, if it is not aligned to discard granularity,
the first split location should make sure following bio has bi_sector
aligned to discard granularity. Then there won't be still-mapped segment
in the middle of the discard range.

The above is how this patch improves discard bio alignment in
__blkdev_issue_discard(). Now with this patch, after discard with same
command line mentiond previously, sg_get_lba_status returns,
descriptor LBA: 0x0000000000000000  blocks: 106954752  deallocated
descriptor LBA: 0x0000000006600000  blocks: 0  deallocated

We an see there is no 2048 sectors segment anymore, everything is clean.

Reported-by: Acshai Manoj <acshai.manoj@microfocus.com>
Signed-off-by: Coly Li <colyli@suse.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Enzo Matsumiya <ematsumiya@suse.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Xiao Ni <xni@redhat.com>
---
Changelog:
v2: replace 9 with SECTOR_SHIFT as suggested by Bart Van Assche.
v1: initial version.

 block/blk-lib.c | 25 +++++++++++++++++++++++--
 block/blk.h     | 15 +++++++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 5f2c429d4378..2fc0e3cc1ed8 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -55,8 +55,29 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		return -EINVAL;
 
 	while (nr_sects) {
-		sector_t req_sects = min_t(sector_t, nr_sects,
-				bio_allowed_max_sectors(q));
+		sector_t granularity_aligned_lba;
+		sector_t req_sects;
+
+		granularity_aligned_lba =
+			round_up(sector, q->limits.discard_granularity);
+
+		/*
+		 * Check whether the discard bio starts at a discard_granularity
+		 * aligned LBA,
+		 * - If no: set (granularity_aligned_lba - sector) to bi_size of
+		 *   the first split bio, then the second bio will start at a
+		 *   discard_granularity aligned LBA.
+		 * - If yes: use bio_aligned_discard_max_sectors() as the max
+		 *   possible bi_size of th first split bio. Then when this bio
+		 *   is split in device drive, the split ones are always easier
+		 *   to be aligned to max_discard_sectors of the device's queue.
+		 */
+		if (granularity_aligned_lba == sector)
+			req_sects = min_t(sector_t, nr_sects,
+					  bio_aligned_discard_max_sectors(q));
+		else
+			req_sects = min_t(sector_t, nr_sects,
+					  granularity_aligned_lba - sector);
 
 		WARN_ON_ONCE((req_sects << 9) > UINT_MAX);
 
diff --git a/block/blk.h b/block/blk.h
index 0a94ec68af32..dc5369e7e1fb 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -292,6 +292,21 @@ static inline unsigned int bio_allowed_max_sectors(struct request_queue *q)
 	return round_down(UINT_MAX, queue_logical_block_size(q)) >> 9;
 }
 
+/*
+ * The max bio size which is aligned to q->limits.max_discard_sectors. This
+ * is a hint to split large discard bio in generic block layer, then if device
+ * driver needs to split the discard bio into smaller ones, their bi_size can
+ * be very probably and easily ligned to max_discard_sectors of the device's
+ * queue.
+ */
+static inline unsigned int bio_aligned_discard_max_sectors(
+					struct request_queue *q)
+{
+	return round_down(UINT_MAX,
+			 (q->limits.max_discard_sectors << SECTOR_SHIFT))
+			>> SECTOR_SHIFT;
+}
+
 /*
  * Internal io_context interface
  */
-- 
2.25.0

