Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DB526BB24
	for <lists+linux-block@lfdr.de>; Wed, 16 Sep 2020 05:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgIPDyN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 15 Sep 2020 23:54:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbgIPDyH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Sep 2020 23:54:07 -0400
Received: from sol.attlocal.net (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC4FA221E7;
        Wed, 16 Sep 2020 03:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600228447;
        bh=sKfndHdiXCcM6425hNhDhw2SooX9ZNQ+cnCmVRd8T4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XoetrHzn1PwlFoJ5BRHB0T4PvB0DmKVyDgeMIJK8lH19VxnnSnaCUxpMLxhcD6svC
         oqEtSGiGSieXVjistOdWBFbFNqg+ewFRGTApVxQAqW204F4CfHLNVJsWq1xsqmkn/K
         UUph6N5aO5ovsoGw+SmuzUrVzNva8xXYLC/KK+Aw=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, Satya Tangirala <satyat@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: [PATCH v2 3/3] block: warn if !__GFP_DIRECT_RECLAIM in bio_crypt_set_ctx()
Date:   Tue, 15 Sep 2020 20:53:15 -0700
Message-Id: <20200916035315.34046-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916035315.34046-1-ebiggers@kernel.org>
References: <20200916035315.34046-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

bio_crypt_set_ctx() assumes its gfp_mask argument always includes
__GFP_DIRECT_RECLAIM, so that the mempool_alloc() will always succeed.

For now this assumption is still fine, since no callers violate it.
Making bio_crypt_set_ctx() able to fail would add unneeded complexity.

However, if a caller didn't use __GFP_DIRECT_RECLAIM, it would be very
hard to notice the bug.  Make it easier by adding a WARN_ON_ONCE().

Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Satya Tangirala <satyat@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 block/blk-crypto.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index bbe7974fd74f0..5da43f0973b46 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -81,7 +81,15 @@ subsys_initcall(bio_crypt_ctx_init);
 void bio_crypt_set_ctx(struct bio *bio, const struct blk_crypto_key *key,
 		       const u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE], gfp_t gfp_mask)
 {
-	struct bio_crypt_ctx *bc = mempool_alloc(bio_crypt_ctx_pool, gfp_mask);
+	struct bio_crypt_ctx *bc;
+
+	/*
+	 * The caller must use a gfp_mask that contains __GFP_DIRECT_RECLAIM so
+	 * that the mempool_alloc() can't fail.
+	 */
+	WARN_ON_ONCE(!(gfp_mask & __GFP_DIRECT_RECLAIM));
+
+	bc = mempool_alloc(bio_crypt_ctx_pool, gfp_mask);
 
 	bc->bc_key = key;
 	memcpy(bc->bc_dun, dun, sizeof(bc->bc_dun));
-- 
2.28.0

