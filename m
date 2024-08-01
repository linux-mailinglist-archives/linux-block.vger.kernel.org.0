Return-Path: <linux-block+bounces-10277-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD2F9451CF
	for <lists+linux-block@lfdr.de>; Thu,  1 Aug 2024 19:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055CE287529
	for <lists+linux-block@lfdr.de>; Thu,  1 Aug 2024 17:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184421B9B4B;
	Thu,  1 Aug 2024 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bALiPJws"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75C71B32B7
	for <linux-block@vger.kernel.org>; Thu,  1 Aug 2024 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534384; cv=none; b=l6beH1holEfGdN8mC7zqtjYLihuG6GVV2OvcmAT9YCgmBcIrOe4Ma0C10isCl7rNUAmlFpws5shLW/8a/yPuYHrRtT3j7GHsCO74FT2H++PlpMGJ9iAKxUho4A6lEs2JTfLFSqNLF5ZpUFh6yMoSUCnWi/IqIglpLyEWyfsH6lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534384; c=relaxed/simple;
	bh=S/Mv3Wi0XxKRfho/EEiSu5bKedBF5iWrW1AFWA2W2RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftqlyOPbsGia41t3XEPiTmeEMF51w8Ssg0n+PBB5LlnoM1oXy3ZavwkdgHgVNnNlT4UlbDCPQYRZUtlyiHfVX/pgt4gLof62x+3c9WAvbufzgfQVpC1MXKbbLo2JS8jubdnXaRUGOlZMihCm3wNnAVoAOyckBVPTlYUq7UwlQ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bALiPJws; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722534379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+BLoP++haBF1SBJAkcfrAS/uc+VDIQyGiu5MLwvra18=;
	b=bALiPJws74TuHCDd3pMxGat8SMUXSjzb/TNeMaeY3DsRXMM0YErMnuMl9o1r0jarV+c3SZ
	UUoFZ3DQbbj1/E1PWWwUBusbAKX6hnJ84AhIjwTGu7JgGHV0DpOD/eOtgHIYtc9VPGoDmH
	pDXIaQz/KLzXC7ntQlPfFnW+fu0vuD0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-GXWIZa73POW-cfZD-hIJOA-1; Thu, 01 Aug 2024 13:46:18 -0400
X-MC-Unique: GXWIZa73POW-cfZD-hIJOA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a7ac41d26e7so335172066b.0
        for <linux-block@vger.kernel.org>; Thu, 01 Aug 2024 10:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722534376; x=1723139176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BLoP++haBF1SBJAkcfrAS/uc+VDIQyGiu5MLwvra18=;
        b=M9ftaCTl3VCEQd2vWe2AgKL8B2nGuOgAz50k2CERCWYPy29Gm7rzDgLrZ7gA1WaKNy
         rGGLYMdgDCqeP1SX+fOa4oirCmOMaLLNnPqueDIfGgi2IkXFHtLafM4UHiKl7eA6qhWz
         W1TvaqfowWDB/nEQcM/eKAsj9tNBghzJF1gk4Y631OKI6rBC32uizLpriurF+BI90pdJ
         zQ9SDc52hADh4tAL9cm6CTD/E/bhFWNnfllZVE3htoefa1NcnUkxm6kCLr+HdTA7mDlu
         ZasKPsH6p1kky0fBwpQcroRHl/RzMMuG7rig/8tYKvQKiZrxhZJv5c1kJQRt6tjBrJup
         V0ag==
X-Forwarded-Encrypted: i=1; AJvYcCVTFi8CI6FeEfDNd68ffdjd+Tq5xNqh/hErvT3chzaMfuP5jCwDywHfkLYtoZCc66fsWsz9NUvYSCeuzKL0NQgxv1OdsnKhD+rCjcA=
X-Gm-Message-State: AOJu0YzPWaw/4lhl+wqtyrZrc5MiG79e0kvlfnnoDFSXFDpTsJGBOY50
	+SUbAZ2xYN/IFgyy7YxvfaXsymU3YaGw2UAZL0KGMCoyi6oYzGazXVK2/NxNOGvA3anBN2nfKhk
	fSDiyWfjr/NDISLzjnNtr4tJaC81O/X6xThdGifHKbpDpnp3vq+glRq7SVxetxhQ+ZTcX
X-Received: by 2002:a17:907:1c29:b0:a72:5f3f:27a2 with SMTP id a640c23a62f3a-a7dc6245605mr68398966b.26.1722534376012;
        Thu, 01 Aug 2024 10:46:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGluWoPoZuFojIcMYbcrlIlUC2pOTT8jJXDWoMiqz8L4MVa8bpMy/PKXPNWhUL6AruwHt/8/A==
