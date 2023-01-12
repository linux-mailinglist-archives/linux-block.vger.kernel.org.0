Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C82E666D92
	for <lists+linux-block@lfdr.de>; Thu, 12 Jan 2023 10:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240010AbjALJLR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Jan 2023 04:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239801AbjALJKP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2023 04:10:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8902852C54;
        Thu, 12 Jan 2023 01:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mSXwh3yn6i//FaD5HLcRk7DflGHspIK+FWCFAVKfSSQ=; b=eui2GZGvSnpm9J1FPAhYS9tnL6
        uhlHL609GqDbi4ybOwOCmbLndvaMsa4RKKYF889+8q2vXMvUO+q4gh+SF4ucLi8098AQY7UG8QCJT
        Cf2cg6kjy+gz5C+x68PExxXIQw+uzn6nkWD+2yLitziQBQeHOzaAAIFM1dW1J5+Nba7CW11f3bARC
        BawDEWoqibDyDt6yRDWhlrENusXj7NT6jcRI7pwF64yLyX/tWPat7vxj2Q2WXugtCbaWYBIZxTtKO
        gAPDM+fjUyefY0OOQrRXWI1TUmyP5WcPB4QVMU+KBAa2UKxbpC638EWpiz+qZ5+Rp7iBQ6nB8cki2
        SjYIJtSg==;
Received: from [2001:4bb8:181:656b:c87d:36c9:914c:c2ea] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFtWi-00EGBn-SO; Thu, 12 Jan 2023 09:05:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 01/19] block: export bio_split_rw
Date:   Thu, 12 Jan 2023 10:05:13 +0100
Message-Id: <20230112090532.1212225-2-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230112090532.1212225-1-hch@lst.de>
References: <20230112090532.1212225-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_split_rw can be used by file systems to split and incoming write
bio into multiple bios fitting the hardware limit for use as ZONE_APPEND
bios.  Export it for initial use in btrfs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-merge.c   | 3 ++-
 include/linux/bio.h | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index b7c193d67185de..64bf7d9dd8e852 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -276,7 +276,7 @@ static bool bvec_split_segs(const struct queue_limits *lim,
  * responsible for ensuring that @bs is only destroyed after processing of the
  * split bio has finished.
  */
-static struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
+struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
 		unsigned *segs, struct bio_set *bs, unsigned max_bytes)
 {
 	struct bio_vec bv, bvprv, *bvprvp = NULL;
@@ -336,6 +336,7 @@ static struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
 	bio_clear_polled(bio);
 	return bio_split(bio, bytes >> SECTOR_SHIFT, GFP_NOIO, bs);
 }
+EXPORT_SYMBOL_GPL(bio_split_rw);
 
 /**
  * __bio_split_to_limits - split a bio to fit the queue limits
diff --git a/include/linux/bio.h b/include/linux/bio.h
index c1da63f6c80800..d766be7152e151 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -12,6 +12,8 @@
 
 #define BIO_MAX_VECS		256U
 
+struct queue_limits;
+
 static inline unsigned int bio_max_segs(unsigned int nr_segs)
 {
 	return min(nr_segs, BIO_MAX_VECS);
@@ -375,6 +377,8 @@ static inline void bip_set_seed(struct bio_integrity_payload *bip,
 void bio_trim(struct bio *bio, sector_t offset, sector_t size);
 extern struct bio *bio_split(struct bio *bio, int sectors,
 			     gfp_t gfp, struct bio_set *bs);
+struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
+		unsigned *segs, struct bio_set *bs, unsigned max_bytes);
 
 /**
  * bio_next_split - get next @sectors from a bio, splitting if necessary
-- 
2.35.1

