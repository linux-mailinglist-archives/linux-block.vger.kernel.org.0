Return-Path: <linux-block+bounces-16420-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F394A142F7
	for <lists+linux-block@lfdr.de>; Thu, 16 Jan 2025 21:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81800161487
	for <lists+linux-block@lfdr.de>; Thu, 16 Jan 2025 20:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8A0236EA5;
	Thu, 16 Jan 2025 20:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Z1gNKkW1"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2463F22FE03
	for <linux-block@vger.kernel.org>; Thu, 16 Jan 2025 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058737; cv=none; b=hpqYgHFHUJUAVsQyO3r8m6wdtILGTsqIa2CNlpw8VQmDbJKXX4ViNT7pDlTMELGKgh0YnAOZmxDdVYHJDD5AqXhNFTe9Of+FyQc2I3wbdm8qwc5P9SigRyymSpk6++3W2QD/rBETY22xrhFtskHTSIh/ixUwmptpWr43ONS8vyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058737; c=relaxed/simple;
	bh=TW2t02hwCcCvA4dY7CqwLTCEluJxPrBR26gpeJGJ43c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XISH1JGyYll/78krmKRHxFcJ8HXuX2d3BLmBkdDrbDeslyeUPO/LiXDtY8ogGwhSrOq9HqbFwWEqytctHY7mazT5y9sKtynmAsTBhWuGfK6MTo3q/BwOe3PNp6cZOIw+T+eWYq1e2+Xa3t+9TnRxeRsWG4dA75hI93VzRq9zYnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Z1gNKkW1; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d89a727a19so24105776d6.0
        for <linux-block@vger.kernel.org>; Thu, 16 Jan 2025 12:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1737058735; x=1737663535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vjLKJevC2V7Xu5ADPJrgzXE+Cum0TiiT74cho1sXgi8=;
        b=Z1gNKkW14lxu8cW6U2PHwwOrjlbCi3tIzLd/2avcQf9Fuzn889VVOr9ybxwoUPqCuv
         UrlUDZ8tiO7rR5LLqvlFYQKbdmpXMfQ2XW0hBXvTBBMHgQAT0J45BMQfSK2jLIguAsar
         s1iLvXU2HwWnQagI5cNOnCWs4jUS0zi2csu0fYL1DffC/iEu8/cENDOofNAxmypsSlu0
         K/Uu2XHu9BlJih4R30VaZ0vHZWqixXYRbwp1mt4wg92EH/TDgMvLXFUSCKgvSJEQSDOP
         bdSWOfiRkI69IZPm0fI1wPl4+xqHyU4z127BDzbHmrE+4WX19o3G+2Q6xszzjQ5/WiAR
         4pLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737058735; x=1737663535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjLKJevC2V7Xu5ADPJrgzXE+Cum0TiiT74cho1sXgi8=;
        b=WV7lRn+irGLX/HqjqmnZ2LVVm0qh4YYU0r/Ve3t2mzJnk+NmlifCXWtr8xnm4VrYhW
         nnlvl/wzM7b6S/AUCEfx6ymQtGEjB1fBG+w5Dk8S0ves0vwj6dzvxWWXSEIsLncWNZXI
         Jyk5ikdavzrivx8NyLY5tQFqLX8qhbZ7x8c65359pOi3Er6/8wmME2915WHhP26Gg/HH
         WazVlgmo6lSeYRYuJPKZZkwpgUjVlZPLNRc4JZriqoTH8SPQM41pgbS9douYdidX6ENg
         /2me7/v2cdEb3roD56Gc4fwRddLqCin8oQKiSWKDwsf8XijQXphXAVQiiF/WUgPzFqm8
         IrmA==
X-Forwarded-Encrypted: i=1; AJvYcCWnV3WT2zpHdbFv1CP3vGRStanQ274bASYWceLMK17kHbQ5e4SuSq1m0aGgPM1Cark7krJa9e9vhHwNCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxM2xGKhCUKbppt/2IOD/3DjH1CckVFWDS8XaVhyvXP29DPCG76
	J+GDRt0JmAqK8LfatU8IN/y2fd2BbVfTISTKlXa4oFG9f0aZbjGczlUbACcDIxA=
X-Gm-Gg: ASbGncsWUSJ0U+m/1mL9utAYiftiyROo86IUs893KoH7hyFCmL4o6sAlcE6BLewZrfq
	D9uu/CEC7Z9wxRY113wWbWab8f+repMe5souNdJVZpRw36bCmpRwiQjJBoLqlyIj5EX/tZlYNpd
	J1D3//D9a7RGkBQh5zkgp1TuLStVoK9UQNgWObr0gh6Tjh1iB0kmVjvY8nRJVVw5fnL6uKRwPYT
	kZndZEPPOg3GDQ14zfWZet5rHpCb+/TL68JMZjTB8VNdw4UbA585DfBBo7OJZk40FpKZHJTT++l
	MuBy2mk1BzOrGSqndK2sUpi9DUB6hg==
X-Google-Smtp-Source: AGHT+IGiuhJCb6CE3xcrJekt3qGHV8KtpIud5ATr1ePaT30zfzK6ww+BnPBnVPMzNC6cTFY+JSWjmQ==
X-Received: by 2002:a05:6214:20a2:b0:6e1:715f:cdf5 with SMTP id 6a1803df08f44-6e192ca312amr104688286d6.15.1737058735081;
        Thu, 16 Jan 2025 12:18:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afce4695sm3441426d6.104.2025.01.16.12.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 12:18:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tYWKL-00000002y1X-3wBD;
	Thu, 16 Jan 2025 16:18:53 -0400
Date: Thu, 16 Jan 2025 16:18:53 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
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
Subject: Re: [PATCH v5 07/17] dma-mapping: Implement link/unlink ranges API
Message-ID: <20250116201853.GE674319@ziepe.ca>
References: <cover.1734436840.git.leon@kernel.org>
 <fa43307222f263e65ae0a84c303150def15e2c77.1734436840.git.leon@kernel.org>
 <ad2312e0-10d5-467a-be5e-75e80805b311@arm.com>
 <20250115083340.GL3146852@unreal>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115083340.GL3146852@unreal>

On Wed, Jan 15, 2025 at 10:33:40AM +0200, Leon Romanovsky wrote:
> > > +	do {
> > > +		phys_addr_t phys;
> > > +		size_t len;
> > > +
> > > +		phys = iommu_iova_to_phys(domain, addr);
> > > +		if (WARN_ON(!phys))
> > > +			continue;
> > 
> > Infinite WARN_ON loop, nice.
> 
> No problem, will change it to WARN_ON_ONCE.

I think the other point is that the addr doesn't increase, so this
loop will lock up.

Possibly just do return? I suppose something is hopelessly corrupted
if we ever hit this..

Jason

