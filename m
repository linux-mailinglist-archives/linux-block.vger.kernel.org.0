Return-Path: <linux-block+bounces-23238-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F19AE89EB
	for <lists+linux-block@lfdr.de>; Wed, 25 Jun 2025 18:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479C318853D1
	for <lists+linux-block@lfdr.de>; Wed, 25 Jun 2025 16:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B12255E23;
	Wed, 25 Jun 2025 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LuSng/wV"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA296381C4
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869215; cv=none; b=NKzKAaDr6uOw/QrdjQrpUs6v5INSHZxcb1G+IPSKxhJsL6nuPD0G9ANwK2yKcFRVb1B1mXHxCPUGopDsIqrZmbbs83SPzv//P18Phbh3LdoIwkFViMaYD3VLkn8oLDeXiwSNllDK6QjBLndRPY2LxxYsLqLtCW1YcggMYE7U9i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869215; c=relaxed/simple;
	bh=w8HamvXIfF70c1Jlwsqol6xTtkLLfkKWH8FsKxJjU2o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Nn9tSd7vxg3cng5Wjg4GJ1uHAOWqX/ms1o2Fb3NZ8aaaFqDezmXdYV5bxVLP6Xx0oekMAp3/ZOXyPFzASh3n93kby6SlBVCPxCWNhLcqBB5VoV8iNn46un9OgLJJa1dU3lnAGl9M1sdZ/uvD96qXdqE+RkWvX79PPykDZCpCKUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LuSng/wV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750869211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=amCEsrQtfa1hXwyWRd1ZdiWEeRbV3sK8Ec08uUHcKsw=;
	b=LuSng/wVCZn+FxL9q84eEIjPbXuW8ArcmmkzADC2nYOZz/RHLRDVXFsmM4l8xWvb7sEXnz
	Ny3Etqe4vphzo3EMD7O9cPAaL+Mhpzdh6q1G73q7KyO6G7v7R52xr0gHxubc1pAfU8j7fb
	IeVz4Ak+73OqGFtaVKt/ppy6SDW0Zsw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-4k-j-2ifMhKxIGTS_sbVDg-1; Wed,
 25 Jun 2025 12:33:27 -0400
X-MC-Unique: 4k-j-2ifMhKxIGTS_sbVDg-1
X-Mimecast-MFC-AGG-ID: 4k-j-2ifMhKxIGTS_sbVDg_1750869206
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D11318862E6;
	Wed, 25 Jun 2025 16:33:10 +0000 (UTC)
Received: from [10.22.80.93] (unknown [10.22.80.93])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E95EA195E761;
	Wed, 25 Jun 2025 16:33:07 +0000 (UTC)
Date: Wed, 25 Jun 2025 18:33:03 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
    dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>, 
    Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 3/4] dm: dm-crypt: Do not split write operations with
 zoned targets
In-Reply-To: <40690cc0-e941-4db1-904c-a5d60718d852@kernel.org>
Message-ID: <917d9f55-6ee2-c5c7-b6a5-fe188ad42590@redhat.com>
References: <20250625055908.456235-1-dlemoal@kernel.org> <20250625055908.456235-4-dlemoal@kernel.org> <96831fd8-da1e-771f-7d19-8087d29f2af1@redhat.com> <07d71ad1-a6de-474b-bee4-a64180284802@kernel.org> <5c9898e1-3fae-d271-b0b8-a23371d22cb0@redhat.com>
 <40690cc0-e941-4db1-904c-a5d60718d852@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12



On Wed, 25 Jun 2025, Damien Le Moal wrote:

> >> Do you have a specific example in mind ?
> > 
> > What happens if a bio that is larger than "BIO_MAX_VECS << PAGE_SHIFT" 
> > enters dm_split_and_process_bio? Where will the bio be split? I don't see 
> > it, but maybe I'm missing something.
> 
> See patch 3 of the v3 I sent: dm_zone_bio_needs_split() and
> dm_split_and_process_bio() have been modified to always endup with need_split ==
> true for zone write BIOs, and that causes a call to bio_split_to_limits(). So
> dm-crypt will always see BIOs that are smaller than limits->max_hw_sectors,
> which is set to BIO_MAX_VECS << PAGE_SECTORS_SHIFT in dm-crypt io_hint. So
> dm-crypt can never see a write BIO that is larger than BIO_MAX_VECS << PAGE_SHIFT.

OK.

I acked the patches and I suppose that they will be sent through the block 
layer tree.

Or - should I send them through the device mapper tree?

Mikulas


