Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941DB354CC1
	for <lists+linux-block@lfdr.de>; Tue,  6 Apr 2021 08:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243964AbhDFGXc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 6 Apr 2021 02:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243963AbhDFGXc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 02:23:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170B3C06174A;
        Mon,  5 Apr 2021 23:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=0QwL6sfGNh7BF90nN4uekuG+iOkQGxSxR8MlPO2wQoY=; b=dZxpcMxA11VhsTxG8JccxXzrx1
        unLtdvHiaD0hNSX21ueYTuhB+ghp0uruHODRmkfm7ATDJeXMso2kmvw9S+uOzNz20IOffN2PLMs9J
        IGyJwzj2ZelGb3E0XaPcBqm9qItN7Jbk7xUfG2oi9uX2cLOyX0wLwrzJftv658h2DzcQ0U6ts16OC
        WFv1j88e0frjCwQSrEw+Xo3rByLE7VOYzMt+uEdXd38OEEKMlrVX5MR2ROoEP6bj+UVGfc0Lu3DcE
        WxP1mb+wG3ShY+Do8K96UcweIfQY2XAaEmy5W5nqQ2LCfJFYNPTj1qTKyiOC8oKgbCTPK0VNZ4Crb
        QSr2/wDQ==;
Received: from [2001:4bb8:188:4907:c664:b479:e725:f367] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lTf7S-007o9F-Rk; Tue, 06 Apr 2021 06:23:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 07/11] block: simplify partition_overlaps
Date:   Tue,  6 Apr 2021 08:22:58 +0200
Message-Id: <20210406062303.811835-8-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210406062303.811835-1-hch@lst.de>
References: <20210406062303.811835-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just use xa_for_each to iterate over the partitions as there is no need
to grab a reference to each partition.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 927144d4e59d39..0f8454b93c6e4c 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -420,21 +420,21 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 static bool partition_overlaps(struct gendisk *disk, sector_t start,
 		sector_t length, int skip_partno)
 {
-	struct disk_part_iter piter;
 	struct block_device *part;
 	bool overlap = false;
+	unsigned long idx;
 
-	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);
-	while ((part = disk_part_iter_next(&piter))) {
-		if (part->bd_partno == skip_partno ||
-		    start >= part->bd_start_sect + bdev_nr_sectors(part) ||
-		    start + length <= part->bd_start_sect)
-			continue;
-		overlap = true;
-		break;
+	rcu_read_lock();
+	xa_for_each_start(&disk->part_tbl, idx, part, 1) {
+		if (part->bd_partno != skip_partno &&
+		    start < part->bd_start_sect + bdev_nr_sectors(part) &&
+		    start + length > part->bd_start_sect) {
+			overlap = true;
+			break;
+		}
 	}
+	rcu_read_unlock();
 
-	disk_part_iter_exit(&piter);
 	return overlap;
 }
 
-- 
2.30.1

