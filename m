Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D09912527
	for <lists+linux-block@lfdr.de>; Fri,  3 May 2019 01:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbfEBXeL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 2 May 2019 19:34:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52686 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfEBXeL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 May 2019 19:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=o8jKHmlQZx/3wRhJhr2SRdh64gHN/m/4emEu4A3A6t0=; b=rMyTYCSr81msdCa/AWWXMKvBRj
        oXSrQg7AAGHCcGn/zW2RX63+GVpJGqWhAX6cSAID5KEkmUwUr5tVAWpb6FWVHVJ1GoQtvHADGi+pF
        CMyUwkCU257SyvuVOvv7oRDvGGL3WI5Ky+Jfztdj29yQQ6a6VZV5n6cJpLHK8tJlMH4GM71YoaMfe
        dOlQKMYPrBj0E9DAdqCaMiTSzWztiWMkBQhBUR/3N3NJhP8THYjO9YtXLZsx2BK6xtOGn49scBLMD
        YTQDWnKyeojzF0u26dm6L+ci/Z0wnX7hmlPnR3w3TjjKaBiiKezSKMQ+IzTV0Edc8ilaI2JTRB1vO
        E5gZAJHA==;
Received: from [12.246.51.142] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMLDO-0002l1-Ti; Thu, 02 May 2019 23:34:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/8] block: move the BIO_NO_PAGE_REF check into bio_release_pages
Date:   Thu,  2 May 2019 19:33:25 -0400
Message-Id: <20190502233332.28720-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502233332.28720-1-hch@lst.de>
References: <20190502233332.28720-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move the BIO_NO_PAGE_REF check into bio_release_pages instead of
duplicating it in both callers.

Also make the function available outside of bio.c so that we can
reuse it in other direct I/O implementations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 11 ++++++-----
 include/linux/bio.h |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 683cbb40f051..96ddffa49881 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -855,11 +855,14 @@ static void bio_get_pages(struct bio *bio)
 		get_page(bvec->bv_page);
 }
 
-static void bio_release_pages(struct bio *bio)
+void bio_release_pages(struct bio *bio)
 {
 	struct bvec_iter_all iter_all;
 	struct bio_vec *bvec;
 
+	if (bio_flagged(bio, BIO_NO_PAGE_REF))
+		return;
+
 	bio_for_each_segment_all(bvec, bio, iter_all)
 		put_page(bvec->bv_page);
 }
@@ -1692,8 +1695,7 @@ static void bio_dirty_fn(struct work_struct *work)
 		next = bio->bi_private;
 
 		bio_set_pages_dirty(bio);
-		if (!bio_flagged(bio, BIO_NO_PAGE_REF))
-			bio_release_pages(bio);
+		bio_release_pages(bio);
 		bio_put(bio);
 	}
 }
@@ -1709,8 +1711,7 @@ void bio_check_pages_dirty(struct bio *bio)
 			goto defer;
 	}
 
-	if (!bio_flagged(bio, BIO_NO_PAGE_REF))
-		bio_release_pages(bio);
+	bio_release_pages(bio);
 	bio_put(bio);
 	return;
 defer:
diff --git a/include/linux/bio.h b/include/linux/bio.h
index ea73df36529a..d5699a54328e 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -427,6 +427,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
+void bio_release_pages(struct bio *bio);
 struct rq_map_data;
 extern struct bio *bio_map_user_iov(struct request_queue *,
 				    struct iov_iter *, gfp_t);
-- 
2.20.1

