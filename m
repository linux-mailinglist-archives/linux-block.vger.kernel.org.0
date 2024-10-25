Return-Path: <linux-block+bounces-13004-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9619B11CA
	for <lists+linux-block@lfdr.de>; Fri, 25 Oct 2024 23:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 699CAB21B63
	for <lists+linux-block@lfdr.de>; Fri, 25 Oct 2024 21:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3161D8E07;
	Fri, 25 Oct 2024 21:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="mQ1IgskG"
X-Original-To: linux-block@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C8520BB42
	for <linux-block@vger.kernel.org>; Fri, 25 Oct 2024 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729892390; cv=none; b=DTX0B4zj/gmi8lIsoVydoUB9GvbbdVRVCylbvaNYMVT06mhNsKnhZ/CvV0rSC2cd3mH65xEsaOaojwNuM7pjOJIyLoOtjnORnRB3P5hbSsk2AYcu+Ss2iLoYNMhVtcC/U44g51Xgmlq7sFd5boA+sd2MWtdQ80uvTTzWUnWN6sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729892390; c=relaxed/simple;
	bh=QNBnH7bi6WbGlj2rf3vDcTyaJMrmau3H7p98DlJvp0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/3W2ysbXccWcmz5MMXMY3NULL/0fizvrzP5MGYRTSh64eGzByqkcqSNrLzAZcoI9xE6z5rH/f+n+dZzqtfbiHH415Pg2skmGxgYd07MNeKWomzqxq507vojoX2c3xonzGHTh7bgc44fpKhRevRCvQyLwIhWnF3e21GJYXd953g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=mQ1IgskG; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 49PKXPhX022992
	for <linux-block@vger.kernel.org>; Fri, 25 Oct 2024 14:39:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=QDSowptOyZLvK9oAHCxfP0iFBCixlqbp/+dl8U+g3G0=; b=mQ1IgskGRUZF
	aHWIeAvxdctEjZ1ozlJxEG/DMeww3ySl+lsIJ/kdShKTO5W63NGWopSwifiIeuLr
	NjMrYPvALK8GNbcTbZnWtwsAxHqOQ8nYuub97UWRdkCxKAjOEkAfLrt1yCY4m10J
	kotD3iBXuL5/I5kA71zbLcMmVicPJ7cCfBg6tJsvvNFJpBQzpbX4ipirCOjJdCoc
	r7PbUdHzE14HEc2/mmhOBWFzIa0YRTnLRDKX+CR/L13/CtXR6FvbYlq3leSgdFxI
	7SRXa09EVoqgafM6OLC6aIf+2evSaRsXITQHTFDxJ+G2Uyh2VlRpQp4TZnfQehY1
	4xHhFHwbkQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 42gdaau1ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 25 Oct 2024 14:39:47 -0700 (PDT)
Received: from twshared10900.35.frc1.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 25 Oct 2024 21:39:46 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id B3E041476D744; Fri, 25 Oct 2024 14:37:06 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <hch@lst.de>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, <bvanassche@acm.org>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv9 7/7] scsi: set permanent stream count in block limits
Date: Fri, 25 Oct 2024 14:36:45 -0700
Message-ID: <20241025213645.3464331-8-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241025213645.3464331-1-kbusch@meta.com>
References: <20241025213645.3464331-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JCZOg0S1YgkkMMzXYmOR76sDM2dKdfkf
X-Proofpoint-GUID: JCZOg0S1YgkkMMzXYmOR76sDM2dKdfkf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

The block limits exports the number of write hints, so set this limit if
the device reports support for the lifetime hints. Not only does this
inform the user of which hints are possible, it also allows scsi devices
supporting the feature to utilize the full range through raw block
device direct-io.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/scsi/sd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index ca4bc0ac76adc..235dd6e5b6688 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3768,6 +3768,8 @@ static int sd_revalidate_disk(struct gendisk *disk)
 		sd_config_protection(sdkp, &lim);
 	}
=20
+	lim.max_write_hints =3D sdkp->permanent_stream_count;
+
 	/*
 	 * We now have all cache related info, determine how we deal
 	 * with flush requests.
--=20
2.43.5


