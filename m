Return-Path: <linux-block+bounces-5386-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAF5890D9B
	for <lists+linux-block@lfdr.de>; Thu, 28 Mar 2024 23:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7313B21325
	for <lists+linux-block@lfdr.de>; Thu, 28 Mar 2024 22:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA79613A3F1;
	Thu, 28 Mar 2024 22:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHuAJAYV"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BF313AD35
	for <linux-block@vger.kernel.org>; Thu, 28 Mar 2024 22:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711665011; cv=none; b=aZrx3PuAC2eUVmowSs/lEtWN6+NFM9ZhrmrmESKOeDMpwyfXPzOh9FEVTU65a04UomkLQ7oIlKn98el1hL8hA5z5UqlD/mccgZT77gIOns4cO8cE8a4k2quz8vevf9vn2cn9AAP+jW2CcTRuUUDj9/E48gg2ll+9uqYJSrppuoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711665011; c=relaxed/simple;
	bh=jNMwMosRuw1ECtOuwXay6HxPvPPRqcMN2lZS7RX/vm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTtPXMU71MVfvaN0HEYw93vHGVAjQFpM3kS9YC8JmbaqzR/6z8DW6W4xM7sW33lr7xt5d8Ps9H12BMKNp2iCwE8mggnB7u7EtbD0lfUlnuK7s0Npa+N09y8VxgU1uy4d0h4+Bclnt2MRyQIahpK1u/QswP301I8ttrUD3Nc5qh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cHuAJAYV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711665009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RLjxk2wc4jymH4AwmcERFao5SrhB3AXX6RO0DVW/6VI=;
	b=cHuAJAYVeHqItfsJtfxrSNVw2t3zgkwMRu6cgL6EX2rFwnuDxibGKMuXmdWy0z4R8O4wmH
	cseWXV2z3RPiBQ3DBabZOa364LpNbsouDDaZ85IeAJaDB9nNdaDDAoaVqqqA9AC3Ps+Bto
	DWfbw3jAnhpGVozw3VCBuaWf+Qa46Cg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-0VoqLDZMPAWlOIYT-scMbA-1; Thu, 28 Mar 2024 18:30:05 -0400
X-MC-Unique: 0VoqLDZMPAWlOIYT-scMbA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B5A7101CC6B;
	Thu, 28 Mar 2024 22:30:05 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.33])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D71B9200AFFC;
	Thu, 28 Mar 2024 22:30:03 +0000 (UTC)
Date: Thu, 28 Mar 2024 17:29:57 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alasdair Kergon <agk@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
	David Teigland <teigland@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Joe Thornber <ejt@redhat.com>
Subject: Re: [RFC 0/9] block: add llseek(SEEK_HOLE/SEEK_DATA) support
Message-ID: <tlgssdlmk4hgbtjo76qre5o72m3k5co5kewxah7iwsgm2nzv55@oyog6vhhxwnc>
References: <20240328203910.2370087-1-stefanha@redhat.com>
 <e2lcp3n5gpf7zmlpyn4nj7wsr36sffn23z5bmzlsghu6oapi5u@sdkcbpimi5is>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2lcp3n5gpf7zmlpyn4nj7wsr36sffn23z5bmzlsghu6oapi5u@sdkcbpimi5is>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Replying to myself,

On Thu, Mar 28, 2024 at 05:17:18PM -0500, Eric Blake wrote:
> On Thu, Mar 28, 2024 at 04:39:01PM -0400, Stefan Hajnoczi wrote:
> > cp(1) and backup tools use llseek(SEEK_HOLE/SEEK_DATA) to skip holes in files.
> 
> > 
> > In the block device world there are similar concepts to holes:
> > - SCSI has Logical Block Provisioning where the "mapped" state would be
> >   considered data and other states would be considered holes.
> 
> BIG caveat here: the SCSI spec does not necessarily guarantee that
> unmapped regions read as all zeroes; compare the difference between
> FALLOC_FL_ZERO_RANGE and FALLOC_FL_PUNCH_HOLE.  While lseek(SEEK_HOLE)
> on a regular file guarantees that future read() in that hole will see
> NUL bytes, I'm not sure whether we want to make that guarantee for
> block devices.  This may be yet another case where we might want to
> add new SEEK_* constants to the *seek() family of functions that lets
> the caller indicate whether they want offsets that are guaranteed to
> read as zero, vs. merely offsets that are not allocated but may or may
> not read as zero.  Skipping unallocated portions, even when you don't
> know if the contents reliably read as zero, is still a useful goal in
> some userspace programs.
> 
> > - NBD has NBD_CMD_BLOCK_STATUS for querying whether blocks are present.

The upstream NBD spec[1] took the time to represent two bits of
information per extent, _because_ of the knowledge that not all SCSI
devices with TRIM support actually guarantee a read of zeroes after
trimming.  That is, NBD chose to convey both:

NBD_STATE_HOLE: 1<<0 if region is unallocated, 0 if region has not been trimmed
NBD_STATE_ZERO: 1<<1 if region reads as zeroes, 0 if region contents might be nonzero

it is always safe to describe an extent as value 0 (both bits clear),
whether or not lseek(SEEK_DATA) returns the same offset; meanwhile,
traditional lseek(SEEK_HOLE) on filesystems generally translates to a
status of 3 (both bits set), but as it is (sometimes) possible to
determine that allocated data still reads as zero, or that unallocated
data may not necessarily read as zero, it is also possible to
implement NBD servers that don't report both bits in parallel.

If we are going to enhance llseek(2) to expose more information about
underlying block devices, possibly by adding more SEEK_ constants for
use in the entire family of *seek() API, it may be worth thinking
about whether it is worth userspace being able to query this
additional distinction between unallocated vs reads-as-zero.

[1] https://github.com/NetworkBlockDevice/nbd/blob/master/doc/proto.md#baseallocation-metadata-context

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


