Return-Path: <linux-block+bounces-17816-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384A1A48BD8
	for <lists+linux-block@lfdr.de>; Thu, 27 Feb 2025 23:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BAB516EE56
	for <lists+linux-block@lfdr.de>; Thu, 27 Feb 2025 22:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7752D27FE85;
	Thu, 27 Feb 2025 22:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="RWt2pHWc"
X-Original-To: linux-block@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E70126E96F
	for <linux-block@vger.kernel.org>; Thu, 27 Feb 2025 22:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695992; cv=none; b=YV4xCLSnS/rFEDMA7HHg87/tNo108Jf/35yjN4GUlRFDUpDPc0g5ka0xkDbNvDHtDzOHf/VA7xo4HXPUmMKrum/pq9wPE701A0clHw0EIvfuIRfvgPFJEUISBwvtR0wavbqxOD5gYJLnWU3B+9mTPV33JMg4Xg/DEk4H/xDfhFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695992; c=relaxed/simple;
	bh=k7dm2mYm+tEvw2wjaJRDLcdLZPDwdFZt1/ZEhdyjjqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FV/KFkixU+ofpTC2XoxqUFyyDMJIUaQO0LOpO15yYWnd24a/lQ/9sjU8MV98akfKTbbKeW8j666U0UIW7q7ZNHcRta6eOfXPSC94ff8i+zvyPv5XraHH/MDG9G8dv/1KZh2V8CGY/QWOsuWbkNbTIgsU9/cCvLpwWwUYhOB9kRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RWt2pHWc; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RMdhwp011846
	for <linux-block@vger.kernel.org>; Thu, 27 Feb 2025 14:39:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=Oz2RWLCKlHp+FkPvD5TrQfmOyHekSvWyNtpF3IJ/nNs=; b=RWt2pHWcTnAI
	q0UTWv2qYlVNG84RUYWHmHqI0jBZYi87ShcebDLa1k1lWt/gQtcY1Kq1oc3anOps
	XhvHb6WfN3RH9OZvxmx9aKFpGnhDzELYziYVUf0BLHHK0SrMJ31ahej4AZNduqFU
	1ViNj5J0jY70QhQNO4XMQn8ifPHR0BOImONnnl+Pgp4Q7VoCrb9PjERmGRLohS7O
	I4LgKxO+Wi1bNlOLlVb0bUhKe8LTtk2x1XFiEvEDbv2lGwleJgpSA1eTYkziAf4a
	rCF2Kx8nookQZD2YaSgmQlgsY98Mf1zE6jc6NElcVxbngSTqS/peJYI/zKhywPkr
	xKXGj4r4ng==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 452wtb9nw9-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 27 Feb 2025 14:39:49 -0800 (PST)
Received: from twshared32179.32.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 27 Feb 2025 22:39:13 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 844791888280D; Thu, 27 Feb 2025 14:39:17 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <ming.lei@redhat.com>, <axboe@kernel.dk>, <asml.silence@gmail.com>,
        <linux-block@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <linux-nvme@lists.infradead.org>, <csander@purestorage.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv8 2/6] io_uring/rw: move fixed buffer import to issue path
Date: Thu, 27 Feb 2025 14:39:12 -0800
Message-ID: <20250227223916.143006-3-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250227223916.143006-1-kbusch@meta.com>
References: <20250227223916.143006-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: BJkvnmCARnoqyNXBXNG_UtkReWVfUJvX
X-Proofpoint-ORIG-GUID: BJkvnmCARnoqyNXBXNG_UtkReWVfUJvX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01

From: Keith Busch <kbusch@kernel.org>

