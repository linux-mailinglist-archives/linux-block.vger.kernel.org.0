Return-Path: <linux-block+bounces-18697-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE43A68C8A
	for <lists+linux-block@lfdr.de>; Wed, 19 Mar 2025 13:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86FB2189F9DA
	for <lists+linux-block@lfdr.de>; Wed, 19 Mar 2025 12:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C49255241;
	Wed, 19 Mar 2025 12:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MP2mwHYf"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24180255229
	for <linux-block@vger.kernel.org>; Wed, 19 Mar 2025 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386420; cv=none; b=DZ9AtMoJUtGnV/lBbJzQ5XpJuZ8ibJvb6M6Kgspi9m0b23SsnDTCKZ6+C78qNo9KQEl+6WreRX3LGJeF7+IzleGVmZK91cw5d2uHLpcp5cIuW7yFZu0tWeXDEz1fEwW3R7m+eZLCImcPvvpzNuGGwHDDq3lRu4J6R8TEMOs5t5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386420; c=relaxed/simple;
	bh=LyJFMfmI/v7jDUiHaBkLE0VqQt6PFJLGMn02FPZ6ymY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfBytuufAurp3DvZZr5IH3zG56CoMHD8+WC7cobaCmUb03Ie+BvxwguP+J40Yllw35x/CgY02iCJlwIuxTj41nP1oQiOwY/ZP+udY8XIGvSWhIPI/jwIxxn7k3CMC4BisScj1NQZi4GqqnuHXStFKFGNMOmfD5wzuusVHbSRZSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MP2mwHYf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742386417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YeN3DvlwH1vdQPd4hot2bQa9DxYxFDt9cRW/xAAcfPw=;
	b=MP2mwHYf6vR2DfnujeJKV6WGtabgToVPVz2yYzg3F82noWe3/b7klJGkHRotcBBRMM+eDB
	ZaukCJVykqDQ8ygYJjAbuL0ZSMe7RmXTvjbqJTv0s4KvLl/hZBJ+zRf2PiXC5vfdS+//8N
	N3XARezaD/X+kTQI6gbq1Jlf47EP/m0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-2BqcAwIaOGKRFO6PEDK2Lg-1; Wed,
 19 Mar 2025 08:13:36 -0400
X-MC-Unique: 2BqcAwIaOGKRFO6PEDK2Lg-1
X-Mimecast-MFC-AGG-ID: 2BqcAwIaOGKRFO6PEDK2Lg_1742386414
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12D2C1800260;
	Wed, 19 Mar 2025 12:13:34 +0000 (UTC)
Received: from fedora (unknown [10.72.120.7])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBE8D180094A;
	Wed, 19 Mar 2025 12:13:25 +0000 (UTC)
Date: Wed, 19 Mar 2025 20:13:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org, hch@lst.de,
	hare@suse.de, dlemoal@kernel.org, axboe@kernel.dk, tj@kernel.org,
	josef@toxicpanda.com, gjoyce@ibm.com, lkp@intel.com,
	oliver.sang@intel.com
Subject: Re: [PATCH 1/2] block: release q->elevator_lock in ioc_qos_write
Message-ID: <Z9q04AC0XUQ2DBwu@fedora>
References: <20250319105518.468941-1-nilay@linux.ibm.com>
 <20250319105518.468941-2-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319105518.468941-2-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Mar 19, 2025 at 04:23:45PM +0530, Nilay Shroff wrote:
> The ioc_qos_write method acquires q->elevator_lock to protect
> updates to blk-wbt parameters. Once these updates are complete,
> the lock should be released before returning from ioc_qos_write.
> 
> However, in one code path, the release of q->elevator_lock was
> mistakenly omitted, potentially leading to a lock leak. This commit
> fixes the issue by ensuring that q->elevator_lock is properly
> released in all return paths of ioc_qos_write.
> 
> Fixes: 245618f8e45f ("block: protect wbt_lat_usec using q->elevator_lock")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202503171650.cc082b66-lkp@intel.com
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  block/blk-iocost.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 38e7bf3c3b4f..56e6fb51316d 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -3348,6 +3348,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
>  		wbt_enable_default(disk);
>  
>  	blk_mq_unquiesce_queue(disk->queue);
> +	mutex_unlock(&disk->queue->elevator_lock);
>  	blk_mq_unfreeze_queue(disk->queue, memflags);

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


