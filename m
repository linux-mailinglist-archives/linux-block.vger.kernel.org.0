Return-Path: <linux-block+bounces-19918-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FBCA93129
	for <lists+linux-block@lfdr.de>; Fri, 18 Apr 2025 06:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0061B61E9C
	for <lists+linux-block@lfdr.de>; Fri, 18 Apr 2025 04:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937ED267F5C;
	Fri, 18 Apr 2025 04:19:30 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF3A253B4E
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 04:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744949970; cv=none; b=a83MO0q8dVAHPcDM3/14mf/GZ/g3pI2t+JpWQ9bGGmxAlEpbuwgsWP+Yu6YZRktWu+FOBe/Jn6fC55mSs95s6MceaNLGvpCXNdH96pyRRVEBq6PdruBaDJdQByVR5eh55pVNJW7AVZzVlHINROUfdilK8ZPsCAvJoczs6QYo7go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744949970; c=relaxed/simple;
	bh=+0FPT4xKuRnZt7U2gw7ooWMX3ekeRHEfCqO5EIdkcqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sl0Fhibhn40xGbJd/ZI0Dtv4eJ9+gQChpnedt4bMyfsnHoSpb40MXzKS7ApHzElCDcX+HXpotKLXhxJUcEFNHxwpkQfFSDM4eD+ET4P7gTtt2wvXvxO0GiwEvXm2O2h4rAPyhGCTXpef1RiETwZjNKmXOMFMts47B3+XqlhcCaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Zf1jd3Lnzz4f3kF9
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 12:19:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3C7681A058E
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 12:19:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgBXul7K0gFoPDtDJw--.14109S9;
	Fri, 18 Apr 2025 12:19:25 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huaweicloud.com,
	ming.lei@redhat.com,
	tj@kernel.org
Subject: [PATCH V3 5/7] blk-throttle: Split the blkthrotl queue
Date: Fri, 18 Apr 2025 12:09:22 +0800
Message-ID: <20250418040924.486324-6-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250418040924.486324-1-wozizhi@huaweicloud.com>
References: <20250418040924.486324-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXul7K0gFoPDtDJw--.14109S9
X-Coremail-Antispam: 1UD129KBjvJXoWxtFy3JryxCF43Ar4xZFy7ZFb_yoWxJFW7pF
	W3GFs8Ja1kJrs2grySqF47CFyfta1xZrZrtr93CrZ0yrW3ZrsrXFn8ZFy8AFWrAFZ3Wa10
	vr1aqr43W3WUJrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAV
	WUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JULtxDUUUUU
	=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

This patch splits the single queue into separate bps and iops queues. Now,
an IO request must first pass through the bps queue, then the iops queue,
and finally be dispatched. Due to the queue splitting, we need to modify
the throtl add/peek/pop function.

Additionally, the patch modifies the logic related to tg_dispatch_time().
If bio needs to wait for bps, function directly returns the bps wait time;
otherwise, it charges bps and returns the iops wait time so that bio can be
directly placed into the iops queue afterward. Note that this may lead to
more frequent updates to disptime, but the overhead is negligible for the
slow path.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 49 ++++++++++++++++++++++++++++++--------------
 block/blk-throttle.h |  3 ++-
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index caae2e3b7534..1cfd226c3b39 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -143,7 +143,8 @@ static inline unsigned int throtl_bio_data_size(struct bio *bio)
 static void throtl_qnode_init(struct throtl_qnode *qn, struct throtl_grp *tg)
 {
 	INIT_LIST_HEAD(&qn->node);
-	bio_list_init(&qn->bios);
+	bio_list_init(&qn->bios_bps);
+	bio_list_init(&qn->bios_iops);
 	qn->tg = tg;
 }
 
