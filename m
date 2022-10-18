Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CB56029F1
	for <lists+linux-block@lfdr.de>; Tue, 18 Oct 2022 13:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiJRLMx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 18 Oct 2022 07:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiJRLMw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 07:12:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C2BB603B;
        Tue, 18 Oct 2022 04:12:47 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MsB0y442jzmV9L;
        Tue, 18 Oct 2022 19:08:02 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 19:12:44 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH v2 3/3] block: Replace struct rq_depth with unsigned int in struct iolatency_grp
Date:   Tue, 18 Oct 2022 19:12:40 +0800
Message-ID: <20221018111240.22612-4-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221018111240.22612-1-shikemeng@huawei.com>
References: <20221018111240.22612-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We only need a max queue depth for every iolatency to limit the inflight io
number. Replace struct rq_depth with unsigned int to simplfy "struct
iolatency_grp" and save memory.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-iolatency.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 2c574f98c8d1..778a0057193e 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -141,7 +141,7 @@ struct iolatency_grp {
 	struct latency_stat __percpu *stats;
 	struct latency_stat cur_stat;
 	struct blk_iolatency *blkiolat;
-	struct rq_depth rq_depth;
+	unsigned int max_depth;
 	struct rq_wait rq_wait;
 	atomic64_t window_start;
 	atomic_t scale_cookie;
@@ -280,7 +280,7 @@ static void iolat_cleanup_cb(struct rq_wait *rqw, void *private_data)
 static bool iolat_acquire_inflight(struct rq_wait *rqw, void *private_data)
 {
 	struct iolatency_grp *iolat = private_data;
-	return rq_wait_inc_below(rqw, iolat->rq_depth.max_depth);
+	return rq_wait_inc_below(rqw, iolat->max_depth);
 }
 
 static void __blkcg_iolatency_throttle(struct rq_qos *rqos,
@@ -374,7 +374,7 @@ static void scale_change(struct iolatency_grp *iolat, bool up)
 {
 	unsigned long qd = iolat->blkiolat->rqos.q->nr_requests;
 	unsigned long scale = scale_amount(qd, up);
-	unsigned long old = iolat->rq_depth.max_depth;
+	unsigned long old = iolat->max_depth;
 
 	if (old > qd)
 		old = qd;
@@ -386,12 +386,12 @@ static void scale_change(struct iolatency_grp *iolat, bool up)
 		if (old < qd) {
 			old += scale;
 			old = min(old, qd);
-			iolat->rq_depth.max_depth = old;
+			iolat->max_depth = old;
 			wake_up_all(&iolat->rq_wait.wait);
 		}
 	} else {
 		old >>= 1;
-		iolat->rq_depth.max_depth = max(old, 1UL);
+		iolat->max_depth = max(old, 1UL);
 	}
 }
 
@@ -444,7 +444,7 @@ static void check_scale_change(struct iolatency_grp *iolat)
 	}
 
 	/* We're as low as we can go. */
-	if (iolat->rq_depth.max_depth == 1 && direction < 0) {
+	if (iolat->max_depth == 1 && direction < 0) {
 		blkcg_use_delay(lat_to_blkg(iolat));
 		return;
 	}
@@ -452,7 +452,7 @@ static void check_scale_change(struct iolatency_grp *iolat)
 	/* We're back to the default cookie, unthrottle all the things. */
 	if (cur_cookie == DEFAULT_SCALE_COOKIE) {
 		blkcg_clear_delay(lat_to_blkg(iolat));
-		iolat->rq_depth.max_depth = UINT_MAX;
+		iolat->max_depth = UINT_MAX;
 		wake_up_all(&iolat->rq_wait.wait);
 		return;
 	}
@@ -507,7 +507,7 @@ static void iolatency_record_time(struct iolatency_grp *iolat,
 	 * We don't want to count issue_as_root bio's in the cgroups latency
 	 * statistics as it could skew the numbers downwards.
 	 */
-	if (unlikely(issue_as_root && iolat->rq_depth.max_depth != UINT_MAX)) {
+	if (unlikely(issue_as_root && iolat->max_depth != UINT_MAX)) {
 		u64 sub = iolat->min_lat_nsec;
 		if (req_time < sub)
 			blkcg_add_delay(lat_to_blkg(iolat), now, sub - req_time);
@@ -919,7 +919,7 @@ static void iolatency_ssd_stat(struct iolatency_grp *iolat, struct seq_file *s)
 	}
 	preempt_enable();
 
-	if (iolat->rq_depth.max_depth == UINT_MAX)
+	if (iolat->max_depth == UINT_MAX)
 		seq_printf(s, " missed=%llu total=%llu depth=max",
 			(unsigned long long)stat.ps.missed,
 			(unsigned long long)stat.ps.total);
@@ -927,7 +927,7 @@ static void iolatency_ssd_stat(struct iolatency_grp *iolat, struct seq_file *s)
 		seq_printf(s, " missed=%llu total=%llu depth=%u",
 			(unsigned long long)stat.ps.missed,
 			(unsigned long long)stat.ps.total,
-			iolat->rq_depth.max_depth);
+			iolat->max_depth);
 }
 
 static void iolatency_pd_stat(struct blkg_policy_data *pd, struct seq_file *s)
@@ -944,12 +944,12 @@ static void iolatency_pd_stat(struct blkg_policy_data *pd, struct seq_file *s)
 
 	avg_lat = div64_u64(iolat->lat_avg, NSEC_PER_USEC);
 	cur_win = div64_u64(iolat->cur_win_nsec, NSEC_PER_MSEC);
-	if (iolat->rq_depth.max_depth == UINT_MAX)
+	if (iolat->max_depth == UINT_MAX)
 		seq_printf(s, " depth=max avg_lat=%llu win=%llu",
 			avg_lat, cur_win);
 	else
 		seq_printf(s, " depth=%u avg_lat=%llu win=%llu",
-			iolat->rq_depth.max_depth, avg_lat, cur_win);
+			iolat->max_depth, avg_lat, cur_win);
 }
 
 static struct blkg_policy_data *iolatency_pd_alloc(gfp_t gfp,
@@ -993,9 +993,7 @@ static void iolatency_pd_init(struct blkg_policy_data *pd)
 	latency_stat_init(iolat, &iolat->cur_stat);
 	rq_wait_init(&iolat->rq_wait);
 	spin_lock_init(&iolat->child_lat.lock);
-	iolat->rq_depth.queue_depth = blkg->q->nr_requests;
-	iolat->rq_depth.max_depth = UINT_MAX;
-	iolat->rq_depth.default_depth = iolat->rq_depth.queue_depth;
+	iolat->max_depth = UINT_MAX;
 	iolat->blkiolat = blkiolat;
 	iolat->cur_win_nsec = 100 * NSEC_PER_MSEC;
 	atomic64_set(&iolat->window_start, now);
-- 
2.30.0

