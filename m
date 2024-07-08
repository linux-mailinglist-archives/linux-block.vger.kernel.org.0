Return-Path: <linux-block+bounces-9851-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 580E092A7A0
	for <lists+linux-block@lfdr.de>; Mon,  8 Jul 2024 18:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3341F2161E
	for <lists+linux-block@lfdr.de>; Mon,  8 Jul 2024 16:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1281F146586;
	Mon,  8 Jul 2024 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="P+TUbkpO"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64067147C7F
	for <linux-block@vger.kernel.org>; Mon,  8 Jul 2024 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720457562; cv=none; b=p/4vu8/iVV6Ql3zt5zZxFEHgknw8Dls5FTlJx6VAhah0x4OOdW00h0ytz3Ld2uHaeKkavnz7dUvrGJbp7wS/90sTTxY+oh5QkVXkR49xEMhjCchnvk1wczd7GYrVqGevpp/V9TNqGXrvSATLhFni709b9RGphjs+jd6PzEeSurQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720457562; c=relaxed/simple;
	bh=1B5tJgkSM04kGIIt7Bd4CwyiBDyOxIVq095mpakxwCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9M1G4J4tWDPpVc+cvbRLLG8GjOKEjrvEDyczIIfkV+eEuVcXK+UmWTznHxoOiEZdUoTNHlW0hyp0PD84IQESZ7QqeMPSVgRDETIAX4eJJkhORiWMNHmPH3ad/7FcTtJbjDrUeTa5aaNFKacI3kzi2p7ETOg09bIQuPOkBfeWiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=P+TUbkpO; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-444fdb6c1cfso27632581cf.3
        for <linux-block@vger.kernel.org>; Mon, 08 Jul 2024 09:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720457559; x=1721062359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=44iLSgmAA8Jj5OzeQp5q3uGTMuRJb4ek81IJRNbfP50=;
        b=P+TUbkpOGqpFLTWb4t5NSUvguJ5/6rVKfyrEcU8M/gVD35r280+g1ipvBHqy4Ujl89
         4BSnWWR1YvaygNAqn4Ow6KuQclsaKNZLcCNhj3cCkaDjZtDd+UmOiH4NWHVUH+68msas
         M1GFdT4yQHwcmbdKWavJjZJNCX5zEFCR9jqzxxoNB7ibBJqOQn8nhJRqWfq3XCjOQMPa
         2esubhBzgBcBXIUSdSvYYkXotdxLTl37i654frtw9D1Y6CsM1HQLdgLWFZi9zwgIKx14
         kfqe8LNIY3cwxvPKoDhXEHc9ekKXEy+9xugONCBQ+fbE0zdKmpvXn7PxxvQgEtxCmgjV
         bzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720457559; x=1721062359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44iLSgmAA8Jj5OzeQp5q3uGTMuRJb4ek81IJRNbfP50=;
        b=l8Oym5h8We/VcUwmltan2rL+0ZTpFug0Rwbdjhr4Dyj5NIKT2BXDh8LKF1AcMTfNev
         Z7u4KqBuWkFrjf9y7VKZr1FyLq/ixVrEZoxt02Gsrasl+vdjFpmNQCOmpAkrNlBanzYc
         uMOlxX5pZN5xuntQ9KCg9Wpx/4g888hpmo7CS//RskVUzFvAuRAvJ6QemKoWZ0q3IsTI
         AQ7k6qF2rGR5HtIPrSAqLEzbSpJHZhc53k0Fn7lmQTHakSGP1roWPLSRF1xnqTobgvNv
         YSmIo4lzVFvIfa29OPfeYeM1aEY55HAx0JJJQaRE/1JFBbstpgz2LDKDqUe6kAQ5s96M
         Rw0g==
X-Forwarded-Encrypted: i=1; AJvYcCWmvnonRExOcfzjUzXgaWcwnWqu9nmRWACmHQraXW/c3yddKMP0h7aRWaL8v4IIFznztepGhu/ELKkLgCqbIlpNhKr4BZrijXicKK0=
X-Gm-Message-State: AOJu0YxiXXQNCgparVSD78vQmVhqgadfv9iAMkgMQN1PZbA4V5LbKfOL
	27RHqufVP5p0MKvaXc5cXxKCiimLiCiEVHJxlrk7VOdJwbo8PKuiL/OfoNqR9jk=
X-Google-Smtp-Source: AGHT+IHmTDKEE4X7UqSrEePQ2yW2AFHAIlc2Xn5bxdXHYF1pSNmcIuJQ4brop8xp0q/dd20hJkGD6Q==
X-Received: by 2002:ac8:58c6:0:b0:447:e532:b370 with SMTP id d75a77b69052e-447fa8aefa5mr156831cf.10.1720457559408;
        Mon, 08 Jul 2024 09:52:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b40389sm1202611cf.36.2024.07.08.09.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 09:52:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sQrbS-000Uky-FO;
	Mon, 08 Jul 2024 13:52:38 -0300
Date: Mon, 8 Jul 2024 13:52:38 -0300
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
Message-ID: <20240708165238.GE14050@ziepe.ca>
References: <cover.1719909395.git.leon@kernel.org>
 <20240703054238.GA25366@lst.de>
 <20240703105253.GA95824@unreal>
 <20240703143530.GA30857@lst.de>
 <20240703155114.GB95824@unreal>
 <20240704074855.GA26913@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704074855.GA26913@lst.de>

On Thu, Jul 04, 2024 at 09:48:56AM +0200, Christoph Hellwig wrote:

> 1) The amount of code needed in nvme worries me a bit.  Now NVMe a messy
> driver due to the stupid PRPs vs just using SGLs, but needing a fair
> amount of extra boilerplate code in drivers is a bit of a warning sign.
> I plan to look into this to see if I can help on improving it, but for
> that I need a working version first.

It would be nice to have less.  So much now depends on the caller to
provide both the input and output data structure.

Ideally we'd have some template code that consolidates these loops to
common code with driver provided hooks - there are a few ways to get
that efficiently in C.

I think it will be clearer when we get to RDMA and there we have the
same SGL/PRP kind of split up and we can see what is sharable.

> Not quite as concerning, but doing an indirect call for each map
> through dma_map_ops in addition to the iommu ops is not every
> efficient.

Yeah, there is no reason to support anything other than dma-iommu.c
for the iommu path, so the dma_map_op indirection for this could just
be removed.

I'm also cooking something that should let us build a way to iommu map
a bio_vec very efficiently, which should transform this into a single
indirect call into the iommu driver per bio_vec, and a single radix
walk/etc.

> We've through for a while to allow direct calls to dma-iommu similar
> how we do direct calls to dma-direct from the core mapping.c code.
> This might be a good time to do that as a prep step for this work.

I think there is room to benchmark and further improve these
paths. Even the fast direct map path is not compiling down to a single
load/store instruction per bio_vec entry as would be ideal.

Jason

