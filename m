Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8B21ACE1F
	for <lists+linux-block@lfdr.de>; Thu, 16 Apr 2020 18:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389283AbgDPQz0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 16 Apr 2020 12:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387794AbgDPQzS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 12:55:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64925C061A0C;
        Thu, 16 Apr 2020 09:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ghdjBZOmDRxzkIoo5Xu3BQRCNWshcMAAkcnzycG1Ibk=; b=qvOSbXAPSkBhaoef/QlGbF4JQb
        y1c9E5zJwP3iIyqmZSejYq6IJFkHirIloVWnNhe0CJ/jbpVMEZ/D3UFjL7Hl+TZKo27zKY+fl84B9
        BIl3yTnHaXMmQ1mHLXTmDD0Te31WrZU/IMMqgw9B3kqoH4xwb1c9M7zU5WRsmzYPV/nedK+wppTcJ
        BCku650V8MQ3X9trRhNeEq8OLOcCZ6Cak/cZhuwWYndi+s4RUHMoMoI+aawkrGvo15eSeSxxbeMTc
        G59iL/aPC3X19YHYTpggfHFaR9vVVEy2QGAW/jXHcLQSSN6IkYroezr6fdzSUwJdPzMIDNwfDn587
        dLyQixnQ==;
Received: from [2001:4bb8:184:4aa1:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP7nE-0004O5-V1; Thu, 16 Apr 2020 16:55:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] bdi: simplify bdi_alloc
Date:   Thu, 16 Apr 2020 18:54:52 +0200
Message-Id: <20200416165453.1080463-8-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416165453.1080463-1-hch@lst.de>
References: <20200416165453.1080463-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Merge the _node vs normal version and drop the superflous gfp_t argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-core.c            | 2 +-
 drivers/mtd/mtdcore.c       | 2 +-
 fs/super.c                  | 2 +-
 include/linux/backing-dev.h | 6 +-----
 mm/backing-dev.c            | 7 +++----
 5 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 7e4a1da0715e..ab87f2833ab2 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -484,7 +484,7 @@ struct request_queue *__blk_alloc_queue(int node_id)
 	if (ret)
 		goto fail_id;
 
-	q->backing_dev_info = bdi_alloc_node(GFP_KERNEL, node_id);
+	q->backing_dev_info = bdi_alloc(node_id);
 	if (!q->backing_dev_info)
 		goto fail_split;
 
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 2916674208b3..39ec563d9a14 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -2036,7 +2036,7 @@ static struct backing_dev_info * __init mtd_bdi_init(char *name)
 	struct backing_dev_info *bdi;
 	int ret;
 
-	bdi = bdi_alloc(GFP_KERNEL);
+	bdi = bdi_alloc(NUMA_NO_NODE);
 	if (!bdi)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/super.c b/fs/super.c
index cd352530eca9..dd28fcd706ff 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1598,7 +1598,7 @@ int super_setup_bdi_name(struct super_block *sb, char *fmt, ...)
 	int err;
 	va_list args;
 
-	bdi = bdi_alloc(GFP_KERNEL);
+	bdi = bdi_alloc(NUMA_NO_NODE);
 	if (!bdi)
 		return -ENOMEM;
 
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 4098ed6ba6b4..6b3504bf7a42 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -36,11 +36,7 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt,
 void bdi_set_owner(struct backing_dev_info *bdi, struct device *owner);
 void bdi_unregister(struct backing_dev_info *bdi);
 
-struct backing_dev_info *bdi_alloc_node(gfp_t gfp_mask, int node_id);
-static inline struct backing_dev_info *bdi_alloc(gfp_t gfp_mask)
-{
-	return bdi_alloc_node(gfp_mask, NUMA_NO_NODE);
-}
+struct backing_dev_info *bdi_alloc(int node_id);
 
 void wb_start_background_writeback(struct bdi_writeback *wb);
 void wb_workfn(struct work_struct *work);
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index bb993f99d424..1f55d5b8269f 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -865,12 +865,11 @@ static int bdi_init(struct backing_dev_info *bdi)
 	return ret;
 }
 
-struct backing_dev_info *bdi_alloc_node(gfp_t gfp_mask, int node_id)
+struct backing_dev_info *bdi_alloc(int node_id)
 {
 	struct backing_dev_info *bdi;
 
-	bdi = kmalloc_node(sizeof(struct backing_dev_info),
-			   gfp_mask | __GFP_ZERO, node_id);
+	bdi = kzalloc_node(sizeof(*bdi), GFP_KERNEL, node_id);
 	if (!bdi)
 		return NULL;
 
@@ -880,7 +879,7 @@ struct backing_dev_info *bdi_alloc_node(gfp_t gfp_mask, int node_id)
 	}
 	return bdi;
 }
-EXPORT_SYMBOL(bdi_alloc_node);
+EXPORT_SYMBOL(bdi_alloc);
 
 static struct rb_node **bdi_lookup_rb_node(u64 id, struct rb_node **parentp)
 {
-- 
2.25.1

