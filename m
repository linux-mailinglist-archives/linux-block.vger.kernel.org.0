Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256B640DC6C
	for <lists+linux-block@lfdr.de>; Thu, 16 Sep 2021 16:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238465AbhIPOJt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 16 Sep 2021 10:09:49 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:16222 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236328AbhIPOJq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Sep 2021 10:09:46 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4H9Jn40dyyz1DH1k;
        Thu, 16 Sep 2021 22:07:20 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 22:08:22 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 16
 Sep 2021 22:08:21 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH v9] nbd: fix uaf in nbd_handle_reply()
Date:   Thu, 16 Sep 2021 22:18:10 +0800
Message-ID: <20210916141810.2325276-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210916093350.1410403-8-yukuai3@huawei.com>
References: <20210916093350.1410403-8-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is a problem that nbd_handle_reply() might access freed request:

1) At first, a normal io is submitted and completed with scheduler:

internel_tag = blk_mq_get_tag -> get tag from sched_tags
 blk_mq_rq_ctx_init
  sched_tags->rq[internel_tag] = sched_tag->static_rq[internel_tag]
...
blk_mq_get_driver_tag
 __blk_mq_get_driver_tag -> get tag from tags
 tags->rq[tag] = sched_tag->static_rq[internel_tag]

So, both tags->rq[tag] and sched_tags->rq[internel_tag] are pointing
to the request: sched_tags->static_rq[internal_tag]. Even if the
io is finished.

2) nbd server send a reply with random tag directly:

recv_work
 nbd_handle_reply
  blk_mq_tag_to_rq(tags, tag)
   rq = tags->rq[tag]

3) if the sched_tags->static_rq is freed:

blk_mq_sched_free_requests
 blk_mq_free_rqs(q->tag_set, hctx->sched_tags, i)
  -> step 2) access rq before clearing rq mapping
  blk_mq_clear_rq_mapping(set, tags, hctx_idx);
  __free_pages() -> rq is freed here

4) Then, nbd continue to use the freed request in nbd_handle_reply

Fix the problem by get 'q_usage_counter' before blk_mq_tag_to_rq(),
thus request is ensured not to be freed because 'q_usage_counter' is
not zero.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
Changes in v9:
 - move percpu_ref_put() behind.

 drivers/block/nbd.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 69dc5eac9ad3..f9d63794275e 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -825,6 +825,7 @@ static void recv_work(struct work_struct *work)
 						     work);
 	struct nbd_device *nbd = args->nbd;
 	struct nbd_config *config = nbd->config;
+	struct request_queue *q = nbd->disk->queue;
 	struct nbd_sock *nsock;
 	struct nbd_cmd *cmd;
 	struct request *rq;
@@ -835,13 +836,28 @@ static void recv_work(struct work_struct *work)
 		if (nbd_read_reply(nbd, args->index, &reply))
 			break;
 
+		/*
+		 * Grab .q_usage_counter so request pool won't go away, then no
+		 * request use-after-free is possible during nbd_handle_reply().
+		 * If queue is frozen, there won't be any inflight requests, we
+		 * needn't to handle the incoming garbage message.
+		 */
+		if (!percpu_ref_tryget(&q->q_usage_counter)) {
+			dev_err(disk_to_dev(nbd->disk), "%s: no io inflight\n",
+				__func__);
+			break;
+		}
+
 		cmd = nbd_handle_reply(nbd, args->index, &reply);
-		if (IS_ERR(cmd))
+		if (IS_ERR(cmd)) {
+			percpu_ref_put(&q->q_usage_counter);
 			break;
+		}
 
 		rq = blk_mq_rq_from_pdu(cmd);
 		if (likely(!blk_should_fake_timeout(rq->q)))
 			blk_mq_complete_request(rq);
+		percpu_ref_put(&q->q_usage_counter);
 	}
 
 	nsock = config->socks[args->index];
-- 
2.31.1