Registered buffers may depend on a linked command, which makes the prep
path too early to import. Move to the issue path when the node is
actually needed like all the other users of fixed buffers.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 io_uring/opdef.c |  4 ++--
 io_uring/rw.c    | 39 ++++++++++++++++++++++++++++++---------
 io_uring/rw.h    |  2 ++
 3 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index 89f50ecadeaf3..9511262c513e4 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -105,7 +105,7 @@ const struct io_issue_def io_issue_defs[] =3D {
 		.iopoll_queue		=3D 1,
 		.async_size		=3D sizeof(struct io_async_rw),
 		.prep			=3D io_prep_read_fixed,
-		.issue			=3D io_read,
+		.issue			=3D io_read_fixed,
 	},
 	[IORING_OP_WRITE_FIXED] =3D {
 		.needs_file		=3D 1,
@@ -119,7 +119,7 @@ const struct io_issue_def io_issue_defs[] =3D {
 		.iopoll_queue		=3D 1,
 		.async_size		=3D sizeof(struct io_async_rw),
 		.prep			=3D io_prep_write_fixed,
-		.issue			=3D io_write,
+		.issue			=3D io_write_fixed,
 	},
 	[IORING_OP_POLL_ADD] =3D {
 		.needs_file		=3D 1,
diff --git a/io_uring/rw.c b/io_uring/rw.c
index b21b423b3cf8f..7bc23802a388e 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -357,31 +357,30 @@ int io_prep_writev(struct io_kiocb *req, const stru=
ct io_uring_sqe *sqe)
 	return io_prep_rwv(req, sqe, ITER_SOURCE);
 }
=20
-static int io_prep_rw_fixed(struct io_kiocb *req, const struct io_uring_=
sqe *sqe,
+static int io_init_rw_fixed(struct io_kiocb *req, unsigned int issue_fla=
gs,
 			    int ddir)
 {
 	struct io_rw *rw =3D io_kiocb_to_cmd(req, struct io_rw);
-	struct io_async_rw *io;
+	struct io_async_rw *io =3D req->async_data;
 	int ret;
=20
-	ret =3D __io_prep_rw(req, sqe, ddir);
-	if (unlikely(ret))
-		return ret;
+	if (io->bytes_done)
+		return 0;
=20
-	io =3D req->async_data;
-	ret =3D io_import_reg_buf(req, &io->iter, rw->addr, rw->len, ddir, 0);
+	ret =3D io_import_reg_buf(req, &io->iter, rw->addr, rw->len, ddir,
+				issue_flags);
 	iov_iter_save_state(&io->iter, &io->iter_state);
 	return ret;
 }
=20
 int io_prep_read_fixed(struct io_kiocb *req, const struct io_uring_sqe *=
sqe)
 {
-	return io_prep_rw_fixed(req, sqe, ITER_DEST);
+	return __io_prep_rw(req, sqe, ITER_DEST);
 }
=20
 int io_prep_write_fixed(struct io_kiocb *req, const struct io_uring_sqe =
*sqe)
 {
-	return io_prep_rw_fixed(req, sqe, ITER_SOURCE);
+	return __io_prep_rw(req, sqe, ITER_SOURCE);
 }
=20
 /*
@@ -1147,6 +1146,28 @@ int io_write(struct io_kiocb *req, unsigned int is=
sue_flags)
 	}
 }
=20
+int io_read_fixed(struct io_kiocb *req, unsigned int issue_flags)
+{
+	int ret;
+
+	ret =3D io_init_rw_fixed(req, issue_flags, ITER_DEST);
+	if (unlikely(ret))
+		return ret;
+
+	return io_read(req, issue_flags);
+}
+
+int io_write_fixed(struct io_kiocb *req, unsigned int issue_flags)
+{
+	int ret;
+
+	ret =3D io_init_rw_fixed(req, issue_flags, ITER_SOURCE);
+	if (unlikely(ret))
+		return ret;
+
+	return io_write(req, issue_flags);
+}
+
 void io_rw_fail(struct io_kiocb *req)
 {
 	int res;
diff --git a/io_uring/rw.h b/io_uring/rw.h
index a45e0c71b59d6..bf121b81ebe84 100644
--- a/io_uring/rw.h
+++ b/io_uring/rw.h
@@ -38,6 +38,8 @@ int io_prep_read(struct io_kiocb *req, const struct io_=
uring_sqe *sqe);
 int io_prep_write(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_read(struct io_kiocb *req, unsigned int issue_flags);
 int io_write(struct io_kiocb *req, unsigned int issue_flags);
+int io_read_fixed(struct io_kiocb *req, unsigned int issue_flags);
+int io_write_fixed(struct io_kiocb *req, unsigned int issue_flags);
 void io_readv_writev_cleanup(struct io_kiocb *req);
 void io_rw_fail(struct io_kiocb *req);
 void io_req_rw_complete(struct io_kiocb *req, io_tw_token_t tw);
--=20
2.43.5


