Return-Path: <linux-block+bounces-1340-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DD581ACD7
	for <lists+linux-block@lfdr.de>; Thu, 21 Dec 2023 04:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2711F21FFC
	for <lists+linux-block@lfdr.de>; Thu, 21 Dec 2023 03:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF9C8F54;
	Thu, 21 Dec 2023 03:01:20 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D698F52;
	Thu, 21 Dec 2023 03:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7b55f3bcf43a41c4aec9b6ba6e278ec2-20231221
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:ada57bc5-8679-49e8-bb38-eba6e84ae9bd,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:35
X-CID-INFO: VERSION:1.1.33,REQID:ada57bc5-8679-49e8-bb38-eba6e84ae9bd,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:35
X-CID-META: VersionHash:364b77b,CLOUDID:c4e40082-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:231221110100PRPDICKD,BulkQuantity:0,Recheck:0,SF:66|24|72|19|44|102,
	TC:nil,Content:0,EDM:5,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-UUID: 7b55f3bcf43a41c4aec9b6ba6e278ec2-20231221
Received: from node4.com.cn [(39.156.73.12)] by mailgw
	(envelope-from <liyouhong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1660399244; Thu, 21 Dec 2023 11:00:58 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id D699016001CD7;
	Thu, 21 Dec 2023 11:00:57 +0800 (CST)
X-ns-mid: postfix-6583AA69-6562031
Received: from localhost.localdomain (unknown [172.20.185.164])
	by node4.com.cn (NSMail) with ESMTPA id 5302416001CD7;
	Thu, 21 Dec 2023 03:00:57 +0000 (UTC)
From: YouHong Li <liyouhong@kylinos.cn>
To: jgross@suse.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liyouhong <liyouhong@kylinos.cn>,
	k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] drivers/block/xen-blkback/common.h: Fix spelling typo in comment
Date: Thu, 21 Dec 2023 11:00:14 +0800
Message-Id: <20231221030014.1319663-1-liyouhong@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: liyouhong <liyouhong@kylinos.cn>

Fix spelling typo in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: liyouhong <liyouhong@kylinos.cn>

diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkba=
ck/common.h
index 40f67bfc052d..c64253d3bb40 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -132,7 +132,7 @@ struct blkif_x86_32_request {
 struct blkif_x86_64_request_rw {
 	uint8_t        nr_segments;  /* number of segments                   */
 	blkif_vdev_t   handle;       /* only for read/write requests         */
-	uint32_t       _pad1;        /* offsetof(blkif_reqest..,u.rw.id)=3D=3D8=
  */
+	uint32_t       _pad1;        /* offsetof(blkif_request..,u.rw.id)=3D=3D=
8  */
 	uint64_t       id;
 	blkif_sector_t sector_number;/* start sector idx on disk (r/w only)  */
 	struct blkif_request_segment seg[BLKIF_MAX_SEGMENTS_PER_REQUEST];
--=20
2.34.1


