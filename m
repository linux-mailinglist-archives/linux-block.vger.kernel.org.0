Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F764C6392
	for <lists+linux-block@lfdr.de>; Mon, 28 Feb 2022 08:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbiB1HGh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 28 Feb 2022 02:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbiB1HGg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Feb 2022 02:06:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59C2673D5;
        Sun, 27 Feb 2022 23:05:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32B2160FEB;
        Mon, 28 Feb 2022 07:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66373C340E7;
        Mon, 28 Feb 2022 07:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646031956;
        bh=p4LZmBEhwI9Ubw6ivvY3meI1rm5OqUixAiwCXXYTlBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pUsOpFF0O9XuxhFfwhuvrO4TjuR86d8Ba1arBp1gRw+uhUlGOfLiQF23RX+BJcA1s
         yEei6c2KCn2DgJGhby4rPuR43NMby4KK7+VNDKUpVd+SdyvGPoZzvjINGa2VA35yl0
         Fvmja7ombJM0xz1qr+XKDSrOlOb48QtXDdehVXMw6TS8RQyVJ+Y/MHJBLcIn4yB3Yz
         y19Uz9T7lDQrs5O0qPBGFMQNZh6lwqwUaYRpqD3rQM/bXhRg2JaP8gRndgqfCAdc7l
         gnI6dWRtsDufOBeBFky3sfbciwLf8eZHBvSQ2adkB9yCCKXvayltEt3/0Penqu+nqp
         2lvbeOntPh3zg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com,
        Gaurav Kashyap <quic_gaurkash@quicinc.com>,
        Israel Rukshin <israelr@nvidia.com>
Subject: [PATCH v5 2/3] block: add ioctls to create and prepare hardware-wrapped keys
Date:   Sun, 27 Feb 2022 23:05:19 -0800
Message-Id: <20220228070520.74082-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228070520.74082-1-ebiggers@kernel.org>
References: <20220228070520.74082-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Until this point, the kernel can use hardware-wrapped keys to do
encryption if userspace provides one -- specifically a key in
ephemerally-wrapped form.  However, no generic way has been provided for
userspace to get such a key in the first place.

Getting such a key is a two-step process.  First, the key needs to be
imported from a raw key or generated by the hardware, producing a key in
long-term wrapped form.  This happens once in the whole lifetime of the
key.  Second, the long-term wrapped key needs to be converted into
ephemerally-wrapped form.  This happens each time the key is "unlocked".

In Android, these operations are supported in a generic way through
KeyMint, a userspace abstraction layer.  However, that method is
Android-specific and can't be used on other Linux systems, may rely on
proprietary libraries, and also misleads people into supporting KeyMint
features like rollback resistance that make sense for other KeyMint keys
but don't make sense for hardware-wrapped inline encryption keys.

Therefore, this patch provides a generic kernel interface for these
operations by introducing new block device ioctls:

- BLKCRYPTOIMPORTKEY: convert a raw key to long-term wrapped form.

- BLKCRYPTOGENERATEKEY: have the hardware generate a new key, then
  return it in long-term wrapped form.

- BLKCRYPTOPREPAREKEY: convert a key from long-term wrapped form to
  ephemerally-wrapped form.

These ioctls are implemented using new operations in blk_crypto_ll_ops.

In combination with the rest of the hardware-wrapped keys framework,
these ioctls allow the hardware-wrapped key support of inline encryption
hardware to be used end-to-end on any Linux system.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/block/inline-encryption.rst |  34 +++--
 block/blk-crypto-internal.h               |   9 ++
 block/blk-crypto-profile.c                |  53 ++++++++
 block/blk-crypto.c                        | 145 ++++++++++++++++++++++
 block/ioctl.c                             |   5 +
 include/linux/blk-crypto-profile.h        |  54 ++++++++
 include/uapi/linux/fs.h                   |  26 ++++
 7 files changed, 319 insertions(+), 7 deletions(-)

diff --git a/Documentation/block/inline-encryption.rst b/Documentation/block/inline-encryption.rst
index 5d43ba36634a8..871603a15f749 100644
--- a/Documentation/block/inline-encryption.rst
+++ b/Documentation/block/inline-encryption.rst
@@ -487,13 +487,33 @@ keys, when hardware support is available.  This works in the following way:
 blk-crypto-fallback doesn't support hardware-wrapped keys.  Therefore,
 hardware-wrapped keys can only be used with actual inline encryption hardware.
 
