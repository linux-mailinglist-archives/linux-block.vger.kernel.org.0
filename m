Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1C43AC03C
	for <lists+linux-block@lfdr.de>; Fri, 18 Jun 2021 02:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhFRAro (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 17 Jun 2021 20:47:44 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:39883 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbhFRArj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 20:47:39 -0400
Received: by mail-pf1-f173.google.com with SMTP id k15so1182252pfp.6
        for <linux-block@vger.kernel.org>; Thu, 17 Jun 2021 17:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IW95tOST+P/99/K7WWyR9Ep4geJbhKEPIWVaMu8O+3w=;
        b=SJFpKpAAXA4Q4zl3alQYwiD1brRRxkJNOn6RPGEDNv66wIhnQY9cZKCo3Nsr8Xb5or
         JcJaG3jec1rt7WqqsYcwFH52sBT3A97anUYMI5kWd9QCDQFBS6/qbtEi2lbuiJ8XKgXb
         g8WWi9lh6pPtADXAOnU8sEhuADa6L1HzdHdXJ1F+G8wTT5K0hd7A2tPNaaCZYLZr7uup
         zu+oW8hNgDZ2XIEp5TiC4GkiMrQQemgTXim5JOCEfrEb/9ZJQbhODFLPZvqd+uExYlun
         H13XogJ5ByLndVjesS5dgbw8h6pQUFD6rRaFBXdxreH3xyQXk8V2r4D6Tq0fluCeMe8Q
         vN1A==
X-Gm-Message-State: AOAM531xvSYJmLtjxB3KF5XVNn7gCLQlIx+l+kkLxPHd3wht4OcywXG4
        iShJnVkN4XouK76l2tDtD8I=
X-Google-Smtp-Source: ABdhPJwCnk7x9WTTrqUHGt823QNHeoQfd0M1+o8iMFMm6z7mA1GXRY2kEYDd7M5ESIKBa5XnLuRokg==
X-Received: by 2002:a65:6a05:: with SMTP id m5mr7239706pgu.319.1623977129958;
        Thu, 17 Jun 2021 17:45:29 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id b10sm6215573pff.14.2021.06.17.17.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 17:45:29 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH v3 16/16] block/mq-deadline: Prioritize high-priority requests
Date:   Thu, 17 Jun 2021 17:44:56 -0700
Message-Id: <20210618004456.7280-17-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618004456.7280-1-bvanassche@acm.org>
References: <20210618004456.7280-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While one or more requests with a certain I/O priority are pending, do not
dispatch lower priority requests. Dispatch lower priority requests anyway
after the "aging" time has expired.

This patch has been tested as follows:

