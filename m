Return-Path: <linux-block+bounces-7187-lists+linux-block=lfdr.de@vger.kernel.org>
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BA48C11AC
	for <lists+linux-block@lfdr.de>; Thu,  9 May 2024 17:08:36 +0200 (CEST)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE94282362
	for <lists+linux-block@lfdr.de>; Thu,  9 May 2024 15:08:34 +0000 (UTC)
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85D012FF9B;
	Thu,  9 May 2024 15:08:29 +0000 (UTC)
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPl17+L4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAEF39AC9;
	Thu,  9 May 2024 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
	t=1715267309; cv=none; b=aAKeDQ/nvCuYHuN+b6QBpbD9tklkUuLYUoSZoBmcX3vjo/06UphKIjxqwt78hQvuE7G60w55t0l/BmE+y/de1ZGfIwGtAdPqfTBHU+/teUPTcbjDVYPByMB4nw86Kiw7CS9k0p4xDZbhb0wabaHbrx6Hpmx92TfauvTh47Fnc64=
	s=arc-20240116; t=1715267309; c=relaxed/simple;
	bh=9EW6nosjHmizZcra6PAPYTvE4b8FuYEt7trYN1KwElU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKSWMcuAu861xR9hQwWxsgC5YGXxRFbtZLyPsLM2QPiP79XDxngqEhmlDBZQrxCXC8xoOks41ea55p2ccuPStbKu95esDuy1C9FAkpnXvww/Ozt1iDdR8ZTD/2vASg5JOORVBlpK5yeLXJQrAz+Xepi3F2JF8vt5Ogw+Hmu02dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPl17+L4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2455FC2BD11;
	Thu,  9 May 2024 15:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715267309;
	bh=9EW6nosjHmizZcra6PAPYTvE4b8FuYEt7trYN1KwElU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fPl17+L4TDK5O455WyQx1pXZhdhlYPnaV4YZdD6RmWyNFg4+Hf8/72P2IZjh/dZpw
	 PkyUgOa4BhcQ2LV5CaT29FLE/ECw++r3ai8YpcJSC/rMeY91xMPNHG4Mt8dF2wl4v+
	 Zj9/Bb8LueVw68kKqieVsPdjgZuq/nIJrDv7ehoXn2diqUJ55scDtre6M4u8yY7Y1L
	 0WQVBxcrr7xZTP2pxQCamxSxEOp37+rvH9pMDw8mdqAYBRmey0NS2Xd3rPEZhViAGU
	 oNI4r0YuBpYNtRIMufYCRwfJLxBAAwbrFzsyBb26guOx2oVXTtZ8eA+MOMsH1z5rov
	 4l2fDf5iJ6ApA==
Date: Thu, 9 May 2024 08:08:28 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, hch@lst.de,
	willy@infradead.org, mcgrof@kernel.org, akpm@linux-foundation.org,
	brauner@kernel.org, chandan.babu@oracle.com, david@fromorbit.com,
	gost.dev@samsung.com, hare@suse.de, john.g.garry@oracle.com,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	ritesh.list@gmail.com, ziy@nvidia.com
Subject: Re: [RFC] iomap: use huge zero folio in iomap_dio_zero
Message-ID: <20240509150828.GK360919@frogsfrogsfrogs>
References: <20240507145811.52987-1-kernel@pankajraghav.com>
 <ZjpSx7SBvzQI4oRV@infradead.org>
 <20240508113949.pwyeavrc2rrwsxw2@quentin>
 <Zjtlep7rySFJFcik@infradead.org>
 <20240509123107.hhi3lzjcn5svejvk@quentin>
 <ZjzFv7cKJcwDRbjQ@infradead.org>
 <20240509125514.2i3a7yo657frjqwq@quentin>
 <ZjzIb-xfFgZ4yg0I@infradead.org>
 <20240509143250.GF360919@frogsfrogsfrogs>
 <ZjzmNF51yb_EyP4W@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjzmNF51yb_EyP4W@infradead.org>

On Thu, May 09, 2024 at 08:05:24AM -0700, Christoph Hellwig wrote:
> On Thu, May 09, 2024 at 07:32:50AM -0700, Darrick J. Wong wrote:
> > On Thu, May 09, 2024 at 05:58:23AM -0700, Christoph Hellwig wrote:
> > > On Thu, May 09, 2024 at 12:55:14PM +0000, Pankaj Raghav (Samsung) wrote:
> > > > We might still fail here during mount. My question is: do we also fail
> > > > the mount if folio_alloc fails?
> > > 
> > > Yes.  Like any other allocation that fails at mount time.
> > 
> > How hard is it to fallback to regular zero-page if you can't allocate
> > the zero-hugepage?
> 
> We'd need the bio allocation and bio_add_page loop.  Not the end
> of the world, but also a bit annoying.  If we do that we might as
> well just do it unconditionally.
> 
> > I think most sysadmins would rather mount with
> > reduced zeroing performance than get an ENOMEM.
> 
> If you don't have 2MB free for the zero huge folio, are you going to
> do useful things with your large block size XFS file system which
> only makes sense for giant storage sizes?
Oh.  Right, this is for bs>ps.  For that case it makes sense to fail the
mount.  I was only thinking about bs<=ps with large folios, where it
doesn't.
(Would we use the zero-hugepage for large folios on a 4k fsblock fs?)
--D