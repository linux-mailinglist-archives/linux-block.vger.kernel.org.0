Return-Path: <linux-block+bounces-11541-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CA49766E1
	for <lists+linux-block@lfdr.de>; Thu, 12 Sep 2024 12:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E36D1F2404A
	for <lists+linux-block@lfdr.de>; Thu, 12 Sep 2024 10:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B94919F425;
	Thu, 12 Sep 2024 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hp08f/vh"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809B819F139
	for <linux-block@vger.kernel.org>; Thu, 12 Sep 2024 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726138194; cv=none; b=t/Hmc1k7u3d4cribYAw4Ta6cv9scid9pHs/EHxmfwY3NpqgxlrgaN2z3c6EY+b2Q/H/pDnX0B7KHcTYgqikCNbPlZG9/ac5daQh1M3toTS2tqQW4ZMTKeUCaP+Hfb7dbyKVLeRjonunrPsOZPAoXYD20VqzH/pzwMqbWPRDTtPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726138194; c=relaxed/simple;
	bh=XaxwdOgjdkWKSUE8zJ8u8UAZKye2X8zJgrZmNovkZ2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qku7snA8PZJueNuvMLMAPISDny0m5FMfcG/gqxhIUE6wLFOIh+kIDDIvRAx8/BOHhcp4bD4wiSJmyhYsWxS9l5yiSwI6jlMOgUpc4yG3HPmBQMfVbovdRMxwUssrJxgimDylh+XYeE4lrerl0gEdk+vs/DbHu0qjtuNeGYuu9ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hp08f/vh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726138191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/0iP1BENTY5K72gB1fMYsnb/8JIWKFVGQ4vPeQHqIk=;
	b=hp08f/vhcnW3sVTbyZIWYK7uEOf7xXaR3lbabuqNw1iAjb/2Tr9WkMiNzOvyy6wzLt2Zig
	71s6kGApP0sYAfByHqGzlc9/5loUA0YzR8PwQ6ajkt3SL2r9WJ2Gyp/UubD70DPRiSROgj
	D/0KXlvvSiiXyAC0X5q7YfwgiM8WfFs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-GQrN3vguO72P4j3YnIlbVg-1; Thu,
 12 Sep 2024 06:49:48 -0400
X-MC-Unique: GQrN3vguO72P4j3YnIlbVg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 698BA1956083;
	Thu, 12 Sep 2024 10:49:47 +0000 (UTC)
Received: from localhost (unknown [10.72.116.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4018E19560AB;
	Thu, 12 Sep 2024 10:49:45 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 1/8] io_uring: add io_link_req() helper
Date: Thu, 12 Sep 2024 18:49:21 +0800
Message-ID: <20240912104933.1875409-2-ming.lei@redhat.com>
In-Reply-To: <20240912104933.1875409-1-ming.lei@redhat.com>
References: <20240912104933.1875409-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add io_link_req() helper, so that io_submit_sqe() can become more
readable.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 io_uring/io_uring.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 1aca501efaf6..8ed4f40470e3 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2132,19 +2132,11 @@ static __cold int io_submit_fail_init(const struct io_uring_sqe *sqe,
 	return 0;
 }
 
-static inline int io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
-			 const struct io_uring_sqe *sqe)
-	__must_hold(&ctx->uring_lock)
+/*
+ * Return NULL if nothing to be queued, otherwise return request for queueing */
+static struct io_kiocb *io_link_sqe(struct io_submit_link *link,
+				    struct io_kiocb *req)
 {
-	struct io_submit_link *link = &ctx->submit_state.link;
-	int ret;
-
-	ret = io_init_req(ctx, req, sqe);
-	if (unlikely(ret))
-		return io_submit_fail_init(sqe, req, ret);
-
-	trace_io_uring_submit_req(req);
-
 	/*
 	 * If we already have a head request, queue this one for async
 	 * submittal once the head completes. If we don't have a head but
@@ -2158,7 +2150,7 @@ static inline int io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		link->last = req;
 
 		if (req->flags & IO_REQ_LINK_FLAGS)
-			return 0;
+			return NULL;
 		/* last request of the link, flush it */
 		req = link->head;
 		link->head = NULL;
@@ -2174,9 +2166,30 @@ static inline int io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 fallback:
 			io_queue_sqe_fallback(req);
 		}
-		return 0;
+		return NULL;
 	}
+	return req;
+}
+
+static inline int io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
+			 const struct io_uring_sqe *sqe)
+	__must_hold(&ctx->uring_lock)
+{
+	struct io_submit_link *link = &ctx->submit_state.link;
+	int ret;
 
+	ret = io_init_req(ctx, req, sqe);
+	if (unlikely(ret))
+		return io_submit_fail_init(sqe, req, ret);
+
+	trace_io_uring_submit_req(req);
+
+	if (unlikely(link->head || (req->flags & (IO_REQ_LINK_FLAGS |
+				    REQ_F_FORCE_ASYNC | REQ_F_FAIL)))) {
+		req = io_link_sqe(link, req);
+		if (!req)
+			return 0;
+	}
 	io_queue_sqe(req);
 	return 0;
 }
-- 
2.42.0


