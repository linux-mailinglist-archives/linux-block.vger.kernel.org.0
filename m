Return-Path: <linux-block+bounces-7543-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AE18CA122
	for <lists+linux-block@lfdr.de>; Mon, 20 May 2024 19:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38A01F214EA
	for <lists+linux-block@lfdr.de>; Mon, 20 May 2024 17:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A458137C20;
	Mon, 20 May 2024 17:17:51 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5B2135A71
	for <linux-block@vger.kernel.org>; Mon, 20 May 2024 17:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716225471; cv=none; b=UyBA/mPgd6unjJhfIU4Uq676qsOzh7RzJLfdcRrpfDopzeZyFWmauRK7lwTyNTXj6Ny77zQjffRMxWE4IER1zlnNr2SNc9JhiSPx9+0I0+izJVofRvjPfXOmve04VG66OV891hzW+2GO1L54hW8iKf0GSBaWlB5/vvhWVIV6u2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716225471; c=relaxed/simple;
	bh=8Ey01W3TWy3+gnWNHRxVsreKBzXGp/Fzi06llfcCTYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jimGcoMNqKf8EFKr/2ik17VMfsRWB+my85s/aAGwcnN0+iKUKWma7kzy5tqXiw/yTH8oBRjSwT9nW/CZu40ZxVR2RheJ2MWLV9VzXe/ems/yQAnIIWMNLt4EY3sZgFD6bdqUt2MwbsecxvMGcQo3ZJe+fXu6OphTugDm4eAVrjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b53bb4bebaso230370eaf.0
        for <linux-block@vger.kernel.org>; Mon, 20 May 2024 10:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716225469; x=1716830269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9qfg2yY+aMu5/VkyPP4w1KWCmXu9VzHzd1XZC4MYQM=;
        b=Ttzxb+pPr9EsellCZkWhUAL4/r2uQsFv8miYmJhTruEnuYRrLz9XiV89zEVzN+dIrg
         NbE1psRvLBubWbzXkraijNDkkN+pa7pK2upMsSJ1e3Pt6jL2Z940bWvVCR7AHIaidmoB
         Pa47Ct/IupUrfB5i+MvOIEW1LDxHljbBCaSr+XB8L2adtaxaL1RKLNs4gMBWhDq7J3SF
         vMqLVPKAPH5gfXZ3/SMfg9cyrd/LPASia7NnWrk0Nl/LWsJzAgSFIQM5I+4zpdcOGCKp
         2ageYFYZAyyjLZ7KCu5CQMo8QHLSMXUeZOA4eirxQEMzzJMr5gq+JPO5yaRsfbLN0iQn
         KabA==
X-Forwarded-Encrypted: i=1; AJvYcCW68Z7Wy6hXfQg7KfIf9k2uSAEDDF77uD5vs/Y4u84xXw3/zIVB7RatzB+VGDXnbMFllfWqOuzYIPESDDeIe7N4l2a8ada1ff8yBuU=
X-Gm-Message-State: AOJu0YxXiH9K/CO49316ue65LQSLHXZDRazlCtz7WCjx28cen4+lblK1
	e8HNRRZPjltl8iHHev8fBPNarFLanKeIt6SXCflYM2+Mu1FW9w3JQzkJVaOUryA=
X-Google-Smtp-Source: AGHT+IGOQ4OQGxkNfsshJaLNjEfIH76m2IGPnMddp7gaSVxhNmrS/aA7yI7pZ70kNwz5B3/MuQaylg==
X-Received: by 2002:a05:6359:5a8c:b0:192:4bf2:a397 with SMTP id e5c5f4694b2df-193bb64d50cmr2918493755d.17.1716225468732;
        Mon, 20 May 2024 10:17:48 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e0bf64844sm121731321cf.62.2024.05.20.10.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 10:17:48 -0700 (PDT)
Date: Mon, 20 May 2024 13:17:46 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Theodore Ts'o <tytso@mit.edu>, dm-devel@lists.linux.dev,
	fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	regressions@lists.linux.dev, linux-block@vger.kernel.org
