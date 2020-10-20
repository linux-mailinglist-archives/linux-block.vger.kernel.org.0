Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F3B293544
	for <lists+linux-block@lfdr.de>; Tue, 20 Oct 2020 08:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404580AbgJTGyX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 20 Oct 2020 02:54:23 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:59924 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728831AbgJTGyX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Oct 2020 02:54:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UCd5jTl_1603176860;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UCd5jTl_1603176860)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Oct 2020 14:54:21 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     snitzer@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        joseph.qi@linux.alibaba.com, xiaoguang.wang@linux.alibaba.com,
        haoxu@linux.alibaba.com
Subject: [RFC 1/3] block/mq: add iterator for polling hw queues
Date:   Tue, 20 Oct 2020 14:54:18 +0800
Message-Id: <20201020065420.124885-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201020065420.124885-1-jefflexu@linux.alibaba.com>
References: <20201020065420.124885-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add one helper function for iterating all hardware queues in polling
mode.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 include/linux/blk-mq.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b23eeca4d677..81c70ce97715 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -571,6 +571,12 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
 	for ((i) = 0; (i) < (q)->nr_hw_queues &&			\
 	     ({ hctx = (q)->queue_hw_ctx[i]; 1; }); (i)++)
 
+#define queue_for_each_poll_hw_ctx(q, hctx, i)				\
+	for ((i) = 0; ((q)->tag_set->nr_maps > HCTX_TYPE_POLL) &&	\
+	     (i) < (q)->tag_set->map[HCTX_TYPE_POLL].nr_queues &&	\
+	     ({ hctx = (q)->queue_hw_ctx[((q)->tag_set->map[HCTX_TYPE_POLL].queue_offset + (i))]; 1; }); \
+	     (i)++)
+
 #define hctx_for_each_ctx(hctx, ctx, i)					\
 	for ((i) = 0; (i) < (hctx)->nr_ctx &&				\
 	     ({ ctx = (hctx)->ctxs[(i)]; 1; }); (i)++)
-- 
2.27.0

