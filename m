Return-Path: <linux-block+bounces-9170-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC10910A3D
	for <lists+linux-block@lfdr.de>; Thu, 20 Jun 2024 17:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095871F20597
	for <lists+linux-block@lfdr.de>; Thu, 20 Jun 2024 15:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A9F1AD411;
	Thu, 20 Jun 2024 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m8h4Sn6T"
X-Original-To: linux-block@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FD31AD9F9
	for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718898231; cv=none; b=qkQUUTEGNMtf6/aqsaUIl9nbzDIl58lMmgZRSDfCaXi/1Xhg2hxleOzRznMgSI9IbFhdMp2HiAdeoj594vgbs6h/6rvadKGAqsA/djcMOhlXOCylhkwbqxu3+A7o0cPzOmiN7wYVjw0PC4f17y7xyOcj6z6cd14QoVmO0HdrQCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718898231; c=relaxed/simple;
	bh=w84aznMklvTomJKm2B/isoxH6+y5xbG2IWzD5jYKSdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2xka+wBUxcN7OZ0pKhhUedlQNIAwktkfjsOqeG2UxSx9eycseoLcxxsTmNKbu1BlIlcai2OqlmoCoTiHRD96r8JRLSzjdb+Qp5TTPAp0ImQRMOB6D/bM3WEtBDcU5oMnLLIQsBdRO1UeE2tRt0rOAyOiu3xVc8UWK6NX6Xv9Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m8h4Sn6T; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: hch@lst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718898228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KR3OdNe6f+nFOK38PD6sSn1rboAVawph2U2KfmOAbN4=;
	b=m8h4Sn6TpfyYEIfU43oG7do1ZqE0IVoBCNOvEBg4oxTDcx/PISBU/xTLhhkxhTRit9AWYS
	RUZPQkm88pX/lfDkWfi+LQDmjq0CzpE4Kkuoc5GbAZD0Fd69KR7ohvCnYd1NR+j2zh3G4N
	6n0ON49f1X2w2KHsmTjdtmmbUHqR4fE=
X-Envelope-To: willy@infradead.org
X-Envelope-To: lihongbo22@huawei.com
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: axboe@kernel.dk
Date: Thu, 20 Jun 2024 11:43:44 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christoph Hellwig <hch@lst.de>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Hongbo Li <lihongbo22@huawei.com>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: bvec_iter.bi_sector -> loff_t? (was: Re: [PATCH] bcachefs: allow
 direct io fallback to buffer io for) unaligned length or offset
Message-ID: <hehodpowajdsfscwf7y3yaqsu2byhzkwpsiaesj5sz722efzg4@gwnod5qe7ed4>
References: <20240620132157.888559-1-lihongbo22@huawei.com>
 <bbf7lnl2d5sxdzqbv3jcn6gxmtnsnscakqmfdf6vj4fcs3nasx@zvjsxfwkavgm>
 <ZnQ0gdpcplp_-aw7@casper.infradead.org>
 <20240620153050.GA26369@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620153050.GA26369@lst.de>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 20, 2024 at 05:30:50PM +0200, Christoph Hellwig wrote:
> On Thu, Jun 20, 2024 at 02:54:09PM +0100, Matthew Wilcox wrote:
> > I'm against it.  Block devices only do sector-aligned IO and we should
> > not pretend otherwise.
> 
> While I agree with that, the bvec_iter is actually used in a few other
> places and could be used in more, and the 512-byte sector unit bi_sector
> is the only weird thing that's not useful elsewhere.  So turning that
> into a
> 
> 	u64 bi_addr;
> 
> that is byte based where the meaning is specific to the user would
> actually be kinda nice.  For traditional block users we'd need a
> bio_sector() helpers similar to the existing bio_sectors() one,
> but a lot of non-trivial drivers actually need to translated to
> a variable LBA-based addressing, which would be (a tiny little bit)
> simpler with the byte address.   As bi_size is already in bytes
> it would also fit in pretty naturally with that.
> 
> The only thing that is really off putting is the amount of churn that
> this would cause.

I'm being imprecise when I just say 'struct bio'; there's things in
there that are block layer specific but there are also things in there
you want that aren't block layer specific (completion callback, write
flags, s/bi_bdev/bi_inode and that as well, perhaps). It's not at all
clear to me we'd want to deal with the churn to split that up or make
bio itself less block layer specific (although, but when I say 'aiming
for commality with struct bio' that sort of thing is what I have in
mind.

But more immediately, yes - bi_addr as all we need for this, and like
you said I think it'd be a worthwhile change.

