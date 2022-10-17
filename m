Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2B2601622
	for <lists+linux-block@lfdr.de>; Mon, 17 Oct 2022 20:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiJQSRD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 17 Oct 2022 14:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiJQSRB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Oct 2022 14:17:01 -0400
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F73774CF2
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 11:16:50 -0700 (PDT)
Received: by dev1180.prn1.facebook.com (Postfix, from userid 425415)
        id 5B60139C99CE; Mon, 17 Oct 2022 11:13:56 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com,
        willy@infradead.org, hch@infradead.org
Subject: [RFC PATCH v2 14/14] mm: document /sys/class/bdi/<bdi>/min_bytes knob
Date:   Mon, 17 Oct 2022 11:13:37 -0700
Message-Id: <20221017181337.3884657-15-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221017181337.3884657-1-shr@devkernel.io>
References: <20221017181337.3884657-1-shr@devkernel.io>
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

This documents the new /sys/class/bdi/<bdi>/min_bytes knob.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 Documentation/ABI/testing/sysfs-class-bdi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-bdi b/Documentation/AB=
I/testing/sysfs-class-bdi
index 580f723de049..bec996e29565 100644
--- a/Documentation/ABI/testing/sysfs-class-bdi
+++ b/Documentation/ABI/testing/sysfs-class-bdi
@@ -57,6 +57,21 @@ Description:
=20
 	(read-write)
=20
+What:		/sys/class/bdi/<bdi>/min_bytes
+Date:		October 2022
+Contact:	Stefan Roesch <shr@devkernel.io>
+Description:
+	Under normal circumstances each device is given a part of the
+	total write-back cache that relates to its current average
+	writeout speed in relation to the other devices.
+
+	The 'min_bytes' parameter allows assigning a minimum
+	percentage of the write-back cache to a particular device
+    expressed in bytes.
+	For example, this is useful for providing a minimum QoS.
+
+	(read-write)
+
 What:		/sys/class/bdi/<bdi>/max_bytes
 Date:		October 2022
 Contact:	Stefan Roesch <shr@devkernel.io>
--=20
2.30.2

