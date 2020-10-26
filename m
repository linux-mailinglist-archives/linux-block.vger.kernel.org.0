Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CF2298705
	for <lists+linux-block@lfdr.de>; Mon, 26 Oct 2020 07:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421710AbgJZGl5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 26 Oct 2020 02:41:57 -0400
Received: from mx1.didichuxing.com ([111.202.154.82]:24543 "HELO
        bsf02.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1421682AbgJZGl4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Oct 2020 02:41:56 -0400
X-ASG-Debug-ID: 1603694510-0e41086da21f39e0002-Cu09wu
Received: from mail.didiglobal.com (bogon [172.20.36.203]) by bsf02.didichuxing.com with ESMTP id uozPeK3qMJ6TMsI7; Mon, 26 Oct 2020 14:41:50 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 26 Oct
 2020 14:15:40 +0800
Date:   Mon, 26 Oct 2020 14:15:34 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>, <snitzer@redhat.com>,
        <mpatocka@redhat.com>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH v4 1/2] block: fix inaccurate io_ticks
Message-ID: <20201026061533.GA23974@192.168.3.9>
X-ASG-Orig-Subj: [PATCH v4 1/2] block: fix inaccurate io_ticks
Mail-Followup-To: axboe@kernel.dk, ming.lei@redhat.com, snitzer@redhat.com,
        mpatocka@redhat.com, linux-block@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS03.didichuxing.com (172.20.36.245) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bogon[172.20.36.203]
X-Barracuda-Start-Time: 1603694510
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 6568
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.85498
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Do not add io_ticks if there is no infligh io when start a new IO,
otherwise an extra 1 jiffy will be add to this IO.

I run the following command on a host, with different kernel version.

fio -name=test -ioengine=sync -bs=4K -rw=write
-filename=/home/test.fio.log -size=100M -time_based=1 -direct=1
-runtime=300 -rate=2m,2m

If we run fio in a sync direct io mode, IO will be proccessed one by one,
you can see that there are 512 IOs completed in one second.

kernel: 4.19.0

Device: rrqm/s wrqm/s  r/s    w/s rMB/s wMB/s avgrq-sz avgqu-sz await r_await w_await svctm %util
vda       0.00   0.00 0.00 512.00  0.00  2.00     8.00     0.21  0.40    0.00    0.40  0.40 20.60

The averate io.latency is 0.4ms, so the disk time cost in one second
should be 0.4 * 512 = 204.8 ms, that means, %util should be 20%.

Becase update_io_ticks will add a extra 1 jiffy(1ms) for every IO, the
io.latency will be 1 + 0.4 = 1.4ms, 1.4 * 512 = 716.8ms,
so the %util show it about 72%.

Device  r/s    w/s rMB/s wMB/s rrqm/s wrqm/s %rrqm %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
vda    0.00 512.00  0.00  2.00   0.00   0.00  0.00  0.00    0.00    0.40   0.20     0.00     4.00  1.41  72.10

After this patch:
Device  r/s    w/s rMB/s wMB/s rrqm/s wrqm/s %rrqm %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
vda    0.00 512.00  0.00  2.00   0.00   0.00  0.00  0.00    0.00    0.40   0.20     0.00     4.00  0.39  20.00

Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
Fixes: 2b8bd423614c ("block/diskstats: more accurate approximation of io_ticks for slow disks")
Reported-by: Yabin Li <liyabinliyabin@didiglobal.com>
Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 block/blk-core.c | 19 ++++++++++++++-----
 block/blk-mq.c   | 26 ++++++++++++++++++++++++++
 block/blk-mq.h   |  1 +
 block/blk.h      |  1 +
 block/genhd.c    | 13 +++++++++++++
 5 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ac00d2fa4eb4..9dad92355125 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1256,14 +1256,14 @@ unsigned int blk_rq_err_bytes(const struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_rq_err_bytes);
 
