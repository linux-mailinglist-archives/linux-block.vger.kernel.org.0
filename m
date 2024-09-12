Return-Path: <linux-block+bounces-11544-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC4B9766E7
	for <lists+linux-block@lfdr.de>; Thu, 12 Sep 2024 12:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E69A0B23638
	for <lists+linux-block@lfdr.de>; Thu, 12 Sep 2024 10:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7960F18BC07;
	Thu, 12 Sep 2024 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbldrrLT"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3154119F12D
	for <linux-block@vger.kernel.org>; Thu, 12 Sep 2024 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726138209; cv=none; b=QU+hrPcSTPGoKbFWk/MWjcPTF0tWvrRDyUybmG9Ycg1wZmT4QVW/WLG5cMGzkVNuqMwARFxOpF1SAWRshqryaggkTyB9hWKSPXQhJTEHBtYKOqyztYzu3hdqWoognxMZbhwEInFXQed36/88SnMDCHmyf18P/Rs+6IlpU+03fxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726138209; c=relaxed/simple;
	bh=Yz2jNd6EV+nzJOw3LHKKItHoetKACp0OYXx4cX12waQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NiswSV5O89DaN/xHKsTD42dJnVbMSdh9fIghRQCkx58SAkNmnQslMesHjHhBs13TY0D26+sGMRv0i8llbLh3wXqKQNl/3qH+Ca1HHEuBXAFhcr8/G/iGObcHFhtsGAErSxIz39U6LJtmqrc34E69XqTMfJpXBJOLNdRkm5bK330=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RbldrrLT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726138205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WlAPVMb5MY8eOxxNVU7vMQ3PjuqxTDN+ZSDYKAmwu70=;
	b=RbldrrLTn5Ds2ZSTotZDhVHuYLrNcBVd0KGd40qTs0QrYE8AYYQC9LSzKtGGT8MHWsU81A
	y0PcCLZiR7jKKBzm5bzda0WBUO0dZP8C8at3JJ8c0kFZ/u5adhTxK8Z9IUitxhXcovG+UT
	DR46sEnHaTmy9SJCRSHerUAeSmCqImM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-j0Vh3dzENlOLzRWHKgUQ7A-1; Thu,
 12 Sep 2024 06:50:02 -0400
X-MC-Unique: j0Vh3dzENlOLzRWHKgUQ7A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E57D91955D4F;
	Thu, 12 Sep 2024 10:50:00 +0000 (UTC)
Received: from localhost (unknown [10.72.116.81])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 94D313000235;
	Thu, 12 Sep 2024 10:49:58 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH V6 4/8] io_uring: support SQE group
Date: Thu, 12 Sep 2024 18:49:24 +0800
Message-ID: <20240912104933.1875409-5-ming.lei@redhat.com>
In-Reply-To: <20240912104933.1875409-1-ming.lei@redhat.com>
References: <20240912104933.1875409-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

SQE group is defined as one chain of SQEs starting with the first SQE that
has IOSQE_SQE_GROUP set, and ending with the first subsequent SQE that
doesn't have it set, and it is similar with chain of linked SQEs.

Not like linked SQEs, each sqe is issued after the previous one is
completed. All SQEs in one group can be submitted in parallel. To simplify
the implementation from beginning, all members are queued after the leader
is completed, however, this way may be changed and leader and members may
be issued concurrently in future.

The 1st SQE is group leader, and the other SQEs are group member. The whole
group share single IOSQE_IO_LINK and IOSQE_IO_DRAIN from group leader, and
the two flags can't be set for group members. For the sake of
simplicity, IORING_OP_LINK_TIMEOUT is disallowed for SQE group now.

When the group is in one link chain, this group isn't submitted until the
previous SQE or group is completed. And the following SQE or group can't
be started if this group isn't completed. Failure from any group member will
fail the group leader, then the link chain can be terminated.

When IOSQE_IO_DRAIN is set for group leader, all requests in this group and
previous requests submitted are drained. Given IOSQE_IO_DRAIN can be set for
group leader only, we respect IO_DRAIN by always completing group leader as
the last one in the group. Meantime it is natural to post leader's CQE
as the last one from application viewpoint.

