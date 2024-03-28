Return-Path: <linux-block+bounces-4579-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573D187E063
	for <lists+linux-block@lfdr.de>; Sun, 17 Mar 2024 22:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124D6281B11
	for <lists+linux-block@lfdr.de>; Sun, 17 Mar 2024 21:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA9920DD3;
	Sun, 17 Mar 2024 21:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GTvPGMUA"
X-Original-To: linux-block@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D47320B35;
	Sun, 17 Mar 2024 21:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710711257; cv=none; b=tzgTcYuqIdEU+ZsAk4WywFkErjKLYdngzHabjY6FSmeQRWdLNoo1SvwNsNogaGL7F/WyMAbhJWC/uJZz+P1DLw90ydVbSMZAj+a1SZ6wp8vU0Hr5zyxGBPltHbMSCRklh862tQie8wXW8r8y9h/bG8ASggy0/rvqBaft087OYYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710711257; c=relaxed/simple;
	bh=JL4f9CkTc1PhMvDJqtVSNWVDRsuHiAIaDHnKNLauDrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enX4jrTDhiLUdXmBu31tU2xPCdq8CIUP7g/MzLyVJ+SKJmreUv3MZUV9qazuoh58inKRl21pLalVYw0lwzrYFmu/cANC1Ei6m7xMnp1wcgUy77weHdf+jFTh+9+f6nIQOBHiAvhR1qQZvbApby7cRh+IyYNP4hlI1ABLXQ/NfQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GTvPGMUA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mhmd4DQYdANeIXg1gAXPMMRysX1z3GDQw6kVU6mRTr0=; b=GTvPGMUANvAVfkSRGVTb9VOlGV
	LRmBd/rJHeORLF/hpnwFvVXYQ8IzeOFBmhW6ipeXMalh2qVUJeeX2HcLXblOxP+Zvi9TUF2CqvxBZ
	HX1Jf/9BLDdHOWcTuqdXXVSuuda74pmfKU/VDdbsKnMvh9+kIOU3JTUyV06ozqohwWWgxbMEDymBD
	x8E1j5UeBFZlyU0ojq437+xL0u+c3r9NOYgxZccJvEoB/iHdQntQoQ792/XOVEH7Sq9390GzPo44W
	cBZYUgdhveX0D3ffJEf1fp/tbI2zm7Id7MxH0Hto9FWfr5zQSFCym8nL7HYi2kBMagTPvnWZLA7Gt
	avc6qhtA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rly8n-0000000Fe5u-2tqR;
	Sun, 17 Mar 2024 21:34:01 +0000
Date: Sun, 17 Mar 2024 21:34:01 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yexuan Yang <1182282462@bupt.edu.cn>,
	Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado <sergio.collado@gmail.com>,
	Joel Granados <j.granados@samsung.com>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	open list <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 0/5] Rust block device driver API and null block
 driver
Message-ID: <ZfdhyfLWBIFtKO81@casper.infradead.org>
References: <20240313110515.70088-1-nmi@metaspace.dk>
 <ZfZajb_vcRwLacfH@casper.infradead.org>
 <874jd5qqpq.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jd5qqpq.fsf@metaspace.dk>

On Sun, Mar 17, 2024 at 08:09:53AM +0100, Andreas Hindborg wrote:
> I was under the impression that using folios also give the advantage
> that handles are always head pages. No need to worry about head/tail
> pages. If the driver moves to use higher order pages for larger block
> sizes, would it then make sense with folios, or are page still
> preferred?

This is a good question.

If you do enhance this driver to support larger block sizes, I would
recommend indexing the xarray by sector number instead of page number.
You would allocate a compound page, but at no point would you need to
ask the page what order it is (you already know), you don't need to
change the page flags, etc, etc.

The page cache is in a bit of a different spot.  It has to support
multiple folio sizes for the same file; it has to support folios being
split, it has to support lookup from users who don't know what the folio
size is, etc, etc.

I don't think there's ever a point at which you'd need to call
compound_head() because you'd always look up the head page.  You'd still
want an iterator of some kind to copy to a compound page (because you
can only map one at a time).  And that might look a lot like the folio
copying code.  Probably the right way to handle this is for the folio
copying code to call the page copying code since a folio is always
composed of pages.

