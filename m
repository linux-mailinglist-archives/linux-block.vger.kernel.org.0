Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38ED363089D
	for <lists+linux-block@lfdr.de>; Sat, 19 Nov 2022 02:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiKSBpN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 18 Nov 2022 20:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbiKSBov (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 20:44:51 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5FB776E9
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 17:03:37 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 599CC19380CE; Fri, 18 Nov 2022 16:52:18 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com,
        akpm@linux-foundation.org
Subject: [RFC PATCH v4 04/20] mm: use part per 1000000 for bdi ratios.
Date:   Fri, 18 Nov 2022 16:51:59 -0800
Message-Id: <20221119005215.3052436-5-shr@devkernel.io>
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

To get finer granularity for ratio calculations use part per million
instead of percentiles. This is especially important if we want to
automatically convert byte values to ratios. Otherwise the values that
are actually used can be quite different. This is also important for
machines with more main memory (1% of 256GB is already 2.5GB).

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 include/linux/backing-dev.h |  3 +++
 mm/backing-dev.c            |  6 +++---
 mm/page-writeback.c         | 15 +++++++++------
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 9c984ffc8a0a..1b50c028e5ad 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -102,6 +102,9 @@ static inline unsigned long wb_stat_error(void)
 #endif
 }
=20
+/* BDI ratio is expressed as part per 1000000 for finer granularity. */
+#define BDI_RATIO_SCALE 10000
+
 int bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_rat=
io);
 int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_rat=
io);
 int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int stri=
ct_limit);
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index a0899cce72ef..90fa517123dc 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -178,7 +178,7 @@ static ssize_t min_ratio_store(struct device *dev,
=20
 	return ret;
 }
-BDI_SHOW(min_ratio, bdi->min_ratio)
+BDI_SHOW(min_ratio, bdi->min_ratio / BDI_RATIO_SCALE)
=20
 static ssize_t max_ratio_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
@@ -197,7 +197,7 @@ static ssize_t max_ratio_store(struct device *dev,
=20
 	return ret;
 }
-BDI_SHOW(max_ratio, bdi->max_ratio)
+BDI_SHOW(max_ratio, bdi->max_ratio / BDI_RATIO_SCALE)
=20
 static ssize_t stable_pages_required_show(struct device *dev,
 					  struct device_attribute *attr,
@@ -809,7 +809,7 @@ int bdi_init(struct backing_dev_info *bdi)
=20
 	kref_init(&bdi->refcnt);
 	bdi->min_ratio =3D 0;
-	bdi->max_ratio =3D 100;
+	bdi->max_ratio =3D 100 * BDI_RATIO_SCALE;
 	bdi->max_prop_frac =3D FPROP_FRAC_BASE;
 	INIT_LIST_HEAD(&bdi->bdi_list);
 	INIT_LIST_HEAD(&bdi->wb_list);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 3745b886722f..dd98b2654302 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -197,7 +197,7 @@ static void wb_min_max_ratio(struct bdi_writeback *wb=
,
 			min *=3D this_bw;
 			min =3D div64_ul(min, tot_bw);
 		}
-		if (max < 100) {
+		if (max < 100 * BDI_RATIO_SCALE) {
 			max *=3D this_bw;
 			max =3D div64_ul(max, tot_bw);
 		}
@@ -655,6 +655,8 @@ int bdi_set_min_ratio(struct backing_dev_info *bdi, u=
nsigned int min_ratio)
 	unsigned int delta;
 	int ret =3D 0;
=20
+	min_ratio *=3D BDI_RATIO_SCALE;
+
 	spin_lock_bh(&bdi_lock);
 	if (min_ratio > bdi->max_ratio) {
 		ret =3D -EINVAL;
@@ -665,7 +667,7 @@ int bdi_set_min_ratio(struct backing_dev_info *bdi, u=
nsigned int min_ratio)
 			bdi->min_ratio =3D min_ratio;
 		} else {
 			delta =3D min_ratio - bdi->min_ratio;
-			if (bdi_min_ratio + delta < 100) {
+			if (bdi_min_ratio + delta < 100 * BDI_RATIO_SCALE) {
 				bdi_min_ratio +=3D delta;
 				bdi->min_ratio =3D min_ratio;
 			} else {
@@ -684,6 +686,7 @@ int bdi_set_max_ratio(struct backing_dev_info *bdi, u=
nsigned max_ratio)
=20
 	if (max_ratio > 100)
 		return -EINVAL;
+	max_ratio *=3D BDI_RATIO_SCALE;
=20
 	spin_lock_bh(&bdi_lock);
 	if (bdi->min_ratio > max_ratio) {
@@ -775,15 +778,15 @@ static unsigned long __wb_calc_thresh(struct dirty_=
throttle_control *dtc)
 	fprop_fraction_percpu(&dom->completions, dtc->wb_completions,
 			      &numerator, &denominator);
=20
-	wb_thresh =3D (thresh * (100 - bdi_min_ratio)) / 100;
+	wb_thresh =3D (thresh * (100 * BDI_RATIO_SCALE - bdi_min_ratio)) / (100=
 * BDI_RATIO_SCALE);
 	wb_thresh *=3D numerator;
 	wb_thresh =3D div64_ul(wb_thresh, denominator);
=20
 	wb_min_max_ratio(dtc->wb, &wb_min_ratio, &wb_max_ratio);
=20
-	wb_thresh +=3D (thresh * wb_min_ratio) / 100;
-	if (wb_thresh > (thresh * wb_max_ratio) / 100)
-		wb_thresh =3D thresh * wb_max_ratio / 100;
+	wb_thresh +=3D (thresh * wb_min_ratio) / (100 * BDI_RATIO_SCALE);
+	if (wb_thresh > (thresh * wb_max_ratio) / (100 * BDI_RATIO_SCALE))
+		wb_thresh =3D thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);
=20
 	return wb_thresh;
 }
--=20
2.30.2

