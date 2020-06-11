Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D194A1F61DE
	for <lists+linux-block@lfdr.de>; Thu, 11 Jun 2020 08:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgFKGpI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 11 Jun 2020 02:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgFKGpI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 02:45:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18404C08C5C1
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2020 23:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MCO3+aH55X6dXD5+pkbpvy8KkFldeBlpKX1O+M4+0+g=; b=MGkeY4a3naZ73vbFcX3YVXoKyn
        KK41slXA8wWiApy6WqF53NyZLwJ8uByke417Dz880/dx+5NVTMLn7JH/ve2Od2l/wpj7+U3qy34lE
        A0cPRc1s6l/EMVHUFMLpfJoWWNFKgiZLkWZPaj+h20Pnn2qis8LdWOYyGnkavXbk23bjt6WzxZ2EK
        cmttecBEoG+oBXof76aYoQR/maiH+O4GWtrVcvlexnyfiAWD0qvgr9HWQkuJbWlzOGM/FviLEoYva
        gdjjcDyIvQps3Jd/So+hz6698X88WqfbBr4K8i4pTx6GOlGX+Z+MNWMRsNlb3MxH+qUa1DYEsGRlp
        hjQwLQNg==;
Received: from [2001:4bb8:18c:317f:efe9:d6fc:cdd9:b4ec] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjGxW-0005Zo-S8; Thu, 11 Jun 2020 06:45:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-block@vger.kernel.org,
        linux-nvme@lists.infrdead.org
Subject: [PATCH 04/12] blk-mq: complete polled requests directly
Date:   Thu, 11 Jun 2020 08:44:44 +0200
Message-Id: <20200611064452.12353-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200611064452.12353-1-hch@lst.de>
References: <20200611064452.12353-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Even for single queue devices there is no point in offloading a polled
completion to the softirq, given that blk_mq_force_complete_rq is called
from the polling thread in that case and thus there are no starvation
issues.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9d3928456af1c8..25ce40b367a635 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -703,6 +703,16 @@ void blk_mq_force_complete_rq(struct request *rq)
 	int cpu;
 
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
+
+	/*
+	 * For a polled request, always complete locallly, it's pointless
+	 * to redirect the completion.
+	 */
+	if (rq->cmd_flags & REQ_HIPRI) {
+		q->mq_ops->complete(rq);
+		return;
+	}
+
 	/*
 	 * Most of single queue controllers, there is only one irq vector
 	 * for handling IO completion, and the only irq's affinity is set
@@ -717,12 +727,7 @@ void blk_mq_force_complete_rq(struct request *rq)
 		return;
 	}
 
-	/*
-	 * For a polled request, always complete locallly, it's pointless
-	 * to redirect the completion.
-	 */
-	if ((rq->cmd_flags & REQ_HIPRI) ||
-	    !test_bit(QUEUE_FLAG_SAME_COMP, &q->queue_flags)) {
+	if (!test_bit(QUEUE_FLAG_SAME_COMP, &q->queue_flags)) {
 		q->mq_ops->complete(rq);
 		return;
 	}
-- 
2.26.2

