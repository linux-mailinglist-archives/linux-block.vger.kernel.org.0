Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20CB71A38A2
	for <lists+linux-block@lfdr.de>; Thu,  9 Apr 2020 19:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgDIRJb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 9 Apr 2020 13:09:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:44226 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbgDIRJa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Apr 2020 13:09:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 14000AC53;
        Thu,  9 Apr 2020 17:09:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 92ED61E124D; Thu,  9 Apr 2020 19:09:28 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     <linux-block@vger.kernel.org>,
        Andreas Herrmann <aherrmann@suse.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] bfq: Fix check detecting whether waker queue should be selected
Date:   Thu,  9 Apr 2020 19:09:14 +0200
Message-Id: <20200409170915.30570-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200409170915.30570-1-jack@suse.cz>
References: <20200409170915.30570-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The check in bfq_select_queue() checking whether a waker queue should be
selected has a bug and is checking bfqq->next_rq instead of
bfqq->waker_bfqq->next_rq to verify whether the waker queue has a
request to dispatch. This often results in the condition being false
(most notably when the current queue is idling waiting for next request)
and thus the waker queue logic is ineffective. Fix the condition.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 78ba57efd16b..18f85d474c9c 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4498,7 +4498,7 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 			bfqq = bfqq->bic->bfqq[0];
 		else if (bfq_bfqq_has_waker(bfqq) &&
 			   bfq_bfqq_busy(bfqq->waker_bfqq) &&
-			   bfqq->next_rq &&
+			   bfqq->waker_bfqq->next_rq &&
 			   bfq_serv_to_charge(bfqq->waker_bfqq->next_rq,
 					      bfqq->waker_bfqq) <=
 			   bfq_bfqq_budget_left(bfqq->waker_bfqq)
-- 
2.16.4

