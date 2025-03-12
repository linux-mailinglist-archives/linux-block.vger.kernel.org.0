Return-Path: <linux-block+bounces-18317-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4C1A5E185
	for <lists+linux-block@lfdr.de>; Wed, 12 Mar 2025 17:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333B03A4FDA
	for <lists+linux-block@lfdr.de>; Wed, 12 Mar 2025 16:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFAE70809;
	Wed, 12 Mar 2025 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KK8IHyHR"
X-Original-To: linux-block@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335FB1DFF7
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795793; cv=none; b=YxTPDEt0yLmPSt96dHpVYDkfCmhzomJZGFcCFEOQWKCTX4Sg8UfC+eYB7VDtHlWv2gnSZoh8/wXXG8zxpotgOY9fZPZj5pbz5spwc8xrTZ4f4OM1HXxWN2dS0FeU0f66de2AXCypPpvwzkOggkOuoyrZHpWTw+OQk46rcrFOXaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795793; c=relaxed/simple;
	bh=zlPYJmg6XIKKvyi9auq/yznc1WWM0rXVGDpiDoNVdhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=se1yWcI7mojXr197yd8fMjdQh0RnR417qa4F31AC99AaWj8SGrYzV6Oq+OdyxvNISSze+Ni7G5UgQV1UBtQuFPkaFwHJ6tTC4basRRUUR721Nn/ztrhH2ithsGRaMB+TsAZKgJI/6cuhYxxhx59SJ5U8ln/mJGuFAAo5YfG0bHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KK8IHyHR; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 12 Mar 2025 12:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741795788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kA6L/HzWXWC5BJ9yaTfNuDk1v/yp7mCPLWYFlG4K5hU=;
	b=KK8IHyHRBJCGhTXK3cs+1+j/J3Sy9bKUaBWAcn8OeU0hpw2OF9LvA678XMXpG4MQrvVD0A
	gao+qZLvQEbSbfd9y0EQFoJbqd/WfqI9AXLMXRmGfa4Y6KaWnUVAavBDBItOxszNYrHyaC
	BjaYb7jjB4QKIP8efStRgQTgK0bHwFM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christoph Hellwig <hch@infradead.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Jooyung Han <jooyung@google.com>, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Heinz Mauelshagen <heinzm@redhat.com>, zkabelac@redhat.com, 
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
Message-ID: <c7znin3sdyzyggpnmwexlnlzhhyzwmrz5l7kyfr3wpszrfhvlt@q74rkjdjz53i>
References: <7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com>
 <Z8W1q6OYKIgnfauA@infradead.org>
 <b3caee06-c798-420e-f39f-f500b3ea68ca@redhat.com>
 <Z8XlvU0o3C5hAAaM@infradead.org>
 <8adb8df2-0c75-592d-bc3e-5609bb8de8d8@redhat.com>
 <Z8cE_4KSKHe5-J3e@infradead.org>
 <2pwjcvwkfasiwq5cum63ytgurs6wqzhlh6r25amofjz74ykybi@ru2qpz7ug6eb>
 <Z9GYGyjJcXLvtDfv@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9GYGyjJcXLvtDfv@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 12, 2025 at 07:20:11AM -0700, Christoph Hellwig wrote:
> On Wed, Mar 12, 2025 at 09:26:55AM -0400, Kent Overstreet wrote:
> > We might be able to provide an API to _request_ a stable mapping to a
> > file - with proper synchronization, of course.
> 
> We already have that with the pNFS layouts.

Good point, maybe Mikulas wants to look at that if they care about
squeezing every iops...

> 
> > I don't recall anyone ever trying that, it'd replace all the weird
> > IF_SWAPFILE() hacks and be a safe way to do these kinds of performance
> > optimizations.
> 
> IS_SWAPFILE isn't going way, as can't allow other writers to it.
> Also asides from the that the layouts are fairly complex.
> 
> The right way ahead for swap is to literally just treat it as a slightly
> special case of direct I/o that is allowed to IS_SWAPFILE files.  We
> can safely do writeback to file backed folios under memory pressure,
> so we can also go through the normal file system path.

Yeah, and that gets us e.g. encrypted swap on bcachefs

