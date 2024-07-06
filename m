Return-Path: <linux-block+bounces-9811-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D7B929033
	for <lists+linux-block@lfdr.de>; Sat,  6 Jul 2024 05:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E0531F22039
	for <lists+linux-block@lfdr.de>; Sat,  6 Jul 2024 03:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6154AEAE9;
	Sat,  6 Jul 2024 03:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayFtvqMw"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74D7E556
	for <linux-block@vger.kernel.org>; Sat,  6 Jul 2024 03:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720235451; cv=none; b=XQa9Hrd0IITiv7p1IurHJUFQAtIY9eh6e49N6Nf6HfSrvrdw3ckMr3Xz5KVj8MOyXNDWYB1DHTzeFZEYivuoplVWfgYfSVygdBLGZAplJ62V62WA/f/cs31ECGSiz2s0bWlQ7blQJDeP2mQsjO1ne2h8aJgoWin406lyX5pSdn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720235451; c=relaxed/simple;
	bh=WB2TAsR9t9tFY7b5vDU3XxkWa0t4lpjwokizquOTH5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PM1lJH/hKYRSEIYgYG05d/4noj5iCdF295SICEGnGU0DMU1Dk/uxNghHMJ+9GY/CwMS3nX8nQ3o9eapv35Ut+gFu2opsVEsGpDvRF8I/MYBhnQZ2A0k15yVI6DeSyswxRBOzzsg9bXmQIM/Dk+1oqemwMpDw6RtA2XnotCyWtJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ayFtvqMw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720235449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2dmOIBGcVq8OHcWfQPDHyT8cisdg+D9DazHiX31sfaI=;
	b=ayFtvqMwj0RNAEL/uOESugR4RsgNVW8kbjwdZfJq/eTV76JvkU3xJ+FHPu4IMPKZEX7PBJ
	PIzJsXtA3GC+TalJozbCHCyi58MV6sHkzFsTVhmtd8Vuf7b3JwS3m8p6j8dXPGP74bMx7Z
	iRPiZIEY5uqtX/zxASrxxcp3n01W748=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-b3ayfIBHOkSiGTcn_zytFA-1; Fri,
 05 Jul 2024 23:10:44 -0400
X-MC-Unique: b3ayfIBHOkSiGTcn_zytFA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C579819560AA;
	Sat,  6 Jul 2024 03:10:43 +0000 (UTC)
Received: from localhost (unknown [10.72.112.32])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 58EE61955F40;
	Sat,  6 Jul 2024 03:10:41 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 7/8] io_uring/uring_cmd: support provide group kernel buffer
Date: Sat,  6 Jul 2024 11:09:57 +0800
Message-ID: <20240706031000.310430-8-ming.lei@redhat.com>
In-Reply-To: <20240706031000.310430-1-ming.lei@redhat.com>
References: <20240706031000.310430-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Allow uring command to be group leader for providing kernel buffer,
and this way can support generic device zero copy over device buffer.

The following patch will use the way to support zero copy for ublk.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/io_uring/cmd.h  |  7 +++++++
 include/uapi/linux/io_uring.h |  7 ++++++-
 io_uring/uring_cmd.c          | 28 ++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 447fbfd32215..fde3a2ec7d9a 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -48,6 +48,8 @@ void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
 void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
 		unsigned int issue_flags);
 
+int io_uring_cmd_provide_kbuf(struct io_uring_cmd *ioucmd,
+		const struct io_uring_kernel_buf *grp_kbuf);
 #else
 static inline int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      struct iov_iter *iter, void *ioucmd)
@@ -67,6 +69,11 @@ static inline void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
 }
+static inline int io_uring_cmd_provide_kbuf(struct io_uring_cmd *ioucmd,
+		const struct io_uring_kernel_buf *grp_kbuf)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 /*
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index e6d321b3add7..2e1f33aeea2e 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -271,9 +271,14 @@ enum io_uring_op {
  * sqe->uring_cmd_flags		top 8bits aren't available for userspace
  * IORING_URING_CMD_FIXED	use registered buffer; pass this flag
  *				along with setting sqe->buf_index.
+ * IORING_PROVIDE_GROUP_KBUF	this command provides group kernel buffer
+ *				for member requests which can retrieve
+ *				any sub-buffer with offset(sqe->addr) and
+ *				len(sqe->len)
  */
 #define IORING_URING_CMD_FIXED	(1U << 0)
-#define IORING_URING_CMD_MASK	IORING_URING_CMD_FIXED
+#define IORING_PROVIDE_GROUP_KBUF	(1U << 1)
+#define IORING_URING_CMD_MASK	(IORING_URING_CMD_FIXED | IORING_PROVIDE_GROUP_KBUF)
 
 
 /*
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 21ac5fb2d5f0..14744eac9158 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -15,6 +15,7 @@
 #include "alloc_cache.h"
 #include "rsrc.h"
 #include "uring_cmd.h"
+#include "kbuf.h"
 
 static struct uring_cache *io_uring_async_get(struct io_kiocb *req)
 {
@@ -175,6 +176,26 @@ void io_uring_cmd_done(struct io_uring_cmd *ioucmd, ssize_t ret, ssize_t res2,
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_done);
 
+/*
+ * Provide kernel buffer for sqe group members to consume, and the caller
+ * has to guarantee that the provided buffer and the callback are valid
+ * until the callback is called.
+ */
+int io_uring_cmd_provide_kbuf(struct io_uring_cmd *ioucmd,
+		const struct io_uring_kernel_buf *grp_kbuf)
+{
+	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+
+	if (unlikely(!(ioucmd->flags & IORING_PROVIDE_GROUP_KBUF)))
+		return -EINVAL;
+
+	if (unlikely(!req_support_group_dep(req)))
+		return -EINVAL;
+
+	return io_provide_group_kbuf(req, grp_kbuf);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_provide_kbuf);
+
 static int io_uring_cmd_prep_setup(struct io_kiocb *req,
 				   const struct io_uring_sqe *sqe)
 {
@@ -207,6 +228,13 @@ int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	if (ioucmd->flags & ~IORING_URING_CMD_MASK)
 		return -EINVAL;
 
+	if (ioucmd->flags & IORING_PROVIDE_GROUP_KBUF) {
+		/* LEADER flag isn't set yet, so check GROUP only */
+		if (!(req->flags & REQ_F_SQE_GROUP))
+			return -EINVAL;
+		req->flags |= REQ_F_SQE_GROUP_DEP;
+	}
+
 	if (ioucmd->flags & IORING_URING_CMD_FIXED) {
 		struct io_ring_ctx *ctx = req->ctx;
 		u16 index;
-- 
2.42.0


