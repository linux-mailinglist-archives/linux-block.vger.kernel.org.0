Return-Path: <linux-block+bounces-7267-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC288C2DD4
	for <lists+linux-block@lfdr.de>; Sat, 11 May 2024 02:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52921F21850
	for <lists+linux-block@lfdr.de>; Sat, 11 May 2024 00:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541521109;
	Sat, 11 May 2024 00:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rb7D4Q43"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B0210F4
	for <linux-block@vger.kernel.org>; Sat, 11 May 2024 00:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715386364; cv=none; b=nKiSctiYsgAmLh2a74vLwtyE5PJB1x6cvXm2h4kFGqz5f7bxNzLQxwsvVvqW0CW215KJwKxUW0gwFUD+xo2seCjrpr7karOpNg/KewwiINndIU2KeJ5P7SkkcQ9QzYKbIqer+bBrTIXfYGpbeT5v1Sw5qWxwOU+S7ZAe1D23/+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715386364; c=relaxed/simple;
	bh=jxHgMM5fF1aPJtUQC3QbqJ1sUIh/mw6qszEyfKsRtzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuPGxUup/sfmDTvrrwEIFCV7GZyZLP5yPKW02eHeuIg+N8LgETTGYK0zInHr0Q25WUR0/mIqMavQGCfhS2LfmUG/sNCYapj0O1/IQCMNzt+l3HDEc8S42IW6KtmfxoGFYvHgmoly20cgmcxMFZI+C3dJ49hAwwFupy9pVSwVWSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rb7D4Q43; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715386361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TrgPfpcrRc09tnbLEWPeSPT7KeBHVt0OIaxEmJNBJNE=;
	b=Rb7D4Q43rLgQc3bFapUUeBJNZkwJ4qcu2Xfs5TFv1DODltn2BTn+gp9geObvtqNUYSvjs8
	CJoQ5v3xCIZIyfHNJ2yUDgSiPiuIZTu1XN8Pb1phduZqHs+cHRs8eh/d88/IJcBQdO1MOx
	goBpnQCDqkt+IMAdJURn2O624xDdHL0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-FF0K8aZVNDq2pyCNKJP7Vg-1; Fri,
 10 May 2024 20:12:36 -0400
X-MC-Unique: FF0K8aZVNDq2pyCNKJP7Vg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4757C3806738;
	Sat, 11 May 2024 00:12:36 +0000 (UTC)
Received: from localhost (unknown [10.72.116.30])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4BCA644E3AFA;
	Sat, 11 May 2024 00:12:34 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 4/9] io_uring: move marking REQ_F_CQE_SKIP out of io_free_req()
Date: Sat, 11 May 2024 08:12:07 +0800
Message-ID: <20240511001214.173711-5-ming.lei@redhat.com>
In-Reply-To: <20240511001214.173711-1-ming.lei@redhat.com>
References: <20240511001214.173711-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Prepare for supporting sqe group, which requires to post group leader's
CQE after all members' CQEs are posted. For group leader request, we can't
do that in io_req_complete_post, and REQ_F_CQE_SKIP can't be set in
io_free_req().

So move marking REQ_F_CQE_SKIP out of io_free_req().

No functional change.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 io_uring/io_uring.c | 5 +++--
 io_uring/timeout.c  | 3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index e4be930e0f1e..c184c9a312df 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1027,8 +1027,6 @@ __cold void io_free_req(struct io_kiocb *req)
 {
 	/* refs were already put, restore them for io_req_task_complete() */
 	req->flags &= ~REQ_F_REFCOUNT;
-	/* we only want to free it, don't post CQEs */
-	req->flags |= REQ_F_CQE_SKIP;
 	req->io_task_work.func = io_req_task_complete;
 	io_req_task_work_add(req);
 }
@@ -1797,6 +1795,9 @@ struct io_wq_work *io_wq_free_work(struct io_wq_work *work)
 	if (req_ref_put_and_test(req)) {
 		if (req->flags & IO_REQ_LINK_FLAGS)
 			nxt = io_req_find_next(req);
+
+		/* we have posted CQEs in io_req_complete_post() */
+		req->flags |= REQ_F_CQE_SKIP;
 		io_free_req(req);
 	}
 	return nxt ? &nxt->work : NULL;
diff --git a/io_uring/timeout.c b/io_uring/timeout.c
index 1c9bf07499b1..202f540aa314 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -47,6 +47,9 @@ static inline void io_put_req(struct io_kiocb *req)
 {
 	if (req_ref_put_and_test(req)) {
 		io_queue_next(req);
+
+		/* we only want to free it, don't post CQEs */
+		req->flags |= REQ_F_CQE_SKIP;
 		io_free_req(req);
 	}
 }
-- 
2.42.0


