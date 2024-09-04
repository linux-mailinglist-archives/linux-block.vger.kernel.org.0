Return-Path: <linux-block+bounces-11243-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0607896C243
	for <lists+linux-block@lfdr.de>; Wed,  4 Sep 2024 17:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12331F24212
	for <lists+linux-block@lfdr.de>; Wed,  4 Sep 2024 15:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49791EC017;
	Wed,  4 Sep 2024 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ixPsuGhO"
X-Original-To: linux-block@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF2D1DEFCB
	for <linux-block@vger.kernel.org>; Wed,  4 Sep 2024 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463608; cv=none; b=LxUKWUfMlettrwQ8SlT8VlGMSBkn3fY9o239n3hsjMq7FuQX6hnRsSqGs+Cm3dlpCGfdtFEJMpAAgw8KzbRrrPWYY8myHgu24vEi2oeLJdmSRqm4VvMrwUl9Sc5Q1uRJS8whylCCGBGc01BkhPtmWz1W/FkQ+cyoPKVgpB9fiyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463608; c=relaxed/simple;
	bh=hHFMDP2NtPGgFNnNaN8JDHv0kbdqrJvoXh7h639Ozu4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dPp+05jJMHjIgwzlWUKejmSnMSR+LuFVKKBBy6OOesJZkuCb0X3ALtzUozB6WS6q68tm18peA6QoD2OFyvcmGmunlfDs7kJDztXBY/DwYkUT8Q1zGTDhaDPuAXb9m/xQqhIecYn1Z9eosdoAg62C3o5MlgHDQYLRxvlxKoXlyyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ixPsuGhO; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4849U2Nt022336
	for <linux-block@vger.kernel.org>; Wed, 4 Sep 2024 08:26:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=yXz
	LEZ5bz9vaEEDlWYyoB6/11NgwtSFlDVn1Em7Vjmw=; b=ixPsuGhOlG92dui+K6S
	74cl0wF2RgPBbqUHFyH86rlpwN/QLrkH8o1bCWzLfmDWuS0u/BQSHMoSelSI/pt2
	xNCvCukbAbwz5FFrqZFwNZue5xnBYOsyf53xHZNbGAlZiLNxz94mFJkFBZAenKhs
	MK5aDuz6SkCHUNj+UwnOLWwahiN4zd5MTc9ZC92+0jfgDZpZeoDpO4dEhEsrfCLU
	7a6sdlmpDLRxzJe8zY3sufYCGiYT1dPWH7NjijIn/ajlFF9xVgNVUkbevJUkahJY
	nhwCB/yVW5aZK/gigCR2xNfULEIx9ZebAXhdypRNuqkgQ1el5T+2KIRACMVo6a1Q
	fRA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41emyp1w8k-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 04 Sep 2024 08:26:46 -0700 (PDT)
Received: from twshared34253.17.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Sep 2024 15:26:12 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 9D67312A036E2; Wed,  4 Sep 2024 08:26:07 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 00/10] block integrity merging and counting
Date: Wed, 4 Sep 2024 08:25:55 -0700
Message-ID: <20240904152605.4055570-1-kbusch@meta.com>
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
X-Proofpoint-GUID: _lcdEuV4U4quhF-iqCptCN7MavoIV6Rj
X-Proofpoint-ORIG-GUID: _lcdEuV4U4quhF-iqCptCN7MavoIV6Rj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_13,2024-09-04_01,2024-09-02_01

From: Keith Busch <kbusch@kernel.org>

Just some fixes and cleanups to counting integrity segments when
metadata is used. This fixes merging issues.

Changes from v2:

  Included all the follow up patches I mentioned in the v2 thread.

  Incorporated Christoph's suggestion to rename blk_rq_count_integrity_sg=
.

Keith Busch (10):
  blk-mq: set the nr_integrity_segments from bio
  block: provide helper for nr_integrity_segments
  scsi: use request helper to get integrity segments
  nvme-rdma: use request helper to get integrity segments
  block: unexport blk_rq_count_integrity_sg
  blk-integrity: simplify counting segments
  blk-integrity: simplify mapping sg
  blk-integrity: remove inappropriate limit checks
  blk-integrity: consider entire bio list for merging
  blk-merge: properly account for integrity segments

 block/bio-integrity.c         |  7 ----
 block/blk-integrity.c         | 78 +++++++----------------------------
 block/blk-merge.c             | 13 +++---
 block/blk-mq.c                |  4 ++
 block/blk.h                   | 34 ---------------
 drivers/nvme/host/rdma.c      |  6 +--
 drivers/scsi/scsi_lib.c       |  6 +--
 include/linux/blk-integrity.h | 11 ++---
 include/linux/blk-mq.h        | 12 ++++++
 9 files changed, 47 insertions(+), 124 deletions(-)

--=20
2.43.5


