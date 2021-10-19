Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34892432FAD
	for <lists+linux-block@lfdr.de>; Tue, 19 Oct 2021 09:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhJSHjE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 19 Oct 2021 03:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhJSHjE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 03:39:04 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CF6C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 00:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xEmF1XJ1P1x7JazxiSTgX0H5G/Dg0T1jC0FmUdRQvXs=; b=hK9AK8I7swt7mIxSGHoIUJieft
        8tXSQHr2GJU3cvML4qqKjubt5uucpLlUyDnpUnphU+fiObFYEEwAyVWXCLk09drNHXFghDU8gdcAF
        K9kqXW/AzjGClCGaKw53dLZ4+HXwDZx6jiymyHFPEUittOUN4VSczxmqLPSu39xgcOh2HLcjGSMzx
        +UCRcAnRL0m4KKy3wmpi1XEOBlAyLy9JxPVDCxnotSlArbKMpeGh8OPCW1Ea7jZiEp+N4fmS7kKbe
        PvATbw2K7qYhohf3APjpo60CFwHu/NhNi457kCgKVMAVJWAp1bUEkOA36etFZbC7lw/Tk9VyGD77V
        lG+54jyA==;
Received: from 089144192247.atnat0001.highway.a1.net ([89.144.192.247] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcjg1-000QWO-Mq; Tue, 19 Oct 2021 07:36:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org
Subject: [PATCH 1/2] nvdimm/pmem: stop using q_usage_count as external pgmap refcount
Date:   Tue, 19 Oct 2021 09:36:40 +0200
Message-Id: <20211019073641.2323410-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019073641.2323410-1-hch@lst.de>
References: <20211019073641.2323410-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Originally all DAX access when through block_device operations and thus
needed a queue reference.  But since commit cccbce671582
("filesystem-dax: convert to dax_direct_access()") all this happens at
the DAX device level which uses its own refcounting.  Having the external
refcount thus wasn't needed but has otherwise been harmless for long
time.

But now that "block: drain file system I/O on del_gendisk" waits for
q_usage_count to reach 0 in del_gendisk this whole scheme can't work
anymore (and pmem is the only driver abusing q_usage_count like that).
So switch to the internal reference and remove the unbalanced
blk_freeze_queue_start that is taken care of by del_gendisk.

Fixes: 8e141f9eb803 ("block: drain file system I/O on del_gendisk")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvdimm/pmem.c | 33 ++-------------------------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 72de88ff0d30d..f576ee0ce7968 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -333,26 +333,6 @@ static const struct attribute_group *pmem_attribute_groups[] = {
 	NULL,
 };
 
-static void pmem_pagemap_cleanup(struct dev_pagemap *pgmap)
-{
-	struct pmem_device *pmem = pgmap->owner;
-
-	blk_cleanup_disk(pmem->disk);
-}
-
-static void pmem_release_queue(void *pgmap)
-{
-	pmem_pagemap_cleanup(pgmap);
-}
-
-static void pmem_pagemap_kill(struct dev_pagemap *pgmap)
-{
-	struct request_queue *q =
-		container_of(pgmap->ref, struct request_queue, q_usage_counter);
-
-	blk_freeze_queue_start(q);
-}
-
 static void pmem_release_disk(void *__pmem)
 {
 	struct pmem_device *pmem = __pmem;
@@ -360,12 +340,9 @@ static void pmem_release_disk(void *__pmem)
 	kill_dax(pmem->dax_dev);
 	put_dax(pmem->dax_dev);
 	del_gendisk(pmem->disk);
-}
 
-static const struct dev_pagemap_ops fsdax_pagemap_ops = {
-	.kill			= pmem_pagemap_kill,
-	.cleanup		= pmem_pagemap_cleanup,
-};
+	blk_cleanup_disk(pmem->disk);
+}
 
 static int pmem_attach_disk(struct device *dev,
 		struct nd_namespace_common *ndns)
@@ -428,10 +405,8 @@ static int pmem_attach_disk(struct device *dev,
 	pmem->disk = disk;
 	pmem->pgmap.owner = pmem;
 	pmem->pfn_flags = PFN_DEV;
-	pmem->pgmap.ref = &q->q_usage_counter;
 	if (is_nd_pfn(dev)) {
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
-		pmem->pgmap.ops = &fsdax_pagemap_ops;
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
 		pfn_sb = nd_pfn->pfn_sb;
 		pmem->data_offset = le64_to_cpu(pfn_sb->dataoff);
@@ -445,16 +420,12 @@ static int pmem_attach_disk(struct device *dev,
 		pmem->pgmap.range.end = res->end;
 		pmem->pgmap.nr_range = 1;
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
-		pmem->pgmap.ops = &fsdax_pagemap_ops;
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
 		pmem->pfn_flags |= PFN_MAP;
 		bb_range = pmem->pgmap.range;
 	} else {
 		addr = devm_memremap(dev, pmem->phys_addr,
 				pmem->size, ARCH_MEMREMAP_PMEM);
-		if (devm_add_action_or_reset(dev, pmem_release_queue,
-					&pmem->pgmap))
-			return -ENOMEM;
 		bb_range.start =  res->start;
 		bb_range.end = res->end;
 	}
-- 
2.30.2

