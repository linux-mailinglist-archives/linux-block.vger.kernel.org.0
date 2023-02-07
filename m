Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC9368D013
	for <lists+linux-block@lfdr.de>; Tue,  7 Feb 2023 08:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjBGHDb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 7 Feb 2023 02:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjBGHDb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2023 02:03:31 -0500
Received: from out199-14.us.a.mail.aliyun.com (out199-14.us.a.mail.aliyun.com [47.90.199.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7A613DDD;
        Mon,  6 Feb 2023 23:02:54 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vb61Xa5_1675753320;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0Vb61Xa5_1675753320)
          by smtp.aliyun-inc.com;
          Tue, 07 Feb 2023 15:02:04 +0800
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
To:     axboe@kernel.dk, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH 1/3] ublk: remove unnecessary NULL check in ublk_rq_has_data()
Date:   Tue,  7 Feb 2023 15:00:31 +0800
Message-Id: <20230207070033.367423-2-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20230207070033.367423-1-ZiyangZhang@linux.alibaba.com>
References: <20230207070033.367423-1-ZiyangZhang@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_has_data() allows a NULL bio so the NULL check in
ublk_rq_has_data() is unnecessary.

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c932e9ea5a0f..55fccce68a9c 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -322,7 +322,7 @@ static inline struct ublk_queue *ublk_get_queue(struct ublk_device *dev,
 
 static inline bool ublk_rq_has_data(const struct request *rq)
 {
-	return rq->bio && bio_has_data(rq->bio);
+	return bio_has_data(rq->bio);
 }
 
 static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
-- 
2.18.4

