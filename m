Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 322283680A
	for <lists+linux-block@lfdr.de>; Thu,  6 Jun 2019 01:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfFEX3C (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 5 Jun 2019 19:29:02 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:34129 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfFEX3B (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jun 2019 19:29:01 -0400
Received: by mail-pl1-f202.google.com with SMTP id d19so324776pls.1
        for <linux-block@vger.kernel.org>; Wed, 05 Jun 2019 16:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GhtacjXSLEAQSRAgho8QtJ9oC7q5n0gdQI0xHCC6Cvk=;
        b=fVOZ4qemkBjsShr+ckWKajh4E6dMYGb5Tmd/tpOLr/wRdHd2YQHgoDs5AmDjcbWy+W
         fbZiRI3/8MVpW5kWfyi4454cp6nVWCBDok6gcnTUW65wW4jLGxsvc8d4WM1VI3tkppCu
         YdDm7mLATFaimsLzvTtkp11+1mPicmeCUdtArjTZeuWpFLsNiMO0ctk6ySlTE1cQBCRv
         kiqIV85PdKfVMMtK/Fu9C721W3OeBXcFYZMhgUI8Y5SRCW4YgBJi/r9eSaflcO1OXMz1
         SCHj3WhQIm116aO/1+G5klsKlZvLMVEEM79x761vnMlGcq0Vw6bflqnryl+RKSaKXHHW
         zRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GhtacjXSLEAQSRAgho8QtJ9oC7q5n0gdQI0xHCC6Cvk=;
        b=EDaKcgpOrDYA6ajlZY7aPM5WTMlodSdIoc0/qtravR7M2tt8Xb8lTmnPcKtjBWU5+j
         sve80025/oMsreRL32rBpmI0IGstcx9k71pCQpt+I8gTOImqAX62IrbZy6TaBNO67Bn2
         NEAG4S6y+uo9ZdGdbtZILEsSlSueIpZblEOb3yRrMbcfC/1iBNQT9OhcwU6kWGONmVHn
         xclHe/ZhbSeLz8t8HgX9GlKjkXUC9lyvNndkRMoEHr/JFzJbJYVD+Vn/Jdqnm/F1/0Sx
         oRq34y01SbWiRCLBpZ7HGONhFBrx/0DHlxAkGJOXXI3MkzEZTb5vdDfBW1GpfZil1MtE
         gDNw==
X-Gm-Message-State: APjAAAWyyIR651/JfI5i8W6Gc6grkyZ563DGx+o1ULUXrCQXIXFIUnFO
        5PDIS0VMgdDShf7DfBcXreWJ8nJLwEsnJUxYbumtdAnxcQIGRufF0cUSg0zYsUYbVjNvEtcEtH9
        nSggo9bb6LiBinVPUP2PWJyc4X6tGZepUcZkykSc8shfi/BuPP15qmDME9PzpUF7ZkhgK
X-Google-Smtp-Source: APXvYqzAnxGOCAYFc0rV1zbrdU7H4NM5f5LbAzIG22kKC/XMkmtaRwnRfRmsIwFxXiJztNL6xcKsKQTl8kU=
X-Received: by 2002:a65:624f:: with SMTP id q15mr373475pgv.436.1559777340623;
 Wed, 05 Jun 2019 16:29:00 -0700 (PDT)
Date:   Wed,  5 Jun 2019 16:28:34 -0700
In-Reply-To: <20190605232837.31545-1-satyat@google.com>
Message-Id: <20190605232837.31545-6-satyat@google.com>
Mime-Version: 1.0
References: <20190605232837.31545-1-satyat@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [RFC PATCH v2 5/8] scsi: ufs: UFS crypto API
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Parshuram Raju Thombare <pthombar@cadence.com>,
        Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce functions to manipulate UFS inline encryption hardware
in line with the JEDEC UFSHCI v2.1 specification and to work with the
block keyslot manager.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 drivers/scsi/ufs/Kconfig         |  10 +
 drivers/scsi/ufs/Makefile        |   1 +
 drivers/scsi/ufs/ufshcd-crypto.c | 438 +++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd-crypto.h |  69 +++++
 4 files changed, 518 insertions(+)
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.c
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.h

diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
index 0b845ab7c3bf..861aabfe791b 100644
--- a/drivers/scsi/ufs/Kconfig
+++ b/drivers/scsi/ufs/Kconfig
@@ -150,3 +150,13 @@ config SCSI_UFS_BSG
 
 	  Select this if you need a bsg device node for your UFS controller.
 	  If unsure, say N.
+
+config SCSI_UFS_CRYPTO
+	bool "UFS Crypto Engine Support"
+	depends on SCSI_UFSHCD && BLK_INLINE_ENCRYPTION
+	help
+	  Enable Crypto Engine Support in UFS.
+	  Enabling this makes it possible for the kernel to use the crypto
+	  capabilities of the UFS device (if present) to perform crypto
+	  operations on data being transferred to/from the device.
+
diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
index 2a9097939bcb..094c39989a37 100644
--- a/drivers/scsi/ufs/Makefile
+++ b/drivers/scsi/ufs/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_SCSI_UFSHCD_PCI) += ufshcd-pci.o
 obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) += ufshcd-pltfrm.o
 obj-$(CONFIG_SCSI_UFS_HISI) += ufs-hisi.o
 obj-$(CONFIG_SCSI_UFS_MEDIATEK) += ufs-mediatek.o
