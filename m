Return-Path: <linux-block+bounces-17370-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8809A3AFC2
	for <lists+linux-block@lfdr.de>; Wed, 19 Feb 2025 03:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44E317091E
	for <lists+linux-block@lfdr.de>; Wed, 19 Feb 2025 02:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A721A18FDC5;
	Wed, 19 Feb 2025 02:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSM4znQD"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F47189F3B
	for <linux-block@vger.kernel.org>; Wed, 19 Feb 2025 02:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739933061; cv=none; b=hVMtI2ej3Av6UkCbvMQ88mTRFfzXpl4nkX7gWygqiP0alLXFYI6rzKdhunp7S87OfS8X3HuNUn92RnCbWjuiiBOK6/7i5C+54NAWbCnz+NOTvzDl+RrUXda6sfAIYlftpzNmQ9jiVmFM9L4efCKkT9JQNPewxvLF1C29IyeqoJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739933061; c=relaxed/simple;
	bh=i6UpQpQlQfLQ3FamC1VRt3WlkDFzAged4tiAACJzat0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WDJPl5bVyWnEIYNCNMIKa081kmnKVfwSz0zsGxuPf83HonotsQkeg5IiSmXFbzaPCkL7qB1Xjs1fv3qvbb19f7sfGt3OXMpaMBtpkwBRGti7MYKL9r/UnVtVnaL0RAE6HLq1C9OFQv4lqU9s4kspQeO67hwiAv1yVdYmhI+ka2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WSM4znQD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739933058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b/ujDiLWLIYQsi6SqCInl0qoQJfQozhD3N7cOdb8eDY=;
	b=WSM4znQDIfe2WWEhHXtLyqC/N32NI0B4OpV9oTzbDoiskv6IByq/9xjGxrDIjw99H0OkLj
	dbC94is0idtzzdSo20rPQtiCGSEBityLuAGfd1JH9ql2Cqst/4MHJdz7y+5Qo2yB/RzoIe
	xhZOrXWcvbkq5yHGMUKpiwh+QUxip8U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-aBzFgj6zMFeEpEOLJ5_oaQ-1; Tue,
 18 Feb 2025 21:44:17 -0500
X-MC-Unique: aBzFgj6zMFeEpEOLJ5_oaQ-1
X-Mimecast-MFC-AGG-ID: aBzFgj6zMFeEpEOLJ5_oaQ_1739933055
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F62F1955F28;
	Wed, 19 Feb 2025 02:44:15 +0000 (UTC)
