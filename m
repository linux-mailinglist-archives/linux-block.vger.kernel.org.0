Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55D228524F
	for <lists+linux-block@lfdr.de>; Tue,  6 Oct 2020 21:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgJFTUp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 6 Oct 2020 15:20:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38036 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgJFTUp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Oct 2020 15:20:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 1096729BD3B
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Omar Sandoval <osandov@fb.com>
Subject: [RESEND PATCH v2] block: Consider only dispatched requests for inflight statistic
Date:   Tue,  6 Oct 2020 15:20:38 -0400
Message-Id: <20201006192038.2484672-1-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201006191509.2482378-1-krisman@collabora.com>
References: <20201006191509.2482378-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Oops, I have no idea what happened, but something ate the hunk at the
last submission.  My apologies.  Please find it below.

>8

According to Documentation/block/stat.rst, inflight should not include
I/O requests that are in the queue but not yet dispatched to the device,
but blk-mq identifies as inflight any request that has a tag allocated,
which, for queues without elevator, happens at request allocation time
and before it is queued in the ctx (default case in blk_mq_submit_bio).

In addition, current behavior is different for queues with elevator from
queues without it, since for the former the driver tag is allocated at
dispatch time.  A more precise approach would be to only consider
requests with state MQ_RQ_IN_FLIGHT.

This effectively reverts commit 6131837b1de6 ("blk-mq: count allocated
but not started requests in iostats inflight") to consolidate blk-mq
behavior with itself (elevator case) and with original documentation,
but it differs from the behavior used by the legacy path.

This version differs from v1 by using blk_mq_rq_state to access the
state attribute.  Avoid using blk_mq_request_started, which was
suggested, since we don't want to include MQ_RQ_COMPLETE.

Cc: Omar Sandoval <osandov@fb.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2e4b3cad2a61..c5fefd39d0c0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -105,7 +105,7 @@ static bool blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
 {
 	struct mq_inflight *mi = priv;
 
-	if (rq->part == mi->part)
+	if (rq->part == mi->part && blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
 		mi->inflight[rq_data_dir(rq)]++;
 
 	return true;
-- 
2.28.0

