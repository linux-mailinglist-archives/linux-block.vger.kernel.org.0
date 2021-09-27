Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0183A4195FE
	for <lists+linux-block@lfdr.de>; Mon, 27 Sep 2021 16:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbhI0OMB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 27 Sep 2021 10:12:01 -0400
Received: from condef-08.nifty.com ([202.248.20.73]:33484 "EHLO
        condef-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbhI0OL6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 10:11:58 -0400
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-08.nifty.com with ESMTP id 18RE19HL028538
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 23:01:09 +0900
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 18RE07G0028280;
        Mon, 27 Sep 2021 23:00:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 18RE07G0028280
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1632751209;
        bh=A+BkteJsqOiCj+z6B2881OBPKBaV4HPokeV46N2OmSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JYMm4/RAQMnWOXdwLovsdIOhLVi5M69GwZTmkJz53e4GW6EOr7SgVYUIREEMBS/Ay
         XhZtUYOgn2xhAT1TAbm/4oZnqMzLJHCsqsGuZe0tIP0ptUtt/MGoJH2cvRm3nAdu5f
         a08eA18AULPjYz6YI4UxTlBJqHnyWQXLm29LTKigkx5+18FYbbui4Qe2koVJaqauiY
         rT23mK9CWQLKUVFVkEmX4AyxH/FKSTz2V644EVVn4dG7xAqjwXQWTZoK2sRrVYzADk
         WjfI41HxkYdCPpTv7QmigxGvM975r13OpE502YQ8ygg2dD/tnyUivbGNC2unKzrktE
         0uzgoVTQM4tog==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [RESEND PATCH 3/4] block: move menu "Partition type" to block/partitions/Kconfig
Date:   Mon, 27 Sep 2021 22:59:59 +0900
Message-Id: <20210927140000.866249-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210927140000.866249-1-masahiroy@kernel.org>
References: <20210927140000.866249-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move the menu to the relevant place.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 block/Kconfig            | 4 ----
 block/partitions/Kconfig | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index c4d35829ea4f..c6ce41a5e5b2 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -190,12 +190,8 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
 	  by falling back to the kernel crypto API when inline
 	  encryption hardware is not present.
 
-menu "Partition Types"
-
 source "block/partitions/Kconfig"
 
-endmenu
-
 config BLOCK_COMPAT
 	def_bool COMPAT
 
diff --git a/block/partitions/Kconfig b/block/partitions/Kconfig
index 278593b8e4e9..7aff4eb81c60 100644
--- a/block/partitions/Kconfig
+++ b/block/partitions/Kconfig
@@ -2,6 +2,8 @@
 #
 # Partition configuration
 #
+menu "Partition Types"
+
 config PARTITION_ADVANCED
 	bool "Advanced partition selection"
 	help
@@ -267,3 +269,5 @@ config CMDLINE_PARTITION
 	help
 	  Say Y here if you want to read the partition table from bootargs.
 	  The format for the command line is just like mtdparts.
+
+endmenu
-- 
2.30.2

