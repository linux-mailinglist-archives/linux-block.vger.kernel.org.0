Return-Path: <linux-block+bounces-2201-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0263083967C
	for <lists+linux-block@lfdr.de>; Tue, 23 Jan 2024 18:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A829C28F349
	for <lists+linux-block@lfdr.de>; Tue, 23 Jan 2024 17:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F80380045;
	Tue, 23 Jan 2024 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yFa7ajAd"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB36811E4
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031201; cv=none; b=Rh2B13L4Ge0ZPuqb5WHY9YY0jcRNiK+i0Bc7mpIeGgkatbYH1xZrKGldn4fp0al7gyUauYXaTWCbojl0MpYgCP1H40pykIxC3E45/OTPZHC6NerQN5FoT7tfOKpd7EcrIZvf/hjWcY+NyD07yzJG+W/TuY+JX7nztKqLDDNP4cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031201; c=relaxed/simple;
	bh=mt/csPSlwKvDneruuiEWWkV4pXV+fbUbPTLIXXRuAg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIxuEc/q4B6UJlZQ5BYhILbAS7LnRa04Me1Y2dcZKrCC1m+0BXKWlEPRdF9SS32r3t0vH0H+iQpfS/AjDxehmIesi/CpJBg8yic1w/N2tjU1FLcJD7yFVCiXk2dvc8Tj1fzCh4lVUg2uds3S6HrvVlM6F1M87eR0mLpzXHl5j8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yFa7ajAd; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso60897139f.0
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 09:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706031198; x=1706635998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPpFX+3PRbo71Vw707Mebi2sbecSvziHGvYdR5TY9cI=;
        b=yFa7ajAdGLjn/c3Y6gSXwlRyQfjr9drjrBnp9ZHApW2X6XQSeQPyr4lRe8IXWPcGZ6
         D3HiirzhOyQeWpSAknXw9jmpJyGOQj727HK1zBS5QqLBX9BzfSn7JAgXAiJ0V3wVJtD8
         xXCsETgs2Lku1rlk3wmlIuqDmmKeiWduFRbqk1Pi1nj34jNdsSV0TOC77CTE3T5wkiSk
         fnkOm+6OKtvxHWYkS0tr6AnGwpuBmghsbwu/zuQ9p7m5dqqkzSdJZv1f5OYVwxP/sikr
         AI8YXo2r7CTr4IVfSuCSEQOXXNUCYjAJsSAkJRHtPWwCeRCDcL8fqzitYBMmMBEvpvU6
         XvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031198; x=1706635998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPpFX+3PRbo71Vw707Mebi2sbecSvziHGvYdR5TY9cI=;
        b=NLqfxzdUvN1kZ0pbpJjIDgXQnmYkvkvoByle+O+alq6hkvtZl3862VoWXrMJKL7IQy
         1fe2+uC0iY+TyvAuViM/ePt5rZA0mkgoDnsf28X2VUGss9DmIAdaYcOKvE5yidPWWpDB
         /CYxXbkhLtrA03mlbTPj7FNQPpOXP/VDGq22M7vUH3Z7Y1rPcMg+lZ6WQ5OMrgGDrPam
         q7Zq5KPlXbVVP0sZ3foAXN35rxA8FdNV9jHBG1H4fik6h6DdQkre0DNkljIAbTrC61mm
         JeRdTyQnQPfmQXbMvRVzG9RSKUcB6DjhWcISlHltajwQPnNaWfki8nVL9ljY4RfKtNCO
         yh3g==
X-Gm-Message-State: AOJu0Yz3GUibAR+NKTdFRD9SAKfTSE8sKq45yeIecBwJ1smU/v4F+uAu
	U4GLABS7ieNPY14FALimSKgbYzpQi1PG/stc04Xs/wEMW5b+Fd7NM5bsuRzbxMyekr+amCUudPy
	E/YM=
X-Google-Smtp-Source: AGHT+IGZagkVOKMV+EmvD+aE6B6Vg2MA/HyEhaQG2yWOkViL+2pCMWpg4GKtU2YpaVcbdbSs8K7VZA==
X-Received: by 2002:a5d:9304:0:b0:7be:e376:fc44 with SMTP id l4-20020a5d9304000000b007bee376fc44mr9545075ion.2.1706031197658;
        Tue, 23 Jan 2024 09:33:17 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gu12-20020a0566382e0c00b0046df4450843sm3640708jab.50.2024.01.23.09.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:33:15 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/6] block: add blk_time_get_ns() and blk_time_get() helpers
