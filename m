Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D16A638982
	for <lists+linux-block@lfdr.de>; Fri, 25 Nov 2022 13:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiKYMRG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 25 Nov 2022 07:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiKYMRD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Nov 2022 07:17:03 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3853E4A07F;
        Fri, 25 Nov 2022 04:16:58 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VVfPn5c_1669378599;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VVfPn5c_1669378599)
          by smtp.aliyun-inc.com;
          Fri, 25 Nov 2022 20:16:40 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Eric Biggers <ebiggers@kernel.org>,
        "Theodore Y. Ts o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-fscrypt@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v3 2/2] fscrypt: Add SM4 XTS/CTS symmetric algorithm support
Date:   Fri, 25 Nov 2022 20:16:30 +0800
Message-Id: <20221125121630.87793-3-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20221125121630.87793-1-tianjia.zhang@linux.alibaba.com>
References: <20221125121630.87793-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SM4 is a symmetric algorithm widely used in China, and is even mandatory
in many scenarios. We need to provide these users with the ability to
encrypt files or disks using SM4-XTS, and many other algorithms that use
SM2/3/4 algorithms or their combined algorithm scenarios, these features
are demanded by many users, this patch enables to use SM4-XTS mode to
encrypt file content, and use SM4-CBC-CTS to encrypt filename.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 Documentation/filesystems/fscrypt.rst |  1 +
 fs/crypto/keysetup.c                  | 15 +++++++++++++++
 fs/crypto/policy.c                    |  4 ++++
 include/uapi/linux/fscrypt.h          |  2 ++
 4 files changed, 22 insertions(+)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index 5ba5817c17c2..af27e7b2c74f 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -336,6 +336,7 @@ Currently, the following pairs of encryption modes are supported:
 
 - AES-256-XTS for contents and AES-256-CTS-CBC for filenames
 - AES-128-CBC for contents and AES-128-CTS-CBC for filenames
+- SM4-XTS for contents and SM4-CTS-CBC for filenames
 - Adiantum for both contents and filenames
 - AES-256-XTS for contents and AES-256-HCTR2 for filenames (v2 policies only)
 
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index f7407071a952..24e55c95abc3 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -44,6 +44,21 @@ struct fscrypt_mode fscrypt_modes[] = {
 		.security_strength = 16,
 		.ivsize = 16,
 	},
+	[FSCRYPT_MODE_SM4_XTS] = {
+		.friendly_name = "SM4-XTS",
+		.cipher_str = "xts(sm4)",
+		.keysize = 32,
+		.security_strength = 16,
+		.ivsize = 16,
+		.blk_crypto_mode = BLK_ENCRYPTION_MODE_SM4_XTS,
+	},
+	[FSCRYPT_MODE_SM4_CTS] = {
+		.friendly_name = "SM4-CTS",
+		.cipher_str = "cts(cbc(sm4))",
+		.keysize = 16,
+		.security_strength = 16,
+		.ivsize = 16,
+	},
 	[FSCRYPT_MODE_ADIANTUM] = {
 		.friendly_name = "Adiantum",
 		.cipher_str = "adiantum(xchacha12,aes)",
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 46757c3052ef..8e69bc0c35cd 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -71,6 +71,10 @@ static bool fscrypt_valid_enc_modes_v1(u32 contents_mode, u32 filenames_mode)
 	    filenames_mode == FSCRYPT_MODE_AES_128_CTS)
 		return true;
 
+	if (contents_mode == FSCRYPT_MODE_SM4_XTS &&
+	    filenames_mode == FSCRYPT_MODE_SM4_CTS)
+		return true;
+
 	if (contents_mode == FSCRYPT_MODE_ADIANTUM &&
 	    filenames_mode == FSCRYPT_MODE_ADIANTUM)
 		return true;
diff --git a/include/uapi/linux/fscrypt.h b/include/uapi/linux/fscrypt.h
index a756b29afcc2..47dbd1994bfe 100644
--- a/include/uapi/linux/fscrypt.h
+++ b/include/uapi/linux/fscrypt.h
@@ -26,6 +26,8 @@
 #define FSCRYPT_MODE_AES_256_CTS		4
 #define FSCRYPT_MODE_AES_128_CBC		5
 #define FSCRYPT_MODE_AES_128_CTS		6
+#define FSCRYPT_MODE_SM4_XTS			7
+#define FSCRYPT_MODE_SM4_CTS			8
 #define FSCRYPT_MODE_ADIANTUM			9
 #define FSCRYPT_MODE_AES_256_HCTR2		10
 /* If adding a mode number > 10, update FSCRYPT_MODE_MAX in fscrypt_private.h */
-- 
2.24.3 (Apple Git-128)

