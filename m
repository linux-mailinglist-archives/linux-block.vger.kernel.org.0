Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982D14604D1
	for <lists+linux-block@lfdr.de>; Sun, 28 Nov 2021 06:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbhK1F6q (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 28 Nov 2021 00:58:46 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45974 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbhK1F4q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Nov 2021 00:56:46 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 092911FD41;
        Sun, 28 Nov 2021 05:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638078810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rLOaZQzvrbLdTILy3pSJ8sHXuXBuGAn0ZnLbYvMbmfE=;
        b=iWgs6G+3ghQBwaauQmt631mW4V9+sk5viaYOH7ifuaAmsiBFhEUnj317PXRutEe0H8g5u7
        /0+v5mgxKLQwp0cQj/xisfEVzExnQTF1tnFW+dCqJ032TSzle28kfPiuY0tpvnf0m1u7vw
        FE4KOOnTndfbCyxHwwip6tckCegtRaw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 100DB13446;
        Sun, 28 Nov 2021 05:53:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6BRRNFgZo2G7fAAAMHmgww
        (envelope-from <wqu@suse.com>); Sun, 28 Nov 2021 05:53:28 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH RFC 08/11] btrfs: allow btrfs_map_bio() to split bio according to chunk stripe boundaries
Date:   Sun, 28 Nov 2021 13:52:56 +0800
Message-Id: <20211128055259.39249-9-wqu@suse.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128055259.39249-1-wqu@suse.com>
References: <20211128055259.39249-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the new btrfs_bio_split() helper, we are able to split bio
according to chunk stripe boundaries at btrfs_map_bio() time.

Although currently due bio split at submit_extent_page() this ability is
not yet utilized.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 53 +++++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e6ed71195e18..7f7e13e4caa3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6878,29 +6878,48 @@ static int submit_one_mapped_range(struct btrfs_fs_info *fs_info, struct bio *bi
 blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 			   int mirror_num)
 {
-	u64 logical = bio->bi_iter.bi_sector << 9;
-	u64 length = 0;
-	u64 map_length;
+	const u64 orig_logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
+	const unsigned int orig_length = bio->bi_iter.bi_size;
+	const enum btrfs_map_op op = btrfs_op(bio);
+	u64 cur_logical = orig_logical;
 	int ret;
-	struct btrfs_io_context *bioc = NULL;
 
-	length = bio->bi_iter.bi_size;
-	map_length = length;
+	while (cur_logical < orig_logical + orig_length) {
+		u64 map_length = orig_logical + orig_length - cur_logical;
+		struct btrfs_io_context *bioc = NULL;
+		struct bio *cur_bio;
 
-	btrfs_bio_counter_inc_blocked(fs_info);
-	ret = __btrfs_map_block(fs_info, btrfs_op(bio), logical,
-				&map_length, &bioc, mirror_num, 1);
-	if (ret) {
-		btrfs_bio_counter_dec(fs_info);
-		return errno_to_blk_status(ret);
-	}
+		ret = __btrfs_map_block(fs_info, op, cur_logical, &map_length,
+					&bioc, mirror_num, 1);
+		if (ret)
+			return errno_to_blk_status(ret);
 
-	ret = submit_one_mapped_range(fs_info, bio, bioc, map_length, mirror_num);
-	if (ret < 0) {
+		if (cur_logical + map_length < orig_logical + orig_length) {
+			/*
+			 * For now zoned write should never cross stripe
+			 * boundary
+			 */
+			ASSERT(bio_op(bio) != REQ_OP_ZONE_APPEND);
+
+			/* Need to split */
+			cur_bio = btrfs_bio_split(fs_info, bio, map_length);
+			if (IS_ERR(cur_bio)) {
+				btrfs_put_bioc(bioc);
+				ret = PTR_ERR(cur_bio);
+				return errno_to_blk_status(ret);
+			}
+		} else {
+			/* Can use the existing bio directly */
+			cur_bio = bio;
+		}
+		btrfs_bio_counter_inc_blocked(fs_info);
+		ret = submit_one_mapped_range(fs_info, cur_bio, bioc,
+					      map_length, mirror_num);
 		btrfs_bio_counter_dec(fs_info);
-		return errno_to_blk_status(ret);
+		if (ret < 0)
+			return errno_to_blk_status(ret);
+		cur_logical += map_length;
 	}
-	btrfs_bio_counter_dec(fs_info);
 	return BLK_STS_OK;
 }
 
-- 
2.34.0

