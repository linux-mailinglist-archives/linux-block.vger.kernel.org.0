Return-Path: <linux-block+bounces-2890-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2898492D3
	for <lists+linux-block@lfdr.de>; Mon,  5 Feb 2024 04:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED106B22422
	for <lists+linux-block@lfdr.de>; Mon,  5 Feb 2024 03:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C19AD35;
	Mon,  5 Feb 2024 03:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxOKPf4p"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D979449
	for <linux-block@vger.kernel.org>; Mon,  5 Feb 2024 03:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707104344; cv=none; b=gJPUEHW3Zp6exnmyiTgMlUDNey/76ylMotgNG8JTH3XB79KF5xD7VDms1QLI6d3Uk/5ciLGyPtZUKSGA9mgxszfqcI4/eAPlpkP9AS6ZSP2jwVou9JIGKFENJ/IrEJmDiAPpZY7dvJAu8EgUhX+1ZFGP39CpeMwe1jTxkqI6axM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707104344; c=relaxed/simple;
	bh=TiJp4x6IUPbILUPqt9kizq42fdTPI3DbGP+yMGkVkcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajYzAbOutW2d1Yccue7dTYFSQBqrkqh+T+TDe9f4/GNj9I5Hyskheo2TM/erzh7/tVeE3qixCromdn7l1vHGsRSvjY9z0jgezFbjtHWpnACP2i0tZHeQJdel9XnVj/1KtVTgxdL5TOiHHnwbc6H4nxr2wHo1UMxlGJiPi6bxi4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UxOKPf4p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707104341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qvD3xk7BRRxDBV73lvxNR5NIlkKnAW1/LEXTrtorDsM=;
	b=UxOKPf4pwc5m6A73lcE/sc7BthWVLR5M5I6O+iKGLE1M4hwNr0HdliA5ebkz/Zz3kVrT+q
	h3FCKtc1A1V84Mh+6afbV0F4zswYJRa+jqD47CkpynplDbYXYy+O3dOjBKN+cm21B71M7Y
	sVFguX7JSUTfz0eMQxyVfwrw2bWJbyg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-TBq5w4gEM6O6TyeRRFwr3w-1; Sun,
 04 Feb 2024 22:38:56 -0500
X-MC-Unique: TBq5w4gEM6O6TyeRRFwr3w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 81E913C2B601;
	Mon,  5 Feb 2024 03:38:55 +0000 (UTC)
Received: from fedora (unknown [10.72.116.96])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AA13951D5;
	Mon,  5 Feb 2024 03:38:51 +0000 (UTC)
Date: Mon, 5 Feb 2024 11:38:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 06/26] block: Introduce zone write plugging
Message-ID: <ZcBYRzAqwoQIaR3r@fedora>
References: <20240202073104.2418230-1-dlemoal@kernel.org>
 <20240202073104.2418230-7-dlemoal@kernel.org>
 <Zb8K4uSN3SNeqrPI@fedora>
 <a3f17ffb-872b-49cf-a1a7-553ca4a272c0@kernel.org>
 <ZcBFoqweG+okoTN6@fedora>
 <58fa0123-e884-4321-9b9b-8575cc7b4e1d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58fa0123-e884-4321-9b9b-8575cc7b4e1d@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Mon, Feb 05, 2024 at 11:41:04AM +0900, Damien Le Moal wrote:
> On 2/5/24 11:19, Ming Lei wrote:
> >>>> +static inline void blk_zone_wplug_add_bio(struct blk_zone_wplug *zwplug,
> >>>> +					  struct bio *bio, unsigned int nr_segs)
> >>>> +{
> >>>> +	/*
> >>>> +	 * Keep a reference on the BIO request queue usage. This reference will
> >>>> +	 * be dropped either if the BIO is failed or after it is issued and
> >>>> +	 * completes.
> >>>> +	 */
> >>>> +	percpu_ref_get(&bio->bi_bdev->bd_disk->queue->q_usage_counter);
> >>>
> >>> It is fragile to get nested usage_counter, and same with grabbing/releasing it
> >>> from different contexts or even functions, and it could be much better to just
> >>> let block layer maintain it.
> >>>
> >>> From patch 23's change:
> >>>
> >>> +	 * Zoned block device information. Reads of this information must be
> >>> +	 * protected with blk_queue_enter() / blk_queue_exit(). Modifying this
> >>>
> >>> Anytime if there is in-flight bio, the block device is opened, so both gendisk and
> >>> request_queue are live, so not sure if this .q_usage_counter protection
> >>> is needed.
> >>
> >> Hannes also commented about this. Let me revisit this.
> > 
> > I think only queue re-configuration(blk_revalidate_zone) requires the
> > queue usage counter. Otherwise, bdev open()/close() should work just
> > fine.
> 
> I want to check FS case though. No clear if mounting FS that supports zone
> (btrfs) also uses bdev open ?

btrfs '-O zoned' shouldn't be one exception:

mount -O zoned /dev/ublkb0 /mnt

  b'blkdev_get_whole'
  b'bdev_open_by_dev'
  b'bdev_open_by_path'
  b'btrfs_scan_one_device'
  b'btrfs_get_tree'
  b'vfs_get_tree'
  b'fc_mount'
  b'btrfs_get_tree'
  b'vfs_get_tree'
  b'path_mount'
  b'__x64_sys_mount'
  b'do_syscall_64'
  b'entry_SYSCALL_64_after_hwframe'
  b'[unknown]'
    1

> 
> >>>> +	/*
> >>>> +	 * blk-mq devices will reuse the reference on the request queue usage
> >>>> +	 * we took when the BIO was plugged, but the submission path for
> >>>> +	 * BIO-based devices will not do that. So drop this reference here.
> >>>> +	 */
> >>>> +	if (bio->bi_bdev->bd_has_submit_bio)
> >>>> +		blk_queue_exit(bio->bi_bdev->bd_disk->queue);
> >>>
> >>> But I don't see where this reference is reused for blk-mq in this patch,
> >>> care to point it out?
> >>
> >> This patch modifies blk_mq_submit_bio() to add a "goto new_request" at the top
> >> for any BIO flagged with BIO_FLAG_ZONE_WRITE_PLUGGING. So when a plugged BIO is
> >> unplugged and submitted again, the reference that was taken in
> >> blk_zone_wplug_add_bio() is reused for the new request for that BIO.
> > 
> > OK, this reference reuse may be worse, because queue freeze can't prevent new
> > write zoned bio from being submitted any more given only percpu_ref_get() is
> > called for all write zoned bios.
> 
> New BIOs (BIOS that have never been plugged yet) will go through the normal
> blk_queue_enter() in blk_mq_submit_bio(), so they will be stopped there if
> another context asked for a queue freeze. I do not think there is any issue with
> how things are currently done (we tested that *a lot* with many different drives
> and drive configs with DM etc). Reference counting as it is is OK, even though
> it most likely be simplified. I am looking at that now.

Indeed, new zoned write bio is still covered by blk-mq's queue reference, and the
trick is just played on old plugged bio.

Thanks,
Ming


