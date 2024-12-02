Return-Path: <linux-block+bounces-14757-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9DB9E0180
	for <lists+linux-block@lfdr.de>; Mon,  2 Dec 2024 13:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAAC281030
	for <lists+linux-block@lfdr.de>; Mon,  2 Dec 2024 12:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5363020899F;
	Mon,  2 Dec 2024 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="osD7ybsb"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C80F207A0C
	for <linux-block@vger.kernel.org>; Mon,  2 Dec 2024 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140983; cv=none; b=WDtQXnZZDSWrVnHHY3fBDHPUbdKF3NzbSDyyUVqRw0SfXI4p6cgRPsqQg9rzWeVf0h1FR5IaxKrqcUXRra7Dl/YCsB1+BttawXiCbqKognnaNoSONLXUYHDiWrtssqzgb/mjjHhnTYtAwKKQV0BSA+bPUIjJgUvQ9wVy+1WMVbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140983; c=relaxed/simple;
	bh=TA4B3fyGt2CM5SHreS4634i2jVgA0QAzzGXgqVryOAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jx9jtvTJGZKfkqKhulVitCS7P/FnS1Tt7lkATo11FYhYM7pPxS2Q1UwJ4wBXud5rYpTWCFelwhHZJD+Qalpuj8ywzravsnCzAxdEjGK0oyB8zpDKCbdvjhPpdq1FWAruqqlCRKgXBs6t67LK0Ux6QCV8LyKiJhr/O3QFCv02QgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=osD7ybsb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434ab938e37so25998955e9.0
        for <linux-block@vger.kernel.org>; Mon, 02 Dec 2024 04:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733140978; x=1733745778; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENVRndH/0R8z7KIBdB13dMhkwu6GEyC+j8MIg5fgRYY=;
        b=osD7ybsb56w9MGV/GcvGoyhKc6zSGeEkfvqneHzmTs/FDWQs6G8buEmUU7UwifFxYt
         QVrxh7L9RpYrVwJvtlQIaqRNmb7akJGnHwQmK8bHmZLNd0mLmYnQktJV+rX0GlCySGw9
         ZB1h7vfZQHLL5mK9LEM4liGjegJc70gZKnwT7JXeo5jkOQyyFuUd7GSOcMUWzaRhYfrE
         o3hgJTz4bpcZ5yvSuUwEeCjrN3Djneq2BjRZEXNlbNXTQ9L7Lp3NvoCL4BxMwZFrfrmH
         2taarIac+VIFhEDDu73UAs7/CZKjXgSM3rVsPQrE/LNJnUK6LkujmG2SBJcGKbDlfW4r
         bUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733140978; x=1733745778;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENVRndH/0R8z7KIBdB13dMhkwu6GEyC+j8MIg5fgRYY=;
        b=AIdT42ADx3kKqAZCn184+lRuYKFji2nULR9RpV41CGvuYg/0w54Ctc5uNLahA84C4x
         K3/d7rS9D5pvHpoJSsQyFjzvNemFw6i29bvh6es8RRFBR96veBEWN6G6SQsZZQfUIXFL
         B9omThLSob+7Stq0K5WB6dcuy0J+iuuCPqgnv/r1xNojtZi3swV8WvQZPl9HdGL/ezHA
         Qy4jsCKhV9R6oho7JbR74RRDK8+bLWWIMlv54goUSaWP/YbHj9HEzqdVR7uOmuK7AK17
         17kwL4sB83pSuwqYdAGyXA5h4PbZwYzAiSm3zS66VogMbFLRv7ZP83F9iqOiv0I7BqEe
         Ksow==
X-Gm-Message-State: AOJu0YzmweMIBPOstpnT5Pcj4qlFg0k+y/8F8yG6/YSxhkA2J89DSsiK
	NxbvMD2zDCCYNuZobB29uE1Ys/cYGRYTgSmelQgTfgH+cfEFZKmgwwSY+YdzU9U=
