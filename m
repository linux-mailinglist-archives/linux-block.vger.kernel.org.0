Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD52630912
	for <lists+linux-block@lfdr.de>; Sat, 19 Nov 2022 03:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbiKSCF4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 18 Nov 2022 21:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbiKSCFj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 21:05:39 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4612D4F1A5
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 18:03:41 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 742F119380DA; Fri, 18 Nov 2022 16:52:18 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com,
        akpm@linux-foundation.org
Subject: [RFC PATCH v4 10/20] mm: add bdi_get_min_bytes() function.
Date:   Fri, 18 Nov 2022 16:52:05 -0800
Message-Id: <20221119005215.3052436-11-shr@devkernel.io>
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

This adds a function to return the specified value for min_bytes. It
converts the stored min_ratio of the bdi to the corresponding bytes
value. This is an approximation as it is based on the value that is
returned by global_dirty_limits(), which can change. The returned
value can be different than the value when the min_bytes value was set.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 include/linux/backing-dev.h | 1 +
 mm/page-writeback.c         | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index ea6c993433d5..8e04567727e6 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -105,6 +105,7 @@ static inline unsigned long wb_stat_error(void)
 /* BDI ratio is expressed as part per 1000000 for finer granularity. */
 #define BDI_RATIO_SCALE 10000
=20
+u64 bdi_get_min_bytes(struct backing_dev_info *bdi);
 u64 bdi_get_max_bytes(struct backing_dev_info *bdi);
 int bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_rat=
io);
 int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_rat=
io);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 20ae9adeb22f..c47824464f4c 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -740,6 +740,11 @@ int bdi_set_max_ratio(struct backing_dev_info *bdi, =
unsigned int max_ratio)
 }
 EXPORT_SYMBOL(bdi_set_max_ratio);
=20
+u64 bdi_get_min_bytes(struct backing_dev_info *bdi)
+{
+	return bdi_get_bytes(bdi->min_ratio);
+}
+
 u64 bdi_get_max_bytes(struct backing_dev_info *bdi)
 {
 	return bdi_get_bytes(bdi->max_ratio);
--=20
2.30.2

