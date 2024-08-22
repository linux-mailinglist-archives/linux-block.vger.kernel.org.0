Return-Path: <linux-block+bounces-10776-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1110C95B76F
	for <lists+linux-block@lfdr.de>; Thu, 22 Aug 2024 15:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7F81C20919
	for <lists+linux-block@lfdr.de>; Thu, 22 Aug 2024 13:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A622E1CE71A;
	Thu, 22 Aug 2024 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B66aLWlu"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDAC1CE6E1
	for <linux-block@vger.kernel.org>; Thu, 22 Aug 2024 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334500; cv=none; b=Sm1GSkO/aBDBFVNYTqpEQB3Djo7WwLh3jK8S/cz69mijpqafsrH7yNKX6VWTsPMEaLT4KTrUgmgaRz2ACHMJWyq6Uud7dZD83IAwDOxWUPwdWAl2ulh6A6UmreinkC7L6f3FL7pDFQkWeBGI9kN+pqMZH+TGFlMsSLcdsS3w0uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334500; c=relaxed/simple;
	bh=Me/VBGfLq2KkhHhzkti+j6tzd1UShbG7U7ve4P+FN3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYRiQXHRuXVfDN2Zm5nNRX0eiVTNgiweyo56wvkZmZGqLfiUm3ktAZoo4fPMSlv8Ot3A2rHNVPuQgL1scWMt4DL1y966FTIhiRs8RgXLPqdt051N57R6wb465QT6OMwZ2dl0qGfsHPEHv/AAfgeTIPOVnbwj6DpXshtZLI3qSEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B66aLWlu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724334497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6h4v+tZpLlqIwoSAXvFUJWXM7qY2tlcI9NvuTPZYAG4=;
	b=B66aLWluZZQxUarZ0ZOhNgGQMCY3d1fpM+hrj3THG9QvkjJKKygOpLG/5Q22QdJIQ+rUfQ
	dSTQeXaePII7kVogVSXnW3USeERqD0nbQLUzphIndqTPQV6+jCQUQCuYKu0LlWUz591EeC
	t4jOtv5AhLJFFWQwMQa6kjwDdLrCuWU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-xCpE2Wn3NIqdW_B6fUwt-w-1; Thu, 22 Aug 2024 09:48:12 -0400
X-MC-Unique: xCpE2Wn3NIqdW_B6fUwt-w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42808efc688so6813935e9.0
        for <linux-block@vger.kernel.org>; Thu, 22 Aug 2024 06:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724334491; x=1724939291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6h4v+tZpLlqIwoSAXvFUJWXM7qY2tlcI9NvuTPZYAG4=;
        b=wo78iGes1QhYa9crQZrf8ZHxrET85vrCAvl80iGJnEdyXnEH4CxyYkMqslESpTQPbg
         Tz4l/rEbKPQYmyjO7z8zNiClqswIOUscaUkKdOjuVJLw22ZbnX8XGVIWofQFPAKeVynn
         NKvcvrUAxYzFHIy1L4pBjPH3G8fxrF6hSsHW/6LWzQmluf/VQIwBpEOxtVSAi8xQhIUH
         p/9nJoscgRe/OU8QCsyUO0CS+05Hv5LjSqHbJBZbQA6EjY69IRPpgE9PV1D4vfJnlop9
         /T8xc0fNhoexNQruyxz82xLkw5xJxKVplNlJAB+WOaPXah3x360GvuAU44s520in097R
         VdXg==
X-Forwarded-Encrypted: i=1; AJvYcCUJrU6hD1Z12HCmrjnFOcr0ssO0n0OOsZkrcDfqkTcrpM0/bLe7BiZPn/8x64g1NePsyGLTp1Uxbi9XfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwW0y+PurIRkizA+A6uOpgtmwW4oDp27RZpyPQ3Yg1p9xIx/pjC
	H9wGfY4MESsflZBy+KcCWB8g1zS4qjwkiM5Ungk5QR6Lx1Eecy2sLug5tOVu+4UcbVYxIPottzL
	Xztpwd+ugVGzP5+YGS5HPHi2w88vIG7b4n2GEcoa1Ir6/iLqHI7vFkbb8BnCq
