Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3FC21A464D
	for <lists+linux-block@lfdr.de>; Fri, 10 Apr 2020 14:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgDJMbt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 10 Apr 2020 08:31:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46782 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgDJMbt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Apr 2020 08:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=yvcLsYHNvHteQ2swi8hf4h/I6Qn6p4yKs1CffDQbzEo=; b=fWX+kmbdfpV1cyl5q4g4ojwVid
        OTii/SkG/jPhzO4rH6k7eSFfDyeLvRae0ZzgVgJYLQA8oLMhFB6hD4niNOXcii0tMG7SsHIPGw8R+
        T6qiiQAOp2D1rZUTIavi2DTyQgzIlTCSO33/MzScrqUegzXJ+to63a5DakPauBhQhaf3xHFry874r
        FMV77RJvDZ8B5ckLzWnXXlvM2BlNFTxcYYY+fG12hIlMNkkk5cZi6jz2SAVtq4v+v50Vujh3IUsIU
        doazzu/kp/vrtFbCUtezm384ehMqdHznUEQlro6HfujgaX+cTUakEGtcIe7hDdlDgyNu2jdg6zHa/
        x5tly1nQ==;
Received: from [2001:4bb8:180:5765:8cdf:b820:7ed9:b80c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMsp3-0000MD-DK; Fri, 10 Apr 2020 12:31:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cai@lca.pw
Subject: [PATCH] block: fix busy device checking in blk_drop_partitions again
Date:   Fri, 10 Apr 2020 14:31:47 +0200
Message-Id: <20200410123147.1771206-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The previous fix had an off by one in the bd_openers checking, counting
the callers blkdev_get.

Fixes: d3ef5536274f ("block: fix busy device checking in blk_drop_partitions")
Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Qian Cai <cai@lca.pw>
---
 block/partitions/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 1a0a829d8416..bc1ded1331b1 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -496,7 +496,7 @@ int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev)
 
 	if (!disk_part_scan_enabled(disk))
 		return 0;
-	if (bdev->bd_part_count || bdev->bd_openers)
+	if (bdev->bd_part_count || bdev->bd_openers > 1)
 		return -EBUSY;
 	res = invalidate_partition(disk, 0);
 	if (res)
-- 
2.25.1

