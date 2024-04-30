Return-Path: <linux-block+bounces-6755-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0168B7B5C
	for <lists+linux-block@lfdr.de>; Tue, 30 Apr 2024 17:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A332F1F218AC
	for <lists+linux-block@lfdr.de>; Tue, 30 Apr 2024 15:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75572143737;
	Tue, 30 Apr 2024 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Goa3K8rm"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A60770F0;
	Tue, 30 Apr 2024 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490650; cv=none; b=svrKTyndEjoxupiHPLVRUbjbI5I0G/7Dj2iuGyC1gU6R7aEUlPQAEKMxW7wtt353oiD1exjDZMJhmlKHBFhLymfnvHRNvp5ERT1brmQZXKECq6RIpcYSP3lIk36Z0xSKQwsq0drsZTrzN3UFwxPRDysLxjrnK2Zcf90L3/k1T98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490650; c=relaxed/simple;
	bh=uIlTWDEVP6/9STi4JRdV7hwIzRQX2pkyMuGrwfl2Y20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjAV+mRoyl9I8D8UWYEROHyk2KhhYJw/MEVZlmcn4637CH2nTKzpsa1/Wx5Ca9sozty6UpU1d+FaIjPDyFDR3+0Eyh5Y9jvRN/IRpD+K72afbYRZ8B3/Mtx1NufUmTI2RdZcFSxpotIOFm0Wbys9du6tApzL9k9tNWpFsJkDoUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Goa3K8rm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7to6bsX34EJDGZQBW8ziRCIFjV3P/zRrci5apjZz7Ic=; b=Goa3K8rmCwqklydVl/Nggu5fJD
	JvoYNNkQNgSdSqkqXhUnnpOT4J2bcvG2/wyWTqql51Lx7aS4MxjN7QHS5g/03pntI8xoHOTNmZdSN
	wwf9xsDkf/MhDEiOVrcPnzwgmf8/p5x7Sc+am2hCh7dDFYGLmAWSd1c6naXVe9FztVOIE4VLGTDOv
	cDk7tZhQr2oF5fKQpRagzOW5DX/6VRT53/ckZqnCa03vBBp0QjouD6C2kGBfmSKgxbpGreIXIqjOX
	DYFYI2x2jUp1/N9x/9CaCCrDfDFM24JYaF5EjrQLOR96rhH6CzN0JHR+CJo6nQU5DxtxHr1TbgY6f
	SHXq0WfQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1pKx-000000071d8-2tIE;
	Tue, 30 Apr 2024 15:24:07 +0000
Date: Tue, 30 Apr 2024 08:24:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 02/13] block: Exclude conventional zones when faking max
 open limit
Message-ID: <ZjENF8spyEWrGwws@infradead.org>
References: <20240430125131.668482-1-dlemoal@kernel.org>
 <20240430125131.668482-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430125131.668482-3-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Apr 30, 2024 at 09:51:20PM +0900, Damien Le Moal wrote:
> +	/* Resize the zone write plug memory pool if needed. */
> +	if (disk->zone_wplugs_pool->min_nr != pool_size)
> +		mempool_resize(disk->zone_wplugs_pool, pool_size);

No need for the if here, mempool_resize is a no-op if called for
the current value.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