Working together with IOSQE_IO_LINK, SQE group provides flexible way to
support N:M dependency, such as:

- group A is chained with group B together
- group A has N SQEs
- group B has M SQEs

then M SQEs in group B depend on N SQEs in group A.

N:M dependency can support some interesting use cases in efficient way:

1) read from multiple files, then write the read data into single file

2) read from single file, and write the read data into multiple files

3) write same data into multiple files, and read data from multiple files and
compare if correct data is written

Also IOSQE_SQE_GROUP takes the last bit in sqe->flags, but we still can
extend sqe->flags with io_uring context flag, such as use __pad3 for
non-uring_cmd OPs and part of uring_cmd_flags for uring_cmd OP.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/io_uring_types.h |  18 ++
 include/uapi/linux/io_uring.h  |   4 +
 io_uring/io_uring.c            | 299 +++++++++++++++++++++++++++++++--
 io_uring/io_uring.h            |   6 +
 io_uring/timeout.c             |   6 +
 5 files changed, 318 insertions(+), 15 deletions(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 4b9ba523978d..11c6726abbb9 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -202,6 +202,8 @@ struct io_submit_state {
 	/* batch completion logic */
 	struct io_wq_work_list	compl_reqs;
 	struct io_submit_link	link;
+	/* points to current group */
+	struct io_submit_link	group;
 
 	bool			plug_started;
 	bool			need_plug;
@@ -438,6 +440,7 @@ enum {
 	REQ_F_FORCE_ASYNC_BIT	= IOSQE_ASYNC_BIT,
 	REQ_F_BUFFER_SELECT_BIT	= IOSQE_BUFFER_SELECT_BIT,
 	REQ_F_CQE_SKIP_BIT	= IOSQE_CQE_SKIP_SUCCESS_BIT,
+	REQ_F_SQE_GROUP_BIT	= IOSQE_SQE_GROUP_BIT,
 
 	/* first byte is taken by user flags, shift it to not overlap */
 	REQ_F_FAIL_BIT		= 8,
@@ -468,6 +471,7 @@ enum {
 	REQ_F_BL_EMPTY_BIT,
 	REQ_F_BL_NO_RECYCLE_BIT,
 	REQ_F_BUFFERS_COMMIT_BIT,
+	REQ_F_SQE_GROUP_LEADER_BIT,
 
 	/* not a real bit, just to check we're not overflowing the space */
 	__REQ_F_LAST_BIT,
@@ -491,6 +495,8 @@ enum {
 	REQ_F_BUFFER_SELECT	= IO_REQ_FLAG(REQ_F_BUFFER_SELECT_BIT),
 	/* IOSQE_CQE_SKIP_SUCCESS */
 	REQ_F_CQE_SKIP		= IO_REQ_FLAG(REQ_F_CQE_SKIP_BIT),
+	/* IOSQE_SQE_GROUP */
+	REQ_F_SQE_GROUP		= IO_REQ_FLAG(REQ_F_SQE_GROUP_BIT),
 
 	/* fail rest of links */
 	REQ_F_FAIL		= IO_REQ_FLAG(REQ_F_FAIL_BIT),
@@ -546,6 +552,8 @@ enum {
 	REQ_F_BL_NO_RECYCLE	= IO_REQ_FLAG(REQ_F_BL_NO_RECYCLE_BIT),
 	/* buffer ring head needs incrementing on put */
 	REQ_F_BUFFERS_COMMIT	= IO_REQ_FLAG(REQ_F_BUFFERS_COMMIT_BIT),
+	/* sqe group lead */
+	REQ_F_SQE_GROUP_LEADER	= IO_REQ_FLAG(REQ_F_SQE_GROUP_LEADER_BIT),
 };
 
 typedef void (*io_req_tw_func_t)(struct io_kiocb *req, struct io_tw_state *ts);
@@ -651,6 +659,8 @@ struct io_kiocb {
 	void				*async_data;
 	/* linked requests, IFF REQ_F_HARDLINK or REQ_F_LINK are set */
 	atomic_t			poll_refs;
+	/* reference for group leader request */
+	int				grp_refs;
 	struct io_kiocb			*link;
 	/* custom credentials, valid IFF REQ_F_CREDS is set */
 	const struct cred		*creds;
@@ -660,6 +670,14 @@ struct io_kiocb {
 		u64			extra1;
 		u64			extra2;
 	} big_cqe;
+
+	union {
+		/* links all group members for leader */
+		struct io_kiocb			*grp_link;
+
+		/* points to group leader for member */
+		struct io_kiocb			*grp_leader;
+	};
 };
 
 struct io_overflow_cqe {
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 7b15216a3d7f..2af32745ebd3 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -124,6 +124,7 @@ enum io_uring_sqe_flags_bit {
 	IOSQE_ASYNC_BIT,
 	IOSQE_BUFFER_SELECT_BIT,
 	IOSQE_CQE_SKIP_SUCCESS_BIT,
+	IOSQE_SQE_GROUP_BIT,
 };
 
 /*
@@ -143,6 +144,8 @@ enum io_uring_sqe_flags_bit {
 #define IOSQE_BUFFER_SELECT	(1U << IOSQE_BUFFER_SELECT_BIT)
 /* don't post CQE if request succeeded */
 #define IOSQE_CQE_SKIP_SUCCESS	(1U << IOSQE_CQE_SKIP_SUCCESS_BIT)
+/* defines sqe group */
+#define IOSQE_SQE_GROUP		(1U << IOSQE_SQE_GROUP_BIT)
 
 /*
  * io_uring_setup() flags
@@ -554,6 +557,7 @@ struct io_uring_params {
 #define IORING_FEAT_REG_REG_RING	(1U << 13)
 #define IORING_FEAT_RECVSEND_BUNDLE	(1U << 14)
 #define IORING_FEAT_MIN_TIMEOUT		(1U << 15)
+#define IORING_FEAT_SQE_GROUP		(1U << 16)
 
 /*
  * io_uring_register(2) opcodes and arguments
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index d277f0a6e549..99b44b6babd6 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -111,13 +111,15 @@
 			  IOSQE_IO_HARDLINK | IOSQE_ASYNC)
 
 #define SQE_VALID_FLAGS	(SQE_COMMON_FLAGS | IOSQE_BUFFER_SELECT | \
-			IOSQE_IO_DRAIN | IOSQE_CQE_SKIP_SUCCESS)
+			IOSQE_IO_DRAIN | IOSQE_CQE_SKIP_SUCCESS | \
+			IOSQE_SQE_GROUP)
 
 #define IO_REQ_CLEAN_FLAGS (REQ_F_BUFFER_SELECTED | REQ_F_NEED_CLEANUP | \
 				REQ_F_POLLED | REQ_F_INFLIGHT | REQ_F_CREDS | \
 				REQ_F_ASYNC_DATA)
 
 #define IO_REQ_CLEAN_SLOW_FLAGS (REQ_F_REFCOUNT | REQ_F_LINK | REQ_F_HARDLINK |\
+				 REQ_F_SQE_GROUP | REQ_F_SQE_GROUP_LEADER | \
 				 IO_REQ_CLEAN_FLAGS)
 
 #define IO_TCTX_REFS_CACHE_NR	(1U << 10)
@@ -875,6 +877,119 @@ static __always_inline void io_req_commit_cqe(struct io_ring_ctx *ctx,
 	}
 }
 
+/* Can only be called after this request is issued */
+static inline struct io_kiocb *get_group_leader(struct io_kiocb *req)
+{
+	if (req->flags & REQ_F_SQE_GROUP) {
+		if (req_is_group_leader(req))
+			return req;
+		return req->grp_leader;
+	}
+	return NULL;
+}
+
+void io_cancel_group_members(struct io_kiocb *req, bool ignore_cqes)
+{
+	struct io_kiocb *member = req->grp_link;
+
+	while (member) {
+		struct io_kiocb *next = member->grp_link;
+
+		if (ignore_cqes)
+			member->flags |= REQ_F_CQE_SKIP;
+		if (!(member->flags & REQ_F_FAIL)) {
+			req_set_fail(member);
+			io_req_set_res(member, -ECANCELED, 0);
+		}
+		member = next;
+	}
+}
+
+static void io_queue_group_members(struct io_kiocb *req)
+{
+	struct io_kiocb *member = req->grp_link;
+
+	if (!member)
+		return;
+
+	req->grp_link = NULL;
+	while (member) {
+		struct io_kiocb *next = member->grp_link;
+
+		member->grp_leader = req;
+		if (unlikely(member->flags & REQ_F_FAIL)) {
+			io_req_task_queue_fail(member, member->cqe.res);
+		} else if (unlikely(req->flags & REQ_F_FAIL)) {
+			io_req_task_queue_fail(member, -ECANCELED);
+		} else {
+			io_req_task_queue(member);
+		}
+		member = next;
+	}
+}
+
+/* called only after the request is completed */
+static void mark_last_group_member(struct io_kiocb *req)
+{
+	/* reuse REQ_F_SQE_GROUP as flag of last member */
+	WARN_ON_ONCE(req->flags & REQ_F_SQE_GROUP);
+
+	req->flags |= REQ_F_SQE_GROUP;
+}
+
+/* called only after the request is completed */
+static bool req_is_last_group_member(struct io_kiocb *req)
+{
+	return req->flags & REQ_F_SQE_GROUP;
+}
+
+static void io_complete_group_member(struct io_kiocb *req)
+{
+	struct io_kiocb *lead = get_group_leader(req);
+
+	if (WARN_ON_ONCE(!(req->flags & REQ_F_SQE_GROUP) ||
+			 lead->grp_refs <= 0))
+		return;
+
+	/* member CQE needs to be posted first */
+	if (!(req->flags & REQ_F_CQE_SKIP))
+		io_req_commit_cqe(req->ctx, req);
+
+	req->flags &= ~REQ_F_SQE_GROUP;
+
+	/* Set leader as failed in case of any member failed */
+	if (unlikely((req->flags & REQ_F_FAIL)))
+		req_set_fail(lead);
+
+	if (!--lead->grp_refs) {
+		mark_last_group_member(req);
+		if (!(lead->flags & REQ_F_CQE_SKIP))
+			io_req_commit_cqe(lead->ctx, lead);
+	} else if (lead->grp_refs == 1 && (lead->flags & REQ_F_SQE_GROUP)) {
+		/*
+		 * The single uncompleted leader will degenerate to plain
+		 * request, so group leader can be always freed via the
+		 * last completed member.
+		 */
+		lead->flags &= ~REQ_F_SQE_GROUP_LEADER;
+	}
+}
+
+static void io_complete_group_leader(struct io_kiocb *req)
+{
+	WARN_ON_ONCE(req->grp_refs <= 1);
+	req->flags &= ~REQ_F_SQE_GROUP;
+	req->grp_refs -= 1;
+}
+
+static void io_complete_group_req(struct io_kiocb *req)
+{
+	if (req_is_group_leader(req))
+		io_complete_group_leader(req);
+	else
+		io_complete_group_member(req);
+}
+
 static void io_req_complete_post(struct io_kiocb *req, unsigned issue_flags)
 {
 	struct io_ring_ctx *ctx = req->ctx;
@@ -890,7 +1005,8 @@ static void io_req_complete_post(struct io_kiocb *req, unsigned issue_flags)
 	 * Handle special CQ sync cases via task_work. DEFER_TASKRUN requires
 	 * the submitter task context, IOPOLL protects with uring_lock.
 	 */
-	if (ctx->task_complete || (ctx->flags & IORING_SETUP_IOPOLL)) {
+	if (ctx->task_complete || (ctx->flags & IORING_SETUP_IOPOLL) ||
+	    req_is_group_leader(req)) {
 		req->io_task_work.func = io_req_task_complete;
 		io_req_task_work_add(req);
 		return;
@@ -1388,11 +1504,43 @@ static void io_free_batch_list(struct io_ring_ctx *ctx,
 						    comp_list);
 
 		if (unlikely(req->flags & IO_REQ_CLEAN_SLOW_FLAGS)) {
+			if (req_is_last_group_member(req) ||
+					req_is_group_leader(req)) {
+				struct io_kiocb *leader;
+
+				/* Leader is freed via the last member */
+				if (req_is_group_leader(req)) {
+					if (req->grp_link)
+						io_queue_group_members(req);
+					node = req->comp_list.next;
+					continue;
+				}
+
+				/*
+				 * Prepare for freeing leader since we are the
+				 * last group member
+				 */
+				leader = get_group_leader(req);
+				leader->flags &= ~REQ_F_SQE_GROUP_LEADER;
+				req->flags &= ~REQ_F_SQE_GROUP;
+				/*
+				 * Link leader to current request's next,
+				 * this way works because the iterator
+				 * always check the next node only.
+				 *
+				 * Be careful when you change the iterator
+				 * in future
+				 */
+				wq_stack_add_head(&leader->comp_list,
+						  &req->comp_list);
+			}
+
 			if (req->flags & REQ_F_REFCOUNT) {
 				node = req->comp_list.next;
 				if (!req_ref_put_and_test(req))
 					continue;
 			}
+
 			if ((req->flags & REQ_F_POLLED) && req->apoll) {
 				struct async_poll *apoll = req->apoll;
 
@@ -1427,8 +1575,16 @@ void __io_submit_flush_completions(struct io_ring_ctx *ctx)
 		struct io_kiocb *req = container_of(node, struct io_kiocb,
 					    comp_list);
 
-		if (!(req->flags & REQ_F_CQE_SKIP))
-			io_req_commit_cqe(ctx, req);
+		if (unlikely(req->flags & (REQ_F_CQE_SKIP | REQ_F_SQE_GROUP))) {
+			if (req->flags & REQ_F_SQE_GROUP) {
+				io_complete_group_req(req);
+				continue;
+			}
+
+			if (req->flags & REQ_F_CQE_SKIP)
+				continue;
+		}
+		io_req_commit_cqe(ctx, req);
 	}
 	__io_cq_unlock_post(ctx);
 
@@ -1638,8 +1794,12 @@ static u32 io_get_sequence(struct io_kiocb *req)
 	struct io_kiocb *cur;
 
 	/* need original cached_sq_head, but it was increased for each req */
-	io_for_each_link(cur, req)
-		seq--;
+	io_for_each_link(cur, req) {
+		if (req_is_group_leader(cur))
+			seq -= cur->grp_refs;
+		else
+			seq--;
+	}
 	return seq;
 }
 
@@ -2101,6 +2261,65 @@ static int io_init_req(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	return def->prep(req, sqe);
 }
 
+static struct io_kiocb *io_group_sqe(struct io_submit_link *group,
+				     struct io_kiocb *req)
+{
+	/*
+	 * Group chain is similar with link chain: starts with 1st sqe with
+	 * REQ_F_SQE_GROUP, and ends with the 1st sqe without REQ_F_SQE_GROUP
+	 */
+	if (group->head) {
+		struct io_kiocb *lead = group->head;
+
+		/*
+		 * Members can't be in link chain, can't be drained
+		 *
+		 * Also IOSQE_CQE_SKIP_SUCCESS can't be set for member
+		 * for the sake of simplicity
+		 */
+		if (req->flags & (IO_REQ_LINK_FLAGS | REQ_F_IO_DRAIN |
+				  REQ_F_CQE_SKIP))
+			req_fail_link_node(lead, -EINVAL);
+
+		lead->grp_refs += 1;
+		group->last->grp_link = req;
+		group->last = req;
+
+		if (req->flags & REQ_F_SQE_GROUP)
+			return NULL;
+
+		req->grp_link = NULL;
+		req->flags |= REQ_F_SQE_GROUP;
+		group->head = NULL;
+
+		return lead;
+	} else {
+		if (WARN_ON_ONCE(!(req->flags & REQ_F_SQE_GROUP)))
+			return req;
+		group->head = req;
+		group->last = req;
+		req->grp_refs = 1;
+		req->flags |= REQ_F_SQE_GROUP_LEADER;
+		return NULL;
+	}
+}
+
+static __cold struct io_kiocb *io_submit_fail_group(
+		struct io_submit_link *link, struct io_kiocb *req)
+{
+	struct io_kiocb *lead = link->head;
+
+	/*
+	 * Instead of failing eagerly, continue assembling the group link
+	 * if applicable and mark the leader with REQ_F_FAIL. The group
+	 * flushing code should find the flag and handle the rest
+	 */
+	if (lead && !(lead->flags & REQ_F_FAIL))
+		req_fail_link_node(lead, -ECANCELED);
+
+	return io_group_sqe(link, req);
+}
+
 static __cold int io_submit_fail_link(struct io_submit_link *link,
 				      struct io_kiocb *req, int ret)
 {
@@ -2139,11 +2358,18 @@ static __cold int io_submit_fail_init(const struct io_uring_sqe *sqe,
 {
 	struct io_ring_ctx *ctx = req->ctx;
 	struct io_submit_link *link = &ctx->submit_state.link;
+	struct io_submit_link *group = &ctx->submit_state.group;
 
 	trace_io_uring_req_failed(sqe, req, ret);
 
 	req_fail_link_node(req, ret);
 
+	if (group->head || (req->flags & REQ_F_SQE_GROUP)) {
+		req = io_submit_fail_group(group, req);
+		if (!req)
+			return 0;
+	}
+
 	/* cover both linked and non-linked request */
 	return io_submit_fail_link(link, req, ret);
 }
@@ -2187,11 +2413,29 @@ static struct io_kiocb *io_link_sqe(struct io_submit_link *link,
 	return req;
 }
 
+static inline bool io_group_assembling(const struct io_submit_state *state,
+				       const struct io_kiocb *req)
+{
+	if (state->group.head || req->flags & REQ_F_SQE_GROUP)
+		return true;
+	return false;
+}
+
+/* Failed request is covered too */
+static inline bool io_link_assembling(const struct io_submit_state *state,
+				      const struct io_kiocb *req)
+{
+	if (state->link.head || (req->flags & (IO_REQ_LINK_FLAGS |
+				 REQ_F_FORCE_ASYNC | REQ_F_FAIL)))
+		return true;
+	return false;
+}
+
 static inline int io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 			 const struct io_uring_sqe *sqe)
 	__must_hold(&ctx->uring_lock)
 {
-	struct io_submit_link *link = &ctx->submit_state.link;
+	struct io_submit_state *state = &ctx->submit_state;
 	int ret;
 
 	ret = io_init_req(ctx, req, sqe);
@@ -2200,11 +2444,20 @@ static inline int io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 
 	trace_io_uring_submit_req(req);
 
-	if (unlikely(link->head || (req->flags & (IO_REQ_LINK_FLAGS |
-				    REQ_F_FORCE_ASYNC | REQ_F_FAIL)))) {
-		req = io_link_sqe(link, req);
-		if (!req)
-			return 0;
+	if (unlikely(io_link_assembling(state, req) ||
+		     io_group_assembling(state, req))) {
+		if (io_group_assembling(state, req)) {
+			req = io_group_sqe(&state->group, req);
+			if (!req)
+				return 0;
+		}
+
+		/* covers non-linked failed request too */
+		if (io_link_assembling(state, req)) {
+			req = io_link_sqe(&state->link, req);
+			if (!req)
+				return 0;
+		}
 	}
 	io_queue_sqe(req);
 	return 0;
@@ -2217,8 +2470,22 @@ static void io_submit_state_end(struct io_ring_ctx *ctx)
 {
 	struct io_submit_state *state = &ctx->submit_state;
 
-	if (unlikely(state->link.head))
-		io_queue_sqe_fallback(state->link.head);
+	if (unlikely(state->group.head || state->link.head)) {
+		/* the last member must set REQ_F_SQE_GROUP */
+		if (state->group.head) {
+			struct io_kiocb *lead = state->group.head;
+
+			state->group.last->grp_link = NULL;
+			if (lead->flags & IO_REQ_LINK_FLAGS)
+				io_link_sqe(&state->link, lead);
+			else
+				io_queue_sqe_fallback(lead);
+		}
+
+		if (unlikely(state->link.head))
+			io_queue_sqe_fallback(state->link.head);
+	}
+
 	/* flush only after queuing links as they can generate completions */
 	io_submit_flush_completions(ctx);
 	if (state->plug_started)
@@ -2236,6 +2503,7 @@ static void io_submit_state_start(struct io_submit_state *state,
 	state->submit_nr = max_ios;
 	/* set only head, no need to init link_last in advance */
 	state->link.head = NULL;
+	state->group.head = NULL;
 }
 
 static void io_commit_sqring(struct io_ring_ctx *ctx)
@@ -3670,7 +3938,8 @@ static __cold int io_uring_create(unsigned entries, struct io_uring_params *p,
 			IORING_FEAT_EXT_ARG | IORING_FEAT_NATIVE_WORKERS |
 			IORING_FEAT_RSRC_TAGS | IORING_FEAT_CQE_SKIP |
 			IORING_FEAT_LINKED_FILE | IORING_FEAT_REG_REG_RING |
-			IORING_FEAT_RECVSEND_BUNDLE | IORING_FEAT_MIN_TIMEOUT;
+			IORING_FEAT_RECVSEND_BUNDLE | IORING_FEAT_MIN_TIMEOUT |
+			IORING_FEAT_SQE_GROUP;
 
 	if (copy_to_user(params, p, sizeof(*p))) {
 		ret = -EFAULT;
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 65078e641390..df2be7353414 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -72,6 +72,7 @@ bool io_post_aux_cqe(struct io_ring_ctx *ctx, u64 user_data, s32 res, u32 cflags
 void io_add_aux_cqe(struct io_ring_ctx *ctx, u64 user_data, s32 res, u32 cflags);
 bool io_req_post_cqe(struct io_kiocb *req, s32 res, u32 cflags);
 void __io_commit_cqring_flush(struct io_ring_ctx *ctx);
+void io_cancel_group_members(struct io_kiocb *req, bool ignore_cqes);
 
 struct file *io_file_get_normal(struct io_kiocb *req, int fd);
 struct file *io_file_get_fixed(struct io_kiocb *req, int fd,
@@ -343,6 +344,11 @@ static inline void io_tw_lock(struct io_ring_ctx *ctx, struct io_tw_state *ts)
 	lockdep_assert_held(&ctx->uring_lock);
 }
 
+static inline bool req_is_group_leader(struct io_kiocb *req)
+{
+	return req->flags & REQ_F_SQE_GROUP_LEADER;
+}
+
 /*
  * Don't complete immediately but use deferred completion infrastructure.
  * Protected by ->uring_lock and can only be used either with
diff --git a/io_uring/timeout.c b/io_uring/timeout.c
index 9973876d91b0..dad7e9283d7e 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -168,6 +168,8 @@ static void io_fail_links(struct io_kiocb *req)
 			link->flags |= REQ_F_CQE_SKIP;
 		else
 			link->flags &= ~REQ_F_CQE_SKIP;
+		if (req_is_group_leader(link))
+			io_cancel_group_members(link, ignore_cqes);
 		trace_io_uring_fail_link(req, link);
 		link = link->link;
 	}
@@ -543,6 +545,10 @@ static int __io_timeout_prep(struct io_kiocb *req,
 	if (is_timeout_link) {
 		struct io_submit_link *link = &req->ctx->submit_state.link;
 
+		/* so far disallow IO group link timeout */
+		if (req->ctx->submit_state.group.head)
+			return -EINVAL;
+
 		if (!link->head)
 			return -EINVAL;
 		if (link->last->opcode == IORING_OP_LINK_TIMEOUT)
-- 
2.42.0


