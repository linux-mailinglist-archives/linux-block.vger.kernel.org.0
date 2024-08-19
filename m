Return-Path: <linux-block+bounces-10623-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C6D9570F7
	for <lists+linux-block@lfdr.de>; Mon, 19 Aug 2024 18:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA202B24EA2
	for <lists+linux-block@lfdr.de>; Mon, 19 Aug 2024 16:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE02517920A;
	Mon, 19 Aug 2024 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eliuQwPy"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2733D187848
	for <linux-block@vger.kernel.org>; Mon, 19 Aug 2024 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086359; cv=none; b=D1Wa20lU+rvjn76L+KGxvX/11DUIjwLmCo5hSXsaZ7bZVqLhl3mMKrJeN1l29RstCf0qdaGZ5VwRNnEknhM8GexdT0UKaqrC+Iy3Qb+a6dh5gBWNX1AqryijmyYahiuOeLPFLWyIj0vWnK8OU/FzbgCmz7bKONMAlnVpb8xWdls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086359; c=relaxed/simple;
	bh=kHKzvvyyQCeBkpz1OciLUTykSAMmzD8brX9rJ76+fHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/+Z69lvFFDW0WjUcBe4S6dZt3XLzv3vWDHwCkqQAL/8AF8/hYTueZmlXEHfr6LwOnfGUDRBdRHVQMSArppbQBs4APAdfmrK/oOuEpRrtdg9n13vUMZ2v9S24/HqQp7N7dvd9CDYqE7sEzjl37cPx4ruJIvvHVsdSLn5o5ynesc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eliuQwPy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724086357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwxbMRfa8A0AMonhiodSZXz8snc1ppjCUOJ6oxZMysE=;
	b=eliuQwPyZaHELVAPQvaSdf+sQNd3VIbsX/l3TQono4ylVoNptAT7AUlhrBqqnvd0oIgQK6
	4hIPZ/BLmzFmrdDLkn0v7NmQ6xs/xtKnbM0iu0zB04gCETio5SAfWU4doWEWG0PupxXgjx
	ZCeaDGJEpHoPsMSuL010tLb18uwuFmU=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-2E5mP-q7PnC0NkvxI_UzrQ-1; Mon, 19 Aug 2024 12:52:36 -0400
X-MC-Unique: 2E5mP-q7PnC0NkvxI_UzrQ-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-84309c6f3b0so86795241.0
        for <linux-block@vger.kernel.org>; Mon, 19 Aug 2024 09:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086355; x=1724691155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwxbMRfa8A0AMonhiodSZXz8snc1ppjCUOJ6oxZMysE=;
        b=UqXTSKxanxoooLWGpt/q8dBD3TTIQ0Duuhz/lK9T7LgMhZ1sd2ohh23GYrUvTl9xKz
         W47NdQ+UGq3dU9isu+oT7cB0lC31kUfiSgb2frc5eO99jhzvGOwD1aP922qJljnP0Ft2
         BQ/TvOnbLiSmPHIOZ82huu3vkV4TqdPzZmwaWIeUDiVVRmmsPnl6ME2EOQaiy8FJHyMK
         vjzk1mN/m6we4i4DaV6gPFz/OKbgJQBQd0J2TO/k/2PGkc2/OB+yzBUCzfxKCQrl2Tbv
         fg2YL23UURMImWbP+FYe6xwYiuj76Jf84qhe4gYDfnlnOypreeDPc3TNVRRykOnuMMne
         H0QA==
X-Forwarded-Encrypted: i=1; AJvYcCVJpwyCkKhIhGEHXEcxbmNDIRJ340QU53lwaK9cCTx/1Ep1L+8VXxnuO+QdDoi4iR1Ok+vaDgs7ZgEOsj5K+uioCb3tiaTTGctiyQ0=
X-Gm-Message-State: AOJu0Yww0MOBukZ5A66h+utrHLQGv4Uo5sE1H4sFym/SdxFNe+3HN24k
	zVw7DpZrjLI7xwrrBFf6LPmuPp3sOjUyXodavFib3UuHfS7bOEzKsVoU2xE5aWDvJZqByZmeYvc
	r0f+3gCi0FFQFa6SSlQDKtyC0K79pjQZDphM/CFOlpPJUohuNR9eM7BEdNoIZ
X-Received: by 2002:a05:6102:5494:b0:495:c40b:f7ca with SMTP id ada2fe7eead31-4977bf0d2d4mr5497603137.3.1724086355215;
        Mon, 19 Aug 2024 09:52:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHysbKKqXtZq0nkk+KqqjyQL404GAu1sdBPta+GD7btYSYi5SLJQ3pijiCStxEYNXypkns3Gw==
X-Received: by 2002:a05:6102:5494:b0:495:c40b:f7ca with SMTP id ada2fe7eead31-4977bf0d2d4mr5497574137.3.1724086354811;
        Mon, 19 Aug 2024 09:52:34 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff01e293sm446579885a.26.2024.08.19.09.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:52:34 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: onathan Corbet <corbet@lwn.net>,
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
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
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
Subject: [PATCH 1/9] PCI: Make pcim_release_region() a public function
Date: Mon, 19 Aug 2024 18:51:41 +0200
Message-ID: <20240819165148.58201-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240819165148.58201-2-pstanner@redhat.com>
References: <20240819165148.58201-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_release_region() is the managed counterpart of
pci_release_region(). It can be useful in some cases where drivers want
to manually release a requested region before the driver's remove()
callback is invoked.

Make pcim_release_region() a public function.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 1 +
 drivers/pci/pci.h    | 1 -
 include/linux/pci.h  | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index b97589e99fad..608f13ef2a4b 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -906,6 +906,7 @@ void pcim_release_region(struct pci_dev *pdev, int bar)
 	devres_release(&pdev->dev, pcim_addr_resource_release,
 			pcim_addr_resources_match, &res_searched);
 }
+EXPORT_SYMBOL(pcim_release_region);
 
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2fe6055a334d..01b55ed2867c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -889,7 +889,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 int pcim_intx(struct pci_dev *dev, int enable);
 int pcim_request_region_exclusive(struct pci_dev *pdev, int bar,
 				  const char *name);
-void pcim_release_region(struct pci_dev *pdev, int bar);
 
 /*
  * Config Address for PCI Configuration Mechanism #1
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 01b9f1a351be..dfa9af3a9c22 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2295,6 +2295,7 @@ void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
 int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
+void pcim_release_region(struct pci_dev *pdev, int bar);
 void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 				       const char *name);
 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
-- 
2.46.0


