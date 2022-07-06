Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9893B56898D
	for <lists+linux-block@lfdr.de>; Wed,  6 Jul 2022 15:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbiGFNcI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 6 Jul 2022 09:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiGFNcH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jul 2022 09:32:07 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9C524093
        for <linux-block@vger.kernel.org>; Wed,  6 Jul 2022 06:32:06 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657114325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L/UttL/iBXWscmtUZHBpvcbNGpMxOQrwmDrDzNQgCd8=;
        b=IjK3ZaZUoY1TKky0BAhWd6h17IyZr4BNyXBMXOb8hwJ8sq35tsgWwlAaexhFIeoiwDYT9x
        08apjlb1fG7hzyxGaG4U6oPw3iHujCx5+Dtse/DByzCoYsTtecOmmialMVy1aBl0/35Pep
        06mADHZXY1hR0ADAz/Z1/vz67o8fKPY=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     axboe@kernel.dk
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        linux-block@vger.kernel.org
Subject: [PATCH V2 5/8] rnbd-clt: adjust the layout of struct rnbd_clt_dev
Date:   Wed,  6 Jul 2022 21:31:49 +0800
Message-Id: <20220706133152.12058-6-guoqing.jiang@linux.dev>
In-Reply-To: <20220706133152.12058-1-guoqing.jiang@linux.dev>
References: <20220706133152.12058-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While at it, let re-arrange the struct to remove holes.

Before, pahole reports

	/* size: 232, cachelines: 4, members: 17 */
	/* sum members: 224, holes: 2, sum holes: 8 */
	/* last cacheline: 40 bytes */

After the change, the report changes to

	/* size: 224, cachelines: 4, members: 17 */
	/* last cacheline: 32 bytes */

Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-clt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
index 7520272541b1..df237d2ea0d9 100644
--- a/drivers/block/rnbd/rnbd-clt.h
+++ b/drivers/block/rnbd/rnbd-clt.h
@@ -106,6 +106,7 @@ struct rnbd_queue {
 };
 
 struct rnbd_clt_dev {
+	struct kobject		kobj;
 	struct rnbd_clt_session	*sess;
 	struct request_queue	*queue;
 	struct rnbd_queue	*hw_queues;
@@ -114,15 +115,14 @@ struct rnbd_clt_dev {
 	u32			clt_device_id;
 	struct mutex		lock;
 	enum rnbd_clt_dev_state	dev_state;
+	refcount_t		refcount;
 	char			*pathname;
 	enum rnbd_access_mode	access_mode;
 	u32			nr_poll_queues;
 	u64			size;		/* device size in bytes */
 	struct list_head        list;
 	struct gendisk		*gd;
-	struct kobject		kobj;
 	char			*blk_symlink_name;
-	refcount_t		refcount;
 	struct work_struct	unmap_on_rmmod_work;
 };
 
-- 
2.31.1

