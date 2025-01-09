Return-Path: <linux-block+bounces-16140-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87238A06ACC
	for <lists+linux-block@lfdr.de>; Thu,  9 Jan 2025 03:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D70A18821B7
	for <lists+linux-block@lfdr.de>; Thu,  9 Jan 2025 02:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9CBBE5E;
	Thu,  9 Jan 2025 02:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHoSDBN/"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7CB8F5E
	for <linux-block@vger.kernel.org>; Thu,  9 Jan 2025 02:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736389124; cv=none; b=TaDmDsATp8g+LgpN1H6rvlyQUddVG5+SlC6XY8XSHPCdiEZmK8t7TLJIVSSDOI33Ugy86bRv0vkuKaoHQkuPEtFNwu1WHlwWJY6SySFuChIvrNqRTNhRw0szddTLDLsFEbMVR1EpsV/5QatvHTbTeU7mrnlHE6yF2CgrJUd3V6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736389124; c=relaxed/simple;
	bh=blSjv22Y11SbJylCWcSMLd+PbMLZEcWCTOWjZ1C3fQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYlPYCj11i5R2QNp6XKGuQ6Mf5GfrGrOqkhHvUI8zGKXK7qxxmjVIK0PQBUH3NVRPqwVtcOWzyDdBIfOA9KH2ONpXN80M9+dEWyd7oIgKWJGtQX0WOr++yv6b8MnKlcW+hzbKVRPX2QD4rnV3afHCSesOPezCzroI7x34DHcbZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UHoSDBN/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736389121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NI/7sQZJsUB7MRKETVbNrqqCnlEl+xyWkxCJ71vt8Ik=;
	b=UHoSDBN/HXxz+81j5QNrM5UI6LXUSRKdTchg+edAL0fNZLeMQ5aiB/as6g8Vs52IBkibXY
	mj+5HAXFTrGquLVcTwWIzWUylF2qWSZKyvTZIoufUgpTCP8tc+NLVfrKPrYgbc9emuGDnD
	ntjT7+QYEikpKOYDc/snESuAGMR6liA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-7FSoSldJMXm3ogIjfdzqow-1; Wed,
 08 Jan 2025 21:18:37 -0500
X-MC-Unique: 7FSoSldJMXm3ogIjfdzqow-1
X-Mimecast-MFC-AGG-ID: 7FSoSldJMXm3ogIjfdzqow
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3DF5195608B;
	Thu,  9 Jan 2025 02:18:34 +0000 (UTC)
Received: from fedora (unknown [10.72.116.23])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EB1419560AD;
	Thu,  9 Jan 2025 02:18:28 +0000 (UTC)
Date: Thu, 9 Jan 2025 10:18:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, nbd@other.debian.org,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 03/10] block: don't update BLK_FEAT_POLL in
 __blk_mq_update_nr_hw_queues
Message-ID: <Z38x7mzrQPEiUOpv@fedora>
References: <20250108092520.1325324-1-hch@lst.de>
 <20250108092520.1325324-4-hch@lst.de>
 <Z35T8xeLxhXe-zAS@fedora>
 <20250108152705.GA24792@lst.de>
 <a3bd231c-0568-4dad-9268-bc7edaace94b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3bd231c-0568-4dad-9268-bc7edaace94b@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Jan 09, 2025 at 09:05:49AM +0900, Damien Le Moal wrote:
> On 1/9/25 00:27, Christoph Hellwig wrote:
> > On Wed, Jan 08, 2025 at 06:31:15PM +0800, Ming Lei wrote:
> >>> -	if (!(q->limits.features & BLK_FEAT_POLL) &&
> >>> -			(bio->bi_opf & REQ_POLLED)) {
> >>> +	if ((bio->bi_opf & REQ_POLLED) && !bdev_can_poll(bdev)) {
> >>
> >> submit_bio_noacct() is called without grabbing .q_usage_counter,
> >> so tagset may be freed now, then use-after-free on q->tag_set?
> > 
> > Indeed.  That also means the previous check wasn't reliable either.
> > I think we can simple move the check into
> > blk_mq_submit_bio/__submit_bio which means we'll do a bunch more
> > checks before we eventually fail, but otherwise it'll work the
> > same.
> 
> Given that the request queue is the same for all tag sets, I do not think we

No, it isn't same.

> need to have the queue_limits_start_update()/commit_update() within the tag set
> loop in __blk_mq_update_nr_hw_queues(). So something like this should be enough
> for an initial fix, no ?
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8ac19d4ae3c0..ac71e9cee25b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4986,6 +4986,7 @@ static void __blk_mq_update_nr_hw_queues(struct
> blk_mq_tag_set *set,
>                                                         int nr_hw_queues)
>  {
>         struct request_queue *q;
> +       struct queue_limits lim;
>         LIST_HEAD(head);
>         int prev_nr_hw_queues = set->nr_hw_queues;
>         int i;
> @@ -4999,8 +5000,10 @@ static void __blk_mq_update_nr_hw_queues(struct
> blk_mq_tag_set *set,
>         if (set->nr_maps == 1 && nr_hw_queues == set->nr_hw_queues)
>                 return;
> 
> +       lim = queue_limits_start_update(q);
>         list_for_each_entry(q, &set->tag_list, tag_set_list)
>                 blk_mq_freeze_queue(q);

It could be worse, since the limits_lock is connected with lots of other
subsystem's lock(debugfs, sysfs dir, ...), it may introduce new deadlock
risk.

Thanks,
Ming


