Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480EF38877B
	for <lists+linux-block@lfdr.de>; Wed, 19 May 2021 08:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbhESGXl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 19 May 2021 02:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhESGXk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 02:23:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6843C06175F;
        Tue, 18 May 2021 23:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=WgWtZKK4mKjVxSQK4NMAPYjW3vLrDBPS+P3RyKHkvgc=; b=YYhSweu8ZsPi/xpO1OOlXKrmDc
        FBFrwgnH1MQIAi5PXnmsdhsWJGd782NzGYw1zLE6mVynrBuTXnZvVi+/ppmQYb6BB4g47OJ8Fl+4C
        BgGJhNqqoIjy5h6lzTquNOngR1M+v6PivTQtzxqw8GYq6dUDWuoOsmG3tkavmEkInOKS7EKk+ndiz
        Ik4N2Y78I5iRjude4WXB9VqnwjKfBxjinXGQbTws/oq8rScnG1MRE03iB1LXDCB1O/Wq5rQNiPno5
        aEJ4Llmh2Fw6g15av1DLc5+HaQdvQOYBZs4IYmPujuCuuJyF53vQ+Sv9k5ERGUF+Kpxseq061fRK4
        HWqT/1+w==;
Received: from [2001:4bb8:180:5add:a424:75ff:2507:f6c6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ljFb0-00FB3k-40; Wed, 19 May 2021 06:22:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     song@kernel.org, axboe@kernel.dk
Cc:     linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        "Florian D ." <spam02@dazinger.net>
Subject: [PATCH] md/raid5: remove an incorect assert in in_chunk_boundary
Date:   Wed, 19 May 2021 08:22:15 +0200
Message-Id: <20210519062215.4111256-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that the original bdev is stored in the bio this assert is incorrect
and will trigge for any partitioned raid5 device.

Reported-by:  Florian D. <spam02@dazinger.net>
Fixes: 309dca309fc3 ("block: store a block_device pointer in struct bio"),
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid5.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 841e1c1aa5e6..7d4ff8a5c55e 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5311,8 +5311,6 @@ static int in_chunk_boundary(struct mddev *mddev, struct bio *bio)
 	unsigned int chunk_sectors;
 	unsigned int bio_sectors = bio_sectors(bio);
 
-	WARN_ON_ONCE(bio->bi_bdev->bd_partno);
-
 	chunk_sectors = min(conf->chunk_sectors, conf->prev_chunk_sectors);
 	return  chunk_sectors >=
 		((sector & (chunk_sectors - 1)) + bio_sectors);
-- 
2.30.2

