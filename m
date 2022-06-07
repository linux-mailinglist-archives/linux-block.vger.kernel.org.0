Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EBF539701
	for <lists+linux-block@lfdr.de>; Tue, 31 May 2022 21:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347285AbiEaT2x (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 31 May 2022 15:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347282AbiEaT2w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 15:28:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B188996A7
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:28:51 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24VFiHNv013596
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:28:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=lI9/WEjnfnDuWcRiQSaF2aLpe846GbmeqIxTbGLKddc=;
 b=ZauHY6c4d/ia/pDbpjVxQCViArpCov5euMiuw68ev04j96FzFiJ8nTy+AnZ2mvEHUgak
 ShSU5+rVKtZJGXHLRFIVi+gInb6rq11g3zn2XggBWCEazLGpXCrudr4Rj20DJJMcB9DN
 gbJfwn3GW4MtIzQkMXXlI8XJMpORm6JTdMo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3gbfdtg7nf-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:28:50 -0700
Received: from twshared14818.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 31 May 2022 12:28:49 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id F19C44924B18; Tue, 31 May 2022 12:11:38 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCHv5 08/11] iov: introduce iov_iter_aligned
Date:   Tue, 31 May 2022 12:11:34 -0700
Message-ID: <20220531191137.2291467-9-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220531191137.2291467-1-kbusch@fb.com>
References: <20220531191137.2291467-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Qu387vanj-UZcx09D8K-iPbLkCuj7Lp8
X-Proofpoint-GUID: Qu387vanj-UZcx09D8K-iPbLkCuj7Lp8
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

The existing iov_iter_alignment() function returns the logical OR of
address and length. For cases where address and length need to be
considered separately, introduce a helper function that a caller can
specificy length and address masks that indicate if the iov is
unaligned.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/uio.h |  2 +
 lib/iov_iter.c      | 92 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 739285fe5a2f..34ba4a731179 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -219,6 +219,8 @@ size_t _copy_mc_to_iter(const void *addr, size_t byte=
s, struct iov_iter *i);
 #endif
=20
 size_t iov_iter_zero(size_t bytes, struct iov_iter *);
+bool iov_iter_is_aligned(const struct iov_iter *i, unsigned addr_mask,
+			unsigned len_mask);
 unsigned long iov_iter_alignment(const struct iov_iter *i);
 unsigned long iov_iter_gap_alignment(const struct iov_iter *i);
 void iov_iter_init(struct iov_iter *i, unsigned int direction, const str=
uct iovec *iov,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6dd5330f7a99..a39b24496878 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1268,6 +1268,98 @@ void iov_iter_discard(struct iov_iter *i, unsigned=
 int direction, size_t count)
 }
 EXPORT_SYMBOL(iov_iter_discard);
=20
+static bool iov_iter_aligned_iovec(const struct iov_iter *i, unsigned ad=
dr_mask,
+				   unsigned len_mask)
+{
+	size_t size =3D i->count;
+	size_t skip =3D i->iov_offset;
+	unsigned k;
+
+	for (k =3D 0; k < i->nr_segs; k++, skip =3D 0) {
+		size_t len =3D i->iov[k].iov_len - skip;
+
+		if (len > size)
+			len =3D size;
+		if (len & len_mask)
+			return false;
+		if ((unsigned long)(i->iov[k].iov_base + skip) & addr_mask)
+			return false;
+
+		size -=3D len;
+		if (!size)
+			break;
+	}
+	return true;
+}
+
+static bool iov_iter_aligned_bvec(const struct iov_iter *i, unsigned add=
r_mask,
+				  unsigned len_mask)
+{
+	size_t size =3D i->count;
+	unsigned skip =3D i->iov_offset;
+	unsigned k;
+
+	for (k =3D 0; k < i->nr_segs; k++, skip =3D 0) {
+		size_t len =3D i->bvec[k].bv_len - skip;
+
+		if (len > size)
+			len =3D size;
+		if (len & len_mask)
+			return false;
+		if ((unsigned long)(i->bvec[k].bv_offset + skip) & addr_mask)
+			return false;
+
+		size -=3D len;
+		if (!size)
+			break;
+	}
+	return true;
+}
+
+/**
+ * iov_iter_is_aligned() - Check if the addresses and lengths of each se=
gments
+ * 	are aligned to the parameters.
+ *
+ * @i: &struct iov_iter to restore
+ * @addr_mask: bit mask to check against the iov element's addresses
+ * @len_mask: bit mask to check against the iov element's lengths
+ *
+ * Return: false if any addresses or lengths intersect with the provided=
 masks
+ */
+bool iov_iter_is_aligned(const struct iov_iter *i, unsigned addr_mask,
+			 unsigned len_mask)
+{
+	if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i)))
+		return iov_iter_aligned_iovec(i, addr_mask, len_mask);
+
+	if (iov_iter_is_bvec(i))
+		return iov_iter_aligned_bvec(i, addr_mask, len_mask);
+
+	if (iov_iter_is_pipe(i)) {
+		unsigned int p_mask =3D i->pipe->ring_size - 1;
+		size_t size =3D i->count;
+
+		if (size & len_mask)
+			return false;
+		if (size && allocated(&i->pipe->bufs[i->head & p_mask])) {
+			if (i->iov_offset & addr_mask)
+				return false;
+		}
+
+		return true;
+	}
+
+	if (iov_iter_is_xarray(i)) {
+		if (i->count & len_mask)
+			return false;
+		if ((i->xarray_start + i->iov_offset) & addr_mask)
+			return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(iov_iter_is_aligned);
+
 static unsigned long iov_iter_alignment_iovec(const struct iov_iter *i)
 {
 	unsigned long res =3D 0;
--=20
2.30.2

