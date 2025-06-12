Return-Path: <linux-block+bounces-22531-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B47DAD670E
	for <lists+linux-block@lfdr.de>; Thu, 12 Jun 2025 07:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05CF83A35A2
	for <lists+linux-block@lfdr.de>; Thu, 12 Jun 2025 05:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A57413C81B;
	Thu, 12 Jun 2025 05:03:02 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB2E8F40
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 05:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749704582; cv=none; b=Bei9NEbJlnhytgqcwGF3bwSbf75fMpNRGAG4ts0LlMhPtdjLRUTXiDcix6z1LxA+ySNjF5gYGLAwf/vRTZIJMD15dvU7MTcmPYWQ3ThjSuxdkwIqtJStdjaf0oykam+rbfX32OlE2KAbGNiVB71UFMAcrF1hpbcsNSHt46QlLrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749704582; c=relaxed/simple;
	bh=xMxsZI7Rml5sONJtu1vxFszxdHNgRJ8SPZ+TXz1dg6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1f3ILWR1+1cV0s8uDfpUwmi91Lv46oe4OJU7Du92PRAtXXzpo3pvwRidk2HDP9xbJjOGP45usf+JFh5D0rdcLdfz0GTM+AcM0p1dtZmO0cVovZNBVbr2yM1f050w1ciLdpSSMwBgD7nJThWOeRmlS2al0BVDa5jeYd8Mt8W9EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 27A4E68D09; Thu, 12 Jun 2025 07:02:57 +0200 (CEST)
Date: Thu, 12 Jun 2025 07:02:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 7/9] nvme-pci: convert the data mapping blk_rq_dma_map
Message-ID: <20250612050256.GH12863@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-8-hch@lst.de> <5c4f1a7f-b56f-4a97-a32e-fa2ded52922a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c4f1a7f-b56f-4a97-a32e-fa2ded52922a@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 11, 2025 at 02:15:10PM +0200, Daniel Gomez wrote:
> >  #define NVME_MAX_SEGS \
> > -	min(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc), \
> > -	    (PAGE_SIZE / sizeof(struct scatterlist)))
> > +	(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc))
> 
> The 8 MiB max transfer size is only reachable if host segments are at least 32k.
> But I think this limitation is only on the SGL side, right?

Yes, PRPs don't really have the concept of segments to start with.

> Adding support to
> multiple SGL segments should allow us to increase this limit 256 -> 2048.
> 
> Is this correct?

Yes.  Note that plenty of hardware doesn't really like chained SGLs too
much and you might get performance degradation.


