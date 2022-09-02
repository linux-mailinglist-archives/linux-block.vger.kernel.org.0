Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374345AABF8
	for <lists+linux-block@lfdr.de>; Fri,  2 Sep 2022 12:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiIBKBU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 2 Sep 2022 06:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbiIBKBP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Sep 2022 06:01:15 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A141685AB1
        for <linux-block@vger.kernel.org>; Fri,  2 Sep 2022 03:01:07 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662112866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+WSJJBKOPtFCE2TNF9n3xczUw3uiyFoNFLDpdimnZiA=;
        b=sqKAVw8qYMLaZzZb76A+oM61mOM1cwY0DXt8ucZGL/bfd4jsD/ctDvVN24fRLe3PC7TNMG
        ERzLSMBtHl/6oiXxV3IyBBuHQLKdlPWXMeutWAF/NTrLXgTDXFr3SNEHazt7pCIUQMW6OM
        YRHHY3+T25zCrH7UfE2TcpFtVIZQvGs=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH V2 3/3] rnbd-srv: remove redundant setting of blk_open_flags
Date:   Fri,  2 Sep 2022 18:00:55 +0800
Message-Id: <20220902100055.25724-4-guoqing.jiang@linux.dev>
In-Reply-To: <20220902100055.25724-1-guoqing.jiang@linux.dev>
References: <20220902100055.25724-1-guoqing.jiang@linux.dev>
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

It is not necessary since it is set later just before function
return success.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/block/rnbd/rnbd-srv-dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-srv-dev.c b/drivers/block/rnbd/rnbd-srv-dev.c
index c63017f6e421..38131fa5718d 100644
--- a/drivers/block/rnbd/rnbd-srv-dev.c
+++ b/drivers/block/rnbd/rnbd-srv-dev.c
@@ -21,7 +21,6 @@ struct rnbd_dev *rnbd_dev_open(const char *path, fmode_t flags)
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 
-	dev->blk_open_flags = flags;
 	dev->bdev = blkdev_get_by_path(path, flags, THIS_MODULE);
 	ret = PTR_ERR_OR_ZERO(dev->bdev);
 	if (ret)
-- 
2.31.1

