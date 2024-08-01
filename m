Return-Path: <linux-block+bounces-10269-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22585944EDC
	for <lists+linux-block@lfdr.de>; Thu,  1 Aug 2024 17:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97DFF1F226E8
	for <lists+linux-block@lfdr.de>; Thu,  1 Aug 2024 15:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D20B13B7B3;
	Thu,  1 Aug 2024 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lsd7Zf1W"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A1913B5A5
	for <linux-block@vger.kernel.org>; Thu,  1 Aug 2024 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525237; cv=none; b=Xbbn8N6AQb30X4ht4/qXxzoqwNjGAJQ24FTQt9DfIzVRAFRkU+yvKkNzenCJ1P9C2wnaVKc3XeVAMY1658U0c4bDOlRvEpok8z1ysEwd5gqlHaNekVdonPdHxweaKHAVEnuwP+ULD/s3UQUcbFwsmr9MnI+no+TV1u9C9RfYnpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525237; c=relaxed/simple;
	bh=en7K10ckYeDUG2Rlh3v0vqhzfQh59lM1wzfBiNwFok0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ch3xwHWF7kWzKbQ3ZpL+jCNVK+/r/akAXtHFSkd8ndokAHnJZSokab85gf48a0PeEpmFKPwaedYDGgFKLz0N2BLR6uvGfYH0Pb4hR+7WQYSvK+0L1Q9Lp96EGSSWblq4CtVqiJc7socRbduFYeEXWydu1+Tn5xTvmYRx69aphcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lsd7Zf1W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722525235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fcSvZvdlSFdDyyiEBzzBsgUxxe7CTijgBJBmE7uQcEE=;
	b=Lsd7Zf1WwK281igfOBQOTLeTnwiMEdxTpOEz2z9jO0/WZR2J6LCgkJbPlx30mfplBGqX9s
	9UcXWO+EVvB5eCGeyV8qyIoDy3YUDOPbG+Tq/EpeVHMnhOPXhI1+o42QxEbAxWxlsgY2xM
	t1IZ1kncF0QmMfgeOCANiNWoq3x9tuo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-NCBlfO7mPEuVSmimOLK9TQ-1; Thu, 01 Aug 2024 11:13:53 -0400
X-MC-Unique: NCBlfO7mPEuVSmimOLK9TQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ef23969070so81709481fa.3
        for <linux-block@vger.kernel.org>; Thu, 01 Aug 2024 08:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525231; x=1723130031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcSvZvdlSFdDyyiEBzzBsgUxxe7CTijgBJBmE7uQcEE=;
        b=psxKJEMGlCrXKtWa0v9GtWZYBEQ/yBHa8bGoY1UjIfjE9h91ta0hWbVCZg0+0D48dV
         g2OrOXaDBdrjt7Ni5A3ozZDUyvN/JZGYWrzmIKQXSpjamQP7StFPv6TI0ooWaD4Gs2ts
         oAB2Zp1HDv6lYloK1rdzyLd9F1k5V4PRh/4rETA2kBjj9Vw/LIXTK660oM1643rdsKYp
         jkoSjGS0uRhr5+SP/avvNKLxCr1Th+w6OJAVLKGDuCsLlj2oYLDGcM7Vl4wtjItvFddP
         g7Nz7Xn87sOqBNeBDwWKTZiD/gzszpQyBDGlLpG85ZSXA6wM1++gXOgK/5qGCIhSHALU
         Qfjw==
X-Forwarded-Encrypted: i=1; AJvYcCUX4V0OnlUVhc9b1EGnSii4QKlGlid+2TfMmGEQd7dN+4XumnJbMT5mIYHzEkTz7b2th8+INETUGlxe/dTuIFQrYDg5PkCiD4P1JtU=
X-Gm-Message-State: AOJu0YyQUZTjaaiA10if6NqlGh6hkkV7jz68Ex7MBP2WydW3/AIzmpQu
	GIaNzzSxJAB7Hxrgbv6Szi+NJsxOe7Xfe3IEBtl9EIuXYNQQo2cQXj7atAqQez23nIbKnfmhCYQ
	xt360rTcAto52ewmf+yUT+tTYluth09nUPflp4ORJgnLOl7YsQetDWXZhnXwqimlwl2P1
X-Received: by 2002:a2e:b60a:0:b0:2ee:52f4:266 with SMTP id 38308e7fff4ca-2f15aa88b39mr5797921fa.3.1722525231212;
        Thu, 01 Aug 2024 08:13:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO012i5Ii2XjdsVJlFVrOJAlhTgOIzD9pHD30f8f8aKqy6GKhPVT49P1m7D9b22LVkm3nE4Q==
X-Received: by 2002:a2e:b60a:0:b0:2ee:52f4:266 with SMTP id 38308e7fff4ca-2f15aa88b39mr5797481fa.3.1722525230280;
        Thu, 01 Aug 2024 08:13:50 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:b4e2:f32f:7caa:572:123e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7d9fa886e2sm209412566b.49.2024.08.01.08.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 08:13:49 -0700 (PDT)
Date: Thu, 1 Aug 2024 11:13:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: stefanha@redhat.com, virtualization@lists.linux.dev, axboe@kernel.dk,
	kvm@vger.kernel.org, linux-block@vger.kernel.org, oren@nvidia.com
