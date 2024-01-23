Return-Path: <linux-block+bounces-2106-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E578385B4
	for <lists+linux-block@lfdr.de>; Tue, 23 Jan 2024 03:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A511F2AD1A
	for <lists+linux-block@lfdr.de>; Tue, 23 Jan 2024 02:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A453FA40;
	Tue, 23 Jan 2024 02:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpAzzm6c"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED2C7F4
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 02:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705978195; cv=none; b=ZLv3dwKd6MmIwiPBghOqYA6HOyEbmx6CEM4cnjHMqBWrjkOli767OGz1S1f21ED71GGzWxILph2pxT98CwZeLnfKmMEuut9I8x8NvEycrJtBXiMqC/TAuo7/GFfk0i0/n6haL5foboEknPrkY6ZJNee5CGvquONbqxZkIt+Ql5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705978195; c=relaxed/simple;
	bh=d7BWMF343mBTabYPriM1CL7mmXJ7zWSl3yWDLj6BsTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MO0Fc2C5mVeZfbZsKOdowumHKvZ3VQ96NeRy4Ao+vjUsOT5Ozt+GvRcLU28BXs+J7gD7Ta/2zpzinkABuW/9Q20af+6xPAyWLuPTiT9F+7+ua3Px/PNduFKClsUzjV8Whn8wd5n5ZBUHTbwEnDNuBxzSOFTavQKlUNN2k28pTjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpAzzm6c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705978192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TSjPEBBGKngXqT4kXanMD5uITl62jWsIl7MG+AM+XF4=;
	b=OpAzzm6cRK6clGqEO8YQ3JVhLQ8hLLyNZt7f01SID3hdbTIbpD1owMBGqGCTmJIdfMP2qB
	zA3lI5vfxJ86wKw55Fqd3RysOacLlQv4ANFL+jBMb5j0JYrJYvL+G8MxlmpwNsmtYts9On
	94kbpG701LHQBG7Ilueuup/A+1mK4QA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-B9Gkei2oOnSgxMOkE_jAfw-1; Mon, 22 Jan 2024 21:49:49 -0500
X-MC-Unique: B9Gkei2oOnSgxMOkE_jAfw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDE1E1013767;
	Tue, 23 Jan 2024 02:49:48 +0000 (UTC)
Received: from fedora (unknown [10.72.116.123])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 83736492BE2;
	Tue, 23 Jan 2024 02:49:44 +0000 (UTC)
Date: Tue, 23 Jan 2024 10:49:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Zdenek Kabelac <zkabelac@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Li Nan <linan666@huaweicloud.com>,
	Christoph Hellwig <hch@infradead.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	ming.lei@redhat.com
Subject: Re: [PATCH v3 0/4] brd discard patches
Message-ID: <Za8pRGZ9ZV3/jwCH@fedora>
References: <2dacc73-854-e71c-1746-99b017401c9a@redhat.com>
 <Zao1PNip1SRVB4Rp@fedora>
 <dc9e648b-6c5f-9642-8892-b48dbc893c6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc9e648b-6c5f-9642-8892-b48dbc893c6@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Mon, Jan 22, 2024 at 05:30:07PM +0100, Mikulas Patocka wrote:
> Hi
> 
> 
> On Fri, 19 Jan 2024, Ming Lei wrote:
> 
> > Hi Mikulas,
> > 
> > On Thu, Aug 10, 2023 at 12:07:07PM +0200, Mikulas Patocka wrote:
> > > Hi
> > > 
> > > Here I'm submitting the ramdisk discard patches for the next merge window. 
> > > If you want to make some more changes, please let me now.
> > 
> > brd discard is removed in f09a06a193d9 ("brd: remove discard support")
> > in 2017 because it is just driver private write_zero, and user can get same
> > result with fallocate(FALLOC_FL_ZERO_RANGE).
> > 
> > Also you only mentioned the motivation in V1 cover-letter:
> > 
> > https://lore.kernel.org/linux-block/alpine.LRH.2.02.2209151604410.13231@file01.intranet.prod.int.rdu2.redhat.com/
> > 
> > ```
> > Zdenek asked me to write it, because we use brd in the lvm2 testsuite and
> > it would be benefical to run the testsuite with discard enabled in order
> > to test discard handling.
> > ```
> > 
> > But we have lots of test disks with discard support: loop, scsi_debug,
> > null_blk, ublk, ..., so one requestion is that why brd discard is
> > a must for lvm2 testsuite to cover (lvm)discard handling?
> 
> We should ask Zdeněk Kabeláč about it - he is expert about the lvm2 
> testsuite.
> 
> > The reason why brd didn't support discard by freeing pages is writeback
> > deadlock risk, see:
> > 
> > commit f09a06a193d9 ("brd: remove discard support")
> > 
> > -static void discard_from_brd(struct brd_device *brd,
> > -                       sector_t sector, size_t n)
> > -{
> > -       while (n >= PAGE_SIZE) {
> > -               /*
> > -                * Don't want to actually discard pages here because
> > -                * re-allocating the pages can result in writeback
> > -                * deadlocks under heavy load.
> > -                */
> > -               if (0)
> > -                       brd_free_page(brd, sector);
> > -               else
> > -                       brd_zero_page(brd, sector);
> > -               sector += PAGE_SIZE >> SECTOR_SHIFT;
> > -               n -= PAGE_SIZE;
> > -       }
> > -}
> > 
> > However, you didn't mention how your patches address this potential
> > risk, care to document it? I can't find any related words about
> > this problem.
> 
> The writeback deadlock can happen even without discard - if the machine 
> runs out of memory while writing data to a ramdisk. But the probability is 
> increased when discard is used, because pages are freed and re-allocated 
> more often.

Yeah, I agree, what I meant is that this thing needs to be documented,
given discard is re-introduced, and the original deadlock comment isn't
addressed

> 
> Generally, the admin should make sure that the machine has enough 
> available memory when creating a ramdisk - then, the deadlock can't 
> happen.
> 
> Ramdisk has no limit on the number of allocated pages, so when it runs out 
> of memory, the oom killer will try to kill unrelated processes and the 
> machine will hang. If there is risk of overflowing the available memory, 
> the admin should use tmpfs instead of a ramdisk - tmpfs can be configured 
> with a limit and it can also swap out pages.
> 
> > BTW, your patches looks more complicated than the original removed
> > discard implementation. And if the above questions get addressed,
> > I am happy to provide review on the following patches.
> 
> My patches actually free the discarded pages. The original discard 
> implementation just overwrote the pages with zeroes without freeing them.

The original implementation supports to discard by freeing pages, and
it is just bypassed unconditionally by:

               if (0)
                       brd_free_page(brd, sector);
               else
                       brd_zero_page(brd, sector);

However, page could be freed by discard when it is being consumed in brd_do_bvec().

Maybe your patch of "brd: extend the rcu regions to cover read and write"
can be simplified a bit, such as:

- grab rcu read lock in brd_do_bvec()
- release the rcu read lock when allocating page via alloc_page() in
  brd_insert_page()
- change free page by rcu

Or avoid it by holding page reference:

- grabbing page reference in brd_lookup_page() if it is called from
copy_to_brd() or copy_from_brd(), and drop it after it is consumed


Thanks,
Ming


