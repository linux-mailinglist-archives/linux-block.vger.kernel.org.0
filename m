Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44EA658C3D
	for <lists+linux-block@lfdr.de>; Thu, 29 Dec 2022 12:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiL2LfQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 29 Dec 2022 06:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiL2LfN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Dec 2022 06:35:13 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E430413DFF
        for <linux-block@vger.kernel.org>; Thu, 29 Dec 2022 03:35:11 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1672313710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qu4mZ4grBhIrSABkjYWYI2yb4o4KiWbAcR8epDr5sA8=;
        b=v5bEPS8F4AFJxdpMtaCxAOAnfpjfF4Cx0kz3U3iRJHK6tkg3FqISB2Vz1CulHKssdCIaEs
        RNjIAhcIXlqb2jkWuYfKABxDV24o8cz6M9svf0mFiEUP9mQCzTMxpzS3+dY5iXJAR3KDYz
        LgZN7L0P/2AtOpVkM1Mh8OgtmYHR8FA=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk,
        christophe.jaillet@wanadoo.fr
Cc:     error27@gmail.com, linux-block@vger.kernel.org
Subject: [PATCH] block/rnbd-clt: fix wrong max ID in ida_alloc_max
Date:   Thu, 29 Dec 2022 19:35:01 +0800
Message-Id: <20221229113501.16612-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We need to pass 'end - 1' to ida_alloc_max after switch from
ida_simple_get to ida_alloc_max.

And smatch warns.

drivers/block/rnbd/rnbd-clt.c:1460 init_dev() error: Calling ida_alloc_max() with a 'max' argument which is a power of 2. -1 missing?

Fixes: 24afc15dbe21 ("block/rnbd: Remove a useless mutex")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-clt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 78334da74d8b..8cdecec89d74 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1440,7 +1440,7 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
 		goto out_alloc;
 	}
 
-	ret = ida_alloc_max(&index_ida, 1 << (MINORBITS - RNBD_PART_BITS),
+	ret = ida_alloc_max(&index_ida, 1 << (MINORBITS - RNBD_PART_BITS) - 1,
 			    GFP_KERNEL);
 	if (ret < 0) {
 		pr_err("Failed to initialize device '%s' from session %s, allocating idr failed, err: %d\n",
-- 
2.35.3