Subject: Re: dm: use queue_limits_set
Message-ID: <ZkuFuqo3dNw8bOA2@kernel.org>
References: <20240518022646.GA450709@mit.edu>
 <ZkmIpCRaZE0237OH@kernel.org>
 <ZkmRKPfPeX3c138f@kernel.org>
 <20240520150653.GA32461@lst.de>
 <ZktuojMrQWH9MQJO@kernel.org>
 <20240520154425.GB1104@lst.de>
 <ZktyTYKySaauFcQT@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZktyTYKySaauFcQT@kernel.org>

[replying for completeness to explain what I think is happening for
the issue Ted reported]

On Mon, May 20, 2024 at 11:54:53AM -0400, Mike Snitzer wrote:
> On Mon, May 20, 2024 at 05:44:25PM +0200, Christoph Hellwig wrote:
> > On Mon, May 20, 2024 at 11:39:14AM -0400, Mike Snitzer wrote:
> > > That's fair.  My criticism was more about having to fix up DM targets
> > > to cope with the new normal of max_discard_sectors being set as a
> > > function of max_hw_discard_sectors and max_user_discard_sectors.
> > > 
> > > With stacked devices in particular it is _very_ hard for the user to
> > > know their exerting control over a max discard limit is correct.
> > 
> > The user forcing a limit is always very sketchy, which is why I'm
> > not a fan of it.
> > 
> > > Yeah, but my concern is that if a user sets a value that is too low
> > > it'll break targets like DM thinp (which Ted reported).  So forcibly
> > > setting both to indirectly set the required max_discard_sectors seems
> > > necessary.

Could also be that a user sets the max discard too large (e.g. larger
than thinp's BIO_PRISON_MAX_RANGE).

> > Dm-think requiring a minimum discard size is a rather odd requirement.
> > Is this just a debug asswert, or is there a real technical reason
> > for it?  If so we can introduce a now to force a minimum size or
> > disable user setting the value entirely. 
> 
> thinp's discard implementation is constrained by the dm-bio-prison's
> constraints.  One of the requirements of dm-bio-prison is that a
> discard not exceed BIO_PRISON_MAX_RANGE.
> 
> My previous reply is a reasonible way to ensure best effort to respect
> a users request but that takes into account the driver provided
> discard_granularity.  It'll force suboptimal (too small) discards be
> issued but at least they'll cover a full thinp block.

Given below, this isn't at the heart of the issue Ted reported.  So
the change to ensure max_discard_sectors is a factor of
discard_granularity, while worthwhile, isn't critical to fixing the
reported issue.

> > > diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> > > index 4793ad2aa1f7..c196f39579af 100644
> > > --- a/drivers/md/dm-thin.c
> > > +++ b/drivers/md/dm-thin.c
> > > @@ -4497,7 +4499,8 @@ static void thin_io_hints(struct dm_target *ti, struct queue_limits *limits)
> > >  
> > >  	if (pool->pf.discard_enabled) {
> > >  		limits->discard_granularity = pool->sectors_per_block << SECTOR_SHIFT;
> > > -		limits->max_discard_sectors = pool->sectors_per_block * BIO_PRISON_MAX_RANGE;
> > > +		limits->max_hw_discard_sectors = limits->max_user_discard_sectors =
> > > +			pool->sectors_per_block * BIO_PRISON_MAX_RANGE;
> > >  	}
> > 
> > Drivers really have no business setting max_user_discard_sector,
> > the whole point of the field is to separate device/driver capabilities
> > from user policy.  So if dm-think really has no way of handling
> > smaller discards, we need to ensure they can't be set.
> 
> It can handle smaller so long as they respect discard_granularity.
> 
> > I'm also kinda curious what actually sets a user limit in Ted's case
> > as that feels weird.
> 
> I agree, not sure... maybe the fstests is using the knob?

Doubt there was anything in fstests setting max discard user limit
(max_user_discard_sectors) in Ted's case. blk_set_stacking_limits()
sets max_user_discard_sectors to UINT_MAX, so given the use of
min(lim->max_hw_discard_sectors, lim->max_user_discard_sectors) I
suspect blk_stack_limits() stacks up max_discard_sectors to match the
underlying storage's max_hw_discard_sectors.

And max_hw_discard_sectors exceeds BIO_PRISON_MAX_RANGE, resulting in
dm_cell_key_has_valid_range() triggering on:
WARN_ON_ONCE(key->block_end - key->block_begin > BIO_PRISON_MAX_RANGE)

Mike

