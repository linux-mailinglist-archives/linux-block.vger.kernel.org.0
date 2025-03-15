Return-Path: <linux-block+bounces-18476-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9914A6306C
	for <lists+linux-block@lfdr.de>; Sat, 15 Mar 2025 18:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD18178DDD
	for <lists+linux-block@lfdr.de>; Sat, 15 Mar 2025 17:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC22A2E339D;
	Sat, 15 Mar 2025 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F78K0dby"
X-Original-To: linux-block@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C3E18C332
	for <linux-block@vger.kernel.org>; Sat, 15 Mar 2025 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742058087; cv=none; b=uQnJ9f/gr31QV/Gwa8tl7D47pC0PG/+84ub9/8KdVMeVsXlsfk2aspvt5YWkyl/M0zVMsZA4wM6EUEhf1BzldCMLt+HqtkNVkuTdZsmwNnJ43Id53sROudAuTzrzLwwf0eQSdY7bFLWEYhkFVdK5luHOxMQE52GvvoGF8GwJs4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742058087; c=relaxed/simple;
	bh=RX2QIt2I3uNGUzYy6vtEQQD0ErNiT4/lRw6nKjUqOJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpI5CP8OR7X5n5OvEwzXWp8ZyBoTHW3jjEp3tlJcv8VxpB07SmMuqOTqQ95LOzOT8a28/AU/tNHmYpbahjnBiYasg0AkUuuPPP+9JbIpXhuRyF1IW1dKH7Qdnd+jpQueW/6W3SrLywmEusvyzMhTWGcKKBEV7xpUedwsuvPMgSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F78K0dby; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 15 Mar 2025 13:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742058070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N7i+vl4BIFqgTL0Ha83gViM1xSIf+FshiCR1KLpb2bM=;
	b=F78K0dbys/geAj/X5EBLO9zyElLsJjj5foxoDrQNRQ/eUtQv53re2Fa+HW3lWjYOPmCKMw
	URCu0fEna4Yq7gS2qV5aj4KqXV1+s9oweLHHZga8l1A56OYS0b02m1apz+qmjeSnfqko35
	CQHcMRXx2uzt6jeNxaX1Iq55qPTPlMk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-bcachefs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 13/14] block: Allow REQ_FUA|REQ_READ
Message-ID: <abk74sbsvsuijqhohyenl2mecz6unmkhavkga55fxsld6m6ise@ncbz3xmjlymw>
References: <20250311201518.3573009-1-kent.overstreet@linux.dev>
 <20250311201518.3573009-14-kent.overstreet@linux.dev>
 <9db17620-4b93-4c01-b7f8-ecab83b12d0f@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9db17620-4b93-4c01-b7f8-ecab83b12d0f@kernel.dk>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 15, 2025 at 10:47:09AM -0600, Jens Axboe wrote:
> On 3/11/25 2:15 PM, Kent Overstreet wrote:
> > REQ_FUA|REQ_READ means "do a read that bypasses the controller cache",
> > the same as writes.
> > 
> > This is useful for when the filesystem gets a checksum error, it's
> > possible that a bit was flipped in the controller cache, and when we
> > retry we want to retry the entire IO, not just from cache.
> > 
> > The nvme driver already passes through REQ_FUA for reads, not just
> > writes, so disabling the warning is sufficient to start using it, and
> > bcachefs is implementing additional retries for checksum errors so can
> > immediately use it.
> 
> This one got effectively nak'ed by various folks here:
> 
> > Link: https://lore.kernel.org/linux-block/20250311133517.3095878-1-kent.overstreet@linux.dev/
> 
> yet it's part of this series and in linux-next? Hmm?

As I explained in that thread, they were only thinking about the caching
of writes.

That's not what we're concerned about; when we retry a read due to a
checksum error we do not want the previous _read_ cached.

