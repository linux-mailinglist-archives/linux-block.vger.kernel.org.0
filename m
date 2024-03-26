Return-Path: <linux-block+bounces-5093-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8E188BAF6
	for <lists+linux-block@lfdr.de>; Tue, 26 Mar 2024 08:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF431F39EC3
	for <lists+linux-block@lfdr.de>; Tue, 26 Mar 2024 07:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5711212DDBF;
	Tue, 26 Mar 2024 07:08:50 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B19B129A71;
	Tue, 26 Mar 2024 07:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711436930; cv=none; b=Oe9cWHBX+/v16CD8cGAh903ARwp9WYrSU5wVBCXdCZAwhwD022uSwkrFAd0CZMXbl99p4BuqaE/zXQ9fLnRpUACL1+04R/PyXvM123W/HRryq58OBK2PGkcis9UVXqJANHz4uSVrz1MID+mSIPLpZv7X2gTUYxNMFNGfaQiH9lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711436930; c=relaxed/simple;
	bh=2pybxWgI9/v8JH1oxbOlq0Vrixo/FGASPZm0L+AgdPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7eYP/v4A1klHsKPo14bBc9c0D2X9l8E0ymmI5E6QtY+sFWHn5iGd8W2pL+gPEKJ7hxb+PwXMDAaJRxWgEX7UESy22nRXaNOjTI8fI8tyIzUcoyeGbk/xzuYue7ljzBeuE2nRUJtslGyWfZefM9K7TTPQhwBdzPhcmlU4SDhle8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3EE9768D45; Tue, 26 Mar 2024 08:08:40 +0100 (CET)
Date: Tue, 26 Mar 2024 08:08:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 12/28] block: Allow BIO-based drivers to use
 blk_revalidate_disk_zones()
Message-ID: <20240326070838.GA8402@lst.de>
References: <20240325044452.3125418-1-dlemoal@kernel.org> <20240325044452.3125418-13-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325044452.3125418-13-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +	/*
> +	 * For devices using a BIO-based driver, we need zone resources only
> +	 * if zone append emulation is required.
> +	 */
> +	if (!queue_is_mq(disk->queue) &&
> +	    !queue_emulates_zone_append(disk->queue))
> +		return 0;
> +

This code and the comment is duplicated in two places.  It also fails
to capture why bio drivers don't need zoned resources - that is that
we can't enforce QD=1 per zone for them.  Maybe add a little helper
to encapsulate this check and expand the comment a little?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

