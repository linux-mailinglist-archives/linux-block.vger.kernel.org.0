Return-Path: <linux-block+bounces-1235-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9EA8177DC
	for <lists+linux-block@lfdr.de>; Mon, 18 Dec 2023 17:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5822855F2
	for <lists+linux-block@lfdr.de>; Mon, 18 Dec 2023 16:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E214FF98;
	Mon, 18 Dec 2023 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Tr2TC4ow"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEB24FF73
	for <linux-block@vger.kernel.org>; Mon, 18 Dec 2023 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7b7cea31f44so16462439f.1
        for <linux-block@vger.kernel.org>; Mon, 18 Dec 2023 08:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702918032; x=1703522832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQV89OI2j87J0XQ/EQ5OFjFiNtSdGj1SfCj762cvhDI=;
        b=Tr2TC4owTtuXTXzTfNfKip4sPkOP9Iror7z+euOBESmKvf3GkNv5T00k+1nbLVEAUJ
         khXfvSDXFvT1qpRrqwQmJjTM2swigXxglPrFBzoz6UmDrtrsw/XFgZY7szCEfmfVbSIT
         PcnnbdunCG3SrX2YfDsNdQmgW9iJsZTLDxqTCApDuP+USKiKDw6X5wEBG1x/3IBlNEay
         KF5ZaWTI0y7YLn+grwA5ESE+A+KAAeW2gnXE2djoJEP+VyB0bNJbJuDvCW2FhZlFfef1
         ybikR2M86KmIxDZNVzjHyRtFA3p0FEBn6dCcfaNDfxkpc6ZfcLtbjAisjvkOkqNG+k9H
         fZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702918032; x=1703522832;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQV89OI2j87J0XQ/EQ5OFjFiNtSdGj1SfCj762cvhDI=;
        b=HGqiAyl04Ypf1k/z2NmXANXXudfi+JZWPpnCRACEGQJ0CbIgbaShn8V8iZQsblKF28
         9EtIDoYb7Ew1wIHYg19+SpaOLE16jVTKXw94P9BHrageJtD1vzCEYJOAPMiiBbKdbyjc
         JZWZFP4HDS4l2aMRtlEJ5WwQn57wlrzqp4TksFXYnC4xW6+F4Blt5Is7MtCNbSwgRLWm
         vwcCj4g2nqBXHIoHxEtmuYLpWAq32HPS7VWH4U8hwvdk/7bguCP3cucijZsghvaUYvxs
         Z+DOxfA42BH5Md8EIz2UkO+IMtIvtMxXmiO2p/TSisw5sRPr5P/RoGeRde0cVxXXELQb
         gB8Q==
X-Gm-Message-State: AOJu0YyKiL80Ra0SGDMJGpRbZnuyl+sQEn6aOpFvgl3ww3nbq2Vr/rb9
	YDU7IymW1vw/jGuEQ61gPW+ynQ==
X-Google-Smtp-Source: AGHT+IGLdFcisOp3Bs7v3ydXrQmU2RB0nTwusJTyWr15QXuuwRwQAOTsVw0F/sRO9l1qTshexAg3QA==
X-Received: by 2002:a05:6602:b90:b0:7b6:fe97:5242 with SMTP id fm16-20020a0566020b9000b007b6fe975242mr30966158iob.0.1702918032201;
        Mon, 18 Dec 2023 08:47:12 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b17-20020a6be711000000b007b3e44dc200sm6052653ioh.42.2023.12.18.08.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 08:47:11 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, kbusch@kernel.org, hch@lst.de, 
 Kanchan Joshi <joshi.k@samsung.com>
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org, 
 Kundan Kumar <kundan.kumar@samsung.com>
In-Reply-To: <20231218152722.1768-1-joshi.k@samsung.com>
References: <CGME20231218153411epcas5p15bfb9e24856b5d719501c375e2bf3897@epcas5p1.samsung.com>
 <20231218152722.1768-1-joshi.k@samsung.com>
Subject: Re: [PATCH] block: skip cgroups for passthrough io
Message-Id: <170291803143.230536.5579208045132253550.b4-ty@kernel.dk>
Date: Mon, 18 Dec 2023 09:47:11 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Mon, 18 Dec 2023 20:57:22 +0530, Kanchan Joshi wrote:
> Even if BLK_CGROUP is enabled, it does not work for passthrough io.
> So skip setting up blkg for passthrough bio.
> 
> Reduced processing gives ~5% hike in peak-performance workload.
> 
> 

Applied, thanks!

[1/1] block: skip cgroups for passthrough io
      commit: 6c9b97085c473e380e57cf33c95d2c74444b2a5d

Best regards,
-- 
Jens Axboe




