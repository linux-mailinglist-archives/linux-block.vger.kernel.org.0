Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92B0518DD7B
	for <lists+linux-block@lfdr.de>; Sat, 21 Mar 2020 02:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgCUBiO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 20 Mar 2020 21:38:14 -0400
Received: from mx2.didichuxing.com ([36.110.17.22]:32012 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1726840AbgCUBiO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Mar 2020 21:38:14 -0400
X-ASG-Debug-ID: 1584753674-0e408861fc67ea10001-Cu09wu
Received: from mail.didiglobal.com (localhost [172.20.36.211]) by bsf01.didichuxing.com with ESMTP id Bwbj4G0VwMmULf5Q; Sat, 21 Mar 2020 09:21:14 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 21 Mar
 2020 09:21:14 +0800
Date:   Sat, 21 Mar 2020 09:21:12 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>
Subject: [RFC 2/3] bio: track timestamp of submitting bio the disk driver
Message-ID: <178d7f1408a7d6465840c8d8730dd490cecf96b0.1584728740.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [RFC 2/3] bio: track timestamp of submitting bio the disk driver
Mail-Followup-To: axboe@kernel.dk, tj@kernel.org,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
References: <cover.1584728740.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1584728740.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS04.didichuxing.com (172.20.36.192) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.211]
X-Barracuda-Start-Time: 1584753674
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 3150
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0209
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.80738
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Change-Id: Ibb9caf20616f83e111113ab5c824c05930c0e523
Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 block/blk-mq.c             |  3 +++
 include/linux/blk-cgroup.h |  6 ++++++
 include/linux/blk_types.h  | 29 +++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5b2e6550e0b6..53db008ac8d0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -652,6 +652,7 @@ EXPORT_SYMBOL(blk_mq_complete_request);
 void blk_mq_start_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
+	struct bio *bio;
 
 	trace_block_rq_issue(q, rq);
 
@@ -660,6 +661,8 @@ void blk_mq_start_request(struct request *rq)
 		rq->stats_sectors = blk_rq_sectors(rq);
 		rq->rq_flags |= RQF_STATS;
 		rq_qos_issue(q, rq);
+		__rq_for_each_bio(bio, rq)
+			blkcg_bio_start_init(bio);
 	}
 
 	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index e4a6949fd171..9720f04a9523 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -579,6 +579,11 @@ static inline void blkcg_bio_issue_init(struct bio *bio)
 	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
 }
 
+static inline void blkcg_bio_start_init(struct bio *bio)
+{
+	bio_start_init(&bio->bi_start);
+}
+
 static inline bool blkcg_bio_issue_check(struct request_queue *q,
 					 struct bio *bio)
 {
@@ -738,6 +743,7 @@ static inline void blkg_get(struct blkcg_gq *blkg) { }
 static inline void blkg_put(struct blkcg_gq *blkg) { }
 
 static inline bool blkcg_punt_bio_submit(struct bio *bio) { return false; }
++static inline void blkcg_bio_start_init(struct bio *bio) { }
 static inline void blkcg_bio_issue_init(struct bio *bio) { }
 static inline bool blkcg_bio_issue_check(struct request_queue *q,
 					 struct bio *bio) { return true; }
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 56e41ef3e827..30dc3a73235f 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -109,10 +109,38 @@ static inline bool blk_path_error(blk_status_t error)
 /* Reserved bit for blk-throtl */
 #define BIO_ISSUE_THROTL_SKIP_LATENCY (1ULL << 63)
 
+/* submit bio to block layer */
 struct bio_issue {
 	u64 value;
 };
 
+/*
+ * submit bio to the disk driver layer
+ *
+ * 63:51	reserved
+ * 50:0		bits: start time of bio
+ *
+ * same bitmask as bi_issue
+ */
+struct bio_start {
+	u64 value;
+};
+
+static inline u64 __bio_start_time(u64 time)
+{
+	return time & BIO_ISSUE_TIME_MASK;
+}
+
+static inline u64 bio_start_time(struct bio_start *start)
+{
+	return __bio_start_time(start->value);
+}
+
+static inline void bio_start_init(struct bio_start *start)
+{
+	start->value = ktime_get_ns() & BIO_ISSUE_TIME_MASK;
+}
+
 static inline u64 __bio_issue_time(u64 time)
 {
 	return time & BIO_ISSUE_TIME_MASK;
@@ -178,6 +206,7 @@ struct bio {
 	 */
 	struct blkcg_gq		*bi_blkg;
 	struct bio_issue	bi_issue;
+	struct bio_start	bi_start;
 #ifdef CONFIG_BLK_CGROUP_IOCOST
 	u64			bi_iocost_cost;
 #endif
-- 
2.18.1

