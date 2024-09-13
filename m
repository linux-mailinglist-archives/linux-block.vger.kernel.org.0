Return-Path: <linux-block+bounces-11664-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2309788BC
	for <lists+linux-block@lfdr.de>; Fri, 13 Sep 2024 21:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D001C22F14
	for <lists+linux-block@lfdr.de>; Fri, 13 Sep 2024 19:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5069C12C478;
	Fri, 13 Sep 2024 19:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="U68oBjFR"
X-Original-To: linux-block@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87115BA38
	for <linux-block@vger.kernel.org>; Fri, 13 Sep 2024 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726255080; cv=none; b=aG91ZHMHCMo5wBdBjvOM5u7hNi/dgWszZEsZ9NoxZEYZFA2HDybzguSqIVjZ9+G1bSbe4VtHrdLda0x2orR9QASHeXXXdh9G7w3rID2+u01KwV7bV6JLRVg2oYD7l7Ly6pCmTh/FgAZ/g9UeS1ng/qeknX4eTfvyc7kQM+185h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726255080; c=relaxed/simple;
	bh=QdqphMzQSz854p3EfhmPfTMbqj218tCXgwpCiPi+WD8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s646frrZSXaM9adMUhi1KGJjGZyGCWg5ZV7FyVg/DM8eaxQdT5OHGaK+iNewUFkqDUcV1wd7rroECv4qabOPyGM+pnpqbTx5EYWb/6jGiwNgDbiNLT4jslOZyv8XOqYj7aK7M8zLE04TimuHQVnoUH9R00C0KqegPRJ4I4X6GGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=U68oBjFR; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 48DI2CQG016996
	for <linux-block@vger.kernel.org>; Fri, 13 Sep 2024 12:17:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=3kL
	wmujLUB+sSHMY+V2cdy2TTVQo6nf46tZ0Gfg5SJA=; b=U68oBjFR7GhZmDPdiO+
	aCrp5qWMoyNxQhircZxGocEGHmp6oeoPrczq9Qw1qOffAtzhZqvNOmeE9N7bhMNy
	sVlWTV+qzEP+OJv1FCSdSCoSB4jwgztANIXhbsWrbVdl08npXEGnhIfxgr+Kw35D
	YjTQHjaaV4X6jQIv4Ldttuo1arbbiQmeZWJUR2b7wDm+l7fAaJ0P4QAZ6xlU7WmZ
	1Y0ZUWTClHUn22i9cbog4KPQRRptj9uyqA9Nuhy5loL3/wAGTWuQDgii4wDfeC0m
	l/dW//we4LjUMKsz9CpMoPRXRyK2uK4lJ7fYjSmYV9a5uqm6Ir+gv7UEbJJ+nU82
	poA==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 41mgk93y6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 13 Sep 2024 12:17:57 -0700 (PDT)
Received: from twshared23455.15.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 13 Sep 2024 19:17:56 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id CBF5112F96E91; Fri, 13 Sep 2024 12:17:46 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        "Martin K
 . Petersen" <martin.petersen@oracle.com>
Subject: [PATCHv6] blk-integrity: improved sg segment mapping
Date: Fri, 13 Sep 2024 12:17:46 -0700
Message-ID: <20240913191746.2628196-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: YWcpRv1Jfxf3z6ABOLdfwJrRSxLGQKKF
X-Proofpoint-GUID: YWcpRv1Jfxf3z6ABOLdfwJrRSxLGQKKF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01

From: Keith Busch <kbusch@kernel.org>

Make the integrity mapping more like data mapping, blk_rq_map_sg. Use
the request to validate the segment count, and update the callers so
they don't have to.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
Actually sending the correct version of this patch. The other one had
the very same mistake that I pointed out in v4.

 block/blk-integrity.c         | 15 +++++++++++----
 drivers/nvme/host/rdma.c      |  4 ++--
 drivers/scsi/scsi_lib.c       | 11 +++--------
 include/linux/blk-integrity.h |  6 ++----
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 1d82b18e06f8e..0a2b1c5d0ebf1 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -62,19 +62,20 @@ int blk_rq_count_integrity_sg(struct request_queue *q=
, struct bio *bio)
  *
  * Description: Map the integrity vectors in request into a
  * scatterlist.  The scatterlist must be big enough to hold all
- * elements.  I.e. sized using blk_rq_count_integrity_sg().
+ * elements.  I.e. sized using blk_rq_count_integrity_sg() or
+ * rq->nr_integrity_segments.
  */
