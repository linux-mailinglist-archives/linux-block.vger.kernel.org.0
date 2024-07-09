Return-Path: <linux-block+bounces-9908-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6A892C3A2
	for <lists+linux-block@lfdr.de>; Tue,  9 Jul 2024 21:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E11283A21
	for <lists+linux-block@lfdr.de>; Tue,  9 Jul 2024 19:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D49185602;
	Tue,  9 Jul 2024 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nbPJR1pi"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025E81836DC
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720551805; cv=none; b=Y0lQMnlB7DnvrCG8TNNKkiIgPNWbKekaQ7RuPP3fKHeuzAS9SlZxRU3ZhhIFrZ2LeFZNwUHuXcFTuIbjXNVxHGKm30j6C2MGNz5FbQKAGBhuMg8+m6pM8fqzBnLrx8K+3AJNveItUk5R2Dq2RiK8oL5WQC1hPIaea9qctFPBLaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720551805; c=relaxed/simple;
	bh=sMyzaJ+W703AH//DDEwdvJyCCtm/s3ttll6zL+v1YV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFgZsJ470l8w9e+c5VK6/PF9nbvtqr7izQ4bGjm04zLh3sU/iBSgO5yohCqW3ov1mzz5GG0aU7a/+SVemGj8itVf44uJpw43IgM2eYL4q8kpyQ0VbyVR8R/XV6Fa3AYPeYdQjVDxMEqBXHGfjy0bRZbzbR8NjGcxGbZaSNIF2pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nbPJR1pi; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b5f2ac0fb9so24421966d6.2
        for <linux-block@vger.kernel.org>; Tue, 09 Jul 2024 12:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720551803; x=1721156603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0eX7Wo0KTUJfWUHtxoHH+B23ObEinslGP6IJ1acrkRc=;
        b=nbPJR1piOHWb7FIpilvYBLblbTE+7tpBZ90HzWrx2FMBne7q6hIDPrTrxFWa+UJxtZ
         b5FFRpW4Te9SYc6xWn556udMsYqGutRxzSYR+XJuRsrgPiegPcMAbYv0a30c8dx43E/q
         UcZHd9kVNYJGcLiVuWXLF9H3blFXgnAZwFEmg5UOXl3Z6gt5V1Fy4fDHLo/SejqN/kV1
         uqaJf7SBWTj/J0TrZNmZlO9OlA5CZ7C/UeWL7iCZd0T2MdMrcqzPhCdUx5L7gMNEMa2H
         dMD9ksL/XxscJeyC571fTvlLmLESo+KShU5zpHyra0BhCygdvoEflPqHeefx6fXLSt/H
         GW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720551803; x=1721156603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eX7Wo0KTUJfWUHtxoHH+B23ObEinslGP6IJ1acrkRc=;
        b=Q6KSv4xVvHZQSVFfdJWmK2bpI8e3m6UIBZFfe1dkyLi7mbqaKU9x/4JBxLRlRqWadn
         uZ70qAaAOoBFA+tk3XxyPcSYowjyNy2OJgvRbdAR8Focqzj2AH1F7J5PSdlN5a4ANFT0
         LfB+oGouIER2UXkHwfZrHfg2FRJ7/2LvLVc/gRpKpZlOeffbhhdgMDiqXiLQJoM0DWV0
         ODAcBAE8hGOkngS2+GYQQ9jB9er72Ny3533tln4lM6z956eZPrYis3fTTExxPFmNqbKT
         aGnG0y8ExZPGQEvJX0ek5bl/md1SButunnCO+7UwYju3DFRxZ+ki3+fg7DbHMUUOEeER
         bS8w==
X-Forwarded-Encrypted: i=1; AJvYcCUQm+7O3JXdWApCpkhfU4wF1BmjEZ6DnGn2U/+LOfg8tng8KwjWwE7CMdOiPIjx6FpKgLe9f7U97bMCWxHGxS02GEfMwm8faMeuYvQ=
X-Gm-Message-State: AOJu0YyeJOuObOe7d66RlWI8amDG9za9AVfFX9b0bQEfx4oDhojSbAbX
	Kd99pBW5C9qedjeNjrCvg61H5VqPbqHcLZ+RJeTPGVZGex0gYFLtFXkNlCxj3g8=
X-Google-Smtp-Source: AGHT+IE9wk6d6lAYU4tvyeORxb5NkdX/FMtkoFI0Rc5O+LsyZzi6JOQvD31sQUESKmTir4qJcqoy3Q==
X-Received: by 2002:a05:6214:250d:b0:6b4:4470:81a5 with SMTP id 6a1803df08f44-6b61bc7f74bmr43617486d6.2.1720551802811;
        Tue, 09 Jul 2024 12:03:22 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61b9c4a1fsm11278546d6.12.2024.07.09.12.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 12:03:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sRG7U-002tXL-BB;
	Tue, 09 Jul 2024 16:03:20 -0300
Date: Tue, 9 Jul 2024 16:03:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Keith Busch <kbusch@kernel.org>,
	"Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/18] Provide a new two step DMA API mapping API
Message-ID: <20240709190320.GN14050@ziepe.ca>
References: <cover.1719909395.git.leon@kernel.org>
 <20240705063910.GA12337@lst.de>
 <20240708235721.GF14050@ziepe.ca>
 <20240709062015.GB16180@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709062015.GB16180@lst.de>

On Tue, Jul 09, 2024 at 08:20:15AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 08, 2024 at 08:57:21PM -0300, Jason Gunthorpe wrote:
> > I understand the block stack already does this using P2P and !P2P, but
> > that isn't quite enough here as we want to split principally based on
> > IOMMU or !IOMMU.
> 
> Except for the powerpc bypass IOMMU or not is a global decision,
> and the bypass is per I/O.  So I'm not sure what else you want there?

For P2P we know if the DMA will go through the IOMMU or not based on
the PCIe fabric path between the initiator (the one doing the DMA) and
the target (the one providing the MMIO memory).

Depending on PCIe topology and ACS flags this path may use the IOMMU
or may skip the IOMMU.

To put it in code, the 'enum pci_p2pdma_map_type' can only be
determined once we know the initator and target struct device.

PCI_P2PDMA_MAP_BUS_ADDR means we don't use the iommu.

PCI_P2PDMA_MAP_THRU_HOST_BRIDGE means we do.

With this API it is important that a single request always has the
same PCI_P2PDMA_MAP_* outcome, and the simplest way to do that is to
split requests if the MMIO memory changes target struct devices.

Jason

