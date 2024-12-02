Return-Path: <linux-block+bounces-14760-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 946739E032D
	for <lists+linux-block@lfdr.de>; Mon,  2 Dec 2024 14:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D7B2B27B19
	for <lists+linux-block@lfdr.de>; Mon,  2 Dec 2024 12:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E8E20A5DC;
	Mon,  2 Dec 2024 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="L1vnA/1M"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668D1209F27
	for <linux-block@vger.kernel.org>; Mon,  2 Dec 2024 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140988; cv=none; b=E+hszw+z9SrDwu0UUXLbrS8fTqoluZREZlWuDyTFcs9IXT17GJMKs0uEkIEnVw2MmxdrtCY6G1wrmu4LcROwlXw6lVj0pBp86k9XcHd3udZV8A5BT724u0vaBvpvFuvZ3WTurUmJz7EUrJJ+gKZlZbs7YzBpdMh1pF1B2LL94kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140988; c=relaxed/simple;
	bh=rDgzjyrCxow20O57yxOKv5Dt7aQaZyB78v7qF4RvpKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WrhingYmJm+hKtDt4sy2f6Z/k/ZV/Tws9ohe0SEwuohYYsy1eQJwGV3TUVNnxZElUE7tZVYBOkH+IjhUysdiUmLilg1Od/DDAcLNJRgdefS3E7vS9C3R8IMLGS9cL4HP/qxzl7zYAOnWnWLwpry+vPxLwLtaI9z7E4jJ2rxDlZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=L1vnA/1M; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385e2c52c21so1199048f8f.2
        for <linux-block@vger.kernel.org>; Mon, 02 Dec 2024 04:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733140984; x=1733745784; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KbT2yjWECByZX4YoBFRCDGctDmzwqVa2hRpV/DsyHrc=;
        b=L1vnA/1Ml8heFmX4+W2mrHZkB5VAfBU4x1yqkH30N5Istx0eFdnEvSCOvJOtm3UPJh
         A79pDdxhXeRvYz280U1HWb7XKM2uCqW5iuOYvBJILA0jqZgy5o/vqmxV+v0IAsdGBsS2
         VeSSnSmQEKKo7GurfLHwWyIZ0bm5qNJhpyUmt/eYLnlRUEQPiEGHlvQKUXZBOiR8kuQ1
         ffn/bSKx2MnSkYJMyTf5PSRuC6fKKh1bBMcwKv9n1ICwA73y2WZF8h+ChwOFI2C3uYea
         luIlnOyQjEkem1BjSihw2JTpZM5lUl4/nKx10dxNOl5fkE++9BtCIBJYdRcwZE+sHWyi
         TWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733140984; x=1733745784;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbT2yjWECByZX4YoBFRCDGctDmzwqVa2hRpV/DsyHrc=;
        b=gOCcL8CoXCSiAw2ysXNpzwK2o5yayuHmE+/9SJjE5Zpkr6odwwP0dAT/LBAX1bev80
         GY1kfy2BC0DTPeK3FDI248bsffO71e36JT1vi0B59MLeAVkHkXALQyux85WHkaT1Hrhs
         n1JUnOGPVhr0rkrp5LKw3x4W4Gulvj9Ducu/pgxutT4S/Wkubn2IDxa6jPejBwW18FCf
         rvNOxTasaxb5zxQKbSkEiwFZ2ypkWKpo4TL68ACT7OiqN0o8mIY2+hkKdKC52DRYitHL
         kuK5hstdrtWxguOCPsHOq9xN7d453ptvBfwi+L6qy0N7/uzu9sY2W5K2Y9H3JkdXx65P
         THTg==
X-Gm-Message-State: AOJu0YyT0K4n4moWK6H3msYdCrQKac7kGPzrkuN+maQ+c1avcnQpempJ
	x57ydMIPWN5CSS6T87kdh94P7hZF21sFBtWEzfbbZqhw6Aosvp+qgSfzFVh6sRs=
X-Gm-Gg: ASbGncuLH6f6/lXB5NOMX9kgwsDCsmTGLRLaAg6zFDAEkF3GOe0dYCNEGWv5KU8TdGj
	esbjdK7wTnAgcEhN2+5zh95SK1uU2GL8SjGOV+p6nMSzO0cZHpzGfJ8Tb5+YCGCQnuiih3pUhRB
	q1VFla8cs1IR33U0bfbIS/RhX1c7dXz8dgrCYhYxDWRuLjT5uB1wKsJP814qWF30/QQ8cvdKS/2
	zSJGoMMq5WeHa2DSHWfNGAKB0sRpJgJOe0omlSf
X-Google-Smtp-Source: AGHT+IE8InKM+5p5YhbHKlZqW5eKtWZzURRtuhs650gYc2AEjKaWvw/sZZSN1CqSTaFlPcWax4Q/Mw==
X-Received: by 2002:a5d:64ee:0:b0:385:f677:859b with SMTP id ffacd0b85a97d-385f67789a8mr1422366f8f.10.1733140983205;
        Mon, 02 Dec 2024 04:03:03 -0800 (PST)