-Currently, the kernel only works with hardware-wrapped keys in
-ephemerally-wrapped form.  No generic kernel interfaces are provided for
-generating or importing hardware-wrapped keys in the first place, or converting
-them to ephemerally-wrapped form.  In Android, SoC vendors are required to
-support these operations in their KeyMint implementation (a hardware abstraction
-layer in userspace); for details, see the `Android documentation
-<https://source.android.com/security/encryption/hw-wrapped-keys>`_.
+All the above deals with hardware-wrapped keys in ephemerally-wrapped form only.
+To get such keys in the first place, new block device ioctls have also been
+added to provide a generic interface to creating and preparing such keys:
+
+- ``BLKCRYPTOIMPORTKEY`` converts a raw key to long-term wrapped form.  It takes
+  in a pointer to a ``struct blk_crypto_import_key_arg``.  The caller must set
+  ``raw_key_ptr`` and ``raw_key_size`` to the pointer and size (in bytes) of the
+  raw key to import.  The ioctl will write the resulting long-term wrapped key
+  to the buffer pointed to by ``longterm_wrapped_key_ptr``, which is of maximum
+  size ``longterm_wrapped_key_size``.  It will also update
+  ``longterm_wrapped_key_size`` to be the actual size of the key.  The ioctl
+  will return 0 on success, or will return -1 and set errno on failure.
+
+- ``BLKCRYPTOGENERATEKEY`` is like ``BLKCRYPTOIMPORTKEY``, but it has the
+  hardware generate the key instead of importing one.  It takes in a pointer to
+  a ``struct blk_crypto_generate_key_arg``.
+
+- ``BLKCRYPTOPREPAREKEY`` converts a key from long-term wrapped form to
+  ephemerally-wrapped form.  It takes in a pointer to a
+  ``struct blk_crypto_prepare_key_arg``.  The caller must set
+  ``longterm_wrapped_key_ptr`` and ``longterm_wrapped_key_size`` to the pointer
+  and size (in bytes) of the long-term wrapped key to convert.  The ioctl will
+  write the resulting ephemerally-wrapped key to the buffer pointed to by
+  ``ephemerally_wrapped_key_ptr``, which is of maximum size
+  ``ephemerally_wrapped_key_size``.  It will also update
+  ``ephemerally_wrapped_key_size`` to be the actual size of the key.  The ioctl
+  will return 0 on success, or will return -1 and set errno on failure.
 
 Testability
 -----------
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index d36ae71afed3f..28993a72a2d69 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -61,6 +61,9 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
 	return rq->crypt_ctx;
 }
 
+int blk_crypto_ioctl(struct block_device *bdev, unsigned int cmd,
+		     void __user *argp);
+
 #else /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 static inline bool bio_crypt_rq_ctx_compatible(struct request *rq,
@@ -94,6 +97,12 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
 	return false;
 }
 
+static inline int blk_crypto_ioctl(struct block_device *bdev, unsigned int cmd,
+				   void __user *argp)
+{
+	return -ENOTTY;
+}
+
 #endif /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 void __bio_crypt_advance(struct bio *bio, unsigned int bytes);
diff --git a/block/blk-crypto-profile.c b/block/blk-crypto-profile.c
index 8699d24e6a0d3..5ea989845f055 100644
--- a/block/blk-crypto-profile.c
+++ b/block/blk-crypto-profile.c
@@ -501,6 +501,59 @@ int blk_crypto_derive_sw_secret(struct blk_crypto_profile *profile,
 	return err;
 }
 