X-Received: by 2002:a05:600c:444b:b0:428:1ce0:4dfd with SMTP id 5b1f17b1804b1-42abf09ff9cmr36149845e9.34.1724334491028;
        Thu, 22 Aug 2024 06:48:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6akima5CtgXO6K5U8TUtsOlzD7gs9FdnvsxKJnG5gEPJ1/b/QeEPWH0oT+lxtkjuS4oHl+Q==
X-Received: by 2002:a05:600c:444b:b0:428:1ce0:4dfd with SMTP id 5b1f17b1804b1-42abf09ff9cmr36149635e9.34.1724334490614;
        Thu, 22 Aug 2024 06:48:10 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5162322sm25057215e9.24.2024.08.22.06.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:48:10 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Jens Axboe <axboe@kernel.dk>,
	Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Philipp Stanner <pstanner@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v3 8/9] vdap: solidrun: Replace deprecated PCI functions
Date: Thu, 22 Aug 2024 15:47:40 +0200
Message-ID: <20240822134744.44919-9-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822134744.44919-1-pstanner@redhat.com>
References: <20240822134744.44919-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

solidrun utilizes pcim_iomap_regions(), which has been deprecated by the
PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()"), among other
things because it forces usage of quite a complicated bitmask mechanism.
The bitmask handling code can entirely be removed by replacing
pcim_iomap_regions() and pcim_iomap_table().

Replace pcim_iomap_regions() and pcim_iomap_table() with
pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/vdpa/solidrun/snet_main.c | 52 +++++++++++--------------------
 1 file changed, 18 insertions(+), 34 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 67235f6190ef..fb15e844847d 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -556,36 +556,25 @@ static const struct vdpa_config_ops snet_config_ops = {
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 {
 	char *name;
-	int ret, i, mask = 0;
-	/* We don't know which BAR will be used to communicate..
-	 * We will map every bar with len > 0.
-	 *
-	 * Later, we will discover the BAR and unmap all other BARs.
-	 */
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (pci_resource_len(pdev, i))
-			mask |= (1 << i);
-	}
-
-	/* No BAR can be used.. */
-	if (!mask) {
-		SNET_ERR(pdev, "Failed to find a PCI BAR\n");
-		return -ENODEV;
-	}
+	unsigned short i;
 
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
 	if (!name)
 		return -ENOMEM;
 
-	ret = pcim_iomap_regions(pdev, mask, name);
-	if (ret) {
-		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
-		return ret;
-	}
-
+	/* We don't know which BAR will be used to communicate..
+	 * We will map every bar with len > 0.
+	 *
+	 * Later, we will discover the BAR and unmap all other BARs.
+	 */
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (mask & (1 << i))
-			psnet->bars[i] = pcim_iomap_table(pdev)[i];
+		if (!pci_resource_len(pdev, i))
+			continue;
+		psnet->bars[i] = pcim_iomap_region(pdev, i, name);
+		if (IS_ERR(psnet->bars[i])) {
+			SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
+			return PTR_ERR(psnet->bars[i]);
+		}
 	}
 
 	return 0;
@@ -600,14 +589,12 @@ static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
 	if (!name)
 		return -ENOMEM;
 	/* Request and map BAR */
-	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
-	if (ret) {
+	snet->bar = pcim_iomap_region(pdev, snet->psnet->cfg.vf_bar, name);
+	if (IS_ERR(snet->bar)) {
 		SNET_ERR(pdev, "Failed to request and map PCI BAR for a VF\n");
-		return ret;
+		return PTR_ERR(snet->bar);
 	}
 
-	snet->bar = pcim_iomap_table(pdev)[snet->psnet->cfg.vf_bar];
-
 	return 0;
 }
 
@@ -655,15 +642,12 @@ static int psnet_detect_bar(struct psnet *psnet, u32 off)
 
 static void psnet_unmap_unused_bars(struct pci_dev *pdev, struct psnet *psnet)
 {
-	int i, mask = 0;
+	unsigned short i;
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (psnet->bars[i] && i != psnet->barno)
-			mask |= (1 << i);
+			pcim_iounmap_region(pdev, i);
 	}
-
-	if (mask)
-		pcim_iounmap_regions(pdev, mask);
 }
 
 /* Read SNET config from PCI BAR */
-- 
2.46.0


