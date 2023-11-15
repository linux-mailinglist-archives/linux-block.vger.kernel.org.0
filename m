Return-Path: <linux-block+bounces-155-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A43B57EB874
	for <lists+linux-block@lfdr.de>; Tue, 14 Nov 2023 22:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B981F25DDC
	for <lists+linux-block@lfdr.de>; Tue, 14 Nov 2023 21:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386E72FC4A;
	Tue, 14 Nov 2023 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-block@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5F62FC4D
	for <linux-block@vger.kernel.org>; Tue, 14 Nov 2023 21:19:00 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97816F3;
	Tue, 14 Nov 2023 13:18:59 -0800 (PST)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1cc1ee2d8dfso54699435ad.3;
        Tue, 14 Nov 2023 13:18:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699996739; x=1700601539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/jFKmYA4b/I5NdwoRTgPurns61Kr2vxDZ6EVCw0jDk=;
        b=nxR3Owm/C5fKiKxIFueC6spGafX9/yPdXrG1K/n7vIspel6cQoBglyvXGWgdslWW7E
         02LPOvDc+k8j8oPP0flDynrYaN3hI8k2Ztam8Pp48/yPBJNYo8JreJZhHqkeaJzCxR5m
         RmEsjRCoDfq5NQyY6gJ4f29zGTNb9X5RbmhKS+L+00SqyhZXt+Ac+xHehDytRz4BA/MU
         jIklwFBmMAf4TespQ7FUV8ejc7BlDavr4xUgemihKRj0ZOnkNz5166e7Bs4XDTRX6lkF
         cAsyPOxEi2QNL3QDhiQyX2/G8r81sFu+Cj6r9dlFHHS9vn4owpi0GPnfayPrvY2nq2RK
         wdNw==
X-Gm-Message-State: AOJu0YyKE0jVOTUfTgEKEVNLk18dKWpman++rEBYbMGiSVr16Jj/MH0K
	7sAccKDKcbyEINy9+UHi5z4=
X-Google-Smtp-Source: AGHT+IELUfic68TNf5ipjG5vfFrum1HgG4FKPn2VNX9AD8GYZCLWSHXfxiqeEAMv3UiEnYUNzF70PA==
X-Received: by 2002:a17:903:40cd:b0:1cc:4071:fa44 with SMTP id t13-20020a17090340cd00b001cc4071fa44mr4328683pld.8.1699996738949;
        Tue, 14 Nov 2023 13:18:58 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:2278:ad72:cefb:4d49])
        by smtp.gmail.com with ESMTPSA id ix7-20020a170902f80700b001c71ec1866fsm6169288plb.258.2023.11.14.13.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 13:18:58 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	"Bao D . Nguyen" <quic_nguyenb@quicinc.com>,
	Can Guo <quic_cang@quicinc.com>,
	Avri Altman <avri.altman@wdc.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Bean Huo <beanhuo@micron.com>,
	Keoseong Park <keosung.park@samsung.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v15 14/19] scsi: ufs: hisi: Rework the code that disables auto-hibernation
Date: Tue, 14 Nov 2023 13:16:22 -0800
Message-ID: <20231114211804.1449162-15-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231114211804.1449162-1-bvanassche@acm.org>
References: <20231114211804.1449162-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The host driver link startup callback is called indirectly by
ufshcd_probe_hba(). That function applies the auto-hibernation
settings by writing hba->ahit into the auto-hibernation control
register. Simplify the code for disabling auto-hibernation by
setting hba->ahit instead of writing into the auto-hibernation
control register. This patch is part of an effort to move all
auto-hibernation register changes into the UFSHCI driver core.

Reviewed-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Can Guo <quic_cang@quicinc.com>
Cc: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/host/ufs-hisi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/ufs/host/ufs-hisi.c b/drivers/ufs/host/ufs-hisi.c
index 0229ac0a8dbe..2e032eaf9e93 100644
--- a/drivers/ufs/host/ufs-hisi.c
+++ b/drivers/ufs/host/ufs-hisi.c
@@ -142,7 +142,6 @@ static int ufs_hisi_link_startup_pre_change(struct ufs_hba *hba)
 	struct ufs_hisi_host *host = ufshcd_get_variant(hba);
 	int err;
 	uint32_t value;
-	uint32_t reg;
 
 	/* Unipro VS_mphy_disable */
 	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xD0C1, 0x0), 0x1);
@@ -232,9 +231,7 @@ static int ufs_hisi_link_startup_pre_change(struct ufs_hba *hba)
 		ufshcd_writel(hba, UFS_HCLKDIV_NORMAL_VALUE, UFS_REG_HCLKDIV);
 
 	/* disable auto H8 */
-	reg = ufshcd_readl(hba, REG_AUTO_HIBERNATE_IDLE_TIMER);
-	reg = reg & (~UFS_AHIT_AH8ITV_MASK);
-	ufshcd_writel(hba, reg, REG_AUTO_HIBERNATE_IDLE_TIMER);
+	hba->ahit = 0;
 
 	/* Unipro PA_Local_TX_LCC_Enable */
 	ufshcd_disable_host_tx_lcc(hba);