X-Received: by 2002:a17:907:1c29:b0:a72:5f3f:27a2 with SMTP id a640c23a62f3a-a7dc6245605mr68396966b.26.1722534375136;
        Thu, 01 Aug 2024 10:46:15 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:b4e2:f32f:7caa:572:123e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec8dafsm5085966b.220.2024.08.01.10.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 10:46:14 -0700 (PDT)
Date: Thu, 1 Aug 2024 13:46:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: stefanha@redhat.com, virtualization@lists.linux.dev, axboe@kernel.dk,
	kvm@vger.kernel.org, linux-block@vger.kernel.org, oren@nvidia.com
Subject: Re: [PATCH 1/1] virtio_blk: implement init_hctx MQ operation
Message-ID: <20240801133937-mutt-send-email-mst@kernel.org>
References: <20240801151137.14430-1-mgurtovoy@nvidia.com>
 <20240801111337-mutt-send-email-mst@kernel.org>
 <0888da3b-3283-405b-b1a8-a315e2623289@nvidia.com>
 <20240801112843-mutt-send-email-mst@kernel.org>
 <9400fb28-47c2-4629-af17-df2a95f2d3d8@nvidia.com>
 <20240801114205-mutt-send-email-mst@kernel.org>
 <6a8f0c72-ba77-42c3-8d85-6bb23a23f025@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a8f0c72-ba77-42c3-8d85-6bb23a23f025@nvidia.com>

On Thu, Aug 01, 2024 at 06:56:44PM +0300, Max Gurtovoy wrote:
> 
> On 01/08/2024 18:43, Michael S. Tsirkin wrote:
> 
>     On Thu, Aug 01, 2024 at 06:39:16PM +0300, Max Gurtovoy wrote:
> 
>         On 01/08/2024 18:29, Michael S. Tsirkin wrote:
> 
>             On Thu, Aug 01, 2024 at 06:17:21PM +0300, Max Gurtovoy wrote:
> 
>                 On 01/08/2024 18:13, Michael S. Tsirkin wrote:
> 
>                     On Thu, Aug 01, 2024 at 06:11:37PM +0300, Max Gurtovoy wrote:
> 
>                         In this operation set the driver data of the hctx to point to the virtio
>                         block queue. By doing so, we can use this reference in the and reduce
> 
>                     in the .... ?
> 
>                 sorry for the type.
> 
>                 should be :
> 
>                 "By doing so, we can use this reference and reduce the number of operations in the fast path."
> 
>             ok. what kind of benefit do you see with this patch?
> 
>         As mentioned. This is a micro optimization that reduce the number of
>         instructions/dereferences in the fast path.
> 
>     By how much? How random code tweaks affect object code is unpredictable.
>     Pls show results of objdump to prove it does anything
>     useful.
> 
> This is the way all modern block drivers such as NVMe PCI/RDMA/TCP use the
> driver_data.
> 
> These drivers don't have driver specific mechanisms to find the queue from the 
> hctx->queue->queuedata like vblk driver has for some unknown reason.
> 
> It is pretty easy to review this patch and see its benefits, isn't it ?
> 
> It is not expected to provide extreme perf improvement.
> 
> It is introduced for aligning the driver to use common MQ mechanisms and reduce
> dereferences.
> 
> This is not "random code tweaks".


Then pls say so in the commit log.

Look I don't have anything for or against this patch.

