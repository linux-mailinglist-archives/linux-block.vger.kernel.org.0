Return-Path: <linux-block+bounces-10767-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6309D95B728
	for <lists+linux-block@lfdr.de>; Thu, 22 Aug 2024 15:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67CDFB21E09
	for <lists+linux-block@lfdr.de>; Thu, 22 Aug 2024 13:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD421CBE9D;
	Thu, 22 Aug 2024 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGRVCIgi"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191221CB332
	for <linux-block@vger.kernel.org>; Thu, 22 Aug 2024 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334484; cv=none; b=LQimX2bqNX1DhogCQo5bjIh+qA/9OkWjxSvTo9tvJ3WKEVqB+DRnLCV30blmVO9A8+lHOzwhO7FCuGh8qh9nj1JBn/AlO40UXwYhBItFhnTjIweWgvLAHr0qn9OH1JXl1m/bM7Ck1uklq8/uaUlzwE9BGBwsxhc4nIdwQaZuDqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334484; c=relaxed/simple;
	bh=mHz+ZZWFhHEQhgF8fgLbMMsZfX1XWBKyTlte92c7V0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCebbMljcDp3Krixi6Ic8IQsPGHI9hFOGAxU9j2uFPK23w4dl9xT8mjBh2hVBBvyy3dIxwl485tIgJ4AhdccUGaZZiyoSJ8SB3jgCauxcq2OM4B6UhBYumKCD3A/ZZWZSitKt2wyybpGrc5Y46hp2xQhlA59+AaCfj5wz13oTL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGRVCIgi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724334482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ch4IaqQVqf4n7EviAoZPVdER6FOrpbjt4F1+Z0pU5Q=;
	b=ZGRVCIgiQtFyD2AulXGcvqUnETGmYD2qC7YSGSS2Ph9OndTEGDiLa9r7SgxgN9UMjGfzMd
	zic0hwFmUXJazVAGowdOc/jzSJ5PHtoRQkhIaE+dzn3htjg72kahAmDgOiRMfMlujU156H
	aKANf20hClrisTiFs6yk/BL3+1C/ctU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-iEl9GfQSPoW-JFx49-KGUw-1; Thu, 22 Aug 2024 09:48:01 -0400
X-MC-Unique: iEl9GfQSPoW-JFx49-KGUw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-428040f49f9so7858345e9.0
        for <linux-block@vger.kernel.org>; Thu, 22 Aug 2024 06:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724334480; x=1724939280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ch4IaqQVqf4n7EviAoZPVdER6FOrpbjt4F1+Z0pU5Q=;
        b=pLMOiTGUFwvzvw8PVOdq0P8Bcqbs4477WUnzCaIVPAQb65c95M9BkuDsoCoalB2KHP
         vCkJnK4cFAx70ZNTzAeuQ7MVkNmi9kFajzJGEsJ4AqxuXWpqcNmgk5weOeEAekXzY2+v
         DJ6jHNGJg75BycY+AOdtmuQTnYHAgJt1qOCyyhGv3miSqTLuv/lwIXUULMIQTz1lldPc
         Pag15Djis1zUILR6ANxYOnvwOMPrXbU9GgbcKpppccYgsgcuquUKOa0vk5DADeH20zYD
         I+4ZfhKboK0MeHZXcapPXPSAg4GoMIDwhB6ByYDLD4ouwdN6zMXawVXyRlQUFphCE+1E
         CB5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJdS2hrgDM5u7ugVS3vb8Afi6qr+GSuV/TUr7nYUNwC8NOLAHjD7VeUcTMPjTtEYYPlMll6XWoPLI3BA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPvMMNI7hZEf/MYTAsOIWx/0+aTzBao8LElQ+qJxG4TB1VEWMs
	RYiz3Bo4wza2m1H05aAciUUE4lwxzkqIeG6W0fbAJp8geGefrLGcYLDw04lVw5ypWxXG0XIZyVU
	chEOJTcOyInK7O8va48kO5cO+5tO9fpeY1gZrjbVSBuPpAPQYP/h7udoV/Ef1
X-Received: by 2002:adf:a396:0:b0:367:9c12:3e64 with SMTP id ffacd0b85a97d-372fd720f34mr3836226f8f.46.1724334479706;
        Thu, 22 Aug 2024 06:47:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHicvTaV+jAoa2XrftQuR7HNHJhvtQLD9wOQsI8y66hbliXuVEgvDzv31xvb8+T4AYL0nh8nA==
X-Received: by 2002:adf:a396:0:b0:367:9c12:3e64 with SMTP id ffacd0b85a97d-372fd720f34mr3836180f8f.46.1724334479068;
        Thu, 22 Aug 2024 06:47:59 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5162322sm25057215e9.24.2024.08.22.06.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:47:58 -0700 (PDT)
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
Subject: [PATCH v3 1/9] PCI: Make pcim_iounmap_region() a public function
Date: Thu, 22 Aug 2024 15:47:33 +0200
Message-ID: <20240822134744.44919-2-pstanner@redhat.com>
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

The function pcim_iounmap_regions() is problematic because it uses a
bitmask mechanism to release / iounmap multiple BARs at once. It, thus,
prevents getting rid of the problematic iomap table mechanism which was
deprecated in commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()").

Make pcim_iounmap_region() public as the successor of
pcim_iounmap_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/devres.c | 3 ++-
 include/linux/pci.h  | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index b97589e99fad..4dbba385e6b4 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -771,7 +771,7 @@ EXPORT_SYMBOL(pcim_iomap_region);
  * Unmap a BAR and release its region manually. Only pass BARs that were
  * previously mapped by pcim_iomap_region().
  */
-static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
+void pcim_iounmap_region(struct pci_dev *pdev, int bar)
 {
 	struct pcim_addr_devres res_searched;
 
@@ -782,6 +782,7 @@ static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
 	devres_release(&pdev->dev, pcim_addr_resource_release,
 			pcim_addr_resources_match, &res_searched);
 }
+EXPORT_SYMBOL(pcim_iounmap_region);
 
 /**
  * pcim_iomap_regions - Request and iomap PCI BARs (DEPRECATED)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 01b9f1a351be..9625d8a7b655 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2297,6 +2297,7 @@ void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
 int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
 void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 				       const char *name);
+void pcim_iounmap_region(struct pci_dev *pdev, int bar);
 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name);
-- 
2.46.0


