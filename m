Return-Path: <linux-block+bounces-7664-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CC08CD7A9
	for <lists+linux-block@lfdr.de>; Thu, 23 May 2024 17:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F071284A18
	for <lists+linux-block@lfdr.de>; Thu, 23 May 2024 15:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75027224CF;
	Thu, 23 May 2024 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRxyocRZ"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5FF12B89
	for <linux-block@vger.kernel.org>; Thu, 23 May 2024 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479335; cv=none; b=NINaRQhHFbl2HAUz1kJL+O1jSqJ3WZEos5U9wFRi7z4z4mo0FSW8982FTFaCzNkxYMT8mN/A+NPMOSVqgszY0SmGwWQLACR2CvGTNqDv1oT/uKLYqT8JQte8d6xU/XaFJwVsoM/rr3KeS/KKVB71CNq0DOn/KnKQzF0h7ZttpJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479335; c=relaxed/simple;
	bh=1CHa0LLDhw1EOaJGtZFhJV+l49sZMF/QoPVvj1O3wVE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cm97hJGLiKoz5z4EmDlEFVahMclhBz93DlhchDNOWbFw/rqisU/lGoLIH3cAPRNbZwle6LnCYxaVcDoweXesXt6i6FfLf1MHCggb6NQFWgVknOkbuWS81np1a3jo8gdyZrVr11EBZpgZgIbegRvYEqKdbgw9h7YE7MXYe9sZfmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RRxyocRZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716479332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XQUquqtb6nc3Z5Y3SUxZ2nv+ANeQKSKLo7pB44ee164=;
	b=RRxyocRZoNRK4oa3DWQbauMBUrVljIo6acIRPKFPjTyEM5f+kytbc16mvhEdwUhuI53Xkc
	hGHj4NOt7ylyCfbAnnAw/8qfLf023AFf62WdvoOf3l8hquO5hH7eu/+DFyLnp4dcw7stmL
	nBQfeRvn2qrXPFm3ZMa2MeBwltiqW2k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-gGgK3U6JPj2tF8bOxmChaA-1; Thu,
 23 May 2024 11:48:47 -0400
X-MC-Unique: gGgK3U6JPj2tF8bOxmChaA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC6CB3C025C7;
	Thu, 23 May 2024 15:48:46 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 975AC2027019;
	Thu, 23 May 2024 15:48:46 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 81DFB30C1C33; Thu, 23 May 2024 15:48:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 7F03C3FB52;
	Thu, 23 May 2024 17:48:46 +0200 (CEST)
Date: Thu, 23 May 2024 17:48:46 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@kernel.org>, 
    Milan Broz <gmazyland@gmail.com>, linux-block@vger.kernel.org, 
    dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] block: change rq_integrity_vec to respect the
 iterator
In-Reply-To: <9ef7cff7-1ef5-4a3f-a2d5-5d7e28bb8a44@kernel.dk>
Message-ID: <f537bcb-bd99-e741-cf2e-8f5ace404252@redhat.com>
References: <f85e3824-5545-f541-c96d-4352585288a@redhat.com> <c366231-e146-5a2b-1d8a-5936fb2047ca@redhat.com> <8522af2f-fb97-4d0b-9e38-868c572da18a@kernel.dk> <7060a917-6537-4334-4961-601a182bca54@redhat.com> <b1ca89ae-1500-4c3c-bd8a-74e081aa8dd3@kernel.dk>
 <798720bc-bc69-1e1c-8436-474e8a9fb0e8@redhat.com> <9ef7cff7-1ef5-4a3f-a2d5-5d7e28bb8a44@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4



On Thu, 23 May 2024, Jens Axboe wrote:

> On 5/23/24 9:11 AM, Mikulas Patocka wrote:
> >>> @@ -853,16 +855,20 @@ static blk_status_t nvme_prep_rq(struct
> >>>  			goto out_free_cmd;
> >>>  	}
> >>>  
> >>> +#ifdef CONFIG_BLK_DEV_INTEGRITY
> >>>  	if (blk_integrity_rq(req)) {
> >>>  		ret = nvme_map_metadata(dev, req, &iod->cmd);
> >>>  		if (ret)
> >>>  			goto out_unmap_data;
> >>>  	}
> >>> +#endif
> >>
> >> 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) && blk_integrity_rq(req)) {
> >>
> >> ?
> > 
> > That wouldn't work, because the calls to rq_integrity_vec need to be 
> > eliminated by the preprocessor.
> 
> Why not just do this incremental? Cleans up the ifdef mess too, leaving
> only the one actually using rq_integrity_vec in place.
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 5f857cbc95c8..bd56416a7fa8 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -821,10 +821,10 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>  	return ret;
>  }
>  
> -#ifdef CONFIG_BLK_DEV_INTEGRITY
>  static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
>  		struct nvme_command *cmnd)
>  {
> +#ifdef CONFIG_BLK_DEV_INTEGRITY
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>  	struct bio_vec bv = rq_integrity_vec(req);
>  
> @@ -832,9 +832,9 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
>  	if (dma_mapping_error(dev->dev, iod->meta_dma))
>  		return BLK_STS_IOERR;
>  	cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
> +#endif
>  	return BLK_STS_OK;
>  }
> -#endif
>  
>  static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
>  {
> @@ -855,20 +855,16 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
>  			goto out_free_cmd;
>  	}
>  
> -#ifdef CONFIG_BLK_DEV_INTEGRITY
> -	if (blk_integrity_rq(req)) {
> +	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) && blk_integrity_rq(req)) {
>  		ret = nvme_map_metadata(dev, req, &iod->cmd);
>  		if (ret)
>  			goto out_unmap_data;
>  	}
> -#endif
>  
>  	nvme_start_request(req);
>  	return BLK_STS_OK;
> -#ifdef CONFIG_BLK_DEV_INTEGRITY
>  out_unmap_data:
>  	nvme_unmap_data(dev, req);
> -#endif
>  out_free_cmd:
>  	nvme_cleanup_cmd(req);
>  	return ret;
> 
> > Should I change rq_integrity_vec to this? Then, we could get rid of the 
> > ifdefs and let the optimizer remove all calls to rq_integrity_vec.
> > static inline struct bio_vec rq_integrity_vec(struct request *rq)
> > {
> > 	struct bio_vec bv = { };
> > 	return bv;
> > }
> 
> Only if that eliminates runtime checking for !INTEGRITY, which I don't
> thin it will.

It will eliminate the ifdefs. If we are compiling without 
CONFIG_BLK_DEV_INTEGRITY, blk_integrity_rq(req) is inline and it always 
returns 0. So the optimizer will remove anything guarded with "if 
(blk_integrity_rq(req))" - including the calls to nvme_map_metadata and 
rq_integrity_vec.

But we need to provide dummy rq_integrity_vec for the compiler front-end. 
The front-end doesn't know that blk_integrity_rq always returns zero.

So, the patch will be smaller if we get rid of the ifdefs and provide a 
dummy rq_integrity_vec.

Mikulas

> 
> 
> -- 
> Jens Axboe
> 


