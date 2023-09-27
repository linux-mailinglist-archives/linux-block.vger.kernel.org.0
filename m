Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B6F7B0089
	for <lists+linux-block@lfdr.de>; Wed, 27 Sep 2023 11:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjI0Jfo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 27 Sep 2023 05:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjI0JfB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Sep 2023 05:35:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C682519A;
        Wed, 27 Sep 2023 02:34:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F2BAA1FD6C;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695807285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ureXPVypBtPxlZhl3+g20W/OKPlFCMOeOub7CiKcuo=;
        b=iFSliLpVrXcSLuPExiWmDGZa/B0OwAUZU1rtXbAZqMLx8nNL64BxY8wc5smrCfAdcmJBQ3
        VqNEgV8R6ClPU6K0jFxnNuYW2f3guJ4vmxZZtwywJLs5KYUJbbrvEvDJbo/88NGRa4dmkP
        enUperpHGU2JMPCSZWQG4vvlSJI9csM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695807285;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ureXPVypBtPxlZhl3+g20W/OKPlFCMOeOub7CiKcuo=;
        b=O2qb5Y4tRkgfY8bJ6TKcYHnhHGJ5RzU1lR0cNg+2aMiF2zSZ5eFA3QDzeWN7WptSliqXuv
        UTY+zvZxlCGrjiAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3AA013ADA;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mHWTNzT3E2U3EwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 27 Sep 2023 09:34:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AB772A07D0; Wed, 27 Sep 2023 11:34:43 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 26/29] ocfs2: Convert to use bdev_open_by_dev()
Date:   Wed, 27 Sep 2023 11:34:32 +0200
Message-Id: <20230927093442.25915-26-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10876; i=jack@suse.cz; h=from:subject; bh=90P2zBbnQwy1aA0C9jwiIz+L8VHmpI+86AhLoGZ9oK4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlE/coSqY/0G1RJJg7CInbnh3lniJFl3w409fL1YUd uF/+vkqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZRP3KAAKCRCcnaoHP2RA2Sj6B/ 0UbYkjIW2+rIgV91qO6zpfLbzky7VsVC9Z4/RgTx5p9QKJPQFITbQkitG2l1KtP+GRG+FURXi2DdAA bCiDK1RmEeoyv7omuTlwAL21wJomKNR3yLK3P3z49QCna5kQNdysNiqZPUP/480UPYy+irZ2uIVACw +d2nArExIOoqhWsB3uqOMQcplqOi0UYEgwVuYrOHGHpAJ839pKLdYaWEr6pXIfLfscM01PYtTL4q7h ixTNVSpfa0C269XkoBBvfFkoQ/SBaaGGvNCrNFUSZKR/GgMW4E/V3flRSGKH5NF6CNqp1VYAGi+1uh U9/l0XT1CbWHsZ6Vsqxp7szsop4giY
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Convert ocfs2 heartbeat code to use bdev_open_by_dev() and pass the
handle around.

