Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F34257C488
	for <lists+linux-block@lfdr.de>; Thu, 21 Jul 2022 08:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiGUGei (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 21 Jul 2022 02:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiGUGeg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 02:34:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03595245F
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 23:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=JENE2YWFfMS9BbG5Fldmp3h+YPSwO6/HQflYsJ0OgVo=; b=SIuInbmN0HTP1tlzuf+Qi5T8va
        MHtVeexDnO4VtA50+alVBC67ZQPDq5g8RAmqdC4vtuwqFu8QtuF03h8DeqSdLSv6p/CAkt1VCvWpR
        QP3KkVPNf7FUWeYvQy/68Fu0ykw0XRb7Ygz27uD3RRyF436f+C8SmEXRm3ZqSB9EKmIQvw03gEmwM
        gwoPYDYDZKSG96XaG6AEqV1UmK8x6D3Y75TFacWMjPGz3FTMcv1qD6agX2QnesVLYxNb7JxrYRWAw
        kzp/ZE7hcfFSrvx2nfGEi4A2FwILmJhIZxb7+uwOQLuetbYRAXV/VxteHWdJ5gmyhFIlGiMuBBMJY
        ymtw+Jjw==;
Received: from [2001:4bb8:18a:6f7a:1b03:4d0e:b929:ebb2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEPla-0014rP-FJ; Thu, 21 Jul 2022 06:34:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: remove __blk_get_queue
Date:   Thu, 21 Jul 2022 08:34:32 +0200
Message-Id: <20220721063432.1714609-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__blk_get_queue is only called by blk_get_queue, so merge the two.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 10 ++++------
 block/blk.h      |  5 -----
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 123468b9d2e43..3d286a256d3d3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -461,12 +461,10 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
  */
 bool blk_get_queue(struct request_queue *q)
 {
-	if (likely(!blk_queue_dying(q))) {
-		__blk_get_queue(q);
-		return true;
-	}
-
-	return false;
+	if (unlikely(blk_queue_dying(q)))
+		return false;
+	kobject_get(&q->kobj);
+	return true;
 }
 EXPORT_SYMBOL(blk_get_queue);
 
diff --git a/block/blk.h b/block/blk.h
index c4b084bfe87c9..1d83b1d41cd10 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -31,11 +31,6 @@ extern struct kmem_cache *blk_requestq_srcu_cachep;
 extern struct kobj_type blk_queue_ktype;
 extern struct ida blk_queue_ida;
 
-static inline void __blk_get_queue(struct request_queue *q)
-{
-	kobject_get(&q->kobj);
-}
-
 bool is_flush_rq(struct request *req);
 
 struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
-- 
2.30.2

