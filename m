Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C211690A2
	for <lists+linux-block@lfdr.de>; Mon, 15 Jul 2019 16:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390725AbfGOOXT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 15 Jul 2019 10:23:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390188AbfGOOXS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 10:23:18 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 926E32053B;
        Mon, 15 Jul 2019 14:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563200597;
        bh=3FUXEOahWPk0BdWzwzeTpwlxEqT6Y1R0u8qqxkpNXGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=08Cpr3JNrubjxtPE/DXG+ioNi8GrCGA0mHtHo3f9M3VfC2t14DHYCt7KA4u3kySOB
         WEVW7R40CkmIXPMUlDU/WdNBX1u+jQhUlIa+jC69PWXNeQbqGMkMaqs4ZRXvCvzr6n
         1BiMbiVtlEtVcx+F8T0w4jNC/0h4WlNf2gxS8+v4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiner Litz <hlitz@ucsc.edu>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 088/158] lightnvm: pblk: fix freeing of merged pages
Date:   Mon, 15 Jul 2019 10:16:59 -0400
Message-Id: <20190715141809.8445-88-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715141809.8445-1-sashal@kernel.org>
References: <20190715141809.8445-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Heiner Litz <hlitz@ucsc.edu>

[ Upstream commit 510fd8ea98fcb586c01aef93d87c060a159ac30a ]

bio_add_pc_page() may merge pages when a bio is padded due to a flush.
Fix iteration over the bio to free the correct pages in case of a merge.

Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/lightnvm/pblk-core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 95be6e36c7dd..80710c62ac29 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -288,14 +288,16 @@ void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type)
 void pblk_bio_free_pages(struct pblk *pblk, struct bio *bio, int off,
 			 int nr_pages)
 {
-	struct bio_vec bv;
-	int i;
-
-	WARN_ON(off + nr_pages != bio->bi_vcnt);
-
-	for (i = off; i < nr_pages + off; i++) {
-		bv = bio->bi_io_vec[i];
-		mempool_free(bv.bv_page, &pblk->page_bio_pool);
+	struct bio_vec *bv;
+	struct page *page;
+	int i, e, nbv = 0;
+
+	for (i = 0; i < bio->bi_vcnt; i++) {
+		bv = &bio->bi_io_vec[i];
+		page = bv->bv_page;
+		for (e = 0; e < bv->bv_len; e += PBLK_EXPOSED_PAGE_SIZE, nbv++)
+			if (nbv >= off)
+				mempool_free(page++, &pblk->page_bio_pool);
 	}
 }
 
-- 
2.20.1

