Return-Path: <linux-block+bounces-28923-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8100C0222A
	for <lists+linux-block@lfdr.de>; Thu, 23 Oct 2025 17:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 18BFD34A36C
	for <lists+linux-block@lfdr.de>; Thu, 23 Oct 2025 15:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187933148D9;
	Thu, 23 Oct 2025 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BlTl+g6E"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A659338913
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233587; cv=none; b=oe+MxrcWfjJ6LMJ0Ex4rV+WH9kercN6QpAHcIjsnIQvaWQ7P68dnnV1tQVZ/pN7JbP2qYicw29C7gXdSnoAvVGXHsYTt5XLOBhy1NeCOpGsr/LfvpTff+1vmLSvqgT9mU72FB37ZttEq+IBuoqdyon9o38THPQEL3rhmzEcIoHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233587; c=relaxed/simple;
	bh=XOnMWr4t16md8fLoewGjhY/NY1d9CIDwRBbjPrGqTFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pmqah7ZTYc6Nb+kUvv6dMPwcp+ubG4Mt+F0fvwDglZNjAGnney3IO5qFFVqZo03GVMNon+LEbLVUHLDoPTzNya3hTbc0TLnZMsa5vJKDEOzHvMXN+CqFXAuSZPNSnc/tv+N6tlfCPSU0xj31F8zBHHCL14wIMCKLuQDDM02pUYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BlTl+g6E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761233584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A14wSH4ekHfbCfvJ6luwRkuk7hiJ1ZP69hTp+io0mB0=;
	b=BlTl+g6E36HUp5qp4hM5tTEFxKtu74+UaIW09R5r+2STR5ojwbyQaOcmDIFWS44bJt9EdI
	Zw5qQIgXum7ws7m3yVTteCdkHJpiuWYAoOVUsZ5LzwLIzRAkK/QOsmnU0sSBUQWLQvbEpM
	e4sHM/acOw3goYO0koj3BZaVwEdJ5cQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-AKCXVp80NriYFqP_nzO7Fg-1; Thu,
 23 Oct 2025 11:33:00 -0400
X-MC-Unique: AKCXVp80NriYFqP_nzO7Fg-1
X-Mimecast-MFC-AGG-ID: AKCXVp80NriYFqP_nzO7Fg_1761233579
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97994180035D;
	Thu, 23 Oct 2025 15:32:59 +0000 (UTC)
Received: from localhost (unknown [10.72.120.30])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A5D6180057D;
	Thu, 23 Oct 2025 15:32:58 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 03/25] ublk: refactor auto buffer register in ublk_dispatch_req()
Date: Thu, 23 Oct 2025 23:32:08 +0800
Message-ID: <20251023153234.2548062-4-ming.lei@redhat.com>
In-Reply-To: <20251023153234.2548062-1-ming.lei@redhat.com>
References: <20251023153234.2548062-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Refactor auto buffer register code and prepare for supporting batch IO
feature, and the main motivation is to put 'ublk_io' operation code
together, so that per-io lock can be applied for the code block.

The key changes are:
- Rename ublk_auto_buf_reg() as ublk_do_auto_buf_reg()
- Introduce an enum `auto_buf_reg_res` to represent the result of
  the buffer registration attempt (FAIL, FALLBACK, OK).
- Split the existing `ublk_do_auto_buf_reg` function into two:
  - `__ublk_do_auto_buf_reg`: Performs the actual buffer registration
    and returns the `auto_buf_reg_res` status.
  - `ublk_do_auto_buf_reg`: A wrapper that calls the internal function
    and handles the I/O preparation based on the result.
- Introduce `ublk_prep_auto_buf_reg_io` to encapsulate the logic for
  preparing the I/O for completion after buffer registration.
- Pass the `tag` directly to `ublk_auto_buf_reg_fallback` to avoid
  recalculating it.

This refactoring makes the control flow clearer and isolates the different
stages of the auto buffer registration process.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 64 +++++++++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 21 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index b89acfee46c3..a11ccf3d96d6 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1234,17 +1234,37 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
 }
 
 static void
