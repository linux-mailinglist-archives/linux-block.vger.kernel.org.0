Return-Path: <linux-block+bounces-4810-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECBB8862EF
	for <lists+linux-block@lfdr.de>; Thu, 21 Mar 2024 23:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB11281138
	for <lists+linux-block@lfdr.de>; Thu, 21 Mar 2024 22:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A66135A55;
	Thu, 21 Mar 2024 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aKETLpDt"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3CD132489;
	Thu, 21 Mar 2024 22:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058861; cv=none; b=Pj+N9c+tLb4R0O8o3qTvdvSo71ADLNZZV72+4dyFR+0R4ONGpeC6ZHlPRdlL+TuH37NirqbYRl8nHxZVxiKrUzINenR6GXAqj6CoynJ1cRvxRshWhk+pUE5n/qPh6ImFkxrmywYz2oqqcYdwaqyMPnHrAW4C+oo3774Cu4dcvhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058861; c=relaxed/simple;
	bh=0/PyoRJiNG0lXwOlRCqHjKpbFIs9KJZ1c7t/9Ifk3oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9RP+XdsoqFpa3tI6pZm1PFTrgOIele/+x/aHVZn3iAt99xr9WnAfqBvdWumA2m1bA+4i/rqvzEjEDQKtLSb4GNdVC7ZeAyMcqIVLRDvWPvQR9lN8qoOVGC7ueevMsxlbPuOByQ0ZQWjYfd433lnPKa/t5qSvT0C4EivkmNvLWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aKETLpDt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JWESeA7aSgA5nIcGmeWSayQGds3VE09pp/wUgycxUB4=; b=aKETLpDtKENs6Pf6A1oh9vqtkq
	tSyH3y1uw9wbWQDUme0NosZemlLivkoR/yvwGBoLNFKNBL2QwSYDIwFRC70NMBABmofHa2b8+aGRm
	xLbnoY+mC6CtM187R1YCGDDk+aOP2mHReohrhovd6dWCipfBM2618ooYC143xg+QuKK6iCLs0Wo+4
	C6SN4IQ1OOuC5ppw1v4n9tXlBTROEu1izrQBKWU4Zn51LXhY0o2yIBohCYDVWQ8W9F6AS68ybwADJ
	8WUssF626ulv/qLK7qVO8PR41XnsCZr6JQSFZH8t9qqkrVbIj++FprTmaCmqaGlSPIUtLCEEN0qSU
	d4Qf2N8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnQZW-00000004q8R-1RHS;
	Thu, 21 Mar 2024 22:07:38 +0000
Date: Thu, 21 Mar 2024 15:07:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>, Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev
Subject: Re: block: fail unaligned bio from submit_bio_noacct()
Message-ID: <ZfyvqmslFn19vgdG@infradead.org>
References: <20240321131634.1009972-1-ming.lei@redhat.com>
 <ZfxVqkniO-6jFFH5@redhat.com>
 <ea8a13c-ee40-47f9-a7be-17b84bd1f686@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea8a13c-ee40-47f9-a7be-17b84bd1f686@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Mar 21, 2024 at 06:01:41PM +0100, Mikulas Patocka wrote:
> But then, the system would crash with the config option being 'n' and 
> return an error with the config option being 'y' - which would be 
> unfortunate.
> 
> We could remove the check from the drivers and add it to the generic I/O 
> path - this wouldn't add extra overhead.

Agreed.  This is a pretty cheap check, and I'd rather have it all the
time instead of being duplicated in various drivers, just like we do
a lot of other sanity checking in submit_bio.


