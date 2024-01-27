Return-Path: <linux-block+bounces-2443-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3612483E849
	for <lists+linux-block@lfdr.de>; Sat, 27 Jan 2024 01:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688031C217A4
	for <lists+linux-block@lfdr.de>; Sat, 27 Jan 2024 00:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809441873;
	Sat, 27 Jan 2024 00:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yn3Il44T"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC0615AA
	for <linux-block@vger.kernel.org>; Sat, 27 Jan 2024 00:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706314814; cv=none; b=QgY5WjKOD8gTdS2f3e7SZGo9Wu5Fmyjth8fc/M9GpTJrt/68S+Rh4uiyfyLuOgtGS7sSj5Klt4ugse66mMFFnzJpKbwDAXkyCuOdj12mUJGEb4UGd/ZJdfpsX5/fBVtO/D1xutP7Cf3MiefTy1V8+YyTKDCUCjnmLWOgUBPNJsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706314814; c=relaxed/simple;
	bh=3R7+h3zFI/mwK/xcjYDHHHu6VIqETYMVQgLm8//Sp+U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q+/m7bH7/rcC3L8KOy4IZkRiueM5wFjwFLJK3AxrnAxNbckdeSX3DsASeWiZTnyGYYDbYsfC0hTp/YskTEa754gUShxvvVGWp6Jjp5qyQB5aPU3y3AtYrtwKzanrFzoAh8xYYUfHb/cVHpG9qhgiJy8hQkomaaT02MgUrIZ2pLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yn3Il44T; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5102a2e4b7bso1090232e87.1
        for <linux-block@vger.kernel.org>; Fri, 26 Jan 2024 16:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706314811; x=1706919611; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T3G6dDcsPJ8FpAk04EPKIfG8hS20g7KdlKTQ8wy7VrQ=;
        b=Yn3Il44TNYDui/6k6842tFGqhUbIEUY1jqSdRs/QPzu9KfHafWuo7N54hEovoeoivG
         QPB1iiFvrUV6k8AX94oD3/HdOicI9vEArUxb3i91nNL0jatvBkasM8pF4nYMORI8do2E
         ovCVZimZB8W8uowZlO1Yd8xF8DvrUZUqTkdaPXtWbU5vIxNqjAAV4KbrHnDI8GkMZGMz
         SmIh4Ksr114RMvRj7Vo/hJnSwKESLvKZ+z2QP14XJe09yVhwTGR8deRrVmycmdenrrr1
         sdyh/AL2RTQdR+8Je10QxgGbJPYLB6SvVGLauvePn/4vsiDBcwOdNxm5+GjH1sJs4ljX
         GANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706314811; x=1706919611;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3G6dDcsPJ8FpAk04EPKIfG8hS20g7KdlKTQ8wy7VrQ=;
        b=cezw+Gr7UsXYuTRaJaujVRA1pcho4piOB+AtdAW6ZRwAoxDFU4gUZYzlXB4HjIJmWe
         mAoTPlUhokklklFGPfajPTFPPqzyio0qaNRx+6+IkDvGNhgYgT3vS7ZiKiH7nLS2uRDL
         d6saWi3WvYAutwoazo1pf7sJeYXaASYIOdZHtiK14pEKnjMnCESw81slugJkxkivedwu
         4KLVOyBMt8CECzUFsL6zP7NQeELSEqJsFTPKlyPWoJLkzO4o/rbtf87qc3NCgXK4yw5k
         D9DOIXJj4Oo/AXMUPb5MDu1UncHMRiPqNyHi0qZ0N/mUhQTWLQqpbv5xfPH02ji8Td41
         eF5A==
X-Gm-Message-State: AOJu0YyUWImzekhpcnuKC9aDGqL1Nvg4z/BFR0Q1Tt1Se9nKgqAfJAzF
	dmQQWIL/+e8x601pYTIieCmigiHmSAz8ccoepvjG3aaOBNWj4pKm640kNQ6ipa4=
X-Google-Smtp-Source: AGHT+IHETzMQXQD13A79irpeoUYJgH4KjCBLUz0xQwCzpGKlgIghJKtL7etq65BJCSZObRjlm+i3BA==
X-Received: by 2002:a05:6512:138c:b0:50e:3e4a:f248 with SMTP id fc12-20020a056512138c00b0050e3e4af248mr252018lfb.3.1706314810790;
        Fri, 26 Jan 2024 16:20:10 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id x25-20020a19f619000000b0050e7f5cffa6sm325226lfe.273.2024.01.26.16.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 16:20:10 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 0/9] mmc: Use proper sg_miter for scatterlists
Date: Sat, 27 Jan 2024 01:19:47 +0100
Message-Id: <20240127-mmc-proper-kmap-v2-0-d8e732aa97d1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACNMtGUC/3WNyw6CMBBFf4XM2jFtoRpc+R+GRe0DJgptpoZoS
 P/dyt7lOck9d4PsmXyGS7MB+5UyxaWCOjRgJ7OMHslVBiVUJ6TSOM8WE8fkGR+zSRiU62zQTp7
 1CeoqsQ/03ou3ofJE+RX5sx+s8mf/t1aJAu+m162Vxrahvz5pMRyPkUcYSilfp44DjK8AAAA=
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
 Ming Lei <ming.lei@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Pitre <nico@fluxnic.net>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Angelo Dureghello <angelo.dureghello@timesys.com>
Cc: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

It was brought to our attention that some MMC host drivers
are referencing sg_virt(sg) directly on scatterlist entries,
which will not perform buffer bouncing for CONFIG_HIGHMEM
pages that reside in highmem.

See the following mail from Christoph and the discussion:
https://lore.kernel.org/linux-mmc/20240122073423.GA25859@lst.de/

This means that bugs with highmem pages can go unnoticed
until an actual highmem page is finally used and not bounced,
resulting in things like unpredictable file corruption.

Attempt to fix this by amending all host controllers
calling sg_virt() for PIO to instead do proper traversal
of the scatterlists using sg_miter helpers that will
kmap() the pages properly, possibly bouncing
it from highmem if need be.

All patches are compile-tested except the m68k one,
sdhci-esdhc-mcf.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Bite the bullet and just patch all drivers to use sg_miter
- Link to v1: https://lore.kernel.org/r/20240125-mmc-proper-kmap-v1-0-ba953c1ac3f9@linaro.org

---
Linus Walleij (9):
      mmc: davinci_mmc: Use sg_miter for PIO
      mmc: moxart-mmc: Factor out moxart_use_dma() helper
      mmc: moxart-mmc: Fix accounting in DMA transfer
      mmc: moxart-mmc: Use sg_miter for PIO
      mmc: mvsdio: Use sg_miter for PIO
      mmc: mxcmmc: Use sg_miter for PIO
      mmc: omap: Use sg_miter for PIO
      mmc: sdhci-esdhc-mcf: Use sg_miter for swapping
      mmc: sh_mmcif: Use sg_miter for PIO

 drivers/mmc/host/davinci_mmc.c     |  61 ++++++++++------------
 drivers/mmc/host/moxart-mmc.c      |  90 ++++++++++++++++----------------
 drivers/mmc/host/mvsdio.c          |  71 +++++++++++++++++++-------
 drivers/mmc/host/mxcmmc.c          |  53 +++++++++++--------
 drivers/mmc/host/omap.c            |  53 +++++++++----------
 drivers/mmc/host/sdhci-esdhc-mcf.c |  12 +++--
 drivers/mmc/host/sh_mmcif.c        | 102 +++++++++++++++++++++++--------------
 7 files changed, 251 insertions(+), 191 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240125-mmc-proper-kmap-f2d4cf5d1756

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


