Return-Path: <linux-block+bounces-29143-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1EAC19D87
	for <lists+linux-block@lfdr.de>; Wed, 29 Oct 2025 11:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E26F1C20008
	for <lists+linux-block@lfdr.de>; Wed, 29 Oct 2025 10:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202442F6937;
	Wed, 29 Oct 2025 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fmx92yO+"
X-Original-To: linux-block@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAF330FF29
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734210; cv=none; b=C1CYuiz2+dAxlucbwLqOcyrYgF1l5/M2R1pdnsNZethm6I2mIHqrHuhOpPAx2KeteG1LrsNPZBi8tjf9M5LxCqidiyNhTLs4qBNfEGr1oq/O4ZlYbcoY/SliDJrMRp3szywliwNw5qlMQ9wc6swzcr6VFmu3sd9JVWYGfgzVV1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734210; c=relaxed/simple;
	bh=Hk84QNXDW8H1OTtXnlw2suLvgM4kWulUicYlqBTFkjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LgblccseKPXBod8BrOeFKeuPM2ydnZMBPJVjfX/jwt1Vcp3BHh3IxhoRwOd+lweFezSQViaoVZgfPduuBRw4TtCeIko1azrz856MZnpXfMmDtli6+cee3t9LFV5zlUtrzLyBUb6HGflUSDxvXiW79J2AiNZGLJgwwRubzz9lkVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fmx92yO+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SJmlEB031550;
	Wed, 29 Oct 2025 10:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YMyRoG
	kUhwKBGLk/1QFPXvvSGnBJCtdw6GRFPWq74u8=; b=Fmx92yO+rDgfVWvppRvWOi
	Wn0d1GfvaZ4bBieJfyBaEUjXQV12wQ9nYB7WE5nNb+/6lVo+R3/2kVXW56sWCEIU
	xfZgP3lKQztK6E7eMCb7O/VjbWa5FnRK4iZ0rUj5ltiTxJJrG9aC9MY5vKluDsQT
	th0VbG5tInejnY4FBiCH9ilPUjmXgCtKxvX4u84VRTUpOCzlBpRalTlYIwgeTMIK
	YpRqGEfCx7U5ewnbGXA93TrCCbLvFBQWk8lXZNXes1tPD9KLjCinjFNuwl/+31dE
	LD0UwInNxJ+0vQm1lMYCaOc5rlR0oqFk79QkW8OGFnBgc7ayYkUVyNabCb0hBl1g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34ajjkgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 10:36:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59T9atZQ023839;
	Wed, 29 Oct 2025 10:36:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33vx2vmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 10:36:41 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59TAacIp52298020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 10:36:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E382220043;
	Wed, 29 Oct 2025 10:36:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3C0C2004B;
	Wed, 29 Oct 2025 10:36:33 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.159.127])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Oct 2025 10:36:33 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, yi.zhang@redhat.com,
        czhong@redhat.com, gjoyce@ibm.com
Subject: [PATCHv3 1/4] block: unify elevator tags and type xarrays into struct elv_change_ctx
Date: Wed, 29 Oct 2025 16:06:14 +0530
Message-ID: <20251029103622.205607-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029103622.205607-1-nilay@linux.ibm.com>
References: <20251029103622.205607-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/XkCAP+ c=1 sm=1 tr=0 ts=6901ee39 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=IDgHv7Sgf56jAkHkfqAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: gCbYuWom8JwW0bp_OxDpYdfE1W18tXkh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfXw4ohT+YWEYNh
 WzIkgjc11NqPwTfpsJjwxHcOXeWTcYrb5Gahe3pX+cMSMlTRPPJWL9sowo7ak2fLpNEpVV/MOvE
 2oNj/wspB4XA0HHrH8uwLLzNy4W3R54QVeUDvdytAVuWkVaz9LSbFesO4d1ytAlbkoGqkQTukmS
 L+u522zzWlfcNI/N8MinHG7O8jFNWGee+JYhXCldxG5zcDO2YKtvn47ZmqOvRkNtwzJXGLBVCSP
 7Ut5BvuVXV1R4XolshMlU/XIl6gxRML/c282KNZ6wscqskDvDfOU0/NIV1vYE25tYO3DQaCtitE
 eFRP+aQfOrXBHi1SRNgXdFyhtI8kx8ycnj2DQvJdZFVN2qdgCDNexbd80BN+ElW32cEuoLrydXH
 kCEKByt2NIRGB178sg3EJ2fEv/ikCw==
X-Proofpoint-ORIG-GUID: gCbYuWom8JwW0bp_OxDpYdfE1W18tXkh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2510280166

