Return-Path: <linux-block+bounces-18284-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C09CA5DDF6
	for <lists+linux-block@lfdr.de>; Wed, 12 Mar 2025 14:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159861890C49
	for <lists+linux-block@lfdr.de>; Wed, 12 Mar 2025 13:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E390C22ACD1;
	Wed, 12 Mar 2025 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qUYF0vtQ"
X-Original-To: linux-block@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D5C248191
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786023; cv=none; b=bQQl+icSk92snrEC1wfa7R8vSFRyf0HhtMBAtorZg3B8vrytE6V6H1uhukFl9Y50Ge+r6wRT2icyXFn/26j34NbYu/ChffrV3awuMoI1a8YfgI1AaDhw3cLr8jYKEcV3+ZR5kDkSlwakhEWgLQAFUGtWZSmXYEryGa+90FulvB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786023; c=relaxed/simple;
	bh=vmPLawssG6OeY2s5RTWKuiub879ZSQW8pkQm4qKUL3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HziDb1YFlUBwwPjJUQQhfhB1cJt2g8kZXePKdsTL3IFIHnhWNgZgciVfvkCXKJSaOER6gHjDC2etxVx/xXT6Apv8mhov/cR5bFL1Xp/EoZsQgjFJA9J2nCfh6DXgxKnOWcvNiqn1EwTJCwpdVydk3pjdgrjKjZ8kn4jiAVgpZXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qUYF0vtQ; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 12 Mar 2025 09:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741786019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mq0FRlXHlhlA6kPYT2gBBHxaWA+LBidJU85rrBHb4G0=;
	b=qUYF0vtQsjZKc+axxpgc7Clq2EEZ0t2c3nn0TkLdyhbmJw7a6D9IWyEhCC8X3QW+5+dloh
	VaZG9ggVIo5myICYIAbkeOXD6N3JyvCdwy4PG1dd8HlqVIg/xEu1wTSmepDFDl9X3gQtsJ
	JFEbQ9hoX+QgumCCPVRcPX+/ECGIY7Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christoph Hellwig <hch@infradead.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Jooyung Han <jooyung@google.com>, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Heinz Mauelshagen <heinzm@redhat.com>, zkabelac@redhat.com, 
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
Message-ID: <2pwjcvwkfasiwq5cum63ytgurs6wqzhlh6r25amofjz74ykybi@ru2qpz7ug6eb>
References: <7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com>
 <Z8W1q6OYKIgnfauA@infradead.org>
 <b3caee06-c798-420e-f39f-f500b3ea68ca@redhat.com>
 <Z8XlvU0o3C5hAAaM@infradead.org>
 <8adb8df2-0c75-592d-bc3e-5609bb8de8d8@redhat.com>
 <Z8cE_4KSKHe5-J3e@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8cE_4KSKHe5-J3e@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 04, 2025 at 05:49:51AM -0800, Christoph Hellwig wrote:
> On Mon, Mar 03, 2025 at 10:03:42PM +0100, Mikulas Patocka wrote:
> > Swapfile does ahead of time mapping.
> 
> It does.  But it is:
> 
>  a) protected against modification by the S_SWAPFILE flag and checked
>     for full allocation first
>  b) something we want to get rid of because even with the above it is
>     rather problematic
> 
> > And I just looked at what swapfile 
> > does and copied the logic into dm-loop. If swapfile is not broken, how 
> > could dm-loop be broken?
> 
> As said above, swapfile works around the brokenness in ways that you
> can't.  And just blindly copying old code without understanding it is
> never a good idea.
> 
> > 
> > > > Would Jens Axboe agree to merge the dm-loop logic into the existing loop 
> > > > driver?
> > > 
> > > What logic?
> > 
> > The ahead-of-time mapping.
> 
> As said multiple times you can't do that.  The block mapping is
> file system private information.

We might be able to provide an API to _request_ a stable mapping to a
file - with proper synchronization, of course.

I don't recall anyone ever trying that, it'd replace all the weird
IF_SWAPFILE() hacks and be a safe way to do these kinds of performance
optimizations.

