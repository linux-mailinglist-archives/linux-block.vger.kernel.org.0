Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59152539394
	for <lists+linux-block@lfdr.de>; Tue, 31 May 2022 17:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345492AbiEaPGu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 31 May 2022 11:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345499AbiEaPGm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 11:06:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A7AB04
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 08:06:38 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 84B8968AFE; Tue, 31 May 2022 17:06:35 +0200 (CEST)
Date:   Tue, 31 May 2022 17:06:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     shinichiro.kawasaki@wdc.com, dan.j.williams@intel.com,
        yukuai3@huawei.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 4/3] block: document debugfs_mutex
Message-ID: <20220531150635.GA23096@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move debugfs_mutex next to the dentries that it protects and document
what it is used for.

Suggested-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c      | 1 -
 include/linux/blkdev.h | 5 ++++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 095a0d68c9b41..5ddcc7b77de0f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -481,7 +481,6 @@ struct request_queue {
 #endif /* CONFIG_BLK_DEV_ZONED */
 
 	int			node;
-	struct mutex		debugfs_mutex;
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	struct blk_trace __rcu	*blk_trace;
 #endif
@@ -527,6 +526,10 @@ struct request_queue {
 	struct dentry		*debugfs_dir;
 	struct dentry		*sched_debugfs_dir;
 	struct dentry		*rqos_debugfs_dir;
+	/*
+	 * Serializes all debugfs metadata operations using the above dentries.
+	 */
+	struct mutex		debugfs_mutex;
 
 	bool			mq_sysfs_init_done;
 
-- 
2.30.2

