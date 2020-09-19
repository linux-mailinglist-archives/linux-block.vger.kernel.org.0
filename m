Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAAE2709F9
	for <lists+linux-block@lfdr.de>; Sat, 19 Sep 2020 04:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgISCPd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 18 Sep 2020 22:15:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44392 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbgISCPd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Sep 2020 22:15:33 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A10CE5A7B70B5E082F60;
        Sat, 19 Sep 2020 10:15:31 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 10:15:21 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH -next v2] rsxx: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat, 19 Sep 2020 10:15:52 +0800
Message-ID: <20200919021552.189712-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
v2: based on linux-next(20200917), and can be applied to
    mainline cleanly now.

 drivers/block/rsxx/core.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index 8799e3bab..7d580965f 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -150,16 +150,6 @@ static int rsxx_attr_stats_show(struct seq_file *m, void *p)
 	return 0;
 }
 
-static int rsxx_attr_stats_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, rsxx_attr_stats_show, inode->i_private);
-}
-
-static int rsxx_attr_pci_regs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, rsxx_attr_pci_regs_show, inode->i_private);
-}
-
 static ssize_t rsxx_cram_read(struct file *fp, char __user *ubuf,
 			      size_t cnt, loff_t *ppos)
 {
@@ -206,21 +196,8 @@ static const struct file_operations debugfs_cram_fops = {
 	.write		= rsxx_cram_write,
 };
 
-static const struct file_operations debugfs_stats_fops = {
-	.owner		= THIS_MODULE,
-	.open		= rsxx_attr_stats_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static const struct file_operations debugfs_pci_regs_fops = {
-	.owner		= THIS_MODULE,
-	.open		= rsxx_attr_pci_regs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(rsxx_attr_stats);
+DEFINE_SHOW_ATTRIBUTE(rsxx_attr_pci_regs);
 
 static void rsxx_debugfs_dev_new(struct rsxx_cardinfo *card)
 {
@@ -234,13 +211,13 @@ static void rsxx_debugfs_dev_new(struct rsxx_cardinfo *card)
 
 	debugfs_stats = debugfs_create_file("stats", 0444,
 					    card->debugfs_dir, card,
-					    &debugfs_stats_fops);
+					    &rsxx_attr_stats_fops);
 	if (IS_ERR_OR_NULL(debugfs_stats))
 		goto failed_debugfs_stats;
 
 	debugfs_pci_regs = debugfs_create_file("pci_regs", 0444,
 					       card->debugfs_dir, card,
-					       &debugfs_pci_regs_fops);
+					       &rsxx_attr_pci_regs_fops);
 	if (IS_ERR_OR_NULL(debugfs_pci_regs))
 		goto failed_debugfs_pci_regs;
 
-- 
2.23.0

