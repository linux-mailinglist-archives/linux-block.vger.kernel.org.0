Return-Path: <linux-block+bounces-2399-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EDC83C4EA
	for <lists+linux-block@lfdr.de>; Thu, 25 Jan 2024 15:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C47028E654
	for <lists+linux-block@lfdr.de>; Thu, 25 Jan 2024 14:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F76B6EB69;
	Thu, 25 Jan 2024 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FgviSqIx"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A226EB4E
	for <linux-block@vger.kernel.org>; Thu, 25 Jan 2024 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193437; cv=none; b=NpBw1m4vRe0mkFGgC+5IHdUqbD1F7/ZJ33teyfq90oc/bUAcMQH6cxvOxVbFIYlT4u5O0PbScycUDdJU2mcBsFau1lWWeZTyMZGjWnMrwXdNxFEnPERl6QGHHIZgkCwRcDk5PaqpeXibgTJP4vlZi3CWOv0AJ0tHPRRwVsP08Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193437; c=relaxed/simple;
	bh=Qs//UMnixr5IUp6jilmOnSE7i7QVfxi3SrizSBiLzF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sTqJHRogkHesknbSIlgvahyX1/wMTzDY0TbysVvTMtYhJ6PPtIENGnlO1UIjQDbobxBBZl6OhewtUvpjbLh43ujpWitp6uZ5Z+I9wKL4mNylwY+qpXLBYW81FkOnCXQcUiqCM66rXYOZ7KIxmjyCT01pDpRKHMAOkNYUbAxj+P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FgviSqIx; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cf338e1438so8396031fa.0
        for <linux-block@vger.kernel.org>; Thu, 25 Jan 2024 06:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706193432; x=1706798232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJBLYCKXFwySdbkU5jNVGgegDvui0xTSvQmfM70ZSEk=;
        b=FgviSqIxltqJDnUcgyL4fGiH6UPmwn1BrCqJpvncZd5lLNvubQcrzIjzJLoIsODfol
         /bqK9UYHLbRJyzJnMiP0kBtRnXvOEvLBvjhxkO48nqp4yWkznbUDwVdq4iRLwDikOO2O
         eSxO5zrRWd68rPJ3CfYiYX1Q8QHn6KY2Q/bE6sKLEBQOyxh5fFQ4/lO+nYN7mj+Hl5kp
         9eTwYvlgUJXEZEZGlLpB0RpJZ32AHBBN2kCYNzOvu4KBM5MoyjK8kq5EXpF0zjfFq2MT
         CZiyiFDPJk5pNCvUz6fkcJ0w+kS50ZpsM64xiFMCQejir7GVUsu74L62LWpu5awoamcu
         JfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706193432; x=1706798232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJBLYCKXFwySdbkU5jNVGgegDvui0xTSvQmfM70ZSEk=;
        b=XCTbYXjlqi3EUODDoTA1+qdmh5fHdhkW/uPGbAR65avrRqBlsoXHHuFiH3owcUoEmh
         w+eru/86peNrUQkv80qgiGibWU9phD0ivqEW7Id54ojuOTu106i93qaNaPZvVq3BOrZa
         mKt+9lkWu1N8G8h4M0FQ/+lXdWtrT7tokxyt+wO1VNmAfBOO+fS+6KHivyhkPxFMF5H9
         k+8FnUw8giG68aaOKnfHsPWTKXcFbTI5CUm9TL7LnZdZv/EqXFMcr8eesfbgkk0T6x9w
         hjhJGc9sJVE6Z536amFmrRP2WnExyGrfRkSwEn9j7QfxC8zhi7sVbSPbUZC3nnpqgCuN
         kgQw==
X-Gm-Message-State: AOJu0YxmS8YVl6rNcHmuxjRvlaHhsrzqKoJepyn2sJCqDED7ruHajPcK
	QUEX2s3BwH2Q1+hyvayLEY4jRdXdAuvbR4fsLvyV1WSw1fq+GeokpUsu27QU9hAhKthrbJ4R/8m
	1
X-Google-Smtp-Source: AGHT+IHyoh6DqOZQxyE2KVxGS/rWXgxchalYubf3yeda14PSRbE8B6cvrgMcdIMq6MgeVioRNGja3Q==
X-Received: by 2002:a2e:90cb:0:b0:2cf:329c:31d3 with SMTP id o11-20020a2e90cb000000b002cf329c31d3mr596119ljg.25.1706193432776;
        Thu, 25 Jan 2024 06:37:12 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id y24-20020a2e3218000000b002ce098d3f0asm292644ljy.115.2024.01.25.06.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:37:12 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 25 Jan 2024 15:37:10 +0100
Subject: [PATCH 6/7] mmc: sdhci-esdhc-mcf: Map the virtual page for
 swapping
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-mmc-proper-kmap-v1-6-ba953c1ac3f9@linaro.org>
References: <20240125-mmc-proper-kmap-v1-0-ba953c1ac3f9@linaro.org>
In-Reply-To: <20240125-mmc-proper-kmap-v1-0-ba953c1ac3f9@linaro.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
 Ming Lei <ming.lei@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Pitre <nico@fluxnic.net>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Angelo Dureghello <angelo.dureghello@timesys.com>
Cc: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

Use kmap_local_page() instead of sg_virt() to obtain a page
from the scatterlist: sg_virt() will not perform bounce
buffering if the page happens to be located in high memory,
which the driver may or may not be using.

Suggested-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/linux-mmc/20240122073423.GA25859@lst.de/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-mcf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
index a07f8333cd6b..ed851afbf9bc 100644
--- a/drivers/mmc/host/sdhci-esdhc-mcf.c
+++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
@@ -314,8 +314,9 @@ static void esdhc_mcf_request_done(struct sdhci_host *host,
 	 * transfer endiannes. A swap after the transfer is needed.
 	 */
 	for_each_sg(mrq->data->sg, sg, mrq->data->sg_len, i) {
-		buffer = (u32 *)sg_virt(sg);
+		buffer = kmap_local_page(sg_page(sg));
 		esdhc_mcf_buffer_swap32(buffer, sg->length);
+		kunmap_local(buffer);
 	}
 
 exit_done:

-- 
2.34.1


