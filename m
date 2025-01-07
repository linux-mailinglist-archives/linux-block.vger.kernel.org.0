Return-Path: <linux-block+bounces-16063-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5864A047E9
	for <lists+linux-block@lfdr.de>; Tue,  7 Jan 2025 18:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC93C1634A1
	for <lists+linux-block@lfdr.de>; Tue,  7 Jan 2025 17:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63661F473E;
	Tue,  7 Jan 2025 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBfoBAL8"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448FB1F5421
	for <linux-block@vger.kernel.org>; Tue,  7 Jan 2025 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736270009; cv=none; b=WuhSnpES/g9hINRu+9GEBMBbCCMYljG6aOwKi/DEy6JhpqHMJUgTDuZrfGmnh8udJHw7Wr8U1BALnyeRAMV5iOTf7MLswDk78CkSNj5qEOPZoQl26BOrVgSzb9NVmiSTvivpu+SmlDTMYGvNyiLmx4mnN+ekcEhtl5zl9/UnM3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736270009; c=relaxed/simple;
	bh=4DWnlFnuo2BwdVJurloqLZyr6SJGkDY8Mh7D5ebrUHc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UAQPlOsVR+05TKLhM2g+ltEw2uJNbXj1Q3fAA0kRL6AcsQJ02H2R0UA7/rWnUIUziRfUIaYfs60HiUKNUfVrpkYDRUwcHwopMe0wRbhNzoYpS4d6eKmdh+5fko0Vh9VajmXeDw5aZZQKXnFG4TcofNXnq3IpP8z5RrVU5BAPMP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YBfoBAL8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736270007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lpA+wm1NYm8XCjdkhq6EDQzPo7soPLlFgVc4ywtxYOo=;
	b=YBfoBAL8kwNLoNN9NEuqZjpJvP2zyJD3V4upXFt0ZTgNxffj/sWupK/1Ho/VZ3DyObskYk
	wEkP6awUBMEYtEqoFjO7IN116xsg+Qq0baTPHM8vhBkWfFSE7X4+4z7UtNDuCRD0RNWpC0
	UksGoU5ihi00gFO5Esm+eiAaDkFykm4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-uVr3HftzMgGzih4Dj80qVA-1; Tue,
 07 Jan 2025 12:13:23 -0500
X-MC-Unique: uVr3HftzMgGzih4Dj80qVA-1
X-Mimecast-MFC-AGG-ID: uVr3HftzMgGzih4Dj80qVA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55FBF1955E99;
	Tue,  7 Jan 2025 17:13:21 +0000 (UTC)
Received: from [10.45.224.27] (unknown [10.45.224.27])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB2861955F40;
	Tue,  7 Jan 2025 17:13:17 +0000 (UTC)
Date: Tue, 7 Jan 2025 18:13:14 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: John Garry <john.g.garry@oracle.com>
cc: Mike Snitzer <snitzer@hammerspace.com>, axboe@kernel.dk, agk@redhat.com, 
    hch@lst.de, martin.petersen@oracle.com, linux-block@vger.kernel.org, 
    dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] device mapper atomic write support
In-Reply-To: <dcbaadea-66c1-4d98-8a37-945d8b336d5b@oracle.com>
Message-ID: <5328db9a-8345-2938-7204-3d4cdb138ee4@redhat.com>
References: <20250106124119.1318428-1-john.g.garry@oracle.com> <Z3wSV0YkR39muivP@hammerspace.com> <dcbaadea-66c1-4d98-8a37-945d8b336d5b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40



On Mon, 6 Jan 2025, John Garry wrote:

> On 06/01/2025 17:26, Mike Snitzer wrote:
> > On Mon, Jan 06, 2025 at 12:41:14PM +0000, John Garry wrote:
> > > This series introduces initial device mapper atomic write support.
> > > 
> > > Since we already support stacking atomic writes limits, it's quite
> > > straightforward to support.
> > > 
> > > Only dm-linear is supported for now, but other personalities could
> > > be supported.
> > > 
> > > Patch #1 is a proper fix, but the rest of the series is RFC - this is
> > > because I have not fully tested and we are close to the end of this
> > > development cycle.
> > In general, looks reasonable.  But I would prefer to see atomic write
> > support added to dm-striped as well.  Not that I have some need, but
> > because it will help verify the correctness of the general stacking
> > code changes (in both block and DM core). 
> 
> That should be fine. We already have md raid0 support working (for atomic
> writes), so I would expect much of the required support is already available.

BTW. could it be possible to add dm-mirror support as well? dm-mirror is 
used when the user moves the logical volume to another physical volume, so 
it would be nice if this worked without resulting in not-supported errors.

dm-mirror uses dm-io to perform the writes on multiple mirror legs (see 
the function do_write() -> dm_io()), I looked at the code and it seems 
that the support for atomic writes in dm-mirror and dm-io would be 
straightforward.

Another possibility would be dm-snapshot support, assuming that the atomic 
i/o size <= snapshot chunk size, the support should be easy - i.e. just 
pass the flag REQ_ATOMIC through. Perhaps it could be supported for 
dm-thin as well.

Mikulas