Currently, the nr_hw_queues update path manages two disjoint xarrays —
one for elevator tags and another for elevator type — both used during
elevator switching. Maintaining these two parallel structures for the
same purpose adds unnecessary complexity and potential for mismatched
state.

This patch unifies both xarrays into a single structure, struct
elv_change_ctx, which holds all per-queue elevator change context. A
single xarray, named elv_tbl, now maps each queue (q->id) in a tagset
to its corresponding elv_change_ctx entry, encapsulating the elevator
tags, type and name references.

This unification simplifies the code, improves maintainability, and
clarifies ownership of per-queue elevator state.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-sched.c | 76 +++++++++++++++++++++++++++++++++-----------
 block/blk-mq-sched.h |  3 ++
 block/blk-mq.c       | 50 +++++++++++++++++------------
 block/blk.h          |  7 ++--
 block/elevator.c     | 31 ++++--------------
 block/elevator.h     | 15 +++++++++
 6 files changed, 115 insertions(+), 67 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index e0bed16485c3..3d9386555a50 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -427,11 +427,11 @@ void blk_mq_free_sched_tags(struct elevator_tags *et,
 	kfree(et);
 }
 
-void blk_mq_free_sched_tags_batch(struct xarray *et_table,
+void blk_mq_free_sched_tags_batch(struct xarray *elv_tbl,
 		struct blk_mq_tag_set *set)
 {
 	struct request_queue *q;
-	struct elevator_tags *et;
+	struct elv_change_ctx *ctx;
 
 	lockdep_assert_held_write(&set->update_nr_hwq_lock);
 
@@ -444,13 +444,47 @@ void blk_mq_free_sched_tags_batch(struct xarray *et_table,
 		 * concurrently.
 		 */
 		if (q->elevator) {
-			et = xa_load(et_table, q->id);
-			if (unlikely(!et))
+			ctx = xa_load(elv_tbl, q->id);
+			if (!ctx || !ctx->et) {
 				WARN_ON_ONCE(1);
-			else
-				blk_mq_free_sched_tags(et, set);
+				continue;
+			}
+			blk_mq_free_sched_tags(ctx->et, set);
+			ctx->et = NULL;
+		}
+	}
+}
+
+void blk_mq_free_sched_ctx_batch(struct xarray *elv_tbl)
+{
+	unsigned long i;
+	struct elv_change_ctx *ctx;
+
+	xa_for_each(elv_tbl, i, ctx) {
+		xa_erase(elv_tbl, i);
+		kfree(ctx);
+	}
+}
+
+int blk_mq_alloc_sched_ctx_batch(struct xarray *elv_tbl,
+		struct blk_mq_tag_set *set)
+{
+	struct request_queue *q;
+	struct elv_change_ctx *ctx;
+
+	lockdep_assert_held_write(&set->update_nr_hwq_lock);
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		ctx = kzalloc(sizeof(struct elv_change_ctx), GFP_KERNEL);
+		if (!ctx)
+			return -ENOMEM;
+
+		if (xa_insert(elv_tbl, q->id, ctx, GFP_KERNEL)) {
+			kfree(ctx);
+			return -ENOMEM;
 		}
 	}
+	return 0;
 }
 
 struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
@@ -498,12 +532,13 @@ struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
 	return NULL;
 }
 
