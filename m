Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB50777A91
	for <lists+linux-block@lfdr.de>; Thu, 10 Aug 2023 16:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbjHJOYI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 10 Aug 2023 10:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbjHJOXw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 10:23:52 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AB326BC;
        Thu, 10 Aug 2023 07:23:51 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 1770A83525;
        Thu, 10 Aug 2023 10:23:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1691677431; bh=aJXqNOiQA3W5HD/wVzA3Lku3TaPX52OCRdKFXHFyGso=;
        h=From:To:Cc:Subject:Date:From;
        b=A24cTKswwX/DUC4O69D4NhIrsFFvQHb28O77wyAnoBzckDP2trYTTP1Ymb9Vto/dJ
         JjJSNKjg+2zkNwCSktG29T1dWnh7I6l+gsx9vMANm96csbn7xjfHJAEjuh8RvXUxR5
         UsZK9nIDYqbI7CkLVpZVSI4jjRhyw3SMw9pLwa+lpvyTXFPrs2GTyOcbpSHy4M0O9K
         70CO6X6GWLEiQKdnfWPCgDg1qbH3lqZDGrvJqmpL61w0fl59pQ6AcMzNRb6JUY3HBY
         dgtFr2N/LuuvEY/L6MZDo1V92QpFLnLMhG1u7pCNO3/UkujR0oEHBa5Q+IXIsKHHZk
         630DxsidkTXIQ==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Jens Axboe <axboe@kernel.dk>, Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, kernel-team@meta.com,
        ebiggers@kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        stable@vger.kernel.org
Subject: [PATCH v4] blk-crypto: dynamically allocate fallback profile
Date:   Thu, 10 Aug 2023 10:21:16 -0400
Message-ID: <20230810142346.96772-1-sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_crypto_profile_init() calls lockdep_register_key(), which warns and
does not register if the provided memory is a static object.
blk-crypto-fallback currently has a static blk_crypto_profile and calls
blk_crypto_profile_init() thereupon, resulting in the warning and
failure to register.

Fortunately it is simple enough to use a dynamically allocated profile
and make lockdep function correctly.

Fixes: 2fb48d88e77f ("blk-crypto: use dynamic lock class for blk_crypto_profile::lock")
Cc: stable@vger.kernel.org
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
v4: removed a stray change introduced in v3
v3: added allocation error checking as noted by Eric Biggers.
v2: reworded commit message, fixed Fixes tag, as pointed out by Eric
Biggers.

 block/blk-crypto-fallback.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index ad9844c5b40c..59e54a264a43 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -78,7 +78,7 @@ static struct blk_crypto_fallback_keyslot {
 	struct crypto_skcipher *tfms[BLK_ENCRYPTION_MODE_MAX];
 } *blk_crypto_keyslots;
 
-static struct blk_crypto_profile blk_crypto_fallback_profile;
+static struct blk_crypto_profile *blk_crypto_fallback_profile;
 static struct workqueue_struct *blk_crypto_wq;
 static mempool_t *blk_crypto_bounce_page_pool;
 static struct bio_set crypto_bio_split;
@@ -292,7 +292,7 @@ static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
 	 * Get a blk-crypto-fallback keyslot that contains a crypto_skcipher for
 	 * this bio's algorithm and key.
 	 */
-	blk_st = blk_crypto_get_keyslot(&blk_crypto_fallback_profile,
+	blk_st = blk_crypto_get_keyslot(blk_crypto_fallback_profile,
 					bc->bc_key, &slot);
 	if (blk_st != BLK_STS_OK) {
 		src_bio->bi_status = blk_st;
@@ -395,7 +395,7 @@ static void blk_crypto_fallback_decrypt_bio(struct work_struct *work)
 	 * Get a blk-crypto-fallback keyslot that contains a crypto_skcipher for
 	 * this bio's algorithm and key.
 	 */
-	blk_st = blk_crypto_get_keyslot(&blk_crypto_fallback_profile,
+	blk_st = blk_crypto_get_keyslot(blk_crypto_fallback_profile,
 					bc->bc_key, &slot);
 	if (blk_st != BLK_STS_OK) {
 		bio->bi_status = blk_st;
@@ -499,7 +499,7 @@ bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr)
 		return false;
 	}
 
-	if (!__blk_crypto_cfg_supported(&blk_crypto_fallback_profile,
+	if (!__blk_crypto_cfg_supported(blk_crypto_fallback_profile,
 					&bc->bc_key->crypto_cfg)) {
 		bio->bi_status = BLK_STS_NOTSUPP;
 		return false;
@@ -526,7 +526,7 @@ bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr)
 
 int blk_crypto_fallback_evict_key(const struct blk_crypto_key *key)
 {
-	return __blk_crypto_evict_key(&blk_crypto_fallback_profile, key);
+	return __blk_crypto_evict_key(blk_crypto_fallback_profile, key);
 }
 
 static bool blk_crypto_fallback_inited;
@@ -534,7 +534,6 @@ static int blk_crypto_fallback_init(void)
 {
 	int i;
 	int err;
-	struct blk_crypto_profile *profile = &blk_crypto_fallback_profile;
 
 	if (blk_crypto_fallback_inited)
 		return 0;
@@ -545,18 +544,25 @@ static int blk_crypto_fallback_init(void)
 	if (err)
 		goto out;
 
-	err = blk_crypto_profile_init(profile, blk_crypto_num_keyslots);
-	if (err)
+	/* Dynamic allocation is needed because of lockdep_register_key(). */
+	blk_crypto_fallback_profile =
+		kzalloc(sizeof(*blk_crypto_fallback_profile), GFP_KERNEL);
+	if (!blk_crypto_fallback_profile)
 		goto fail_free_bioset;
+
+	err = blk_crypto_profile_init(blk_crypto_fallback_profile,
+				      blk_crypto_num_keyslots);
+	if (err)
+		goto fail_free_profile;
 	err = -ENOMEM;
 
-	profile->ll_ops = blk_crypto_fallback_ll_ops;
-	profile->max_dun_bytes_supported = BLK_CRYPTO_MAX_IV_SIZE;
+	blk_crypto_fallback_profile->ll_ops = blk_crypto_fallback_ll_ops;
+	blk_crypto_fallback_profile->max_dun_bytes_supported = BLK_CRYPTO_MAX_IV_SIZE;
 
 	/* All blk-crypto modes have a crypto API fallback. */
 	for (i = 0; i < BLK_ENCRYPTION_MODE_MAX; i++)
-		profile->modes_supported[i] = 0xFFFFFFFF;
-	profile->modes_supported[BLK_ENCRYPTION_MODE_INVALID] = 0;
+		blk_crypto_fallback_profile->modes_supported[i] = 0xFFFFFFFF;
+	blk_crypto_fallback_profile->modes_supported[BLK_ENCRYPTION_MODE_INVALID] = 0;
 
 	blk_crypto_wq = alloc_workqueue("blk_crypto_wq",
 					WQ_UNBOUND | WQ_HIGHPRI |
@@ -597,7 +603,9 @@ static int blk_crypto_fallback_init(void)
 fail_free_wq:
 	destroy_workqueue(blk_crypto_wq);
 fail_destroy_profile:
-	blk_crypto_profile_destroy(profile);
+	blk_crypto_profile_destroy(blk_crypto_fallback_profile);
+fail_free_profile:
+	kfree(blk_crypto_fallback_profile);
 fail_free_bioset:
 	bioset_exit(&crypto_bio_split);
 out:
-- 
2.41.0

