Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9C2630AD1
	for <lists+linux-block@lfdr.de>; Sat, 19 Nov 2022 03:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiKSCnj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 18 Nov 2022 21:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiKSCnV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 21:43:21 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E940DC78E2
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 18:27:44 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 80F9919380E2; Fri, 18 Nov 2022 16:52:18 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com,
        akpm@linux-foundation.org
Subject: [RFC PATCH v4 13/20] mm: add /sys/class/bdi/<bdi>/min_bytes knob
Date:   Fri, 18 Nov 2022 16:52:08 -0800
Message-Id: <20221119005215.3052436-14-shr@devkernel.io>
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

bdi has two existing knobs to limit the amount of dirty memory:
min_ratio and max_ratio. However the granularity of the knobs is limited
and often it is more convenient to specify limits in terms of bytes.
This change adds the min_bytes knob.

It does not store the min_bytes value, instead it converts the max_bytes
value to a ratio. The value is therefore more an approximation than an
absolute value.

It also maintains the sum over all the bdi min_ratio values stored in
the variable bdi_min_ratio.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 mm/backing-dev.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 95d3229fc81f..3fab79061ade 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -199,6 +199,34 @@ static ssize_t max_ratio_store(struct device *dev,
 }
 BDI_SHOW(max_ratio, bdi->max_ratio / BDI_RATIO_SCALE)
=20
+static ssize_t min_bytes_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct backing_dev_info *bdi =3D dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%llu\n", bdi_get_min_bytes(bdi));
+}
+
+static ssize_t min_bytes_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct backing_dev_info *bdi =3D dev_get_drvdata(dev);
+	u64 bytes;
+	ssize_t ret;
+
+	ret =3D kstrtoull(buf, 10, &bytes);
+	if (ret < 0)
+		return ret;
+
+	ret =3D bdi_set_min_bytes(bdi, bytes);
+	if (!ret)
+		ret =3D count;
+
+	return ret;
+}
+DEVICE_ATTR_RW(min_bytes);
+
 static ssize_t max_bytes_show(struct device *dev,
 			      struct device_attribute *attr,
 			      char *buf)
@@ -269,6 +297,7 @@ static struct attribute *bdi_dev_attrs[] =3D {
 	&dev_attr_read_ahead_kb.attr,
 	&dev_attr_min_ratio.attr,
 	&dev_attr_max_ratio.attr,
+	&dev_attr_min_bytes.attr,
 	&dev_attr_max_bytes.attr,
 	&dev_attr_stable_pages_required.attr,
 	&dev_attr_strict_limit.attr,
--=20
2.30.2

