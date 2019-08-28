Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACE109FE4E
	for <lists+linux-block@lfdr.de>; Wed, 28 Aug 2019 11:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfH1JVL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 28 Aug 2019 05:21:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62009 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbfH1JVL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Aug 2019 05:21:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 635EF4E83E;
        Wed, 28 Aug 2019 09:21:11 +0000 (UTC)
Received: from ming.t460p (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 510B71001938;
        Wed, 28 Aug 2019 09:21:02 +0000 (UTC)
Date:   Wed, 28 Aug 2019 17:20:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Gopal Tiwari <gtiwari@redhat.com>, dmilburn@redhat.com
Subject: Re: [PATCH 10/15] nvme-pci: do not build a scatterlist to map
 metadata
Message-ID: <20190828092057.GA15524@ming.t460p>
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321231037.25104-11-hch@lst.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 28 Aug 2019 09:21:11 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 21, 2019 at 04:10:32PM -0700, Christoph Hellwig wrote:
> We always have exactly one segment, so we can simply call dma_map_bvec.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index bc4ee869fe82..a7dad24e0406 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -221,7 +221,7 @@ struct nvme_iod {
>  	int npages;		/* In the PRP list. 0 means small pool in use */
>  	int nents;		/* Used in scatterlist */
>  	dma_addr_t first_dma;
> -	struct scatterlist meta_sg; /* metadata requires single contiguous buffer */
> +	dma_addr_t meta_dma;
>  	struct scatterlist *sg;
>  	struct scatterlist inline_sg[0];
>  };
> @@ -592,13 +592,16 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
>  	dma_addr_t dma_addr = iod->first_dma, next_dma_addr;
>  	int i;
>  
> +	if (blk_integrity_rq(req)) {
> +		dma_unmap_page(dev->dev, iod->meta_dma,
> +				rq_integrity_vec(req)->bv_len, dma_dir);
> +	}
> +
>  	if (iod->nents) {
>  		/* P2PDMA requests do not need to be unmapped */
>  		if (!is_pci_p2pdma_page(sg_page(iod->sg)))
>  			dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
>  
> -		if (blk_integrity_rq(req))
> -			dma_unmap_sg(dev->dev, &iod->meta_sg, 1, dma_dir);
>  	}
>  
>  	if (iod->npages == 0)
> @@ -861,17 +864,11 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>  
>  	ret = BLK_STS_IOERR;
>  	if (blk_integrity_rq(req)) {
> -		if (blk_rq_count_integrity_sg(q, req->bio) != 1)
> -			goto out;
> -
> -		sg_init_table(&iod->meta_sg, 1);
> -		if (blk_rq_map_integrity_sg(q, req->bio, &iod->meta_sg) != 1)
> -			goto out;
> -
> -		if (!dma_map_sg(dev->dev, &iod->meta_sg, 1, dma_dir))
> +		iod->meta_dma = dma_map_bvec(dev->dev, rq_integrity_vec(req),
> +				dma_dir, 0);

Hi Christoph,

When one bio is enough big, the generated integrity data could cross
more than one pages even though the data is still in single segment.

However, we don't convert to multi-page bvec for bio_integrity_prep(),
and each page may consume one bvec, so is it possible for this patch to
cause issues in case of NVMe's protection? Since this patch supposes
that there is only one bvec for integrity data.

BTW, not see such kind of report, just a concern in theory.

thanks,
Ming
