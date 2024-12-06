Return-Path: <linux-block+bounces-15000-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB02D9E7BCC
	for <lists+linux-block@lfdr.de>; Fri,  6 Dec 2024 23:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B654516B03B
	for <lists+linux-block@lfdr.de>; Fri,  6 Dec 2024 22:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD1822C6D9;
	Fri,  6 Dec 2024 22:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="UAwEVY1r"
X-Original-To: linux-block@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0CF1F9EA9
	for <linux-block@vger.kernel.org>; Fri,  6 Dec 2024 22:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733524212; cv=none; b=oa13nr0/XpPQraOaoky2fNA745B4VUMfcmJ0pVx5MDa4K4se9lwzGkvlk3qXC9uKeW+AF63Z+eAdNtZw9ccse1ChWPIzoshi7ylvk2lKfjcC0se7KopXgJivbKfkZTtuNum98qVEtvYsWvbYEFYjX10XykFXG99ekt+Kgg73bp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733524212; c=relaxed/simple;
	bh=hfeQrSKzpWIy3OO3Oin2gi8VuTZqhNuFtx8UGd5jvpI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOVI7xpVaes56A0vutJ7yAKntipmM/zKYI/bK+LfWcTRRLv2yBgTIT7sSyHfMEzRwpZniODT2lIt5XAUEL8CCVyY9B7kp2n8ZidRP0Cd+NixGzzGFZ/fRtguLn6GgusaMKJjmEVZ83Lfim7UZqHvKzisef28WVWoKeOt8Jz8ZmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=UAwEVY1r; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4B6Lh0CM021619
	for <linux-block@vger.kernel.org>; Fri, 6 Dec 2024 14:30:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=oxFDFgnTMRB5Y+npjeZrWa3Vc5pSM5Iq2SS4ZNMVCY0=; b=UAwEVY1r+Dn+
	L5i1w0/5uF5t0jMe+mEAlyRkOOUyNlv2ZoCW4ooNLe4XBYNE0kAkZjC9vuq/FzZP
	ghn3J0SkL4jX34moYIz7jehxMoHv6pzFF7FSJczOynaHMeEb+QSJOtCTWpL9RFou
	lNHM7jpW4vUla0ynEx7PGxBe47ZT/EApws+2Iu2XcaD++HMXWynr54z5eztx5n0+
	O/SnSP1InhNGt5kh7Cm7QKz9YjTasjPfbyz0Zlw41UQENZ0tMhhdfAEiTFENLr0F
	AaIYFir8whBCL0R+RoO6pmOjn3U6i1a9vxkmTayvDshnY13ZoJmU1AFE35+FpygB
	JSTvyakVNQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 43c7neh2ax-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 06 Dec 2024 14:30:09 -0800 (PST)
Received: from twshared24170.03.ash8.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 6 Dec 2024 22:30:02 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 30F3615B8CB7B; Fri,  6 Dec 2024 14:18:27 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>, <anuj20.g@samsung.com>,
        <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv12 06/12] block: expose write streams for block device nodes
Date: Fri, 6 Dec 2024 14:17:55 -0800
Message-ID: <20241206221801.790690-7-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241206221801.790690-1-kbusch@meta.com>
References: <20241206221801.790690-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: aD2LGke4-Ox2lSmvV43ZSb5lzRjogj30
X-Proofpoint-ORIG-GUID: aD2LGke4-Ox2lSmvV43ZSb5lzRjogj30
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Christoph Hellwig <hch@lst.de>

Export statx information about the number and granularity of write
streams, use the per-kiocb write hint and map temperature hints
to write streams (which is a bit questionable, but this shows how it is
done).

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bdev.c |  6 ++++++
 block/fops.c | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index 738e3c8457e7f..c23245f1fdfe3 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1296,6 +1296,12 @@ void bdev_statx(struct path *path, struct kstat *s=
tat,
 		stat->result_mask |=3D STATX_DIOALIGN;
 	}
=20
+	if ((request_mask & STATX_WRITE_STREAM) &&
+	    bdev_max_write_streams(bdev)) {
+		stat->write_stream_max =3D bdev_max_write_streams(bdev);
+		stat->result_mask |=3D STATX_WRITE_STREAM;
+	}
+
 	if (request_mask & STATX_WRITE_ATOMIC && bdev_can_atomic_write(bdev)) {
 		struct request_queue *bd_queue =3D bdev->bd_queue;
=20
diff --git a/block/fops.c b/block/fops.c
index 6d5c4fc5a2168..f16aa39bf5bad 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -73,6 +73,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *=
iocb,
 	}
 	bio.bi_iter.bi_sector =3D pos >> SECTOR_SHIFT;
 	bio.bi_write_hint =3D file_inode(iocb->ki_filp)->i_write_hint;
+	bio.bi_write_stream =3D iocb->ki_write_stream;
 	bio.bi_ioprio =3D iocb->ki_ioprio;
 	if (iocb->ki_flags & IOCB_ATOMIC)
 		bio.bi_opf |=3D REQ_ATOMIC;
@@ -206,6 +207,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb,=
 struct iov_iter *iter,
 	for (;;) {
 		bio->bi_iter.bi_sector =3D pos >> SECTOR_SHIFT;
 		bio->bi_write_hint =3D file_inode(iocb->ki_filp)->i_write_hint;
+		bio->bi_write_stream =3D iocb->ki_write_stream;
 		bio->bi_private =3D dio;
 		bio->bi_end_io =3D blkdev_bio_end_io;
 		bio->bi_ioprio =3D iocb->ki_ioprio;
@@ -333,6 +335,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb =
*iocb,
 	dio->iocb =3D iocb;
 	bio->bi_iter.bi_sector =3D pos >> SECTOR_SHIFT;
 	bio->bi_write_hint =3D file_inode(iocb->ki_filp)->i_write_hint;
+	bio->bi_write_stream =3D iocb->ki_write_stream;
 	bio->bi_end_io =3D blkdev_bio_end_io_async;
 	bio->bi_ioprio =3D iocb->ki_ioprio;
=20
@@ -398,6 +401,26 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, =
struct iov_iter *iter)
 	if (blkdev_dio_invalid(bdev, iocb, iter))
 		return -EINVAL;
=20
+	if (iov_iter_rw(iter) =3D=3D WRITE) {
+		u16 max_write_streams =3D bdev_max_write_streams(bdev);
+
+		if (iocb->ki_write_stream) {
+			if (iocb->ki_write_stream > max_write_streams)
+				return -EINVAL;
+		} else if (max_write_streams) {
+			enum rw_hint write_hint =3D
+				file_inode(iocb->ki_filp)->i_write_hint;
+
+			/*
+			 * Just use the write hint as write stream for block
+			 * device writes.  This assumes no file system is
+			 * mounted that would use the streams differently.
+			 */
+			if (write_hint <=3D max_write_streams)
+				iocb->ki_write_stream =3D write_hint;
+		}
+	}
+
 	nr_pages =3D bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
 	if (likely(nr_pages <=3D BIO_MAX_VECS)) {
 		if (is_sync_kiocb(iocb))
--=20
2.43.5


