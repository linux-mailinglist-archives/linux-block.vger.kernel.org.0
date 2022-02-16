Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A4A4B7FAC
	for <lists+linux-block@lfdr.de>; Wed, 16 Feb 2022 05:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344387AbiBPErT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 15 Feb 2022 23:47:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiBPErS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 23:47:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C6E2F4639
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 20:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644986826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O9J6/mmYY+DQGg07c14Y9wN5WFmdh/uIILxRmMFpKww=;
        b=LSkhqbnhfjOjA321HChdW390CDI80XwuDerH/1soMbWH9Qjg9Sk44zjaC+znCxOT9cJhgN
        J9yizzsGS0PBiKm8jsndDsqA69BmXLSPdkCcp01CPS18+Xhy0KrgLeoOG6sQB3/vj3FtPJ
        K4Ml1bZMZ9Fin3Rhdszj1NMafQMPYEg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-102-3AJry-fjP4-aUcCHMNSxTw-1; Tue, 15 Feb 2022 23:47:03 -0500
X-MC-Unique: 3AJry-fjP4-aUcCHMNSxTw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D64A1800D50;
        Wed, 16 Feb 2022 04:47:02 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B89057CD2;
        Wed, 16 Feb 2022 04:46:56 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ning Li <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 8/8] block: revert 4f1e9630afe6 ("blk-throtl: optimize IOPS throttle for large IO scenarios")
Date:   Wed, 16 Feb 2022 12:45:14 +0800
Message-Id: <20220216044514.2903784-9-ming.lei@redhat.com>
In-Reply-To: <20220216044514.2903784-1-ming.lei@redhat.com>
References: <20220216044514.2903784-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Revert commit 4f1e9630afe6 ("blk-throtl: optimize IOPS throttle for large
IO scenarios") since we have another easier way to address this issue and
get better iops throttling result.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-throttle.c | 28 ----------------------------
 block/blk-throttle.h |  5 -----
 2 files changed, 33 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index ec72eced24d2..a3b3ebc72dd4 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -640,8 +640,6 @@ static inline void throtl_start_new_slice_with_credit(struct throtl_grp *tg,
 	tg->bytes_disp[rw] = 0;
 	tg->io_disp[rw] = 0;
 
-	atomic_set(&tg->io_split_cnt[rw], 0);
-
 	/*
 	 * Previous slice has expired. We must have trimmed it after last
 	 * bio dispatch. That means since start of last slice, we never used
@@ -665,8 +663,6 @@ static inline void throtl_start_new_slice(struct throtl_grp *tg, bool rw)
 	tg->slice_start[rw] = jiffies;
 	tg->slice_end[rw] = jiffies + tg->td->throtl_slice;
 
-	atomic_set(&tg->io_split_cnt[rw], 0);
-
 	throtl_log(&tg->service_queue,
 		   "[%c] new slice start=%lu end=%lu jiffies=%lu",
 		   rw == READ ? 'R' : 'W', tg->slice_start[rw],
@@ -900,9 +896,6 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 				jiffies + tg->td->throtl_slice);
 	}
 
-	if (iops_limit != UINT_MAX)
-		tg->io_disp[rw] += atomic_xchg(&tg->io_split_cnt[rw], 0);
-
 	if (tg_with_in_bps_limit(tg, bio, bps_limit, &bps_wait) &&
 	    tg_with_in_iops_limit(tg, bio, iops_limit, &iops_wait)) {
 		if (wait)
@@ -1927,14 +1920,12 @@ static void throtl_downgrade_check(struct throtl_grp *tg)
 	}
 
 	if (tg->iops[READ][LIMIT_LOW]) {
-		tg->last_io_disp[READ] += atomic_xchg(&tg->last_io_split_cnt[READ], 0);
 		iops = tg->last_io_disp[READ] * HZ / elapsed_time;
 		if (iops >= tg->iops[READ][LIMIT_LOW])
 			tg->last_low_overflow_time[READ] = now;
 	}
 
 	if (tg->iops[WRITE][LIMIT_LOW]) {
-		tg->last_io_disp[WRITE] += atomic_xchg(&tg->last_io_split_cnt[WRITE], 0);
 		iops = tg->last_io_disp[WRITE] * HZ / elapsed_time;
 		if (iops >= tg->iops[WRITE][LIMIT_LOW])
 			tg->last_low_overflow_time[WRITE] = now;
@@ -2053,25 +2044,6 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
 }
 #endif
 
-void blk_throtl_charge_bio_split(struct bio *bio)
-{
-	struct blkcg_gq *blkg = bio->bi_blkg;
-	struct throtl_grp *parent = blkg_to_tg(blkg);
-	struct throtl_service_queue *parent_sq;
-	bool rw = bio_data_dir(bio);
-
-	do {
-		if (!parent->has_rules[rw])
-			break;
-
-		atomic_inc(&parent->io_split_cnt[rw]);
-		atomic_inc(&parent->last_io_split_cnt[rw]);
-
-		parent_sq = parent->service_queue.parent_sq;
-		parent = sq_to_tg(parent_sq);
-	} while (parent);
-}
-
 bool __blk_throtl_bio(struct bio *bio)
 {
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index c996a15f290e..b23a9f3abb82 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -138,9 +138,6 @@ struct throtl_grp {
 	unsigned int bad_bio_cnt; /* bios exceeding latency threshold */
 	unsigned long bio_cnt_reset_time;
 
-	atomic_t io_split_cnt[2];
-	atomic_t last_io_split_cnt[2];
-
 	struct blkg_rwstat stat_bytes;
 	struct blkg_rwstat stat_ios;
 };
@@ -164,13 +161,11 @@ static inline struct throtl_grp *blkg_to_tg(struct blkcg_gq *blkg)
 static inline int blk_throtl_init(struct request_queue *q) { return 0; }
 static inline void blk_throtl_exit(struct request_queue *q) { }
 static inline void blk_throtl_register_queue(struct request_queue *q) { }
-static inline void blk_throtl_charge_bio_split(struct bio *bio) { }
 static inline bool blk_throtl_bio(struct bio *bio) { return false; }
 #else /* CONFIG_BLK_DEV_THROTTLING */
 int blk_throtl_init(struct request_queue *q);
 void blk_throtl_exit(struct request_queue *q);
 void blk_throtl_register_queue(struct request_queue *q);
-void blk_throtl_charge_bio_split(struct bio *bio);
 bool __blk_throtl_bio(struct bio *bio);
 static inline bool blk_throtl_bio(struct bio *bio)
 {
-- 
2.31.1