I do however want to establish that if something is billed as
an "optimization" it has to come with numbers (even if
it's as simple as "size" run on the object file).

If it's just cleaner/simpler, say so.


I'll wait for an ack from Paolo/Stefan, anyway.



>                         the number of operations in the fast path.
> 
>                         Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>                         ---
>                            drivers/block/virtio_blk.c | 42 ++++++++++++++++++++------------------
>                            1 file changed, 22 insertions(+), 20 deletions(-)
> 
>                         diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>                         index 2351f411fa46..35a7a586f6f5 100644
>                         --- a/drivers/block/virtio_blk.c
>                         +++ b/drivers/block/virtio_blk.c
>                         @@ -129,14 +129,6 @@ static inline blk_status_t virtblk_result(u8 status)
>                                 }
>                            }
>                         -static inline struct virtio_blk_vq *get_virtio_blk_vq(struct blk_mq_hw_ctx *hctx)
>                         -{
>                         -       struct virtio_blk *vblk = hctx->queue->queuedata;
>                         -       struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
>                         -
>                         -       return vq;
>                         -}
>                         -
>                            static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr)
>                            {
>                                 struct scatterlist out_hdr, in_hdr, *sgs[3];
>                         @@ -377,8 +369,7 @@ static void virtblk_done(struct virtqueue *vq)
>                            static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
>                            {
>                         -       struct virtio_blk *vblk = hctx->queue->queuedata;
>                         -       struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
>                         +       struct virtio_blk_vq *vq = hctx->driver_data;
>                                 bool kick;
>                                 spin_lock_irq(&vq->lock);
>                         @@ -428,10 +419,10 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>                                                    const struct blk_mq_queue_data *bd)
>                            {
>                                 struct virtio_blk *vblk = hctx->queue->queuedata;
>                         +       struct virtio_blk_vq *vq = hctx->driver_data;
>                                 struct request *req = bd->rq;
>                                 struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
>                                 unsigned long flags;
>                         -       int qid = hctx->queue_num;
>                                 bool notify = false;
>                                 blk_status_t status;
>                                 int err;
>                         @@ -440,26 +431,26 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>                                 if (unlikely(status))
>                                         return status;
>                         -       spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
>                         -       err = virtblk_add_req(vblk->vqs[qid].vq, vbr);
>                         +       spin_lock_irqsave(&vq->lock, flags);
>                         +       err = virtblk_add_req(vq->vq, vbr);
>                                 if (err) {
>                         -               virtqueue_kick(vblk->vqs[qid].vq);
>                         +               virtqueue_kick(vq->vq);
>                                         /* Don't stop the queue if -ENOMEM: we may have failed to
>                                          * bounce the buffer due to global resource outage.
>                                          */
>                                         if (err == -ENOSPC)
>                                                 blk_mq_stop_hw_queue(hctx);
>                         -               spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
>                         +               spin_unlock_irqrestore(&vq->lock, flags);
>                                         virtblk_unmap_data(req, vbr);
>                                         return virtblk_fail_to_queue(req, err);
>                                 }
>                         -       if (bd->last && virtqueue_kick_prepare(vblk->vqs[qid].vq))
>                         +       if (bd->last && virtqueue_kick_prepare(vq->vq))
>                                         notify = true;
>                         -       spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
>                         +       spin_unlock_irqrestore(&vq->lock, flags);
>                                 if (notify)
>                         -               virtqueue_notify(vblk->vqs[qid].vq);
>                         +               virtqueue_notify(vq->vq);
>                                 return BLK_STS_OK;
>                            }
>                         @@ -504,7 +495,7 @@ static void virtio_queue_rqs(struct request **rqlist)
>                                 struct request *requeue_list = NULL;
>                                 rq_list_for_each_safe(rqlist, req, next) {
>                         -               struct virtio_blk_vq *vq = get_virtio_blk_vq(req->mq_hctx);
>                         +               struct virtio_blk_vq *vq = req->mq_hctx->driver_data;
>                                         bool kick;
>                                         if (!virtblk_prep_rq_batch(req)) {
>                         @@ -1164,6 +1155,16 @@ static const struct attribute_group *virtblk_attr_groups[] = {
>                                 NULL,
>                            };
>                         +static int virtblk_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
>                         +               unsigned int hctx_idx)
>                         +{
>                         +       struct virtio_blk *vblk = data;
>                         +       struct virtio_blk_vq *vq = &vblk->vqs[hctx_idx];
>                         +
>                         +       hctx->driver_data = vq;
>                         +       return 0;
>                         +}
>                         +
>                            static void virtblk_map_queues(struct blk_mq_tag_set *set)
>                            {
>                                 struct virtio_blk *vblk = set->driver_data;
>                         @@ -1205,7 +1206,7 @@ static void virtblk_complete_batch(struct io_comp_batch *iob)
>                            static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>                            {
>                                 struct virtio_blk *vblk = hctx->queue->queuedata;
>                         -       struct virtio_blk_vq *vq = get_virtio_blk_vq(hctx);
>                         +       struct virtio_blk_vq *vq = hctx->driver_data;
>                                 struct virtblk_req *vbr;
>                                 unsigned long flags;
>                                 unsigned int len;
>                         @@ -1236,6 +1237,7 @@ static const struct blk_mq_ops virtio_mq_ops = {
>                                 .queue_rqs      = virtio_queue_rqs,
>                                 .commit_rqs     = virtio_commit_rqs,
>                                 .complete       = virtblk_request_done,
>                         +       .init_hctx      = virtblk_init_hctx,
>                                 .map_queues     = virtblk_map_queues,
>                                 .poll           = virtblk_poll,
>                            };
>                         --
>                         2.18.1
> 


