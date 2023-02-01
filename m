Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C8867915E
	for <lists+linux-block@lfdr.de>; Tue, 24 Jan 2023 07:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbjAXG5h (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 24 Jan 2023 01:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjAXG5g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 01:57:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EF13D937;
        Mon, 23 Jan 2023 22:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=yyvfuElyczLnW23wKQAT1v2PmAXGpxcV3xuBqy3rzI4=; b=MK7Ez7zTJPKPzGg9iEgGyxwRGR
        9YkLVbIeaxZ3oAzi4Mi/LgcyN++75FX/0IoHJcjPZWSKtWNQhOp1Z4V+B0fZUFZ3SuKTOf12DDUc1
        PiC/Lh52XXG79hiT/WX09HSOSjoQGLrAFSWUVh7qY8VMx4o2GrXDsERkyYGwxaAq9EBsxqx+W9chp
        7ZiRT3Kp2FTfUETWpO4CHOoIZk7UC75DqlMki0OC6R8su+TxCYE+Z57zKz2ZIRHUpRiYA0TgZCYwW
        f+0BjZhYTCAxqa4BfDxKaR8nU1wMS2knRAW8TYHrsjFUPlR7harhgl1giCGcP1kKCjPExyEFakXsW
        yXGpcdtw==;
Received: from [2001:4bb8:19a:27af:ea4c:1aa8:8f64:2866] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKDFN-002aRN-7V; Tue, 24 Jan 2023 06:57:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: [PATCH 03/15] blk-cgroup: delay blk-cgroup initialization until add_disk
Date:   Tue, 24 Jan 2023 07:57:03 +0100
Message-Id: <20230124065716.152286-4-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230124065716.152286-1-hch@lst.de>
References: <20230124065716.152286-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no need to initialize the group code before the disk is marked
live.  Moving the cgroup initialization earlier will help to have a
fully initialized struct device in the gendisk for the cgroup code to
use in the future.  Similarly tear the cgroup information down in
del_gendisk to be symmetric and because none of the cgroup tracking is
needed once non-passthrough I/O stops.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
---
 block/genhd.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 23cf83b3331cde..705dec0800d62e 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -466,10 +466,14 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	 */
 	pm_runtime_set_memalloc_noio(ddev, true);
 
-	ret = blk_integrity_add(disk);
+	ret = blkcg_init_disk(disk);
 	if (ret)
 		goto out_del_block_link;
 
+	ret = blk_integrity_add(disk);
+	if (ret)
+		goto out_blkcg_exit;
+
 	disk->part0->bd_holder_dir =
 		kobject_create_and_add("holders", &ddev->kobj);
 	if (!disk->part0->bd_holder_dir) {
@@ -534,6 +538,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	kobject_put(disk->part0->bd_holder_dir);
 out_del_integrity:
 	blk_integrity_del(disk);
+out_blkcg_exit:
+	blkcg_exit_disk(disk);
 out_del_block_link:
 	if (!sysfs_deprecated)
 		sysfs_remove_link(block_depr, dev_name(ddev));
@@ -662,6 +668,8 @@ void del_gendisk(struct gendisk *disk)
 	rq_qos_exit(q);
 	blk_mq_unquiesce_queue(q);
 
+	blkcg_exit_disk(disk);
+
 	/*
 	 * If the disk does not own the queue, allow using passthrough requests
 	 * again.  Else leave the queue frozen to fail all I/O.
@@ -1171,8 +1179,6 @@ static void disk_release(struct device *dev)
 	    !test_bit(GD_ADDED, &disk->state))
 		blk_mq_exit_queue(disk->queue);
 
-	blkcg_exit_disk(disk);
-
 	bioset_exit(&disk->bio_split);
 
 	disk_release_events(disk);
@@ -1385,9 +1391,6 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 	if (xa_insert(&disk->part_tbl, 0, disk->part0, GFP_KERNEL))
 		goto out_destroy_part_tbl;
 
-	if (blkcg_init_disk(disk))
-		goto out_erase_part0;
-
 	rand_initialize_disk(disk);
 	disk_to_dev(disk)->class = &block_class;
 	disk_to_dev(disk)->type = &disk_type;
@@ -1400,8 +1403,6 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 #endif
 	return disk;
 
-out_erase_part0:
-	xa_erase(&disk->part_tbl, 0);
 out_destroy_part_tbl:
 	xa_destroy(&disk->part_tbl);
 	disk->part0->bd_disk = NULL;
-- 
2.39.0

