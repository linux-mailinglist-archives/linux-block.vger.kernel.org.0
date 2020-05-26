Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B565C1E2013
	for <lists+linux-block@lfdr.de>; Tue, 26 May 2020 12:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgEZKtE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 26 May 2020 06:49:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5284 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726977AbgEZKtE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 May 2020 06:49:04 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1B41DDB73B7C7464554A;
        Tue, 26 May 2020 18:49:02 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Tue, 26 May 2020 18:48:55 +0800
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] blk-mq: Explicitly zero-init blk_mq_tags.active_queues
Date:   Tue, 26 May 2020 18:45:00 +0800
Message-ID: <1590489900-121753-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As is good practice, explicitly zero-init atomic_t type
blk_mq_tags.active_queues.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 586c9d6e904a..cbbd0af9f3b0 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -469,6 +469,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
+	atomic_set(&tags->active_queues, 0);
 
 	return blk_mq_init_bitmap_tags(tags, node, alloc_policy);
 }
-- 
2.16.4

