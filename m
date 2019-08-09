Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8337388499
	for <lists+linux-block@lfdr.de>; Fri,  9 Aug 2019 23:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfHIV0X (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 9 Aug 2019 17:26:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbfHIV0X (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Aug 2019 17:26:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 933343022DB3;
        Fri,  9 Aug 2019 21:26:23 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-125-29.rdu2.redhat.com [10.10.125.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0087460872;
        Fri,  9 Aug 2019 21:26:22 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     josef@toxicpanda.com, linux-block@vger.kernel.org
Cc:     Mike Christie <mchristi@redhat.com>
Subject: [PATCH 1/4] nbd: add set cmd timeout helper
Date:   Fri,  9 Aug 2019 16:26:07 -0500
Message-Id: <20190809212610.19412-2-mchristi@redhat.com>
In-Reply-To: <20190809212610.19412-1-mchristi@redhat.com>
References: <20190809212610.19412-1-mchristi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 09 Aug 2019 21:26:23 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a helper to set the cmd timeout. It does not really do a lot now,
but will be more useful in the next patches.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 drivers/block/nbd.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5af1988785b0..cb2b98392ae5 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1245,6 +1245,12 @@ static bool nbd_is_valid_blksize(unsigned long blksize)
 	return true;
 }
 
+static void nbd_set_cmd_timeout(struct nbd_device *nbd, u64 timeout)
+{
+	nbd->tag_set.timeout = timeout * HZ;
+	blk_queue_rq_timeout(nbd->disk->queue, timeout * HZ);
+}
+
 /* Must be called with config_lock held */
 static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		       unsigned int cmd, unsigned long arg)
@@ -1275,10 +1281,8 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		nbd_size_set(nbd, config->blksize, arg);
 		return 0;
 	case NBD_SET_TIMEOUT:
-		if (arg) {
-			nbd->tag_set.timeout = arg * HZ;
-			blk_queue_rq_timeout(nbd->disk->queue, arg * HZ);
-		}
+		if (arg)
+			nbd_set_cmd_timeout(nbd, arg);
 		return 0;
 
 	case NBD_SET_FLAGS:
@@ -1798,11 +1802,9 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	if (ret)
 		goto out;
 
-	if (info->attrs[NBD_ATTR_TIMEOUT]) {
-		u64 timeout = nla_get_u64(info->attrs[NBD_ATTR_TIMEOUT]);
-		nbd->tag_set.timeout = timeout * HZ;
-		blk_queue_rq_timeout(nbd->disk->queue, timeout * HZ);
-	}
+	if (info->attrs[NBD_ATTR_TIMEOUT])
+		nbd_set_cmd_timeout(nbd,
+				    nla_get_u64(info->attrs[NBD_ATTR_TIMEOUT]));
 	if (info->attrs[NBD_ATTR_DEAD_CONN_TIMEOUT]) {
 		config->dead_conn_timeout =
 			nla_get_u64(info->attrs[NBD_ATTR_DEAD_CONN_TIMEOUT]);
@@ -1976,11 +1978,9 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 	if (ret)
 		goto out;
 
-	if (info->attrs[NBD_ATTR_TIMEOUT]) {
-		u64 timeout = nla_get_u64(info->attrs[NBD_ATTR_TIMEOUT]);
-		nbd->tag_set.timeout = timeout * HZ;
-		blk_queue_rq_timeout(nbd->disk->queue, timeout * HZ);
-	}
+	if (info->attrs[NBD_ATTR_TIMEOUT])
+		nbd_set_cmd_timeout(nbd,
+				    nla_get_u64(info->attrs[NBD_ATTR_TIMEOUT]));
 	if (info->attrs[NBD_ATTR_DEAD_CONN_TIMEOUT]) {
 		config->dead_conn_timeout =
 			nla_get_u64(info->attrs[NBD_ATTR_DEAD_CONN_TIMEOUT]);
-- 
2.20.1

