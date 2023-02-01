Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC7A67916E
	for <lists+linux-block@lfdr.de>; Tue, 24 Jan 2023 07:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjAXG5y (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 24 Jan 2023 01:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbjAXG5w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 01:57:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155A530C7;
        Mon, 23 Jan 2023 22:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gmGRlIGbk7cMAdW29RoVHKV85PE4HvKI0abjEhUf1L4=; b=mrmfBzrJWYsBTpWpWWERVwfjMC
        O+UIJ8jfUgV6C1T50CnnPRwhF8aWeYZiukC76l+awv/4nr/QYUM7+fsPuXcxLwqX0N8M8KqDIse1c
        T/EzN6JpA+qyVZmptDVp/2IB1Z+FRpx/edKxuY2gFO+tQCgxHFzDLX8uY0L4e0vSYMURGHLtDYxoc
        kauBz0M6yZ77FtX/6S3Fy4SnZujHERklcV3xCpIE2rj1akirnN+qJTxFGADvWNXaav/FA05/mrtbx
        P7/8oAaSSI3TJEuqHbVGKLZPFhdXHQKO2TjanG1zXCbBzIqtgm0Wt2wmtiq/GgdSfvCGI3blzPvMi
        y1+E6MjQ==;
Received: from [2001:4bb8:19a:27af:ea4c:1aa8:8f64:2866] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKDFb-002aSr-Le; Tue, 24 Jan 2023 06:57:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: [PATCH 07/15] blk-wbt: pass a gendisk to wbt_init
Date:   Tue, 24 Jan 2023 07:57:07 +0100
Message-Id: <20230124065716.152286-8-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230124065716.152286-1-hch@lst.de>
References: <20230124065716.152286-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pass a gendisk to wbt_init to prepare for phasing out usage of the
request_queue in the blk-cgroup code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
---
 block/blk-sysfs.c | 2 +-
 block/blk-wbt.c   | 5 +++--
 block/blk-wbt.h   | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 2074103865f45b..c2adf640e5c816 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -500,7 +500,7 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
 
 	rqos = wbt_rq_qos(q);
 	if (!rqos) {
-		ret = wbt_init(q);
+		ret = wbt_init(q->disk);
 		if (ret)
 			return ret;
 	}
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 8f9302134339c5..542271fa99e8f7 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -671,7 +671,7 @@ void wbt_enable_default(struct gendisk *disk)
 		return;
 
 	if (queue_is_mq(q) && !disable_flag)
-		wbt_init(q);
+		wbt_init(disk);
 }
 EXPORT_SYMBOL_GPL(wbt_enable_default);
 
@@ -835,8 +835,9 @@ static struct rq_qos_ops wbt_rqos_ops = {
 #endif
 };
 
-int wbt_init(struct request_queue *q)
+int wbt_init(struct gendisk *disk)
 {
+	struct request_queue *q = disk->queue;
 	struct rq_wb *rwb;
 	int i;
 	int ret;
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index 7ab1cba55c25f7..b673da41a867d3 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -90,7 +90,7 @@ static inline unsigned int wbt_inflight(struct rq_wb *rwb)
 
 #ifdef CONFIG_BLK_WBT
 
-int wbt_init(struct request_queue *);
+int wbt_init(struct gendisk *disk);
 void wbt_disable_default(struct gendisk *disk);
 void wbt_enable_default(struct gendisk *disk);
 
@@ -104,7 +104,7 @@ u64 wbt_default_latency_nsec(struct request_queue *);
 
 #else
 
-static inline int wbt_init(struct request_queue *q)
+static inline int wbt_init(struct gendisk *disk)
 {
 	return -EINVAL;
 }
-- 
2.39.0

