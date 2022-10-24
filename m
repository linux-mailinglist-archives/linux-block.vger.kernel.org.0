Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EAD60BBA2
	for <lists+linux-block@lfdr.de>; Mon, 24 Oct 2022 23:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiJXVHo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 24 Oct 2022 17:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiJXVH3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Oct 2022 17:07:29 -0400
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED417117035
        for <linux-block@vger.kernel.org>; Mon, 24 Oct 2022 12:14:14 -0700 (PDT)
Received: by dev1180.prn1.facebook.com (Postfix, from userid 425415)
        id 81FC93ED591C; Mon, 24 Oct 2022 12:06:12 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com,
        willy@infradead.org, hch@infradead.org
Subject: [RFC PATCH v3 10/14] mm: add bdi_get_min_bytes() function.
Date:   Mon, 24 Oct 2022 12:05:59 -0700
Message-Id: <20221024190603.3987969-11-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221024190603.3987969-1-shr@devkernel.io>
References: <20221024190603.3987969-1-shr@devkernel.io>
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
 mm/page-writeback.c         | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 5eb1ae3410b2..621329f25bbe 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -105,6 +105,7 @@ static inline unsigned long wb_stat_error(void)
 /* BDI ratio is expressed as part per 1000 for finer granularity. */
 #define BDI_RATIO_SCALE 10
=20
+unsigned long long bdi_get_min_bytes(struct backing_dev_info *bdi);
 unsigned long long bdi_get_max_bytes(struct backing_dev_info *bdi);
 int bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_rat=
io);
 int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_rat=
io);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 21d7c1880ea8..69fc2866e625 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -740,6 +740,12 @@ int bdi_set_max_ratio(struct backing_dev_info *bdi, =
unsigned int max_ratio)
 }
 EXPORT_SYMBOL(bdi_set_max_ratio);
=20
+unsigned long long bdi_get_min_bytes(struct backing_dev_info *bdi)
+{
+	return bdi_get_bytes(bdi->min_ratio);
+}
+EXPORT_SYMBOL_GPL(bdi_get_min_bytes);
+
 unsigned long long bdi_get_max_bytes(struct backing_dev_info *bdi)
 {
 	return bdi_get_bytes(bdi->max_ratio);
--=20
2.30.2

