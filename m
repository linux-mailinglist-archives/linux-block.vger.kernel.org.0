Return-Path: <linux-block+bounces-23224-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC5EAE8588
	for <lists+linux-block@lfdr.de>; Wed, 25 Jun 2025 16:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E4DB16E92C
	for <lists+linux-block@lfdr.de>; Wed, 25 Jun 2025 14:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B6F26656D;
	Wed, 25 Jun 2025 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkiHx1qr"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3728262FF6
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860203; cv=none; b=n7l/vzM7gNbE1GdPYFoOmoZTSrDF+jCycDBDYoaBMtsfG65GOi6Dwm/HS20GVAhp+fKMuPRqApN8FIMI6Ik2zbGqoUywOYwFtT2ZyQdn0dNf/vCpBQhSRu0fKY9qRkiikwVpCPTNdnfIhkf4TpVU9uQ8TNy0LKqVZOAXwffWKIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860203; c=relaxed/simple;
	bh=EaFhp6R32Jc8lRhiKE1xYpI6RCk3iahyylmWstMF/jI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dyle27vU75r+LYVkIOQyMWWSav90sFxKHi7SEvfQ4Rdu3Id0QuDRU1COhMrxjKWkBvHP1RCf8s38vV6NFv0Mvjf3CfTVGmgr3fT3GieS5jPE2mrPPNIEvVqBWOrChCmbkHeM3s3n+RKl1jHD/rhF4D2roeIrgOFWxe/NVTy3Udw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FkiHx1qr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750860201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2od9y3CugzjAAC7eCYpJrhMDJ9juTnwbD/Om22GZ6Ik=;
	b=FkiHx1qrmXW0yh1u+jHXOObEa3ZHmCKi9GcOupQZGQtNDx4K2dwHcOINOyECFsKdOniyLR
	tmGKRw/OPrc4h2aBzGZn3oLcn2iSkSJxReA6nWWrNSoemBOgBRxGVMEvUi0KzG7rEn+hcE
	G2zw8gD6y0BnODlIwo3jv6Xtj2JtNBs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-v0qaJX-ENq2oEn-3YNKcwQ-1; Wed,
 25 Jun 2025 10:03:17 -0400
X-MC-Unique: v0qaJX-ENq2oEn-3YNKcwQ-1
X-Mimecast-MFC-AGG-ID: v0qaJX-ENq2oEn-3YNKcwQ_1750860194
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0029D1955F56;
	Wed, 25 Jun 2025 14:03:14 +0000 (UTC)
Received: from [10.22.80.93] (unknown [10.22.80.93])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98AEA18003FC;
	Wed, 25 Jun 2025 14:03:11 +0000 (UTC)
Date: Wed, 25 Jun 2025 16:03:08 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
    dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>, 
    Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 3/4] dm: dm-crypt: Do not split write operations with
 zoned targets
In-Reply-To: <07d71ad1-a6de-474b-bee4-a64180284802@kernel.org>
Message-ID: <5c9898e1-3fae-d271-b0b8-a23371d22cb0@redhat.com>
References: <20250625055908.456235-1-dlemoal@kernel.org> <20250625055908.456235-4-dlemoal@kernel.org> <96831fd8-da1e-771f-7d19-8087d29f2af1@redhat.com> <07d71ad1-a6de-474b-bee4-a64180284802@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93



On Wed, 25 Jun 2025, Damien Le Moal wrote:

> On 6/25/25 19:19, Mikulas Patocka wrote:
> > 
> > 
> > On Wed, 25 Jun 2025, Damien Le Moal wrote:
> > 
> >> +	bool wrt = op_is_write(bio_op(bio));
> >> +
> >> +	if (wrt) {
> >> +		/*
> >> +		 * For zoned devices, splitting write operations creates the
> >> +		 * risk of deadlocking queue freeze operations with zone write
> >> +		 * plugging BIO work when the reminder of a split BIO is
> >> +		 * issued. So always allow the entire BIO to proceed.
> >> +		 */
> >> +		if (ti->emulate_zone_append)
> >> +			return bio_sectors(bio);
> > 
> > The overrun may still happen (if the user changes the dm table while some 
> > bio is in progress) and if it happens, you should terminate the bio with 
> > DM_MAPIO_KILL (like it was in my original patch).
> 
> I am confused... Overrun against what ? We are now completely ignoring the
> max_write_size limit so even if the user changes it, that will not affect the
> BIO processing. If you are referring to an overrun against the zoned device
> max_hw_sectors limit, it is not possible since changing limits is done with the
> DM device queue frozen, so we are guaranteed that there will be no BIO in-flight.
> 
> I am not sure about what kind of table change you are thinking of, but at the
> very least,  dm_table_supports_size_change() ensure that there cannot be any
> device size change for a zoned DM device. And given the above point about limits
> changes, I do not see how a table change can affect the BIO execution.
> 
> Do you have a specific example in mind ?

What happens if a bio that is larger than "BIO_MAX_VECS << PAGE_SHIFT" 
enters dm_split_and_process_bio? Where will the bio be split? I don't see 
it, but maybe I'm missing something.

Mikulas


