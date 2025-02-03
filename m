Return-Path: <linux-block+bounces-16833-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046E8A262EA
	for <lists+linux-block@lfdr.de>; Mon,  3 Feb 2025 19:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A51D3A1A6E
	for <lists+linux-block@lfdr.de>; Mon,  3 Feb 2025 18:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675BF1FFC65;
	Mon,  3 Feb 2025 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="T0T50WP7"
X-Original-To: linux-block@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC5670821
	for <linux-block@vger.kernel.org>; Mon,  3 Feb 2025 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738608414; cv=none; b=PsO+zRsIFELrRwOFbnMOwOoB/t0WyhQpaM/3UBYBIDgiShOJaycWNPbj3wigiVQ1lHYagik1GmbMwv9TrDZr03NydJZRAZvtiYkQqmjp/0esSPo6y5Hy4o/LRPhN5HZR3yWYDUvuE7+SJpjpjWCSyjUgpYwZhLxvfXu4lBOkJIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738608414; c=relaxed/simple;
	bh=ZmPBU+y0wUs+Dct6iyCseKDNT93XKYQWtki3HrGZh9I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poVsHkd1aQ4qjqZ71UoFrbUA8WbwZveU6Ob8rzDd6PPlRDwbEfFKc26P320bQEUeKmwES7EYY9il02gbol+RkoXenlQC64KuZGokk87i8huKx0qg6dH0jWXTdxeY3CjHcEPz0jp2cOGjNk4QSkK0vnDYrfrdOqmXHbOxlmEx3BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=T0T50WP7; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513IHo8R002115
	for <linux-block@vger.kernel.org>; Mon, 3 Feb 2025 10:46:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=CRYlmtHGoiktA/eCNL20FwlrxpVyl/ohOo4w2aG06+M=; b=T0T50WP766gj
	3YC8kKmGOJkP1AH49JGSBoafmicnhf9tx+hBjarsECY/i6GfC182OLN5E65/BlUT
	1/k4fiarPx/Dqhig672oiCRTK8lWJHVOcNdwpBbOIuCiY8gjungehKqcXbXVmS8/
	d6pbAE53wA1o7W309CUaR3dI+JQdzFYCi3AHn+gfEV0hNG85CDHL1iJ0s5j0FULU
	m5GC+vQ7ftUf1K6rKoeIdOkjQJ0uYH0cQE3+yg2L2bWeEMgpCQwv5Cd/NqGNzbKU
	m7YCv6oqETDhQhrdM7s374PA/UiBIZGF5xYR7DD8tg0SZhDrRiMdPcvgoQvLcKfS
	CjYeNKqFHQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44k21ugsgm-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 03 Feb 2025 10:46:51 -0800 (PST)
Received: from twshared55211.03.ash8.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 3 Feb 2025 18:46:50 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id C3E71179C262F; Mon,  3 Feb 2025 10:41:34 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <io-uring@vger.kernel.org>,
        <linux-block@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <asml.silence@gmail.com>,
        <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        Hannes Reinecke
	<hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 07/11] nvme: add a nvme_get_log_lsi helper
Date: Mon, 3 Feb 2025 10:41:25 -0800
Message-ID: <20250203184129.1829324-8-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250203184129.1829324-1-kbusch@meta.com>
References: <20250203184129.1829324-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: je6JKnGdkZa0UWy6BC9D5Xhg-i4ndfPU
X-Proofpoint-GUID: je6JKnGdkZa0UWy6BC9D5Xhg-i4ndfPU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_08,2025-01-31_02,2024-11-22_01

From: Christoph Hellwig <hch@lst.de>

For log pages that need to pass in a LSI value, while at the same time
not touching all the existing nvme_get_log callers.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 653aa6544a90e..8c43823cc37e1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -150,6 +150,8 @@ static void nvme_remove_invalid_namespaces(struct nvm=
e_ctrl *ctrl,
 					   unsigned nsid);
 static void nvme_update_keep_alive(struct nvme_ctrl *ctrl,
 				   struct nvme_command *cmd);
+static int nvme_get_log_lsi(struct nvme_ctrl *ctrl, u32 nsid, u8 log_pag=
e,
+		u8 lsp, u8 csi, void *log, size_t size, u64 offset, u16 lsi);
=20
 void nvme_queue_scan(struct nvme_ctrl *ctrl)
 {
@@ -3083,8 +3085,8 @@ static int nvme_init_subsystem(struct nvme_ctrl *ct=
rl, struct nvme_id_ctrl *id)
 	return ret;
 }
=20
-int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, =
u8 csi,
-		void *log, size_t size, u64 offset)
+static int nvme_get_log_lsi(struct nvme_ctrl *ctrl, u32 nsid, u8 log_pag=
e,
+		u8 lsp, u8 csi, void *log, size_t size, u64 offset, u16 lsi)
 {
 	struct nvme_command c =3D { };
 	u32 dwlen =3D nvme_bytes_to_numd(size);
@@ -3098,10 +3100,18 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid=
, u8 log_page, u8 lsp, u8 csi,
 	c.get_log_page.lpol =3D cpu_to_le32(lower_32_bits(offset));
 	c.get_log_page.lpou =3D cpu_to_le32(upper_32_bits(offset));
 	c.get_log_page.csi =3D csi;
+	c.get_log_page.lsi =3D cpu_to_le16(lsi);
=20
 	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
 }
=20
+int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, =
u8 csi,
+		void *log, size_t size, u64 offset)
+{
+	return nvme_get_log_lsi(ctrl, nsid, log_page, lsp, csi, log, size,
+			offset, 0);
+}
+
 static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
 				struct nvme_effects_log **log)
 {
--=20
2.43.5


