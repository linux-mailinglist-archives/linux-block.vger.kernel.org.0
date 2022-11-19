Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60740630A61
	for <lists+linux-block@lfdr.de>; Sat, 19 Nov 2022 03:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiKSC0R (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 18 Nov 2022 21:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbiKSCYo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 21:24:44 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF58C7596
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 18:15:43 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 891E619380E6; Fri, 18 Nov 2022 16:52:18 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com,
        akpm@linux-foundation.org
Subject: [RFC PATCH v4 15/20] mm: add bdi_set_max_ratio_no_scale() function
Date:   Fri, 18 Nov 2022 16:52:10 -0800
Message-Id: <20221119005215.3052436-16-shr@devkernel.io>
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

This introduces bdi_set_max_ratio_no_scale(). It uses the max
granularity for the ratio. This function by the new sysfs knob
max_ratio_fine.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 include/linux/backing-dev.h |  1 +
 mm/page-writeback.c         | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 572669758c7f..d9acbb22ff25 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -109,6 +109,7 @@ u64 bdi_get_min_bytes(struct backing_dev_info *bdi);
 u64 bdi_get_max_bytes(struct backing_dev_info *bdi);
 int bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_rat=
io);
 int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_rat=
io);
+int bdi_set_max_ratio_no_scale(struct backing_dev_info *bdi, unsigned in=
t max_ratio);
 int bdi_set_min_bytes(struct backing_dev_info *bdi, u64 min_bytes);
 int bdi_set_max_bytes(struct backing_dev_info *bdi, u64 max_bytes);
 int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int stri=
ct_limit);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 3d151e7a9b6c..f44ade72966c 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -719,6 +719,9 @@ static int __bdi_set_max_ratio(struct backing_dev_inf=
o *bdi, unsigned int max_ra
 {
 	int ret =3D 0;
=20
+	if (max_ratio > 100 * BDI_RATIO_SCALE)
+		return -EINVAL;
+
 	spin_lock_bh(&bdi_lock);
 	if (bdi->min_ratio > max_ratio) {
 		ret =3D -EINVAL;
@@ -731,6 +734,11 @@ static int __bdi_set_max_ratio(struct backing_dev_in=
fo *bdi, unsigned int max_ra
 	return ret;
 }
=20
+int bdi_set_max_ratio_no_scale(struct backing_dev_info *bdi, unsigned in=
t max_ratio)
+{
+	return __bdi_set_max_ratio(bdi, max_ratio);
+}
+
 int bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_rat=
io)
 {
 	return __bdi_set_min_ratio(bdi, min_ratio * BDI_RATIO_SCALE);
@@ -738,9 +746,6 @@ int bdi_set_min_ratio(struct backing_dev_info *bdi, u=
nsigned int min_ratio)
=20
 int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_rat=
io)
 {
-	if (max_ratio > 100)
-		return -EINVAL;
-
 	return __bdi_set_max_ratio(bdi, max_ratio * BDI_RATIO_SCALE);
 }
 EXPORT_SYMBOL(bdi_set_max_ratio);
--=20
2.30.2

