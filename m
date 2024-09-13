Return-Path: <linux-block+bounces-11654-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BD69787D6
	for <lists+linux-block@lfdr.de>; Fri, 13 Sep 2024 20:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21881C22704
	for <lists+linux-block@lfdr.de>; Fri, 13 Sep 2024 18:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C7E135A63;
	Fri, 13 Sep 2024 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fHF+1n/8"
X-Original-To: linux-block@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0FB84FA0
	for <linux-block@vger.kernel.org>; Fri, 13 Sep 2024 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726252152; cv=none; b=Szq5+Gr/aRfsgUr6AiiyG4DDNHg/mu2F9nebih6oRSJKUKw0IlQLTUaoPcXX+yyZ78pKkE6XrRo9fWclJ+p0S80t4zm+VnSfg4eDpKGllx4k2c6M3Cr2nl9m2xpZv9EUb/fVXWvTGliNG71r6s2cxRHY0jd+jO1xZ7W2pMq6USY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726252152; c=relaxed/simple;
	bh=/xRbpYTmItdNfTgMZUlmMcBDDQDJai5vbVVoVSnAvNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFUlTHFkXCDp2dC78UE7ezSb8HlNCfb0Jdpr4/MNs6L4+h4mx18rnC6vZHemxyHnQEWn+fEB0ngLhTB2G4IaRJXB8aprxoza9qb25Kp9pgtRMu8mQ/7Bad3i8PBEOP6A2DuutiuglkaAsQkdWNSPpXaXq/UzZSbXPSEcdqhBT44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fHF+1n/8; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DI9uOf016519
	for <linux-block@vger.kernel.org>; Fri, 13 Sep 2024 11:29:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=YjRDVhh75SMTGa/Nn/K3IvSmdcIyNqHJBBkm4InR34M=; b=
	fHF+1n/8IqkkxClSZzL2/Xn6LCL7Uw93tAn9SkLLlcFFctTvPF3/5/9dBlnOSqLh
	1cv14+n7lTZVWXdOUQbwgqHqDQz13PrJllwLh2huzG96i/xuBAcMrNvuOB0mMLNT
	BLut+nGeGD0sGeajx+2l7NHfHkFRjIYpagWwCqZnriQ772SvdCLXzcHL1j7+rF3f
	0aK7bhEgvu9yQ8e2QhityVK80eMFUbRw9nUQ8mLNCSmC7B2x1VLsDP1wuNcon6Y3
	TvTwIwcd9G/sOUqoNuqyK+OvTSO6i60jNjVJr5ez6cBtVoF9k4lm/+LUQG0lozgy
	ACZhy2Dg0AbiOyRc7eiUWw==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41mte705n8-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 13 Sep 2024 11:29:09 -0700 (PDT)
Received: from twshared57535.03.ash8.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 13 Sep 2024 18:29:06 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 7966312F9104B; Fri, 13 Sep 2024 11:29:03 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCHv5 5/9] block: provide a request helper for user integrity segments
Date: Fri, 13 Sep 2024 11:28:50 -0700
Message-ID: <20240913182854.2445457-6-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240913182854.2445457-1-kbusch@meta.com>
References: <20240913182854.2445457-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7sKlrFSKfrt0KIj9F9p94b3495dmYt-e
X-Proofpoint-GUID: 7sKlrFSKfrt0KIj9F9p94b3495dmYt-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01

From: Keith Busch <kbusch@kernel.org>

Provide a helper to keep the request flags and nr_integrity_segments in
sync with the bio's integrity payload. This is an integrity equivalent
to the normal data helper function, 'blk_rq_map_user()'.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio-integrity.c         |  1 -
 block/blk-integrity.c         | 14 ++++++++++++++
 drivers/nvme/host/ioctl.c     |  6 ++----
 include/linux/blk-integrity.h |  9 +++++++++
 4 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 8d1fb38f745f9..357a022eed411 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -371,7 +371,6 @@ int bio_integrity_map_user(struct bio *bio, void __us=
er *ubuf, ssize_t bytes,
 		kfree(bvec);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(bio_integrity_map_user);
=20
 /**
  * bio_integrity_prep - Prepare bio for integrity I/O
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 84065691aaed0..ddc742d58330b 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -107,6 +107,20 @@ int blk_rq_map_integrity_sg(struct request_queue *q,=
 struct bio *bio,
 }
 EXPORT_SYMBOL(blk_rq_map_integrity_sg);
=20
+int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
+			      ssize_t bytes, u32 seed)
+{
+	int ret =3D bio_integrity_map_user(rq->bio, ubuf, bytes, seed);
+
+	if (ret)
+		return ret;
+
+	rq->nr_integrity_segments =3D blk_rq_count_integrity_sg(rq->q, rq->bio)=
;
+	rq->cmd_flags |=3D REQ_INTEGRITY;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(blk_rq_integrity_map_user);
+
 bool blk_integrity_merge_rq(struct request_queue *q, struct request *req=
,
 			    struct request *next)
 {
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 1d769c842fbf5..b9b79ccfabf8a 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2011-2014, Intel Corporation.
  * Copyright (c) 2017-2021 Christoph Hellwig.
  */
-#include <linux/bio-integrity.h>
 #include <linux/blk-integrity.h>
 #include <linux/ptrace.h>	/* for force_successful_syscall_return */
 #include <linux/nvme_ioctl.h>
@@ -153,11 +152,10 @@ static int nvme_map_user_request(struct request *re=
q, u64 ubuffer,
 		bio_set_dev(bio, bdev);
=20
 	if (has_metadata) {
-		ret =3D bio_integrity_map_user(bio, meta_buffer, meta_len,
-					     meta_seed);
+		ret =3D blk_rq_integrity_map_user(req, meta_buffer, meta_len,
+						meta_seed);
 		if (ret)
 			goto out_unmap;
-		req->cmd_flags |=3D REQ_INTEGRITY;
 	}
=20
 	return ret;
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.=
h
index de98049b7ded9..793dbb1e0672d 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -28,6 +28,8 @@ static inline bool queue_limits_stack_integrity_bdev(st=
ruct queue_limits *t,
 int blk_rq_map_integrity_sg(struct request_queue *, struct bio *,
 				   struct scatterlist *);
 int blk_rq_count_integrity_sg(struct request_queue *, struct bio *);
+int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
+			      ssize_t bytes, u32 seed);
=20
 static inline bool
 blk_integrity_queue_supports_integrity(struct request_queue *q)
@@ -102,6 +104,13 @@ static inline int blk_rq_map_integrity_sg(struct req=
uest_queue *q,
 {
 	return 0;
 }
+static inline int blk_rq_integrity_map_user(struct request *rq,
+					    void __user *ubuf,
+					    ssize_t bytes,
+					    u32 seed)
+{
+	return -EINVAL;
+}
 static inline struct blk_integrity *bdev_get_integrity(struct block_devi=
ce *b)
 {
 	return NULL;
--=20
2.43.5


