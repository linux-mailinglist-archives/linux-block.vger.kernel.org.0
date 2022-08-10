Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B48C58E6D1
	for <lists+linux-block@lfdr.de>; Wed, 10 Aug 2022 07:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiHJFxw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 10 Aug 2022 01:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiHJFxc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Aug 2022 01:53:32 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A4A85F82
        for <linux-block@vger.kernel.org>; Tue,  9 Aug 2022 22:53:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VLtllU6_1660110789;
Received: from localhost(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VLtllU6_1660110789)
          by smtp.aliyun-inc.com;
          Wed, 10 Aug 2022 13:53:27 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, xiaoguang.wang@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH] ublk_drv: update iod->addr for UBLK_IO_NEED_GET_DATA
Date:   Wed, 10 Aug 2022 13:52:12 +0800
Message-Id: <20220810055212.66417-1-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
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

If ublksrv sends UBLK_IO_NEED_GET_DATA with new allocated io buffer, we
have to update iod->addr in task_work before calling io_uring_cmd_done().
Then usersapce target can handle (write)io request with the new io
buffer reading from updated iod.

Without this change, userspace target may touch a wrong io buffer!

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 0b9bd9e02b53..98c345df6896 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -677,6 +677,11 @@ static inline void __ublk_rq_task_work(struct request *req)
 		 * do the copy work.
 		 */
 		io->flags &= ~UBLK_IO_FLAG_NEED_GET_DATA;
+		/* update iod->addr because ublksrv may have passed a new io buffer */
+		ublk_get_iod(ubq, req->tag)->addr = io->addr;
+		pr_devel("%s: update iod->addr: op %d, qid %d tag %d io_flags %x addr %llx\n",
+				__func__, io->cmd->cmd_op, ubq->q_id, req->tag, io->flags,
+				ublk_get_iod(ubq, req->tag)->addr);
 	}
 
 	mapped_bytes = ublk_map_io(ubq, req, io);
-- 
2.37.1

