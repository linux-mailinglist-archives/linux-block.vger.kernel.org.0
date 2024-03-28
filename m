Return-Path: <linux-block+bounces-4844-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BE4886A0A
	for <lists+linux-block@lfdr.de>; Fri, 22 Mar 2024 11:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE2C62859C8
	for <lists+linux-block@lfdr.de>; Fri, 22 Mar 2024 10:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3F022EF5;
	Fri, 22 Mar 2024 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StDwZGwy"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126A118629
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711102594; cv=none; b=Zhti44qd74LeDcmWEQE4ajYUbPhOevjNBRtrPeT6Nr03K99bpazyOMl+Xf8T1+7vJUbY6WuU7VZVp2/iGqixjB2efv98loZurXrGssy3MDpvo2xbS402KaBHIWvkApzaV3Gq3X7lcJ0PM9YwJYzbQKmpmSbGHTsIcYyzlen5WtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711102594; c=relaxed/simple;
	bh=rmZLHL12c58LxK8RmzCpoTEEZ6vgU2KklkmgV3DS7Q0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=h6UfCS49BKNiOeWF6Hz2Al9+Mt8o4XeT3v9pWG+39MDZZ1PJnsGUg5wYOYpGHwex1G7sGPRaZgyhiyyn7SajaX9GF4dkKm2w3UApoOn0wtdbABBYEpOd6EBhpenmxuTUNpLGf8VLWn+1CgxYQQzwEdmiS4TBNhTb3XZNFtaJxWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=StDwZGwy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711102592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O0JUJuOfMh8CnijpLAcgbKqt0zNMKFJUJdCktWh8VBk=;
	b=StDwZGwyz1D0PimUdp1Aa8xrF10jJJ20A1Vof5iT7KWRbTDLfbvgNwWAnxT6JInEH53gIS
	3KTpC9y8z8V/cCDLeOHnuFRWpc2/ylSD1WeetnhgY50uxicMrP2UerOzbmQrptMY3g5JQh
	e03cM0FCisRGVs+j9gy1O6A9+Lw4DKg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-al3aDdPLMcujfZvRRN5lMA-1; Fri,
 22 Mar 2024 06:16:28 -0400
X-MC-Unique: al3aDdPLMcujfZvRRN5lMA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33E241C02CA0;
	Fri, 22 Mar 2024 10:16:28 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5963C492BC6;
	Fri, 22 Mar 2024 10:16:27 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 3065730BFECA; Fri, 22 Mar 2024 10:16:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 2EB313FB4B;
	Fri, 22 Mar 2024 11:16:27 +0100 (CET)
Date: Fri, 22 Mar 2024 11:16:27 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
cc: Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
    linux-block@vger.kernel.org, dm-devel@lists.linux.dev
Subject: Re: block: fail unaligned bio from submit_bio_noacct()
In-Reply-To: <ZfzoC/V07nExJ+0x@fedora>
Message-ID: <dd4e8b49-aa76-4b1b-3827-6650cb525226@redhat.com>
References: <20240321131634.1009972-1-ming.lei@redhat.com> <ZfxVqkniO-6jFFH5@redhat.com> <ea8a13c-ee40-47f9-a7be-17b84bd1f686@redhat.com> <ZfzoC/V07nExJ+0x@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9



On Fri, 22 Mar 2024, Ming Lei wrote:

> On Thu, Mar 21, 2024 at 06:01:41PM +0100, Mikulas Patocka wrote:
> > 
> > 
> > > > +static bool bio_check_alignment(struct bio *bio, struct request_queue *q)
> > > > +{
> > > > +	unsigned int bs = q->limits.logical_block_size;
> > > > +	unsigned int size = bio->bi_iter.bi_size;
> > > > +
> > > > +	if (size & (bs - 1))
> > > > +		return false;
> > > > +
> > > > +	if (size && ((bio->bi_iter.bi_sector << SECTOR_SHIFT) & (bs - 1)))
> > > > +		return false;
> > > > +
> > > > +	return true;
> > > > +}
> > 
> > I would change it to
> > 
> > if (unlikely(((bi_iter.bi_sector | bio_sectors(bio)) & ((queue_logical_block_size(q) >> 9) - 1)) != 0))
> > 	return false;
> 
> What if bio->bi_iter.bi_size isn't aligned with 512? The above check
> can't find that at all.

Could it happen that bi_size is not aligned to 512? I haven't seen such a 
bio yet. If you have seen it, say where was it created.

Mikulas


