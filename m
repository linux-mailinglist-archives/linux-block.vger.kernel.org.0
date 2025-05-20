Return-Path: <linux-block+bounces-21795-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40249ABCE51
	for <lists+linux-block@lfdr.de>; Tue, 20 May 2025 06:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19DA17139D
	for <lists+linux-block@lfdr.de>; Tue, 20 May 2025 04:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552BB2459C7;
	Tue, 20 May 2025 04:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqVUBjAO"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BF0213E77
	for <linux-block@vger.kernel.org>; Tue, 20 May 2025 04:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747716921; cv=none; b=oDo0fYeS1e3BRJrqCZr/lsVWv1G2gpSbG8V3njZn0WoIbNDQhc6HZGtJfvNAdIPuKvw5836HkMh/dnKn9KS9KfMe8qb8qu2PDkpchBnnWVnYKk1SwWsgls1/tG3JYOfuY5ya4N24rUutqytVGPyCvIiqBXYPoJQrvBjtrc91OjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747716921; c=relaxed/simple;
	bh=/7LoKdAZYi54mk2/tEj+FZKO5eJrZf3Un2JFuNF+QU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgStXPIyj60n6NT07/Y8QJyL0kEzImc+4V+FTB62JrBNMhKd1RZlCi5Lob3cqcdjf6ms43c2d/sHyZ4xJ7T3zTpYp+jxYFEPZqzZPLJAWWuU9GX2UIOtUwuwOevcx1jIqOuIaBbBjZTmMMC12jcMKHpRtp+PHsBt50pSVv0+6IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BqVUBjAO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747716918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vOiLAHn8UHh8TvH7g/KELuSMXln2fQ6t/gT9IcGyqUA=;
	b=BqVUBjAOWMuXPCcl3oYL710CGb3MkuawtHTCaPn0tO4oo7B5Jv/Cg3CQTBIiiOB/FGDnBS
	kngl+0PHUzRK5LZvwLnPWvRcMch9rbw7wjRy7RMqSrP81YMVYc10cnW1mbABf2kxOIjy4I
	mf0LHRISIkVbXG8zlsQXhdxtcas/c0U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-__dvVLPMPuGcKLRKmYTsEw-1; Tue,
 20 May 2025 00:55:16 -0400
X-MC-Unique: __dvVLPMPuGcKLRKmYTsEw-1
X-Mimecast-MFC-AGG-ID: __dvVLPMPuGcKLRKmYTsEw_1747716915
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B0CE180048E;
	Tue, 20 May 2025 04:55:15 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 30F0230001AA;
	Tue, 20 May 2025 04:55:13 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 2/6] ublk: prepare for supporting to register request buffer automatically
Date: Tue, 20 May 2025 12:54:32 +0800
Message-ID: <20250520045455.515691-3-ming.lei@redhat.com>
In-Reply-To: <20250520045455.515691-1-ming.lei@redhat.com>
References: <20250520045455.515691-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

UBLK_F_SUPPORT_ZERO_COPY requires ublk server to issue explicit buffer
register/unregister uring_cmd for each IO, this way is not only inefficient,
but also introduce dependency between buffer consumer and buffer register/
unregister uring_cmd, please see tools/testing/selftests/ublk/stripe.c
in which backing file IO has to be issued one by one by IOSQE_IO_LINK.

Prepare for adding feature UBLK_F_AUTO_BUF_REG for addressing the existing
zero copy limitation:

- register request buffer automatically to ublk uring_cmd's io_uring
  context before delivering io command to ublk server

- unregister request buffer automatically from the ublk uring_cmd's
  io_uring context when completing the request

- io_uring will unregister the buffer automatically when uring is
  exiting, so we needn't worry about accident exit

For using this feature, ublk server has to create one sparse buffer table

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 70 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index ae2f47dc8224..3e56a9d267fb 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -133,6 +133,14 @@ struct ublk_uring_cmd_pdu {
  */
 #define UBLK_IO_FLAG_NEED_GET_DATA 0x08
 
+/*
+ * request buffer is registered automatically, so we have to unregister it
+ * before completing this request.
+ *
+ * io_uring will unregister buffer automatically for us during exiting.
+ */
+#define UBLK_IO_FLAG_AUTO_BUF_REG 	0x10
+
 /* atomic RW with ubq->cancel_lock */
 #define UBLK_IO_FLAG_CANCELED	0x80000000
 
@@ -205,6 +213,7 @@ struct ublk_params_header {
 	__u32	types;
 };
 
+static void ublk_io_release(void *priv);
 static void ublk_stop_dev_unlocked(struct ublk_device *ub);
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
@@ -619,6 +628,11 @@ static inline bool ublk_support_zero_copy(const struct ublk_queue *ubq)
 	return ubq->flags & UBLK_F_SUPPORT_ZERO_COPY;
 }
 
