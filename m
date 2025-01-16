Return-Path: <linux-block+bounces-16408-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EE5A13D04
	for <lists+linux-block@lfdr.de>; Thu, 16 Jan 2025 15:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DAA61619D6
	for <lists+linux-block@lfdr.de>; Thu, 16 Jan 2025 14:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D3E1DE2D7;
	Thu, 16 Jan 2025 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ii3dWB5a"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E7622A7EA
	for <linux-block@vger.kernel.org>; Thu, 16 Jan 2025 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737039503; cv=none; b=i2ZsV6joXP4WcgLlE6iavMSWIqnt6lBFxlN6EBnDC3GlMsBbkHgiNRIBYEQMGS8hfIXeCO8YIiXhabM8Oxzcn9P6CRqL0B8TbVtj34o0rUnhvgAduc6nNYVoWcyZUsxPeKGlpOXJasUQ3AIZz4UPpWHryLCPL8sQZVkcAJTy4hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737039503; c=relaxed/simple;
	bh=liYsYk4BwupWhIEa/P0TzteY4W0NvkOTBi+Uu1+z8/8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qwj048eT+MvfE+vin2KVipkt8X1Ajqm92937MRWV+z2JgzlwANL4bUrOtcZ7YxGpdgKF3ekufXybeEapLd+jpP5QCTeTEUQv+OaShFd9dLTstrLDoQOn9UhG94Rj0uxyB8yrXTxi/hUwfhVUA8IX6u4xFNGRuu+u8Bdf3Lfkj7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ii3dWB5a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737039500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G0xGaHBuJ1I6u96s4NNOKGBg4Qx97eysuUk/gPTtRcY=;
	b=Ii3dWB5a0mBxkcGTB88AIVS4rGipWGajT/knS3V3WKb8A4WwnwA0v+kWgVbaSPGFoaz40N
	s+7MsHTDavGoTFjEzkhrdLR/l1elntU5drmZIL7XjF+v3r1SZ0WbN8rLXoS7hXfgdT9m6C
	1XQkRXCl/YzEV3tuuy3mrdnIxJaZBjs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-ZvVR_zLpMrai7z5DSEaM3w-1; Thu,
 16 Jan 2025 09:58:16 -0500
X-MC-Unique: ZvVR_zLpMrai7z5DSEaM3w-1
X-Mimecast-MFC-AGG-ID: ZvVR_zLpMrai7z5DSEaM3w
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00EB719560B9;
	Thu, 16 Jan 2025 14:58:15 +0000 (UTC)
Received: from [10.45.224.57] (unknown [10.45.224.57])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BDD619560AD;
	Thu, 16 Jan 2025 14:58:11 +0000 (UTC)
Date: Thu, 16 Jan 2025 15:58:07 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: John Garry <john.g.garry@oracle.com>
cc: Mike Snitzer <snitzer@hammerspace.com>, axboe@kernel.dk, agk@redhat.com, 
    hch@lst.de, martin.petersen@oracle.com, linux-block@vger.kernel.org, 
    dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] device mapper atomic write support
In-Reply-To: <9384e8e2-dd4a-4b49-88a8-f15a9193c872@oracle.com>
Message-ID: <0aeae777-5468-c0e9-3196-e81135da2d8e@redhat.com>
References: <20250106124119.1318428-1-john.g.garry@oracle.com> <Z3wSV0YkR39muivP@hammerspace.com> <dcbaadea-66c1-4d98-8a37-945d8b336d5b@oracle.com> <5328db9a-8345-2938-7204-3d4cdb138ee4@redhat.com> <6a6f8cff-bd19-4079-8867-4ac17d09e915@oracle.com>
 <e2be0a8c-3b97-f75c-362e-2174340b1b2c@redhat.com> <9384e8e2-dd4a-4b49-88a8-f15a9193c872@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12



On Thu, 16 Jan 2025, John Garry wrote:

> On 16/01/2025 12:59, Mikulas Patocka wrote:
> > > > dm-mirror uses dm-io to perform the writes on multiple mirror legs (see
> > > > the function do_write() -> dm_io()), I looked at the code and it seems
> > > > that the support for atomic writes in dm-mirror and dm-io would be
> > > > straightforward.
> > > I tried this out, and it seems to work ok.
> > > 
> > > However, I need to set DM_TARGET_ATOMIC_WRITES in the
> > > mirror_target.features
> > > member, like:
> > > 
> > > diff --git a/drivers/md/dm-raid1.c b/drivers/md/dm-raid1.c
> > > index 9511dae5b556..913a92c55904 100644
> > > --- a/drivers/md/dm-raid1.c
> > > +++ b/drivers/md/dm-raid1.c
> > > @@ -1485,6 +1485,7 @@ static struct target_type mirror_target = {
> > > 	.name    = "mirror",
> > > 	.version = {1, 14, 0},
> > > 	.module  = THIS_MODULE,
> > > +	.features = DM_TARGET_ATOMIC_WRITES,
> > > 	.ctr     = mirror_ctr,
> > > 	.dtr     = mirror_dtr,
> > > 	.map     = mirror_map,
> > > 
> > > 
> > > Is this the right thing to do? I ask, as none of the other DM_TARGET*
> > > flags
> > > are set already, which makes me suspicious.
> > > 
> > > Thanks,
> > > John
> > Yes - that's right. I suggest that you verify that the atomic flag is
> > really passed through the dm-raid1.c and dm-io.c stack. Add a printk that
> > tests if REQ_ATOMIC is set to the function do_region in dm-io.c just
> > before "submit_bio(bio)".
> > 
> > Alternatively, you can use blktrace to test if the REQ_ATOMIC is passed
> > through correctly.
> 
> Yes, it is passed ok.
> 
> JFYI, I can also verify proper atomic write functionality on /dev/dmX with fio
> in verify mode.
> 
> Thanks,
> John

Yes - so please send version 2 of the patches and I will stage them for 
this merge window.

Mikulas