Received: from [127.0.1.1] ([193.57.185.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bed7sm152396095e9.8.2024.12.02.04.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 04:03:02 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 02 Dec 2024 13:02:29 +0100
Subject: [PATCH RESEND v7 13/17] ufs: core: add support for deriving the
 software secret
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-wrapped-keys-v7-13-67c3ca3f3282@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2650;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=MQigyGWoS7egCiFabEGvOIGlVmzO1zHpQlE1Kmp4zmE=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnTaHVIFBM1y8uWTaoURGUfuIgsk9gDANWKQCsa
 8zWklwoa4iJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ02h1QAKCRARpy6gFHHX
 cgLDEADBrjGlnEDnOX6YzXmxa3INqU5S9zTFOsYDq/wb2dUpJF462gP2OnwVdwfJVV0cyWufaVS
 0/l0ZqTS3zvGBArVt6A1c8blcMiztmUuVjRcwhKHNRnzbf2JIZlGbgd1I7b6YYS1twaziT+9c25
 iG3kbnS9u10fc7U4HqOOd+9DpVXJ4uxY3DPvP8W3gh0lJGfxeNmnlXwItZIB0EJ3Zi/0K4lJcg5
 cKDNcTr2MQlnc2WZ1G/nsWB2Ar2LoP61yARuh5xaLaD0dAK+iQ4CqDdzazIw+hiko+8Tx9zoxSY
 cHdvYsWKYYgEnzt8DkEmZH8/QYKXAYxgwL1HP49sIGLwq2NRREAXQCmXXJZ7NihiNinLMQsl5Et
 pKNVMm/VP27H3ysZv1Es74K+PkL9uC5yzLEHbnElaGefcEfoZW9elsd6PHdxKkZ7HHVPg0CH6Gz
 EwYJUrlucD2BHHbfFT5OFScj583jzecNIRSnYLsbhT2npxqsG5fhEamL9RaDwexQ/32+qZeaogO
 Gz7hx9WMoOAy8hfUXGhlKuY8R6kammvqYgztudMdbTxwkPFfipCHbXUr9lXjNVBV6fAoB1KuIAT
 jLGh8Hk2Aigj6gUSpjqyX5uG+LzT9c1GHeN0XsOW/MxPLokfo/7Eat/kVPMFFdjUuL13y5zqNwx
 wlUgeZoRfVCAaMw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Gaurav Kashyap <quic_gaurkash@quicinc.com>

Extend the UFS core to allow calling the block layer's callback for
deriving the software secret from a wrapped key. This is needed as in
most cases the wrapped key support will be vendor-specific and the
implementation will live in the specific UFS driver.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/ufs/core/ufshcd-crypto.c | 15 +++++++++++++++
 include/ufs/ufshcd.h             |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/ufs/core/ufshcd-crypto.c b/drivers/ufs/core/ufshcd-crypto.c
index 64389e8769108..2530239d42afa 100644
--- a/drivers/ufs/core/ufshcd-crypto.c
+++ b/drivers/ufs/core/ufshcd-crypto.c
@@ -113,6 +113,20 @@ static int ufshcd_crypto_keyslot_evict(struct blk_crypto_profile *profile,
 	return ufshcd_program_key(hba, NULL, &cfg, slot);
 }
 
+static int ufshcd_crypto_derive_sw_secret(struct blk_crypto_profile *profile,
+					  const u8 wkey[], size_t wkey_size,
+					  u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
+{
+	struct ufs_hba *hba =
+		container_of(profile, struct ufs_hba, crypto_profile);
+
+	if (hba->vops && hba->vops->derive_sw_secret)
+		return hba->vops->derive_sw_secret(hba, wkey, wkey_size,
+						   sw_secret);
+
+	return -EOPNOTSUPP;
+}
+
 /*
  * Reprogram the keyslots if needed, and return true if CRYPTO_GENERAL_ENABLE
  * should be used in the host controller initialization sequence.
@@ -134,6 +148,7 @@ bool ufshcd_crypto_enable(struct ufs_hba *hba)
 static const struct blk_crypto_ll_ops ufshcd_crypto_ops = {
 	.keyslot_program	= ufshcd_crypto_keyslot_program,
 	.keyslot_evict		= ufshcd_crypto_keyslot_evict,
+	.derive_sw_secret	= ufshcd_crypto_derive_sw_secret,
 };
 
 static enum blk_crypto_mode_num
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index db2b71f760717..1b7c36e5347b2 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -375,6 +375,9 @@ struct ufs_hba_variant_ops {
 	int	(*program_key)(struct ufs_hba *hba,
 			       const struct blk_crypto_key *bkey,
 			       const union ufs_crypto_cfg_entry *cfg, int slot);
+	int	(*derive_sw_secret)(struct ufs_hba *hba, const u8 wkey[],
+				    unsigned int wkey_size,
+				    u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE]);
 	int	(*fill_crypto_prdt)(struct ufs_hba *hba,
 				    const struct bio_crypt_ctx *crypt_ctx,
 				    void *prdt, unsigned int num_segments);

-- 
2.45.2