+static inline bool ublk_support_auto_buf_reg(const struct ublk_queue *ubq)
+{
+	return false;
+}
+
 static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
 {
 	return ubq->flags & UBLK_F_USER_COPY;
@@ -626,7 +640,8 @@ static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
 
 static inline bool ublk_need_map_io(const struct ublk_queue *ubq)
 {
-	return !ublk_support_user_copy(ubq) && !ublk_support_zero_copy(ubq);
+	return !ublk_support_user_copy(ubq) && !ublk_support_zero_copy(ubq) &&
+		!ublk_support_auto_buf_reg(ubq);
 }
 
 static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
@@ -637,8 +652,13 @@ static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
 	 *
 	 * for zero copy, request buffer need to be registered to io_uring
 	 * buffer table, so reference is needed
+	 *
+	 * For auto buffer register, ublk server still may issue
+	 * UBLK_IO_COMMIT_AND_FETCH_REQ before one registered buffer is used up,
+	 * so reference is required too.
 	 */
-	return ublk_support_user_copy(ubq) || ublk_support_zero_copy(ubq);
+	return ublk_support_user_copy(ubq) || ublk_support_zero_copy(ubq) ||
+		ublk_support_auto_buf_reg(ubq);
 }
 
 static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
@@ -1155,6 +1175,35 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
 		blk_mq_end_request(rq, BLK_STS_IOERR);
 }
 
+static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
+			      unsigned int issue_flags)
+{
+	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
+	int ret;
+
+	ret = io_buffer_register_bvec(io->cmd, req, ublk_io_release, 0,
+				      issue_flags);
+	if (ret) {
+		blk_mq_end_request(req, BLK_STS_IOERR);
+		return false;
+	}
+	/* one extra reference is dropped by ublk_io_release */
+	refcount_set(&data->ref, 2);
+	io->flags |= UBLK_IO_FLAG_AUTO_BUF_REG;
+	return true;
+}
+
+static bool ublk_prep_auto_buf_reg(struct ublk_queue *ubq,
+				   struct request *req, struct ublk_io *io,
+				   unsigned int issue_flags)
+{
+	if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req))
+		return ublk_auto_buf_reg(req, io, issue_flags);
+
+	ublk_init_req_ref(ubq, req);
+	return true;
+}
+
 static bool ublk_start_io(const struct ublk_queue *ubq, struct request *req,
 			  struct ublk_io *io)
 {
@@ -1180,7 +1229,6 @@ static bool ublk_start_io(const struct ublk_queue *ubq, struct request *req,
 			mapped_bytes >> 9;
 	}
 
-	ublk_init_req_ref(ubq, req);
 	return true;
 }
 
@@ -1226,7 +1274,8 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
 	if (!ublk_start_io(ubq, req, io))
 		return;
 
-	ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags);
+	if (ublk_prep_auto_buf_reg(ubq, req, io, issue_flags))
+		ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags);
 }
 
 static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
@@ -1994,7 +2043,8 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 
 static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 				 struct ublk_io *io, struct io_uring_cmd *cmd,
-				 const struct ublksrv_io_cmd *ub_cmd)
+				 const struct ublksrv_io_cmd *ub_cmd,
+				 unsigned int issue_flags)
 {
 	struct request *req = io->req;
 
@@ -2014,6 +2064,14 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 		return -EINVAL;
 	}
 
+	if (ublk_support_auto_buf_reg(ubq)) {
+		if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG) {
+			WARN_ON_ONCE(io_buffer_unregister_bvec(cmd, 0,
+						issue_flags));
+			io->flags &= ~UBLK_IO_FLAG_AUTO_BUF_REG;
+		}
+	}
+
 	ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
 
 	/* now this cmd slot is owned by ublk driver */
@@ -2110,7 +2168,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			goto out;
 		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
-		ret = ublk_commit_and_fetch(ubq, io, cmd, ub_cmd);
+		ret = ublk_commit_and_fetch(ubq, io, cmd, ub_cmd, issue_flags);
 		if (ret)
 			goto out;
 		break;
-- 
2.47.0


