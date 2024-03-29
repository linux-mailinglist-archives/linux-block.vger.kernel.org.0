Return-Path: <linux-block+bounces-5401-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F531890ECD
	for <lists+linux-block@lfdr.de>; Fri, 29 Mar 2024 01:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2224FB227A0
	for <lists+linux-block@lfdr.de>; Fri, 29 Mar 2024 00:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF5F3D8E;
	Fri, 29 Mar 2024 00:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJtZ0KWw"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D812F26
	for <linux-block@vger.kernel.org>; Fri, 29 Mar 2024 00:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711670441; cv=none; b=Ncc5vYPfd3g70pmnCd9yowZp/mqTPuitai/xITpn2i4y4hYg6TxN2lLvAg2UDTpidcvlaG6Ez5fbQdJiPRyp/xcxvTwZ5dBLMyCcK6Fv45wwm0titWNA1CRir4OCFQbMVDgQwZmjll7288IMfKyb+snmZ+w0sDp1ks4/0RK7/4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711670441; c=relaxed/simple;
	bh=ENZlmKNxpzlLiGBo6kS0UnjmR03CylTphFoCV+u4xmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCaeswKpi15qdAkbcQherI25RYJ502ebJxFDxclB7mtUhruOSXKOya7RCA8Byvq1HTIj9Wnq6JI8yMQtCOtb6/o9S4CuMTSlwTEywFl1HWGCVX4xRnifIk4EK+4vNz9ratIZUMDPPORGwH8CQI9fpbvDmVnDzjlrMoqrGoOtJqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DJtZ0KWw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711670439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KOh0bGzRFscdK7n0pRRU7ddpBbKZJGLB2WZV3d0SUpI=;
	b=DJtZ0KWw84Y3H43689Z61fjiaJT5jR7Pln+YnfRoH1DK+dZBk/eyE0jg9qR/uDErPXB5sl
	0JkkI0/5DJ1bnyZHynOGU/V5qC9UElFE3zSX81UMn0zEjQEFF9BtVN11xkuod8/1Sx5fvd
	fhw76wukWTQdyH0ByxZVWk+HsoGcrTI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-OPZRQc8PPO2s2otDIOSCEQ-1; Thu,
 28 Mar 2024 20:00:35 -0400
X-MC-Unique: OPZRQc8PPO2s2otDIOSCEQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 086C43801F53;
	Fri, 29 Mar 2024 00:00:35 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.33])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 599E12166B36;
	Fri, 29 Mar 2024 00:00:32 +0000 (UTC)
Date: Thu, 28 Mar 2024 19:00:26 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alasdair Kergon <agk@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
	David Teigland <teigland@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Joe Thornber <ejt@redhat.com>
Subject: Re: [RFC 2/9] loop: add llseek(SEEK_HOLE/SEEK_DATA) support
Message-ID: <wvdjesmnq6xrkanncathyciocbtxa6m3fefvx3za3ikxfs7uqx@wo22n4cvndr3>
References: <20240328203910.2370087-1-stefanha@redhat.com>
 <20240328203910.2370087-3-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328203910.2370087-3-stefanha@redhat.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Thu, Mar 28, 2024 at 04:39:03PM -0400, Stefan Hajnoczi wrote:
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Open issues:
> - The file offset is updated on both the blkdev file and the backing
>   file. Is there a way to avoid updating the backing file offset so the
>   file opened by userspace is not affected?
> - Should this run in the worker or use the cgroups?
> ---
>  drivers/block/loop.c | 36 ++++++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 28a95fd366fea..6a89375de82e8 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -750,6 +750,29 @@ static void loop_sysfs_exit(struct loop_device *lo)
>  				   &loop_attribute_group);
>  }
>  
> +static loff_t lo_seek_hole_data(struct block_device *bdev, loff_t offset,
> +		int whence)
> +{
> +	/* TODO need to activate cgroups or use worker? */
> +	/* TODO locking? */
> +	struct loop_device *lo = bdev->bd_disk->private_data;
> +	struct file *file = lo->lo_backing_file;
> +
> +	if (lo->lo_offset > 0)
> +		offset += lo->lo_offset; /* TODO underflow/overflow? */
> +
> +	/* TODO backing file offset is modified! */
> +	offset = vfs_llseek(file, offset, whence);

Not only did you modify the underlying offset...

> +	if (offset < 0)
> +		return offset;
> +
> +	if (lo->lo_offset > 0)
> +		offset -= lo->lo_offset; /* TODO underflow/overflow? */
> +	if (lo->lo_sizelimit > 0 && offset > lo->lo_sizelimit)
> +		offset = lo->lo_sizelimit;

...but if this code kicks in, you have clamped the return result to
EOF of the loop device while leaving the underlying offset beyond the
limit, which may mess up assumptions of other code expecting the loop
to always have an in-bounds offset for the underlying file (offhand, I
don't know if there is any such code; but since loop_ctl_fops.llseek =
noop_lseek, there may be code relying on an even-tighter restriction
that the offset of the underlying file never changes, not even within
bounds).

Furthermore, this is inconsistent with all other seek-beyond-end code
that fails with -ENXIO instead of returning size.

But for an RFC, the idea of being able to seek to HOLEs in a loop
device is awesome!

> @@ -2140,7 +2164,7 @@ static int loop_control_remove(int idx)
>  		pr_warn_once("deleting an unspecified loop device is not supported.\n");
>  		return -EINVAL;
>  	}
> -		
> +
>  	/* Hide this loop device for serialization. */
>  	ret = mutex_lock_killable(&loop_ctl_mutex);
>  	if (ret)

Unrelated whitespace change?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