-static void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
+static void update_io_ticks(struct hd_struct *part, unsigned long now, bool inflight)
 {
 	unsigned long stamp;
 again:
 	stamp = READ_ONCE(part->stamp);
 	if (unlikely(stamp != now)) {
-		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp))
-			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
+		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp) && inflight)
+			__part_stat_add(part, io_ticks, now - stamp);
 	}
 	if (part->partno) {
 		part = &part_to_disk(part)->part0;
@@ -1310,13 +1310,20 @@ void blk_account_io_done(struct request *req, u64 now)
 
 void blk_account_io_start(struct request *rq)
 {
+	struct hd_struct *part;
+	struct request_queue *q;
+	bool inflight;
+
 	if (!blk_do_io_stat(rq))
 		return;
 
 	rq->part = disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
 
 	part_stat_lock();
-	update_io_ticks(rq->part, jiffies, false);
+	part = rq->part;
+	q = part_to_disk(part)->queue;
+	inflight = blk_mq_part_is_in_flight(q, part);
+	update_io_ticks(part, jiffies, inflight);
 	part_stat_unlock();
 }
 
@@ -1325,9 +1332,11 @@ static unsigned long __part_start_io_acct(struct hd_struct *part,
 {
 	const int sgrp = op_stat_group(op);
 	unsigned long now = READ_ONCE(jiffies);
+	bool inflight;
 
 	part_stat_lock();
-	update_io_ticks(part, now, false);
+	inflight = part_is_in_flight(part);
+	update_io_ticks(part, now, inflight);
 	part_stat_inc(part, ios[sgrp]);
 	part_stat_add(part, sectors[sgrp], sectors);
 	part_stat_local_inc(part, in_flight[op_is_write(op)]);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 696450257ac1..126a6a6f7035 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -130,6 +130,32 @@ void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 	inflight[1] = mi.inflight[1];
 }
 
+static bool blk_mq_part_check_inflight(struct blk_mq_hw_ctx *hctx,
+				  struct request *rq, void *priv,
+				  bool reserved)
+{
+	struct mq_inflight *mi = priv;
+
+	if (rq->part == mi->part && blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT) {
+		mi->inflight[rq_data_dir(rq)]++;
+		/* return false to break loop early */
+		return false;
+	}
+
+	return true;
+}
+
+bool blk_mq_part_is_in_flight(struct request_queue *q, struct hd_struct *part)
+{
+	struct mq_inflight mi = { .part = part };
+
+	mi.inflight[0] = mi.inflight[1] = 0;
+
+	blk_mq_queue_tag_busy_iter(q, blk_mq_part_check_inflight, &mi);
+
+	return mi.inflight[0] + mi.inflight[1] > 0;
+}
+
 void blk_freeze_queue_start(struct request_queue *q)
 {
 	mutex_lock(&q->mq_freeze_lock);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index a52703c98b77..bb7e22d746e1 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -76,6 +76,7 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last);
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 				    struct list_head *list);
+bool blk_mq_part_is_in_flight(struct request_queue *q, struct hd_struct *part);
 
 /*
  * CPU -> queue mappings
diff --git a/block/blk.h b/block/blk.h
index dfab98465db9..2572b7aadcbb 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -443,5 +443,6 @@ static inline void part_nr_sects_write(struct hd_struct *part, sector_t size)
 int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		unsigned int max_sectors, bool *same_page);
+bool part_is_in_flight(struct hd_struct *part);
 
 #endif /* BLK_INTERNAL_H */
diff --git a/block/genhd.c b/block/genhd.c
index 0a273211fec2..4a089bed9dcb 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -109,6 +109,19 @@ static void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat)
 	}
 }
 
+bool part_is_in_flight(struct hd_struct *part)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		if (part_stat_local_read_cpu(part, in_flight[0], cpu) ||
+			    part_stat_local_read_cpu(part, in_flight[1], cpu))
+			return true;
+	}
+
+	return false;
+}
+
 static unsigned int part_in_flight(struct hd_struct *part)
 {
 	unsigned int inflight = 0;
-- 
2.18.4

