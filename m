Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 092B915DC2
	for <lists+linux-block@lfdr.de>; Tue,  7 May 2019 08:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfEGGyS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 7 May 2019 02:54:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48240 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfEGGyR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 May 2019 02:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2124wyQJG3aqZ26ar5c8Sv4MrYfVbicLqym+W2slUyI=; b=NQPMaEgEb6vLyBYS3fDF1Fs6o
        U9HlPj1CnsLN46E9850sLfme8/6pUdviQKRUEx5Ieykz4hlhPOhBtsxroSIljYW/nmmLjiLH/RCgs
        gUb1Yzzd4P1sxDgNRRXLJNgLF6UXtEGM9NO2gj15rKuLWzoXxqvzZt9xTAp5pZVbiiBrjd0m8Fbcs
        uHlyrSGZOQ8PzTwSZdOdcYbyf2rRm92y3Y1RcwZurhIwuXtsasxkdzrX8KLFPrDiOjjzzn6zvm7DQ
        kg1+cnf8gIJWoPg10vcvtWIIaFhKcKqAk6AL9goaZXw6/WYmzU0MRsqZikRVb+WcUllfNXtUn6HaL
        /5rs2EXYA==;
Received: from 089144210233.atnat0019.highway.a1.net ([89.144.210.233] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hNtzU-0001kK-84; Tue, 07 May 2019 06:54:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH] block: fix mismerge in bvec_advance
Date:   Tue,  7 May 2019 08:53:35 +0200
Message-Id: <20190507065335.8138-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When Jens merged my commit to only allow contiguous page structs in a
bio_vec with Ming's 5.1 fix to ensue the bvec length didn't overflow
we failed to keep the removal of the expensive nth_page calls.  This
commits adds them back as intended.

Fixes: 5c61ee2cd586 ("Merge tag 'v5.1-rc6' into for-5.2/block")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bvec.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 545a480528e0..a032f01e928c 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -133,11 +133,6 @@ static inline struct bio_vec *bvec_init_iter_all(struct bvec_iter_all *iter_all)
 	return &iter_all->bv;
 }
 
-static inline struct page *bvec_nth_page(struct page *page, int idx)
-{
-	return idx == 0 ? page : nth_page(page, idx);
-}
-
 static inline void bvec_advance(const struct bio_vec *bvec,
 				struct bvec_iter_all *iter_all)
 {
@@ -147,8 +142,7 @@ static inline void bvec_advance(const struct bio_vec *bvec,
 		bv->bv_page++;
 		bv->bv_offset = 0;
 	} else {
-		bv->bv_page = bvec_nth_page(bvec->bv_page, bvec->bv_offset /
-					    PAGE_SIZE);
+		bv->bv_page = bvec->bv_page + (bvec->bv_offset >> PAGE_SHIFT);
 		bv->bv_offset = bvec->bv_offset & ~PAGE_MASK;
 	}
 	bv->bv_len = min_t(unsigned int, PAGE_SIZE - bv->bv_offset,
-- 
2.20.1

