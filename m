Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D86354CA7
	for <lists+linux-block@lfdr.de>; Tue,  6 Apr 2021 08:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbhDFGSu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 6 Apr 2021 02:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236986AbhDFGSu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 02:18:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2295C06174A
        for <linux-block@vger.kernel.org>; Mon,  5 Apr 2021 23:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=rmKGDCFKSzoD71LmBI17ejAGAl8ijAil5igSw2zgXtg=; b=2wWOn4m4UevKMr5mlO9UdWfZ97
        e/dvxSmGHIRuWxQXszaQSquM4qUj1cQjOigZWDcCNqGgwfJLpENt06ETQAMe+zivbBatLxbJdKd1c
        vHRe+oR8mC3JKbRZmiEVNH1hbHSWLKxci03QiuHmfl5IeoNKXolL46kDA9nDYle+nkxQE00dE4ehg
        cw2auMn7xG+pY7qbMimwdGArWjcYXEHzAfON5P5l9YlUVAgWkTmXJshz/+EPXsU1C86OmuaqVMLu5
        f3uHPk1fkUgqepiFJ9bqbBTeeS0HislVBTl4lGl0e9FsN3zk6s3ltRYv+gisSBjlf6RZv/Btl9MSX
        iwEOt4lA==;
Received: from [2001:4bb8:188:4907:c664:b479:e725:f367] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lTf2v-007o2S-Je; Tue, 06 Apr 2021 06:18:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] swim3: support highmem
Date:   Tue,  6 Apr 2021 08:18:39 +0200
Message-Id: <20210406061839.811588-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

swim3 only uses the virtual address of a bio to stash it into the data
transfer using virt_to_bus.  But the ppc32 virt_to_bus just uses the
physical address with an offset.  Replace virt_to_bus with a local hack
that performs the equivalent transformation and stop asking for block
layer bounce buffering.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/swim3.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index c2d922d125e281..a515d0c1d2cb8e 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -234,7 +234,6 @@ static unsigned short write_postamble[] = {
 };
 
 static void seek_track(struct floppy_state *fs, int n);
-static void init_dma(struct dbdma_cmd *cp, int cmd, void *buf, int count);
 static void act(struct floppy_state *fs);
 static void scan_timeout(struct timer_list *t);
 static void seek_timeout(struct timer_list *t);
@@ -404,12 +403,28 @@ static inline void seek_track(struct floppy_state *fs, int n)
 	fs->settle_time = 0;
 }
 
+/*
+ * XXX: this is a horrible hack, but at least allows ppc32 to get
+ * out of defining virt_to_bus, and this driver out of using the
+ * deprecated block layer bounce buffering for highmem addresses
+ * for no good reason.
+ */
+static unsigned long swim3_phys_to_bus(phys_addr_t paddr)
+{
+	return paddr + PCI_DRAM_OFFSET;
+}
+
+static phys_addr_t swim3_bio_phys(struct bio *bio)
+{
+	return page_to_phys(bio_page(bio)) + bio_offset(bio);
+}
+
 static inline void init_dma(struct dbdma_cmd *cp, int cmd,
-			    void *buf, int count)
+			    phys_addr_t paddr, int count)
 {
 	cp->req_count = cpu_to_le16(count);
 	cp->command = cpu_to_le16(cmd);
-	cp->phy_addr = cpu_to_le32(virt_to_bus(buf));
+	cp->phy_addr = cpu_to_le32(swim3_phys_to_bus(paddr));
 	cp->xfer_status = 0;
 }
 
@@ -441,16 +456,18 @@ static inline void setup_transfer(struct floppy_state *fs)
 	out_8(&sw->sector, fs->req_sector);
 	out_8(&sw->nsect, n);
 	out_8(&sw->gap3, 0);
-	out_le32(&dr->cmdptr, virt_to_bus(cp));
+	out_le32(&dr->cmdptr, swim3_phys_to_bus(virt_to_phys(cp)));
 	if (rq_data_dir(req) == WRITE) {
 		/* Set up 3 dma commands: write preamble, data, postamble */
-		init_dma(cp, OUTPUT_MORE, write_preamble, sizeof(write_preamble));
+		init_dma(cp, OUTPUT_MORE, virt_to_phys(write_preamble),
+			 sizeof(write_preamble));
 		++cp;
-		init_dma(cp, OUTPUT_MORE, bio_data(req->bio), 512);
+		init_dma(cp, OUTPUT_MORE, swim3_bio_phys(req->bio), 512);
 		++cp;
-		init_dma(cp, OUTPUT_LAST, write_postamble, sizeof(write_postamble));
+		init_dma(cp, OUTPUT_LAST, virt_to_phys(write_postamble),
+			sizeof(write_postamble));
 	} else {
-		init_dma(cp, INPUT_LAST, bio_data(req->bio), n * 512);
+		init_dma(cp, INPUT_LAST, swim3_bio_phys(req->bio), n * 512);
 	}
 	++cp;
 	out_le16(&cp->command, DBDMA_STOP);
@@ -1201,7 +1218,6 @@ static int swim3_attach(struct macio_dev *mdev,
 		disk->queue = NULL;
 		goto out_put_disk;
 	}
-	blk_queue_bounce_limit(disk->queue, BLK_BOUNCE_HIGH);
 	disk->queue->queuedata = fs;
 
 	rc = swim3_add_device(mdev, floppy_count);
-- 
2.30.1

