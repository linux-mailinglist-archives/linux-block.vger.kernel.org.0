Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8BF4E5389
	for <lists+linux-block@lfdr.de>; Wed, 23 Mar 2022 14:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244511AbiCWNvP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 23 Mar 2022 09:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244494AbiCWNvP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Mar 2022 09:51:15 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967BC46B31;
        Wed, 23 Mar 2022 06:49:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V80FjZB_1648043381;
Received: from localhost(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0V80FjZB_1648043381)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 23 Mar 2022 21:49:42 +0800
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, bostroesser@gmail.com
Subject: [PATCH v2 1/3] scsi: target: tcmu: Fix possible page UAF
Date:   Wed, 23 Mar 2022 21:49:38 +0800
Message-Id: <20220323134940.31463-2-xiaoguang.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20220323134940.31463-1-xiaoguang.wang@linux.alibaba.com>
References: <20220323134940.31463-1-xiaoguang.wang@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

tcmu_try_get_data_page() looks up pages under cmdr_lock, but it don't
take refcount properly and just return page pointer.

When tcmu_try_get_data_page() returns, the returned page may have been
freed by tcmu_blocks_release(), need to get_page() under cmdr_lock to
avoid concurrent tcmu_blocks_release().

Reviewed-by: Bodo Stroesser <bostroesser@gmail.com>
Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
---
 drivers/target/target_core_user.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index 7b2a89a67cdb..06a5c4086551 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -1820,6 +1820,7 @@ static struct page *tcmu_try_get_data_page(struct tcmu_dev *udev, uint32_t dpi)
 	mutex_lock(&udev->cmdr_lock);
 	page = xa_load(&udev->data_pages, dpi);
 	if (likely(page)) {
+		get_page(page);
 		mutex_unlock(&udev->cmdr_lock);
 		return page;
 	}
@@ -1876,6 +1877,7 @@ static vm_fault_t tcmu_vma_fault(struct vm_fault *vmf)
 		/* For the vmalloc()ed cmd area pages */
 		addr = (void *)(unsigned long)info->mem[mi].addr + offset;
 		page = vmalloc_to_page(addr);
+		get_page(page);
 	} else {
 		uint32_t dpi;
 
@@ -1886,7 +1888,6 @@ static vm_fault_t tcmu_vma_fault(struct vm_fault *vmf)
 			return VM_FAULT_SIGBUS;
 	}
 
-	get_page(page);
 	vmf->page = page;
 	return 0;
 }
-- 
2.14.4.44.g2045bb6

