Return-Path: <linux-block+bounces-2452-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8770383E866
	for <lists+linux-block@lfdr.de>; Sat, 27 Jan 2024 01:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16F631F22698
	for <lists+linux-block@lfdr.de>; Sat, 27 Jan 2024 00:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F38D33F6;
	Sat, 27 Jan 2024 00:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RYLiIB4A"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D964533FA
	for <linux-block@vger.kernel.org>; Sat, 27 Jan 2024 00:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706314827; cv=none; b=LIp808jvhC8zIRk4v/krAVXqYila6+ZmfYuZmrDUmu8A96b9oiei6lN9vS2yXZetCFQKGSgLyNXD14ScAsLfBeRHFelk6d9zN+riQ4qFOVFhdUvfMZHub181gACXxtw8FvXSvAPLoM9Wb+WMMjHJH7svDKk3OUh0Q3/8qsaCADI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706314827; c=relaxed/simple;
	bh=m64DINGtjwCb4sGpGFmOo+EROZNKY2mbmaeuUuBBRqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PdzPRVhIhfGq1Nna/3if9PuHtOwXAi4gl0yngnd8aB4xwdGG98CX2kH9lt5aY3DyfgFHDTXsIWEVqNAs8MoNo6LdbcvyGGSWh01paFVWOHX1w5xrzZBYN0ZmHVBR55+ennz7B3RL4GTHxvY0D1OPhU4a29IZI8GgBdyK6XYCJvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RYLiIB4A; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e5a9bcec9so983404e87.3
        for <linux-block@vger.kernel.org>; Fri, 26 Jan 2024 16:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706314822; x=1706919622; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6xRTgWpwVbdQrYrVCpj0/5DkwYyjb0pfDixXSPxg08=;
        b=RYLiIB4ADJHqpt3w+GfoD4jp2simx33+zgqY8KZJz2yIZURm2B9EXPDTS0/r0GfBTp
         xKSC/l2vAZYkoflIvphhspZYegwjiakFVmaIMr6Lh/XupXMo+GtyOPkF6hSEK/Fuww1g
         ynPuvL5xEfcWNh2MfR42Y49ks6xzvJi62OnfD6LtAa+IxTBM++2kba+JFO0Bfrlh3KdW
         FhxK2Nd3DHIjXA8DaPVqlxznpSwwLZ75aLpAV/UN5quT5qev3QXAYIPcFshCb9GsUqUH
         Qf4thQ0tg81raETEun2Em2qFHwQIO8vj3dvX814xTnGWb0q4ZQE/7v9hf12sUueYqV8H
         yWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706314822; x=1706919622;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6xRTgWpwVbdQrYrVCpj0/5DkwYyjb0pfDixXSPxg08=;
        b=hS2BW3sJ/L7xXSom0xHHDNuQPQ5FELnvF2nB4wtmX8uOpLli70uB5X+WYYXnjw8fhK
         bA1cdTLsOu35IkB/dCzrhEGr2D6mDKsActyBAMQOmDbahhCMF7KHOzGOD2gMwKHX8lBQ
         pF2N9xhcwSTrPICswxQ30RaYasMrLiKphRy/SqOB9a7j3LLs2LeJ7P3D9of30DCzvLX3
         9qFRRwsaGi+85m/gpNV0vwz+6QhBZD0yfCsfG0zS+R02329NZATHh5bBqorL4CdaMRKJ
         YY+T/u000nuJg5d1QejlQUoxkkm3Fk92PTUD+SA//G1npXl5+UIEjMcuhOyXU/OAkoby
         X7sQ==
X-Gm-Message-State: AOJu0YyXLTNYvcZ9xqjmZszK68yZ7bfaL7lSCdjxv9sU1hV6E9SxpktL
	ar6T1nO2CALndpsRenZEObARnpn++eh8jQE+lGw3CCVRLBmQGwDi48ti8SPaBLo=
X-Google-Smtp-Source: AGHT+IFODti9q2E+Agfa3fBrMz3o9POZ0N1iM9LXhM4BVi8Jox9fI3RwAY18ghi+6oR5uiYdJhU9kQ==
X-Received: by 2002:ac2:4907:0:b0:510:c62:d97b with SMTP id n7-20020ac24907000000b005100c62d97bmr305904lfi.45.1706314822099;
        Fri, 26 Jan 2024 16:20:22 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id x25-20020a19f619000000b0050e7f5cffa6sm325226lfe.273.2024.01.26.16.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 16:20:21 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 27 Jan 2024 01:19:56 +0100
Subject: [PATCH v2 9/9] mmc: sh_mmcif: Use sg_miter for PIO
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240127-mmc-proper-kmap-v2-9-d8e732aa97d1@linaro.org>
References: <20240127-mmc-proper-kmap-v2-0-d8e732aa97d1@linaro.org>
In-Reply-To: <20240127-mmc-proper-kmap-v2-0-d8e732aa97d1@linaro.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
 Ming Lei <ming.lei@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Pitre <nico@fluxnic.net>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Angelo Dureghello <angelo.dureghello@timesys.com>