-ublk_auto_buf_reg_fallback(const struct ublk_queue *ubq, struct ublk_io *io)
+ublk_auto_buf_reg_fallback(const struct ublk_queue *ubq, unsigned tag)
 {
-	unsigned tag = io - ubq->ios;
 	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, tag);
 
 	iod->op_flags |= UBLK_IO_F_NEED_REG_BUF;
 }
 
-static bool ublk_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
-			      struct ublk_io *io, struct io_uring_cmd *cmd,
-			      unsigned int issue_flags)
+enum auto_buf_reg_res {
+	AUTO_BUF_REG_FAIL,
+	AUTO_BUF_REG_FALLBACK,
+	AUTO_BUF_REG_OK,
+};
+
+static void ublk_prep_auto_buf_reg_io(const struct ublk_queue *ubq,
+				      struct request *req, struct ublk_io *io,
+				      struct io_uring_cmd *cmd,
+				      enum auto_buf_reg_res res)
+{
+	if (res == AUTO_BUF_REG_OK) {
+		io->task_registered_buffers = 1;
+		io->buf_ctx_handle = io_uring_cmd_ctx_handle(cmd);
+		io->flags |= UBLK_IO_FLAG_AUTO_BUF_REG;
+	}
+	ublk_init_req_ref(ubq, io);
+	__ublk_prep_compl_io_cmd(io, req);
+}
+
+static enum auto_buf_reg_res
+__ublk_do_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
+		       struct ublk_io *io, struct io_uring_cmd *cmd,
+		       unsigned int issue_flags)
 {
 	int ret;
 
@@ -1252,29 +1272,27 @@ static bool ublk_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
 				      io->buf.auto_reg.index, issue_flags);
 	if (ret) {
 		if (io->buf.auto_reg.flags & UBLK_AUTO_BUF_REG_FALLBACK) {
-			ublk_auto_buf_reg_fallback(ubq, io);
-			return true;
+			ublk_auto_buf_reg_fallback(ubq, req->tag);
+			return AUTO_BUF_REG_FALLBACK;
 		}
 		blk_mq_end_request(req, BLK_STS_IOERR);
-		return false;
+		return AUTO_BUF_REG_FAIL;
 	}
 
-	io->task_registered_buffers = 1;
-	io->buf_ctx_handle = io_uring_cmd_ctx_handle(cmd);
-	io->flags |= UBLK_IO_FLAG_AUTO_BUF_REG;
-	return true;
+	return AUTO_BUF_REG_OK;
 }
 
-static bool ublk_prep_auto_buf_reg(struct ublk_queue *ubq,
-				   struct request *req, struct ublk_io *io,
-				   struct io_uring_cmd *cmd,
-				   unsigned int issue_flags)
+static void ublk_do_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
+				 struct ublk_io *io, struct io_uring_cmd *cmd,
+				 unsigned int issue_flags)
 {
-	ublk_init_req_ref(ubq, io);
-	if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req))
-		return ublk_auto_buf_reg(ubq, req, io, cmd, issue_flags);
+	enum auto_buf_reg_res res = __ublk_do_auto_buf_reg(ubq, req, io, cmd,
+			issue_flags);
 
-	return true;
+	if (res != AUTO_BUF_REG_FAIL) {
+		ublk_prep_auto_buf_reg_io(ubq, req, io, cmd, res);
+		io_uring_cmd_done(cmd, UBLK_IO_RES_OK, issue_flags);
+	}
 }
 
 static bool ublk_start_io(const struct ublk_queue *ubq, struct request *req,
@@ -1347,8 +1365,12 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
 	if (!ublk_start_io(ubq, req, io))
 		return;
 
-	if (ublk_prep_auto_buf_reg(ubq, req, io, io->cmd, issue_flags))
+	if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req)) {
+		ublk_do_auto_buf_reg(ubq, req, io, io->cmd, issue_flags);
+	} else {
+		ublk_init_req_ref(ubq, io);
 		ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags);
+	}
 }
 
 static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
-- 
2.47.0


