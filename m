Return-Path: <linux-block+bounces-8222-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA49B8FC29D
	for <lists+linux-block@lfdr.de>; Wed,  5 Jun 2024 06:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7461D1F232FD
	for <lists+linux-block@lfdr.de>; Wed,  5 Jun 2024 04:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CC873454;
	Wed,  5 Jun 2024 04:23:17 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B8D5C603
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 04:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717561397; cv=none; b=MGgg5AIpNYPY2ceczvabCkAnbSXtMsQFjmFQ+0AUFzIEw6Y9AVCmN2GDK+JV37D82Y1/tTjk6H7xPXaSXLc4hEqWrALV69z9HfrvYNmTKwQdMrJ046dXOO552i+T9xPiVOSf4BtCsBUR19S1s61hj4cN16hA9pXfBTNMKviFoUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717561397; c=relaxed/simple;
	bh=fvq3GheW3Y1VSRp85H9+kdZugwIQXWhub/OiQvjcFjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfwgtjxGRKnu+r6PEY8CYChKNRUgi9H4N0Fs8TgtGCfYgC4m2tft5LJZcIl93GtZ2PQiZ27p2wFqfOGh4A1MgKamBBck0WuRM9w0G1yPIE7/Jj3U/w00ILFLRWeHTUg4mlOYL9k64t9ONDejGwQorjZSwGOSkhDGQ/upfLBzjpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0732B68D84; Wed,  5 Jun 2024 06:23:12 +0200 (CEST)
Date: Wed, 5 Jun 2024 06:23:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Benjamin Marzinski <bmarzins@redhat.com>
Subject: Re: [PATCH v2 2/2] dm: Improve zone resource limits handling
Message-ID: <20240605042311.GB12183@lst.de>
References: <20240605022445.105747-1-dlemoal@kernel.org> <20240605022445.105747-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605022445.105747-3-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 05, 2024 at 11:24:45AM +0900, Damien Le Moal wrote:
> The generic stacking of limits implemented in the block layer cannot
> correctly handle stacking of zone resource limits (max open zones and
> max active zones)

... for DM.  All other limits stacking ends up in a single top device.

> +	/*
> +	 * If the target does not map all sequential zones, the limits
> +	 * will not be reliable.
> +	 */
> +	if (zc.target_nr_seq_zones < zc.total_nr_seq_zones)
> +		zlim->reliable_limits = false;
> +
> +	/*
> +	 * If the target maps less sequential zones than the limit values, then
> +	 * we do not have limits for this target.
> +	 */
> +	max_active_zones = disk->queue->limits.max_active_zones;
> +	if (max_active_zones >= zc.target_nr_seq_zones)
> +		max_active_zones = 0;
> +	zlim->max_active_zones =
> +		min_not_zero(max_active_zones, zlim->max_active_zones);
> +
> +	max_open_zones = disk->queue->limits.max_open_zones;
> +	if (max_open_zones >= zc.target_nr_seq_zones)
> +		max_open_zones = 0;
> +	zlim->max_open_zones =
> +		min_not_zero(max_open_zones, zlim->max_open_zones);

Given that your previous patch already caps max_open/active_zones to the
number of sequential zones, duplicating this here should not be needed.

> +	/* We cannot have more open zones than active zones. */
> +	zlim->max_open_zones =
> +			min(zlim->max_open_zones, zlim->max_active_zones);

Same question about the capping as in patch 1, and same comment about
the duplication as above.

> +	if (zlim.max_open_zones >= zlim.mapped_nr_seq_zones)
> +		lim->max_open_zones = 0;
> +	else
> +		lim->max_open_zones = zlim.max_open_zones;
> +
> +	if (zlim.max_active_zones >= zlim.mapped_nr_seq_zones)
> +		lim->max_active_zones = 0;
> +	else
> +		lim->max_active_zones = zlim.max_active_zones;

And once more here.