Cc: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

Use sg_miter iterator instead of sg_virt() and custom code
to loop over the scatterlist. The memory iterator will do
bounce buffering if the page happens to be located in high memory,
which the driver may or may not be using.

Suggested-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/linux-mmc/20240122073423.GA25859@lst.de/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/sh_mmcif.c | 102 +++++++++++++++++++++++++++-----------------
 1 file changed, 63 insertions(+), 39 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 077d711e964e..1ef6e153e5a3 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -227,14 +227,12 @@ struct sh_mmcif_host {
 	bool dying;
 	long timeout;
 	void __iomem *addr;
-	u32 *pio_ptr;
 	spinlock_t lock;		/* protect sh_mmcif_host::state */
 	enum sh_mmcif_state state;
 	enum sh_mmcif_wait_for wait_for;
 	struct delayed_work timeout_work;
 	size_t blocksize;
-	int sg_idx;
-	int sg_blkidx;
+	struct sg_mapping_iter sg_miter;
 	bool power;
 	bool ccs_enable;		/* Command Completion Signal support */
 	bool clk_ctrl2_enable;
@@ -600,32 +598,17 @@ static int sh_mmcif_error_manage(struct sh_mmcif_host *host)
 	return ret;
 }
 
-static bool sh_mmcif_next_block(struct sh_mmcif_host *host, u32 *p)
-{
-	struct mmc_data *data = host->mrq->data;
-
-	host->sg_blkidx += host->blocksize;
-
-	/* data->sg->length must be a multiple of host->blocksize? */
-	BUG_ON(host->sg_blkidx > data->sg->length);
-
-	if (host->sg_blkidx == data->sg->length) {
-		host->sg_blkidx = 0;
-		if (++host->sg_idx < data->sg_len)
-			host->pio_ptr = sg_virt(++data->sg);
-	} else {
-		host->pio_ptr = p;
-	}
-
-	return host->sg_idx != data->sg_len;
-}
-
 static void sh_mmcif_single_read(struct sh_mmcif_host *host,
 				 struct mmc_request *mrq)
 {
+	struct mmc_data *data = mrq->data;
+
 	host->blocksize = (sh_mmcif_readl(host->addr, MMCIF_CE_BLOCK_SET) &
 			   BLOCK_SIZE_MASK) + 3;
 
+	sg_miter_start(&host->sg_miter, data->sg, data->sg_len,
+		       SG_MITER_ATOMIC | SG_MITER_TO_SG);
+
 	host->wait_for = MMCIF_WAIT_FOR_READ;
 
 	/* buf read enable */
@@ -634,20 +617,32 @@ static void sh_mmcif_single_read(struct sh_mmcif_host *host,
 
 static bool sh_mmcif_read_block(struct sh_mmcif_host *host)
 {
+	struct sg_mapping_iter *sgm = &host->sg_miter;
 	struct device *dev = sh_mmcif_host_to_dev(host);
 	struct mmc_data *data = host->mrq->data;
-	u32 *p = sg_virt(data->sg);
+	u32 *p;
 	int i;
 
 	if (host->sd_error) {
+		sg_miter_stop(sgm);
 		data->error = sh_mmcif_error_manage(host);
 		dev_dbg(dev, "%s(): %d\n", __func__, data->error);
 		return false;
 	}
 
+	if (!sg_miter_next(sgm)) {
+		/* This should not happen on single blocks */
+		sg_miter_stop(sgm);
+		return false;
+	}
+
+	p = sgm->addr;
+
 	for (i = 0; i < host->blocksize / 4; i++)
 		*p++ = sh_mmcif_readl(host->addr, MMCIF_CE_DATA);
 
+	sg_miter_stop(&host->sg_miter);
+
 	/* buffer read end */
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFRE);
 	host->wait_for = MMCIF_WAIT_FOR_READ_END;
@@ -666,34 +661,40 @@ static void sh_mmcif_multi_read(struct sh_mmcif_host *host,
 	host->blocksize = sh_mmcif_readl(host->addr, MMCIF_CE_BLOCK_SET) &
 		BLOCK_SIZE_MASK;
 
+	sg_miter_start(&host->sg_miter, data->sg, data->sg_len,
+		       SG_MITER_ATOMIC | SG_MITER_TO_SG);
+
 	host->wait_for = MMCIF_WAIT_FOR_MREAD;
-	host->sg_idx = 0;
-	host->sg_blkidx = 0;
-	host->pio_ptr = sg_virt(data->sg);
 
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
 }
 
 static bool sh_mmcif_mread_block(struct sh_mmcif_host *host)
 {
+	struct sg_mapping_iter *sgm = &host->sg_miter;
 	struct device *dev = sh_mmcif_host_to_dev(host);
 	struct mmc_data *data = host->mrq->data;
-	u32 *p = host->pio_ptr;
+	u32 *p;
 	int i;
 
 	if (host->sd_error) {
+		sg_miter_stop(sgm);
 		data->error = sh_mmcif_error_manage(host);
 		dev_dbg(dev, "%s(): %d\n", __func__, data->error);
 		return false;
 	}
 
-	BUG_ON(!data->sg->length);
+	if (!sg_miter_next(sgm)) {
+		sg_miter_stop(sgm);
+		return false;
+	}
+
+	p = sgm->addr;
 
 	for (i = 0; i < host->blocksize / 4; i++)
 		*p++ = sh_mmcif_readl(host->addr, MMCIF_CE_DATA);
 
-	if (!sh_mmcif_next_block(host, p))
-		return false;
+	sgm->consumed = host->blocksize;
 
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
 
@@ -703,9 +704,14 @@ static bool sh_mmcif_mread_block(struct sh_mmcif_host *host)
 static void sh_mmcif_single_write(struct sh_mmcif_host *host,
 					struct mmc_request *mrq)
 {
+	struct mmc_data *data = mrq->data;
+
 	host->blocksize = (sh_mmcif_readl(host->addr, MMCIF_CE_BLOCK_SET) &
 			   BLOCK_SIZE_MASK) + 3;
 
+	sg_miter_start(&host->sg_miter, data->sg, data->sg_len,
+		       SG_MITER_ATOMIC | SG_MITER_FROM_SG);
+
 	host->wait_for = MMCIF_WAIT_FOR_WRITE;
 
 	/* buf write enable */
@@ -714,20 +720,32 @@ static void sh_mmcif_single_write(struct sh_mmcif_host *host,
 
 static bool sh_mmcif_write_block(struct sh_mmcif_host *host)
 {
+	struct sg_mapping_iter *sgm = &host->sg_miter;
 	struct device *dev = sh_mmcif_host_to_dev(host);
 	struct mmc_data *data = host->mrq->data;
-	u32 *p = sg_virt(data->sg);
+	u32 *p;
 	int i;
 
 	if (host->sd_error) {
+		sg_miter_stop(sgm);
 		data->error = sh_mmcif_error_manage(host);
 		dev_dbg(dev, "%s(): %d\n", __func__, data->error);
 		return false;
 	}
 
+	if (!sg_miter_next(sgm)) {
+		/* This should not happen on single blocks */
+		sg_miter_stop(sgm);
+		return false;
+	}
+
+	p = sgm->addr;
+
 	for (i = 0; i < host->blocksize / 4; i++)
 		sh_mmcif_writel(host->addr, MMCIF_CE_DATA, *p++);
 
+	sg_miter_stop(&host->sg_miter);
+
 	/* buffer write end */
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MDTRANE);
 	host->wait_for = MMCIF_WAIT_FOR_WRITE_END;
@@ -746,34 +764,40 @@ static void sh_mmcif_multi_write(struct sh_mmcif_host *host,
 	host->blocksize = sh_mmcif_readl(host->addr, MMCIF_CE_BLOCK_SET) &
 		BLOCK_SIZE_MASK;
 
+	sg_miter_start(&host->sg_miter, data->sg, data->sg_len,
+		       SG_MITER_ATOMIC | SG_MITER_FROM_SG);
+
 	host->wait_for = MMCIF_WAIT_FOR_MWRITE;
-	host->sg_idx = 0;
-	host->sg_blkidx = 0;
-	host->pio_ptr = sg_virt(data->sg);
 
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
 }
 
 static bool sh_mmcif_mwrite_block(struct sh_mmcif_host *host)
 {
+	struct sg_mapping_iter *sgm = &host->sg_miter;
 	struct device *dev = sh_mmcif_host_to_dev(host);
 	struct mmc_data *data = host->mrq->data;
-	u32 *p = host->pio_ptr;
+	u32 *p;
 	int i;
 
 	if (host->sd_error) {
+		sg_miter_stop(sgm);
 		data->error = sh_mmcif_error_manage(host);
 		dev_dbg(dev, "%s(): %d\n", __func__, data->error);
 		return false;
 	}
 
-	BUG_ON(!data->sg->length);
+	if (!sg_miter_next(sgm)) {
+		sg_miter_stop(sgm);
+		return false;
+	}
+
+	p = sgm->addr;
 
 	for (i = 0; i < host->blocksize / 4; i++)
 		sh_mmcif_writel(host->addr, MMCIF_CE_DATA, *p++);
 
-	if (!sh_mmcif_next_block(host, p))
-		return false;
+	sgm->consumed = host->blocksize;
 
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
 

-- 
2.34.1


