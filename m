Return-Path: <linux-block+bounces-13379-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B30D9B816D
	for <lists+linux-block@lfdr.de>; Thu, 31 Oct 2024 18:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD418B20C38
	for <lists+linux-block@lfdr.de>; Thu, 31 Oct 2024 17:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB601C1AC9;
	Thu, 31 Oct 2024 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="txQX41zQ"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5516E12D1EA
	for <linux-block@vger.kernel.org>; Thu, 31 Oct 2024 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730396533; cv=none; b=NT4tRQ9S+oqh3cI+YP2z2VgjnLnB7SA+66UvHyMW/l568g+SlAwf65/fVkCo1trO3IQMxT7QYrpPEmYJ/tkHvEenyxwVKUiVFQv/9rYlfki5Vu0rb1/89Ukrq9X/8IWFkcvtHkqrVGfNe/wskHu8oslUMIxvhbqL+U5hXaBX994=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730396533; c=relaxed/simple;
	bh=Rf6mnPpy9l06l6dtMxbRoYeknemanNGyXKBqhdu+XDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axr+7N7AEJJYGz03Gm///6hWs6nxB6e7KH2I4ogvIH/2AZgX7GEFPp6NhS4uXpZT49Ton+Q6r0y45ZAfj+0Mf/q3Lqb3AwMT8TiKOrV1s59w/96pGkKXruPzcCNWlnER9+rlpjLjRZxF9N9xOIIkOIS1p4V41wAsjaqfh3HlAMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=txQX41zQ; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-83a9cd37a11so44978039f.3
        for <linux-block@vger.kernel.org>; Thu, 31 Oct 2024 10:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730396530; x=1731001330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x40+SjEaq5943TtiP/UXom9Wy7SciOs8xRpZ9sdjGNw=;
        b=txQX41zQgMYFvp8EGoQK9Ckb1lRZIDT0QGY+GktWrrYaCVhOREhzDL4Hbh87LiexHY
         0Wk/OY2SFmuGxtJB8Am2ukTVipM9VX4jfHp23oXDjKtIfQMe5V5mfZpkt9XqqYcuuYjn
         i4vcJUHNuQbHxPf5JQvW0XtBTimyE4Gpe4xbe6ksoMKJb9py91Gqdfoolng1OmA+qEBo
         d/SlzYamivnRYj/xWiMJAJcab0Gb0ZszImZZqMG5nGiMVnidiYFS8+H8hfBuqSFltyq2
         6hgCjOJvyRlT8/iENBRpRDKrRE/uR4LqSXZl2QZxqJrj/HUPY3BVGph5nLYEBWDSGLM4
         xKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730396530; x=1731001330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x40+SjEaq5943TtiP/UXom9Wy7SciOs8xRpZ9sdjGNw=;
        b=IgVgZvWZ7fMf6IFvhgoFw5nFKqEBH4RwOgcPslAzGCHpnVAdlUx6pUZvFuSLj04leA
         0d1fEcHTVM7ExraLf7IO6IBSeVv3morngFYQPgAS21LBGzdb3x//tjcoq1cby2mmxgGB
         iqv3urerAUint52g6MIyCu8UTXq7TqalZiVlMVi3B+fRlp6AyN1MycHWGscvGJhuPycX
         O2dGcq6ltN8mO2L06WIy9wgwGtLwRxXuNLxLoxKePWwbCCtwyyLe1AD0MpXy+J0AmgxD
         2CZNRkmBUhZhbGs52OSJeqqBNsWS2Etmk4h2n0xSDY3cKcISL352p3NyT1ULzw43lsHX
         MeBA==
X-Forwarded-Encrypted: i=1; AJvYcCXluelaGMu3rM2sbyN9IWQwTQYvv8CzAN6s5BkRxP5kpx8rBjlh+LCk/YUP5KIet3LNXLxH3dXQrxPqgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxujV1u1W2t/dF3g0nFxi3fcv+gs4GlERExsCwuQ03/KFJvyOWD
	XfFDHsf1cr/7tiuhUXbx+okvkZDD6kb8RMy9xtbRT7qWxOeUo2Rx5oiS8wHmY6A=
X-Google-Smtp-Source: AGHT+IG0ksmejkYn/tsWOFj5UDq65mB5fTjw0uagwhlJwyCNesDEnrmSpfLQj8+GbqVblFhVpBgdOw==
X-Received: by 2002:a05:6602:15d4:b0:83a:c242:82aa with SMTP id ca18e2360f4ac-83b1c5cd123mr2127656539f.13.1730396530549;
        Thu, 31 Oct 2024 10:42:10 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83b67b4b157sm40604339f.22.2024.10.31.10.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 10:42:09 -0700 (PDT)
Message-ID: <2a0fc88a-53af-4d7e-b8fd-8cee3f0804a1@kernel.dk>
Date: Thu, 31 Oct 2024 11:42:07 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <cover.1730298502.git.leon@kernel.org>
 <3144b6e7-5c80-46d2-8ddc-a71af3c23072@kernel.dk>
 <20241031083450.GA30625@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241031083450.GA30625@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/24 2:34 AM, Christoph Hellwig wrote:
> On Wed, Oct 30, 2024 at 07:44:13PM -0600, Jens Axboe wrote:
>> On Christoph's request, I tested this series last week and saw some
>> pretty significant performance regressions on my box. I don't know what
>> the status is in terms of that, just want to make sure something like
>> this doesn't get merged until that is both fully understood and sorted
>> out.
> 
> Working on it, but I have way too many things going on at once.  Note
> that the weird thing about your setup was that we apparently dropped into
> the slow path, which still puzzles me.  But I should probably also look
> into making that path a little less slow.

That's fine, just wanted to ensure that no push was being done on this
before that was resolved.

-- 
Jens Axboe

