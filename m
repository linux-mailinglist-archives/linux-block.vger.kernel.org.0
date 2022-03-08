Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890734D111C
	for <lists+linux-block@lfdr.de>; Tue,  8 Mar 2022 08:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242826AbiCHHhX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 8 Mar 2022 02:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240331AbiCHHhW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 02:37:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF6B43DDC9
        for <linux-block@vger.kernel.org>; Mon,  7 Mar 2022 23:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646724985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VDv+mpCQdOBtixOTkOmR+1J+tF7n6IGi+OyjGVZkKEo=;
        b=e9hG4eMek7X7nmcqSpxKRd/5QGrqGzsiCsTOR0FVE4kSG0o/ZRyMNS84tQWmnsf17NYaVV
        BQp4ezwFAFB4jP9kE9pk/4WcCdu83zU/EB0azbqW9WqtzlSPWGS1vDY6kcLC3+oPlmrZeX
        rrNrcS94CKD6/kTCS7F8bVkUVyaBZVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-bwIqSDKzMVyha_5nvSdPsQ-1; Tue, 08 Mar 2022 02:32:32 -0500
X-MC-Unique: bwIqSDKzMVyha_5nvSdPsQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 304FE180FD72;
        Tue,  8 Mar 2022 07:32:31 +0000 (UTC)
Received: from localhost (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 77C9C72427;
        Tue,  8 Mar 2022 07:32:30 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V4 1/6] blk-mq: figure out correct numa node for hw queue
Date:   Tue,  8 Mar 2022 15:32:14 +0800
Message-Id: <20220308073219.91173-2-ming.lei@redhat.com>
In-Reply-To: <20220308073219.91173-1-ming.lei@redhat.com>
References: <20220308073219.91173-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The current code always uses default queue map and hw queue index
for figuring out the numa node for hw queue, this way isn't correct
because blk-mq supports three queue maps, and the correct queue map
should be used for the specified hw queue.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a05ce7725031..5d25abf9e551 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3107,15 +3107,41 @@ void blk_mq_free_rq_map(struct blk_mq_tags *tags)
 	blk_mq_free_tags(tags);
 }
 
+static enum hctx_type hctx_idx_to_type(struct blk_mq_tag_set *set,
+		unsigned int hctx_idx)
+{
+	int i;
+
+	for (i = 0; i < set->nr_maps; i++) {
+		unsigned int start = set->map[i].queue_offset;
+		unsigned int end = start + set->map[i].nr_queues;
+
+		if (hctx_idx >= start && hctx_idx < end)
+			break;
+	}
+
+	if (i >= set->nr_maps)
+		i = HCTX_TYPE_DEFAULT;
+
+	return i;
+}
+
+static int blk_mq_get_hctx_node(struct blk_mq_tag_set *set,
+		unsigned int hctx_idx)
+{
+	enum hctx_type type = hctx_idx_to_type(set, hctx_idx);
+
+	return blk_mq_hw_queue_to_node(&set->map[type], hctx_idx);
+}
+
 static struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
 					       unsigned int hctx_idx,
 					       unsigned int nr_tags,
 					       unsigned int reserved_tags)
 {
+	int node = blk_mq_get_hctx_node(set, hctx_idx);
 	struct blk_mq_tags *tags;
-	int node;
 
-	node = blk_mq_hw_queue_to_node(&set->map[HCTX_TYPE_DEFAULT], hctx_idx);
 	if (node == NUMA_NO_NODE)
 		node = set->numa_node;
 
@@ -3164,10 +3190,9 @@ static int blk_mq_alloc_rqs(struct blk_mq_tag_set *set,
 			    unsigned int hctx_idx, unsigned int depth)
 {
 	unsigned int i, j, entries_per_page, max_order = 4;
+	int node = blk_mq_get_hctx_node(set, hctx_idx);
 	size_t rq_size, left;
-	int node;
 
-	node = blk_mq_hw_queue_to_node(&set->map[HCTX_TYPE_DEFAULT], hctx_idx);
 	if (node == NUMA_NO_NODE)
 		node = set->numa_node;
 
@@ -3941,10 +3966,9 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	/* protect against switching io scheduler  */
 	mutex_lock(&q->sysfs_lock);
 	for (i = 0; i < set->nr_hw_queues; i++) {
-		int node;
+		int node = blk_mq_get_hctx_node(set, i);
 		struct blk_mq_hw_ctx *hctx;
 
-		node = blk_mq_hw_queue_to_node(&set->map[HCTX_TYPE_DEFAULT], i);
 		/*
 		 * If the hw queue has been mapped to another numa node,
 		 * we need to realloc the hctx. If allocation fails, fallback
-- 
2.31.1