CC: Joseph Qi <joseph.qi@linux.alibaba.com>
CC: ocfs2-devel@oss.oracle.com
Acked-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ocfs2/cluster/heartbeat.c | 81 ++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 36 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 21472e3ed182..4d7efefa98c5 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -213,7 +213,7 @@ struct o2hb_region {
 	unsigned int		hr_num_pages;
 
 	struct page             **hr_slot_data;
-	struct block_device	*hr_bdev;
+	struct bdev_handle	*hr_bdev_handle;
 	struct o2hb_disk_slot	*hr_slots;
 
 	/* live node map of this region */
@@ -261,6 +261,11 @@ struct o2hb_region {
 	int			hr_last_hb_status;
 };
 
+static inline struct block_device *reg_bdev(struct o2hb_region *reg)
+{
+	return reg->hr_bdev_handle ? reg->hr_bdev_handle->bdev : NULL;
+}
+
 struct o2hb_bio_wait_ctxt {
 	atomic_t          wc_num_reqs;
 	struct completion wc_io_complete;
@@ -286,7 +291,7 @@ static void o2hb_write_timeout(struct work_struct *work)
 			     hr_write_timeout_work.work);
 
 	mlog(ML_ERROR, "Heartbeat write timeout to device %pg after %u "
-	     "milliseconds\n", reg->hr_bdev,
+	     "milliseconds\n", reg_bdev(reg),
 	     jiffies_to_msecs(jiffies - reg->hr_last_timeout_start));
 
 	if (o2hb_global_heartbeat_active()) {
@@ -383,7 +388,7 @@ static void o2hb_nego_timeout(struct work_struct *work)
 		if (!test_bit(master_node, reg->hr_nego_node_bitmap)) {
 			printk(KERN_NOTICE "o2hb: node %d hb write hung for %ds on region %s (%pg).\n",
 				o2nm_this_node(), O2HB_NEGO_TIMEOUT_MS/1000,
-				config_item_name(&reg->hr_item), reg->hr_bdev);
+				config_item_name(&reg->hr_item), reg_bdev(reg));
 			set_bit(master_node, reg->hr_nego_node_bitmap);
 		}
 		if (!bitmap_equal(reg->hr_nego_node_bitmap, live_node_bitmap,
@@ -398,7 +403,8 @@ static void o2hb_nego_timeout(struct work_struct *work)
 		}
 
 		printk(KERN_NOTICE "o2hb: all nodes hb write hung, maybe region %s (%pg) is down.\n",
-			config_item_name(&reg->hr_item), reg->hr_bdev);
+			config_item_name(&reg->hr_item),
+			reg_bdev(reg));
 		/* approve negotiate timeout request. */
 		o2hb_arm_timeout(reg);
 
@@ -419,7 +425,7 @@ static void o2hb_nego_timeout(struct work_struct *work)
 		/* negotiate timeout with master node. */
 		printk(KERN_NOTICE "o2hb: node %d hb write hung for %ds on region %s (%pg), negotiate timeout with node %d.\n",
 			o2nm_this_node(), O2HB_NEGO_TIMEOUT_MS/1000, config_item_name(&reg->hr_item),
-			reg->hr_bdev, master_node);
+			reg_bdev(reg), master_node);
 		ret = o2hb_send_nego_msg(reg->hr_key, O2HB_NEGO_TIMEOUT_MSG,
 				master_node);
 		if (ret)
@@ -436,7 +442,8 @@ static int o2hb_nego_timeout_handler(struct o2net_msg *msg, u32 len, void *data,
 
 	nego_msg = (struct o2hb_nego_msg *)msg->buf;
 	printk(KERN_NOTICE "o2hb: receive negotiate timeout message from node %d on region %s (%pg).\n",
-		nego_msg->node_num, config_item_name(&reg->hr_item), reg->hr_bdev);
+		nego_msg->node_num, config_item_name(&reg->hr_item),
+		reg_bdev(reg));
 	if (nego_msg->node_num < O2NM_MAX_NODES)
 		set_bit(nego_msg->node_num, reg->hr_nego_node_bitmap);
 	else
@@ -451,7 +458,7 @@ static int o2hb_nego_approve_handler(struct o2net_msg *msg, u32 len, void *data,
 	struct o2hb_region *reg = data;
 
 	printk(KERN_NOTICE "o2hb: negotiate timeout approved by master node on region %s (%pg).\n",
-		config_item_name(&reg->hr_item), reg->hr_bdev);
+		config_item_name(&reg->hr_item), reg_bdev(reg));
 	o2hb_arm_timeout(reg);
 	return 0;
 }
