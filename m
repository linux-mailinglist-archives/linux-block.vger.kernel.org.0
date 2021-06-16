Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6323A9390
	for <lists+linux-block@lfdr.de>; Wed, 16 Jun 2021 09:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhFPHSJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 16 Jun 2021 03:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhFPHSJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 03:18:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382CFC061574
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 00:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=3RAKQODVmlmZd5OTYCX7bagPqlSsd3KFFngN3bWEDDQ=; b=Ko/T8UP+WEsG+QF3vu21Edgs5y
        +vAjuyAkMIbTLanoG08RyH3a7bMQ93KhtHoy9WvXNOizDwdu0W7VTHE4AvhcAwv2TyPr1YEY5Bkc3
        h2ygKJUnqjaDJt9bpxCWjN9Fh0TPTRiCcdKqHHHqXWCtZka6Hqxxb8H/8fQPrs0c02gk8vEQgbogX
        pL74w8ZMxzeU8y695ygTZ0J8c7fPMJggyMxga5czXvb35T+U1Pyt1IfvJcCJtbWlJcrLHymbDaA3h
        EKPfTVydjp/iAqrwVS1CM9GwUcHgRtrnnvbew/JZulEqeWraZ5T6Y4YaQG+Xi1HZpN0OEuP75wXZD
        6mszgrWQ==;
Received: from [2001:4bb8:19b:fdce:84d:447:81f0:ca60] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltPm8-007jj8-3u; Wed, 16 Jun 2021 07:15:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, bgoncalv@redhat.com,
        m.szyprowski@samsung.com
Subject: [PATCH 1/2] mtd_blkdevs: initialze new->rq in add_mtd_blktrans_dev
Date:   Wed, 16 Jun 2021 09:15:46 +0200
Message-Id: <20210616071547.1156283-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Various places expect the request_queue in ->rq.  Initialize it to
avoid NULL pointer derefences.

Fixes: 6966bb921def ("mtd_blkdevs: use blk_mq_alloc_disk")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/mtd/mtd_blkdevs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 5dc4c966ea73..6ce4bc57f919 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -382,6 +382,7 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 	}
 
 	new->disk = gd;
+	new->rq = new->disk->queue;
 	gd->private_data = new;
 	gd->major = tr->major;
 	gd->first_minor = (new->devnum) << tr->part_bits;
-- 
2.30.2

