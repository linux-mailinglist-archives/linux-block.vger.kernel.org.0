Return-Path: <linux-block+bounces-537-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8867FC97C
	for <lists+linux-block@lfdr.de>; Tue, 28 Nov 2023 23:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C987E1C20CF7
	for <lists+linux-block@lfdr.de>; Tue, 28 Nov 2023 22:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA965024B;
	Tue, 28 Nov 2023 22:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="kFSWOWNN"
X-Original-To: linux-block@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E43D85
	for <linux-block@vger.kernel.org>; Tue, 28 Nov 2023 14:28:11 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3ASMGMfu014696
	for <linux-block@vger.kernel.org>; Tue, 28 Nov 2023 14:28:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=CtCSQu7SBwAU5RA4TEPV6ClvLhwUfelUCahho9yo6No=;
 b=kFSWOWNNg1c2o2i3LDqJ/HRlQmRdwjTjFZqxvar/dMbXbEJfwKcMCi5R1+9Piq9tM6BR
 ltUQZ/r2SKuLUG7BOT4yhbTSSphf0U2DEIWAu/z1pr+2j5FPpIdrHSJV1PQKo2Mvopsj
 6FYcVsfOndIb1BJdPRs4hdNoaIWWCoFIVj/p8npN/u9s2w/wrCKzuCeWFriitqdy67Vh
 FKRE8sYp/JaxC6moIxgQr5NRF8xnENL/YScEhCyyOHW6EDMg9UhYWQMKT/o0KHsOvFz4
 xhq4RWLGmFrVgVCAdKpjYxvCYHNBczGPCIkARNFSIPQequuvuU8vUCZhz5LlRPQ1mlyg xQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3unf81cty6-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 28 Nov 2023 14:28:11 -0800
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:28:06 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 7316C2252F0CC; Tue, 28 Nov 2023 14:27:54 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <io-uring@vger.kernel.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <joshi.k@samsung.com>,
        <martin.petersen@oracle.com>, <ming.lei@redhat.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv4 4/4] io_uring: remove uring_cmd cookie
Date: Tue, 28 Nov 2023 14:27:52 -0800
Message-ID: <20231128222752.1767344-5-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128222752.1767344-1-kbusch@meta.com>
References: <20231128222752.1767344-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: F5zg8FrSDNtPhL7RvQrWbaH03TTszWG6
X-Proofpoint-ORIG-GUID: F5zg8FrSDNtPhL7RvQrWbaH03TTszWG6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_24,2023-11-27_01,2023-05-22_02

From: Keith Busch <kbusch@kernel.org>

No more users of this field.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/io_uring.h | 8 ++------
 io_uring/uring_cmd.c     | 1 -
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index fe23bf88f86fa..9e6ce6d4ab51f 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -32,12 +32,8 @@ enum io_uring_cmd_flags {
 struct io_uring_cmd {
 	struct file	*file;
 	const struct io_uring_sqe *sqe;
-	union {
-		/* callback to defer completions to task context */
-		void (*task_work_cb)(struct io_uring_cmd *cmd, unsigned);
-		/* used for polled completion */
-		void *cookie;
-	};
+	/* callback to defer completions to task context */
+	void (*task_work_cb)(struct io_uring_cmd *cmd, unsigned);
 	u32		cmd_op;
 	u32		flags;
 	u8		pdu[32]; /* available inline for free use */
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index acbc2924ecd21..b39ec25c36bc3 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -182,7 +182,6 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int i=
ssue_flags)
 			return -EOPNOTSUPP;
 		issue_flags |=3D IO_URING_F_IOPOLL;
 		req->iopoll_completed =3D 0;
-		WRITE_ONCE(ioucmd->cookie, NULL);
 	}
=20
 	ret =3D file->f_op->uring_cmd(ioucmd, issue_flags);
--=20
2.34.1