@@ -515,7 +522,7 @@ static struct bio *o2hb_setup_one_bio(struct o2hb_region *reg,
 	 * GFP_KERNEL that the local node can get fenced. It would be
 	 * nicest if we could pre-allocate these bios and avoid this
 	 * all together. */
-	bio = bio_alloc(reg->hr_bdev, 16, opf, GFP_ATOMIC);
+	bio = bio_alloc(reg_bdev(reg), 16, opf, GFP_ATOMIC);
 	if (!bio) {
 		mlog(ML_ERROR, "Could not alloc slots BIO!\n");
 		bio = ERR_PTR(-ENOMEM);
@@ -687,7 +694,7 @@ static int o2hb_check_own_slot(struct o2hb_region *reg)
 		errstr = ERRSTR3;
 
 	mlog(ML_ERROR, "%s (%pg): expected(%u:0x%llx, 0x%llx), "
-	     "ondisk(%u:0x%llx, 0x%llx)\n", errstr, reg->hr_bdev,
+	     "ondisk(%u:0x%llx, 0x%llx)\n", errstr, reg_bdev(reg),
 	     slot->ds_node_num, (unsigned long long)slot->ds_last_generation,
 	     (unsigned long long)slot->ds_last_time, hb_block->hb_node,
 	     (unsigned long long)le64_to_cpu(hb_block->hb_generation),
@@ -861,7 +868,7 @@ static void o2hb_set_quorum_device(struct o2hb_region *reg)
 		goto unlock;
 
 	printk(KERN_NOTICE "o2hb: Region %s (%pg) is now a quorum device\n",
-	       config_item_name(&reg->hr_item), reg->hr_bdev);
+	       config_item_name(&reg->hr_item), reg_bdev(reg));
 
 	set_bit(reg->hr_region_num, o2hb_quorum_region_bitmap);
 
@@ -920,7 +927,7 @@ static int o2hb_check_slot(struct o2hb_region *reg,
 		 * consider it a transient miss but don't populate any
 		 * other values as they may be junk. */
 		mlog(ML_ERROR, "Node %d has written a bad crc to %pg\n",
-		     slot->ds_node_num, reg->hr_bdev);
+		     slot->ds_node_num, reg_bdev(reg));
 		o2hb_dump_slot(hb_block);
 
 		slot->ds_equal_samples++;
@@ -1003,8 +1010,8 @@ static int o2hb_check_slot(struct o2hb_region *reg,
 			     "of %u ms, but our count is %u ms.\n"
 			     "Please double check your configuration values "
 			     "for 'O2CB_HEARTBEAT_THRESHOLD'\n",
-			     slot->ds_node_num, reg->hr_bdev, slot_dead_ms,
-			     dead_ms);
+			     slot->ds_node_num, reg_bdev(reg),
+			     slot_dead_ms, dead_ms);
 		}
 		goto out;
 	}
@@ -1143,7 +1150,7 @@ static int o2hb_do_disk_heartbeat(struct o2hb_region *reg)
 		 * can't be sure that the new block ever made it to
 		 * disk */
 		mlog(ML_ERROR, "Write error %d on device \"%pg\"\n",
-		     write_wc.wc_error, reg->hr_bdev);
+		     write_wc.wc_error, reg_bdev(reg));
 		ret = write_wc.wc_error;
 		goto bail;
 	}
@@ -1169,7 +1176,7 @@ static int o2hb_do_disk_heartbeat(struct o2hb_region *reg)
 			printk(KERN_NOTICE "o2hb: Unable to stabilize "
 			       "heartbeat on region %s (%pg)\n",
 			       config_item_name(&reg->hr_item),
-			       reg->hr_bdev);
+			       reg_bdev(reg));
 			atomic_set(&reg->hr_steady_iterations, 0);
 			reg->hr_aborted_start = 1;
 			wake_up(&o2hb_steady_queue);
@@ -1489,7 +1496,7 @@ static void o2hb_region_release(struct config_item *item)
 	struct page *page;
 	struct o2hb_region *reg = to_o2hb_region(item);
 
-	mlog(ML_HEARTBEAT, "hb region release (%pg)\n", reg->hr_bdev);
+	mlog(ML_HEARTBEAT, "hb region release (%pg)\n", reg_bdev(reg));
 
 	kfree(reg->hr_tmp_block);
 
@@ -1502,8 +1509,8 @@ static void o2hb_region_release(struct config_item *item)
 		kfree(reg->hr_slot_data);
 	}
 
-	if (reg->hr_bdev)
-		blkdev_put(reg->hr_bdev, NULL);
+	if (reg->hr_bdev_handle)
+		bdev_release(reg->hr_bdev_handle);
 
 	kfree(reg->hr_slots);
 
