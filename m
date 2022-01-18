Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2523E491FC5
	for <lists+linux-block@lfdr.de>; Tue, 18 Jan 2022 08:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244691AbiARHUM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 18 Jan 2022 02:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244684AbiARHUK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jan 2022 02:20:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08579C061574;
        Mon, 17 Jan 2022 23:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pMAOIxwEWgivE8T/8jAutxBqi67ojpc7aSJ9Dfvp1Nk=; b=kFKC1f6LHbffT6qzEiLaEuNO4Z
        y5Wa6DZ64ihxEa532MbgjcReTwtC60BjPLQEj05bs6YuEeVI3sM977SdQzX4xmobJdlgPZVs2xWyC
        EMJ38PRJqUFy7XNiizvMrGIgprvIHQUp93bgTey3sz0jg7eZMOPncNFBYMmaEZWsV/sf41kUB2N71
        F5CwruEap8s8xzf4gj6k+YJ16+23/Z0Hl+DOqrPk1VXeoCpYu2IIRMb8Gs68ph2j0gtiX2+uWw4CJ
        twPIBYTRWRfw9YLbtir6ZkrrfCdWs9qy8EIvSFTnNOFAOKv/ZGihXdRGCZZictQuPhGrpOtQoXsyI
        Sb9DHpsQ==;
Received: from [2001:4bb8:184:72a4:a4a9:19c0:5242:7768] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9imh-000ZOH-7s; Tue, 18 Jan 2022 07:20:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Md . Haris Iqbal " <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.co>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        xen-devel@lists.xenproject.org, drbd-dev@lists.linbit.com
Subject: [PATCH 03/19] nfs/blocklayout: remove bl_alloc_init_bio
Date:   Tue, 18 Jan 2022 08:19:36 +0100
Message-Id: <20220118071952.1243143-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220118071952.1243143-1-hch@lst.de>
References: <20220118071952.1243143-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_alloc will never fail when it can sleep.  Remove the now simple
bl_alloc_init_bio helper and open code it in the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/blocklayout/blocklayout.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index fe860c5387476..38e063af7e98a 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -115,23 +115,6 @@ bl_submit_bio(struct bio *bio)
 	return NULL;
 }
 
-static struct bio *bl_alloc_init_bio(unsigned int npg,
-		struct block_device *bdev, sector_t disk_sector,
-		bio_end_io_t end_io, struct parallel_io *par)
-{
-	struct bio *bio;
-
-	npg = bio_max_segs(npg);
-	bio = bio_alloc(GFP_NOIO, npg);
-	if (bio) {
-		bio->bi_iter.bi_sector = disk_sector;
-		bio_set_dev(bio, bdev);
-		bio->bi_end_io = end_io;
-		bio->bi_private = par;
-	}
-	return bio;
-}
-
 static bool offset_in_map(u64 offset, struct pnfs_block_dev_map *map)
 {
 	return offset >= map->start && offset < map->start + map->len;
@@ -171,10 +154,11 @@ do_add_page_to_bio(struct bio *bio, int npg, int rw, sector_t isect,
 
 retry:
 	if (!bio) {
-		bio = bl_alloc_init_bio(npg, map->bdev,
-				disk_addr >> SECTOR_SHIFT, end_io, par);
-		if (!bio)
-			return ERR_PTR(-ENOMEM);
+		bio = bio_alloc(GFP_NOIO, bio_max_segs(npg));
+		bio->bi_iter.bi_sector = disk_addr >> SECTOR_SHIFT;
+		bio_set_dev(bio, map->bdev);
+		bio->bi_end_io = end_io;
+		bio->bi_private = par;
 		bio_set_op_attrs(bio, rw, 0);
 	}
 	if (bio_add_page(bio, page, *len, offset) < *len) {
-- 
2.30.2

