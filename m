Return-Path: <linux-block+bounces-4790-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E422885F38
	for <lists+linux-block@lfdr.de>; Thu, 21 Mar 2024 18:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740E11C213E5
	for <lists+linux-block@lfdr.de>; Thu, 21 Mar 2024 17:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E43A13666E;
	Thu, 21 Mar 2024 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecFH4e79"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD211332B7
	for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711040511; cv=none; b=PUjTuWTcVtavNL9ZuQ23YzKkEMpg/RLiJhG0/jriHS7TAEyZlaObhyB8cHLRMIWUybbNY/ByxWkYSvALBZhisvZZVwIwczdsO683IU1oIwTKCZxXD5l9siv1/vawtJXynTgawXMfP4JsuA4IhEmNB0hec8WVwFl9ffUA45HwM6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711040511; c=relaxed/simple;
	bh=rI2zlEUIdfdoDPN9bKT55fECDTqGDJHYDO2COwILZw4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VT8XFwGn0PaNkzOPLZ+RLtplwBdeql50rDi9Z7eajuuDjyKQjVLyqWBcgwHDQXpI5WZdaoQgN2Iti28utbpUJltzQd1ydwGfndoIdGqCjmi28X+/jlwpYZLWYuY4IoKjt69bQsYT0Ph9rRa5jRAZAp2A5yhnQ5DSZVwCqmpvb18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecFH4e79; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711040508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6z3Ui1R9gRt1exubAt23J/56jSQjv0u0d+ss6rezH6k=;
	b=ecFH4e79jRcSnYFV6QRa2wGbJUDh91i0bZu49BqsmPNiO05FWUshOm1yOL+/bwlBIpTYEr
	j5Cjv3O/E2af1GaaVB4GEwjnFhYpWiH4mICC576wXVpdi6dzTDKQ3GfM9dJcw9hfqQ87p8
	iuBsQl+S3p4m4mHQhNfaveit4M5O5CA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-Sa-xBGS9PTadSWi7Hd1chQ-1; Thu,
 21 Mar 2024 13:01:42 -0400
X-MC-Unique: Sa-xBGS9PTadSWi7Hd1chQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03C1C282478E;
	Thu, 21 Mar 2024 17:01:42 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B4764492BDA;
	Thu, 21 Mar 2024 17:01:41 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 7011830BFECA; Thu, 21 Mar 2024 17:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 6E1F53FB4A;
	Thu, 21 Mar 2024 18:01:41 +0100 (CET)
Date: Thu, 21 Mar 2024 18:01:41 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Mike Snitzer <snitzer@kernel.org>
cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
    linux-block@vger.kernel.org, dm-devel@lists.linux.dev
Subject: Re: block: fail unaligned bio from submit_bio_noacct()
In-Reply-To: <ZfxVqkniO-6jFFH5@redhat.com>
Message-ID: <ea8a13c-ee40-47f9-a7be-17b84bd1f686@redhat.com>
References: <20240321131634.1009972-1-ming.lei@redhat.com> <ZfxVqkniO-6jFFH5@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10



On Thu, 21 Mar 2024, Mike Snitzer wrote:

> On Thu, Mar 21 2024 at  9:16P -0400,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > For any bio with data, its start sector and size have to be aligned with
> > the queue's logical block size.
> > 
> > This rule is obvious, but there is still user which may send unaligned
> > bio to block layer, and it is observed that dm-integrity can do that,
> > and cause double free of driver's dma meta buffer.
> > 
> > So failfast unaligned bio from submit_bio_noacct() for avoiding more
> > troubles.
> > 
> > Cc: Mikulas Patocka <mpatocka@redhat.com>
> > Cc: Mike Snitzer <snitzer@kernel.org>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-core.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index a16b5abdbbf5..b1a10187ef74 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -729,6 +729,20 @@ void submit_bio_noacct_nocheck(struct bio *bio)
> >  		__submit_bio_noacct(bio);
> >  }
> >  
> > +static bool bio_check_alignment(struct bio *bio, struct request_queue *q)
> > +{
> > +	unsigned int bs = q->limits.logical_block_size;
> > +	unsigned int size = bio->bi_iter.bi_size;
> > +
> > +	if (size & (bs - 1))
> > +		return false;
> > +
> > +	if (size && ((bio->bi_iter.bi_sector << SECTOR_SHIFT) & (bs - 1)))
> > +		return false;
> > +
> > +	return true;
> > +}

I would change it to

if (unlikely(((bi_iter.bi_sector | bio_sectors(bio)) & ((queue_logical_block_size(q) >> 9) - 1)) != 0))
	return false;

> >  /**
> >   * submit_bio_noacct - re-submit a bio to the block device layer for I/O
> >   * @bio:  The bio describing the location in memory and on the device.
> > @@ -780,6 +794,9 @@ void submit_bio_noacct(struct bio *bio)
> >  		}
> >  	}
> >  
> > +	if (WARN_ON_ONCE(!bio_check_alignment(bio, q)))
> > +		goto end_io;
> > +
> >  	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
> >  		bio_clear_polled(bio);
> >  
> > -- 
> > 2.41.0
> > 
> > 
> 
> This check would really help more quickly find buggy code, but it
> would be unfortunate for these extra checks to be required in
> production.  It feels like this is the type of check that should be
> wrapped by a debug CONFIG option (so only debug kernels have it).
> 
> Do we already have an appropriate CONFIG option to use?
> 
> Mike

But then, the system would crash with the config option being 'n' and 
return an error with the config option being 'y' - which would be 
unfortunate.

We could remove the check from the drivers and add it to the generic I/O 
path - this wouldn't add extra overhead.

Mikulas