+int blk_crypto_import_key(struct blk_crypto_profile *profile,
+			  const u8 *raw_key, size_t raw_key_size,
+			  u8 longterm_wrapped_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	int ret = -EOPNOTSUPP;
+
+	if (profile &&
+	    (profile->key_types_supported & BLK_CRYPTO_KEY_TYPE_HW_WRAPPED) &&
+	    profile->ll_ops.import_key) {
+		blk_crypto_hw_enter(profile);
+		ret = profile->ll_ops.import_key(profile, raw_key, raw_key_size,
+						 longterm_wrapped_key);
+		blk_crypto_hw_exit(profile);
+	}
+	return ret;
+}
+
+int blk_crypto_generate_key(struct blk_crypto_profile *profile,
+			    u8 longterm_wrapped_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	int ret = -EOPNOTSUPP;
+
+	if (profile &&
+	    (profile->key_types_supported & BLK_CRYPTO_KEY_TYPE_HW_WRAPPED) &&
+	    profile->ll_ops.generate_key) {
+		blk_crypto_hw_enter(profile);
+		ret = profile->ll_ops.generate_key(profile,
+						   longterm_wrapped_key);
+		blk_crypto_hw_exit(profile);
+	}
+	return ret;
+}
+
+int blk_crypto_prepare_key(struct blk_crypto_profile *profile,
+			   const u8 *longterm_wrapped_key,
+			   size_t longterm_wrapped_key_size,
+			   u8 ephemerally_wrapped_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	int ret = -EOPNOTSUPP;
+
+	if (profile &&
+	    (profile->key_types_supported & BLK_CRYPTO_KEY_TYPE_HW_WRAPPED) &&
+	    profile->ll_ops.prepare_key) {
+		blk_crypto_hw_enter(profile);
+		ret = profile->ll_ops.prepare_key(profile,
+						  longterm_wrapped_key,
+						  longterm_wrapped_key_size,
+						  ephemerally_wrapped_key);
+		blk_crypto_hw_exit(profile);
+	}
+	return ret;
+}
+
 /**
  * blk_crypto_intersect_capabilities() - restrict supported crypto capabilities
  *					 by child device
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index ebd9cf12f6547..1acf103727e61 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -438,3 +438,148 @@ int blk_crypto_evict_key(struct request_queue *q,
 	return blk_crypto_fallback_evict_key(key);
 }
 EXPORT_SYMBOL_GPL(blk_crypto_evict_key);
+
+static int blk_crypto_ioctl_import_key(struct blk_crypto_profile *profile,
+				       void __user *argp)
+{
+	struct blk_crypto_import_key_arg arg;
+	u8 raw_key[BLK_CRYPTO_MAX_STANDARD_KEY_SIZE];
+	u8 longterm_wrapped_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE];
+	int ret;
+
+	if (copy_from_user(&arg, argp, sizeof(arg)))
+		return -EFAULT;
+
+	if (memchr_inv(arg.reserved, 0, sizeof(arg.reserved)))
+		return -EINVAL;
+
+	if (arg.raw_key_size < 16 || arg.raw_key_size > sizeof(raw_key))
+		return -EINVAL;
+
+	if (copy_from_user(raw_key, u64_to_user_ptr(arg.raw_key_ptr),
+			   arg.raw_key_size)) {
+		ret = -EFAULT;
+		goto out;
+	}
+	ret = blk_crypto_import_key(profile, raw_key, arg.raw_key_size,
+				    longterm_wrapped_key);
+	if (ret < 0)
+		goto out;
+	if (ret > arg.longterm_wrapped_key_size) {
+		ret = -ENOBUFS;
+		goto out;
+	}
+	arg.longterm_wrapped_key_size = ret;
+	if (copy_to_user(u64_to_user_ptr(arg.longterm_wrapped_key_ptr),
+			 longterm_wrapped_key, arg.longterm_wrapped_key_size) ||
+	    copy_to_user(argp, &arg, sizeof(arg))) {
+		ret = -EFAULT;
+		goto out;
+	}
+	ret = 0;
+out:
+	memzero_explicit(raw_key, sizeof(raw_key));
+	memzero_explicit(longterm_wrapped_key, sizeof(longterm_wrapped_key));
+	return ret;
+}
+
+static int blk_crypto_ioctl_generate_key(struct blk_crypto_profile *profile,
+					 void __user *argp)
+{
+	struct blk_crypto_generate_key_arg arg;
+	u8 longterm_wrapped_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE];
+	int ret;
+
+	if (copy_from_user(&arg, argp, sizeof(arg)))
+		return -EFAULT;
+
+	if (memchr_inv(arg.reserved, 0, sizeof(arg.reserved)))
+		return -EINVAL;
+
+	ret = blk_crypto_generate_key(profile, longterm_wrapped_key);
+	if (ret < 0)
+		goto out;
+	if (ret > arg.longterm_wrapped_key_size) {
+		ret = -ENOBUFS;
+		goto out;
+	}
+	arg.longterm_wrapped_key_size = ret;
+	if (copy_to_user(u64_to_user_ptr(arg.longterm_wrapped_key_ptr),
+			 longterm_wrapped_key, arg.longterm_wrapped_key_size) ||
+	    copy_to_user(argp, &arg, sizeof(arg))) {
+		ret = -EFAULT;
+		goto out;
+	}
+	ret = 0;
+out:
+	memzero_explicit(longterm_wrapped_key, sizeof(longterm_wrapped_key));
+	return ret;
+}
+
+static int blk_crypto_ioctl_prepare_key(struct blk_crypto_profile *profile,
+					void __user *argp)
+{
+	struct blk_crypto_prepare_key_arg arg;
+	u8 longterm_wrapped_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE];
+	u8 ephemerally_wrapped_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE];
+	int ret;
+
+	if (copy_from_user(&arg, argp, sizeof(arg)))
+		return -EFAULT;
+
+	if (memchr_inv(arg.reserved, 0, sizeof(arg.reserved)))
+		return -EINVAL;
+
+	if (arg.longterm_wrapped_key_size > sizeof(longterm_wrapped_key))
+		return -EINVAL;
+	if (copy_from_user(longterm_wrapped_key,
+			   u64_to_user_ptr(arg.longterm_wrapped_key_ptr),
+			   arg.longterm_wrapped_key_size)) {
+		ret = -EFAULT;
+		goto out;
+	}
+	ret = blk_crypto_prepare_key(profile, longterm_wrapped_key,
+				     arg.longterm_wrapped_key_size,
+				     ephemerally_wrapped_key);
+	if (ret < 0)
+		goto out;
+	if (ret > arg.ephemerally_wrapped_key_size) {
+		ret = -ENOBUFS;
+		goto out;
+	}
+	arg.ephemerally_wrapped_key_size = ret;
+	if (copy_to_user(u64_to_user_ptr(arg.ephemerally_wrapped_key_ptr),
+			 ephemerally_wrapped_key,
+			 arg.ephemerally_wrapped_key_size) ||
+	    copy_to_user(argp, &arg, sizeof(arg))) {
+		ret = -EFAULT;
+		goto out;
+	}
+	ret = 0;
+out:
+	memzero_explicit(longterm_wrapped_key, sizeof(longterm_wrapped_key));
+	memzero_explicit(ephemerally_wrapped_key,
+			 sizeof(ephemerally_wrapped_key));
+	return ret;
+}
+
+int blk_crypto_ioctl(struct block_device *bdev, unsigned int cmd,
+		     void __user *argp)
+{
+	struct blk_crypto_profile *profile =
+		bdev_get_queue(bdev)->crypto_profile;
+
+	if (!profile)
+		return -EOPNOTSUPP;
+
+	switch (cmd) {
+	case BLKCRYPTOIMPORTKEY:
+		return blk_crypto_ioctl_import_key(profile, argp);
+	case BLKCRYPTOGENERATEKEY:
+		return blk_crypto_ioctl_generate_key(profile, argp);
+	case BLKCRYPTOPREPAREKEY:
+		return blk_crypto_ioctl_prepare_key(profile, argp);
+	default:
+		return -ENOTTY;
+	}
+}
diff --git a/block/ioctl.c b/block/ioctl.c
index 4a86340133e46..f934aea41647f 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -12,6 +12,7 @@
 #include <linux/pr.h>
 #include <linux/uaccess.h>
 #include "blk.h"
+#include "blk-crypto-internal.h"
 
 static int blkpg_do_ioctl(struct block_device *bdev,
 			  struct blkpg_partition __user *upart, int op)
@@ -506,6 +507,10 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 	case BLKTRACESTOP:
 	case BLKTRACETEARDOWN:
 		return blk_trace_ioctl(bdev, cmd, argp);
+	case BLKCRYPTOIMPORTKEY:
+	case BLKCRYPTOGENERATEKEY:
+	case BLKCRYPTOPREPAREKEY:
+		return blk_crypto_ioctl(bdev, cmd, argp);
 	case IOC_PR_REGISTER:
 		return blkdev_pr_register(bdev, argp);
 	case IOC_PR_RESERVE:
diff --git a/include/linux/blk-crypto-profile.h b/include/linux/blk-crypto-profile.h
index 706de8c91ec9e..f55bd22185fa7 100644
--- a/include/linux/blk-crypto-profile.h
+++ b/include/linux/blk-crypto-profile.h
@@ -72,6 +72,48 @@ struct blk_crypto_ll_ops {
 				const u8 *wrapped_key,
 				unsigned int wrapped_key_size,
 				u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE]);
+
+	/**
+	 * @import_key: Create a hardware-wrapped key by importing a raw key.
+	 *
+	 * This only needs to be implemented if BLK_CRYPTO_KEY_TYPE_HW_WRAPPED
+	 * is supported.
+	 *
+	 * Must return the size (in bytes) of the resulting wrapped key on
+	 * success, or -errno on failure.
+	 */
+	int (*import_key)(struct blk_crypto_profile *profile,
+			  const u8 *raw_key, size_t raw_key_size,
+			  u8 longterm_wrapped_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
+
+	/**
+	 * @generate_key: Generate a hardware-wrapped key.
+	 *
+	 * This only needs to be implemented if BLK_CRYPTO_KEY_TYPE_HW_WRAPPED
+	 * is supported.
+	 *
+	 * Must return the size (in bytes) of the resulting wrapped key on
+	 * success, or -errno on failure.
+	 */
+	int (*generate_key)(struct blk_crypto_profile *profile,
+			    u8 longterm_wrapped_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
+
+	/**
+	 * @prepare_key: Prepare a hardware-wrapped key to be used.
+	 *
+	 * This function prepares a hardware-wrapped to be used by converting it
+	 * from long-term wrapped form to ephemerally-wrapped form.
+	 *
+	 * This only needs to be implemented if BLK_CRYPTO_KEY_TYPE_HW_WRAPPED
+	 * is supported.
+	 *
+	 * Must return the size (in bytes) of the resulting wrapped key on
+	 * success, or -errno on failure.
+	 */
+	int (*prepare_key)(struct blk_crypto_profile *profile,
+			   const u8 *longterm_wrapped_key,
+			   size_t longterm_wrapped_key_size,
+			   u8 ephemerally_wrapped_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
 };
 
 /**
@@ -180,6 +222,18 @@ int blk_crypto_derive_sw_secret(struct blk_crypto_profile *profile,
 				unsigned int wrapped_key_size,
 				u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE]);
 
+int blk_crypto_import_key(struct blk_crypto_profile *profile,
+			  const u8 *raw_key, size_t raw_key_size,
+			  u8 longterm_wrapped_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
+
+int blk_crypto_generate_key(struct blk_crypto_profile *profile,
+			    u8 longterm_wrapped_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
+
+int blk_crypto_prepare_key(struct blk_crypto_profile *profile,
+			   const u8 *longterm_wrapped_key,
+			   size_t longterm_wrapped_key_size,
+			   u8 ephemerally_wrapped_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
+
 void blk_crypto_intersect_capabilities(struct blk_crypto_profile *parent,
 				       const struct blk_crypto_profile *child);
 
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index bdf7b404b3e72..d5021094c2fee 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -121,6 +121,28 @@ struct fsxattr {
 	unsigned char	fsx_pad[8];
 };
 
+struct blk_crypto_import_key_arg {
+	__u64 raw_key_ptr;
+	__u64 raw_key_size;
+	__u64 longterm_wrapped_key_ptr;
+	__u64 longterm_wrapped_key_size;
+	__u64 reserved[4];
+};
+
+struct blk_crypto_generate_key_arg {
+	__u64 longterm_wrapped_key_ptr;
+	__u64 longterm_wrapped_key_size;
+	__u64 reserved[4];
+};
+
+struct blk_crypto_prepare_key_arg {
+	__u64 longterm_wrapped_key_ptr;
+	__u64 longterm_wrapped_key_size;
+	__u64 ephemerally_wrapped_key_ptr;
+	__u64 ephemerally_wrapped_key_size;
+	__u64 reserved[4];
+};
+
 /*
  * Flags for the fsx_xflags field
  */
@@ -185,6 +207,10 @@ struct fsxattr {
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
 #define BLKGETDISKSEQ _IOR(0x12,128,__u64)
+#define BLKCRYPTOIMPORTKEY _IOWR(0x12, 129, struct blk_crypto_import_key_arg)
+#define BLKCRYPTOGENERATEKEY _IOWR(0x12, 130, struct blk_crypto_generate_key_arg)
+#define BLKCRYPTOPREPAREKEY _IOWR(0x12, 131, struct blk_crypto_prepare_key_arg)
+
 /*
  * A jump here: 130-136 are reserved for zoned block devices
  * (see uapi/linux/blkzoned.h)
-- 
2.35.1

