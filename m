Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A79D65F56E
	for <lists+linux-block@lfdr.de>; Thu,  5 Jan 2023 21:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjAEU5T (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 5 Jan 2023 15:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjAEU5T (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Jan 2023 15:57:19 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3023E35933
        for <linux-block@vger.kernel.org>; Thu,  5 Jan 2023 12:57:18 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305KM4Uf010193
        for <linux-block@vger.kernel.org>; Thu, 5 Jan 2023 12:57:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=Itao23zfTfOR2T0HeXnec+oGsVZUH4zqCODN/YrFWnI=;
 b=TyIrvFLLeoLcqXgUvsG6FPH1sDbVroW0z/Aw3Cjv4GR/EJpSdcgNGxYyyIGdjNUnbjB4
 QWFGPlJWjsvmp5/t6ql5IstGcadgccgzsBychc+XtvscCKr8Eoz9QP72qrEZKHb90Zzg
 13JsEEinCuGq9YUWEh+BOMKwVkaQoy9RXqFLJygbFAbQAXMVrifTnoFWu3KcipaGtB9/
 f8OimDFGmAjwN7lGLvEJ1ePO3V1O1Ubwio+UZ0TNU8HRU0kteGrzuZd3paL3b3c29+je
 NdbD9rdYDm13ThzhPLYvq6LPn4zQo9a/qa61IMyIchSahGn2iw5OCTGhtc539tOsyQbD hA== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mx5h2r4va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 05 Jan 2023 12:57:17 -0800
Received: from twshared16996.15.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 5 Jan 2023 12:57:17 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 45937E45DCBD; Thu,  5 Jan 2023 12:51:47 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC:     <hch@lst.de>, <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 1/2] block: make BLK_DEF_MAX_SECTORS unsigned
Date:   Thu, 5 Jan 2023 12:51:45 -0800
Message-ID: <20230105205146.3610282-2-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230105205146.3610282-1-kbusch@meta.com>
References: <20230105205146.3610282-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: kMeF6F8IX3Tfy9ZFLThHonwlyZUXDy6A
X-Proofpoint-ORIG-GUID: kMeF6F8IX3Tfy9ZFLThHonwlyZUXDy6A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_12,2023-01-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

This is used as an unsigned value, so define it that way to avoid
having to cast it.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-settings.c          | 2 +-
 drivers/block/null_blk/main.c | 3 +--
 include/linux/blkdev.h        | 3 ++-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 0477c4d527fee..9875ca131eb0c 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -135,7 +135,7 @@ void blk_queue_max_hw_sectors(struct request_queue *q=
, unsigned int max_hw_secto
 	limits->max_hw_sectors =3D max_hw_sectors;
=20
 	max_sectors =3D min_not_zero(max_hw_sectors, limits->max_dev_sectors);
-	max_sectors =3D min_t(unsigned int, max_sectors, BLK_DEF_MAX_SECTORS);
+	max_sectors =3D min(max_sectors, BLK_DEF_MAX_SECTORS);
 	max_sectors =3D round_down(max_sectors,
 				 limits->logical_block_size >> SECTOR_SHIFT);
 	limits->max_sectors =3D max_sectors;
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
index 7d28e3aa406c2..4c601ca9552a0 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2123,8 +2123,7 @@ static int null_add_dev(struct nullb_device *dev)
 	blk_queue_physical_block_size(nullb->q, dev->blocksize);
 	if (!dev->max_sectors)
 		dev->max_sectors =3D queue_max_hw_sectors(nullb->q);
-	dev->max_sectors =3D min_t(unsigned int, dev->max_sectors,
-				 BLK_DEF_MAX_SECTORS);
+	dev->max_sectors =3D min(dev->max_sectors, BLK_DEF_MAX_SECTORS);
 	blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);
=20
 	if (dev->virt_boundary)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 43d4e073b1115..2b85161e22561 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1095,11 +1095,12 @@ static inline bool bdev_is_partition(struct block=
_device *bdev)
 enum blk_default_limits {
 	BLK_MAX_SEGMENTS	=3D 128,
 	BLK_SAFE_MAX_SECTORS	=3D 255,
-	BLK_DEF_MAX_SECTORS	=3D 2560,
 	BLK_MAX_SEGMENT_SIZE	=3D 65536,
 	BLK_SEG_BOUNDARY_MASK	=3D 0xFFFFFFFFUL,
 };
=20
+#define BLK_DEF_MAX_SECTORS 2560u
+
 static inline unsigned long queue_segment_boundary(const struct request_=
queue *q)
 {
 	return q->limits.seg_boundary_mask;
--=20
2.30.2

