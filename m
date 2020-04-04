Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 753B119E321
	for <lists+linux-block@lfdr.de>; Sat,  4 Apr 2020 08:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgDDGvY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 4 Apr 2020 02:51:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44740 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgDDGvY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Apr 2020 02:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=qki1tQprFNKggA7pzaUzkSNxtkMWt/ABaK5EURoI05Y=; b=dKkSSb9gOjo2E7OmlfdylXMk+z
        svrxeMeWIk7zmROuVWpDHooMfgVHJjG2/G9I2EVMx2JcB/RvLlPmJWG+hvPlOp0ogUOg1kzYMNoXP
        +VO7rEqDV36zlixdPZSmsDkGSwyO856e1EmpLAvmyPXd7FKYNGeajT1sGVIt1FrvmfHxHR8hTCqmr
        /o4hTeOUPlTqzvNHBIsVB/oiBw/uPLAaq4JiDhUuEs+sd/Xc51K+eObjdrayJktOKb+2d8D11RIvL
        7MLlPSZIBMdMsgIfGJxeRpsULxKzUdrPrWd4qt89DlaMq1Rz+o5Uy9Y13KQ0wK0DFFz5AeXiDcugM
        2JR81w+w==;
Received: from [2001:4bb8:180:7914:2ca6:9476:bbfa:a4d0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKceI-0007FO-TR; Sat, 04 Apr 2020 06:51:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: [PATCH] block: fix busy device checking in blk_drop_partitions
Date:   Sat,  4 Apr 2020 08:51:20 +0200
Message-Id: <20200404065120.655735-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bd_super is only set by get_tree_bdev and mount_bdev, and thus not by
other openers like btrfs or the XFS realtime and log devices, as well as
block devices directly opened from user space.  Check bd_openers
instead.

Fixes: 77032ca66f86 ("Return EBUSY from BLKRRPART for mounted whole-dev fs")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index b79c4513629b..1a0a829d8416 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -496,7 +496,7 @@ int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev)
 
 	if (!disk_part_scan_enabled(disk))
 		return 0;
-	if (bdev->bd_part_count || bdev->bd_super)
+	if (bdev->bd_part_count || bdev->bd_openers)
 		return -EBUSY;
 	res = invalidate_partition(disk, 0);
 	if (res)
-- 
2.25.1

