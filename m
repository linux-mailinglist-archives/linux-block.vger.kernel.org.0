Return-Path: <linux-block+bounces-30162-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E423EC5331D
	for <lists+linux-block@lfdr.de>; Wed, 12 Nov 2025 16:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB4B6546EBD
	for <lists+linux-block@lfdr.de>; Wed, 12 Nov 2025 15:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BC62857F6;
	Wed, 12 Nov 2025 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2Xf993U"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00DB2750E6;
	Wed, 12 Nov 2025 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960569; cv=none; b=r8uooQhcYeO3ysQDVskDhRRBoo9H6mndPtieGKmTZcN+SDZJpm34WrER/7HpMiCZBhBVOUpSnP1JBDDEEEF8ZPuxxntwhou7GHGf3n5qWiaJYiRd3ScOXk8DJF09UakghZqVr0WuVB/HIAr16fHybKXa7x9i0X46CktvHZGbjf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960569; c=relaxed/simple;
	bh=vzrBhlBN+G4m8xbDXYXnTlmh3Zk67K2c6rZJh+4k460=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGBNfC6/Y2YYA372XwothYW3CQvPEqLow6CYCewZo6L0iDBmo6tBMPaU59D/Swx9CPyDz8phe5pb5WWCgxX4Vl/cW0FC7Uvjp9EECU27NJD9mge4843uclxHiadanUsbQ6dmAuUDKW4Zt9rLqIqYS1PdvWKjh3TS161GqfYlDcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2Xf993U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE8BC4CEF1;
	Wed, 12 Nov 2025 15:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762960569;
	bh=vzrBhlBN+G4m8xbDXYXnTlmh3Zk67K2c6rZJh+4k460=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V2Xf993Uag6Ne/cYPOKmf0Nv7zxzm5iuuxwnJPuCB8n+3JPk48w/eBcEdMeFDHMIZ
	 LjIgxtK2KhKkFk9sjHQY/2d9ONqBWsrEcyOFwY0saKHliNb8JqhLodBixQUKVGFd0J
	 Fb5iAuoV0sIsz3f61Z5a8yBM2BsDifa3dSATli2oIUWxAO6n05f3IFwNZvVgcJTDa0
	 dE5XqyU+IB2gxfHaHaXu1vcwf0F44hFF343Oaq5HuEjnevnR8IGyuitCWSjC5BEkaj
	 S9wtY4E2lxwGZxDbftwRCrKULTwLTddzVVIiQ3/ZxISF4jbTkzw4h6nPR+zgNxct0b
	 BWftzdUj10Iog==
Date: Wed, 12 Nov 2025 17:16:04 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] block-dma: properly take MMIO path
Message-ID: <20251112151604.GF17382@unreal>
References: <20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com>
 <20251027-block-with-mmio-v3-2-ac3370e1f7b7@nvidia.com>
 <aRSbzwpS2AuP92_n@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRSbzwpS2AuP92_n@kbusch-mbp>

On Wed, Nov 12, 2025 at 09:38:07AM -0500, Keith Busch wrote:
> On Mon, Oct 27, 2025 at 09:30:21AM +0200, Leon Romanovsky wrote:
> > @@ -732,13 +746,20 @@ static void nvme_unmap_metadata(struct request *req)
> >  		return;
> >  	}
> >  
> > -	if (!blk_rq_integrity_dma_unmap(req, dma_dev, &iod->meta_dma_state,
> > -					iod->meta_total_len)) {
> > +	if (iod->flags & IOD_META_P2P)
> > +		map = PCI_P2PDMA_MAP_BUS_ADDR;
> > +	if (iod->flags & IOD_META_MMIO) {
> > +		map = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
> > +		attrs |= DMA_ATTR_MMIO;
> > +	}
> 
> This should be an 'else if' no?

We can't have both IOD_META_P2P and IOD_META_MMIO. It can be only one or
IOD_META_P2P or IOD_META_MMIO. In this case "else if' is not necessary.

> 

<...>

> > @@ -1036,6 +1067,17 @@ static blk_status_t nvme_map_data(struct request *req)
> >  	if (!blk_rq_dma_map_iter_start(req, dev->dev, &iod->dma_state, &iter))
> >  		return iter.status;
> >  
> > +	switch (iter.p2pdma.map) {
> > +	case PCI_P2PDMA_MAP_BUS_ADDR:
> > +		iod->flags |= IOD_DATA_P2P;
> > +		break;
> > +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> > +		iod->flags |= IOD_DATA_MMIO;
> > +		break;
> > +	default:
> > +		return BLK_STS_RESOURCE;
> > +	}
> 
> Why is it an error if the data isn't a P2PDMA type?

This is probably bug, I was supposed to handle PCI_P2PDMA_MAP_NONE case too.

Thanks

