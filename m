Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539E9409712
	for <lists+linux-block@lfdr.de>; Mon, 13 Sep 2021 17:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345634AbhIMPUG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 13 Sep 2021 11:20:06 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3779 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346189AbhIMPSw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Sep 2021 11:18:52 -0400
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H7VQy1DYhz67PfY;
        Mon, 13 Sep 2021 23:15:22 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 13 Sep 2021 17:17:34 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 13 Sep 2021 16:17:32 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <ming.lei@redhat.com>, <linux-scsi@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH RESEND v3 07/13] blk-mq: Pass driver tags to blk_mq_clear_rq_mapping()
Date:   Mon, 13 Sep 2021 23:12:24 +0800
Message-ID: <1631545950-56586-8-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1631545950-56586-1-git-send-email-john.garry@huawei.com>
References: <1631545950-56586-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Function blk_mq_clear_rq_mapping() will be used for shared sbitmap tags
in future, so pass a driver tags pointer instead of the tagset container
and HW queue index.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 block/blk-mq.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 47d6ab725bcc..4bae8afdfbe1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2302,10 +2302,9 @@ static size_t order_to_size(unsigned int order)
 }
 
 /* called before freeing request pool in @tags */
-static void blk_mq_clear_rq_mapping(struct blk_mq_tag_set *set,
-		struct blk_mq_tags *tags, unsigned int hctx_idx)
+static void blk_mq_clear_rq_mapping(struct blk_mq_tags *drv_tags,
+				    struct blk_mq_tags *tags)
 {
-	struct blk_mq_tags *drv_tags = set->tags[hctx_idx];
 	struct page *page;
 	unsigned long flags;
 
@@ -2314,7 +2313,7 @@ static void blk_mq_clear_rq_mapping(struct blk_mq_tag_set *set,
 		unsigned long end = start + order_to_size(page->private);
 		int i;
 
-		for (i = 0; i < set->queue_depth; i++) {
+		for (i = 0; i < drv_tags->nr_tags; i++) {
 			struct request *rq = drv_tags->rqs[i];
 			unsigned long rq_addr = (unsigned long)rq;
 
@@ -2338,8 +2337,11 @@ static void blk_mq_clear_rq_mapping(struct blk_mq_tag_set *set,
 void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		     unsigned int hctx_idx)
 {
+	struct blk_mq_tags *drv_tags;
 	struct page *page;
 
+	drv_tags = set->tags[hctx_idx];
+
 	if (tags->static_rqs && set->ops->exit_request) {
 		int i;
 
@@ -2353,7 +2355,7 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		}
 	}
 
-	blk_mq_clear_rq_mapping(set, tags, hctx_idx);
+	blk_mq_clear_rq_mapping(drv_tags, tags);
 
 	while (!list_empty(&tags->page_list)) {
 		page = list_first_entry(&tags->page_list, struct page, lru);
-- 
2.26.2

