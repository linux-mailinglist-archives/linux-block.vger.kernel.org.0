Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 441F1EF1A5
	for <lists+linux-block@lfdr.de>; Tue,  5 Nov 2019 01:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfKEAGS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 Nov 2019 19:06:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38458 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbfKEAGS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Nov 2019 19:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=azN2v7805Rd1n8JZ+dhCYTV2qK3SiItehCbMqWUXVZs=; b=WJWX5OnDbUtP4VfMWuzrLoSnU
        026ogVH/SR9kw1MOX+l+0CHB4IuGQH9z4PWJEvHxBOumN9e9LCd/RV8vg4b6POJA6FJ3LWkCzfIga
        Edm3KeRyCntDC8sVqTLve98IvGHRAKwj1THzrisymost+9qcoP53YVyZAUrVfVPiE6XV8mWmIdvfo
        Fao6oL5BFCNLseR6W8ue1zDhYk+YkGbOu0oMapcgfOCtwHBbdHL/POuDn7C06bbRtpskGLxmprU9j
        E73YPhBFcdnpy7L7Z1kGv3331eJQnsC+4Tg2WAhys9eiT34jDxybZ8FbgOhkF2iGS2/WOgBsfGpVS
        rvcms19Ow==;
Received: from [216.240.19.104] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iRmMT-0000l4-TA; Tue, 05 Nov 2019 00:06:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: skip the split micro-optimization for devices with chunk size
Date:   Mon,  4 Nov 2019 16:06:17 -0800
Message-Id: <20191105000617.26923-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the devices sets a chunk size we might have to split I/O that is
smaller than a page size if it crosses the chunk boundary.  Skip the
micro-optimization for small I/Os in that case.

Fixes: b072e20f0084 ("block: merge invalidate_partitions into rescan_partitions")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 06eb38357b41..f22cb6251d06 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -317,7 +317,8 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
 		 * are cloned, but compared to the performance impact of cloned
 		 * bios themselves the loop below doesn't matter anyway.
 		 */
-		if ((*bio)->bi_vcnt == 1 &&
+		if (!q->limits.chunk_sectors &&
+		    (*bio)->bi_vcnt == 1 &&
 		    (*bio)->bi_io_vec[0].bv_len <= PAGE_SIZE) {
 			*nr_segs = 1;
 			break;
-- 
2.20.1