+ufshcd-core-$(CONFIG_SCSI_UFS_CRYPTO) += ufshcd-crypto.o
diff --git a/drivers/scsi/ufs/ufshcd-crypto.c b/drivers/scsi/ufs/ufshcd-crypto.c
new file mode 100644
index 000000000000..678866d15b8e
--- /dev/null
+++ b/drivers/scsi/ufs/ufshcd-crypto.c
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Google LLC
+ */
+
+#include <crypto/algapi.h>
+
+#include "ufshcd.h"
+#include "ufshcd-crypto.h"
+
+bool ufshcd_hba_is_crypto_supported(struct ufs_hba *hba)
+{
+	return hba->crypto_capabilities.reg_val != 0;
+}
+
+bool ufshcd_is_crypto_enabled(struct ufs_hba *hba)
+{
+	return hba->caps & UFSHCD_CAP_CRYPTO;
+}
+
+static bool ufshcd_cap_idx_valid(struct ufs_hba *hba, unsigned int cap_idx)
+{
+	return cap_idx < hba->crypto_capabilities.num_crypto_cap;
+}
+
+#define NUM_KEYSLOTS(hba) (hba->crypto_capabilities.config_count + 1)
+
+bool ufshcd_keyslot_valid(struct ufs_hba *hba, unsigned int slot)
+{
+	/*
+	 * The actual number of configurations supported is (CFGC+1), so slot
+	 * numbers range from 0 to config_count inclusive.
+	 */
+	return slot < NUM_KEYSLOTS(hba);
+}
+
+static u8 get_data_unit_size_mask(unsigned int data_unit_size)
+{
+	if (data_unit_size < 512 || data_unit_size > 65536 ||
+	    !is_power_of_2(data_unit_size))
+		return 0;
+
+	return data_unit_size / 512;
+}
+
+static size_t get_keysize_bytes(enum ufs_crypto_key_size size)
+{
+	switch (size) {
+	case UFS_CRYPTO_KEY_SIZE_128: return 16;
+	case UFS_CRYPTO_KEY_SIZE_192: return 24;
+	case UFS_CRYPTO_KEY_SIZE_256: return 32;
+	case UFS_CRYPTO_KEY_SIZE_512: return 64;
+	default: return 0;
+	}
+}
+
+static int ufshcd_crypto_alg_find(void *hba_p,
+			   enum blk_crypt_mode_num crypt_mode,
+			   unsigned int data_unit_size)
+{
+	struct ufs_hba *hba = hba_p;
+	enum ufs_crypto_alg ufs_alg;
+	u8 data_unit_mask;
+	int cap_idx;
+	enum ufs_crypto_key_size ufs_key_size;
+	union ufs_crypto_cap_entry *ccap_array = hba->crypto_cap_array;
+
+	if (!ufshcd_hba_is_crypto_supported(hba))
+		return -EINVAL;
+
+	switch (crypt_mode) {
+	case BLK_ENCRYPTION_MODE_AES_256_XTS:
+		ufs_alg = UFS_CRYPTO_ALG_AES_XTS;
+		ufs_key_size = UFS_CRYPTO_KEY_SIZE_256;
+		break;
+	/*
+	 * case BLK_CRYPTO_ALG_BITLOCKER_AES_CBC:
+	 *	ufs_alg = UFS_CRYPTO_ALG_BITLOCKER_AES_CBC;
+	 *	break;
+	 * case INLINECRYPT_ALG_AES_ECB:
+	 *	ufs_alg = UFS_CRYPTO_ALG_AES_ECB;
+	 *	break;
+	 * case INLINECRYPT_ALG_ESSIV_AES_CBC:
+	 *	ufs_alg = UFS_CRYPTO_ALG_ESSIV_AES_CBC;
+	 *	break;
+	 */
+	default: return -EINVAL;
+	}
+
+	data_unit_mask = get_data_unit_size_mask(data_unit_size);
+
+	/*
+	 * TODO: We can replace this for loop entirely by constructing
+	 * a table on init that translates blk_crypt_mode to
+	 * ufs crypt alg numbers. (By assuming that each alg/keysize combo
+	 * appears only once in the ufs crypto caps array.)
+	 */
+	for (cap_idx = 0; cap_idx < hba->crypto_capabilities.num_crypto_cap;
+	     cap_idx++) {
+		if (ccap_array[cap_idx].algorithm_id == ufs_alg &&
+		    (ccap_array[cap_idx].sdus_mask & data_unit_mask) &&
+		    ccap_array[cap_idx].key_size == ufs_key_size)
+			return cap_idx;
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * ufshcd_crypto_cfg_entry_write_key - Write a key into a crypto_cfg_entry
+ *
+ *	Writes the key with the appropriate format - for AES_XTS,
+ *	the first half of the key is copied as is, the second half is
+ *	copied with an offset halfway into the cfg->crypto_key array.
+ *	For the other supported crypto algs, the key is just copied.
+ *
+ * @cfg: The crypto config to write to
+ * @key: The key to write
+ * @cap: The crypto capability (which specifies the crypto alg and key size)
+ *
+ * Returns 0 on success, or -EINVAL
+ */
+static int ufshcd_crypto_cfg_entry_write_key(union ufs_crypto_cfg_entry *cfg,
+					     const u8 *key,
+					     union ufs_crypto_cap_entry cap)
+{
+	size_t key_size_bytes = get_keysize_bytes(cap.key_size);
+
+	if (key_size_bytes == 0)
+		return -EINVAL;
+
+	switch (cap.algorithm_id) {
+	case UFS_CRYPTO_ALG_AES_XTS:
+		key_size_bytes *= 2;
+		if (key_size_bytes > UFS_CRYPTO_KEY_MAX_SIZE)
+			return -EINVAL;
+
+		memcpy(cfg->crypto_key, key, key_size_bytes/2);
+		memcpy(cfg->crypto_key + UFS_CRYPTO_KEY_MAX_SIZE/2,
+		       key + key_size_bytes/2, key_size_bytes/2);
+		return 0;
+	case UFS_CRYPTO_ALG_BITLOCKER_AES_CBC: // fallthrough
+	case UFS_CRYPTO_ALG_AES_ECB: // fallthrough
+	case UFS_CRYPTO_ALG_ESSIV_AES_CBC:
+		memcpy(cfg->crypto_key, key, key_size_bytes);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static void program_key(struct ufs_hba *hba,
+			const union ufs_crypto_cfg_entry *cfg,
+			int slot)
+{
+	int i;
+	u32 slot_offset = hba->crypto_cfg_register + slot * sizeof(*cfg);
+
+	/* Clear the dword 16 */
+	ufshcd_writel(hba, 0, slot_offset + 16 * sizeof(cfg->reg_val[0]));
+	/* Ensure that CFGE is cleared before programming the key */
+	wmb();
+	for (i = 0; i < 16; i++) {
+		ufshcd_writel(hba, le32_to_cpu(cfg->reg_val[i]),
+			      slot_offset + i * sizeof(cfg->reg_val[0]));
+		/* Spec says each dword in key must be written sequentially */
+		wmb();
+	}
+	/* Write dword 17 */
+	ufshcd_writel(hba, le32_to_cpu(cfg->reg_val[17]),
+		      slot_offset + 17 * sizeof(cfg->reg_val[0]));
+	/* Dword 16 must be written last */
+	wmb();
+	/* Write dword 16 */
+	ufshcd_writel(hba, le32_to_cpu(cfg->reg_val[16]),
+		      slot_offset + 16 * sizeof(cfg->reg_val[0]));
+	wmb();
+}
+
+static int ufshcd_crypto_keyslot_program(void *hba_p, const u8 *key,
+					 enum blk_crypt_mode_num crypt_mode,
+					 unsigned int data_unit_size,
+					 unsigned int slot)
+{
+	struct ufs_hba *hba = hba_p;
+	int err = 0;
+	u8 data_unit_mask;
+	union ufs_crypto_cfg_entry cfg;
+	union ufs_crypto_cfg_entry *cfg_arr = hba->crypto_cfgs;
+	int crypto_alg_id;
+
+	crypto_alg_id = ufshcd_crypto_alg_find(hba_p, crypt_mode,
+					       data_unit_size);
+
+	if (!ufshcd_is_crypto_enabled(hba) ||
+	    !ufshcd_keyslot_valid(hba, slot) ||
+	    !ufshcd_cap_idx_valid(hba, crypto_alg_id))
+		return -EINVAL;
+
+	data_unit_mask = get_data_unit_size_mask(data_unit_size);
+
+	if (!(data_unit_mask &
+	      hba->crypto_cap_array[crypto_alg_id].sdus_mask))
+		return -EINVAL;
+
+	memset(&cfg, 0, sizeof(cfg));
+	cfg.data_unit_size = data_unit_mask;
+	cfg.crypto_cap_idx = crypto_alg_id;
+	cfg.config_enable |= UFS_CRYPTO_CONFIGURATION_ENABLE;
+
+	err = ufshcd_crypto_cfg_entry_write_key(&cfg, key,
+				hba->crypto_cap_array[crypto_alg_id]);
+	if (err)
+		return err;
+
+	program_key(hba, &cfg, slot);
+
+	memcpy(&cfg_arr[slot], &cfg, sizeof(cfg));
+	memzero_explicit(&cfg, sizeof(cfg));
+
+	return 0;
+}
+
+static int ufshcd_crypto_keyslot_find(void *hba_p,
+				      const u8 *key,
+				      enum blk_crypt_mode_num crypt_mode,
+				      unsigned int data_unit_size)
+{
+	struct ufs_hba *hba = hba_p;
+	int err = 0;
+	int slot;
+	u8 data_unit_mask;
+	union ufs_crypto_cfg_entry cfg;
+	union ufs_crypto_cfg_entry *cfg_arr = hba->crypto_cfgs;
+	int crypto_alg_id;
+
+	crypto_alg_id = ufshcd_crypto_alg_find(hba_p, crypt_mode,
+					       data_unit_size);
+
+	if (!ufshcd_is_crypto_enabled(hba) ||
+	    !ufshcd_cap_idx_valid(hba, crypto_alg_id))
+		return -EINVAL;
+
+	data_unit_mask = get_data_unit_size_mask(data_unit_size);
+
+	if (!(data_unit_mask &
+	      hba->crypto_cap_array[crypto_alg_id].sdus_mask))
+		return -EINVAL;
+
+	memset(&cfg, 0, sizeof(cfg));
+	err = ufshcd_crypto_cfg_entry_write_key(&cfg, key,
+					hba->crypto_cap_array[crypto_alg_id]);
+
+	if (err)
+		return -EINVAL;
+
+	for (slot = 0; slot < NUM_KEYSLOTS(hba); slot++) {
+		if ((cfg_arr[slot].config_enable &
+		     UFS_CRYPTO_CONFIGURATION_ENABLE) &&
+		    data_unit_mask == cfg_arr[slot].data_unit_size &&
+		    crypto_alg_id == cfg_arr[slot].crypto_cap_idx &&
+		    crypto_memneq(&cfg.crypto_key, cfg_arr[slot].crypto_key,
+				  UFS_CRYPTO_KEY_MAX_SIZE) == 0) {
+			memzero_explicit(&cfg, sizeof(cfg));
+			return slot;
+		}
+	}
+
+	memzero_explicit(&cfg, sizeof(cfg));
+	return -ENOKEY;
+}
+
+static int ufshcd_crypto_keyslot_evict(void *hba_p, const u8 *key,
+				       enum blk_crypt_mode_num crypt_mode,
+				       unsigned int data_unit_size,
+				       unsigned int slot)
+{
+	struct ufs_hba *hba = hba_p;
+	int i = 0;
+	u32 reg_base;
+	union ufs_crypto_cfg_entry *cfg_arr = hba->crypto_cfgs;
+
+	if (!ufshcd_is_crypto_enabled(hba) ||
+	    !ufshcd_keyslot_valid(hba, slot))
+		return -EINVAL;
+
+	memset(&cfg_arr[slot], 0, sizeof(cfg_arr[slot]));
+	reg_base = hba->crypto_cfg_register + slot * sizeof(cfg_arr[0]);
+
+	/*
+	 * Clear the crypto cfg on the device. Clearing CFGE
+	 * might not be sufficient, so just clear the entire cfg.
+	 */
+	for (i = 0; i < sizeof(cfg_arr[0]); i += sizeof(__le32))
+		ufshcd_writel(hba, 0, reg_base + i);
+	wmb();
+
+	return 0;
+}
+
+static bool ufshcd_crypt_mode_supported(void *hba_p,
+					 enum blk_crypt_mode_num crypt_mode,
+					 unsigned int data_unit_size)
+{
+	return ufshcd_crypto_alg_find(hba_p, crypt_mode, data_unit_size) >= 0;
+}
+
+void ufshcd_crypto_enable(struct ufs_hba *hba)
+{
+	union ufs_crypto_cfg_entry *cfg_arr = hba->crypto_cfgs;
+	int slot;
+
+	if (!ufshcd_hba_is_crypto_supported(hba))
+		return;
+
+	hba->caps |= UFSHCD_CAP_CRYPTO;
+	/*
+	 * Reset might clear all keys, so reprogram all the keys.
+	 * Also serves to clear keys on driver init.
+	 */
+	for (slot = 0; slot < NUM_KEYSLOTS(hba); slot++)
+		program_key(hba, &cfg_arr[slot], slot);
+}
+
+void ufshcd_crypto_disable(struct ufs_hba *hba)
+{
+	hba->caps &= ~UFSHCD_CAP_CRYPTO;
+}
+
+
+/**
+ * ufshcd_hba_init_crypto - Read crypto capabilities, init crypto fields in hba
+ * @hba: Per adapter instance
+ *
+ * Returns 0 on success. Returns -ENODEV if such capabilties don't exist, and
+ * -ENOMEM upon OOM.
+ */
+int ufshcd_hba_init_crypto(struct ufs_hba *hba)
+{
+	int cap_idx = 0;
+	int err = 0;
+
+	/* Default to disabling crypto */
+	hba->caps &= ~UFSHCD_CAP_CRYPTO;
+
+	if (!(hba->capabilities & MASK_CRYPTO_SUPPORT)) {
+		err = -ENODEV;
+		goto out;
+	}
+
+	/*
+	 * Crypto Capabilities should never be 0, because the
+	 * config_array_ptr > 04h. So we use a 0 value to indicate that
+	 * crypto init failed, and can't be enabled.
+	 */
+	hba->crypto_capabilities.reg_val =
+			cpu_to_le32(ufshcd_readl(hba, REG_UFS_CCAP));
+	hba->crypto_cfg_register =
+		(u32)hba->crypto_capabilities.config_array_ptr * 0x100;
+	hba->crypto_cap_array =
+		devm_kcalloc(hba->dev,
+			     hba->crypto_capabilities.num_crypto_cap,
+			     sizeof(hba->crypto_cap_array[0]),
+			     GFP_KERNEL);
+	if (!hba->crypto_cap_array) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	hba->crypto_cfgs =
+		devm_kcalloc(hba->dev,
+			     hba->crypto_capabilities.config_count + 1,
+			     sizeof(union ufs_crypto_cfg_entry),
+			     GFP_KERNEL);
+	if (!hba->crypto_cfgs) {
+		err = -ENOMEM;
+		goto out_cfg_mem;
+	}
+
+	/*
+	 * Store all the capabilities now so that we don't need to repeatedly
+	 * access the device each time we want to know its capabilities
+	 */
+	for (cap_idx = 0; cap_idx < hba->crypto_capabilities.num_crypto_cap;
+	     cap_idx++) {
+		hba->crypto_cap_array[cap_idx].reg_val =
+			cpu_to_le32(ufshcd_readl(hba,
+						 REG_UFS_CRYPTOCAP +
+						 cap_idx * sizeof(__le32)));
+	}
+
+	return 0;
+out_cfg_mem:
+	devm_kfree(hba->dev, hba->crypto_cap_array);
+out:
+	// TODO: print error?
+	/* Indicate that init failed by setting crypto_capabilities to 0 */
+	hba->crypto_capabilities.reg_val = 0;
+	return err;
+}
+
+static const struct keyslot_mgmt_ll_ops ufshcd_ksm_ops = {
+	.keyslot_program	= ufshcd_crypto_keyslot_program,
+	.keyslot_evict		= ufshcd_crypto_keyslot_evict,
+	.keyslot_find		= ufshcd_crypto_keyslot_find,
+	.crypt_mode_supported	= ufshcd_crypt_mode_supported,
+};
+
+void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
+					    struct request_queue *q)
+{
+	if (!ufshcd_hba_is_crypto_supported(hba))
+		return;
+
+	if (q) {
+		q->ksm = keyslot_manager_create(
+				hba->crypto_capabilities.config_count + 1,
+				&ufshcd_ksm_ops, hba);
+	}
+	/*
+	 * If we fail we make it look like
+	 * crypto is not supported, which will avoid issues
+	 * with reset
+	 */
+	if (!q || !q->ksm) {
+		ufshcd_crypto_disable(hba);
+		hba->crypto_capabilities.reg_val = 0;
+		devm_kfree(hba->dev, hba->crypto_cap_array);
+		devm_kfree(hba->dev, hba->crypto_cfgs);
+	}
+}
+
+void ufshcd_crypto_destroy_rq_keyslot_manager(struct request_queue *q)
+{
+	if (q && q->ksm)
+		keyslot_manager_destroy(q->ksm);
+}
+
diff --git a/drivers/scsi/ufs/ufshcd-crypto.h b/drivers/scsi/ufs/ufshcd-crypto.h
new file mode 100644
index 000000000000..7790e99477b9
--- /dev/null
+++ b/drivers/scsi/ufs/ufshcd-crypto.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2019 Google LLC
+ */
+
+#ifndef _UFSHCD_CRYPTO_H
+#define _UFSHCD_CRYPTO_H
+
+struct ufs_hba;
+
+#ifdef CONFIG_SCSI_UFS_CRYPTO
+#include <linux/keyslot-manager.h>
+
+#include "ufshci.h"
+
+bool ufshcd_keyslot_valid(struct ufs_hba *hba, unsigned int slot);
+
+bool ufshcd_hba_is_crypto_supported(struct ufs_hba *hba);
+
+bool ufshcd_is_crypto_enabled(struct ufs_hba *hba);
+
+void ufshcd_crypto_enable(struct ufs_hba *hba);
+
+void ufshcd_crypto_disable(struct ufs_hba *hba);
+
+int ufshcd_hba_init_crypto(struct ufs_hba *hba);
+
+void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
+					    struct request_queue *q);
+
+void ufshcd_crypto_destroy_rq_keyslot_manager(struct request_queue *q);
+
+#else /* CONFIG_SCSI_UFS_CRYPTO */
+
+static inline bool ufshcd_keyslot_valid(struct ufs_hba *hba,
+					unsigned int slot)
+{
+	return false;
+}
+
+static inline bool ufshcd_hba_is_crypto_supported(struct ufs_hba *hba)
+{
+	return false;
+}
+
+static inline bool ufshcd_is_crypto_enabled(struct ufs_hba *hba)
+{
+	return false;
+}
+
+static inline void ufshcd_crypto_enable(struct ufs_hba *hba) { }
+
+static inline void ufshcd_crypto_disable(struct ufs_hba *hba) { }
+
+static inline int ufshcd_hba_init_crypto(struct ufs_hba *hba)
+{
+	return 0;
+}
+
+static inline void ufshcd_crypto_setup_rq_keyslot_manager(
+					struct ufs_hba *hba,
+					struct request_queue *q) { }
+
+static inline void ufshcd_crypto_destroy_rq_keyslot_manager(
+				struct request_queue *q) { }
+
+#endif /* CONFIG_SCSI_UFS_CRYPTO */
+
+#endif /* _UFSHCD_CRYPTO_H */
-- 
2.22.0.rc1.311.g5d7573a151-goog

