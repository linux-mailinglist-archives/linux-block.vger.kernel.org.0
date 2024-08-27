Return-Path: <linux-block+bounces-10971-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1105D96177B
	for <lists+linux-block@lfdr.de>; Tue, 27 Aug 2024 20:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E7C1C23145
	for <lists+linux-block@lfdr.de>; Tue, 27 Aug 2024 18:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE99A1D47DF;
	Tue, 27 Aug 2024 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRcIFQk9"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25601D4602
	for <linux-block@vger.kernel.org>; Tue, 27 Aug 2024 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784995; cv=none; b=QqBesSoAiadlsYzggrnPitp4D50WsW9bCJUa5lNexxj3lpCLLhkUj0X6YML/2ljg5GWzrW07jLb2XU7dwNAm89Ynt7Btwz+2ovWQt/6ioeJqnhS+81E09FsOqnUvYo554DgebLKHOI65PaDcE8FHYQ+1NvWT2UBTnL0l8b44k34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784995; c=relaxed/simple;
	bh=ARR42U31SsfvWWCrHwbXesPCT1d63Wp8dyC5fYwgRtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTgNmnUeQVulDzk5dS+ENwfVtV1++3mMbflWYoZ3WI2ibdnjJPW0B/CD5G3Uyr/rb9NQ4G2Nv+q4acu9vAenzORpXMfz7NGLPUtmzD3IVavW3EvUyLUHKK1WWNJ1TS/WdgHsbr3DUEFC42Tnf6I3IAHtEeTqfspnkmf9U3dvwT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gRcIFQk9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724784992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ot52nkK/Na0X35bsJx5mf+W03nkANhJiuieinuTtF+Y=;
	b=gRcIFQk9h0YOjcRwh6+nV57h82zaEKTd4oMlTGd/gxHo6Syuj0OalOHSwGrqrBBkvnKPK+
	NhlxNM5Qx+fj5Tk6lHejNoGKZ+4PgfD2x85El7LmAueczL5OIWKwr+QoZnOmlNbz3mLJlr
	FRIMIklIN/ITRbFFJCcASfntahKSGJs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-TOy2sXFSMrSEqPuz1FK39g-1; Tue, 27 Aug 2024 14:56:31 -0400
X-MC-Unique: TOy2sXFSMrSEqPuz1FK39g-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a868b6d6882so837366266b.1
        for <linux-block@vger.kernel.org>; Tue, 27 Aug 2024 11:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724784989; x=1725389789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ot52nkK/Na0X35bsJx5mf+W03nkANhJiuieinuTtF+Y=;
        b=wWqfTm5ar+0sRbrQRITIDNHlQqzT0HjVpnwUrWiUEKJuNkvFLq63EeR1/dJXW1fs51
         Zp+MW/Faq7aUzqjEy8XqcPmNg5RBEBakQCdX2YgHSdfJYNMNm/ior6WCUB4eFqsUQlKc
         1CvDdg5M2QmIJSDp17+s+932sDv9QIJak9t/R8NzFXUFDs1xrbU2WfFPyHGTWtUnuOBx
         QDzry1eRylnA0BkO0+GE2Tu9H959vOxrJzRcaHjMwFQqaB1ecPZAFd4KwO+dKjyWc7n/
         8NufhixKIQK1uHNZh5geWkBHAgD3y4NU6FDiDafB5soxUIx6L6iRoq6C5A82VxdplpXj
         +uKA==
X-Gm-Message-State: AOJu0YyjkkPPJmaACvmmwFWItkUPs9aT04kvPSG0zuT5OhbxClh6+7Il
	Tsau/QT57usTJPpepmPU/t/GSP7bmmTF6mo6Ls8s7NiS5rTNwy6FdwoZQ80SsTG+RXA/avkNvAJ
	0s+JtE8evn+UXzwoJ4zy1ArudWb2ilwtScHhI4+w0qHS59qpg6o8yWHBeG3DE
X-Received: by 2002:a17:907:968b:b0:a77:dbf9:118f with SMTP id a640c23a62f3a-a870589d7bemr19231366b.13.1724784988736;
        Tue, 27 Aug 2024 11:56:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpPIsWnweTtHk2jYqlmIfKSsDaoipOeMWhXQ4B5bGcQn25jUZvX7EeAh161EGEDUYY0nmhrA==
X-Received: by 2002:a17:907:968b:b0:a77:dbf9:118f with SMTP id a640c23a62f3a-a870589d7bemr19227366b.13.1724784988317;
        Tue, 27 Aug 2024 11:56:28 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dbc:3c00:460c:db7e:8195:ddb5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549c4e9sm141473066b.47.2024.08.27.11.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:56:27 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: ens Axboe <axboe@kernel.dk>,
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
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v4 5/7] ethernet: cavium: Replace deprecated PCI functions
Date: Tue, 27 Aug 2024 20:56:10 +0200
Message-ID: <20240827185616.45094-6-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827185616.45094-1-pstanner@redhat.com>
References: <20240827185616.45094-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Furthermore, the driver contains an unneeded call to
pcim_iounmap_regions() in its probe() function's error unwind path.

Replace the deprecated PCI functions with pcim_iomap_region().

Remove the unnecessary call to pcim_iounmap_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/net/ethernet/cavium/common/cavium_ptp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cavium/common/cavium_ptp.c b/drivers/net/ethernet/cavium/common/cavium_ptp.c
index 9fd717b9cf69..914ccc8eaf5e 100644
--- a/drivers/net/ethernet/cavium/common/cavium_ptp.c
+++ b/drivers/net/ethernet/cavium/common/cavium_ptp.c
@@ -239,12 +239,11 @@ static int cavium_ptp_probe(struct pci_dev *pdev,
 	if (err)
 		goto error_free;
 
-	err = pcim_iomap_regions(pdev, 1 << PCI_PTP_BAR_NO, pci_name(pdev));
+	clock->reg_base = pcim_iomap_region(pdev, PCI_PTP_BAR_NO, pci_name(pdev));
+	err = PTR_ERR_OR_ZERO(clock->reg_base);
 	if (err)
 		goto error_free;
 
-	clock->reg_base = pcim_iomap_table(pdev)[PCI_PTP_BAR_NO];
-
 	spin_lock_init(&clock->spin_lock);
 
 	cc = &clock->cycle_counter;
@@ -292,7 +291,6 @@ static int cavium_ptp_probe(struct pci_dev *pdev,
 	clock_cfg = readq(clock->reg_base + PTP_CLOCK_CFG);
 	clock_cfg &= ~PTP_CLOCK_CFG_PTP_EN;
 	writeq(clock_cfg, clock->reg_base + PTP_CLOCK_CFG);
-	pcim_iounmap_regions(pdev, 1 << PCI_PTP_BAR_NO);
 
 error_free:
 	devm_kfree(dev, clock);
-- 
2.46.0


