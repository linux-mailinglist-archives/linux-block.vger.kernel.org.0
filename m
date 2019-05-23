Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6384827431
	for <lists+linux-block@lfdr.de>; Thu, 23 May 2019 04:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfEWCA3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 22 May 2019 22:00:29 -0400
Received: from smtpbguseast2.qq.com ([54.204.34.130]:55032 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfEWCA2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 May 2019 22:00:28 -0400
X-QQ-mid: bizesmtp7t1558576823tkrb06yzd
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 23 May 2019 10:00:13 +0800 (CST)
X-QQ-SSF: 01400000002000Q0VN60000A0000000
X-QQ-FEAT: 3UaOJI4aduGYfR3kC5jAsSHxyCGR6AojezsPdulb32r2vV43FXu59tAgv2zke
        duGvGbvHxqwqZRNyJP8W55ffScgu4+7PTWFDQ8YyHW8geIle0fOntjyYe8jZIbeSxV+XtvK
        DKQRYVF5zirwDkon71i65axetVeSSSKa87TmywWv2UrN4XhwPDrb2hjIuZUlPMkbt5CZQMw
        AEqCcjlhwaJNak0gBcnSor5Tisz6yHclzMvg1AZ4PmstPUYDioeXnw9E8xJ+29woM9CTvTV
        QwZDM2Z/EPA4FnCdtElL9EP3slFifNpVVKnY8NZBeajSUwLzOR4K5gKF98oFDh8cgLVD65u
        rwt2YV2
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH 2/3] io_uring: no need to reap event repeatedly
Date:   Thu, 23 May 2019 09:59:46 +0800
Message-Id: <1558576787-18310-2-git-send-email-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558576787-18310-1-git-send-email-liuyun01@kylinos.cn>
References: <1558576787-18310-1-git-send-email-liuyun01@kylinos.cn>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Function io_ring_ctx_wait_and_kill use io_iopoll_reap_events
to reap events, No need to do it again in the io_ring_ctx_free
function.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 4430429..3bbd202 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2771,7 +2771,6 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	if (ctx->sqo_mm)
 		mmdrop(ctx->sqo_mm);
 
-	io_iopoll_reap_events(ctx);
 	io_sqe_buffer_unregister(ctx);
 	io_sqe_files_unregister(ctx);
 	io_eventfd_unregister(ctx);
-- 
2.7.4



