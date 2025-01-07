Return-Path: <linux-block+bounces-16075-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF89A049B5
	for <lists+linux-block@lfdr.de>; Tue,  7 Jan 2025 19:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C181673B7
	for <lists+linux-block@lfdr.de>; Tue,  7 Jan 2025 18:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987041F4E21;
	Tue,  7 Jan 2025 18:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UR30ik3T"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8391F4276
	for <linux-block@vger.kernel.org>; Tue,  7 Jan 2025 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736276196; cv=none; b=qLa3b15g2FoWP3Uzbpl8h1ZcXcqbRUWrUdYWAZ4iPy/7xuO6ySwYu/cLU26/VqcSzSw2ebY7nXEaICoIOQ8AUlyK06GyxG0+NBSpiY05sx2Xgdp77dkS7rvPC11LXBp5zIYhHUGrtzORpflFK4QXPZCDCBiKEudGwDt7dRVSJNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736276196; c=relaxed/simple;
	bh=CjX4NEdBl3M2NudxOqV5N4y0Af3CCbP2DnLRLuB44xA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hUdZwkBHxI25xaObjaZCyvzc63bTa8Zj3YL7rvJLq10aYiaHBDF2dknOncQUCm0syeDBO9T3EgF9/otJi//++WZUDrqlfr2y2+190YcHvyADfvv5DFA2gAQE2JEvgfQ0PhLOCo/nZT2t/vr8PYik/LHcV/KPbT3dtdoTJJZ8LjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UR30ik3T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736276194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lXUizMUG4x4RLxkGkude1vWBp1xO2TAjpPF5B2ZhjBk=;
	b=UR30ik3TFoeI22jBIg1HKGXarb/CMh6oLbB2sZXjX0BUg9Clu+oS/sDOEofazBVhEAKeQs
	COjJHpRmgj11OubCJQafHfWHd3MQTtwNkF9Zjwgq9ui4Yti6TkTs3ZbVEGEsDtAHhO3R4U
	H2wmgqbWUZkpkQUZfG2oOea+5/Cmdwo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-YIeffaxmNbChvaJ0Pj0QEQ-1; Tue,
 07 Jan 2025 13:56:28 -0500
X-MC-Unique: YIeffaxmNbChvaJ0Pj0QEQ-1
X-Mimecast-MFC-AGG-ID: YIeffaxmNbChvaJ0Pj0QEQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1AAD01956088;
	Tue,  7 Jan 2025 18:56:27 +0000 (UTC)
Received: from [10.45.224.27] (unknown [10.45.224.27])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F62B195606B;
	Tue,  7 Jan 2025 18:56:22 +0000 (UTC)
Date: Tue, 7 Jan 2025 19:56:17 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: John Garry <john.g.garry@oracle.com>, Joe Thornber <thornber@redhat.com>
cc: Mike Snitzer <snitzer@hammerspace.com>, axboe@kernel.dk, agk@redhat.com, 
    hch@lst.de, martin.petersen@oracle.com, linux-block@vger.kernel.org, 
    dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] device mapper atomic write support
In-Reply-To: <ca18486a-a171-43a9-b0ff-638a8ed3c882@oracle.com>
Message-ID: <5a24c8ca-bd0f-6cd0-a3f0-09482a562efe@redhat.com>
References: <20250106124119.1318428-1-john.g.garry@oracle.com> <Z3wSV0YkR39muivP@hammerspace.com> <dcbaadea-66c1-4d98-8a37-945d8b336d5b@oracle.com> <5328db9a-8345-2938-7204-3d4cdb138ee4@redhat.com> <ca18486a-a171-43a9-b0ff-638a8ed3c882@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40



On Tue, 7 Jan 2025, John Garry wrote:

> On 07/01/2025 17:13, Mikulas Patocka wrote:
> > On Mon, 6 Jan 2025, John Garry wrote:
> > 
> > BTW. could it be possible to add dm-mirror support as well? dm-mirror is
> > used when the user moves the logical volume to another physical volume, so
> > it would be nice if this worked without resulting in not-supported errors.
> > 
> > dm-mirror uses dm-io to perform the writes on multiple mirror legs (see
> > the function do_write() -> dm_io()), I looked at the code and it seems
> > that the support for atomic writes in dm-mirror and dm-io would be
> > straightforward.
> 
> FWIW, we do support atomic writes for md raid1. The key principle is that we
> atomically write to each disk. Obviously we cannot write to multiple disks
> atomically. So the copies in each mirror may be out-of-sync after an
> unexpected power fail, but that is ok as either will have all of old or new
> data, which is what we guarantee.

Yes - something like that can be implemented for dm-mirror too.

> > Another possibility would be dm-snapshot support, assuming that the atomic
> > i/o size <= snapshot chunk size, the support should be easy - i.e. just
> > pass the flag REQ_ATOMIC through. Perhaps it could be supported for
> > dm-thin as well.
> 
> Do you think that there will be users for these?
> 
> atomic writes provide guarantees for users, and it would be hard to detect
> when these guarantees become broken through software bugs. I would be just
> concerned that we enable atomic writes for many of these more complicated
> personalities, and they are not actively used and break.
> 
> Thanks,
> John

dm-snapshot is not much used, but dm-thin is. I added Joe to the 
recipients list, so that he can decide whether dm-thin should support 
atomic writes or not.

Mikulas


