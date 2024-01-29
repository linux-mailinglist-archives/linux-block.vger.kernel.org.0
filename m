Return-Path: <linux-block+bounces-2491-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEAB83FD0F
	for <lists+linux-block@lfdr.de>; Mon, 29 Jan 2024 04:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569ED2852A9
	for <lists+linux-block@lfdr.de>; Mon, 29 Jan 2024 03:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D891DFE8;
	Mon, 29 Jan 2024 03:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUMWi6SH"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EC114F70
	for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 03:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706500684; cv=none; b=HcyKe0NGNtxFRlAfHxot3YH3cVdwCPnNDMXCFnBMIuqZS+vMEUrlFw/YA2P3JnH9FH9tYY7vumWggQXRFNmiDGBtCCheA8elJynWBNBKf9RdxkfhEnhpqAsE11d55f7N9smjL+aINhGd1dyQn1BNomUG6mUixaMMJ+OxMqy3W/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706500684; c=relaxed/simple;
	bh=KLl/UJhNY/3jG+0jMPjVgkjiPYawaw6fziPDlbDmeY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm3SUupuOWxyfhs3pjXw9slJ3UQMmoMBMxhVuMj7pkwWKQDcJCDbYEIdtTqH/LzOazWDaM4C65s4yaTswRKJxyJYjopzzj1lM+Mhi6QkdWZcH6AfsL0pla3SpmPx/9ReNvvrSmLj0+rDwGwbT48ympHFFQkiLS+g179f/hGu3Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LUMWi6SH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706500681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n/MxaP1kzI5B5Dd1Ifm/aTvDRwpaQpXdO3YcG9Kmi5A=;
	b=LUMWi6SH2jTu/5GMygdhZZBlVdA2ykULUd9hlWlJl64sl/wmBCyE3H1vGF5zr19ctYqI03
	kiO8bi+DpLYywrEaBofS+fQY/lsEBnz7ks2T+kKX53NpqJFJVFNPGNTP3Rl34s0mktWLEY
	KLuIWrEwLETaAvT1K/77tc6DHgqdU+k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-Rma6JoVROtOm-i8iAgSF3A-1; Sun, 28 Jan 2024 22:57:55 -0500
X-MC-Unique: Rma6JoVROtOm-i8iAgSF3A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E460683B86A;
	Mon, 29 Jan 2024 03:57:54 +0000 (UTC)
Received: from fedora (unknown [10.72.116.135])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F37F492BC6;
	Mon, 29 Jan 2024 03:57:48 +0000 (UTC)
Date: Mon, 29 Jan 2024 11:57:45 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Mike Snitzer <snitzer@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Don Dutile <ddutile@redhat.com>,
	Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, linux-block@vger.kernel.org,
	ming.lei@redhat.com
Subject: Re: [RFC PATCH] mm/readahead: readahead aggressively if read drops
 in willneed range
Message-ID: <ZbciOba1h3V9mmup@fedora>
References: <20240128142522.1524741-1-ming.lei@redhat.com>
 <ZbbPCQZdazF7s0_b@casper.infradead.org>
 <ZbbfXVg9FpWRUVDn@redhat.com>
 <ZbbvfFxcVgkwbhFv@casper.infradead.org>
 <CAH6w=aw_46Ker0w8HmSA41vUUDKGDGC3gxBFWAhd326+kEtrNg@mail.gmail.com>
 <ZbcDvTkeDKttPfJ4@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbcDvTkeDKttPfJ4@dread.disaster.area>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Mon, Jan 29, 2024 at 12:47:41PM +1100, Dave Chinner wrote:
> On Sun, Jan 28, 2024 at 07:39:49PM -0500, Mike Snitzer wrote:
> > On Sun, Jan 28, 2024 at 7:22 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Sun, Jan 28, 2024 at 06:12:29PM -0500, Mike Snitzer wrote:
> > > > On Sun, Jan 28 2024 at  5:02P -0500,
> > > > Matthew Wilcox <willy@infradead.org> wrote:
> > > Understood.  But ... the application is asking for as much readahead as
> > > possible, and the sysadmin has said "Don't readahead more than 64kB at
> > > a time".  So why will we not get a bug report in 1-15 years time saying
> > > "I put a limit on readahead and the kernel is ignoring it"?  I think
> > > typically we allow the sysadmin to override application requests,
> > > don't we?
> > 
> > The application isn't knowingly asking for readahead.  It is asking to
> > mmap the file (and reporter wants it done as quickly as possible..
> > like occurred before).
> 
> ... which we do within the constraints of the given configuration.
> 
> > This fix is comparable to Jens' commit 9491ae4aade6 ("mm: don't cap
> > request size based on read-ahead setting") -- same logic, just applied
> > to callchain that ends up using madvise(MADV_WILLNEED).
> 
> Not really. There is a difference between performing a synchronous
> read IO here that we must complete, compared to optimistic
> asynchronous read-ahead which we can fail or toss away without the
> user ever seeing the data the IO returned.

Yeah, the big readahead in this patch happens when user starts to read
over mmaped buffer instead of madvise().

> 
> We want required IO to be done in as few, larger IOs as possible,
> and not be limited by constraints placed on background optimistic
> IOs.
> 
> madvise(WILLNEED) is optimistic IO - there is no requirement that it
> complete the data reads successfully. If the data is actually
> required, we'll guarantee completion when the user accesses it, not
> when madvise() is called.  IOWs, madvise is async readahead, and so
> really should be constrained by readahead bounds and not user IO
> bounds.
> 
> We could change this behaviour for madvise of large ranges that we
> force into the page cache by ignoring device readahead bounds, but
> I'm not sure we want to do this in general.
> 
> Perhaps fadvise/madvise(willneed) can fiddle the file f_ra.ra_pages
> value in this situation to override the device limit for large
> ranges (for some definition of large - say 10x bdi->ra_pages) and
> restore it once the readahead operation is done. This would make it
> behave less like readahead and more like a user read from an IO
> perspective...

->ra_pages is just one hint, which is 128KB at default, and either
device or userspace can override it.

fadvise/madvise(willneed) already readahead bytes from bdi->io_pages which
is the max device sector size(often 10X of ->ra_pages), please see
force_page_cache_ra().

Follows the current report:

1) usersapce call madvise(willneed, 1G)

2) only the 1st part(size is from bdi->io_pages, suppose it is 2MB) is
readahead in madvise(willneed, 1G) since commit 6d2be915e589

3) the other parts(2M ~ 1G) is readahead by unit of bdi->ra_pages which is
set as 64KB by userspace when userspace reads the mmaped buffer, then
the whole application becomes slower.

This patch changes 3) to use bdi->io_pages as readahead unit.


Thanks,
Ming


