Return-Path: <linux-block+bounces-13612-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F0D9BE8C1
	for <lists+linux-block@lfdr.de>; Wed,  6 Nov 2024 13:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCB91F220DC
	for <lists+linux-block@lfdr.de>; Wed,  6 Nov 2024 12:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD23318C00E;
	Wed,  6 Nov 2024 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iag1CtUd"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9AA1DDA15
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896043; cv=none; b=EXqwNgYzYCBfQjy21Jn7t1YS+rEHZmRWYQCJkNq7aLSMKJVXTVJMExAqWyc3VWG8dn0juui0ISYVEf2twNrz2kzKIRgaFEmYmNQChyArE+hHIHoh4Pr5VxD5uG8GddvB4AJYA17zXrA5ZUM9mPHb6mfAy+2qWu0Cx6OiQiuYd+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896043; c=relaxed/simple;
	bh=cx69wQ58LbhzH3xwzCYAeiEvLLlkfUyXhMvHWWB9JlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azIwhhZK+Ru08O5XU0FDaQc0WUdnAdQKb2lCKf892KWiSfmlq/CRyx9EBx/UobGTU1T2IZpR2FUmuaQHRaGkkBdi6s5BRS8b/ZeVonuSSzti3n0K3QXLwj2aNgWTnlTU0ikVgMLy20dqtPODTUr6XmzVGOjmmhrJ0WaXxxT6bQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iag1CtUd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPw2kmEX5kl0FyN/JZb5DZTJ8S+p2c666XJCyJVZx5M=;
	b=Iag1CtUdjHRLaeHDxgIm+M+fFyAdV/r+uSJOVOPjCB6ssAwtCdOhC+6XuUBvHYATvM9aVO
	BFMuUbQGsbAVX3DprIsvsOdPze3XwTfImk3JdWoW+G97Kw3O5IPDoDDSFvoIRgOGs824o8
	TKegtGaPOYWxGbD7nF+n+m8TMhP9/EI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-dSeFhuJBOVCPnwExNGN7fw-1; Wed,
 06 Nov 2024 07:27:16 -0500
X-MC-Unique: dSeFhuJBOVCPnwExNGN7fw-1
X-Mimecast-MFC-AGG-ID: dSeFhuJBOVCPnwExNGN7fw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73DAC1944D16;
	Wed,  6 Nov 2024 12:27:15 +0000 (UTC)
Received: from localhost (unknown [10.72.116.107])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 761C91956088;
	Wed,  6 Nov 2024 12:27:13 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Akilesh Kailash <akailash@google.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V9 1/7] io_uring: rename io_mapped_ubuf as io_mapped_buf
Date: Wed,  6 Nov 2024 20:26:50 +0800
Message-ID: <20241106122659.730712-2-ming.lei@redhat.com>
In-Reply-To: <20241106122659.730712-1-ming.lei@redhat.com>
References: <20241106122659.730712-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Rename io_mapped_ubuf so that the same structure can be used for
describing kernel buffer.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 io_uring/fdinfo.c |  2 +-
 io_uring/rsrc.c   | 10 +++++-----
 io_uring/rsrc.h   |  6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/io_uring/fdinfo.c b/io_uring/fdinfo.c
index b214e5a407b5..9ca95f877312 100644
--- a/io_uring/fdinfo.c
+++ b/io_uring/fdinfo.c
@@ -218,7 +218,7 @@ __cold void io_uring_show_fdinfo(struct seq_file *m, struct file *file)
 	}
 	seq_printf(m, "UserBufs:\t%u\n", ctx->buf_table.nr);
 	for (i = 0; has_lock && i < ctx->buf_table.nr; i++) {
-		struct io_mapped_ubuf *buf = NULL;
+		struct io_mapped_buf *buf = NULL;
 
 		if (ctx->buf_table.nodes[i])
 			buf = ctx->buf_table.nodes[i]->buf;
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 2fb1791d7255..70dba4a4de1d 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -106,7 +106,7 @@ static void io_buffer_unmap(struct io_ring_ctx *ctx, struct io_rsrc_node *node)
 	unsigned int i;
 
 	if (node->buf) {
-		struct io_mapped_ubuf *imu = node->buf;
+		struct io_mapped_buf *imu = node->buf;
 
 		if (!refcount_dec_and_test(&imu->refs))
 			return;
@@ -580,7 +580,7 @@ static bool headpage_already_acct(struct io_ring_ctx *ctx, struct page **pages,
 	/* check previously registered pages */
 	for (i = 0; i < ctx->buf_table.nr; i++) {
 		struct io_rsrc_node *node = ctx->buf_table.nodes[i];
-		struct io_mapped_ubuf *imu;
+		struct io_mapped_buf *imu;
 
 		if (!node)
 			continue;
@@ -597,7 +597,7 @@ static bool headpage_already_acct(struct io_ring_ctx *ctx, struct page **pages,
 }
 
 static int io_buffer_account_pin(struct io_ring_ctx *ctx, struct page **pages,
-				 int nr_pages, struct io_mapped_ubuf *imu,
+				 int nr_pages, struct io_mapped_buf *imu,
 				 struct page **last_hpage)
 {
 	int i, ret;
@@ -724,7 +724,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 						   struct iovec *iov,
 						   struct page **last_hpage)
 {
-	struct io_mapped_ubuf *imu = NULL;
+	struct io_mapped_buf *imu = NULL;
 	struct page **pages = NULL;
 	struct io_rsrc_node *node;
 	unsigned long off;
@@ -866,7 +866,7 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 }
 
 int io_import_fixed(int ddir, struct iov_iter *iter,
-			   struct io_mapped_ubuf *imu,
+			   struct io_mapped_buf *imu,
 			   u64 buf_addr, size_t len)
 {
 	u64 buf_end;
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index bc3a863b14bb..9d55f9769c77 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -22,11 +22,11 @@ struct io_rsrc_node {
 	u64 tag;
 	union {
 		unsigned long file_ptr;
-		struct io_mapped_ubuf *buf;
+		struct io_mapped_buf *buf;
 	};
 };
 
-struct io_mapped_ubuf {
+struct io_mapped_buf {
 	u64		ubuf;
 	unsigned int	len;
 	unsigned int	nr_bvecs;
@@ -50,7 +50,7 @@ void io_rsrc_data_free(struct io_rsrc_data *data);
 int io_rsrc_data_alloc(struct io_rsrc_data *data, unsigned nr);
 
 int io_import_fixed(int ddir, struct iov_iter *iter,
-			   struct io_mapped_ubuf *imu,
+			   struct io_mapped_buf *imu,
 			   u64 buf_addr, size_t len);
 
 int io_register_clone_buffers(struct io_ring_ctx *ctx, void __user *arg);
-- 
2.47.0


