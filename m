Return-Path: <linux-block+bounces-7668-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA238CD889
	for <lists+linux-block@lfdr.de>; Thu, 23 May 2024 18:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D38B1F2347C
	for <lists+linux-block@lfdr.de>; Thu, 23 May 2024 16:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F45F39ADB;
	Thu, 23 May 2024 16:38:28 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A136A18633
	for <linux-block@vger.kernel.org>; Thu, 23 May 2024 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482308; cv=none; b=RMi/F3SMiP9MK8HlaMPvjhxa7GxSZqkPuYXFflHa6zXWfKf81IBmCvy8vLpKwsyGmfVFiGoWwm1MiM4aouPxy0SPzM/Flo7ETGEQRDLoqt69xRnCJ+YxBTjC5BN+6HVr3CbTCEWA/TH2v9X2Ry4DFlqzYMsDQHx1A3ISk2l8JDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482308; c=relaxed/simple;
	bh=u9Wir9iPBM8gnarcCmvRVioqS8WnxFLE/plLFHpkQME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMi5IXjrICaJJTpEKhe6Y1AZKCBXSZpMNFCUFsPzJadCzpBJ0gayGCSCzxvkrfwYp95Dt1jLWLGaSXM0kYor0XoQvjFlqRaiie3XFURJKLNEnvqo8fFAPW4KH+Q7+pL04xtwK2+zVO452hSvr1I97KjXdkg76SwRIQnguzgBk4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-792b8cd0825so189920785a.0
        for <linux-block@vger.kernel.org>; Thu, 23 May 2024 09:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716482305; x=1717087105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIfLdj49wKy854TltAEAmYWURF6O/ckM40TlcEN9pF0=;
        b=wiVSDsOxDbAAm93CMrGcv5Mfvu3H2+Yd9Nn/v+ytF5VEsBh4N3t7kWf+j9nbGJqYlT
         SlF8rrg51CUbeo+T7IBWP+aa+wnDOYFS+D0Y+CyxPVQFOwwZLRtjw2cvuMB6kY53o2vi
         jrsWylr1ZT7lPvRyUAyGYIvQuwCByDZEYddJi0s0xA9+irO0h73cOlMhrJq5HlxvQ2wd
         sp6jGyHXKDX0A984S7aCeo5IykT83CdSvN0NCtcLkh3z3OiASJrao+HoD5X2r59ndfWl
         99Bm2nHsVFbPdH3a9V5NG5JeHnxHlljdoFUeE3WFYqkhjsYo4gZ2SbHMn6rGfFeeVRTW
         v67g==
X-Forwarded-Encrypted: i=1; AJvYcCUBPK6DQvmxH2gDcbOQKDWs9ikMgLOYm3q99DMgseMBAUKrtCvf4zoCCFyExvNnr2w1MgIuwVmGbyR6vgL4nJ8Pqslou9LY5CtMoWo=
X-Gm-Message-State: AOJu0Yx+Z8NJVTQ2dMgVVS2bL9fJgfXF/0/EfIcEuXjl3nBd4QXvf3WI
	5up8+l+tTEWzP5EqbQ003M5krVJMv8aQxky5u9XVszkYB4WcQ5hXV51170885qhIjpBE1MmcBcr
	InpWn7A==
X-Google-Smtp-Source: AGHT+IHImD2ZZ/UHBIoJzCXH67k5b003ufsWsa+fk2wDCEAso958XFH+V1+azPGCkeH/2m+Je7QZHA==
X-Received: by 2002:a05:620a:e0f:b0:792:a479:a149 with SMTP id af79cd13be357-794994a2f1bmr560698985a.55.1716482305616;
        Thu, 23 May 2024 09:38:25 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2fc466sm1502251785a.77.2024.05.23.09.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 09:38:25 -0700 (PDT)
Date: Thu, 23 May 2024 12:38:24 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	Marco Patalano <mpatalan@redhat.com>,
	Ewan Milne <emilne@redhat.com>, linux-raid@vger.kernel.org
Subject: Re: [PATCH for-6.10-rc1] block: fix blk_validate_limits() to
 properly handle stacked devices
Message-ID: <Zk9xAJur96MVX0cy@kernel.org>
References: <20240522025117.75568-1-snitzer@kernel.org>
 <20240522142458.GB7502@lst.de>
 <Zk4h-6f2M0XmraJV@kernel.org>
 <Zk6haNVa5JXxlOf1@fedora>
 <Zk9i7V2GRoHxBPRu@kernel.org>
 <20240523154435.GA1783@lst.de>
 <Zk9lYpthswuegMhn@kernel.org>
 <20240523155217.GA2346@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523155217.GA2346@lst.de>

On Thu, May 23, 2024 at 05:52:17PM +0200, Christoph Hellwig wrote:
> On Thu, May 23, 2024 at 11:48:50AM -0400, Mike Snitzer wrote:
> > 
> > Reality is, we have stacking block devices that regularly are _not_
> > accounted for when people make changes to block core queue_limits
> > code.  That is a serious problem.
> 
> Well, maybe we need to sure blktests covers this instead of either
> impossible to run on a stock distro (device_mapper tests) or always
> somehow hanging (lvm2 testsuite) separate tests..

Happy to see mptest get folded into blktests (its just bash code) --
but it doesn't reproduce for you so not a reliable safeguard.

The other testsuites aren't applicable to this particular issue, but I
don't disagree that the unicorn automated test frameworks used for DM
aren't robust enough.

> > Happy to see the need for the 'stacking' flag to go away in time but I
> > fail to see why it is "fundamentally wrong".
> 
> Because stacking limits should not in any way be built different.
> Both the stacking flag and your restoring of the value just hack
> around the problem instead of trying to address it.  Let's use a
> little time to sort this out properly instead of piling up hacks.

I have limited patience for queue_limits bugs given how long it took
us to stablize limits stacking (and how regressions keep happening).

All of the changes to render max_sectors and max_discard_sectors
unsettable directly (and only allow them being set in terms of an ever
growing array of overrides) were quite the big hammer. But yeah, it
is what it is.

I do appreciate your concern with me wanting limits stacking to be a
more pronounced first-class citizen in block core's queue_limits code.
I was trying to get the code back to a reliable state relative to
blk_stack_limits() et al -- for any underlying driver that might also
be blind to (ab)using max_user_sectors to steer blk_validate_limits().
I'm concerned such hacks are also fragile.

But in general I know we share the same goal, so I'll slow down and
yield to you to run with piecewise fixes where needed.  Will reply to
your latest patch now.

Mike

