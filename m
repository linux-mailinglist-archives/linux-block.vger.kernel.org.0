Return-Path: <linux-block+bounces-5722-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D178978FC
	for <lists+linux-block@lfdr.de>; Wed,  3 Apr 2024 21:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74FA1F24A9D
	for <lists+linux-block@lfdr.de>; Wed,  3 Apr 2024 19:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6041552FF;
	Wed,  3 Apr 2024 19:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZqKks3rL"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3265153BED
	for <linux-block@vger.kernel.org>; Wed,  3 Apr 2024 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712172501; cv=none; b=rz0VFNzO4T9Z26pZbeJBN55c76HUK9hWCr/ofURVozkoyYFXGkcfuaP/TT/t6N0zgCXlKrmrVpISxmnh6RsF2HDn0TBT36lQZ7UU9aAltTN0BY3L8+Rs0xEhRiuh12JDHZ/OTk81/U6IXSZTiBa+a8HxlpeGwg9nRtqKj04yV20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712172501; c=relaxed/simple;
	bh=OwALeF5nmzCNK8ItJ0qnf5QvnZqP/OUnt88OHcvEQWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODOMtnwg1dyn4Pm9QWpwemWNxR1dLtRiyeeQow3degoCD41OF+w4UYkov9Qjdpf7ioIfWtanpmvlp2xh94dmE/QkuSlcUTJzIjkKMraibqwnc02ASWuK+02qkQb8krG+kAGyG07xhrS83o/bVFGXnWYzBpZ5VW2MWKpEzP27Mk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZqKks3rL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712172498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l8IjLsOFjETxQxIF6yNyiEpLyzn4wdWa1ib2f+sE/pY=;
	b=ZqKks3rLMWL9FdCjOSrkSGqDufkuOXFTPAZpKppBR8uxOACQJZ223tyhf7zNy3BbcrIusi
	BWpWu0eN3akvKpej2vrZS9JJh9dPgtXI79v/CCYEnMJjnuNT1ueZQZCD6dc0W9jayJuJ9w
	+fK2VX3ozASb+vik8xHgM9MEnFRujIk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-Ng9pcfDpMWumDdRch7iYhg-1; Wed,
 03 Apr 2024 15:28:16 -0400
X-MC-Unique: Ng9pcfDpMWumDdRch7iYhg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7D413800086;
	Wed,  3 Apr 2024 19:28:15 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.181])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BDC22024517;
	Wed,  3 Apr 2024 19:28:13 +0000 (UTC)
Date: Wed, 3 Apr 2024 14:28:07 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alasdair Kergon <agk@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
	David Teigland <teigland@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Joe Thornber <ejt@redhat.com>
Subject: Re: [RFC 4/9] dm: add llseek(SEEK_HOLE/SEEK_DATA) support
Message-ID: <usjvvltfh6lk4ummqh3qyvd4gp3vzbmclvbcp2zqjhdwrswv7f@mmjwmfoyavxg>
References: <20240328203910.2370087-1-stefanha@redhat.com>
 <20240328203910.2370087-5-stefanha@redhat.com>
 <6awt5gq36kzwhuobabtye5vhnexc6cufuamy4frymehuv57ky5@esel3f5naqyu>
 <20240403141147.GD2524049@fedora>
 <mi3yp4kel6junjk2corv4hi56s56pmwilnm2bb4gg2tbbvyq2n@zmzaqpdq2rlq>
 <20240403175838.GB2534900@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403175838.GB2534900@fedora>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Wed, Apr 03, 2024 at 01:58:38PM -0400, Stefan Hajnoczi wrote:
> > Yes, we want to ensure that:
> > 
> > off1 = lseek(fd, -1, SEEK_END);
> > off2 = off1 + 1; // == lseek(fd, 0, SEEK_END)
> > 
> > if off1 belongs to a data extent:
> >   - lseek(fd, off1, SEEK_DATA) == off1
> >   - lseek(fd, off1, SEEK_HOLE) == off2
> >   - lseek(fd, off2, SEEK_DATA) == -ENXIO
> >   - lseek(fd, off2, SEEK_HOLE) == -ENXIO
> 
> Agreed.
> 
> > if off1 belongs to a hole:
> >   - lseek(fd, off1, SEEK_DATA) == -ENXIO
> >   - lseek(fd, off1, SEEK_HOLE) == off1
> >   - lseek(fd, off2, SEEK_DATA) == -ENXIO
> >   - lseek(fd, off2, SEEK_HOLE) == -ENXIO
> 
> Agreed.
> 
...
> > 
> > That is, we can never pass in off2 (beyond the bounds of the table),
> > and when passing in off1, I think this interface may be easier to work
> > with in the intermediate layers, even though it differs from the
> > lseek() interface above.  For off1 in data:
> >   - dm_blk_do_seek_hole_data(dm, off1, SEEK_DATA) == off1
> >   - dm_blk_do_seek_hole_data(dm, off1, SEEK_HOLE) == off2
> > and for a hole:
> >   - dm_blk_do_seek_hole_data(dm, off1, SEEK_DATA) == off2
> >   - dm_blk_do_seek_hole_data(dm, off1, SEEK_HOLE) == off1
>

In the caller, we already need to know both off1 and off2 (that is,
the offset we are asking about, AND the offset at which the underlying
component ends its map at, since that is where we are then in charge
of whether to concatenate that with the next component or give the
overall result).

If we already guarantee that we never call into a lower layer with
off2 (because it was beyond bounds), then the only difference between
the two semantics is whether SEEK_DATA in a final hole returns -ENXIO
or off2; and it looks like we can do a conversion from either style
into the other.

So designing the caller logic, it looks like I would want:

if off1 >= EOF return -ENXIO (out of bounds)

while off1 < EOF:

  determine off2 of current lower region
  at this point, we are guaranteed off1 < off2
  we also know that off2 < EOF unless we are on last lower region
  call result=lower_layer(off1, SEEK_X)
  it is a bug if result is non-negative but < off1, or if result > off2

  if result == off1, return result (we are already in the right HOLE
  or DATA)

  if result > off1 and < off2, return result (we had to advance to get
  to the right region, but the right region was within the lower
  layer, and we don't need to inspect further layers)

  Note - the above two paragraphs can be collapsed into one: if result
  < off2, return result (the current subregion gave us an adequate
  answer)

  if result == off2, continue to the next region with off1=result (in
  first semantics, this is only possible for SEEK_HOLE for a lower
  region ending in data; in the second semantics, it is possible for
  either SEEK_HOLE or SEEK_DATA for a lower region ending in the type
  opposite of the request)

  if result == -ENXIO, continue to the next region by using off1=off2
  (only possible in the first semantics for SEEK_DATA on a lower
  region ending in a hole)

  any other result is necessarily a negative errno like -EIO; return it

if the loop completes without an early return, we are out of lower
regions, and we should be left with off1 == EOF.  Because we advanced,
we know now to:
return whence == SEEK_HOLE ? off1 : -ENXIO

> I'll take a look again starting from block/fops.c, through dm.c, and
> into dm-linear.c to see how to make things clearest. Although I would
> like to have the same semantics for every seek function, maybe in the
> end your suggestion will make the code clearer. Let's see.

Keeping lseek semantics may require a couple more lines of code
duplicated at each layer, but less maintainer headaches in the long
run of converting between slightly different semantics depending on
which layer you are at.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


