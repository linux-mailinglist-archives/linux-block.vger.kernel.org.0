Return-Path: <linux-block+bounces-13688-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA839C0320
	for <lists+linux-block@lfdr.de>; Thu,  7 Nov 2024 12:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44AC11F2355F
	for <lists+linux-block@lfdr.de>; Thu,  7 Nov 2024 11:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12FD13C682;
	Thu,  7 Nov 2024 11:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K389T0VA"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1033C1EF0A4
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977341; cv=none; b=MER61XDgxtT6+oRaEPSHNLyXOhIohbmPTyMboayDoY3Yu4FtUNfRRrd47eDaEF0TWYJ9G9EkyPMKlSR3JXgHjL1Kdn8j7KSD9C6Fw3qq0qM1j4MXocjTEHrlkW+wRpalePYWUFZVT+H/TRjVMjEZs1bIscs6RiVteI581+5AlZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977341; c=relaxed/simple;
	bh=NsZ1msBsSYLL/eepZldaM7VPRfAR3s7KkSdOQlyHAYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Il8TB1fqixPruHuE3y1Xh8g3t/JdPSHCv9dkQoNIyYwK4l6X58Z0VQ7IJoHnJHANAODo5Jf43+wxslgttJHmFl8OYzwTViAomGtrJHI0cRHUh/eW5tzkiAmqE1YaPZjeANxMp41tUd3lHia8NOfPHXx5HoZ3Wkb0kkXyF/Mi36U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K389T0VA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730977339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rsB2O5a+Xy5ldSEadpiS1OiDWOLSJfk5jFl4Okpjsxs=;
	b=K389T0VAAi1OG4WJpz1pEBlpYm3BRIRPst/7IPmOGmokVwwZAqIw3uRyW6i/JzyP7WpVAR
	kXxhVPCvGj+NMQqd/K0C8yO40fb5muukx3DyoATbaQVNFnLoWiWrMGZzDQeXdDJ60v9HnO
	aYRt//CHfX9v/QlneiRBv4/kKZUuteQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-Ec1vTrEiNq2DY45L4bO7jw-1; Thu,
 07 Nov 2024 06:02:18 -0500
X-MC-Unique: Ec1vTrEiNq2DY45L4bO7jw-1
X-Mimecast-MFC-AGG-ID: Ec1vTrEiNq2DY45L4bO7jw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8A621955EE8;
	Thu,  7 Nov 2024 11:02:16 +0000 (UTC)
Received: from localhost (unknown [10.72.116.54])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B3424196BC05;
	Thu,  7 Nov 2024 11:02:15 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Akilesh Kailash <akailash@google.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V10 04/12] io_uring/rsrc: prepare for supporting external 'io_rsrc_node'
Date: Thu,  7 Nov 2024 19:01:37 +0800
Message-ID: <20241107110149.890530-5-ming.lei@redhat.com>
In-Reply-To: <20241107110149.890530-1-ming.lei@redhat.com>
References: <20241107110149.890530-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Now 'io_rsrc_node' is just one buffer, and it may be provided from
other subsystem, such as the coming group kernel buffer.

So add flag IORING_RSRC_F_NEED_FREE for external 'io_rsrc_node'.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 io_uring/rsrc.c | 12 +++++++-----
 io_uring/rsrc.h | 15 ++++++++++++++-
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index adaae8630932..db5d917081b1 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -123,10 +123,9 @@ struct io_rsrc_node *io_rsrc_node_alloc(struct io_ring_ctx *ctx, int type)
 	struct io_rsrc_node *node;
 
 	node = kzalloc(sizeof(*node), GFP_KERNEL);
-	if (node) {
-		node->type = type;
-		node->refs = 1;
-	}
+	if (node)
+		io_rsrc_node_init(node, type, IORING_RSRC_F_NEED_FREE);
+
 	return node;
 }
 
@@ -444,6 +443,8 @@ int io_files_update(struct io_kiocb *req, unsigned int issue_flags)
 
 void io_free_rsrc_node(struct io_ring_ctx *ctx, struct io_rsrc_node *node)
 {
+	bool need_free = node->flags & IORING_RSRC_F_NEED_FREE;
+
 	lockdep_assert_held(&ctx->uring_lock);
 
 	if (node->tag)
@@ -463,7 +464,8 @@ void io_free_rsrc_node(struct io_ring_ctx *ctx, struct io_rsrc_node *node)
 		break;
 	}
 
-	kfree(node);
+	if (need_free)
+		kfree(node);
 }
 
 int io_sqe_files_unregister(struct io_ring_ctx *ctx)
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 7a4668deaa1a..582a69adfdc9 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -10,11 +10,15 @@
 
 enum {
 	IORING_RSRC_FILE		= 0,
-	IORING_RSRC_BUFFER		= 1,
+	IORING_RSRC_BUFFER,
+	__IORING_RSRC_LAST_TYPE,
+
+	IORING_RSRC_F_NEED_FREE		= 1 << 0,
 };
 
 struct io_rsrc_node {
 	unsigned char			type;
+	unsigned char			flags;
 	int				refs;
 
 	u64 tag;
@@ -66,6 +70,15 @@ int io_register_rsrc_update(struct io_ring_ctx *ctx, void __user *arg,
 int io_register_rsrc(struct io_ring_ctx *ctx, void __user *arg,
 			unsigned int size, unsigned int type);
 
+static inline void io_rsrc_node_init(struct io_rsrc_node *node, int type,
+				     unsigned char flags)
+{
+	WARN_ON_ONCE(type >= __IORING_RSRC_LAST_TYPE);
+
+	node->type = type;
+	node->refs = 1;
+	node->flags = flags;
+}
 static inline struct io_rsrc_node *io_rsrc_node_lookup(struct io_rsrc_data *data,
 						       int index)
 {
-- 
2.47.0


