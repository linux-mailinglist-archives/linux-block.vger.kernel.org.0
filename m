Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9235396EE
	for <lists+linux-block@lfdr.de>; Tue, 31 May 2022 21:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbiEaTXE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 31 May 2022 15:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347248AbiEaTXA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 15:23:00 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFEC69CD0
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:22:57 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VFiLZb024619
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:22:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=HJNK0c5mX6YX+CKVjOyKTa9QgWojDcOFC9rcet7m5hU=;
 b=BuF77ijzBIeFP7An/UKT7vCVFgYp5c8MuNjrmaK+lhkJkE+fju4+Hv7iKKAH0u8oAClK
 rCCxDNDT7ow+RvTJ8G0gV2uO0r61UTCbjP1VK9FB5r9I4iSdbTgy77gHjjY13T6hOih2
 agtJgKQV9GGwdJZ0l5sLQC3tCyOzxHoA9LI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gbhjsfued-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:22:57 -0700
Received: from twshared8508.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 31 May 2022 12:22:56 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 221AC4924B1B; Tue, 31 May 2022 12:11:38 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv5 11/11] fs: add support for dma aligned direct-io
Date:   Tue, 31 May 2022 12:11:37 -0700
Message-ID: <20220531191137.2291467-12-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220531191137.2291467-1-kbusch@fb.com>
References: <20220531191137.2291467-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VO5lMl8QiClsyjStg2cRr8LHPUgC-d7A
X-Proofpoint-GUID: VO5lMl8QiClsyjStg2cRr8LHPUgC-d7A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-31_07,2022-05-30_03,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Use the address alignment requirements from the block_device for direct
io instead of requiring addresses be aligned to the block size.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 fs/iomap/direct-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 80f9b047aa1b..dd78549d9fd6 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -233,7 +233,6 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 	struct inode *inode =3D iter->inode;
 	unsigned int blkbits =3D blksize_bits(bdev_logical_block_size(iomap->bd=
ev));
 	unsigned int fs_block_size =3D i_blocksize(inode), pad;
-	unsigned int align =3D iov_iter_alignment(dio->submit.iter);
 	loff_t length =3D iomap_length(iter);
 	loff_t pos =3D iter->pos;
 	unsigned int bio_opf;
@@ -244,7 +243,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 	size_t copied =3D 0;
 	size_t orig_count;
=20
-	if ((pos | length | align) & ((1 << blkbits) - 1))
+	if ((pos | length) & ((1 << blkbits) - 1) ||
+	    !bvev_iter_is_aligned(iomap->bdev, dio->submit.iter))
 		return -EINVAL;
=20
 	if (iomap->type =3D=3D IOMAP_UNWRITTEN) {
--=20
2.30.2