Subject: Re: [PATCH 1/1] virtio_blk: implement init_hctx MQ operation
Message-ID: <20240801111337-mutt-send-email-mst@kernel.org>
References: <20240801151137.14430-1-mgurtovoy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801151137.14430-1-mgurtovoy@nvidia.com>

On Thu, Aug 01, 2024 at 06:11:37PM +0300, Max Gurtovoy wrote:
> In this operation set the driver data of the hctx to point to the virtio
> block queue. By doing so, we can use this reference in the and reduce

in the .... ?

> the number of operations in the fast path.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  drivers/block/virtio_blk.c | 42 ++++++++++++++++++++------------------
>  1 file changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 2351f411fa46..35a7a586f6f5 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -129,14 +129,6 @@ static inline blk_status_t virtblk_result(u8 status)
>  	}
>  }
>  
> -static inline struct virtio_blk_vq *get_virtio_blk_vq(struct blk_mq_hw_ctx *hctx)
> -{
> -	struct virtio_blk *vblk = hctx->queue->queuedata;
> -	struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> -
> -	return vq;
> -}
> -
>  static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr)
>  {
>  	struct scatterlist out_hdr, in_hdr, *sgs[3];
> @@ -377,8 +369,7 @@ static void virtblk_done(struct virtqueue *vq)
>  
>  static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
>  {
> -	struct virtio_blk *vblk = hctx->queue->queuedata;
> -	struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> +	struct virtio_blk_vq *vq = hctx->driver_data;
>  	bool kick;
>  
>  	spin_lock_irq(&vq->lock);
> @@ -428,10 +419,10 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>  			   const struct blk_mq_queue_data *bd)
>  {
>  	struct virtio_blk *vblk = hctx->queue->queuedata;
> +	struct virtio_blk_vq *vq = hctx->driver_data;
>  	struct request *req = bd->rq;
>  	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
>  	unsigned long flags;
> -	int qid = hctx->queue_num;
>  	bool notify = false;
>  	blk_status_t status;
>  	int err;
> @@ -440,26 +431,26 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	if (unlikely(status))
>  		return status;
>  
> -	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
> -	err = virtblk_add_req(vblk->vqs[qid].vq, vbr);
> +	spin_lock_irqsave(&vq->lock, flags);
> +	err = virtblk_add_req(vq->vq, vbr);
>  	if (err) {
> -		virtqueue_kick(vblk->vqs[qid].vq);
> +		virtqueue_kick(vq->vq);
>  		/* Don't stop the queue if -ENOMEM: we may have failed to
>  		 * bounce the buffer due to global resource outage.
>  		 */
>  		if (err == -ENOSPC)
>  			blk_mq_stop_hw_queue(hctx);
> -		spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
> +		spin_unlock_irqrestore(&vq->lock, flags);
>  		virtblk_unmap_data(req, vbr);
>  		return virtblk_fail_to_queue(req, err);
>  	}
>  
> -	if (bd->last && virtqueue_kick_prepare(vblk->vqs[qid].vq))
> +	if (bd->last && virtqueue_kick_prepare(vq->vq))
>  		notify = true;
> -	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
> +	spin_unlock_irqrestore(&vq->lock, flags);
>  
>  	if (notify)
> -		virtqueue_notify(vblk->vqs[qid].vq);
> +		virtqueue_notify(vq->vq);
>  	return BLK_STS_OK;
>  }
>  
> @@ -504,7 +495,7 @@ static void virtio_queue_rqs(struct request **rqlist)
>  	struct request *requeue_list = NULL;
>  
>  	rq_list_for_each_safe(rqlist, req, next) {
> -		struct virtio_blk_vq *vq = get_virtio_blk_vq(req->mq_hctx);
> +		struct virtio_blk_vq *vq = req->mq_hctx->driver_data;
>  		bool kick;
>  
>  		if (!virtblk_prep_rq_batch(req)) {
> @@ -1164,6 +1155,16 @@ static const struct attribute_group *virtblk_attr_groups[] = {
>  	NULL,
>  };
>  
> +static int virtblk_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
> +		unsigned int hctx_idx)
> +{
> +	struct virtio_blk *vblk = data;
> +	struct virtio_blk_vq *vq = &vblk->vqs[hctx_idx];
> +
> +	hctx->driver_data = vq;
> +	return 0;
> +}
> +
>  static void virtblk_map_queues(struct blk_mq_tag_set *set)
>  {
>  	struct virtio_blk *vblk = set->driver_data;
> @@ -1205,7 +1206,7 @@ static void virtblk_complete_batch(struct io_comp_batch *iob)
>  static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>  {
>  	struct virtio_blk *vblk = hctx->queue->queuedata;
> -	struct virtio_blk_vq *vq = get_virtio_blk_vq(hctx);
> +	struct virtio_blk_vq *vq = hctx->driver_data;
>  	struct virtblk_req *vbr;
>  	unsigned long flags;
>  	unsigned int len;
> @@ -1236,6 +1237,7 @@ static const struct blk_mq_ops virtio_mq_ops = {
>  	.queue_rqs	= virtio_queue_rqs,
>  	.commit_rqs	= virtio_commit_rqs,
>  	.complete	= virtblk_request_done,
> +	.init_hctx	= virtblk_init_hctx,
>  	.map_queues	= virtblk_map_queues,
>  	.poll		= virtblk_poll,
>  };
> -- 
> 2.18.1


