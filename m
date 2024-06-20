Return-Path: <linux-block+bounces-9162-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2185D9109A0
	for <lists+linux-block@lfdr.de>; Thu, 20 Jun 2024 17:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527161C216C5
	for <lists+linux-block@lfdr.de>; Thu, 20 Jun 2024 15:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285C31AE096;
	Thu, 20 Jun 2024 15:20:35 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEFE1AB91B;
	Thu, 20 Jun 2024 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718896835; cv=none; b=ikHGs7bzxUyJo1ngQTuYblVkcFMED6sUVg6NAKRSekxn34nm5C+LrRPcFMUvdCGavWgmaUB5f5gGPH8zYg4cpM/7IVKXXszTLG/8+Btd8+g5fsrMlueNDM6f0nwgWH7lVZ1l9YaL3fP2SrVXfiHC37eQnLzwPheAgbV9/EV/coI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718896835; c=relaxed/simple;
	bh=CU56t5Z5Al/t+2efQHbi0SL8eMItLTEZKVw2sIkJPGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VymajkHWSaKZGWtwukRKonyr29adb6T5e4X1Rb1LHx5w1A/rD65sYgN0U09RifCOeVgdaZmxxR1f+xAl8KJkZEfrrm83l8o/leUun+lrQVnEDGmoTunBQ4H+7CHdzgPFvl0SN/m5LVkaX3j8m5ctTS3KtvFFdhj4f/Jt09UOHnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B8DE268AFE; Thu, 20 Jun 2024 17:20:26 +0200 (CEST)
Date: Thu, 20 Jun 2024 17:20:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Hongbo Li <lihongbo22@huawei.com>, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	hch@lst.de
Subject: Re: bvec_iter.bi_sector -> loff_t?
Message-ID: <20240620152026.GA25908@lst.de>
References: <20240620132157.888559-1-lihongbo22@huawei.com> <bbf7lnl2d5sxdzqbv3jcn6gxmtnsnscakqmfdf6vj4fcs3nasx@zvjsxfwkavgm> <ZnQ0gdpcplp_-aw7@casper.infradead.org> <pfxno4kzdgk6imw7vt2wvpluybohbf6brka6tlx34lu2zbbuaz@khifgy2v2z5n> <ZnRBkr_7Ah8Hj-i-@casper.infradead.org> <0f74318e-2442-4d7d-b839-2277a40ca196@kernel.dk> <ZnRHi3Cfh_w7ZQa1@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnRHi3Cfh_w7ZQa1@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 20, 2024 at 04:15:23PM +0100, Matthew Wilcox wrote:
> > 
> > and have O_DIRECT with a 32-bit memory alignment work just fine, where
> > before it would EINVAL. The sector size memory alignment thing has
> > always been odd and never rooted in anything other than "oh let's just
> > require the whole combination of size/disk offset/alignment to be sector
> > based".
> 
> Oh, cool!  https://man7.org/linux/man-pages/man2/open.2.html
> doesn't know about this yet; is anyone working on updating it?

Just remember that there are two kinds of alignments:

 - the memory alignment, which Jens is talking about
 - the offset/size alignment, which is set by the LBA size

statx (optionally) exposes both in the stx_dio_mem_align and
stx_dio_offset_align fields, which are documented in the statx(2)
man page.  For network file systems like nfs there might be no
alignment requirements at all.

