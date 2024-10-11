Return-Path: <linux-block+bounces-12499-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B2B99AC24
	for <lists+linux-block@lfdr.de>; Fri, 11 Oct 2024 21:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E9E287F6E
	for <lists+linux-block@lfdr.de>; Fri, 11 Oct 2024 19:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ECB1EF0A2;
	Fri, 11 Oct 2024 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EUw9LV2u"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9979D1E501B
	for <linux-block@vger.kernel.org>; Fri, 11 Oct 2024 18:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672902; cv=none; b=cb9umXqJImWn1yaFQmv4b8W5vhOJypX7QrcEJ+LKCqojtyb0aa6Nlr1grsugYMBpSscXBOZYbzE/tjrAxnUI56d1GFHlOMyp2GoFQm0yXANVpcuB9+jHR5f1yRCJObD0Sewmdhfi3g2Vv/U0q3UlvaBNvwvub9ueYBkGzaJ410A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672902; c=relaxed/simple;
	bh=de+Joho0wbPNo8CWOb0AcSIqfyHWF2VNRtpxf3ipnTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pj9KOh12NP32WdZ4xEiTzcT74ieQas2PgwsoDfauuZG/SxdW/3Fe/yJlnzjSFLvJzidkUOPFaVTNKUaZmGT6Xrg86nXWIhYLCHjVWxk0teWwhDXXb/4PivqAXClTjTLb47GBRKt1zD5lscizcpMlU9jH0imTxqIovpMEUKuTlUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EUw9LV2u; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5389917ef34so2856791e87.2
        for <linux-block@vger.kernel.org>; Fri, 11 Oct 2024 11:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728672890; x=1729277690; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ps/3PAJ3ohu5EX4FhnSIgzxwM5atSAD0wceEQwc56sw=;
        b=EUw9LV2uZyVQ+l5j65X2oCcW4ZwzTBztf/8s+0MAAecK1K6dW3hCAU16koSEAEJrB1
         FeKhZ4DlWJpdvXYuK6uuhAtqCtv4TymBxA9Tepj8Z81Q6By6iITF62OI9mh0kiD6KE3R
         PwGmCsf8+xWtS2oKs9V65bFDUHJU+jG6vumYM1+zMlwg+9+zLqqNGk4JAgYVOf8sZ/75
         gUxSsAbEl4BtCioBu0j6/2ZguR83eNgLDfoJcHyZV2HZudmbrgANbBiTXEnPxSyxLyoF
         xtO0jSXNGCo/tJr/XaNPuEE2hf7Yl6MTkdZNAHizYIP9ZQaJ2UeW6LCL8RnM1lHD1r/L
         fUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672890; x=1729277690;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ps/3PAJ3ohu5EX4FhnSIgzxwM5atSAD0wceEQwc56sw=;
        b=h9pUrZRRcYI1SNHs/72yfJbAeCpXnPfmZlyHAkjfQyygGPQAGY1Go86vcJtN6fpEej
         GYUSaWdyVHAXDGhEUXIAQFQnfVjBaOV5ktfHnW46X8PSwFyZY8UvKHt6nkkKhOhseZ6L
         BbkbS2QVJh1681s7Ugr9rkzarH7QfPvXmk+Gj4HMQ9anLvlU2ARISSpUbYdqJzZvs7qw
         fWrD8vAWI113ThBntBBO7lIjIz5b7tVhlyPuD6wrgtLmMpCkfRVCN4ikrjut9sfr/WnV
         W2qExtodrn5ReBjLKSou5FeeKRq535r3SnbvLedYsTIQ/+4B9BEpo7tlVKClPhZKeVVY
         n59g==
X-Gm-Message-State: AOJu0YzMNJaQnsRt8zaRYQkStn1vVV0UkUMWgaOOMK0r9kcbEFu9UruY
	nU1CyF0gEkrJX7PnaODUKvR8DohmEi18ksfGkq2TgMT1dNFQn+FOu8fMLHoMFJU=
X-Google-Smtp-Source: AGHT+IGryQ+lDGfgxxnvNV6uEKWx0nZm13Qlc3Jq8RCK1OxEnQ7Fu390jY8YHDD/SiysCseIMG22uQ==
X-Received: by 2002:a05:6512:3f12:b0:52e:9e70:d068 with SMTP id 2adb3069b0e04-539e54d8534mr315850e87.4.1728672890181;
        Fri, 11 Oct 2024 11:54:50 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:68b8:bef:b7eb:538f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fe7csm4559161f8f.70.2024.10.11.11.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:54:49 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 11 Oct 2024 20:54:14 +0200
