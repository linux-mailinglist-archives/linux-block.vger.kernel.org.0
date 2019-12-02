Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59FC510EC7F
	for <lists+linux-block@lfdr.de>; Mon,  2 Dec 2019 16:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfLBPjb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 2 Dec 2019 10:39:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:44838 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727572AbfLBPja (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Dec 2019 10:39:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2B0AFC1AC;
        Mon,  2 Dec 2019 15:39:26 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 05/11] blk-mq: add WARN_ON in blk_mq_free_rqs()
Date:   Mon,  2 Dec 2019 16:39:08 +0100
Message-Id: <20191202153914.84722-6-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191202153914.84722-1-hare@suse.de>
References: <20191202153914.84722-1-hare@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before freeing up the requests we should ensure that none of
those requests are still present in the ->rqs array; this could
lead to an use-after free error.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-mq.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 016f8401cfb9..054c0597c052 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2049,10 +2049,14 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		     unsigned int hctx_idx)
 {
 	struct page *page;
+	int i;
 
-	if (tags->rqs && set->ops->exit_request) {
-		int i;
-
+	if (tags->rqs) {
+		for (i = 0; i < tags->nr_tags; i++)
+			if (WARN_ON(tags->rqs[i]))
+				tags->rqs[i] = NULL;
+	}
+	if (tags->static_rqs && set->ops->exit_request) {
 		for (i = 0; i < tags->nr_tags; i++) {
 			struct request *rq = tags->static_rqs[i];
 
-- 
2.16.4

