Return-Path: <linux-block+bounces-23173-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7C5AE76CC
	for <lists+linux-block@lfdr.de>; Wed, 25 Jun 2025 08:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE11E162A00
	for <lists+linux-block@lfdr.de>; Wed, 25 Jun 2025 06:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7E81EB9EB;
	Wed, 25 Jun 2025 06:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zzuUmYvW"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04751EB5C2;
	Wed, 25 Jun 2025 06:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750831974; cv=none; b=nxP+GzIXMn8g9TpJ271OkJV/IXikk8pL9vZpJviN79HRULqcC5GtxXBOps6oD/osyQh8US7pCQYmehN9EI7wd79B6+4SVstTzRRsnTWQmMZ/mYkpdmeZ8Q3S+siGs3JFQ/MMnEoyHnXGyq3F87hF+GA4ASpm1zuHfkOjyU+kIms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750831974; c=relaxed/simple;
	bh=/ZE7O5iYYHD2cWHUQMttWl4oBO/D0q77IXmtN84PVhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDpZVSC4Zwjcb6dPmzcTfTtYYZJDu82SWYZJF3deJH+tEJYoilYyMSCdPIlJRzx2doqj1tFF1RM4o/LrKYSI5pQd4RNqfFrXIrUdaI4/10GafA4vyVIolwbrv1K84LsSBGqbYY3lrtvcnDqe1ekzh5/DpuX3/Wm/Vjm8YYPpNdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zzuUmYvW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/ZE7O5iYYHD2cWHUQMttWl4oBO/D0q77IXmtN84PVhw=; b=zzuUmYvWQV6Amparz4D6gMfpLZ
	cZWKBtm3Wta1WwFAtBBSJL/mgp26d4G+nZpgd5ddZ9m/uLHENYKzm3+XV2kPp6fgomx0IGJZWe5B3
	XDAOMdrJ4EHOkL6GstcPyYOhQzg7KzHbXwl+vnGhtcC35oDVX3YMDSm7l5f/wuxeteCNqHm4/Mx8r
	9fadMjZ/Hs1H9yTk68fHuHN8Rc1nW+cKRzRRhbINavMEFw5Wz18kS+l4lz0EfV4USuFaaVz89DLrm
	MVd2ADXAeV/VwHeCfcPOw7/skGItx7LDsiZOqu55N6ABMfG0QvNRA+igQkvCOEVXGZpAAo3NuLB/4
	d1ohMtLg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUJNL-00000007dNn-1uNQ;
	Wed, 25 Jun 2025 06:12:51 +0000
Date: Tue, 24 Jun 2025 23:12:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 1/4] block: Introduce bio_needs_zone_write_plugging()
Message-ID: <aFuTYxdeAzG1iSl9@infradead.org>
References: <20250625055908.456235-1-dlemoal@kernel.org>
 <20250625055908.456235-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625055908.456235-2-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 25, 2025 at 02:59:05PM +0900, Damien Le Moal wrote:
> +bool bio_needs_zone_write_plugging(struct bio *bio)

Can you use this in blk_zone_plug_bio instead of duplicating the logic?

I also wonder if we should only it it, as despite looking quite complex
it should compile down to just a few instructions and is used in the
I/O fast path.


