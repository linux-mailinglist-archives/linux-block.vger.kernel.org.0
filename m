Return-Path: <linux-block+bounces-6845-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FA78B9BF5
	for <lists+linux-block@lfdr.de>; Thu,  2 May 2024 16:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769671F21F90
	for <lists+linux-block@lfdr.de>; Thu,  2 May 2024 14:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50984C8F3;
	Thu,  2 May 2024 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="KGc9K55g"
X-Original-To: linux-block@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E161F13C67F
	for <linux-block@vger.kernel.org>; Thu,  2 May 2024 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714658531; cv=none; b=ivkVaxWMQq+K117MWSCVj1f+Mr84ywbYlwitnE1YiGcUlLEwk5bIWSRJIg4e7n4gwrBrAuI5ndUOR55AuZYi2gmcaPpsgoqDQ+W5VatnyeR5F/r1rYLH6MZ+0RDYFONVtiBL3Uc+KmBFLPPic5JY3gQlhMX4Du+fz7LDcTFfhf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714658531; c=relaxed/simple;
	bh=ZM9T6R7S8K4p4/89PZv5xZTw1drdCyPBkdOVr0adZ8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBsLFIJ5jPo+U1PUaAILa5b1b2rhfTwiIBSEHA/btp7r7u1FZJwievJv3/Qf5MxT89ytzVXwtDcFETnYdBEvBzDgJpoRDw1fM0kCuteKob7Gh1Ni8y0ihcT0WFU4Omzlk8uaY1Fq0xH1NNTWlblj8NOZUuPENsrlw6EfaoCYmzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=KGc9K55g; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-33.bstnma.fios.verizon.net [108.26.156.33])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 442E1dJE031567
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 10:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1714658503; bh=duxA4e5bb2slFBM2DuV5/NyEGX/IrYnPRt/udTa/gnw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=KGc9K55g0J4WVV/KLX4hsaE3/oSNDDGJwmS0Rs/KFzAk8GdB4T/AEfbm/YQcJDHnX
	 fDd94sXS8thWudS+1ULE3+F8bKufScI1dIB/ksSscPPcnc0XefU+VZW4Xrf1XdrFWp
	 Ku4br1qsVqQK/TOhJADvBP5w/rGdTcjaBBnnzLKDM1xdlDETRmCTljdU1Ll/qk/Ees
	 LW/oeWx5mx+R60ds7qEqnQkYeoFqbZPHYdQvUthiJUtYqXsQusulyUypTXSktVfG7h
	 cOaPp1JlUucWJ2bXAaD40zjdvnBCO6euqj3ezMzKEjkeaX3xoWC0MZP0gpA2bLXali
	 B9iOdYYMTG8qw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id CE6E415C02BB; Thu,  2 May 2024 10:01:39 -0400 (EDT)
Date: Thu, 2 May 2024 10:01:39 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeremy Bongio <bongiojp@gmail.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, Jeremy Bongio <jbongio@google.com>
Subject: Re: [RFC PATCH 1/1] Remove buffered failover for ext4 and block fops
 direct writes.
Message-ID: <20240502140139.GE1743554@mit.edu>
References: <20240501231533.3128797-1-bongiojp@gmail.com>
 <20240501231533.3128797-2-bongiojp@gmail.com>
 <ZjMoYkUsQnd33mXm@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjMoYkUsQnd33mXm@infradead.org>

On Wed, May 01, 2024 at 10:45:06PM -0700, Christoph Hellwig wrote:
> 
> Please don't combine ext4 and block changes in a single patch.  Please
> also explain why you want to change things.
> 
> AFAIK this is simply the historic behavior of the old direct I/O code
> that's been around forever.  I think the XFS semantics make a lot more
> sense, but people might rely on this one way or another.

I agree that the ext4 and block I/O change should be split into two
separate patches.

As for the rest, we discussed this at the weekly ext4 conference call
last week and at the, I had indicated that this was indeed the
historical Direct I/O behavior.  Darrick mentioned that XFS is only
falling back to buffered I/O in one circumstances, which is when there
is direct I/O to a file which is reflinked, which since the
application wouldn't know that this might be the case, falling back to
buffered I/O was the best of not-so-great alternatives.

It might be a good idea if we could agree on a unfied set of standard
semantics for Direct I/O, including what should happen if there is an
I/O error in the middle of a DIO request; should the kernel return a
short write?  Should it silently fallback to buffered I/O?  Given that
XFS has had a fairly strict "never fall back to buffered" practice,
and there haven't been users screaming bloody murder, perhaps it is
time that we can leave the old historical Direct I/O semantics behind,
and we should just be more strict.

Ext4 can make a decision about what to do on its own, but if we want
to unify behavior across all file systems and all of the direct I/O
implications in the kernels, then this is a discussion that would need
to take place on linux-fsdevel, linux-block, and/or LSF/MM.

With that context, what are folks' thiking about the proposal that we
unify Linux's Direct I/O semantics?  I think it would be good if it
was (a) clearly documented, and (b) not be surprising for userspace
application which they switch beteween file systems, or between a file
system and a raw block device.  (Which for certain enterprise
database, is mostly only use for benchmarketing, on the back cover of
Business Week, but sometimes there might be users who decide to
squeeze that last 1% of performance by going to a raw block device,
and it might be nice if they see the same behaviour when they make
that change.)

Cheers,

					- Ted

