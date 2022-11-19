Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F737630ADA
	for <lists+linux-block@lfdr.de>; Sat, 19 Nov 2022 03:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiKSCvR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 18 Nov 2022 21:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbiKSCuy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 21:50:54 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9935E9FE
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 18:39:44 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 99BAD19380EF; Fri, 18 Nov 2022 16:52:18 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com,
        akpm@linux-foundation.org
Subject: [RFC PATCH v4 19/20] mm: add /sys/class/bdi/<bdi>/min_ratio_fine knob
Date:   Fri, 18 Nov 2022 16:52:14 -0800
Message-Id: <20221119005215.3052436-20-shr@devkernel.io>
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

This adds the min_ratio_fine knob. The knob specifies the values not
based on 1 of 100, but instead 1 per million.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 mm/backing-dev.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 94c2382367cf..a53b9360b72e 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -180,6 +180,25 @@ static ssize_t min_ratio_store(struct device *dev,
 }
 BDI_SHOW(min_ratio, bdi->min_ratio / BDI_RATIO_SCALE)
=20
+static ssize_t min_ratio_fine_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct backing_dev_info *bdi =3D dev_get_drvdata(dev);
+	unsigned int ratio;
+	ssize_t ret;
+
+	ret =3D kstrtouint(buf, 10, &ratio);
+	if (ret < 0)
+		return ret;
+
+	ret =3D bdi_set_min_ratio_no_scale(bdi, ratio);
+	if (!ret)
+		ret =3D count;
+
+	return ret;
+}
+BDI_SHOW(min_ratio_fine, bdi->min_ratio)
+
 static ssize_t max_ratio_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
@@ -315,6 +334,7 @@ static DEVICE_ATTR_RW(strict_limit);
 static struct attribute *bdi_dev_attrs[] =3D {
 	&dev_attr_read_ahead_kb.attr,
 	&dev_attr_min_ratio.attr,
+	&dev_attr_min_ratio_fine.attr,
 	&dev_attr_max_ratio.attr,
 	&dev_attr_max_ratio_fine.attr,
 	&dev_attr_min_bytes.attr,
--=20
2.30.2

