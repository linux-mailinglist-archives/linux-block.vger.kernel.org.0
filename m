Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8002A56B2D
	for <lists+linux-block@lfdr.de>; Wed, 26 Jun 2019 15:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfFZNtl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 26 Jun 2019 09:49:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfFZNtk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 09:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pwP6CfifdPLNcQBrZ5g6WNlr7qJaUvGycBXjIOeNc9Q=; b=IkBX6zJ+jteA45Uc6mOIZJ26Tm
        KNvjeJ2DRUwbilLSq4EBqXyybVLecwTX0xtZMZEE0HyOk/0+PGRlMbDix0poz7s85Zs2cF4VAHGi0
        nVSVkDPXxgkT30m35TaUIpgaFBwUAs4LuLnjlYE2acqwscb/nPHlUfB1VyZJnQI4m9GI7rPNyRJyH
        sJDS/SekEDAVxQDvm3+eC0Bju+/zS8yEdkjNQkBXzy+2lIQzVdJR9F/0I4uroGYC7UDExlxO00ZuF
        UPdEH8C2QU+xNir64siW0gWdzy/eZHBIdm+RwJ7GwK9Ac2oPD6nnJukEUvPaeggOaS6CdWFGa0STR
        yt2+qIFQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg8Iu-0003C6-CB; Wed, 26 Jun 2019 13:49:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 4/9] block: use bio_release_pages in bio_map_user_iov
Date:   Wed, 26 Jun 2019 15:49:23 +0200
Message-Id: <20190626134928.7988-5-hch@lst.de>
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

Use bio_release_pages instead of open coding it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 20a16347bcbb..a96d33d2de44 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1362,8 +1362,6 @@ struct bio *bio_map_user_iov(struct request_queue *q,
 	int j;
 	struct bio *bio;
 	int ret;
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
 
 	if (!iov_iter_count(iter))
 		return ERR_PTR(-EINVAL);
@@ -1430,9 +1428,7 @@ struct bio *bio_map_user_iov(struct request_queue *q,
 	return bio;
 
  out_unmap:
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		put_page(bvec->bv_page);
-	}
+	bio_release_pages(bio, false);
 	bio_put(bio);
 	return ERR_PTR(ret);
 }
-- 
2.20.1