Subject: [PATCH v7 15/17] ufs: host: add support for wrapped keys in QCom
 UFS
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-wrapped-keys-v7-15-e3f7a752059b@linaro.org>
References: <20241011-wrapped-keys-v7-0-e3f7a752059b@linaro.org>
In-Reply-To: <20241011-wrapped-keys-v7-0-e3f7a752059b@linaro.org>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Asutosh Das <quic_asutoshd@quicinc.com>, 
 Ritesh Harjani <ritesh.list@gmail.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Gaurav Kashyap <quic_gaurkash@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, 
 linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Om Prakash Singh <quic_omprsing@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1566;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=xwlnjVi2jUBjlpEUGbvLRfkKAv4bV9u9b8J3YkckciQ=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnCXRhOM98BaLy+q2AKnKZIbe+voo3BHWq8M7xV
 +qKTBPs9pmJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZwl0YQAKCRARpy6gFHHX
 crVmD/40O6xkBP6h8NyYU34WFQR1qaACPd/tKq6J3kqHjlS8fkWN66g8j5Hhxq/puv6/1ZZPnbz
 XbDU/qZMT/wWGnH5wZhhDNvXSogJMnSw1UQM+nE7PXA6lzuK+x9BftbfzAP3zkJVTTR6KEIcLw1
 a1ZYnkx0j3dq/R0LrKqNoxncs0QADkjTlEKjThFplgsLaPYCCqJPkKzBdj+BV9i8q6P5IECVIk7
 Cu3GkDDXmSGZX5IbjNNogP4JZEcRNIb8JvBW7uJYBytHAUHwzWfflGSvb0ivqW0t6qbzVHBxTU3
 esGjsMj62bdPDYub9Sq9amuC3ebo92wOcdhNd303wXI4UXAme+eBI1laG3Qk738IQ3TitxATSer
 TUufZA52+/PS/tYJAizXt1UkXnlXXNC525jg2cdubxSyPsFC1MP0Nvh0NOGx+jeZctTsim+lqDs
 HA9TVdaPqKePieSSUbIruTYMNeCxe37VzLdlqCH+U9BJfLkC8HdNi/dyovJe2C1/006ufpvadxD
 7zTqa5LWgoE5MtDhj4A25h5L7Z2BN1fx4ny7IPBh9xBBH3smd9cb1VmYuuZeUYXw9K1wkzUFmy6
 I4pMmP/35DcvP7ce6qKSjE0olZBOjtqKrM8NAyesEwWVtFYj7cmC6gIloxvDFUhiojYRz8lz0OT
 TPvGyYq9+bWFnDQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Gaurav Kashyap <quic_gaurkash@quicinc.com>

Use the wrapped keys capability when HWKM is supported. Whether to use
HWKM or not would be decided during an ICE probe, and based on this
information, UFS can decide to use wrapped or raw keys.

Also, propagate the appropriate key size to the ICE driver when wrapped
keys are used.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 2f317a4c3edf..880df3a8955a 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -129,6 +129,8 @@ static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
 
 	host->ice = ice;
 	hba->caps |= UFSHCD_CAP_CRYPTO;
+	if (qcom_ice_hwkm_supported(host->ice))
+		hba->caps |= UFSHCD_CAP_WRAPPED_CRYPTO_KEYS;
 
 	return 0;
 }
@@ -166,7 +168,11 @@ static int ufs_qcom_ice_program_key(struct ufs_hba *hba,
 	    cap.key_size != UFS_CRYPTO_KEY_SIZE_256)
 		return -EOPNOTSUPP;
 
-	ice_key_size = QCOM_ICE_CRYPTO_KEY_SIZE_256;
+	if (bkey->crypto_cfg.key_type == BLK_CRYPTO_KEY_TYPE_HW_WRAPPED)
+		ice_key_size = QCOM_ICE_CRYPTO_KEY_SIZE_WRAPPED;
+	else
+		ice_key_size = QCOM_ICE_CRYPTO_KEY_SIZE_256;
+
 	if (config_enable)
 		return qcom_ice_program_key(host->ice,
 					    QCOM_ICE_CRYPTO_ALG_AES_XTS,

-- 
2.43.0


