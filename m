Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC4B568988
	for <lists+linux-block@lfdr.de>; Wed,  6 Jul 2022 15:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbiGFNcC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 6 Jul 2022 09:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbiGFNcB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jul 2022 09:32:01 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A65F23BD7
        for <linux-block@vger.kernel.org>; Wed,  6 Jul 2022 06:32:00 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657114318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XqaIWhJ5bGBPWTK+PPs/n3Sa3fxwgcYxiL2lazLYoxE=;
        b=ZPuFduKxI76P2Rs0VssjbDcT9jL9HQrYmaKJEQGhOq4ZBAKhBFf1Vr5EKQtshqZJQ+szkR
        Ry/ZZc1bliNnYFWde9wFT4X6N6f4txLqP+7zq2BsWOa5isWgvtIudfbCu7YaB1Cy5MfB9+
        VDbcWYJqJ3WDCkmLqUlWb/0npynyu3c=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     axboe@kernel.dk
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        linux-block@vger.kernel.org
Subject: [PATCH V2 1/8] rnbd-clt: open code send_msg_open in rnbd_clt_map_device
Date:   Wed,  6 Jul 2022 21:31:45 +0800
Message-Id: <20220706133152.12058-2-guoqing.jiang@linux.dev>
In-Reply-To: <20220706133152.12058-1-guoqing.jiang@linux.dev>
References: <20220706133152.12058-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Let's open code it in rnbd_clt_map_device, then we can use information
from rsp to setup gendisk and request_queue in next commits. After that,
we can remove some members (wc, fua and max_hw_sectors etc) from struct
rnbd_clt_dev.

Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-clt.c | 43 +++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index b8d9e2824d9c..00d26e42a21b 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1562,7 +1562,14 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 {
 	struct rnbd_clt_session *sess;
 	struct rnbd_clt_dev *dev;
-	int ret;
+	int ret, errno;
+	struct rnbd_msg_open_rsp *rsp;
+	struct rnbd_msg_open msg;
+	struct rnbd_iu *iu;
+	struct kvec vec = {
+		.iov_base = &msg,
+		.iov_len  = sizeof(msg)
+	};
 
 	if (exists_devpath(pathname, sessname))
 		return ERR_PTR(-EEXIST);
@@ -1582,7 +1589,39 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 		ret = -EEXIST;
 		goto put_dev;
 	}
-	ret = send_msg_open(dev, RTRS_PERMIT_WAIT);
+
+	rsp = kzalloc(sizeof(*rsp), GFP_KERNEL);
+	if (!rsp) {
+		ret = -ENOMEM;
+		goto del_dev;
+	}
+
+	iu = rnbd_get_iu(sess, RTRS_ADMIN_CON, RTRS_PERMIT_WAIT);
+	if (!iu) {
+		ret = -ENOMEM;
+		kfree(rsp);
+		goto del_dev;
+	}
+	iu->buf = rsp;
+	iu->dev = dev;
+	sg_init_one(iu->sgt.sgl, rsp, sizeof(*rsp));
+
+	msg.hdr.type    = cpu_to_le16(RNBD_MSG_OPEN);
+	msg.access_mode = dev->access_mode;
+	strscpy(msg.dev_name, dev->pathname, sizeof(msg.dev_name));
+
+	WARN_ON(!rnbd_clt_get_dev(dev));
+	ret = send_usr_msg(sess->rtrs, READ, iu,
+			   &vec, sizeof(*rsp), iu->sgt.sgl, 1,
+			   msg_open_conf, &errno, RTRS_PERMIT_WAIT);
+	if (ret) {
+		rnbd_clt_put_dev(dev);
+		rnbd_put_iu(sess, iu);
+		kfree(rsp);
+	} else {
+		ret = errno;
+	}
+	rnbd_put_iu(sess, iu);
 	if (ret) {
 		rnbd_clt_err(dev,
 			      "map_device: failed, can't open remote device, err: %d\n",
-- 
2.31.1