@@ -1562,7 +1569,7 @@ static ssize_t o2hb_region_block_bytes_store(struct config_item *item,
 	unsigned long block_bytes;
 	unsigned int block_bits;
 
-	if (reg->hr_bdev)
+	if (reg->hr_bdev_handle)
 		return -EINVAL;
 
 	status = o2hb_read_block_input(reg, page, &block_bytes,
@@ -1591,7 +1598,7 @@ static ssize_t o2hb_region_start_block_store(struct config_item *item,
 	char *p = (char *)page;
 	ssize_t ret;
 
-	if (reg->hr_bdev)
+	if (reg->hr_bdev_handle)
 		return -EINVAL;
 
 	ret = kstrtoull(p, 0, &tmp);
@@ -1616,7 +1623,7 @@ static ssize_t o2hb_region_blocks_store(struct config_item *item,
 	unsigned long tmp;
 	char *p = (char *)page;
 
-	if (reg->hr_bdev)
+	if (reg->hr_bdev_handle)
 		return -EINVAL;
 
 	tmp = simple_strtoul(p, &p, 0);
@@ -1635,8 +1642,8 @@ static ssize_t o2hb_region_dev_show(struct config_item *item, char *page)
 {
 	unsigned int ret = 0;
 
-	if (to_o2hb_region(item)->hr_bdev)
-		ret = sprintf(page, "%pg\n", to_o2hb_region(item)->hr_bdev);
+	if (to_o2hb_region(item)->hr_bdev_handle)
+		ret = sprintf(page, "%pg\n", reg_bdev(to_o2hb_region(item)));
 
 	return ret;
 }
@@ -1745,7 +1752,10 @@ static int o2hb_populate_slot_data(struct o2hb_region *reg)
 	return ret;
 }
 
-/* this is acting as commit; we set up all of hr_bdev and hr_task or nothing */
+/*
+ * this is acting as commit; we set up all of hr_bdev_handle and hr_task or
+ * nothing
+ */
 static ssize_t o2hb_region_dev_store(struct config_item *item,
 				     const char *page,
 				     size_t count)
@@ -1759,7 +1769,7 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 	ssize_t ret = -EINVAL;
 	int live_threshold;
 
-	if (reg->hr_bdev)
+	if (reg->hr_bdev_handle)
 		goto out;
 
 	/* We can't heartbeat without having had our node number
@@ -1785,16 +1795,15 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 	if (!S_ISBLK(f.file->f_mapping->host->i_mode))
 		goto out2;
 
-	reg->hr_bdev = blkdev_get_by_dev(f.file->f_mapping->host->i_rdev,
-					 BLK_OPEN_WRITE | BLK_OPEN_READ, NULL,
-					 NULL);
-	if (IS_ERR(reg->hr_bdev)) {
-		ret = PTR_ERR(reg->hr_bdev);
-		reg->hr_bdev = NULL;
+	reg->hr_bdev_handle = bdev_open_by_dev(f.file->f_mapping->host->i_rdev,
+			BLK_OPEN_WRITE | BLK_OPEN_READ, NULL, NULL);
+	if (IS_ERR(reg->hr_bdev_handle)) {
+		ret = PTR_ERR(reg->hr_bdev_handle);
+		reg->hr_bdev_handle = NULL;
 		goto out2;
 	}
 
-	sectsize = bdev_logical_block_size(reg->hr_bdev);
+	sectsize = bdev_logical_block_size(reg_bdev(reg));
 	if (sectsize != reg->hr_block_bytes) {
 		mlog(ML_ERROR,
 		     "blocksize %u incorrect for device, expected %d",
@@ -1890,12 +1899,12 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 
 	if (hb_task && o2hb_global_heartbeat_active())
 		printk(KERN_NOTICE "o2hb: Heartbeat started on region %s (%pg)\n",
-		       config_item_name(&reg->hr_item), reg->hr_bdev);
+		       config_item_name(&reg->hr_item), reg_bdev(reg));
 
 out3:
 	if (ret < 0) {
-		blkdev_put(reg->hr_bdev, NULL);
-		reg->hr_bdev = NULL;
+		bdev_release(reg->hr_bdev_handle);
+		reg->hr_bdev_handle = NULL;
 	}
 out2:
 	fdput(f);
@@ -2085,7 +2094,7 @@ static void o2hb_heartbeat_group_drop_item(struct config_group *group,
 		printk(KERN_NOTICE "o2hb: Heartbeat %s on region %s (%pg)\n",
 		       ((atomic_read(&reg->hr_steady_iterations) == 0) ?
 			"stopped" : "start aborted"), config_item_name(item),
-		       reg->hr_bdev);
+		       reg_bdev(reg));
 	}
 
 	/*
-- 
2.35.3

