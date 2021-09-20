Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89FC41148C
	for <lists+linux-block@lfdr.de>; Mon, 20 Sep 2021 14:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbhITMfb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 20 Sep 2021 08:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbhITMfa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 08:35:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461A0C061574
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 05:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8ZI14oBmDaNEcQ5OCaRY2wf7sNE0O3jQYQOJNwbTc+c=; b=dw0RJRwPA/Q0C1vQ2dg+3dhZud
        bK3kikeF+g34gKEE5JDZyFBItyeYCzMelGUj8USFuCLMsWGfE0ucYRVumEaUyJehOWILw3cf7O02b
        Cu1WmSEBFtplOojwJ/lFpHRRwaCxpLeTMG4UXEP01SuiTZuYesPpjxlp4fRMyeq65lMEVLMw84D6g
        69vO8X3NNE/3N+5yv/3J5IP7ZOOS+/kbsmbIIuzXg6IbXkEZafT4IjEwbk1yerAGHwbHHtbsdm86w
        hX4ezF+RUkbqbaJ1E6qSorFoV6WHObnJ1RJFKXchs+WbpjrKXrSOIxYvcohfWpzJxAho7v60tXAhq
        9Dl4gm1A==;
Received: from [2001:4bb8:184:72db:7ad9:14d9:8599:3025] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSIUQ-002esM-7x; Mon, 20 Sep 2021 12:33:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 01/17] mm: don't include <linux/blk-cgroup.h> in <linux/writeback.h>
Date:   Mon, 20 Sep 2021 14:33:12 +0200
Message-Id: <20210920123328.1399408-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920123328.1399408-1-hch@lst.de>
References: <20210920123328.1399408-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk-cgroup.h pulls in blkdev.h and thus pretty much all the block
headers.  Break this dependency chain by turning wbc_blkcg_css into a
macro and dropping the blk-cgroup.h include.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/i915_utils.h |  1 +
 fs/btrfs/inode.c                  |  1 +
 fs/quota/quota.c                  |  1 +
 include/linux/writeback.h         | 14 +++++---------
 lib/random32.c                    |  1 +
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
index 5259edacde380..066a9118c3748 100644
--- a/drivers/gpu/drm/i915/i915_utils.h
+++ b/drivers/gpu/drm/i915/i915_utils.h
@@ -30,6 +30,7 @@
 #include <linux/sched.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <linux/sched/clock.h>
 
 struct drm_i915_private;
 struct timer_list;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 487533c35ddb6..4a9077c524448 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6,6 +6,7 @@
 #include <crypto/hash.h>
 #include <linux/kernel.h>
 #include <linux/bio.h>
+#include <linux/blk-cgroup.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 2bcc9a6f1bfc0..052f143e2e0e1 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -10,6 +10,7 @@
 #include <linux/namei.h>
 #include <linux/slab.h>
 #include <asm/current.h>
+#include <linux/blkdev.h>
 #include <linux/uaccess.h>
 #include <linux/kernel.h>
 #include <linux/security.h>
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index d1f65adf6a266..8eb165760752b 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -11,7 +11,6 @@
 #include <linux/flex_proportions.h>
 #include <linux/backing-dev-defs.h>
 #include <linux/blk_types.h>
-#include <linux/blk-cgroup.h>
 
 struct bio;
 
@@ -109,15 +108,12 @@ static inline int wbc_to_write_flags(struct writeback_control *wbc)
 	return flags;
 }
 
-static inline struct cgroup_subsys_state *
-wbc_blkcg_css(struct writeback_control *wbc)
-{
 #ifdef CONFIG_CGROUP_WRITEBACK
-	if (wbc->wb)
-		return wbc->wb->blkcg_css;
-#endif
-	return blkcg_root_css;
-}
+#define wbc_blkcg_css(wbc) \
+	((wbc)->wb ? (wbc)->wb->blkcg_css : blkcg_root_css)
+#else
+#define wbc_blkcg_css(wbc)		(blkcg_root_css)
+#endif /* CONFIG_CGROUP_WRITEBACK */
 
 /*
  * A wb_domain represents a domain that wb's (bdi_writeback's) belong to
diff --git a/lib/random32.c b/lib/random32.c
index 4d0e05e471d72..a57a0e18819d0 100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -39,6 +39,7 @@
 #include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/bitops.h>
+#include <linux/slab.h>
 #include <asm/unaligned.h>
 #include <trace/events/random.h>
 
-- 
2.30.2

