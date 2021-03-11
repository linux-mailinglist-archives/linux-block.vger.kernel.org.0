Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9D7336D95
	for <lists+linux-block@lfdr.de>; Thu, 11 Mar 2021 09:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbhCKIRo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 11 Mar 2021 03:17:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:35104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230448AbhCKIRb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Mar 2021 03:17:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615450650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4nPVhXsrHdk8zeiwPTvUYTS/SseCXIjNk7cerul1UOE=;
        b=OhAGo9mOoSylxssVA4fW0tTKb3A2vAtNXrK9XD8qCcCqU9SdsUHh5DJ+k4EKoAuEk4DnqB
        XmKUuu1Hf/5OX07+vf5WTY+w0f+OqKsFW5a5Amj2ik1mdg00dBA5hd2WvAErbAhsFYxQQp
        HmOxEkON9v10ytLrYaQe5eBisk7Mqg4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D5BF6AC16;
        Thu, 11 Mar 2021 08:17:30 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] blk-mq: Document some blk_mq_ctx fields
Date:   Thu, 11 Mar 2021 10:17:29 +0200
Message-Id: <20210311081729.2763232-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 block/blk-mq.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index 3616453ca28c..f0079e177bba 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -17,12 +17,26 @@ struct blk_mq_ctxs {
  */
 struct blk_mq_ctx {
 	struct {
+		/** @lock: Protects the rq_lists */
 		spinlock_t		lock;
 		struct list_head	rq_lists[HCTX_MAX_TYPES];
 	} ____cacheline_aligned_in_smp;
 
+	/**
+	 * @cpu: id of cpu owning this context
+	 */
 	unsigned int		cpu;
+
+	/**
+	 * @index_hw: Number of software queues mapped to the hw queue for each
+	 * hardware queue type
+	 */
 	unsigned short		index_hw[HCTX_MAX_TYPES];
+
+	/**
+	 * @hctxs: Hardware queue this queue maps to for each hardware queue
+	 * type
+	 */
 	struct blk_mq_hw_ctx 	*hctxs[HCTX_MAX_TYPES];
 
 	/* incremented at dispatch time */
@@ -32,6 +46,9 @@ struct blk_mq_ctx {
 	/* incremented at completion time */
 	unsigned long		____cacheline_aligned_in_smp rq_completed[2];
 
+	/**
+	 * @queue: Pointer to the request queue that owns this software context.
+	 */
 	struct request_queue	*queue;
 	struct blk_mq_ctxs      *ctxs;
 	struct kobject		kobj;
-- 
2.25.1

