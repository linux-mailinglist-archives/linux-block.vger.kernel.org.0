Return-Path: <linux-block+bounces-18181-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590F0A59FDF
	for <lists+linux-block@lfdr.de>; Mon, 10 Mar 2025 18:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC591714B0
	for <lists+linux-block@lfdr.de>; Mon, 10 Mar 2025 17:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED462309B0;
	Mon, 10 Mar 2025 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISb5xf6u"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075C622B8A9
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628642; cv=none; b=tPyGYTg+0D17gYLlU6ZK3HPwUNC0n0hlqYuCXa2ujzNaMG8VHSjTN5AmDfpXCnmgKolhhK4xpdCXRzHokLlIvmRWB83+7BPfk+b4eYPtKnidQtMpyqLTt68V69e6Et1upLKh/1BPhL0BME12lnCeBOh+fClmd8y8xZKgt38xKas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628642; c=relaxed/simple;
	bh=DMlVsRFFcGi179g6mWmtNBJL5iKkSlKcXZbq086uPLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHuquAZSKXGV74YCpXyvIEOcjOrwVq15zm41SDMnd0L7NleFrEa5Xt4f/gdhL+pANL/o4NFFl78cFylXRnQ0i65QasaecvITk4L8mt6oSzQFy0niHq3EQ9ydRbyygkX6AC30GzMKnM5olojAKAf57BRRc8AvpCUzE0DfrBGZVfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ISb5xf6u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741628639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JWx4bqz//iE/SaEIoi+MBscTh2y5ceXZRIpga2fQldM=;
	b=ISb5xf6uzktV2qlII6CoZA53je8cv/Bk2UF5L2XVaWbloaM/OOlvoQUghwyVVzT4AHKlQQ
	1aFvMnkVlNJfAZPcvoDDQ2JoyxidSF9pGWPTYT5swx62MtUS7s4hgb6ugCwBGsEObhFFO3
	/0+K+iARWyXg/7DlkvS/r+4CzNv11CQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-TnHROTZqNtePG_p-qZVzdA-1; Mon,
 10 Mar 2025 13:43:56 -0400
X-MC-Unique: TnHROTZqNtePG_p-qZVzdA-1
X-Mimecast-MFC-AGG-ID: TnHROTZqNtePG_p-qZVzdA_1741628635
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6501E180025C;
	Mon, 10 Mar 2025 17:43:55 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCE7418009AE;
	Mon, 10 Mar 2025 17:43:54 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 52AHhrqh480929
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 13:43:53 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 52AHhrd3480928;
	Mon, 10 Mar 2025 13:43:53 -0400
Date: Mon, 10 Mar 2025 13:43:53 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 7/7] dm: allow devices to revalidate existing zones
Message-ID: <Z88k2RD6s5KpuxOD@redhat.com>
References: <20250309222904.449803-1-bmarzins@redhat.com>
 <20250309222904.449803-8-bmarzins@redhat.com>
 <7e0a1b47-3c96-4864-80b0-813f357845ad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e0a1b47-3c96-4864-80b0-813f357845ad@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Mar 10, 2025 at 08:59:26AM +0900, Damien Le Moal wrote:
> On 3/10/25 07:29, Benjamin Marzinski wrote:
> > dm_revalidate_zones() only allowed devices that had no zone resources
> > set up to call blk_revalidate_disk_zones(). If the device already had
> > zone resources, disk->nr_zones would always equal md->nr_zones so
> > dm_revalidate_zones() returned without doing any work. Instead, always
> > call blk_revalidate_disk_zones() if you are loading a new zoned table.
> > 
> > However, if the device emulates zone append operations and already has
> > zone append emulation resources, the table size cannot change when
> > loading a new table. Otherwise, all those resources will be garbage.
> > 
> > If emulated zone append operations are needed and the zone write pointer
> > offsets of the new table do not match those of the old table, writes to
> > the device will still fail. This patch allows users to safely grow and
> > shrink zone devices. But swapping arbitrary zoned tables will still not
> > work.
> 
> I do not think that this patch correctly address the shrinking of dm zoned
> device: blk_revalidate_disk_zones() will look at a smaller set of zones, which
> will leave already hashed zone write plugs outside of that new zone range in the
> disk zwplug hash table. disk_revalidate_zone_resources() does not cleanup and
> reallocate the hash table if the number of zones shrinks.

This is necessary for DM. There could be plugged bios that are on on
these no longer in-range zones.  They will obviously fail when they get
reissued, but we need to keep the plugs around so that they *do* get
reissued. A cleaner alternative would be to add code to immediately
error out all the plugged bios on shrinks, but I was trying to avoid
adding a bunch of code to deal with these cases (of course simply
disallowing them adds even less code).

-Ben

> For a physical drive,
> this can only happen if the drive is reformatted with some magic vendor unique
> command, which is why this was never implemented as that is not a valid
> production use case.
> 
> To make things simpler, I think we should allow growing/shrinking zoned device
> tables, and much less swapping tables between zoned and not-zoned. I am more
> inclined to avoid all these corner cases by simply not supporting table
> switching for zoned device. That would be much safer I think.
> No-one complained about any issue with table switching until now, which likely
> means that no-one is using this. So what about simply returning an error for
> table switching for a zoned device ? If someone request this support, we can
> revisit this.
> 
> > 
> > Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
> > ---
> >  drivers/md/dm-zone.c | 23 +++++++++++++----------
> >  1 file changed, 13 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> > index ac86011640c3..7e9ebeee7eac 100644
> > --- a/drivers/md/dm-zone.c
> > +++ b/drivers/md/dm-zone.c
> > @@ -164,16 +164,8 @@ int dm_revalidate_zones(struct dm_table *t, struct request_queue *q)
> >  	if (!get_capacity(disk))
> >  		return 0;
> >  
> > -	/* Revalidate only if something changed. */
> > -	if (!disk->nr_zones || disk->nr_zones != md->nr_zones) {
> > -		DMINFO("%s using %s zone append",
> > -		       disk->disk_name,
> > -		       queue_emulates_zone_append(q) ? "emulated" : "native");
> > -		md->nr_zones = 0;
> > -	}
> > -
> > -	if (md->nr_zones)
> > -		return 0;
> > +	DMINFO("%s using %s zone append", disk->disk_name,
> > +	       queue_emulates_zone_append(q) ? "emulated" : "native");
> >  
> >  	/*
> >  	 * Our table is not live yet. So the call to dm_get_live_table()
> > @@ -392,6 +384,17 @@ int dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q,
> >  		return 0;
> >  	}
> >  
> > +	/*
> > +	 * If the device needs zone append emulation, and the device already has
> > +	 * zone append emulation resources, make sure that the chunk_sectors
> > +	 * hasn't changed size. Otherwise those resources will be garbage.
> > +	 */
> > +	if (!lim->max_hw_zone_append_sectors && disk->zone_wplugs_hash &&
> > +	    q->limits.chunk_sectors != lim->chunk_sectors) {
> > +		DMERR("Cannot change zone size when swapping tables");
> > +		return -EINVAL;
> > +	}
> > +
> >  	/*
> >  	 * Warn once (when the capacity is not yet set) if the mapped device is
> >  	 * partially using zone resources of the target devices as that leads to
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research