modprobe scsi_debug ndelay=1000000 max_queue=16 &&
sd='' &&
while [ -z "$sd" ]; do
  sd=/dev/$(basename /sys/bus/pseudo/drivers/scsi_debug/adapter*/host*/target*/*/block/*)
done &&
echo $((100*1000)) > /sys/block/$sd/queue/iosched/aging_expire &&
cd /sys/fs/cgroup/blkio/ &&
echo $$ >cgroup.procs &&
echo restrict-to-be >blkio.prio.class &&
mkdir -p hipri &&
cd hipri &&
echo none-to-rt >blkio.prio.class &&
{ max-iops -a1 -d32 -j1 -e mq-deadline $sd >& ~/low-pri.txt & } &&
echo $$ >cgroup.procs &&
max-iops -a1 -d32 -j1 -e mq-deadline $sd >& ~/hi-pri.txt

Result:
* 11000 IOPS for the high-priority job
*    40 IOPS for the low-priority job

If the aging expiry time is changed from 100s into 0, the IOPS results change
into 6712 and 6796 IOPS.

The max-iops script is a script that runs fio with the following arguments:
--bs=4K --gtod_reduce=1 --ioengine=libaio --ioscheduler=${arg_e} --runtime=60
--norandommap --rw=read --thread --buffered=0 --numjobs=${arg_j}
--iodepth=${arg_d} --iodepth_batch_submit=${arg_a}
--iodepth_batch_complete=$((arg_d / 2)) --name=${positional_argument_1}
--filename=${positional_argument_1}

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline-main.c | 42 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/block/mq-deadline-main.c b/block/mq-deadline-main.c
index 58a401ea8f56..4815e536091f 100644
--- a/block/mq-deadline-main.c
+++ b/block/mq-deadline-main.c
@@ -32,6 +32,11 @@
  */
 static const int read_expire = HZ / 2;  /* max time before a read is submitted. */
 static const int write_expire = 5 * HZ; /* ditto for writes, these limits are SOFT! */
+/*
+ * Time after which to dispatch lower priority requests even if higher
+ * priority requests are pending.
+ */
+static const int aging_expire = 10 * HZ;
 static const int writes_starved = 2;    /* max times reads can starve a write */
 static const int fifo_batch = 16;       /* # of sequential requests treated as one
 				     by the above parameters. For throughput. */
@@ -94,6 +99,7 @@ struct deadline_data {
 	int writes_starved;
 	int front_merges;
 	u32 async_depth;
+	int aging_expire;
 
 	spinlock_t lock;
 	spinlock_t zone_lock;
@@ -361,10 +367,11 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 
 /*
  * deadline_dispatch_requests selects the best request according to
- * read/write expire, fifo_batch, etc
+ * read/write expire, fifo_batch, etc and with a start time <= @latest.
  */
 static struct request *__dd_dispatch_request(struct deadline_data *dd,
-					     struct dd_per_prio *per_prio)
+					     struct dd_per_prio *per_prio,
+					     u64 latest_start_ns)
 {
 	struct request *rq, *next_rq;
 	enum dd_data_dir data_dir;
@@ -377,6 +384,8 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	if (!list_empty(&per_prio->dispatch)) {
 		rq = list_first_entry(&per_prio->dispatch, struct request,
 				      queuelist);
+		if (rq->start_time_ns > latest_start_ns)
+			return NULL;
 		list_del_init(&rq->queuelist);
 		goto done;
 	}
@@ -454,6 +463,8 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	dd->batching = 0;
 
 dispatch_request:
+	if (rq->start_time_ns > latest_start_ns)
+		return NULL;
 	/*
 	 * rq is the selected appropriate request.
 	 */
@@ -484,15 +495,32 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 {
 	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
-	struct request *rq;
+	const u64 now_ns = ktime_get_ns();
+	struct request *rq = NULL;
 	enum dd_prio prio;
 
 	spin_lock(&dd->lock);
-	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
-		rq = __dd_dispatch_request(dd, &dd->per_prio[prio]);
+	/*
+	 * Start with dispatching requests whose deadline expired more than
+	 * aging_expire jiffies ago.
+	 */
+	for (prio = DD_BE_PRIO; prio <= DD_PRIO_MAX; prio++) {
+		rq = __dd_dispatch_request(dd, &dd->per_prio[prio], now_ns -
+					   jiffies_to_nsecs(dd->aging_expire));
 		if (rq)
+			goto unlock;
+	}
+	/*
+	 * Next, dispatch requests in priority order. Ignore lower priority
+	 * requests if any higher priority requests are pending.
+	 */
+	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
+		rq = __dd_dispatch_request(dd, &dd->per_prio[prio], now_ns);
+		if (rq || dd_queued(dd, prio))
 			break;
 	}
+
+unlock:
 	spin_unlock(&dd->lock);
 
 	return rq;
@@ -603,6 +631,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	dd->front_merges = 1;
 	dd->last_dir = DD_WRITE;
 	dd->fifo_batch = fifo_batch;
+	dd->aging_expire = aging_expire;
 	spin_lock_init(&dd->lock);
 	spin_lock_init(&dd->zone_lock);
 
@@ -835,6 +864,7 @@ static ssize_t __FUNC(struct elevator_queue *e, char *page)		\
 #define SHOW_JIFFIES(__FUNC, __VAR) SHOW_INT(__FUNC, jiffies_to_msecs(__VAR))
 SHOW_JIFFIES(deadline_read_expire_show, dd->fifo_expire[DD_READ]);
 SHOW_JIFFIES(deadline_write_expire_show, dd->fifo_expire[DD_WRITE]);
+SHOW_JIFFIES(deadline_aging_expire_show, dd->aging_expire);
 SHOW_INT(deadline_writes_starved_show, dd->writes_starved);
 SHOW_INT(deadline_front_merges_show, dd->front_merges);
 SHOW_INT(deadline_async_depth_show, dd->front_merges);
@@ -864,6 +894,7 @@ static ssize_t __FUNC(struct elevator_queue *e, const char *page, size_t count)
 	STORE_FUNCTION(__FUNC, __PTR, MIN, MAX, msecs_to_jiffies)
 STORE_JIFFIES(deadline_read_expire_store, &dd->fifo_expire[DD_READ], 0, INT_MAX);
 STORE_JIFFIES(deadline_write_expire_store, &dd->fifo_expire[DD_WRITE], 0, INT_MAX);
+STORE_JIFFIES(deadline_aging_expire_store, &dd->aging_expire, 0, INT_MAX);
 STORE_INT(deadline_writes_starved_store, &dd->writes_starved, INT_MIN, INT_MAX);
 STORE_INT(deadline_front_merges_store, &dd->front_merges, 0, 1);
 STORE_INT(deadline_async_depth_store, &dd->front_merges, 1, INT_MAX);
@@ -882,6 +913,7 @@ static struct elv_fs_entry deadline_attrs[] = {
 	DD_ATTR(front_merges),
 	DD_ATTR(async_depth),
 	DD_ATTR(fifo_batch),
+	DD_ATTR(aging_expire),
 	__ATTR_NULL
 };
 
