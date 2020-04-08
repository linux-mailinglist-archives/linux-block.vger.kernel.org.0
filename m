Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD5F81A2993
	for <lists+linux-block@lfdr.de>; Wed,  8 Apr 2020 21:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgDHTpD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 8 Apr 2020 15:45:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40882 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbgDHTpC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Apr 2020 15:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WaFDFRBmbmUN+/BUtSasLo/ufQZePgX56qxKiFzwBwo=; b=fe7tcieX69aREXEJjhPcJeewmF
        G0iGRY36xLimW2bwx+t3uf9a6t3ra6OAIKG004hrDGmk3fEuORkj5oBDMficlqBDq4ZjCVH2n24Ou
        VxqpGt+GGMV9QkleV+oEoTqOs8oscGbXuR6xt3t2EGNyJl1GNH/aGakuRkoyXxkEwThQ7Wz+TgXqo
        tbWK5SbStkaw2VT2bi70dPAYcDHT8bZ/JlvcoKUWdzYRuoD0x6AxxOAn4rdl2t+PLGcxiXnIpVOzH
        UukwyWVgdxrpEFuiUdEwaH+eX77J9dFtuMK+oHrfkSt0nEJoZczYs/kqmt9t/ueZfGDyC18pSEiyv
        7EL2cEAA==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMGdB-0004MT-5O; Wed, 08 Apr 2020 19:45:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 08/10] block: simplify block device syncing in bdev_del_partition
Date:   Wed,  8 Apr 2020 21:44:37 +0200
Message-Id: <20200408194439.1580699-9-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408194439.1580699-1-hch@lst.de>
References: <20200408194439.1580699-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We just checked a little above that the block device for the partition
im busy.  That implies no file system is mounted, and thus the only
thing in fsync_bdev that actually is used is sync_blockdev.  Just call
sync_blockdev directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 3fe383adb42a..9c402edee4a4 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -531,7 +531,7 @@ int bdev_del_partition(struct block_device *bdev, int partno)
 	if (bdevp->bd_openers)
 		goto out_unlock;
 
-	fsync_bdev(bdevp);
+	sync_blockdev(bdevp);
 	invalidate_bdev(bdevp);
 
 	mutex_lock_nested(&bdev->bd_mutex, 1);
-- 
2.25.1

