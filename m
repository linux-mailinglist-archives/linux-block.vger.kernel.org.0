Return-Path: <linux-block+bounces-17754-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BE5A46924
	for <lists+linux-block@lfdr.de>; Wed, 26 Feb 2025 19:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73C0B7AA2CB
	for <lists+linux-block@lfdr.de>; Wed, 26 Feb 2025 18:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134FF23643E;
	Wed, 26 Feb 2025 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="WFVoI5x+"
X-Original-To: linux-block@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E8422A4EE
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593425; cv=none; b=szcBrPowwS90g2QJzG/X8/OMnjptgK+WAGaqjzOZqfBmPVzm6oFoU+CDv835sWwaKU07Yddq8r6I6ztjHSRGNlAFLDiEYryRKfZmct6bsdQL1+B71e5xkq7rXUQ8j84usxJpKTSWvL1zgK/sypCCMgWsMowS+LEfj0Tx6Cy5e2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593425; c=relaxed/simple;
	bh=vXpPB62p/gOzDfVR0WVJxsPbSl2431glAEKWypdX2WI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WD/medXf27HhSZoac32Cttukj0rzCRLp2CEPXWjYYkPBHTHqc54eZuPPghKcjye0em1FXQS2r6eNqYnWJq2fZlowr2CpmwOycY/JAURFoXA1al9CW/Ka8UMblZ7vPHOT1wsMqVIOF2xm7E+RepNDYLZw+ZMx83zAu5Z1JD60MAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=WFVoI5x+; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 51QFa4K7015056
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 10:10:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=rhZprq/fhlitTeHklVfwoWYolzCx7OIds6d1dWBk5OU=; b=WFVoI5x+pBUZ
	c+3cbYaRIfgTmZ5BjCxmXv06yV6ytFzsi1+ouoRFjNfL7eMEud+yET+QBBITXSPd
	5mMQbdqdR0GH3HLHD5an763R+Do3gQZsYmTVwp22ULgnA76BxhQ2g5YQfPoHop3M
	zkrCEPUvVBSUlLT/KF0wFcuUY5jTdqSVtzR30ka9g1qTGC4m+qblW/yYM1m9N7wH
	1O/s4OQ8j8inkOjuLzFSGaH31D/OwjItDiqIQeM+yRAFeNVH5NHOThLtg92ZKZC8
	TR4aGRvLGK9z2iLkrktIqQK3sg6TZ99VXC8xdCxnWvLhQZU7N5k4UVPcSwXnhGaE
	H+nxyUKbRQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4525r796mp-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 10:10:21 -0800 (PST)
Received: from twshared18153.09.ash9.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 26 Feb 2025 18:10:05 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id C71C1187C4ADA; Wed, 26 Feb 2025 10:10:06 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <ming.lei@redhat.com>, <asml.silence@gmail.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <bernd@bsbernd.com>, <csander@purestorage.com>,
        <linux-nvme@lists.infradead.org>,
        Xinyu Zhang <xizhang@purestorage.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv6 2/5] nvme: map uring_cmd data even if address is 0
Date: Wed, 26 Feb 2025 10:09:55 -0800
Message-ID: <20250226181002.2574148-5-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250226181002.2574148-1-kbusch@meta.com>
References: <20250226181002.2574148-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: uf7KofWWtFPDkGJ2TXDFcOIXUVsTmnSY
X-Proofpoint-ORIG-GUID: uf7KofWWtFPDkGJ2TXDFcOIXUVsTmnSY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01

From: Xinyu Zhang <xizhang@purestorage.com>

When using kernel registered bvec fixed buffers, the "address" is
actually the offset into the bvec rather than userspace address.
Therefore it can be 0.

We can skip checking whether the address is NULL before mapping
uring_cmd data. Bad userspace address will be handled properly later when
the user buffer is imported.

With this patch, we will be able to use the kernel registered bvec fixed
buffers in io_uring NVMe passthru with ublk zero-copy support.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Xinyu Zhang <xizhang@purestorage.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 5078d9aaf88fc..ecf136489044f 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -516,7 +516,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, =
struct nvme_ns *ns,
 		return PTR_ERR(req);
 	req->timeout =3D d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0;
=20
-	if (d.addr && d.data_len) {
+	if (d.data_len) {
 		ret =3D nvme_map_user_request(req, d.addr,
 			d.data_len, nvme_to_user_ptr(d.metadata),
 			d.metadata_len, ioucmd, vec, issue_flags);
--=20
2.43.5


