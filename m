Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA8A1AEE85
	for <lists+linux-block@lfdr.de>; Sat, 18 Apr 2020 16:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgDRONI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 18 Apr 2020 10:13:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbgDROJs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Apr 2020 10:09:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A28E922251;
        Sat, 18 Apr 2020 14:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587218988;
        bh=Yb0dT5Mf5FCK4nJCMD4GNxe6Lfw8RlG4lpvc3T+67PM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2h074zuBWcpcUuIFnOzMraH77sWthApCUFob+E9snEOVcywrMybZK6HTWYgjcaXzf
         0YX3FS7NYFx0EZyfIUT+DfJp7DKMfxY8rGfHkbfQyPUH0F3gBfdtwbejH2FZD/SyCW
         aDppxZQbdCu+9aNDpoF27wX45VEugil17k1JT36w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 30/75] block: fix busy device checking in blk_drop_partitions
Date:   Sat, 18 Apr 2020 10:08:25 -0400
Message-Id: <20200418140910.8280-30-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418140910.8280-1-sashal@kernel.org>
References: <20200418140910.8280-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit d3ef5536274faf89e626276b833be122a16bdb81 ]

bd_super is only set by get_tree_bdev and mount_bdev, and thus not by
other openers like btrfs or the XFS realtime and log devices, as well as
block devices directly opened from user space.  Check bd_openers
instead.

Fixes: 77032ca66f86 ("Return EBUSY from BLKRRPART for mounted whole-dev fs")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/partition-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partition-generic.c b/block/partition-generic.c
index 564fae77711df..5f3b2a959aa51 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -468,7 +468,7 @@ int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev)
 
 	if (!disk_part_scan_enabled(disk))
 		return 0;
-	if (bdev->bd_part_count || bdev->bd_super)
+	if (bdev->bd_part_count || bdev->bd_openers)
 		return -EBUSY;
 	res = invalidate_partition(disk, 0);
 	if (res)
-- 
2.20.1