-int blk_mq_alloc_sched_tags_batch(struct xarray *et_table,
+int blk_mq_alloc_sched_tags_batch(struct xarray *elv_tbl,
 		struct blk_mq_tag_set *set, unsigned int nr_hw_queues)
 {
+	struct elv_change_ctx *ctx;
 	struct request_queue *q;
 	struct elevator_tags *et;
-	gfp_t gfp = GFP_NOIO | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;
+	int ret = -ENOMEM;
 
 	lockdep_assert_held_write(&set->update_nr_hwq_lock);
 
@@ -516,26 +551,31 @@ int blk_mq_alloc_sched_tags_batch(struct xarray *et_table,
 		 * concurrently.
 		 */
 		if (q->elevator) {
-			et = blk_mq_alloc_sched_tags(set, nr_hw_queues,
+			ctx = xa_load(elv_tbl, q->id);
+			if (WARN_ON_ONCE(!ctx)) {
+				ret = -ENOENT;
+				goto out_unwind;
+			}
+
+			ctx->et = blk_mq_alloc_sched_tags(set, nr_hw_queues,
 					blk_mq_default_nr_requests(set));
-			if (!et)
+			if (!ctx->et)
 				goto out_unwind;
-			if (xa_insert(et_table, q->id, et, gfp))
-				goto out_free_tags;
+
 		}
 	}
 	return 0;
-out_free_tags:
-	blk_mq_free_sched_tags(et, set);
 out_unwind:
 	list_for_each_entry_continue_reverse(q, &set->tag_list, tag_set_list) {
 		if (q->elevator) {
-			et = xa_load(et_table, q->id);
-			if (et)
-				blk_mq_free_sched_tags(et, set);
+			ctx = xa_load(elv_tbl, q->id);
+			if (ctx && ctx->et) {
+				blk_mq_free_sched_tags(ctx->et, set);
+				ctx->et = NULL;
+			}
 		}
 	}
-	return -ENOMEM;
+	return ret;
 }
 
 /* caller must have a reference to @e, will grab another one if successful */
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 8e21a6b1415d..2fddbc91a235 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -27,6 +27,9 @@ struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
 		unsigned int nr_hw_queues, unsigned int nr_requests);
 int blk_mq_alloc_sched_tags_batch(struct xarray *et_table,
 		struct blk_mq_tag_set *set, unsigned int nr_hw_queues);
+int blk_mq_alloc_sched_ctx_batch(struct xarray *elv_tbl,
+		struct blk_mq_tag_set *set);
+void blk_mq_free_sched_ctx_batch(struct xarray *elv_tbl);
 void blk_mq_free_sched_tags(struct elevator_tags *et,
 		struct blk_mq_tag_set *set);
 void blk_mq_free_sched_tags_batch(struct xarray *et_table,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d626d32f6e57..1f5ef7fc9cda 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4983,27 +4983,28 @@ struct elevator_tags *blk_mq_update_nr_requests(struct request_queue *q,
  * Switch back to the elevator type stored in the xarray.
  */
 static void blk_mq_elv_switch_back(struct request_queue *q,
-		struct xarray *elv_tbl, struct xarray *et_tbl)
+		struct xarray *elv_tbl)
 {
-	struct elevator_type *e = xa_load(elv_tbl, q->id);
-	struct elevator_tags *t = xa_load(et_tbl, q->id);
+	struct elv_change_ctx *ctx = xa_load(elv_tbl, q->id);
+
+	if (WARN_ON_ONCE(!ctx))
+		return;
 
 	/* The elv_update_nr_hw_queues unfreezes the queue. */
-	elv_update_nr_hw_queues(q, e, t);
+	elv_update_nr_hw_queues(q, ctx);
 
 	/* Drop the reference acquired in blk_mq_elv_switch_none. */
-	if (e)
-		elevator_put(e);
+	if (ctx->type)
+		elevator_put(ctx->type);
 }
 
 /*
- * Stores elevator type in xarray and set current elevator to none. It uses
- * q->id as an index to store the elevator type into the xarray.
+ * Stores elevator name and type in ctx and set current elevator to none.
  */
 static int blk_mq_elv_switch_none(struct request_queue *q,
 		struct xarray *elv_tbl)
 {
-	int ret = 0;
+	struct elv_change_ctx *ctx;
 
 	lockdep_assert_held_write(&q->tag_set->update_nr_hwq_lock);
 
@@ -5015,10 +5016,11 @@ static int blk_mq_elv_switch_none(struct request_queue *q,
 	 * can't run concurrently.
 	 */
 	if (q->elevator) {
+		ctx = xa_load(elv_tbl, q->id);
+		if (WARN_ON_ONCE(!ctx))
+			return -ENOENT;
 
-		ret = xa_insert(elv_tbl, q->id, q->elevator->type, GFP_KERNEL);
-		if (WARN_ON_ONCE(ret))
-			return ret;
+		ctx->name = q->elevator->type->elevator_name;
 
 		/*
 		 * Before we switch elevator to 'none', take a reference to
@@ -5029,9 +5031,14 @@ static int blk_mq_elv_switch_none(struct request_queue *q,
 		 */
 		__elevator_get(q->elevator->type);
 
+		/*
+		 * Store elevator type so that we can release the reference
+		 * taken above later.
+		 */
+		ctx->type = q->elevator->type;
 		elevator_set_none(q);
 	}
-	return ret;
+	return 0;
 }
 
 static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
@@ -5041,7 +5048,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	int prev_nr_hw_queues = set->nr_hw_queues;
 	unsigned int memflags;
 	int i;
-	struct xarray elv_tbl, et_tbl;
+	struct xarray elv_tbl;
 	bool queues_frozen = false;
 
 	lockdep_assert_held(&set->tag_list_lock);
@@ -5055,11 +5062,12 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 	memflags = memalloc_noio_save();
 
-	xa_init(&et_tbl);
-	if (blk_mq_alloc_sched_tags_batch(&et_tbl, set, nr_hw_queues) < 0)
-		goto out_memalloc_restore;
-
 	xa_init(&elv_tbl);
+	if (blk_mq_alloc_sched_ctx_batch(&elv_tbl, set) < 0)
+		goto out_free_ctx;
+
+	if (blk_mq_alloc_sched_tags_batch(&elv_tbl, set, nr_hw_queues) < 0)
+		goto out_free_ctx;
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_debugfs_unregister_hctxs(q);
@@ -5105,7 +5113,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		/* switch_back expects queue to be frozen */
 		if (!queues_frozen)
 			blk_mq_freeze_queue_nomemsave(q);
-		blk_mq_elv_switch_back(q, &elv_tbl, &et_tbl);
+		blk_mq_elv_switch_back(q, &elv_tbl);
 	}
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
@@ -5116,9 +5124,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_add_hw_queues_cpuhp(q);
 	}
 
+out_free_ctx:
+	blk_mq_free_sched_ctx_batch(&elv_tbl);
 	xa_destroy(&elv_tbl);
-	xa_destroy(&et_tbl);
-out_memalloc_restore:
 	memalloc_noio_restore(memflags);
 
 	/* Free the excess tags when nr_hw_queues shrink. */
diff --git a/block/blk.h b/block/blk.h
index 170794632135..a7992680f9e1 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -11,8 +11,7 @@
 #include <xen/xen.h>
 #include "blk-crypto-internal.h"
 
-struct elevator_type;
-struct elevator_tags;
+struct elv_change_ctx;
 
 /*
  * Default upper limit for the software max_sectors limit used for regular I/Os.
@@ -333,8 +332,8 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 
 bool blk_insert_flush(struct request *rq);
 
-void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_type *e,
-		struct elevator_tags *t);
+void elv_update_nr_hw_queues(struct request_queue *q,
+		struct elv_change_ctx *ctx);
 void elevator_set_default(struct request_queue *q);
 void elevator_set_none(struct request_queue *q);
 
diff --git a/block/elevator.c b/block/elevator.c
index e2ebfbf107b3..cd7bdff205c8 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -45,19 +45,6 @@
 #include "blk-wbt.h"
 #include "blk-cgroup.h"
 
-/* Holding context data for changing elevator */
-struct elv_change_ctx {
-	const char *name;
-	bool no_uevent;
-
-	/* for unregistering old elevator */
-	struct elevator_queue *old;
-	/* for registering new elevator */
-	struct elevator_queue *new;
-	/* holds sched tags data */
-	struct elevator_tags *et;
-};
-
 static DEFINE_SPINLOCK(elv_list_lock);
 static LIST_HEAD(elv_list);
 
@@ -706,32 +693,28 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
  * The I/O scheduler depends on the number of hardware queues, this forces a
  * reattachment when nr_hw_queues changes.
  */
-void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_type *e,
-		struct elevator_tags *t)
+void elv_update_nr_hw_queues(struct request_queue *q,
+		struct elv_change_ctx *ctx)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
-	struct elv_change_ctx ctx = {};
 	int ret = -ENODEV;
 
 	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 
