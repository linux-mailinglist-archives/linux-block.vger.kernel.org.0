Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254CB3041EC
	for <lists+linux-block@lfdr.de>; Tue, 26 Jan 2021 16:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391453AbhAZPE5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 26 Jan 2021 10:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391796AbhAZPDw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 10:03:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85118C061A31;
        Tue, 26 Jan 2021 07:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Y3ETPQ/J5b9VzWd6gZkaTVXt4OBDcvG3hAbwDlM7Vf4=; b=mwJd/045dmJyeWS4zYv9KjfH+B
        uVMvepvUAcMJ2wO2oEm9Vj0hy/6OgYLg2wyYVvQiEp49bLmHzFb7RYP41TAxbPQJk3d0/z0b4wZ5I
        GjH7z3cKjL2XyfrdFxbViextVhLmmgrhFNzkIsiDEh/n5UjIE1U7X4vuFMroMTeTlFcEdMC00xHnu
        j1P/uVY68WPmlmuYjl8Kis/h1pNlis4wblwNZsQRu57JK1/jxVqdb02OpBkO0pBlFfw6fjrGoA+5y
        L7P23xpZ/bUuqlzT+iDWd0gG9GfO5T4JnY/ujfPIedVOLarszLq7aPsQ2C7UTvLF8Z+V9J9PTiQGw
        TelaHqLA==;
Received: from [2001:4bb8:191:e347:5918:ac86:61cb:8801] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4Pmc-005mP7-SH; Tue, 26 Jan 2021 14:58:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org, dm-devel@redhat.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 03/17] blk-crypto: use bio_kmalloc in blk_crypto_clone_bio
Date:   Tue, 26 Jan 2021 15:52:33 +0100
Message-Id: <20210126145247.1964410-4-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126145247.1964410-1-hch@lst.de>
References: <20210126145247.1964410-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use bio_kmalloc instead of open coding it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-crypto-fallback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 50c225398e4d60..e8327c50d7c9f4 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -164,7 +164,7 @@ static struct bio *blk_crypto_clone_bio(struct bio *bio_src)
 	struct bio_vec bv;
 	struct bio *bio;
 
-	bio = bio_alloc_bioset(GFP_NOIO, bio_segments(bio_src), NULL);
+	bio = bio_kmalloc(GFP_NOIO, bio_segments(bio_src));
 	if (!bio)
 		return NULL;
 	bio->bi_bdev		= bio_src->bi_bdev;
-- 
2.29.2

