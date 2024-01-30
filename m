Return-Path: <linux-block+bounces-2589-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F132684267A
	for <lists+linux-block@lfdr.de>; Tue, 30 Jan 2024 14:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD51C286940
	for <lists+linux-block@lfdr.de>; Tue, 30 Jan 2024 13:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431386D1D9;
	Tue, 30 Jan 2024 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AG7TSczF"
X-Original-To: linux-block@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CCA6D1BF;
	Tue, 30 Jan 2024 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706622742; cv=none; b=FDhbB+ZoapKkK0vvfPItT6XfLp3yFRJM94v1vkAXVq2kZnl3V//82+ufkczFx7yAdIy2qwMniEeoM7TN84OMDJNA10FERkxEEhQ7aeoU7Sx3hgvS84BGV+OMRqqz+OorMYBYbzEifqNs8Uv2D1/xHIJrVlkWVeuV8oCoGV0ePRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706622742; c=relaxed/simple;
	bh=zfYjNHFFs8Fq44BpkDOtB1YavVGP1uB9Xs7BaGdmCgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2PqvE1xF+AytukmSqyK/v0f9D+pp2bTyZBhju6nmjkT5zT503mrqnQkNVvq/yDrgwkYU645OoHMad86x4nQZ9pKT7IqK0K/WlhbGEMrLm3pecgd6y40a/3WYrFeDkG2L6qPqH/E7fuNwgGRo6YSDApezpjXZyeh0vpPSBhu31g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AG7TSczF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VcsdYxQa1M0QQIUwllrKVKNWcmHyrB1J+JwCbDlCV40=; b=AG7TSczFM7Flw+NtBumfg5BUka
	ZUatoQRvBWWAyH45sEq0HKWlZ6niH3NFbBbFd7VGV2BdNDU2RW5wXX3zBZ+hdsBcGIxxDmblE9ghZ
	ketpIOdA0YYuBqbjAp+9/LNYWn2kudrv9Hfks5HC77KY/tZys2wySTSqpMUi8/6qRHR6lSJCAdW7X
	vbIb+EqSe5Jo0jDK/GEHy6S74MOk3YoFKe0MnHi7gI3cAK8AYZ9JooemFQ9whngM0G0Zq7CvHs5oM
	/CaeuVCWywwoTjaol3QSBe4d92e1YJDw7qAbiu+xBdJ73FCWrRo7vWbAbJpgNCDZo5wgkdTCt1NkI
	cRafvltA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUoWx-00000009yDX-3SU4;
	Tue, 30 Jan 2024 13:52:03 +0000
Date: Tue, 30 Jan 2024 13:52:03 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
	Yu Zhao <yuzhao@google.com>, Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <niklas.cassel@wdc.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Linus Walleij <linus.walleij@linaro.org>, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [PATCHv5 1/1] block: introduce content activity based ioprio
Message-ID: <Zbj_A3e1T1wRsKiM@casper.infradead.org>
References: <20240130084207.3760518-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130084207.3760518-1-zhaoyang.huang@unisoc.com>

On Tue, Jan 30, 2024 at 04:42:07PM +0800, zhaoyang.huang wrote:
> +static __maybe_unused
> +bool act_bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
> +		size_t off)

No, stop this.  What the filesystem needs to do is not
s/bio_add_folio/act_bio_add_folio/.  There needs to be an API to set the
bio prio; something like:

	bio_set_active_prio(bio, folio);

and then you can do whatever gunk is needed in bio_set_active_prio()
to end up calling bio_set_prio().


