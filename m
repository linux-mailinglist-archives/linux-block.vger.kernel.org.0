Return-Path: <linux-block+bounces-7447-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584C38C6FDF
	for <lists+linux-block@lfdr.de>; Thu, 16 May 2024 03:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12FB328357C
	for <lists+linux-block@lfdr.de>; Thu, 16 May 2024 01:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C15FA47;
	Thu, 16 May 2024 01:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cRBM6MnO"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C005B7E1
	for <linux-block@vger.kernel.org>; Thu, 16 May 2024 01:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715822008; cv=none; b=Zt94DAXkvV0+ryMjMG06r5E3uClETmJKJlUu4s1Xak3XHTjCNAIgz7S79MedFx1daxmwoIto0fv8m6ABUddeBQZijapFKPnF/97LOSTCKhkm+AIURiP1inTGjA14nHQTh5D9AptatTg/TEINOWYfCLe0uCSkJj+Njsni9HDj/oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715822008; c=relaxed/simple;
	bh=aU4bIrypo3fSMNvIVeRGR0akyO7b61BZ7RtJMzkJ7gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7rBiQj0kVSAnjDPnOqQjztV1D2P3NW8FWEeybr+64QLol63191fq/SVSW93S+OjkJhhKiDhiKkb2Jio5wm0+kAz/j8zOHuVKJfw7sZpYtPogiUykz5bhLjlXx2sCUOLdPY1h78fG2MTC7aDlStwgpr2IqnjRmbwvPZ1To5RuSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cRBM6MnO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715822005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V9idPTsI7t4AJ0FvbhcpdhNgeAHxtx1gXNf8WyfuOVQ=;
	b=cRBM6MnOF4vymqAwKcpvQwSOZ2XMRVO66jSQN9NNovz+kuGs/zYJFMJZdCmANCTmoXlMp7
	3LbgFrA+X65t114v0OCz2CW8GJJMEfw95vGlVfjlgkj/udKHQVgmvBQPrm3x25Eq45krfS
	rhOgWdplLtuBN0iJN5XNYBG/7YklGb4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-janpmtJhOAa1J5JL1Yb_6w-1; Wed, 15 May 2024 21:13:23 -0400
X-MC-Unique: janpmtJhOAa1J5JL1Yb_6w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 041FD101A525;
	Thu, 16 May 2024 01:13:23 +0000 (UTC)
Received: from fedora (unknown [10.72.116.49])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E3F8F1C00A90;
	Thu, 16 May 2024 01:13:18 +0000 (UTC)
Date: Thu, 16 May 2024 09:13:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: Re: [PATCH] blk-cgroup: Properly propagate the iostat update up the
 hierarchy
Message-ID: <ZkVdqoRpAoTyheb8@fedora>
References: <20240515143059.276677-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515143059.276677-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Wed, May 15, 2024 at 10:30:59AM -0400, Waiman Long wrote:
> During a cgroup_rstat_flush() call, the lowest level of nodes are flushed
> first before their parents. Since commit 3b8cc6298724 ("blk-cgroup:
> Optimize blkcg_rstat_flush()"), iostat propagation was still done to
> the parent. Grandparent, however, may not get the iostat update if the
> parent has no blkg_iostat_set queued in its lhead lockless list.
> 
> Fix this iostat propagation problem by queuing the parent's global
> blkg->iostat into one of its percpu lockless lists to make sure that
> the delta will always be propagated up to the grandparent and so on
> toward the root blkcg.
> 
> Note that successive calls to __blkcg_rstat_flush() are serialized by
> the cgroup_rstat_lock. So no special barrier is used in the reading
> and writing of blkg->iostat.lqueued.
> 
> Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
> Reported-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> Closes: https://lore.kernel.org/lkml/ZkO6l%2FODzadSgdhC@dschatzberg-fedora-PF3DHTBV/
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  block/blk-cgroup.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 059467086b13..2a7624c32a1a 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -323,6 +323,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
>  	blkg->q = disk->queue;
>  	INIT_LIST_HEAD(&blkg->q_node);
>  	blkg->blkcg = blkcg;
> +	blkg->iostat.blkg = blkg;
>  #ifdef CONFIG_BLK_CGROUP_PUNT_BIO
>  	spin_lock_init(&blkg->async_bio_lock);
>  	bio_list_init(&blkg->async_bios);
> @@ -1025,6 +1026,8 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
>  		unsigned int seq;
>  
>  		WRITE_ONCE(bisc->lqueued, false);
> +		if (bisc == &blkg->iostat)
> +			goto propagate_up; /* propagate up to parent only */
>  
>  		/* fetch the current per-cpu values */
>  		do {
> @@ -1034,10 +1037,24 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
>  
>  		blkcg_iostat_update(blkg, &cur, &bisc->last);
>  
> +propagate_up:
>  		/* propagate global delta to parent (unless that's root) */
> -		if (parent && parent->parent)
> +		if (parent && parent->parent) {
>  			blkcg_iostat_update(parent, &blkg->iostat.cur,
>  					    &blkg->iostat.last);
> +			/*
> +			 * Queue parent->iostat to its blkcg's lockless
> +			 * list to propagate up to the grandparent if the
> +			 * iostat hasn't been queued yet.
> +			 */
> +			if (!parent->iostat.lqueued) {
> +				struct llist_head *plhead;
> +
> +				plhead = per_cpu_ptr(parent->blkcg->lhead, cpu);
> +				llist_add(&parent->iostat.lnode, plhead);
> +				parent->iostat.lqueued = true;
> +			}
> +		}

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


