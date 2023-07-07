Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA6C74ADE1
	for <lists+linux-block@lfdr.de>; Fri,  7 Jul 2023 11:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjGGJjI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 7 Jul 2023 05:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjGGJjG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jul 2023 05:39:06 -0400
Received: from out-13.mta0.migadu.com (out-13.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EEE2106
        for <linux-block@vger.kernel.org>; Fri,  7 Jul 2023 02:39:05 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688722743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GNQffBpvwsnQY1EH1HZ//XhBWHXASFg3WNRxajHHe/k=;
        b=fp2imDnjRIdA+x9yfGUVEx9Y742YG+UA7+IZVdK3KPoej92hyEUCPCVKDxZqMwCTvu5NL3
        Zu3ekiHzUtwtu4U58i2kJhJPALPiW46XLqCLscWSUWuLbKxiG7aAHJ5ClJ55+Uferx91IR
        VfmYznnkwG3bzfKDSBnmb11Vz7eBwwI=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v3 1/4] blk-mq: delete unused completion_data in struct request
Date:   Fri,  7 Jul 2023 17:37:19 +0800
Message-ID: <20230707093722.1338589-2-chengming.zhou@linux.dev>
In-Reply-To: <20230707093722.1338589-1-chengming.zhou@linux.dev>
References: <20230707093722.1338589-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

After global search, I found "completion_data" in struct request
is not used anywhere, so just clean it up by the way.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk-mq.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index f401067ac03a..0a1c404e6c7a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -158,13 +158,11 @@ struct request {
 
 	/*
 	 * The rb_node is only used inside the io scheduler, requests
-	 * are pruned when moved to the dispatch queue. So let the
-	 * completion_data share space with the rb_node.
+	 * are pruned when moved to the dispatch queue.
 	 */
 	union {
 		struct rb_node rb_node;	/* sort/lookup */
 		struct bio_vec special_vec;
-		void *completion_data;
 	};
 
 	/*
-- 
2.41.0

