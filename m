Return-Path: <linux-block+bounces-14410-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 215B99D2CA8
	for <lists+linux-block@lfdr.de>; Tue, 19 Nov 2024 18:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF9E1F21752
	for <lists+linux-block@lfdr.de>; Tue, 19 Nov 2024 17:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566271D27A0;
	Tue, 19 Nov 2024 17:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FvkC43Ya"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3492D1D220E
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732037409; cv=none; b=BbQQybXR68S1ivKCn5Y4XHWuc9/21gkCsjVcXmxfsmBRyOlxvXk5A73gMgW0AcTFAQR4h9803KYlI3jlzCxS+a30C0dRb46XqcGayZg55wHbuOJ5a0qv946GYf3VKA5dPhiECYFGeCgpgFDZcG/o2F2DNrjkLCQQhzq0tyim8Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732037409; c=relaxed/simple;
	bh=iJAspBGFRcgVzY4bKp3lb6zrw26/GFw5AyKc0Z0Pg6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LP93c4aTrYNf3WoVNQfk704fTF1Hn9zGPPU9Eisfwo7bzBGMprp0XYPa46YqsCFRZHk5kie0sM3kNYKSn1AbL88dh5Y7RnD62R4EQc67qDdW4gQ/i6WOxHuhk32OvhGcJqZvypI7X6qVt1EDB68K+rH8p2Rahwxu9NpkvA7Hym4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FvkC43Ya; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b147a2ff04so252544085a.3
        for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 09:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1732037406; x=1732642206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P2RZbmw8j/hv2SNzaAYY1BO4WuVS0Sj8NBeQ9Pxkopo=;
        b=FvkC43YaD8+d6wNMNRd0+xw8SRuKxj9GtQEGGF9P4KwpEodRvUMCA1HZXIoQL8VmPk
         y/A4iJxrqhwVDiMjkrWRyeqHbxv+/THdnXD9cfmcG6BF976poH2j9CJdt0H9yXd/8Rb8
         FvPe0yIRumaJnmPcKRf5m7PVS1x3I9hZCfNlTBiWmXGE5QXlMdUqxD5egVFA7vjSBIr0
         Ifu0kR7lYX8bJgRBspWaUZxC+qfs97R8LkA8AqtGzK6Q4a7rew6zcyR1Fn1No8IMZ40q
         CHs07ac33zopJjrM/fp8vmfldfQscuxNJIjOLwSuoXpWCexhcNQWuSK+GTy9X9jYUsQN
         0K4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732037406; x=1732642206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2RZbmw8j/hv2SNzaAYY1BO4WuVS0Sj8NBeQ9Pxkopo=;
        b=m4YYEv0NrvGZYMmuuS/vtokfdgS3TO3XcgJ6sm0KK/Vw35Na4VlLnnywysrevC/ME7
         4lUpPnJ03pVkC/ifGuEgQXFjETdamsN7cSRCxbVDP6/odUY7ZAq86B9SRDEO6D6pmx/S
         Erfub3CXxh7jF1pXKs6jx4W7404CPDPmTPWl8/1I1VNKYKUNm64VaPBdu74LzkO4MNVB
         xHcyclCr4gGDVu1+OBjI+ToxNYct/4kyk84MeNSnrvAUBaEaHALC/cQcb+ZxayQDKN9J
         /RfYVaRp7GV4juEBqBDlJKGW/STVW1x6Y877JEY8UMHtRm3KdXhJpV8sD7sBQHbodmKR
         OHIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOfj3/5DTpxdxyJxvbwPusH8w7zwTmUUbOyUvLEihzyJWPSS2E/BcKjLzVgCPfGJy4bpFl8+nNvNOv5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKKzJOxdO1GSZ9TdYbd+0mkC6Qt1I0jG/E1NZ+wcVNB8r4GkF5
	60phgpZnNkOa1Es+JOec26mYVHs2nv+xH8v7X75HwccdQ6O+YE+sfBqLp+5nOsg=
X-Google-Smtp-Source: AGHT+IEw2hhta4tF97+ZTqDEn97k4/qPKPWIxcDYewixCIGPDLkcCaqZGpK5GII/9x88g1PJnE+WXg==
X-Received: by 2002:a05:620a:1992:b0:7b1:4330:634f with SMTP id af79cd13be357-7b362384ee1mr2344165985a.61.1732037405973;
        Tue, 19 Nov 2024 09:30:05 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b37a866319sm113013385a.69.2024.11.19.09.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:30:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tDS3A-00000003GSP-14at;
	Tue, 19 Nov 2024 13:30:04 -0400
Date: Tue, 19 Nov 2024 13:30:04 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Will Deacon <will@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 07/17] dma-mapping: Implement link/unlink ranges API
Message-ID: <20241119173004.GA773835@ziepe.ca>
References: <cover.1731244445.git.leon@kernel.org>
 <f8c7f160c9ae97fef4ccd355f9979727552c7374.1731244445.git.leon@kernel.org>
 <20241118145929.GB27795@willie-the-truck>
 <20241118185533.GA24154@unreal>
 <20241119090507.GB28466@willie-the-truck>
 <20241119135743.GB26101@unreal>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119135743.GB26101@unreal>

On Tue, Nov 19, 2024 at 03:57:43PM +0200, Leon Romanovsky wrote:

> > > dma_iova_link/dma_iova_unlink() don't have any assumptions in addition
> > > to already existing for dma_map_sg/dma_unmap_sg(). In reality, it means
> > > that all calls to unlink will have same size as for link.
> > 
> > Ok, great. Any chance you could call that out in the documentation patch,
> > please?
> 
> Can you suggest what should I add there, as it is not specific to new
> API, but general note applicable to all __iommu_unmap() callers?

This is what I wrote:

+/**
+ * iommu_unmap() - Remove mappings from a range of IOVA
+ * @domain: Domain to manipulate
+ * @iova: IO virtual address to start
+ * @size: Length of the range starting from @iova
+ *
+ * iommu_unmap() will remove a translation created by iommu_map(). It cannot
+ * subdivide a mapping created by iommu_map(), so it should be called with IOVA
+ * ranges that match what was passed to iommu_map(). The range can aggregate
+ * contiguous iommu_map() calls so long as no individual range is split.
+ *
+ * Returns: Number of bytes of IOVA unmapped. iova + res will be the point
+ * unmapping stopped.
+ */

Jason

