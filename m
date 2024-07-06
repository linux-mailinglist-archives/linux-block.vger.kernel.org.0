Return-Path: <linux-block+bounces-9807-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A0792902B
	for <lists+linux-block@lfdr.de>; Sat,  6 Jul 2024 05:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E939283261
	for <lists+linux-block@lfdr.de>; Sat,  6 Jul 2024 03:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83479D29E;
	Sat,  6 Jul 2024 03:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2w6y6pX"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9268C156
	for <linux-block@vger.kernel.org>; Sat,  6 Jul 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720235432; cv=none; b=SzxkNxsTJn4gVlcrwz1DM/V95Wy0lr3heivY5OnVWasy28yHmu2gp2H9zb5ZyfQETdso8yA5wv4A+aeLDSaZ8PloL5FYIDdB2gOzyerkoUIdUnF/BbWPlbV6PMYRkEtEOL8wIerGwYjFsXvXKj8lGCpbDMpu4z6mjX7wZdit5mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720235432; c=relaxed/simple;
	bh=aCa7TGSe2G0qdMBX1NrTEN7tTHsO+fKPEaPpZbJ7zMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2RbEEcKrS7NVvDlvD6IJ60lo3HC7ZEljvqIbRuqAOjjDji/cHtjmPrIAO7afw/Bmu754Pm2IUNMJhXDcVBmpgdTQN2cxGr0Ycbp24CA9bejZsDIvVFxrDdu5EI4JBq/+Jd80Puc7Q4nyoAM9A1izTBjDcyTBLMkqZe4oZikTYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N2w6y6pX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720235428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lbtuv50NovI4isyMvbgXqNXTaGjGObwMNVDL0i0mYiw=;
	b=N2w6y6pXKxb6Rn8z3f1CfdOhTjQHD5OsQjT+Mt2WfF+Up4qM4ENqQCkiyqrGHSqYM/UebE
	H7nFttz1AXmJ4k+PxwvdptnG0XSZbNXmLiTxLWe8NbqLIWjUWvghkFlCCjroJ+mgR0MPA4
	4x2+5mp6SmE6HV0ocG8dsndZ3Ywp1Mg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-xArVi-QOOPKV152hUJfrWg-1; Fri,
 05 Jul 2024 23:10:25 -0400
X-MC-Unique: xArVi-QOOPKV152hUJfrWg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36F8619560AA;
	Sat,  6 Jul 2024 03:10:24 +0000 (UTC)
Received: from localhost (unknown [10.72.112.32])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C445A19560B2;
	Sat,  6 Jul 2024 03:10:22 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 3/8] io_uring: add helper of io_req_commit_cqe()
Date: Sat,  6 Jul 2024 11:09:53 +0800
Message-ID: <20240706031000.310430-4-ming.lei@redhat.com>
In-Reply-To: <20240706031000.310430-1-ming.lei@redhat.com>
References: <20240706031000.310430-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add helper of io_req_commit_cqe() for simplifying
__io_submit_flush_completions() a bit.

No functional change, and the added helper will be reused in
sqe group code with same lock rule.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 io_uring/io_uring.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 5d69851b5131..7597344a6440 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -861,6 +861,20 @@ bool io_req_post_cqe(struct io_kiocb *req, s32 res, u32 cflags)
 	return posted;
 }
 
+static __always_inline void io_req_commit_cqe(struct io_ring_ctx *ctx,
+		struct io_kiocb *req)
+{
+	if (unlikely(!io_fill_cqe_req(ctx, req))) {
+		if (ctx->lockless_cq) {
+			spin_lock(&ctx->completion_lock);
+			io_req_cqe_overflow(req);
+			spin_unlock(&ctx->completion_lock);
+		} else {
+			io_req_cqe_overflow(req);
+		}
+	}
+}
+
 static void io_req_complete_post(struct io_kiocb *req, unsigned issue_flags)
 {
 	struct io_ring_ctx *ctx = req->ctx;
@@ -1413,16 +1427,8 @@ void __io_submit_flush_completions(struct io_ring_ctx *ctx)
 		struct io_kiocb *req = container_of(node, struct io_kiocb,
 					    comp_list);
 
-		if (!(req->flags & REQ_F_CQE_SKIP) &&
-		    unlikely(!io_fill_cqe_req(ctx, req))) {
-			if (ctx->lockless_cq) {
-				spin_lock(&ctx->completion_lock);
-				io_req_cqe_overflow(req);
-				spin_unlock(&ctx->completion_lock);
-			} else {
-				io_req_cqe_overflow(req);
-			}
-		}
+		if (!(req->flags & REQ_F_CQE_SKIP))
+			io_req_commit_cqe(ctx, req);
 	}
 	__io_cq_unlock_post(ctx);
 
-- 
2.42.0