Date: Tue, 23 Jan 2024 10:30:34 -0700
Message-ID: <20240123173310.1966157-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123173310.1966157-1-axboe@kernel.dk>
References: <20240123173310.1966157-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert any user of ktime_get_ns() to use blk_time_get_ns(), and
ktime_get() to blk_time_get(), so we have a unified API for querying the
current time in nanoseconds or as ktime.

No functional changes intended, this patch just wraps ktime_get_ns()
and ktime_get() with a block helper.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bfq-cgroup.c     | 14 +++++++-------
 block/bfq-iosched.c    | 28 ++++++++++++++--------------
 block/blk-cgroup.c     |  2 +-
 block/blk-flush.c      |  2 +-
 block/blk-iocost.c     |  8 ++++----
 block/blk-iolatency.c  |  6 +++---
 block/blk-mq.c         | 16 ++++++++--------
 block/blk-throttle.c   |  6 +++---
 block/blk-wbt.c        |  5 ++---
 include/linux/blkdev.h | 13 ++++++++++++-
 10 files changed, 55 insertions(+), 45 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 2c90e5de0acd..d442ee358fc2 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -127,7 +127,7 @@ static void bfqg_stats_update_group_wait_time(struct bfqg_stats *stats)
 	if (!bfqg_stats_waiting(stats))
 		return;
 
-	now = ktime_get_ns();
+	now = blk_time_get_ns();
 	if (now > stats->start_group_wait_time)
 		bfq_stat_add(&stats->group_wait_time,
 			      now - stats->start_group_wait_time);
@@ -144,7 +144,7 @@ static void bfqg_stats_set_start_group_wait_time(struct bfq_group *bfqg,
 		return;
 	if (bfqg == curr_bfqg)
 		return;
-	stats->start_group_wait_time = ktime_get_ns();
+	stats->start_group_wait_time = blk_time_get_ns();
 	bfqg_stats_mark_waiting(stats);
 }
 
@@ -156,7 +156,7 @@ static void bfqg_stats_end_empty_time(struct bfqg_stats *stats)
 	if (!bfqg_stats_empty(stats))
 		return;
 
-	now = ktime_get_ns();
+	now = blk_time_get_ns();
 	if (now > stats->start_empty_time)
 		bfq_stat_add(&stats->empty_time,
 			      now - stats->start_empty_time);
@@ -183,7 +183,7 @@ void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg)
 	if (bfqg_stats_empty(stats))
 		return;
 
-	stats->start_empty_time = ktime_get_ns();
+	stats->start_empty_time = blk_time_get_ns();
 	bfqg_stats_mark_empty(stats);
 }
 