@@ -160,7 +161,11 @@ static void throtl_qnode_init(struct throtl_qnode *qn, struct throtl_grp *tg)
 static void throtl_qnode_add_bio(struct bio *bio, struct throtl_qnode *qn,
 				 struct list_head *queued)
 {
-	bio_list_add(&qn->bios, bio);
+	if (bio_flagged(bio, BIO_TG_BPS_THROTTLED))
+		bio_list_add(&qn->bios_iops, bio);
+	else
+		bio_list_add(&qn->bios_bps, bio);
+
 	if (list_empty(&qn->node)) {
 		list_add_tail(&qn->node, queued);
 		blkg_get(tg_to_blkg(qn->tg));
@@ -170,6 +175,10 @@ static void throtl_qnode_add_bio(struct bio *bio, struct throtl_qnode *qn,
 /**
  * throtl_peek_queued - peek the first bio on a qnode list
  * @queued: the qnode list to peek
+ *
+ * Always take a bio from the head of the iops queue first. If the queue
+ * is empty, we then take it from the bps queue to maintain the overall
+ * idea of fetching bios from the head.
  */
 static struct bio *throtl_peek_queued(struct list_head *queued)
 {
@@ -180,7 +189,9 @@ static struct bio *throtl_peek_queued(struct list_head *queued)
 		return NULL;
 
 	qn = list_first_entry(queued, struct throtl_qnode, node);
-	bio = bio_list_peek(&qn->bios);
+	bio = bio_list_peek(&qn->bios_iops);
+	if (!bio)
+		bio = bio_list_peek(&qn->bios_bps);
 	WARN_ON_ONCE(!bio);
 	return bio;
 }
@@ -190,9 +201,10 @@ static struct bio *throtl_peek_queued(struct list_head *queued)
  * @queued: the qnode list to pop a bio from
  * @tg_to_put: optional out argument for throtl_grp to put
  *
- * Pop the first bio from the qnode list @queued.  After popping, the first
- * qnode is removed from @queued if empty or moved to the end of @queued so
- * that the popping order is round-robin.
+ * Pop the first bio from the qnode list @queued. Note that we firstly
+ * focus on the iops list because bios are ultimately dispatched from it.
+ * After popping, the first qnode is removed from @queued if empty or moved to
+ * the end of @queued so that the popping order is round-robin.
  *
  * When the first qnode is removed, its associated throtl_grp should be put
  * too.  If @tg_to_put is NULL, this function automatically puts it;
@@ -209,10 +221,12 @@ static struct bio *throtl_pop_queued(struct list_head *queued,
 		return NULL;
 
 	qn = list_first_entry(queued, struct throtl_qnode, node);
-	bio = bio_list_pop(&qn->bios);
+	bio = bio_list_pop(&qn->bios_iops);
+	if (!bio)
+		bio = bio_list_pop(&qn->bios_bps);
 	WARN_ON_ONCE(!bio);
 
-	if (bio_list_empty(&qn->bios)) {
+	if (bio_list_empty(&qn->bios_bps) && bio_list_empty(&qn->bios_iops)) {
 		list_del_init(&qn->node);
 		if (tg_to_put)
 			*tg_to_put = qn->tg;
@@ -805,12 +819,12 @@ static unsigned long tg_dispatch_iops_time(struct throtl_grp *tg, struct bio *bi
 
 /*
  * Returns approx number of jiffies to wait before this bio is with-in IO rate
- * and can be dispatched.
+ * and can be moved to other queue or dispatched.
  */
 static unsigned long tg_dispatch_time(struct throtl_grp *tg, struct bio *bio)
 {
 	bool rw = bio_data_dir(bio);
-	unsigned long bps_wait, iops_wait;
+	unsigned long wait;
 
 	/*
  	 * Currently whole state machine of group depends on first bio
@@ -821,10 +835,17 @@ static unsigned long tg_dispatch_time(struct throtl_grp *tg, struct bio *bio)
 	BUG_ON(tg->service_queue.nr_queued[rw] &&
 	       bio != throtl_peek_queued(&tg->service_queue.queued[rw]));
 
-	bps_wait = tg_dispatch_bps_time(tg, bio);
-	iops_wait = tg_dispatch_iops_time(tg, bio);
+	wait = tg_dispatch_bps_time(tg, bio);
+	if (wait != 0)
+		return wait;
 
-	return max(bps_wait, iops_wait);
+	/*
+	 * Charge bps here because @bio will be directly placed into the
+	 * iops queue afterward.
+	 */
+	throtl_charge_bps_bio(tg, bio);
+
+	return tg_dispatch_iops_time(tg, bio);
 }
 
 /**
@@ -913,7 +934,6 @@ static void tg_dispatch_one_bio(struct throtl_grp *tg, bool rw)
 	bio = throtl_pop_queued(&sq->queued[rw], &tg_to_put);
 	sq->nr_queued[rw]--;
 
-	throtl_charge_bps_bio(tg, bio);
 	throtl_charge_iops_bio(tg, bio);
 
 	/*
@@ -1641,7 +1661,6 @@ bool __blk_throtl_bio(struct bio *bio)
 	while (true) {
 		if (tg_within_limit(tg, bio, rw)) {
 			/* within limits, let's charge and dispatch directly */
-			throtl_charge_bps_bio(tg, bio);
 			throtl_charge_iops_bio(tg, bio);
 
 			/*
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 7964cc041e06..5257e5c053e6 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -28,7 +28,8 @@
  */
 struct throtl_qnode {
 	struct list_head	node;		/* service_queue->queued[] */
-	struct bio_list		bios;		/* queued bios */
+	struct bio_list		bios_bps;	/* queued bios for bps limit */
+	struct bio_list		bios_iops;	/* queued bios for iops limit */
 	struct throtl_grp	*tg;		/* tg this qnode belongs to */
 };
 
-- 
2.46.1


