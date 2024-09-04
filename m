Return-Path: <linux-block+bounces-11248-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6010096C24D
	for <lists+linux-block@lfdr.de>; Wed,  4 Sep 2024 17:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A72C1F23B63
	for <lists+linux-block@lfdr.de>; Wed,  4 Sep 2024 15:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDC41DEFC5;
	Wed,  4 Sep 2024 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="F8RfilbV"
X-Original-To: linux-block@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E1A1DC754
	for <linux-block@vger.kernel.org>; Wed,  4 Sep 2024 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463619; cv=none; b=SBeaFB1AAE60Y0tOy1NthjLmMDwQ35Ro4D/AVjhUbcW835VwcMYqIRVLwQ5SE99vldm/m1pGINk6ShOGKcILZdaOLJj0rguqXHRmGzuIACCJdAAsCSSqU/HiT9MqQTxcAlP4Il8ZU9cmI+kPEDjZsA3dKBrQPW2XYlJ1ibKwOOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463619; c=relaxed/simple;
	bh=mIMzDYPipEZCzvoJEZhl1TTa2Z2biQRbEVba7c6Ips0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XiZ5hU42SRo1G3UXwmxoFh/GsTh6+VxFI/A0V9d6iwtOqhggKxgEJC9j+KDvvbvPTbnmYuRC0ZySxWCJFAPVaFwqf5AJAvZKaJAgga3ZeNlYycEL/FgwULpDxqqn2zsWqzBTGYfSSi/I5yPjZgCFcC/roytaDkeupWOCV453Urs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=F8RfilbV; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4849UfQB022985
	for <linux-block@vger.kernel.org>; Wed, 4 Sep 2024 08:26:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=nYakPJ9rnveCc/VvRR9I1ztb2OG9ggJMLK0vhtAOxDs=; b=
	F8RfilbVxSMoFlVK8z/wsOmEiHTmIjzfYzFKHUGW8uOTfYDkPhl/6EjFBqTC2hgB
	5Es2V3DiEGOIDjVa8DjWzUofi+I0OFyTqQCt0FGOwD7wiy0HJaCUDPwLln1iTlXy
	O5Q6s97aWzHjfVYr/B6+9VXxlgHmHQ+avoT9LfP77j5CMVWl68o2kVzOrsanallK
	OCLkp1/fbEtOvjXzrVEh8myYeT8kXn2ZbtumDNr9TM5eIQY6lIaV8DAa83MgZZRQ
	8u73FAjmRYF3DTiq3VcG7LF4JnIC+grFabeaL9r8orp6KFaMGq/pUxueXkPqucRM
	8TyZ9DWVMI62HhU5m2vVIA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41emyp1wcm-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 04 Sep 2024 08:26:56 -0700 (PDT)
Received: from twshared34253.17.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Sep 2024 15:26:13 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id C80ED12A036EB; Wed,  4 Sep 2024 08:26:07 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 05/10] block: unexport blk_rq_count_integrity_sg
Date: Wed, 4 Sep 2024 08:26:00 -0700
Message-ID: <20240904152605.4055570-6-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240904152605.4055570-1-kbusch@meta.com>
References: <20240904152605.4055570-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: -HiehyxzMLq6vhHc_pHGPrUEi7ajhCyu
X-Proofpoint-ORIG-GUID: -HiehyxzMLq6vhHc_pHGPrUEi7ajhCyu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_13,2024-09-04_01,2024-09-02_01

From: Keith Busch <kbusch@kernel.org>

There are no external users of this.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-integrity.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 010decc892eaa..4365960153b91 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -53,7 +53,6 @@ int blk_rq_count_integrity_sg(struct request_queue *q, =
struct bio *bio)
=20
 	return segments;
 }
-EXPORT_SYMBOL(blk_rq_count_integrity_sg);
=20
 /**
  * blk_rq_map_integrity_sg - Map integrity metadata into a scatterlist
--=20
2.43.5


