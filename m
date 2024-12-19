Return-Path: <linux-block+bounces-15637-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 909C79F7C9A
	for <lists+linux-block@lfdr.de>; Thu, 19 Dec 2024 14:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D961516C398
	for <lists+linux-block@lfdr.de>; Thu, 19 Dec 2024 13:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6B7224AE3;
	Thu, 19 Dec 2024 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="REjNZR6B"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731B1224893
	for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734616124; cv=none; b=e3koLVbmAFMws6eW8BkRF4dVLL1G9tiS4mlQMZzje9Vv7xDAdR9AMTvTRJbusmxm1ZeNvvam53NFvY1rJ1G7rNxzi1+vt6TYqqAU0anBJhv1fbZ/K+E0718IhrndZT8qRlx7UjGBN7lO54yZO278Z9H60BYb5rdbI934sH/p1rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734616124; c=relaxed/simple;
	bh=XO81+Jcc5NmcuuvImCT+riJpdk47c6EberFwhgQPnN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+wtw5NYOu3F4fsanZ7W+/IropM2Q6fE0sbgrxZGNPoaTCsK1NSzTe3XROintL2ioz37SVAmfqgmW2MLTkIrSMuxUANA7bJdEvwWqFtOS+bOkbhiqvXZrewiEANLcJwT0MI9vy5CRH50qkSyBfgoGansuoGv0Ja62JJt7TfXLVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=REjNZR6B; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6f3d31808e3so6102807b3.3
        for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 05:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734616121; x=1735220921; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=In5HoeH7y9Mw3MBgtXCixaUYWromv5oJ1tBlMI+S7Q8=;
        b=REjNZR6BGRCN2DgSdk0QfEuduSImCWkihNMRBtywBWw0e70c4Eu9aDUJoa6smjlXwl
         jYZzloAdbI/oQOZsCcHamifcT5NCOCSnxdiwa2tcd97T9gXxmSNyQosX1qRxXVl6y+90
         A9RXitzUlLTnSaZT+1N3GxXLFS54mERtWLwb2KxCzpM2+SeL2BAkaCRMs4TVe6vAnE3j
         2A28PScdKwRgqJUIc/rl0NVzLKdHZnFnqO+SteJwoxPfXkX5SpD9bqH1LJupzevO65X2
         mwlPi6bwdPd0sqRzcZAG9VkHVEcqJ6SACvdkXDmRLs72VudubIc/L6WNlHRKtUIsBBGP
         KSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734616121; x=1735220921;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=In5HoeH7y9Mw3MBgtXCixaUYWromv5oJ1tBlMI+S7Q8=;
        b=XJCjIhNc9FRIT8VgVQxAazPpd/csFcUxs9knmphKUoZK6ZvUtziN5rCblptAsosK5U
         1BZFDvr9TSE2r4x4wUj6nZeEoeeluYiVZLf5/JE86M0vcHQ+qebcXRrvUF/qo5y0tktU
         h+T0mAyQh9Grsj/AVpet7PeeCqEkgbFma213dnN6AnKsLtiDIsC70Iq9pRr55DOTUY9V
         8t5IVpecU12ga+Y8TWkuyyhga/sEwL3l6qfivQCmRDMaB7LE7oqiKM4qeXdRB2xEXqPC
         SCzWu2zmRDIzXYCwW97y6pXzIXh6w/ZGmd7kpPAi1EXJss0j6Obc5rrnRG3zO8n1nBKP
         Cbqw==
X-Gm-Message-State: AOJu0YzwXBmBqTCewu+6+5FJDbkZSGRF3Cqp5q7m5K5tQb4hWAobmm0y
	q6D7FBqrAs/QaZXzPvfdQXTzMbfmAud9R4mzyCGPdHYGcIrt+hn3dlhhYs6s4lYwiM9Vi+uI9FP
	EJnuyVmTbjQht6ywluZc7bzaQovCWqp8LgcjcQQ==
X-Gm-Gg: ASbGncvbQYY9mfd/gP+gB0n4YtZ8Pfo8TlF1V1SeiSb5itxrGBxwuauBZ/QJ6iNpY9q
	S9m2jOEBNC05hg+8lBYAleSWkyAXFCkxkh/S8Vxg=
X-Google-Smtp-Source: AGHT+IHAgTWL75NXrM2GBK4SDn0t2shp+CeG7oHDnfNd5GjPl4y15Kf6WPYgbK4lJLVly6G4hcWHSkGBI5QdeqgJhdo=
X-Received: by 2002:a05:690c:708b:b0:6ef:94db:b208 with SMTP id
 00721157ae682-6f3d263a814mr55382397b3.24.1734616121516; Thu, 19 Dec 2024
 05:48:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213041958.202565-1-ebiggers@kernel.org> <20241213041958.202565-6-ebiggers@kernel.org>
In-Reply-To: <20241213041958.202565-6-ebiggers@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Dec 2024 14:48:05 +0100
Message-ID: <CAPDyKFp01751khZ7xKC0QFtsoqxVifTH4im6_2yq4heurdONRw@mail.gmail.com>
Subject: Re: [PATCH v10 05/15] mmc: sdhci-msm: fix crypto key eviction
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Gaurav Kashyap <quic_gaurkash@quicinc.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, Bjorn Andersson <andersson@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Jens Axboe <axboe@kernel.dk>, 
	Konrad Dybcio <konradybcio@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, stable@vger.kernel.org, 
	Abel Vesa <abel.vesa@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Dec 2024 at 05:20, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Commit c7eed31e235c ("mmc: sdhci-msm: Switch to the new ICE API")
> introduced an incorrect check of the algorithm ID into the key eviction
> path, and thus qcom_ice_evict_key() is no longer ever called.  Fix it.
>
> Fixes: c7eed31e235c ("mmc: sdhci-msm: Switch to the new ICE API")
> Cc: stable@vger.kernel.org
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-msm.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index e00208535bd1..319f0ebbe652 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1865,24 +1865,24 @@ static int sdhci_msm_program_key(struct cqhci_host *cq_host,
>         struct sdhci_host *host = mmc_priv(cq_host->mmc);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>         union cqhci_crypto_cap_entry cap;
>
> +       if (!(cfg->config_enable & CQHCI_CRYPTO_CONFIGURATION_ENABLE))
> +               return qcom_ice_evict_key(msm_host->ice, slot);
> +
>         /* Only AES-256-XTS has been tested so far. */
>         cap = cq_host->crypto_cap_array[cfg->crypto_cap_idx];
>         if (cap.algorithm_id != CQHCI_CRYPTO_ALG_AES_XTS ||
>                 cap.key_size != CQHCI_CRYPTO_KEY_SIZE_256)
>                 return -EINVAL;
>
> -       if (cfg->config_enable & CQHCI_CRYPTO_CONFIGURATION_ENABLE)
> -               return qcom_ice_program_key(msm_host->ice,
> -                                           QCOM_ICE_CRYPTO_ALG_AES_XTS,
> -                                           QCOM_ICE_CRYPTO_KEY_SIZE_256,
> -                                           cfg->crypto_key,
> -                                           cfg->data_unit_size, slot);
> -       else
> -               return qcom_ice_evict_key(msm_host->ice, slot);
> +       return qcom_ice_program_key(msm_host->ice,
> +                                   QCOM_ICE_CRYPTO_ALG_AES_XTS,
> +                                   QCOM_ICE_CRYPTO_KEY_SIZE_256,
> +                                   cfg->crypto_key,
> +                                   cfg->data_unit_size, slot);
>  }
>
>  #else /* CONFIG_MMC_CRYPTO */
>
>  static inline int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
> --
> 2.47.1
>