Received: from localhost (unknown [10.72.120.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4BD75180056F;
	Wed, 19 Feb 2025 02:44:13 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Paul Bunyan <pbunyan@redhat.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Keith Busch <kbusch@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V4] block: make segment size limit workable for > 4K PAGE_SIZE
Date: Wed, 19 Feb 2025 10:44:09 +0800
Message-ID: <20250219024409.901186-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

PAGE_SIZE is applied in validating block device queue limits, this way is
very fragile and is wrong:

- queue limits are read from hardware, which is often one readonly hardware
property

- PAGE_SIZE is one config option which can be changed during build time.

In RH lab, it has been found that max segment size of some mmc card is
less than 64K, then this kind of card can't be probed successfully when
same kernel is re-built with 64K PAGE_SIZE.

Fix this issue by adding BLK_MIN_SEGMENT_SIZE and lim->min_segment_size:

- validate segment limits by BLK_MIN_SEGMENT_SIZE which is 4K(minimized PAGE_SIZE)

- checking if one bvec can be one segment quickly by lim->min_segment_size

commit 6aeb4f836480 ("block: remove bio_add_pc_page")
commit 02ee5d69e3ba ("block: remove blk_rq_bio_prep")
commit b7175e24d6ac ("block: add a dma mapping iterator")

Cc: Daniel Gomez <da.gomez@kernel.org>
Cc: Paul Bunyan <pbunyan@redhat.com>
Cc: Yi Zhang <yi.zhang@redhat.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>
Cc: Keith Busch <kbusch@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V4:
	- take Daniel's suggestion to add min_segment_size limit
    for avoiding to call into split code in case that max_seg_size
    is > PAGE_SIZE

V3:
	- rephrase commit log & fix patch style(Christoph)
	- more comment log(Christoph)
V2:
	- cover bio_split_rw_at()
	- add BLK_MIN_SEGMENT_SIZE


 block/blk-merge.c      |  2 +-
 block/blk-settings.c   | 14 +++++++++++---
 block/blk.h            |  8 ++++++--
 include/linux/blkdev.h |  3 +++
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 15cd231d560c..4fe2dfabfc9d 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -329,7 +329,7 @@ int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
 
 		if (nsegs < lim->max_segments &&
 		    bytes + bv.bv_len <= max_bytes &&
-		    bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
+		    bv.bv_offset + bv.bv_len <= lim->min_segment_size) {
 			nsegs++;
 			bytes += bv.bv_len;
 		} else {
diff --git a/block/blk-settings.c b/block/blk-settings.c
index c44dadc35e1e..703a9217414e 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -246,6 +246,7 @@ int blk_validate_limits(struct queue_limits *lim)
 {
 	unsigned int max_hw_sectors;
 	unsigned int logical_block_sectors;
+	unsigned long seg_size;
 	int err;
 
 	/*
@@ -303,7 +304,7 @@ int blk_validate_limits(struct queue_limits *lim)
 	max_hw_sectors = min_not_zero(lim->max_hw_sectors,
 				lim->max_dev_sectors);
 	if (lim->max_user_sectors) {
-		if (lim->max_user_sectors < PAGE_SIZE / SECTOR_SIZE)
+		if (lim->max_user_sectors < BLK_MIN_SEGMENT_SIZE / SECTOR_SIZE)
 			return -EINVAL;
 		lim->max_sectors = min(max_hw_sectors, lim->max_user_sectors);
 	} else if (lim->io_opt > (BLK_DEF_MAX_SECTORS_CAP << SECTOR_SHIFT)) {
@@ -341,7 +342,7 @@ int blk_validate_limits(struct queue_limits *lim)
 	 */
 	if (!lim->seg_boundary_mask)
 		lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
-	if (WARN_ON_ONCE(lim->seg_boundary_mask < PAGE_SIZE - 1))
+	if (WARN_ON_ONCE(lim->seg_boundary_mask < BLK_MIN_SEGMENT_SIZE - 1))
 		return -EINVAL;
 
 	/*
@@ -362,10 +363,17 @@ int blk_validate_limits(struct queue_limits *lim)
 		 */
 		if (!lim->max_segment_size)
 			lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
-		if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
+		if (WARN_ON_ONCE(lim->max_segment_size < BLK_MIN_SEGMENT_SIZE))
 			return -EINVAL;
 	}
 
+	/* setup min segment size for building new segment in fast path */
+	if (lim->seg_boundary_mask > lim->max_segment_size - 1)
+		seg_size = lim->max_segment_size;
+	else
+		seg_size = lim->seg_boundary_mask + 1;
+	lim->min_segment_size = min_t(unsigned, seg_size, PAGE_SIZE);
+
 	/*
 	 * We require drivers to at least do logical block aligned I/O, but
 	 * historically could not check for that due to the separate calls
diff --git a/block/blk.h b/block/blk.h
index 90fa5f28ccab..57fe8261e09f 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -358,8 +358,12 @@ struct bio *bio_split_zone_append(struct bio *bio,
 static inline bool bio_may_need_split(struct bio *bio,
 		const struct queue_limits *lim)
 {
-	return lim->chunk_sectors || bio->bi_vcnt != 1 ||
-		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > PAGE_SIZE;
+	if (lim->chunk_sectors)
+		return true;
+	if (bio->bi_vcnt != 1)
+		return true;
+	return bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset >
+		lim->min_segment_size;
 }
 
 /**
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 248416ecd01c..1f7d492975c1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -367,6 +367,7 @@ struct queue_limits {
 	unsigned int		max_sectors;
 	unsigned int		max_user_sectors;
 	unsigned int		max_segment_size;
+	unsigned int		min_segment_size;
 	unsigned int		physical_block_size;
 	unsigned int		logical_block_size;
 	unsigned int		alignment_offset;
@@ -1163,6 +1164,8 @@ static inline bool bdev_is_partition(struct block_device *bdev)
 enum blk_default_limits {
 	BLK_MAX_SEGMENTS	= 128,
 	BLK_SAFE_MAX_SECTORS	= 255,
+	/* use minimized PAGE_SIZE as min segment size hint */
+	BLK_MIN_SEGMENT_SIZE	= 4096,
 	BLK_MAX_SEGMENT_SIZE	= 65536,
 	BLK_SEG_BOUNDARY_MASK	= 0xFFFFFFFFUL,
 };
-- 
2.47.1


