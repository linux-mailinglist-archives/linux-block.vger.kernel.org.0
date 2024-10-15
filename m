Return-Path: <linux-block+bounces-12588-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A8D99DFC7
	for <lists+linux-block@lfdr.de>; Tue, 15 Oct 2024 09:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6013BB23294
	for <lists+linux-block@lfdr.de>; Tue, 15 Oct 2024 07:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0751ADFFC;
	Tue, 15 Oct 2024 07:54:24 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0B91AAE2C;
	Tue, 15 Oct 2024 07:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978864; cv=none; b=YlIGaXKm41q8j8oU9yvXkaHpCNgPdM86iiHU+37lxDnkk4EJWeYXhv0CtfURoep+miG0ZWdnfFrsvkPTeRmlQ/7K1QCsdkB6O0W6qgbII+AUAI1pbp/7zs398ZCXM8FRYDANug+kTd9mLr4/6BtHlXLJV9Bh6wc+hiUMVmWF+6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978864; c=relaxed/simple;
	bh=81PWpKBiCuQR9qayZ+gc7K8ZHTHGC6P8ZEbv2PsYCz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NynmYG+o+qeiOISZj+rFD13ihl1zngaSQxm+JSFT0ix7LJ+SWC87OfRM4879w77Lji/LSxsreRV7pRVakFbFdzkLsObfP8p0FdW22msjLy9MS9IOyGyK/mf5jlBsGHSS19NFFvyOAaYTZfBTmN2zWuL+0Mkf10+Ckik3moADrJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D4B5E227AA8; Tue, 15 Oct 2024 09:54:18 +0200 (CEST)
Date: Tue, 15 Oct 2024 09:54:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Hannes Reinecke <hare@suse.de>,
	Hamza Mahfooz <someguy@effective-light.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	linux-raid@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [Report] annoyed dma debug warning "cacheline tracking EEXIST,
 overlapping mappings aren't supported"
Message-ID: <20241015075418.GA25487@lst.de>
References: <ZwxzdWmYcBK27mUs@fedora> <426b5600-7489-43a7-8007-ac4d9dbc9aca@suse.de> <20241014074151.GA22419@lst.de> <ZwzPDU5Lgt6MbpYt@fedora> <7411ae1d-5e36-46da-99cf-c485ebdb31bc@arm.com> <20241015045413.GA18058@lst.de> <Zw4camcCvclL4Q_6@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw4camcCvclL4Q_6@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 15, 2024 at 03:40:26PM +0800, Ming Lei wrote:
> > Yes, active_cacheline_insert only complains for FROM_DEVICE or
> > BIDIRECTIONAL mappings.  I can't see how raid 1 would trigger that
> > given that it only reads from one leg at a time.
> > 
> > Ming, can you look a bit more into what is happening here?
> 
> All should be READ IO which is FROM_DEVICE, please see my reply:

Yes, reads translate to DMA_FROM_DEVICE.

> https://lore.kernel.org/linux-block/Zw3MZrK_l7DuFfFd@fedora/
> 
> And the raid1 warning is actually from raid1_sync_request().

In that case the warnings are perfectly valid because the I/O patterns
will create data corruption on non-coherent architectures.  For direct
I/O from userspace the kernel can't prevent it, but for raid1 we should
be able to do something better.  As raid1_sync_request is a convoluted
and undocumented mess I don't have a straigh shot answer to what it is
doing (wrong) and how to fix it unfortunately.

> 
> 
> Thanks,
> Ming
---end quoted text---