-	if (e && !blk_queue_dying(q) && blk_queue_registered(q)) {
-		ctx.name = e->elevator_name;
-		ctx.et = t;
-
+	if (ctx->type && !blk_queue_dying(q) && blk_queue_registered(q)) {
 		mutex_lock(&q->elevator_lock);
 		/* force to reattach elevator after nr_hw_queue is updated */
-		ret = elevator_switch(q, &ctx);
+		ret = elevator_switch(q, ctx);
 		mutex_unlock(&q->elevator_lock);
 	}
 	blk_mq_unfreeze_queue_nomemrestore(q);
 	if (!ret)
-		WARN_ON_ONCE(elevator_change_done(q, &ctx));
+		WARN_ON_ONCE(elevator_change_done(q, ctx));
 	/*
 	 * Free sched tags if it's allocated but we couldn't switch elevator.
 	 */
-	if (t && !ctx.new)
-		blk_mq_free_sched_tags(t, set);
+	if (ctx->et && !ctx->new)
+		blk_mq_free_sched_tags(ctx->et, set);
 }
 
 /*
diff --git a/block/elevator.h b/block/elevator.h
index c4d20155065e..bad43182361e 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -32,6 +32,21 @@ struct elevator_tags {
 	struct blk_mq_tags *tags[];
 };
 
+/* Holding context data for changing elevator */
+struct elv_change_ctx {
+	const char *name;
+	bool no_uevent;
+
+	/* for unregistering old elevator */
+	struct elevator_queue *old;
+	/* for registering new elevator */
+	struct elevator_queue *new;
+	/* store elevator type */
+	struct elevator_type *type;
+	/* holds sched tags data */
+	struct elevator_tags *et;
+};
+
 struct elevator_mq_ops {
 	int (*init_sched)(struct request_queue *, struct elevator_queue *);
 	void (*exit_sched)(struct elevator_queue *);
-- 
2.51.0


