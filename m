Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110DB630899
	for <lists+linux-block@lfdr.de>; Sat, 19 Nov 2022 02:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiKSBoQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 18 Nov 2022 20:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbiKSBn6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 20:43:58 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24917BE274
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 16:57:37 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 5DF8C19380D0; Fri, 18 Nov 2022 16:52:18 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com,
        akpm@linux-foundation.org
Subject: [RFC PATCH v4 05/20] mm: add bdi_get_max_bytes() function
Date:   Fri, 18 Nov 2022 16:52:00 -0800
Message-Id: <20221119005215.3052436-6-shr@devkernel.io>
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

This adds a function to return the specified value for max_bytes. It
converts the stored max_ratio of the bdi to the corresponding bytes
value. It introduces the bdi_get_bytes helper function to do the
conversion. This is an approximation as it is based on the value that is
returned by global_dirty_limits(), which can change. The helper function
will also be used by the min_bytes bdi knob.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 include/linux/backing-dev.h |  1 +
 mm/page-writeback.c         | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 1b50c028e5ad..473686c32775 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -105,6 +105,7 @@ static inline unsigned long wb_stat_error(void)
 /* BDI ratio is expressed as part per 1000000 for finer granularity. */
 #define BDI_RATIO_SCALE 10000
=20
+u64 bdi_get_max_bytes(struct backing_dev_info *bdi);
 int bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_rat=
io);
 int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_rat=
io);
 int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int stri=
ct_limit);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index dd98b2654302..719404e0d03d 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -650,6 +650,18 @@ void wb_domain_exit(struct wb_domain *dom)
  */
 static unsigned int bdi_min_ratio;
=20
+static u64 bdi_get_bytes(unsigned int ratio)
+{
+	unsigned long background_thresh;
+	unsigned long dirty_thresh;
+	u64 bytes;
+
+	global_dirty_limits(&background_thresh, &dirty_thresh);
+	bytes =3D (dirty_thresh * PAGE_SIZE * ratio) / BDI_RATIO_SCALE / 100;
+
+	return bytes;
+}
+
 int bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_rat=
io)
 {
 	unsigned int delta;
@@ -701,6 +713,11 @@ int bdi_set_max_ratio(struct backing_dev_info *bdi, =
unsigned max_ratio)
 }
 EXPORT_SYMBOL(bdi_set_max_ratio);
=20
+u64 bdi_get_max_bytes(struct backing_dev_info *bdi)
+{
+	return bdi_get_bytes(bdi->max_ratio);
+}
+
 int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int stri=
ct_limit)
 {
 	if (strict_limit > 1)
--=20
2.30.2

