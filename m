Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A0F6308BA
	for <lists+linux-block@lfdr.de>; Sat, 19 Nov 2022 02:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbiKSBsw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 18 Nov 2022 20:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbiKSBs2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 20:48:28 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47F59B7E3
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 17:21:37 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 6272019380D2; Fri, 18 Nov 2022 16:52:18 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com,
        akpm@linux-foundation.org
Subject: [RFC PATCH v4 06/20] mm: split off __bdi_set_max_ratio() function
Date:   Fri, 18 Nov 2022 16:52:01 -0800
Message-Id: <20221119005215.3052436-7-shr@devkernel.io>
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

This splits off __bdi_set_max_ratio() from bdi_set_max_ratio().
__bdi_set_max_ratio() will also be called from bdi_set_max_bytes(),
which will be introduced in the next patch.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 mm/page-writeback.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 719404e0d03d..e74ef596dc27 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -692,14 +692,10 @@ int bdi_set_min_ratio(struct backing_dev_info *bdi,=
 unsigned int min_ratio)
 	return ret;
 }
=20
-int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned max_ratio)
+static int __bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned in=
t max_ratio)
 {
 	int ret =3D 0;
=20
-	if (max_ratio > 100)
-		return -EINVAL;
-	max_ratio *=3D BDI_RATIO_SCALE;
-
 	spin_lock_bh(&bdi_lock);
 	if (bdi->min_ratio > max_ratio) {
 		ret =3D -EINVAL;
@@ -711,6 +707,14 @@ int bdi_set_max_ratio(struct backing_dev_info *bdi, =
unsigned max_ratio)
=20
 	return ret;
 }
+
+int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_rat=
io)
+{
+	if (max_ratio > 100)
+		return -EINVAL;
+
+	return __bdi_set_max_ratio(bdi, max_ratio * BDI_RATIO_SCALE);
+}
 EXPORT_SYMBOL(bdi_set_max_ratio);
=20
 u64 bdi_get_max_bytes(struct backing_dev_info *bdi)
--=20
2.30.2

