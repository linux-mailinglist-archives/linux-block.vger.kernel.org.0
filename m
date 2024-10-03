Return-Path: <linux-block+bounces-12145-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D23798F98C
	for <lists+linux-block@lfdr.de>; Fri,  4 Oct 2024 00:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 433C81F2370E
	for <lists+linux-block@lfdr.de>; Thu,  3 Oct 2024 22:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0BF1C7B79;
	Thu,  3 Oct 2024 22:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q+daZcbs"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90811C6892
	for <linux-block@vger.kernel.org>; Thu,  3 Oct 2024 22:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727993193; cv=none; b=V8zO68msIauC8gmKBGboIeudM79JA1NVIlFVj9uPx8y1zeVn1D9xYJPbK40na5ZlIC+4E7UXI4xFzIl8ZBQMe4nREJbY2shfpo3Z1NkZ6/RD0DGaFoeNq+lEe8d/BFyCNVp3jacMROeAb3H+sBxaDyeV9tNPplJ5GF2yW5vQ3sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727993193; c=relaxed/simple;
	bh=Pt1ZUSvFX87DVRXIwapbBHcWsvds+a/vkDyvcPIZRsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SlXke6gjLR1rKxmMqdeRd4MxlUXNIT/gPeXXjyDsHFElWeppGrrS7RA55TCz8nyhJh/t2EJHc9QlFvKAJaRepGqY3S2SFyraNrpimFrIxeZFKoJ+A4LOiORHfdKkpwVsqy1yZeAN5Jjk59D9KbIvQZpA0G0bweGjFNQNAY/bXow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Q+daZcbs; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b7463dd89so16382955ad.2
        for <linux-block@vger.kernel.org>; Thu, 03 Oct 2024 15:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727993191; x=1728597991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/n+Bm+NK1yV3ykOPuXSmp/mRwlagEN1LGfqlR+znwqI=;
        b=Q+daZcbsvqsmbadFRLjG6dF6/7BzcWDMhyc6RnMUaHPCpAHcHQGgRhc9T6r2rMWLSx
         LSNGnYG1NrqN3AF0dAliwj0inSSv5yKaQRNDGKDj2vi992rHyxwYNFQ1lj8USvUOjdvt
         SiuvSeLwZhzX2DmypLgunZM1R9Pt/YmL8nat1LDLlqLpSqeFsOHHV1ZhZWyg7oQqIq5o
         56DQxD1daUlwTxnvWhuM9sSo8wRp85Nh5CneOgJ5pDa97xhR2y1xganV+DdpjNUNDX97
         oLmFDb2duAqtkB5fJ/9h7H/SIx5t88rViVTpmdt8YKYzwk5ZgTIG4gYxk6IfTeqXsYaf
         2wsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727993191; x=1728597991;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/n+Bm+NK1yV3ykOPuXSmp/mRwlagEN1LGfqlR+znwqI=;
        b=dPpddEPopR2Gd5b1EvmhDR4jPlJ/PeWfDQr5yHLxqdi4nptxaIV2vzQi7dXTEIz2Tf
         CkutgCuKizsf6bu0FQm9ASmdSxlHRY7MKVVUfx+cyc6ccIrHcewj38lity2buqnJfoa6
         yN6tS90M85s91j8ZEwEt48uia6SkdMlSET9rWwVYAcjy7meXw4wzO64w6KIi4RbWRmu3
         xvNwRhsW4yMfHgahxU0gRZpmHHFF8bzaEOLutZWkU9fSZt3S5IUuZpFTFHifec+TZvhb
         oLB3CvgHqcpbeDdoNQFB2mttIECJxLNNnV3Cwpnu3b94EhzHyiDOgtxIuQw2q55bPDiz
         1UUg==
X-Forwarded-Encrypted: i=1; AJvYcCWAr+6FI7fc9G6FgTIY5VAMDXnrhuuqM8SPaR234zFujOjvANLrCwNb5a+hmJ2/RMzJXJEaOVFzAxzkUA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9BGda2iYoTNh2L99mCVxcAhxkj07EtaceaQ+Jt2vuLm++lv4s
	CmO3fEF5I2iWLo70wVSgJTQrf9RpZ1Cv+UuFRZlDf+7beX+Hbc6vdRwOoDb/r7s=
X-Google-Smtp-Source: AGHT+IG3Z3RoW+4gVwOQPtL97jDrvwXJXpPy+ySiF1kDHRm4DfIx6MZYfO3x19vUvzG8fbDYEx7ERQ==
X-Received: by 2002:a17:902:f64c:b0:20b:982e:73f5 with SMTP id d9443c01a7336-20bfdf6b4d7mr8219805ad.3.1727993190942;
        Thu, 03 Oct 2024 15:06:30 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beeca2235sm13554225ad.105.2024.10.03.15.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 15:06:30 -0700 (PDT)
Message-ID: <d5b34514-aa3a-47dc-9521-d2774c1785a2@kernel.dk>
Date: Thu, 3 Oct 2024 16:06:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blk_iocost: remove some duplicate irq disable/enables
To: Tejun Heo <tj@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Waiman Long
 <longman@redhat.com>, Yu Kuai <yukuai3@huawei.com>,
 Josef Bacik <josef@toxicpanda.com>, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <Zv0kudA9xyGdaA4g@stanley.mountain>
 <0a8fe25b-9b72-496d-b1fc-e8f773151e0a@redhat.com>
 <925f3337-cf9b-4dc1-87ea-f1e63168fbc4@stanley.mountain>
 <df1cc7cb-bac6-4ec2-b148-0260654cc59a@redhat.com>
 <3083c357-9684-45d3-a9c7-2cd2912275a1@stanley.mountain>
 <fe7ce685-f7e3-4963-a0d3-b992354ea1d8@kernel.dk>
 <68f3e5f8-895e-416b-88cf-284a263bd954@stanley.mountain>
 <c26e5b36-d369-4353-a5a8-9c9b381ce239@kernel.dk>
 <Zv8LAaeuJQkvscWF@slm.duckdns.org> <Zv8NBM4mOVoMoBQS@slm.duckdns.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zv8NBM4mOVoMoBQS@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/24 3:30 PM, Tejun Heo wrote:
> On Thu, Oct 03, 2024 at 11:22:09AM -1000, Tejun Heo wrote:
>> Yeah, that should be spin_lock_irq() for consistency but at the same time it
>> doesn't look like anything is actually grabbing that lock (or blkcg->lock
>> nesting outside of it) from an IRQ context, so no actual deadlock scenario
>> exists and lockdep doesn't trigger.
> 
> Oh, wait, it's not that. blkg_conf_prep() implies queue_lock, so the IRQ is
> disabled around it and adding _irq will trigger lockdep.

Ah makes sense, didn't realize it was nested under the queue lock. Then it
does look like it's just that one spot.

-- 
Jens Axboe


