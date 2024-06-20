Return-Path: <linux-block+bounces-9153-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F65E910651
	for <lists+linux-block@lfdr.de>; Thu, 20 Jun 2024 15:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B4B3B277A8
	for <lists+linux-block@lfdr.de>; Thu, 20 Jun 2024 13:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26B71AD9DA;
	Thu, 20 Jun 2024 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lR8yolg9"
X-Original-To: linux-block@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671891E497
	for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890610; cv=none; b=AedLAHdpI8UH2r+Z1R+bpaQoYLN0CBjE2DRpUQNd1RzswBM/eWNyBGUqJDw4RxTduKUWnKyFbetPF8Gq7Wy9dzSh0uURbfWM19boZkrnoyZkAM1Go9YcmUZI+48fywEsuFSHfIlBaat1mMebK85gGJKAp8WiKeV9gsJhyYREqQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890610; c=relaxed/simple;
	bh=+sWTWDC3ikPWsAV1IbSylnunXKZryaaHQW9aHe9Mpo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXm3lXe9VjL1Is9EsOga/27HTeYy9ouTRbFDCYTjOJX09/7nw+Vl8I6/hyIkcMdtY2IUY483xhW9wZlYsFEtkbj2xf7JYKECMnQuAJbzNuV0i6BPFZMIajvGJEn7hm0KWpM5Q3CwyphJYVTM7ZMg3SwoOO7Aeb7X7RrcrrZ3I5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lR8yolg9; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: lihongbo22@huawei.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718890605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=46Y87jZfUvizmkvEkJBUYNPGXnI+S4cKabQ3/FwgEYI=;
	b=lR8yolg9taBy7u6SE50bHxnsAjDkQO0HDSLKvY1m30IE7QIqiJRVWnRH+wlH8BdwGQ1ZJF
	HYxBMN63a7+uEDw4vznNxY392+mAopcJUIjJF6/pMKB4iMCHION5ua+z9wcTuM81Xn+PR5
	XqeTVNljlqcJwXvGwU2EILMz4B3j35o=
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: hch@lst.de
Date: Thu, 20 Jun 2024 09:36:42 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de
Subject: bvec_iter.bi_sector -> loff_t? (was: Re: [PATCH] bcachefs: allow
 direct io fallback to buffer io for) unaligned length or offset
Message-ID: <bbf7lnl2d5sxdzqbv3jcn6gxmtnsnscakqmfdf6vj4fcs3nasx@zvjsxfwkavgm>
References: <20240620132157.888559-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620132157.888559-1-lihongbo22@huawei.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 20, 2024 at 09:21:57PM +0800, Hongbo Li wrote:
> Support fallback to buffered I/O if the operation being performed on
> unaligned length or offset. This may change the behavior for direct
> I/O in some cases.
> 
> [Before]
> For length which aligned with 256 bytes (not SECTOR aligned) will
> read failed under direct I/O.
> 
> [After]
> For length which aligned with 256 bytes (not SECTOR aligned) will
> read the data successfully under direct I/O because it will fallback
> to buffer I/O.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

I don't think we want to do this in bcachefs - we can't efficiently mix
buffered and O_DIRECT IO on the same file. This is true on any
filesystem, but even moreso on bcachefs as we guarantee strict page
cache consistency (O_DIRECT IO blocks pagecache fills, and vice versa).

Better way to do that would be to make the bcachefs read path natively
handle unaligned IO, which conceptually wouldn't be difficult since our
read path already has support for bouncing when necessary (i.e. reading
only part of a checksummed or compressed extent).

The catch is that struct bio - bvec_iter - represents addresses with a
sector_t, and we'd want that to be a loff_t.

That's something we should do anyways; everything else in struct bio can
represent a byte-aligned io, bvec_iter.bi_sector is the only exception
and fixing that would help in consolidating our various scatter-gather
list data structures - but we'd need buy-in from Jens and Christoph
before doing that.

As an intermediate solution (i.e., I would want it clearly labelled as a
hack to be removed when the proper solution is merged and an explanation
of what we actually want), we could add a loff_t to bch_read_bio, and
only initialize bi_iter.bi_sector right before submit_bio() when we know
our loff_t is properly aligned. But that'd be pretty ugly, we'd have to
audit and probably add new helpers for everywhere we use a bvec_iter in
the read path.

