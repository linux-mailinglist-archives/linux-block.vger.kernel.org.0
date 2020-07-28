Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CCF230B78
	for <lists+linux-block@lfdr.de>; Tue, 28 Jul 2020 15:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgG1N3z (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Jul 2020 09:29:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:38378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729044AbgG1N3y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 09:29:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3B832B67A;
        Tue, 28 Jul 2020 13:30:04 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Wagner <dwagner@suse.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: Use non _rcu version of list functions for tag_set_list
Date:   Tue, 28 Jul 2020 15:29:51 +0200
Message-Id: <20200728132951.29459-1-dwagner@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

tag_set_list is only accessed under the tag_set_lock lock. There is
no need for using the _rcu list functions.

The _rcu list function were introduced to allow read access to the
tag_set_list protected under RCU, see 705cda97ee3a ("blk-mq: Make it
safe to use RCU to iterate over blk_mq_tag_set.tag_list") and
05b79413946d ("Revert "blk-mq: don't handle TAG_SHARED in restart"").
Those changes got reverted later but the cleanup commit missed a
couple of places to undo the changes.

Fixes: 97889f9ac24f ("blk-mq: remove synchronize_rcu() from blk_mq_del_queue_tag_set()"
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 block/blk-mq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e32cb0217135..14ee7506f32f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2792,7 +2792,7 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 	struct blk_mq_tag_set *set = q->tag_set;
 
 	mutex_lock(&set->tag_list_lock);
-	list_del_rcu(&q->tag_set_list);
+	list_del(&q->tag_set_list);
 	if (list_is_singular(&set->tag_list)) {
 		/* just transitioned to unshared */
 		set->flags &= ~BLK_MQ_F_TAG_SHARED;
@@ -2819,7 +2819,7 @@ static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
 	}
 	if (set->flags & BLK_MQ_F_TAG_SHARED)
 		queue_set_hctx_shared(q, true);
-	list_add_tail_rcu(&q->tag_set_list, &set->tag_list);
+	list_add_tail(&q->tag_set_list, &set->tag_list);
 
 	mutex_unlock(&set->tag_list_lock);
 }
-- 
2.16.4

