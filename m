Return-Path: <linux-block+bounces-684-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D32A4803BAE
	for <lists+linux-block@lfdr.de>; Mon,  4 Dec 2023 18:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88EB21F2111E
	for <lists+linux-block@lfdr.de>; Mon,  4 Dec 2023 17:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1C52E849;
	Mon,  4 Dec 2023 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ktszx4t6"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6630FD51
	for <linux-block@vger.kernel.org>; Mon,  4 Dec 2023 09:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=DbYPZcFpPERtsKijQ9FBhgRSEJSze9sdW+1EorX2Seg=; b=ktszx4t6lkRXJsBBFEq5BHAWwM
	y7NdqBlpwH1Sd0iOXlI7+xlIdFvvEr6kQrGa48jUK2AjG5b8u4cL2KI26s7ei7fKMdJ667Xe4fseO
	G8TFHgSKnm8w9RhIbnrJhZKhwCO8topfOAJbJ0frbHKz29ve/fVIspdMsm1rf5/mniLVVYNVfNUFq
	b1tWWZK6wMmgZOlusOGnIe1OebdPOnz/DbzF3OZlb+S3bvv0zF/5qTlk1HLAznUKkB/45vdYj9stT
	j5muaFmcg8k07o50SqwhJYsFSmqXO2t6KGg3P8CsSblvvGZzpmkWh3jTmENAJevwQxHE+nFYsWP7a
	sTACEMqQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rACpv-005Ctt-2L;
	Mon, 04 Dec 2023 17:34:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: prevent an integer overflow in bvec_try_merge_hw_page
Date: Mon,  4 Dec 2023 18:34:18 +0100
Message-Id: <20231204173419.782378-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204173419.782378-1-hch@lst.de>
References: <20231204173419.782378-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Reordered a check to avoid a possible overflow when adding len to bv_len.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 816d412c06e9b4..cef830adbc06e0 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -944,7 +944,7 @@ bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
 
 	if ((addr1 | mask) != (addr2 | mask))
 		return false;
-	if (bv->bv_len + len > queue_max_segment_size(q))
+	if (len > queue_max_segment_size(q) - bv->bv_len)
 		return false;
 	return bvec_try_merge_page(bv, page, len, offset, same_page);
 }
-- 
2.39.2


