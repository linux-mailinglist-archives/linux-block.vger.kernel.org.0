Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA2C5927D4
	for <lists+linux-block@lfdr.de>; Mon, 15 Aug 2022 04:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiHOChc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 14 Aug 2022 22:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiHOChb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Aug 2022 22:37:31 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7562C13D5B
        for <linux-block@vger.kernel.org>; Sun, 14 Aug 2022 19:37:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VMCMnyj_1660531035;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VMCMnyj_1660531035)
          by smtp.aliyun-inc.com;
          Mon, 15 Aug 2022 10:37:28 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, xiaoguang.wang@linux.alibaba.com,
        joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH V2 2/3] ublk_drv: update comment for __ublk_fail_req()
Date:   Mon, 15 Aug 2022 10:36:32 +0800
Message-Id: <20220815023633.259825-3-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220815023633.259825-1-ZiyangZhang@linux.alibaba.com>
References: <20220815023633.259825-1-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since __ublk_rq_task_work always fails requests immediately during
exiting, __ublk_fail_req() is only called from abort context during
exiting. So lock is unnecessary.

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 17896172b0fe..685a43b7ae6e 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -605,8 +605,9 @@ static void ublk_complete_rq(struct request *req)
 }
 
 /*
- * __ublk_fail_req() may be called from abort context or ->ubq_daemon
- * context during exiting, so lock is required.
+ * Since __ublk_rq_task_work always fails requests immediately during
+ * exiting, __ublk_fail_req() is only called from abort context during
+ * exiting. So lock is unnecessary.
  *
  * Also aborting may not be started yet, keep in mind that one failed
  * request may be issued by block layer again.
-- 
2.27.0

