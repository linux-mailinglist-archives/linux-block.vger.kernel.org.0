Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5625927D3
	for <lists+linux-block@lfdr.de>; Mon, 15 Aug 2022 04:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiHOChV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 14 Aug 2022 22:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiHOChU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Aug 2022 22:37:20 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5ED13D5B
        for <linux-block@vger.kernel.org>; Sun, 14 Aug 2022 19:37:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VMCMnt4_1660531013;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VMCMnt4_1660531013)
          by smtp.aliyun-inc.com;
          Mon, 15 Aug 2022 10:37:14 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, xiaoguang.wang@linux.alibaba.com,
        joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH V2 1/3] ublk_drv: check ubq_daemon_is_dying() in __ublk_rq_task_work()
Date:   Mon, 15 Aug 2022 10:36:31 +0800
Message-Id: <20220815023633.259825-2-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220815023633.259825-1-ZiyangZhang@linux.alibaba.com>
References: <20220815023633.259825-1-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace direct check on PF_EXITING in __ublk_rq_task_work() by the
existing wrapper. Also inline ubq_daemon_is_dying().

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 5d8c7234639c..17896172b0fe 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -555,7 +555,7 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
 	return (struct ublk_uring_cmd_pdu *)&ioucmd->pdu;
 }
 
-static bool ubq_daemon_is_dying(struct ublk_queue *ubq)
+static inline bool ubq_daemon_is_dying(struct ublk_queue *ubq)
 {
 	return ubq->ubq_daemon->flags & PF_EXITING;
 }
@@ -644,8 +644,7 @@ static inline void __ublk_rq_task_work(struct request *req)
 	struct ublk_device *ub = ubq->dev;
 	int tag = req->tag;
 	struct ublk_io *io = &ubq->ios[tag];
-	bool task_exiting = current != ubq->ubq_daemon ||
-		(current->flags & PF_EXITING);
+	bool task_exiting = current != ubq->ubq_daemon || ubq_daemon_is_dying(ubq);
 	unsigned int mapped_bytes;
 
 	pr_devel("%s: complete: op %d, qid %d tag %d io_flags %x addr %llx\n",
-- 
2.27.0

