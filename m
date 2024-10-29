Return-Path: <linux-block+bounces-13145-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5799E9B4D8F
	for <lists+linux-block@lfdr.de>; Tue, 29 Oct 2024 16:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29E9285BD4
	for <lists+linux-block@lfdr.de>; Tue, 29 Oct 2024 15:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832A5197A67;
	Tue, 29 Oct 2024 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ay2frHnQ"
X-Original-To: linux-block@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699201946A2
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215201; cv=none; b=RL8DyUi9z1wgOkMUKeNGg4fHWkw1SFm4NNb48qcdEzgwA/sg3z61wfBSKE/0tRZ8gPDADVm3Na6DfoglsxOFESPqdHE6gdkdR4Qa9wBbyFtw706SczTAK1pjTBC50n/uGATXZxPwC/SkhtiSkstQYGLpkAwYFuXtvoqcQMg0ihI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215201; c=relaxed/simple;
	bh=bLVs+NUjXqkb64uW7DX9xzl2BkYI8JF3mYXsk/Fl4uY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eXLqmZd6kv0xMCWfrPbnRbotm0eS9VaeQQ+bvccPpH/SVRTIPS+Wv18akFcqtMDg+yF8Ji1Si6thICX5R0oRBroB97nSe59mH4Xapn87nSAP3pKsVyd0Vp0+GOMSRlIYruBuDcpffNk1DTNXMQ3i3xLi99qDTGYDoB+PMfvJvrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ay2frHnQ; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 49TD7Fwl021662
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 08:19:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=YaxUJJnRZ28AJAdK6cvper+b/ynFQDqHd29QjSNk8fc=; b=ay2frHnQBoz3
	7Ne1TVmq/1c7UPH78vZxWhsnfpe1X2s/gMcA22+1LPYEbFzY6tEM0X8ziK5Ir6b5
	vo0stBS0x8rZkyjK+2M0jb5KR/XCSleMALdE1FMBrWD6NPlS/Ps/4kThvfUoyBxp
	JTKbdK3kkuvpHRTkoJv5QWmXRrMYA0CON8Xw0j3c/J1EOybmElLKPn838819Tebc
	xPUryeS4nxIaC0fnkDpgff6K4b1FpFS8vpnl0qfBxdgLQ55www/LU9N8RecMUsQs
	y7ZFPQDgmc+H6UldklgDliXIn73s6UnF39rhS+d3mXEx6ODhz3rVfkbiqgCcXZ+3
	Hwq9r0shmg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 42k0af13y2-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 08:19:58 -0700 (PDT)
Received: from twshared23455.15.frc2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 29 Oct 2024 15:19:52 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 0228614920EA1; Tue, 29 Oct 2024 08:19:44 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <hch@lst.de>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, <bvanassche@acm.org>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv10 3/9] statx: add write hint information
Date: Tue, 29 Oct 2024 08:19:16 -0700
Message-ID: <20241029151922.459139-4-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241029151922.459139-1-kbusch@meta.com>
References: <20241029151922.459139-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: f6K_-SGms8oj0YwKQow4YUohC1dFNDM_
X-Proofpoint-ORIG-GUID: f6K_-SGms8oj0YwKQow4YUohC1dFNDM_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

If requested on a raw block device, report the maximum write hint the
block device supports.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bdev.c              | 5 +++++
 fs/stat.c                 | 1 +
 include/linux/stat.h      | 1 +
 include/uapi/linux/stat.h | 3 ++-
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index 738e3c8457e7f..9a59f0c882170 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1296,6 +1296,11 @@ void bdev_statx(struct path *path, struct kstat *s=
tat,
 		stat->result_mask |=3D STATX_DIOALIGN;
 	}
=20
+	if (request_mask & STATX_WRITE_HINT) {
+		stat->write_hint_max =3D bdev_max_write_hints(bdev);
+		stat->result_mask |=3D STATX_WRITE_HINT;
+	}
+
 	if (request_mask & STATX_WRITE_ATOMIC && bdev_can_atomic_write(bdev)) {
 		struct request_queue *bd_queue =3D bdev->bd_queue;
=20
diff --git a/fs/stat.c b/fs/stat.c
index 41e598376d7e3..60bcd5c2e2a1d 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -704,6 +704,7 @@ cp_statx(const struct kstat *stat, struct statx __use=
r *buffer)
 	tmp.stx_atomic_write_unit_min =3D stat->atomic_write_unit_min;
 	tmp.stx_atomic_write_unit_max =3D stat->atomic_write_unit_max;
 	tmp.stx_atomic_write_segments_max =3D stat->atomic_write_segments_max;
+	tmp.stx_write_hint_max =3D stat->write_hint_max;
=20
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 3d900c86981c5..48f0f64846a02 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -57,6 +57,7 @@ struct kstat {
 	u32		atomic_write_unit_min;
 	u32		atomic_write_unit_max;
 	u32		atomic_write_segments_max;
+	u32		write_hint_max;
 };
=20
 /* These definitions are internal to the kernel for now. Mainly used by =
nfsd. */
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 887a252864416..10f5622c21113 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -132,7 +132,7 @@ struct statx {
 	__u32	stx_atomic_write_unit_max;	/* Max atomic write unit in bytes */
 	/* 0xb0 */
 	__u32   stx_atomic_write_segments_max;	/* Max atomic write segment coun=
t */
-	__u32   __spare1[1];
+	__u32   stx_write_hint_max;
 	/* 0xb8 */
 	__u64	__spare3[9];	/* Spare space for future expansion */
 	/* 0x100 */
@@ -164,6 +164,7 @@ struct statx {
 #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_i=
d */
 #define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
 #define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields=
 */
+#define STATX_WRITE_HINT	0x00020000U	/* Want/got write_hint_max */
=20
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx=
 expansion */
=20
--=20
2.43.5


