Return-Path: <linux-block+bounces-13617-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD18E9BE8D3
	for <lists+linux-block@lfdr.de>; Wed,  6 Nov 2024 13:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54C81C212DB
	for <lists+linux-block@lfdr.de>; Wed,  6 Nov 2024 12:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7081DF995;
	Wed,  6 Nov 2024 12:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPLV+QRP"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D651DFD84
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896066; cv=none; b=PpgXq00oLjU91KAahIu7sjopE8P4yGsbk+WDJbS+92t+Jtej0ArtaoVG5QzlWM7C3KiImqFkSNEfaYIDnc0lUGTer29Nleph/iD+NfJBa/BFd8RZ15plhI14aFOwt9hQxGcyFzXScuw8iSNzp338hte9cRcyx4ghZXIXm1WR7Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896066; c=relaxed/simple;
	bh=ef9QRRM73LFQtxlW0meSWrPeRjCZELXcD6HSWOHesh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dtj3FI4SI4y7lRkRyWHbMi+F+euPZkQnMWyus7Vcjs2wW0bXd3nNrVwOKNGPAkWSMxW+bo2Cqj8yWrPafCuvfJk7hUm7Nn01Roho5a8speLgU1b58Gt+8K6Yal4nb5f6L+iBIWF7tDiaHRbnTAizfLL5efm5tA0sY+4QwFhb6o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XPLV+QRP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4/rwFt4byI/RP9SWAIWNPx5U2cnvRwoR2eVyqA6RWuE=;
	b=XPLV+QRPfPx0/Q+6HjQq/zwbS5jEjaYnNXdMRDEbkNtxTU23fbcrL8+UDlAn0mxEoCAmJY
	wSqHInDPw3IK8+sE6/askUG+pE8Qe+q70Vn37gvwpY64TUpd6LPBsOS6u9hRnAC+cyCx1E
	Jp54V/JyPDqgSNLe3WC8wXP2/nAMBHs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-vxpMDMu-Me2SgOZAagQJTw-1; Wed,
 06 Nov 2024 07:27:39 -0500
X-MC-Unique: vxpMDMu-Me2SgOZAagQJTw-1
X-Mimecast-MFC-AGG-ID: vxpMDMu-Me2SgOZAagQJTw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0EC761955BEE;
	Wed,  6 Nov 2024 12:27:37 +0000 (UTC)
Received: from localhost (unknown [10.72.116.107])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 139721956088;
	Wed,  6 Nov 2024 12:27:35 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Akilesh Kailash <akailash@google.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V9 6/7] io_uring/uring_cmd: support leasing device kernel buffer to io_uring
Date: Wed,  6 Nov 2024 20:26:55 +0800
Message-ID: <20241106122659.730712-7-ming.lei@redhat.com>
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

Add API of io_uring_cmd_lease_kbuf() for driver to lease its kernel
buffer to io_uring.

The leased buffer can only be consumed by io_uring OPs in group wide,
and the uring_cmd has to be one group leader.

This way can support generic device zero copy over device buffer in
userspace:

- create one sqe group
- lease one device buffer to io_uring by the group leader of uring_cmd
- io_uring member OPs consume this kernel buffer by passing IOSQE_IO_DRAIN
  which isn't used for group member, and mapped to GROUP_BUF.
- the kernel buffer is returned back after all member OPs are completed

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/io_uring/cmd.h |  7 +++++++
 io_uring/uring_cmd.c         | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 578a3fdf5c71..8a6f1db1ca84 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -60,6 +60,8 @@ void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
 /* Execute the request from a blocking context */
 void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd);
 
+int io_uring_cmd_lease_kbuf(struct io_uring_cmd *ioucmd,
+		const struct io_mapped_buf *grp_kbuf);
 #else
 static inline int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      struct iov_iter *iter, void *ioucmd)
@@ -82,6 +84,11 @@ static inline void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
 static inline void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd)
 {
 }
+static inline int io_uring_cmd_lease_kbuf(struct io_uring_cmd *ioucmd,
+		const struct io_mapped_buf *grp_kbuf)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 /*
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 40b8b777ba12..5d59183212f6 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -15,6 +15,7 @@
 #include "alloc_cache.h"
 #include "rsrc.h"
 #include "uring_cmd.h"
+#include "kbuf.h"
 
 static struct uring_cache *io_uring_async_get(struct io_kiocb *req)
 {
@@ -175,6 +176,15 @@ void io_uring_cmd_done(struct io_uring_cmd *ioucmd, ssize_t ret, ssize_t res2,
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_done);
 
+int io_uring_cmd_lease_kbuf(struct io_uring_cmd *ioucmd,
+			    const struct io_mapped_buf *grp_kbuf)
+{
+	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+
+	return io_lease_group_kbuf(req, grp_kbuf);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_lease_kbuf);
+
 static int io_uring_cmd_prep_setup(struct io_kiocb *req,
 				   const struct io_uring_sqe *sqe)
 {
-- 
2.47.0