@@ -192,7 +192,7 @@ void bfqg_stats_update_idle_time(struct bfq_group *bfqg)
 	struct bfqg_stats *stats = &bfqg->stats;
 
 	if (bfqg_stats_idling(stats)) {
-		u64 now = ktime_get_ns();
+		u64 now = blk_time_get_ns();
 
 		if (now > stats->start_idle_time)
 			bfq_stat_add(&stats->idle_time,
@@ -205,7 +205,7 @@ void bfqg_stats_set_start_idle_time(struct bfq_group *bfqg)
 {
 	struct bfqg_stats *stats = &bfqg->stats;
 
-	stats->start_idle_time = ktime_get_ns();
+	stats->start_idle_time = blk_time_get_ns();
 	bfqg_stats_mark_idling(stats);
 }
 
@@ -242,7 +242,7 @@ void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
 				  u64 io_start_time_ns, blk_opf_t opf)
 {
 	struct bfqg_stats *stats = &bfqg->stats;
-	u64 now = ktime_get_ns();
+	u64 now = blk_time_get_ns();
 
 	if (now > io_start_time_ns)
 		blkg_rwstat_add(&stats->service_time, opf,
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 3cce6de464a7..4b88a54a9b76 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1005,7 +1005,7 @@ static struct request *bfq_check_fifo(struct bfq_queue *bfqq,
 
 	rq = rq_entry_fifo(bfqq->fifo.next);
 
-	if (rq == last || ktime_get_ns() < rq->fifo_time)
+	if (rq == last || blk_time_get_ns() < rq->fifo_time)
 		return NULL;
 
 	bfq_log_bfqq(bfqq->bfqd, bfqq, "check_fifo: returned %p", rq);
@@ -1829,7 +1829,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 		 * bfq_bfqq_update_budg_for_activation for
 		 * details on the usage of the next variable.
 		 */
-		arrived_in_time =  ktime_get_ns() <=
+		arrived_in_time =  blk_time_get_ns() <=
 			bfqq->ttime.last_end_request +
 			bfqd->bfq_slice_idle * 3;
 	unsigned int act_idx = bfq_actuator_index(bfqd, rq->bio);
@@ -2208,7 +2208,7 @@ static void bfq_add_request(struct request *rq)
 	struct request *next_rq, *prev;
 	unsigned int old_wr_coeff = bfqq->wr_coeff;
 	bool interactive = false;
-	u64 now_ns = ktime_get_ns();
+	u64 now_ns = blk_time_get_ns();
 
 	bfq_log_bfqq(bfqd, bfqq, "add_request %d", rq_is_sync(rq));
 	bfqq->queued[rq_is_sync(rq)]++;
@@ -2262,7 +2262,7 @@ static void bfq_add_request(struct request *rq)
 		      bfqd->rqs_injected && bfqd->tot_rq_in_driver > 0)) &&
 		    time_is_before_eq_jiffies(bfqq->decrease_time_jif +
 					      msecs_to_jiffies(10))) {
-			bfqd->last_empty_occupied_ns = ktime_get_ns();
+			bfqd->last_empty_occupied_ns = blk_time_get_ns();
 			/*
 			 * Start the state machine for measuring the
 			 * total service time of rq: setting
@@ -3294,7 +3294,7 @@ static void bfq_set_budget_timeout(struct bfq_data *bfqd,
 	else
 		timeout_coeff = bfqq->entity.weight / bfqq->entity.orig_weight;
 
-	bfqd->last_budget_start = ktime_get();
+	bfqd->last_budget_start = blk_time_get();
 
 	bfqq->budget_timeout = jiffies +
 		bfqd->bfq_timeout * timeout_coeff;
@@ -3394,7 +3394,7 @@ static void bfq_arm_slice_timer(struct bfq_data *bfqd)
 	else if (bfqq->wr_coeff > 1)
 		sl = max_t(u32, sl, 20ULL * NSEC_PER_MSEC);
 
-	bfqd->last_idling_start = ktime_get();
+	bfqd->last_idling_start = blk_time_get();
 	bfqd->last_idling_start_jiffies = jiffies;
 
 	hrtimer_start(&bfqd->idle_slice_timer, ns_to_ktime(sl),
@@ -3433,7 +3433,7 @@ static void bfq_reset_rate_computation(struct bfq_data *bfqd,
 				       struct request *rq)
 {
 	if (rq != NULL) { /* new rq dispatch now, reset accordingly */
-		bfqd->last_dispatch = bfqd->first_dispatch = ktime_get_ns();
+		bfqd->last_dispatch = bfqd->first_dispatch = blk_time_get_ns();
 		bfqd->peak_rate_samples = 1;
 		bfqd->sequential_samples = 0;
 		bfqd->tot_sectors_dispatched = bfqd->last_rq_max_size =
@@ -3590,7 +3590,7 @@ static void bfq_update_rate_reset(struct bfq_data *bfqd, struct request *rq)
  */
 static void bfq_update_peak_rate(struct bfq_data *bfqd, struct request *rq)
 {
-	u64 now_ns = ktime_get_ns();
+	u64 now_ns = blk_time_get_ns();
 
 	if (bfqd->peak_rate_samples == 0) { /* first dispatch */
 		bfq_log(bfqd, "update_peak_rate: goto reset, samples %d",
@@ -4162,7 +4162,7 @@ static bool bfq_bfqq_is_slow(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	if (compensate)
 		delta_ktime = bfqd->last_idling_start;
 	else
-		delta_ktime = ktime_get();
+		delta_ktime = blk_time_get();
 	delta_ktime = ktime_sub(delta_ktime, bfqd->last_budget_start);
 	delta_usecs = ktime_to_us(delta_ktime);
 
@@ -5591,7 +5591,7 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 			  struct bfq_io_cq *bic, pid_t pid, int is_sync,
 			  unsigned int act_idx)
 {
-	u64 now_ns = ktime_get_ns();
+	u64 now_ns = blk_time_get_ns();
 
 	bfqq->actuator_idx = act_idx;
 	RB_CLEAR_NODE(&bfqq->entity.rb_node);
@@ -5903,7 +5903,7 @@ static void bfq_update_io_thinktime(struct bfq_data *bfqd,
 	 */
 	if (bfqq->dispatched || bfq_bfqq_busy(bfqq))
 		return;
-	elapsed = ktime_get_ns() - bfqq->ttime.last_end_request;
+	elapsed = blk_time_get_ns() - bfqq->ttime.last_end_request;
 	elapsed = min_t(u64, elapsed, 2ULL * bfqd->bfq_slice_idle);
 
 	ttime->ttime_samples = (7*ttime->ttime_samples + 256) / 8;
@@ -6194,7 +6194,7 @@ static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
 	bfq_add_request(rq);
 	idle_timer_disabled = waiting && !bfq_bfqq_wait_request(bfqq);
 
-	rq->fifo_time = ktime_get_ns() + bfqd->bfq_fifo_expire[rq_is_sync(rq)];
+	rq->fifo_time = blk_time_get_ns() + bfqd->bfq_fifo_expire[rq_is_sync(rq)];
 	list_add_tail(&rq->queuelist, &bfqq->fifo);
 
 	bfq_rq_enqueued(bfqd, bfqq, rq);
@@ -6370,7 +6370,7 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 		bfq_weights_tree_remove(bfqq);
 	}
 
-	now_ns = ktime_get_ns();
+	now_ns = blk_time_get_ns();
 
 	bfqq->ttime.last_end_request = now_ns;
 
@@ -6585,7 +6585,7 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 static void bfq_update_inject_limit(struct bfq_data *bfqd,
 				    struct bfq_queue *bfqq)
 {
-	u64 tot_time_ns = ktime_get_ns() - bfqd->last_empty_occupied_ns;
+	u64 tot_time_ns = blk_time_get_ns() - bfqd->last_empty_occupied_ns;
 	unsigned int old_limit = bfqq->inject_limit;
 
 	if (bfqq->last_serv_time_ns > 0 && bfqd->rqs_injected) {
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index ff93c385ba5a..bdbb557feb5a 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1846,7 +1846,7 @@ static void blkcg_maybe_throttle_blkg(struct blkcg_gq *blkg, bool use_memdelay)
 {
 	unsigned long pflags;
 	bool clamp;
-	u64 now = ktime_to_ns(ktime_get());
+	u64 now = blk_time_get_ns();
 	u64 exp;
 	u64 delay_nsec = 0;
 	int tok;
diff --git a/block/blk-flush.c b/block/blk-flush.c
index 3f4d41952ef2..b0f314f4bc14 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -143,7 +143,7 @@ static void blk_account_io_flush(struct request *rq)
 	part_stat_lock();
 	part_stat_inc(part, ios[STAT_FLUSH]);
 	part_stat_add(part, nsecs[STAT_FLUSH],
-		      ktime_get_ns() - rq->start_time_ns);
+		      blk_time_get_ns() - rq->start_time_ns);
 	part_stat_unlock();
 }
 
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index c8beec6d7df0..4b0b483a9693 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -829,7 +829,7 @@ static int ioc_autop_idx(struct ioc *ioc, struct gendisk *disk)
 
 	/* step up/down based on the vrate */
 	vrate_pct = div64_u64(ioc->vtime_base_rate * 100, VTIME_PER_USEC);
-	now_ns = ktime_get_ns();
+	now_ns = blk_time_get_ns();
 
 	if (p->too_fast_vrate_pct && p->too_fast_vrate_pct <= vrate_pct) {
 		if (!ioc->autop_too_fast_at)
@@ -1044,7 +1044,7 @@ static void ioc_now(struct ioc *ioc, struct ioc_now *now)
 	unsigned seq;
 	u64 vrate;
 
-	now->now_ns = ktime_get();
+	now->now_ns = blk_time_get_ns();
 	now->now = ktime_to_us(now->now_ns);
 	vrate = atomic64_read(&ioc->vtime_rate);
 
@@ -2810,7 +2810,7 @@ static void ioc_rqos_done(struct rq_qos *rqos, struct request *rq)
 		return;
 	}
 
-	on_q_ns = ktime_get_ns() - rq->alloc_time_ns;
+	on_q_ns = blk_time_get_ns() - rq->alloc_time_ns;
 	rq_wait_ns = rq->start_time_ns - rq->alloc_time_ns;
 	size_nsec = div64_u64(calc_size_vtime_cost(rq, ioc), VTIME_PER_NSEC);
 
@@ -2893,7 +2893,7 @@ static int blk_iocost_init(struct gendisk *disk)
 	ioc->vtime_base_rate = VTIME_PER_USEC;
 	atomic64_set(&ioc->vtime_rate, VTIME_PER_USEC);
 	seqcount_spinlock_init(&ioc->period_seqcount, &ioc->lock);
-	ioc->period_at = ktime_to_us(ktime_get());
+	ioc->period_at = ktime_to_us(blk_time_get());
 	atomic64_set(&ioc->cur_period, 0);
 	atomic_set(&ioc->hweight_gen, 0);
 
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index c1a6aba1d59e..ebb522788d97 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -609,7 +609,7 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
 	if (!iolat->blkiolat->enabled)
 		return;
 
-	now = ktime_to_ns(ktime_get());
+	now = blk_time_get_ns();
 	while (blkg && blkg->parent) {
 		iolat = blkg_to_lat(blkg);
 		if (!iolat) {
@@ -661,7 +661,7 @@ static void blkiolatency_timer_fn(struct timer_list *t)
 	struct blk_iolatency *blkiolat = from_timer(blkiolat, t, timer);
 	struct blkcg_gq *blkg;
 	struct cgroup_subsys_state *pos_css;
-	u64 now = ktime_to_ns(ktime_get());
+	u64 now = blk_time_get_ns();
 
 	rcu_read_lock();
 	blkg_for_each_descendant_pre(blkg, pos_css,
@@ -985,7 +985,7 @@ static void iolatency_pd_init(struct blkg_policy_data *pd)
 	struct blkcg_gq *blkg = lat_to_blkg(iolat);
 	struct rq_qos *rqos = iolat_rq_qos(blkg->q);
 	struct blk_iolatency *blkiolat = BLKIOLATENCY(rqos);
-	u64 now = ktime_to_ns(ktime_get());
+	u64 now = blk_time_get_ns();
 	int cpu;
 
 	if (blk_queue_nonrot(blkg->q))
diff --git a/block/blk-mq.c b/block/blk-mq.c
index aa87fcfda1ec..aff9e9492f59 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -323,7 +323,7 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	RB_CLEAR_NODE(&rq->rb_node);
 	rq->tag = BLK_MQ_NO_TAG;
 	rq->internal_tag = BLK_MQ_NO_TAG;
-	rq->start_time_ns = ktime_get_ns();
+	rq->start_time_ns = blk_time_get_ns();
 	rq->part = NULL;
 	blk_crypto_rq_set_defaults(rq);
 }
@@ -333,7 +333,7 @@ EXPORT_SYMBOL(blk_rq_init);
 static inline void blk_mq_rq_time_init(struct request *rq, u64 alloc_time_ns)
 {
 	if (blk_mq_need_time_stamp(rq))
-		rq->start_time_ns = ktime_get_ns();
+		rq->start_time_ns = blk_time_get_ns();
 	else
 		rq->start_time_ns = 0;
 
@@ -444,7 +444,7 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 
 	/* alloc_time includes depth and tag waits */
 	if (blk_queue_rq_alloc_time(q))
-		alloc_time_ns = ktime_get_ns();
+		alloc_time_ns = blk_time_get_ns();
 
 	if (data->cmd_flags & REQ_NOWAIT)
 		data->flags |= BLK_MQ_REQ_NOWAIT;
@@ -629,7 +629,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 
 	/* alloc_time includes depth and tag waits */
 	if (blk_queue_rq_alloc_time(q))
-		alloc_time_ns = ktime_get_ns();
+		alloc_time_ns = blk_time_get_ns();
 
 	/*
 	 * If the tag allocator sleeps we could get an allocation for a
@@ -1042,7 +1042,7 @@ static inline void __blk_mq_end_request_acct(struct request *rq, u64 now)
 inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 {
 	if (blk_mq_need_time_stamp(rq))
-		__blk_mq_end_request_acct(rq, ktime_get_ns());
+		__blk_mq_end_request_acct(rq, blk_time_get_ns());
 
 	blk_mq_finish_request(rq);
 
@@ -1085,7 +1085,7 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
 	u64 now = 0;
 
 	if (iob->need_ts)
-		now = ktime_get_ns();
+		now = blk_time_get_ns();
 
 	while ((rq = rq_list_pop(&iob->req_list)) != NULL) {
 		prefetch(rq->bio);
@@ -1255,7 +1255,7 @@ void blk_mq_start_request(struct request *rq)
 
 	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags) &&
 	    !blk_rq_is_passthrough(rq)) {
-		rq->io_start_time_ns = ktime_get_ns();
+		rq->io_start_time_ns = blk_time_get_ns();
 		rq->stats_sectors = blk_rq_sectors(rq);
 		rq->rq_flags |= RQF_STATS;
 		rq_qos_issue(q, rq);
@@ -3107,7 +3107,7 @@ blk_status_t blk_insert_cloned_request(struct request *rq)
 	blk_mq_run_dispatch_ops(q,
 			ret = blk_mq_request_issue_directly(rq, true));
 	if (ret)
-		blk_account_io_done(rq, ktime_get_ns());
+		blk_account_io_done(rq, blk_time_get_ns());
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_insert_cloned_request);
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 16f5766620a4..da9dc1f793c3 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1815,7 +1815,7 @@ static bool throtl_tg_is_idle(struct throtl_grp *tg)
 	time = min_t(unsigned long, MAX_IDLE_TIME, 4 * tg->idletime_threshold);
 	ret = tg->latency_target == DFL_LATENCY_TARGET ||
 	      tg->idletime_threshold == DFL_IDLE_THRESHOLD ||
-	      (ktime_get_ns() >> 10) - tg->last_finish_time > time ||
+	      (blk_time_get_ns() >> 10) - tg->last_finish_time > time ||
 	      tg->avg_idletime > tg->idletime_threshold ||
 	      (tg->latency_target && tg->bio_cnt &&
 		tg->bad_bio_cnt * 5 < tg->bio_cnt);
@@ -2060,7 +2060,7 @@ static void blk_throtl_update_idletime(struct throtl_grp *tg)
 	if (last_finish_time == 0)
 		return;
 
-	now = ktime_get_ns() >> 10;
+	now = blk_time_get_ns() >> 10;
 	if (now <= last_finish_time ||
 	    last_finish_time == tg->checked_last_finish_time)
 		return;
@@ -2327,7 +2327,7 @@ void blk_throtl_bio_endio(struct bio *bio)
 	if (!tg->td->limit_valid[LIMIT_LOW])
 		return;
 
-	finish_time_ns = ktime_get_ns();
+	finish_time_ns = blk_time_get_ns();
 	tg->last_finish_time = finish_time_ns >> 10;
 
 	start_time = bio_issue_time(&bio->bi_issue) >> 10;
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 5ba3cd574eac..4c1c04345040 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -274,13 +274,12 @@ static inline bool stat_sample_valid(struct blk_rq_stat *stat)
 
 static u64 rwb_sync_issue_lat(struct rq_wb *rwb)
 {
-	u64 now, issue = READ_ONCE(rwb->sync_issue);
+	u64 issue = READ_ONCE(rwb->sync_issue);
 
 	if (!issue || !rwb->sync_cookie)
 		return 0;
 
-	now = ktime_to_ns(ktime_get());
-	return now - issue;
+	return blk_time_get_ns() - issue;
 }
 
 static inline unsigned int wbt_inflight(struct rq_wb *rwb)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index da0f7e1caa5a..40d3d7da39a4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -24,6 +24,7 @@
 #include <linux/sbitmap.h>
 #include <linux/uuid.h>
 #include <linux/xarray.h>
+#include <linux/timekeeping.h>
 
 struct module;
 struct request_queue;
@@ -975,6 +976,16 @@ static inline void blk_flush_plug(struct blk_plug *plug, bool async)
 int blkdev_issue_flush(struct block_device *bdev);
 long nr_blockdev_pages(void);
 
+static inline u64 blk_time_get_ns(void)
+{
+	return ktime_get_ns();
+}
+
+static inline ktime_t blk_time_get(void)
+{
+	return ns_to_ktime(blk_time_get_ns());
+}
+
 /*
  * From most significant bit:
  * 1 bit: reserved for other usage, see below
@@ -1013,7 +1024,7 @@ static inline void bio_issue_init(struct bio_issue *issue,
 {
 	size &= (1ULL << BIO_ISSUE_SIZE_BITS) - 1;
 	issue->value = ((issue->value & BIO_ISSUE_RES_MASK) |
-			(ktime_get_ns() & BIO_ISSUE_TIME_MASK) |
+			(blk_time_get_ns() & BIO_ISSUE_TIME_MASK) |
 			((u64)size << BIO_ISSUE_SIZE_SHIFT));
 }
 
-- 
2.43.0