X-Gm-Gg: ASbGncsLdsWDXXUflfdxHLYLs0EBnb50XSD/klFryizqWtoFWX7+alzd5PTEXf7+XAI
	1flVVo3Vl1c86KQerGljSAWnW/AnZvMlSy26PsJQ1XXcI9h1EI6usHeW+DDgqb9IkYD9pWMRBef
	Ut68T560WNw/ROILtwuF2Q9OVkUiw1tuDP67X15zDpPgX/kwFG8HOdNvR2tatzhypnmr68r7xlZ
	z9Y/DYa1JcSMkLa1DxPJW4CmuM57RocpFhYqUYz
X-Google-Smtp-Source: AGHT+IFWyXRf8rkt+k0mrxH33J9pbMghYb3Zg0nOw117JklEJ2A8HlPMp2Xl9MunztcUpcgDviuWdQ==
X-Received: by 2002:a05:600c:b8b:b0:434:9e17:18e5 with SMTP id 5b1f17b1804b1-434a9d4f7famr223589455e9.0.1733140976376;
        Mon, 02 Dec 2024 04:02:56 -0800 (PST)
Received: from [127.0.1.1] ([193.57.185.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bed7sm152396095e9.8.2024.12.02.04.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 04:02:56 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 02 Dec 2024 13:02:26 +0100
Subject: [PATCH RESEND v7 10/17] soc: qcom: ice: add support for hardware
 wrapped keys
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-wrapped-keys-v7-10-67c3ca3f3282@linaro.org>
References: <20241202-wrapped-keys-v7-0-67c3ca3f3282@linaro.org>
In-Reply-To: <20241202-wrapped-keys-v7-0-67c3ca3f3282@linaro.org>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Asutosh Das <quic_asutoshd@quicinc.com>, 
 Ritesh Harjani <ritesh.list@gmail.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Gaurav Kashyap <quic_gaurkash@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, 
 linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Om Prakash Singh <quic_omprsing@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=8351;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=4eGznOyJ6jIlOR4N8SwTDY1Bm/ka7XPc9moCeYXUmlA=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnTaHURoKmLgKNErYt+kREnqsfebciFZDqEHUSY
 qn//W00zk6JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ02h1AAKCRARpy6gFHHX
 cillD/4lmG39c3yJzIIeRBg7RYJFW0rISfZaAyg8EJKILzOI/aV4YRrX4o9eBpHEJObvDkYEPPG
 2etWkhiGsEbKEsbZUMVN1vPVDIr1ZuQIwfOuk9RiAjMJ8CdtG91JP/yG+aGETnrxgAUlP99L14c
 giN37nqe5tnbCcRI+EZ5wMeb6VuYG8HtZFlBe2uKXt2Sj0nnQotufnKQPwWVBrIhThp+j7/Ytqm
 frQUShV0GH4EMCj7fU1fE3jLC1sOSO/h82S6tlJLv2ZJqT0TlytLUbe9iRe6m769Pne2hBVVnZf
 bpgppRtPoNaF/YECNEEUmpK4PxOfQs4ricaShn1gOrrShLRQI/TynLKnRZbLLhgQrFU3OmVXPsI
 RAlkcsH2eNl1aIFR5QUKbA730cZYQ6viekH4k+VE4lYdJIApmW760UUwhSVEAUb84ImlOaNxxCY
 GQxSoH7Zee0/Ay5KinfiwK814nwa08vjoc0AHkMZJvEyxj05/vqoCqwPi8d2NV0+0RtSVaOGZ85
 DzwjnRk0lpxdgKYNzfkYXMhV8YccMnkRoMTdADJo+AyvdEohaLrxggTiVfD6ucj3YehKRCWEtb+
 x3tbADP1cOteUL6cfOIPixok/S4LvHiHWcPqWBTWkCADwJGq3fsv/RmdAx3Y2bDCzVsOugqhA3T
 SFEuPkYxzkE2NdQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Gaurav Kashyap <quic_gaurkash@quicinc.com>

Now that HWKM support has been added to ICE, extend the ICE driver to
support hardware wrapped keys programming coming in from the storage
controllers (UFS and eMMC). This is similar to raw keys where the call is
forwarded to Trustzone, however we also need to clear and re-enable
CFGE before and after programming the key.

Derive software secret support is also added by forwarding the call to
the corresponding SCM API.

Wrapped keys are only used if the new module parameter is set AND the
architecture supports HWKM.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/soc/qcom/ice.c | 128 ++++++++++++++++++++++++++++++++++++++++++++-----
 include/soc/qcom/ice.h |   4 ++
 2 files changed, 121 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index 5f138e278554c..e83e74e39e44f 100644
--- a/drivers/soc/qcom/ice.c
+++ b/drivers/soc/qcom/ice.c
@@ -28,6 +28,8 @@
 #define QCOM_ICE_REG_BIST_STATUS		0x0070
 #define QCOM_ICE_REG_ADVANCED_CONTROL		0x1000
 #define QCOM_ICE_REG_CONTROL			0x0
+#define QCOM_ICE_LUT_KEYS_CRYPTOCFG_R16		0x4040
+
 /* QCOM ICE HWKM registers */
 #define QCOM_ICE_REG_HWKM_TZ_KM_CTL			0x1000
 #define QCOM_ICE_REG_HWKM_TZ_KM_STATUS			0x1004
@@ -62,6 +64,8 @@
 #define QCOM_ICE_HWKM_DISABLE_CRC_CHECKS_VAL	(BIT(1) | BIT(2))
 #define QCOM_ICE_HWKM_RSP_FIFO_CLEAR_VAL	BIT(3)
 
+#define QCOM_ICE_HWKM_CFG_ENABLE_VAL		BIT(7)
+
 /* BIST ("built-in self-test") status flags */
 #define QCOM_ICE_BIST_STATUS_MASK		GENMASK(31, 28)
 
@@ -69,6 +73,8 @@
 #define QCOM_ICE_FORCE_HW_KEY0_SETTING_MASK	0x2
 #define QCOM_ICE_FORCE_HW_KEY1_SETTING_MASK	0x4
 
+#define QCOM_ICE_LUT_KEYS_CRYPTOCFG_OFFSET	0x80
+
 #define QCOM_ICE_HWKM_REG_OFFSET	0x8000
 #define HWKM_OFFSET(reg)		((reg) + QCOM_ICE_HWKM_REG_OFFSET)
 
@@ -78,6 +84,15 @@
 #define qcom_ice_readl(engine, reg)	\
 	readl((engine)->base + (reg))
 
+#define QCOM_ICE_LUT_CRYPTOCFG_SLOT_OFFSET(slot) \
+	(QCOM_ICE_LUT_KEYS_CRYPTOCFG_R16 + \
+	 QCOM_ICE_LUT_KEYS_CRYPTOCFG_OFFSET * slot)
+
+static bool ufs_qcom_use_wrapped_keys;
+module_param_named(use_wrapped_keys, ufs_qcom_use_wrapped_keys, bool, 0660);
+MODULE_PARM_DESC(use_wrapped_keys,
+"Use HWKM for wrapped keys support if available on the platform");
+
 struct qcom_ice {
 	struct device *dev;
 	void __iomem *base;
@@ -88,6 +103,16 @@ struct qcom_ice {
 	bool hwkm_init_complete;
 };
 
+union crypto_cfg {
+	__le32 regval;
+	struct {
+		u8 dusize;
+		u8 capidx;
+		u8 reserved;
+		u8 cfge;
+	};
+};
+
 static bool qcom_ice_check_supported(struct qcom_ice *ice)
 {
 	u32 regval = qcom_ice_readl(ice, QCOM_ICE_REG_VERSION);
@@ -298,6 +323,46 @@ int qcom_ice_suspend(struct qcom_ice *ice)
 }
 EXPORT_SYMBOL_GPL(qcom_ice_suspend);
 
+/*
+ * For v1 the ICE slot will be calculated in the trustzone.
+ */
+static int translate_hwkm_slot(struct qcom_ice *ice, int slot)
+{
+	return (ice->hwkm_version == 1) ? slot : (slot * 2);
+}
+
+static int qcom_ice_program_wrapped_key(struct qcom_ice *ice,
+					const struct blk_crypto_key *key,
+					u8 data_unit_size, int slot)
+{
+	union crypto_cfg cfg = {
+		.dusize = data_unit_size,
+		.capidx = QCOM_SCM_ICE_CIPHER_AES_256_XTS,
+		.cfge = QCOM_ICE_HWKM_CFG_ENABLE_VAL,
+	};
+	int hwkm_slot;
+	int err;
+
+	hwkm_slot = translate_hwkm_slot(ice, slot);
+
+	/* Clear CFGE */
+	qcom_ice_writel(ice, 0x0, QCOM_ICE_LUT_CRYPTOCFG_SLOT_OFFSET(slot));
+
+	/* Call trustzone to program the wrapped key using hwkm */
+	err = qcom_scm_ice_set_key(hwkm_slot, key->raw, key->size,
+				   QCOM_SCM_ICE_CIPHER_AES_256_XTS, data_unit_size);
+	if (err) {
+		pr_err("%s:SCM call Error: 0x%x slot %d\n", __func__, err,
+		       slot);
+		return err;
+	}
+
+	/* Enable CFGE after programming key */
+	qcom_ice_writel(ice, cfg.regval, QCOM_ICE_LUT_CRYPTOCFG_SLOT_OFFSET(slot));
+
+	return err;
+}
+
 int qcom_ice_program_key(struct qcom_ice *ice,
 			 u8 algorithm_id, u8 key_size,
 			 const struct blk_crypto_key *bkey,
@@ -313,24 +378,40 @@ int qcom_ice_program_key(struct qcom_ice *ice,
 
 	/* Only AES-256-XTS has been tested so far. */
 	if (algorithm_id != QCOM_ICE_CRYPTO_ALG_AES_XTS ||
-	    key_size != QCOM_ICE_CRYPTO_KEY_SIZE_256) {
+	    (key_size != QCOM_ICE_CRYPTO_KEY_SIZE_256 &&
+	    key_size != QCOM_ICE_CRYPTO_KEY_SIZE_WRAPPED)) {
 		dev_err_ratelimited(dev,
 				    "Unhandled crypto capability; algorithm_id=%d, key_size=%d\n",
 				    algorithm_id, key_size);
 		return -EINVAL;
 	}
 
-	memcpy(key.bytes, bkey->raw, AES_256_XTS_KEY_SIZE);
+	if (ufs_qcom_use_wrapped_keys &&
+	    (bkey->crypto_cfg.key_type == BLK_CRYPTO_KEY_TYPE_HW_WRAPPED)) {
+		/* It is expected that HWKM init has completed before programming wrapped keys */
+		if (!ice->use_hwkm || !ice->hwkm_init_complete) {
+			dev_err_ratelimited(dev, "HWKM not currently used or initialized\n");
+			return -EINVAL;
+		}
+		err = qcom_ice_program_wrapped_key(ice, bkey, data_unit_size,
+						   slot);
+	} else {
+		if (bkey->size != QCOM_ICE_CRYPTO_KEY_SIZE_256)
+			dev_err_ratelimited(dev,
+					    "Incorrect key size; bkey->size=%d\n",
+					    algorithm_id);
+		return -EINVAL;
+		memcpy(key.bytes, bkey->raw, AES_256_XTS_KEY_SIZE);
 
-	/* The SCM call requires that the key words are encoded in big endian */
-	for (i = 0; i < ARRAY_SIZE(key.words); i++)
-		__cpu_to_be32s(&key.words[i]);
+		/* The SCM call requires that the key words are encoded in big endian */
+		for (i = 0; i < ARRAY_SIZE(key.words); i++)
+			__cpu_to_be32s(&key.words[i]);
 
-	err = qcom_scm_ice_set_key(slot, key.bytes, AES_256_XTS_KEY_SIZE,
-				   QCOM_SCM_ICE_CIPHER_AES_256_XTS,
-				   data_unit_size);
-
-	memzero_explicit(&key, sizeof(key));
+		err = qcom_scm_ice_set_key(slot, key.bytes, AES_256_XTS_KEY_SIZE,
+					   QCOM_SCM_ICE_CIPHER_AES_256_XTS,
+					   data_unit_size);
+		memzero_explicit(&key, sizeof(key));
+	}
 
 	return err;
 }
@@ -338,7 +419,23 @@ EXPORT_SYMBOL_GPL(qcom_ice_program_key);
 
 int qcom_ice_evict_key(struct qcom_ice *ice, int slot)
 {
-	return qcom_scm_ice_invalidate_key(slot);
+	int hwkm_slot = slot;
+
+	if (ice->use_hwkm) {
+		hwkm_slot = translate_hwkm_slot(ice, slot);
+
+		/*
+		 * Ignore calls to evict key when HWKM is supported and hwkm
+		 * init is not yet done. This is to avoid the clearing all
+		 * slots call during a storage reset when ICE is still in
+		 * legacy mode. HWKM slave in ICE takes care of zeroing out
+		 * the keytable on reset.
+		 */
+		if (!ice->hwkm_init_complete)
+			return 0;
+	}
+
+	return qcom_scm_ice_invalidate_key(hwkm_slot);
 }
 EXPORT_SYMBOL_GPL(qcom_ice_evict_key);
 
@@ -348,6 +445,15 @@ bool qcom_ice_hwkm_supported(struct qcom_ice *ice)
 }
 EXPORT_SYMBOL_GPL(qcom_ice_hwkm_supported);
 
+int qcom_ice_derive_sw_secret(struct qcom_ice *ice, const u8 wkey[],
+			      unsigned int wkey_size,
+			      u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
+{
+	return qcom_scm_derive_sw_secret(wkey, wkey_size,
+					 sw_secret, BLK_CRYPTO_SW_SECRET_SIZE);
+}
+EXPORT_SYMBOL_GPL(qcom_ice_derive_sw_secret);
+
 static struct qcom_ice *qcom_ice_create(struct device *dev,
 					void __iomem *base)
 {
diff --git a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h
index 1f52e82e3e1ca..dabe0d3a1fd05 100644
--- a/include/soc/qcom/ice.h
+++ b/include/soc/qcom/ice.h
@@ -17,6 +17,7 @@ enum qcom_ice_crypto_key_size {
 	QCOM_ICE_CRYPTO_KEY_SIZE_192		= 0x2,
 	QCOM_ICE_CRYPTO_KEY_SIZE_256		= 0x3,
 	QCOM_ICE_CRYPTO_KEY_SIZE_512		= 0x4,
+	QCOM_ICE_CRYPTO_KEY_SIZE_WRAPPED	= 0x5,
 };
 
 enum qcom_ice_crypto_alg {
@@ -35,5 +36,8 @@ int qcom_ice_program_key(struct qcom_ice *ice,
 			 u8 data_unit_size, int slot);
 int qcom_ice_evict_key(struct qcom_ice *ice, int slot);
 bool qcom_ice_hwkm_supported(struct qcom_ice *ice);
+int qcom_ice_derive_sw_secret(struct qcom_ice *ice, const u8 wkey[],
+			      unsigned int wkey_size,
+			      u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE]);
 struct qcom_ice *of_qcom_ice_get(struct device *dev);
 #endif /* __QCOM_ICE_H__ */

-- 
2.45.2


