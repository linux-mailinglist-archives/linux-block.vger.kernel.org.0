Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B2428DC06
	for <lists+linux-block@lfdr.de>; Wed, 14 Oct 2020 10:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgJNIwA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 14 Oct 2020 04:52:00 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17166 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727948AbgJNIv7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Oct 2020 04:51:59 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Oct 2020 04:51:59 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1602664598; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=XoTTM9JpMCEv+gu73GyuPjFCy7Fxw/rg4tWoMdhYkUyDyBRzdiFS2i35s2nLoiFy0qu1u2O6KsklkdRcN0ZnZroKrug6aGSKRPe6Ca5VBGCpCfHMTE5grP8iGchPgr5DMgXBI3t0+VtmVNHnv7JN8Tum9PXmU8/gAUMJiGHP13k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1602664598; h=Cc:Date:From:Message-ID:Subject:To; 
        bh=0uL8b9AiSLJuL9HLBQKKq6Ra1n1uMLHNHnZhsDTdvh8=; 
        b=SzbE6R4t1Bvc/zT8+WBL9ZPy78SHLNB+Tk9+21FcZtpARaoiOOLpC9eaav0DH7qLBqrE9C7NPaCLi6y863FPP22AFK6PPpX8S4S6OnIZ7cLLM8JcLzJSPCCJ/OH9Kzy3LHxnhtCifjZDfPx6HXOVI6m87GD7hIk6hKHbdKozLx4=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1602664598;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=0uL8b9AiSLJuL9HLBQKKq6Ra1n1uMLHNHnZhsDTdvh8=;
        b=cuAfQosDHa/fv2rgcSScgWwdQmZmIe8oldQmW5ssTnq/2so5b75c6Xb1q2mHlnjd
        gXwgMijyMPK8apSF5DOHQtDm/+g3ELwMC7RvX6sInGorA/qZdkaaFPLK6apv/gmIS3A
        fKa0JOLvyN4itQFQDI5vCykcCT5JLtB61qz2CehQ=
Received: from localhost.localdomain (81.71.33.115 [81.71.33.115]) by mx.zoho.com.cn
        with SMTPS id 1602664596568242.13266844437942; Wed, 14 Oct 2020 16:36:36 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Subject: [PATCH] block: always set bslab->slab to NULL when creating new slab
Date:   Wed, 14 Oct 2020 16:36:08 +0800
Message-Id: <20201014083608.310098-1-cgxu519@mykernel.net>
X-Mailer: git-send-email 2.18.4
X-ZohoCNMailClient: External
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When fail to create new slab and if the entry slot is acquired
by extending bio_slab_max, bslab->slab will contain uninitialized
data and it may affect subsequent search.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index 640d0fb74a8b..01ece8dbfc7f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -104,6 +104,7 @@ static struct kmem_cache *bio_find_or_create_slab(unsigned int extra_size)
 	bslab = &bio_slabs[entry];
 
 	snprintf(bslab->name, sizeof(bslab->name), "bio-%d", entry);
+	bslab->slab = NULL;
 	slab = kmem_cache_create(bslab->name, sz, ARCH_KMALLOC_MINALIGN,
 				 SLAB_HWCACHE_ALIGN, NULL);
 	if (!slab)
-- 
2.18.4

