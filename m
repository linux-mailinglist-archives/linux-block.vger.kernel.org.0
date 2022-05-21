Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DD152F9AA
	for <lists+linux-block@lfdr.de>; Sat, 21 May 2022 09:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353703AbiEUHYU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 21 May 2022 03:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344383AbiEUHYR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 May 2022 03:24:17 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80691166475;
        Sat, 21 May 2022 00:24:16 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L4w2D4hSlzCsYl;
        Sat, 21 May 2022 15:19:16 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 21 May 2022 15:24:14 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 21 May
 2022 15:24:13 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <yukuai3@huawei.com>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
Subject: [PATCH -next v3 6/6] nbd: use pr_err to output error message
Date:   Sat, 21 May 2022 15:37:49 +0800
Message-ID: <20220521073749.3146892-7-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220521073749.3146892-1-yukuai3@huawei.com>
References: <20220521073749.3146892-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of using the long printk(KERN_ERR "nbd: ...") to
output error message, defining pr_fmt and using
the short pr_err("") to do that. The replacemen is done
by using the following command:

  sed -i 's/printk(KERN_ERR "nbd: /pr_err("/g' \
		  drivers/block/nbd.c

This patch also rewrap to 80 columns where possible.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/block/nbd.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 349bc3da878d..07f3c139a3d7 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1928,16 +1928,16 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 		 * MKDEV() expect that the max bits of first_minor is 20.
 		 */
 		if (index < 0 || index > MINORMASK >> part_shift) {
-			printk(KERN_ERR "nbd: illegal input index %d\n", index);
+			pr_err("illegal input index %d\n", index);
 			return -EINVAL;
 		}
 	}
 	if (!info->attrs[NBD_ATTR_SOCKETS]) {
-		printk(KERN_ERR "nbd: must specify at least one socket\n");
+		pr_err("must specify at least one socket\n");
 		return -EINVAL;
 	}
 	if (!info->attrs[NBD_ATTR_SIZE_BYTES]) {
-		printk(KERN_ERR "nbd: must specify a size in bytes for the device\n");
+		pr_err("must specify a size in bytes for the device\n");
 		return -EINVAL;
 	}
 again:
@@ -1973,7 +1973,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 		nbd_put(nbd);
 		if (index == -1)
 			goto again;
-		printk(KERN_ERR "nbd: nbd%d already in use\n", index);
+		pr_err("nbd%d already in use\n", index);
 		return -EBUSY;
 	}
 	if (WARN_ON(nbd->config)) {
@@ -1985,7 +1985,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	if (IS_ERR(config)) {
 		mutex_unlock(&nbd->config_lock);
 		nbd_put(nbd);
-		printk(KERN_ERR "nbd: couldn't allocate config\n");
+		pr_err("couldn't allocate config\n");
 		return PTR_ERR(config);
 	}
 	nbd->config = config;
@@ -2041,7 +2041,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 			struct nlattr *socks[NBD_SOCK_MAX+1];
 
 			if (nla_type(attr) != NBD_SOCK_ITEM) {
-				printk(KERN_ERR "nbd: socks must be embedded in a SOCK_ITEM attr\n");
+				pr_err("socks must be embedded in a SOCK_ITEM attr\n");
 				ret = -EINVAL;
 				goto out;
 			}
@@ -2050,7 +2050,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 							  nbd_sock_policy,
 							  info->extack);
 			if (ret != 0) {
-				printk(KERN_ERR "nbd: error processing sock list\n");
+				pr_err("error processing sock list\n");
 				ret = -EINVAL;
 				goto out;
 			}
@@ -2122,7 +2122,7 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
 		return -EPERM;
 
 	if (!info->attrs[NBD_ATTR_INDEX]) {
-		printk(KERN_ERR "nbd: must specify an index to disconnect\n");
+		pr_err("must specify an index to disconnect\n");
 		return -EINVAL;
 	}
 	index = nla_get_u32(info->attrs[NBD_ATTR_INDEX]);
