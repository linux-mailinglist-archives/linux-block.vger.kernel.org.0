Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF96D6308CA
	for <lists+linux-block@lfdr.de>; Sat, 19 Nov 2022 02:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiKSBwi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 18 Nov 2022 20:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbiKSBwP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 20:52:15 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4528154B35
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 17:33:39 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 670C619380D4; Fri, 18 Nov 2022 16:52:18 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com,
        akpm@linux-foundation.org
Subject: [RFC PATCH v4 07/20] mm: add bdi_set_max_bytes() function.
Date:   Fri, 18 Nov 2022 16:52:02 -0800
Message-Id: <20221119005215.3052436-8-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221119005215.3052436-1-shr@devkernel.io>
References: <20221119005215.3052436-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_NEUTRAL,TVD_RCVD_IP autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This introduces the bdi_set_max_bytes() function. The max_bytes function
does not store the max_bytes value. Instead it converts the max_bytes
value into the corresponding ratio value.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 include/linux/backing-dev.h |  1 +
 mm/page-writeback.c         | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 473686c32775..ea6c993433d5 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -108,6 +108,7 @@ static inline unsigned long wb_stat_error(void)
 u64 bdi_get_max_bytes(struct backing_dev_info *bdi);
 int bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_rat=
io);
 int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_rat=
io);
+int bdi_set_max_bytes(struct backing_dev_info *bdi, u64 max_bytes);
 int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int stri=
ct_limit);
=20
 /*
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index e74ef596dc27..20ae9adeb22f 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -13,6 +13,7 @@
  */
=20
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/export.h>
 #include <linux/spinlock.h>
 #include <linux/fs.h>
@@ -650,6 +651,28 @@ void wb_domain_exit(struct wb_domain *dom)
  */
 static unsigned int bdi_min_ratio;
=20
+static int bdi_check_pages_limit(unsigned long pages)
+{
+	unsigned long max_dirty_pages =3D global_dirtyable_memory();
+
+	if (pages > max_dirty_pages)
+		return -EINVAL;
+
+	return 0;
+}
+
+static unsigned long bdi_ratio_from_pages(unsigned long pages)
+{
+	unsigned long background_thresh;
+	unsigned long dirty_thresh;
+	unsigned long ratio;
+
+	global_dirty_limits(&background_thresh, &dirty_thresh);
+	ratio =3D div64_u64(pages * 100ULL * BDI_RATIO_SCALE, dirty_thresh);
+
+	return ratio;
+}
+
 static u64 bdi_get_bytes(unsigned int ratio)
 {
 	unsigned long background_thresh;
@@ -722,6 +745,20 @@ u64 bdi_get_max_bytes(struct backing_dev_info *bdi)
 	return bdi_get_bytes(bdi->max_ratio);
 }
=20
+int bdi_set_max_bytes(struct backing_dev_info *bdi, u64 max_bytes)
+{
+	int ret;
+	unsigned long pages =3D max_bytes >> PAGE_SHIFT;
+	unsigned long max_ratio;
+
+	ret =3D bdi_check_pages_limit(pages);
+	if (ret)
+		return ret;
+
+	max_ratio =3D bdi_ratio_from_pages(pages);
+	return __bdi_set_max_ratio(bdi, max_ratio);
+}
+
 int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int stri=
ct_limit)
 {
 	if (strict_limit > 1)
--=20
2.30.2

