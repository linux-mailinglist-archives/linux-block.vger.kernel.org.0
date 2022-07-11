Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D4755E6E1
	for <lists+linux-block@lfdr.de>; Tue, 28 Jun 2022 18:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346758AbiF1Ogq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Jun 2022 10:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346391AbiF1Ogq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 10:36:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C102A429
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 07:36:45 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LXRvD6XgvzkWkm;
        Tue, 28 Jun 2022 22:34:48 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 22:36:38 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tj@kernel.org>, <jack@suse.cz>, <hch@lst.de>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 1/2] blk-cgroup: factor out blkcg_iostat_update()
Date:   Tue, 28 Jun 2022 22:49:20 +0800
Message-ID: <20220628144921.2190275-2-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220628144921.2190275-1-yanaijie@huawei.com>
References: <20220628144921.2190275-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To reduce some duplicated code, factor out blkcg_iostat_update(). No
functional change.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 block/blk-cgroup.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 764e740b0c0f..60d205ec213e 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -846,6 +846,21 @@ static void blkg_iostat_sub(struct blkg_iostat *dst, struct blkg_iostat *src)
 	}
 }
 
+static inline void blkcg_iostat_update(struct blkcg_gq *blkg,
+	struct blkg_iostat *cur, struct blkg_iostat *last)
+{
+	struct blkg_iostat delta;
+	unsigned long flags;
+
+	/* propagate percpu delta to global */
+	flags = u64_stats_update_begin_irqsave(&blkg->iostat.sync);
+	blkg_iostat_set(&delta, cur);
+	blkg_iostat_sub(&delta, last);
+	blkg_iostat_add(&blkg->iostat.cur, &delta);
+	blkg_iostat_add(last, &delta);
+	u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
+}
+
 static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 {
 	struct blkcg *blkcg = css_to_blkcg(css);
@@ -860,8 +875,7 @@ static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
 		struct blkcg_gq *parent = blkg->parent;
 		struct blkg_iostat_set *bisc = per_cpu_ptr(blkg->iostat_cpu, cpu);
-		struct blkg_iostat cur, delta;
-		unsigned long flags;
+		struct blkg_iostat cur;
 		unsigned int seq;
 
 		/* fetch the current per-cpu values */
@@ -870,23 +884,12 @@ static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 			blkg_iostat_set(&cur, &bisc->cur);
 		} while (u64_stats_fetch_retry(&bisc->sync, seq));
 
-		/* propagate percpu delta to global */
-		flags = u64_stats_update_begin_irqsave(&blkg->iostat.sync);
-		blkg_iostat_set(&delta, &cur);
-		blkg_iostat_sub(&delta, &bisc->last);
-		blkg_iostat_add(&blkg->iostat.cur, &delta);
-		blkg_iostat_add(&bisc->last, &delta);
-		u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
+		blkcg_iostat_update(blkg, &cur, &bisc->last);
 
 		/* propagate global delta to parent (unless that's root) */
-		if (parent && parent->parent) {
-			flags = u64_stats_update_begin_irqsave(&parent->iostat.sync);
-			blkg_iostat_set(&delta, &blkg->iostat.cur);
-			blkg_iostat_sub(&delta, &blkg->iostat.last);
-			blkg_iostat_add(&parent->iostat.cur, &delta);
-			blkg_iostat_add(&blkg->iostat.last, &delta);
-			u64_stats_update_end_irqrestore(&parent->iostat.sync, flags);
-		}
+		if (parent && parent->parent)
+			blkcg_iostat_update(parent, &blkg->iostat.cur,
+					    &blkg->iostat.last);
 	}
 
 	rcu_read_unlock();
-- 
2.31.1

