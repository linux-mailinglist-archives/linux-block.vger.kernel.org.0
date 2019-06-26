Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC02E56B2F
	for <lists+linux-block@lfdr.de>; Wed, 26 Jun 2019 15:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfFZNtp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 26 Jun 2019 09:49:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45080 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfFZNtp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 09:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8qpPFM5eZFRHxviwkAUBHCKBnw0FgiO51bE/yCYaMwY=; b=L5yYI/tcFhJJLdmHyfo4yLOlPu
        oFc4s6GMgRFpIH4DVU4bQ+/hOEZCXw5mR3/NsscySBX5r8oOtpIARWqBRD9+Hxf8R2FO+8Gt6Rn3y
        VoJj0/ZJDH9j/UaqSWnO/Y8WF2+IW+tdZOltg0bpO/WQoDC0Lz9hdq9sU3rCEwndAk7KlPx9f7Znj
        3zxaI1X/1D2B+zYBTQcg5gap4ZCxPs7SwkWqE0479/8shR4JUGMTHI7nOSAwDvHqB8CLFwYkmPvqb
        2dE0K2AIn9gRkSZ0CTcINGFH6syEN8ZLVzeqwjLSAzmZdZvR0FqMKfCZmVyXStgkOgh18xbfI7l3Q
        DITDOwOA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg8Iy-0003D5-Mx; Wed, 26 Jun 2019 13:49:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 6/9] block_dev: use bio_release_pages in blkdev_bio_end_io
Date:   Wed, 26 Jun 2019 15:49:25 +0200
Message-Id: <20190626134928.7988-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626134928.7988-1-hch@lst.de>
References: <20190626134928.7988-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use bio_release_pages instead of duplicating it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 749f5984425d..a6572a811880 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -335,13 +335,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 	if (should_dirty) {
 		bio_check_pages_dirty(bio);
 	} else {
-		if (!bio_flagged(bio, BIO_NO_PAGE_REF)) {
-			struct bvec_iter_all iter_all;
-			struct bio_vec *bvec;
-
-			bio_for_each_segment_all(bvec, bio, iter_all)
-				put_page(bvec->bv_page);
-		}
+		bio_release_pages(bio, false);
 		bio_put(bio);
 	}
 }
-- 
2.20.1

