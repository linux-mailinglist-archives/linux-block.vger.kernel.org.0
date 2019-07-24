Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0778972582
	for <lists+linux-block@lfdr.de>; Wed, 24 Jul 2019 05:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfGXDs6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 Jul 2019 23:48:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfGXDs5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 23:48:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 96160859FE;
        Wed, 24 Jul 2019 03:48:57 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5307C5D71A;
        Wed, 24 Jul 2019 03:48:55 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Ming Lei <ming.lei@redhat.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2 1/5] blk-mq: introduce blk_mq_request_completed()
Date:   Wed, 24 Jul 2019 11:48:39 +0800
Message-Id: <20190724034843.10879-2-ming.lei@redhat.com>
In-Reply-To: <20190724034843.10879-1-ming.lei@redhat.com>
References: <20190724034843.10879-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 24 Jul 2019 03:48:57 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

NVMe needs this function to decide if one request to be aborted has
been completed in normal IO path already.

So introduce it.

Cc: Max Gurtovoy <maxg@mellanox.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 6 ++++++
 include/linux/blk-mq.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b038ec680e84..e1d0b4567388 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -665,6 +665,12 @@ int blk_mq_request_started(struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_mq_request_started);
 
+int blk_mq_request_completed(struct request *rq)
+{
+	return blk_mq_rq_state(rq) == MQ_RQ_COMPLETE;
+}
+EXPORT_SYMBOL_GPL(blk_mq_request_completed);
+
 void blk_mq_start_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ab25e69a15d1..cc5115ca0e19 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -303,6 +303,7 @@ static inline u16 blk_mq_unique_tag_to_tag(u32 unique_tag)
 
 
 int blk_mq_request_started(struct request *rq);
+int blk_mq_request_completed(struct request *rq);
 void blk_mq_start_request(struct request *rq);
 void blk_mq_end_request(struct request *rq, blk_status_t error);
 void __blk_mq_end_request(struct request *rq, blk_status_t error);
-- 
2.20.1

