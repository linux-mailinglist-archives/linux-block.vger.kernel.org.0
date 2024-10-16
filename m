Return-Path: <linux-block+bounces-12637-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC28A9A05F9
	for <lists+linux-block@lfdr.de>; Wed, 16 Oct 2024 11:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950A82813FB
	for <lists+linux-block@lfdr.de>; Wed, 16 Oct 2024 09:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61781206944;
	Wed, 16 Oct 2024 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYX13cgS"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44113206954
	for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072168; cv=none; b=SefFdcJ7kFFdQTwSnrKrPsr2noYbE+G2rjrayjlRLOsAXMFC8Dps6NqxW9C08+w4ic+y7RujF9itRG0lKnjFpOKOyWlolItYBjb7kZyGVYMq+lqRXDNVhcJG69dSZV9NzbTpbQfOOnmy9bH+6yPKUjH+OnVpppJPCOt1AJ8PAtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072168; c=relaxed/simple;
	bh=tJu5U2oC9OD6rR3Vcl19luaP+UNIfavq6ySX6Ao35wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/eHABOzFy0WmGT0g9Nx9WiCtqzy4/1rNnZ3SC8IvkFEUuVneu6m+Njlxizd2hI15pMkq6zM9B/htxkro718Rvdx6BvIMXpeFpWLo+DJ5Va+5pQmHaJerzb4PN4k5bGdR7z54fyCIPBQrlApSM3n074RvuXT9pkK1L62PQyu6Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYX13cgS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729072165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZnMvQjSP3jZBMFekrBQlY/hq8+zQym4SrGgl7pIccig=;
	b=CYX13cgSEOWYEM8IJA9CtL9EF/Z5+WUocyFbbUBFwgffjzMtWJGUt1Xbs0GdcJgkHe/E/b
	Tipo7j2iOd5Z3gB1LlaWdRYMivsD0mzQDWgkuB08zcuNsQI9ov0cUxDurjNl0PD+amrx/9
	ZRXsXvwgk6e+iEthviAxj7/VD8FREaA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-l9hLy_EyPaCGe5Muu1ud9A-1; Wed, 16 Oct 2024 05:49:20 -0400
X-MC-Unique: l9hLy_EyPaCGe5Muu1ud9A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-431248c438eso3971255e9.0
        for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 02:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729072159; x=1729676959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnMvQjSP3jZBMFekrBQlY/hq8+zQym4SrGgl7pIccig=;
        b=GliSmfPDfOcN+xhJnDDxQP6EdHeym7PXG8cbo7GCn5jl5l7ro8jTqmmban1xx7zGNS
         LpmfwGXphwwzlsM5jXpcO5xj5c8JNnkyL5QkPtZKzgM9Pkf+ErtemQxr4KE778ZqGKkK
         IoDusI0vaBqFT3UYgofN88jQfausRoJznHXGtLXZNMu0wcHtw5mt6BiUF7k65azzGx7y
         Ozxl9vb6fDZ2qR6C7vLkbJ7oFto8rEK2wRiJMcFXm1R/TO/pY19r2wAY71eSoIt04GlE
         +dL9WO185yu/Z+ULRyHV8nlxJ86NioA6dmxe+wJmITOJYQfZpHc4HDzoDjmqC4ffxBrS
         tfBA==
X-Gm-Message-State: AOJu0YwENPD3jWSBh8ID3h9M+cHbiJBSYejvWub5H+5AHad6Ry+S5mfi
	mZ5niQoPp2NwKiT5DWACtteb39T42eWlaTmIHBf3nqINfvOjT7MVMBe2ybZuN5sCI4yYHeAC+5O
	14EtMlt93BcXSWGHPz1m1A8h1KUaC3UqP1dhkcMgB5xieA0XRbTA8PelbcU54
X-Received: by 2002:a05:600c:54cc:b0:431:52da:9d89 with SMTP id 5b1f17b1804b1-43152daa0ecmr7721005e9.1.1729072159441;
        Wed, 16 Oct 2024 02:49:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfsAAAGgUBJ0f9Xs7hYUhseqFHC1b9z96yM3vsvYHHD2153BJru4vUCPyjdhRiv6k6fxkIdQ==
X-Received: by 2002:a05:600c:54cc:b0:431:52da:9d89 with SMTP id 5b1f17b1804b1-43152daa0ecmr7720745e9.1.1729072159038;
        Wed, 16 Oct 2024 02:49:19 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4314b32e487sm28190235e9.25.2024.10.16.02.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 02:49:18 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
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
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Philipp Stanner <pstanner@redhat.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Zetao <lizetao1@huawei.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v8 1/6] PCI: Make pcim_iounmap_region() a public function
Date: Wed, 16 Oct 2024 11:49:04 +0200
Message-ID: <20241016094911.24818-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016094911.24818-2-pstanner@redhat.com>
References: <20241016094911.24818-2-pstanner@redhat.com>
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

pcim_iounmap_region() does not have that problem. Make it public as the
successor of pcim_iounmap_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 3 ++-
 include/linux/pci.h  | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index b133967faef8..7b12e2a3469c 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -773,7 +773,7 @@ EXPORT_SYMBOL(pcim_iomap_region);
  * Unmap a BAR and release its region manually. Only pass BARs that were
  * previously mapped by pcim_iomap_region().
  */
-static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
+void pcim_iounmap_region(struct pci_dev *pdev, int bar)
 {
 	struct pcim_addr_devres res_searched;
 
@@ -784,6 +784,7 @@ static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
 	devres_release(&pdev->dev, pcim_addr_resource_release,
 			pcim_addr_resources_match, &res_searched);
 }
+EXPORT_SYMBOL(pcim_iounmap_region);
 
 /**
  * pcim_iomap_regions - Request and iomap PCI BARs (DEPRECATED)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4c2be6..c4221aca20f9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2296,6 +2296,7 @@ static inline void pci_fixup_device(enum pci_fixup_pass pass,
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 				const char *name);
+void pcim_iounmap_region(struct pci_dev *pdev, int bar);
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
 int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
-- 
2.47.0