@@ -2130,14 +2130,12 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
 	nbd = idr_find(&nbd_index_idr, index);
 	if (!nbd) {
 		mutex_unlock(&nbd_index_mutex);
-		printk(KERN_ERR "nbd: couldn't find device at index %d\n",
-		       index);
+		pr_err("couldn't find device at index %d\n", index);
 		return -EINVAL;
 	}
 	if (!refcount_inc_not_zero(&nbd->refs)) {
 		mutex_unlock(&nbd_index_mutex);
-		printk(KERN_ERR "nbd: device at index %d is going down\n",
-		       index);
+		pr_err("device at index %d is going down\n", index);
 		return -EINVAL;
 	}
 	mutex_unlock(&nbd_index_mutex);
@@ -2162,7 +2160,7 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 		return -EPERM;
 
 	if (!info->attrs[NBD_ATTR_INDEX]) {
-		printk(KERN_ERR "nbd: must specify a device to reconfigure\n");
+		pr_err("must specify a device to reconfigure\n");
 		return -EINVAL;
 	}
 	index = nla_get_u32(info->attrs[NBD_ATTR_INDEX]);
@@ -2170,8 +2168,7 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 	nbd = idr_find(&nbd_index_idr, index);
 	if (!nbd) {
 		mutex_unlock(&nbd_index_mutex);
-		printk(KERN_ERR "nbd: couldn't find a device at index %d\n",
-		       index);
+		pr_err("couldn't find a device at index %d\n", index);
 		return -EINVAL;
 	}
 	if (nbd->backend) {
@@ -2192,8 +2189,7 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 	}
 	if (!refcount_inc_not_zero(&nbd->refs)) {
 		mutex_unlock(&nbd_index_mutex);
-		printk(KERN_ERR "nbd: device at index %d is going down\n",
-		       index);
+		pr_err("device at index %d is going down\n", index);
 		return -EINVAL;
 	}
 	mutex_unlock(&nbd_index_mutex);
@@ -2257,7 +2253,7 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 			struct nlattr *socks[NBD_SOCK_MAX+1];
 
 			if (nla_type(attr) != NBD_SOCK_ITEM) {
-				printk(KERN_ERR "nbd: socks must be embedded in a SOCK_ITEM attr\n");
+				pr_err("socks must be embedded in a SOCK_ITEM attr\n");
 				ret = -EINVAL;
 				goto out;
 			}
@@ -2266,7 +2262,7 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 							  nbd_sock_policy,
 							  info->extack);
 			if (ret != 0) {
-				printk(KERN_ERR "nbd: error processing sock list\n");
+				pr_err("error processing sock list\n");
 				ret = -EINVAL;
 				goto out;
 			}
@@ -2483,7 +2479,7 @@ static int __init nbd_init(void)
 	BUILD_BUG_ON(sizeof(struct nbd_request) != 28);
 
 	if (max_part < 0) {
-		printk(KERN_ERR "nbd: max_part must be >= 0\n");
+		pr_err("max_part must be >= 0\n");
 		return -EINVAL;
 	}
 
@@ -2562,10 +2558,10 @@ static void __exit nbd_cleanup(void)
 		nbd = list_first_entry(&del_list, struct nbd_device, list);
 		list_del_init(&nbd->list);
 		if (refcount_read(&nbd->config_refs))
-			printk(KERN_ERR "nbd: possibly leaking nbd_config (ref %d)\n",
+			pr_err("possibly leaking nbd_config (ref %d)\n",
 					refcount_read(&nbd->config_refs));
 		if (refcount_read(&nbd->refs) != 1)
-			printk(KERN_ERR "nbd: possibly leaking a device\n");
+			pr_err("possibly leaking a device\n");
 		nbd_put(nbd);
 	}
 
-- 
2.31.1