-int blk_rq_map_integrity_sg(struct request_queue *q, struct bio *bio,
-			    struct scatterlist *sglist)
+int blk_rq_map_integrity_sg(struct request *rq, struct scatterlist *sgli=
st)
 {
 	struct bio_vec iv, ivprv =3D { NULL };
+	struct request_queue *q =3D rq->q;
 	struct scatterlist *sg =3D NULL;
+	struct bio *bio =3D rq->bio;
 	unsigned int segments =3D 0;
 	struct bvec_iter iter;
 	int prev =3D 0;
=20
 	bio_for_each_integrity_vec(iv, bio, iter) {
-
 		if (prev) {
 			if (!biovec_phys_mergeable(q, &ivprv, &iv))
 				goto new_segment;
@@ -102,6 +103,12 @@ int blk_rq_map_integrity_sg(struct request_queue *q,=
 struct bio *bio,
 	if (sg)
 		sg_mark_end(sg);
=20
+	/*
+	 * Something must have been wrong if the figured number of segment
+	 * is bigger than number of req's physical integrity segments
+	 */
+	BUG_ON(segments > rq->nr_integrity_segments);
+	BUG_ON(segments > queue_max_integrity_segments(q));
 	return segments;
 }
 EXPORT_SYMBOL(blk_rq_map_integrity_sg);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 256466bdaee7c..c8fd0e8f02375 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1504,8 +1504,8 @@ static int nvme_rdma_dma_map_req(struct ib_device *=
ibdev, struct request *rq,
 			goto out_unmap_sg;
 		}
=20
-		req->metadata_sgl->nents =3D blk_rq_map_integrity_sg(rq->q,
-				rq->bio, req->metadata_sgl->sg_table.sgl);
+		req->metadata_sgl->nents =3D blk_rq_map_integrity_sg(rq,
+				req->metadata_sgl->sg_table.sgl);
 		*pi_count =3D ib_dma_map_sg(ibdev,
 					  req->metadata_sgl->sg_table.sgl,
 					  req->metadata_sgl->nents,
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index c602b0af745ca..c2f6d0e1c03e7 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1163,7 +1163,6 @@ blk_status_t scsi_alloc_sgtables(struct scsi_cmnd *=
cmd)
=20
 	if (blk_integrity_rq(rq)) {
 		struct scsi_data_buffer *prot_sdb =3D cmd->prot_sdb;
-		int ivecs;
=20
 		if (WARN_ON_ONCE(!prot_sdb)) {
 			/*
@@ -1175,19 +1174,15 @@ blk_status_t scsi_alloc_sgtables(struct scsi_cmnd=
 *cmd)
 			goto out_free_sgtables;
 		}
=20
-		ivecs =3D rq->nr_integrity_segments;
-		if (sg_alloc_table_chained(&prot_sdb->table, ivecs,
+		if (sg_alloc_table_chained(&prot_sdb->table,
+				rq->nr_integrity_segments,
 				prot_sdb->table.sgl,
 				SCSI_INLINE_PROT_SG_CNT)) {
 			ret =3D BLK_STS_RESOURCE;
 			goto out_free_sgtables;
 		}
=20
-		count =3D blk_rq_map_integrity_sg(rq->q, rq->bio,
-						prot_sdb->table.sgl);
-		BUG_ON(count > ivecs);
-		BUG_ON(count > queue_max_integrity_segments(rq->q));
-
+		count =3D blk_rq_map_integrity_sg(rq, prot_sdb->table.sgl);
 		cmd->prot_sdb =3D prot_sdb;
 		cmd->prot_sdb->table.nents =3D count;
 	}
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.=
h
index 793dbb1e0672d..676f8f860c474 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -25,8 +25,7 @@ static inline bool queue_limits_stack_integrity_bdev(st=
ruct queue_limits *t,
 }
=20
 #ifdef CONFIG_BLK_DEV_INTEGRITY
-int blk_rq_map_integrity_sg(struct request_queue *, struct bio *,
-				   struct scatterlist *);
+int blk_rq_map_integrity_sg(struct request *, struct scatterlist *);
 int blk_rq_count_integrity_sg(struct request_queue *, struct bio *);
 int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
 			      ssize_t bytes, u32 seed);
@@ -98,8 +97,7 @@ static inline int blk_rq_count_integrity_sg(struct requ=
est_queue *q,
 {
 	return 0;
 }
-static inline int blk_rq_map_integrity_sg(struct request_queue *q,
-					  struct bio *b,
+static inline int blk_rq_map_integrity_sg(struct request *q,
 					  struct scatterlist *s)
 {
 	return 0;
--=20
2.43.5


