Return-Path: <linux-block+bounces-18362-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 634CFA5F404
	for <lists+linux-block@lfdr.de>; Thu, 13 Mar 2025 13:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDECD19C199D
	for <lists+linux-block@lfdr.de>; Thu, 13 Mar 2025 12:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BC8266F15;
	Thu, 13 Mar 2025 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VT4fPc+D"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B669266EF8
	for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 12:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868158; cv=none; b=JN4IaB2v1hJI61MvNlFmJphFbfAYyIoyQBTRVag9LXsQRdbYCOMpg5ZY+4D58oSppNi9+PQp3Y91eKn3NGbV76uN2Uy373hOCSvAq7b+9PZUnv2JJ/UIJiZW+Db5oebr4at91EuSb9CToRF6OooL4Oh8bnJP0RbQqRdYSySXB4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868158; c=relaxed/simple;
	bh=vp5MZTmroiuBdvR0ttdRG0jnr2uZNkSNRW9eKcTZPEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HmNa+EwV623DoXCIJdl4KKSXcpKdmZbo/fGicAp7r4ARyo3uQLj/bO+ZxFD3LEv7USe3HQqkfL4/SGelo/GRf82v6r2rPa4ZnbfAq92LlLynlaeFGVS7AQQXNxPKYiN9g4QQmzyujWk0ZpLtE2FBPJLrMKLXmIUbblAJVTSUWyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VT4fPc+D; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6fee63b9139so8249727b3.1
        for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 05:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741868151; x=1742472951; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Oxo4nRaNKlTff6Ix3Ee9t1VjmVf7/i10eQiNoUZabVo=;
        b=VT4fPc+DPLi79SHdfV7xvzO/spCKw5YsEqZC8zyp96um+pfKZrJbCL5yNpNsW3YUUc
         8Q1VZaJkd0j29pSKombRliV0OzGGBDQTPii/lxnUMW3KzGglLnQ9J8truKAvielmFx9S
         Dx1FayxUdVmOiyu/9lS58IyOV0HZd6ku1IVi6ih5fVUvSC9CZOieBQxtX3rCBrZXPySN
         nl0sTKXKVzfB2h2H3CoKENtKR/FTVnc7TCeSnUOov/ixRFC8QEpqVfrchVUtT8lAJCfW
         IFNG1ZYoMZerH/NmdBUtBljHy4ZCEuRtQTC0Lqc2fLnWjWrh85F/Qw0rRsqTo8WaTJY6
         QqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741868151; x=1742472951;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oxo4nRaNKlTff6Ix3Ee9t1VjmVf7/i10eQiNoUZabVo=;
        b=KVJVnb2fKcy96vWxXNXLzg+AwdcvgGX2Ugpo4to8VqKUko1RACCQDm+x2Oawy2ujkV
         foyGeL7cie0ZbJc+SmtOrMh9BKkaO/DRntVVipbvSM1kFLhA2X0ZMivZY0jwk7XOQ9Fw
         aS+peWnci2pBNYEyjxoiq/k0NtIcbDrTKzDnS00/t+y+iTm13NY5NfuK/GE2NXeujXge
         hlemftp0idj22VeuXgX7/vkFWdj0yHoYUSTWsrQfgh9QHXO5m8KVfrh3017bpxlUoxmF
         2iJEEtf48j2A2ECC9Kcu3oGOCQagvwK26hX9qpzLpCqTkqABP0ypb4FF7okQ7ACjqJMM
         DDGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiysocpjd5i+DVHCrVkBeFi7rmCooeY2OmkAK/YmzbXYv7kModzE+EobzsC847EttRH3GRm+mar74gOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvYZTD3OAMK2mZifI9uKyoKni4re5VfUoGv2M4I3zW3hvR4761
	noEb4tFE5rhmLS5vlajFNigKJhlhPjMaM6O0pZ6TnGs6ocP2/MFU1IzgcKXODGwu3W0nGbGW/j/
	NWgKOa07aMoEFlIz3jZIiPcSjVXHPSczoKCCp1A==
X-Gm-Gg: ASbGncsREf4yxlM2fhKJPqVzaQBDg1RlQW5wwXkzyaqqB/68L3IQ4EJDRIuroNcQh1v
	GpBw6+pvB0UsyJ7uufLVcfQH87CJ3HO44pOny6e7zdeRXIGph3RQoxGt/QqBENLsguMoQxRmOx4
	aNnmp3Lrgr3jIEYazOn7Ypb1lRD2c=
X-Google-Smtp-Source: AGHT+IH+g4YhUvJzDDM8IF19825mFy84oTJJNtvmLZ+edTkcRlAfOhjQ33xlQord/MYk0nTfcCGUgTiOxucg/kuf8R8=
X-Received: by 2002:a05:690c:6389:b0:6fe:c4bd:e2ca with SMTP id
 00721157ae682-6ff2f80f6f8mr30294897b3.14.1741868151300; Thu, 13 Mar 2025
 05:15:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250313040150epcas5p347f94dac34fd2946dea51049559ee1de@epcas5p3.samsung.com>
 <20250313035322.243239-1-anuj20.g@samsung.com>
In-Reply-To: <20250313035322.243239-1-anuj20.g@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 13 Mar 2025 13:15:15 +0100
X-Gm-Features: AQ5f1JqMiJUg0zYIlcoPjPPIUUYi7aY9XoeZibdDJNGexKsNoy8AEu5lVvN-wm8
Message-ID: <CAPDyKFqdK0OPKkTK5C5b1_9kXNSkXJKBvBSa80eXj+GpNfEKBg@mail.gmail.com>
Subject: Re: [PATCH] block: remove unused parameter
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
	Jack Wang <jinpu.wang@ionos.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Maxim Levitsky <maximlevitsky@gmail.com>, 
	Alex Dubov <oakad@yahoo.com>, Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mmc@vger.kernel.org, 
	linux-mtd@lists.infradead.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Mar 2025 at 06:13, Anuj Gupta <anuj20.g@samsung.com> wrote:
>
> request_queue param is not used by blk_rq_map_sg and __blk_rq_map_sg.
> remove it.
>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For MMC/MEMSTICK

> ---
>  block/blk-merge.c                   | 4 ++--
>  block/bsg-lib.c                     | 2 +-
>  drivers/block/mtip32xx/mtip32xx.c   | 2 +-
>  drivers/block/rnbd/rnbd-clt.c       | 2 +-
>  drivers/block/sunvdc.c              | 2 +-
>  drivers/block/virtio_blk.c          | 2 +-
>  drivers/block/xen-blkfront.c        | 2 +-
>  drivers/memstick/core/ms_block.c    | 2 +-
>  drivers/memstick/core/mspro_block.c | 4 +---
>  drivers/mmc/core/queue.c            | 2 +-
>  drivers/mtd/ubi/block.c             | 2 +-
>  drivers/nvme/host/apple.c           | 2 +-
>  drivers/nvme/host/fc.c              | 2 +-
>  drivers/nvme/host/pci.c             | 2 +-
>  drivers/nvme/host/rdma.c            | 3 +--
>  drivers/nvme/target/loop.c          | 2 +-
>  drivers/scsi/scsi_lib.c             | 2 +-
>  include/linux/blk-mq.h              | 9 ++++-----
>  18 files changed, 22 insertions(+), 26 deletions(-)
>
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 1d1589c35297..fdd4efb54c6c 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -551,8 +551,8 @@ static inline struct scatterlist *blk_next_sg(struct scatterlist **sg,
>   * Map a request to scatterlist, return number of sg entries setup. Caller
>   * must make sure sg can hold rq->nr_phys_segments entries.
>   */
> -int __blk_rq_map_sg(struct request_queue *q, struct request *rq,
> -               struct scatterlist *sglist, struct scatterlist **last_sg)
> +int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
> +                   struct scatterlist **last_sg)
>  {
>         struct req_iterator iter = {
>                 .bio    = rq->bio,
> diff --git a/block/bsg-lib.c b/block/bsg-lib.c
> index 93523d8f8195..9ceb5d0832f5 100644
> --- a/block/bsg-lib.c
> +++ b/block/bsg-lib.c
> @@ -219,7 +219,7 @@ static int bsg_map_buffer(struct bsg_buffer *buf, struct request *req)
>         if (!buf->sg_list)
>                 return -ENOMEM;
>         sg_init_table(buf->sg_list, req->nr_phys_segments);
> -       buf->sg_cnt = blk_rq_map_sg(req->q, req, buf->sg_list);
> +       buf->sg_cnt = blk_rq_map_sg(req, buf->sg_list);
>         buf->payload_len = blk_rq_bytes(req);
>         return 0;
>  }
> diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
> index 95361099a2dc..0d619df03fa9 100644
> --- a/drivers/block/mtip32xx/mtip32xx.c
> +++ b/drivers/block/mtip32xx/mtip32xx.c
> @@ -2056,7 +2056,7 @@ static void mtip_hw_submit_io(struct driver_data *dd, struct request *rq,
>         unsigned int nents;
>
>         /* Map the scatter list for DMA access */
> -       nents = blk_rq_map_sg(hctx->queue, rq, command->sg);
> +       nents = blk_rq_map_sg(rq, command->sg);
>         nents = dma_map_sg(&dd->pdev->dev, command->sg, nents, dma_dir);
>
>         prefetch(&port->flags);
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index 82467ecde7ec..15627417f12e 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -1010,7 +1010,7 @@ static int rnbd_client_xfer_request(struct rnbd_clt_dev *dev,
>          * See queue limits.
>          */
>         if ((req_op(rq) != REQ_OP_DISCARD) && (req_op(rq) != REQ_OP_WRITE_ZEROES))
> -               sg_cnt = blk_rq_map_sg(dev->queue, rq, iu->sgt.sgl);
> +               sg_cnt = blk_rq_map_sg(rq, iu->sgt.sgl);
>
>         if (sg_cnt == 0)
>                 sg_mark_end(&iu->sgt.sgl[0]);
> diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
> index 282f81616a78..2b33fb5b949b 100644
> --- a/drivers/block/sunvdc.c
> +++ b/drivers/block/sunvdc.c
> @@ -485,7 +485,7 @@ static int __send_request(struct request *req)
>         }
>
>         sg_init_table(sg, port->ring_cookies);
> -       nsg = blk_rq_map_sg(req->q, req, sg);
> +       nsg = blk_rq_map_sg(req, sg);
>
>         len = 0;
>         for (i = 0; i < nsg; i++)
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 6a61ec35f426..a3df4d49bd46 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -226,7 +226,7 @@ static int virtblk_map_data(struct blk_mq_hw_ctx *hctx, struct request *req,
>         if (unlikely(err))
>                 return -ENOMEM;
>
> -       return blk_rq_map_sg(hctx->queue, req, vbr->sg_table.sgl);
> +       return blk_rq_map_sg(req, vbr->sg_table.sgl);
>  }
>
>  static void virtblk_cleanup_cmd(struct request *req)
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index edcd08a9dcef..5babe575c288 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -751,7 +751,7 @@ static int blkif_queue_rw_req(struct request *req, struct blkfront_ring_info *ri
>         id = blkif_ring_get_request(rinfo, req, &final_ring_req);
>         ring_req = &rinfo->shadow[id].req;
>
> -       num_sg = blk_rq_map_sg(req->q, req, rinfo->shadow[id].sg);
> +       num_sg = blk_rq_map_sg(req, rinfo->shadow[id].sg);
>         num_grant = 0;
>         /* Calculate the number of grant used */
>         for_each_sg(rinfo->shadow[id].sg, sg, num_sg, i)
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
> index 5b617c1f6789..f4398383ae06 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -1904,7 +1904,7 @@ static void msb_io_work(struct work_struct *work)
>
>                 /* process the request */
>                 dbg_verbose("IO: processing new request");
> -               blk_rq_map_sg(msb->queue, req, sg);
> +               blk_rq_map_sg(req, sg);
>
>                 lba = blk_rq_pos(req);
>
> diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
> index 634d343b6bdb..c9853d887d28 100644
> --- a/drivers/memstick/core/mspro_block.c
> +++ b/drivers/memstick/core/mspro_block.c
> @@ -627,9 +627,7 @@ static int mspro_block_issue_req(struct memstick_dev *card)
>         while (true) {
>                 msb->current_page = 0;
>                 msb->current_seg = 0;
> -               msb->seg_count = blk_rq_map_sg(msb->block_req->q,
> -                                              msb->block_req,
> -                                              msb->req_sg);
> +               msb->seg_count = blk_rq_map_sg(msb->block_req, msb->req_sg);
>
>                 if (!msb->seg_count) {
>                         unsigned int bytes = blk_rq_cur_bytes(msb->block_req);
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index ab662f502fe7..3ba62f825b84 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -523,5 +523,5 @@ unsigned int mmc_queue_map_sg(struct mmc_queue *mq, struct mmc_queue_req *mqrq)
>  {
>         struct request *req = mmc_queue_req_to_req(mqrq);
>
> -       return blk_rq_map_sg(mq->queue, req, mqrq->sg);
> +       return blk_rq_map_sg(req, mqrq->sg);
>  }
> diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
> index 2836905f0152..39cc0a6a4d37 100644
> --- a/drivers/mtd/ubi/block.c
> +++ b/drivers/mtd/ubi/block.c
> @@ -199,7 +199,7 @@ static blk_status_t ubiblock_read(struct request *req)
>          * and ubi_read_sg() will check that limit.
>          */
>         ubi_sgl_init(&pdu->usgl);
> -       blk_rq_map_sg(req->q, req, pdu->usgl.sg);
> +       blk_rq_map_sg(req, pdu->usgl.sg);
>
>         while (bytes_left) {
>                 /*
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index a060f69558e7..a437eee741e1 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -525,7 +525,7 @@ static blk_status_t apple_nvme_map_data(struct apple_nvme *anv,
>         if (!iod->sg)
>                 return BLK_STS_RESOURCE;
>         sg_init_table(iod->sg, blk_rq_nr_phys_segments(req));
> -       iod->nents = blk_rq_map_sg(req->q, req, iod->sg);
> +       iod->nents = blk_rq_map_sg(req, iod->sg);
>         if (!iod->nents)
>                 goto out_free_sg;
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index b9929a5a7f4e..1b5ad1173bc7 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2571,7 +2571,7 @@ nvme_fc_map_data(struct nvme_fc_ctrl *ctrl, struct request *rq,
>         if (ret)
>                 return -ENOMEM;
>
> -       op->nents = blk_rq_map_sg(rq->q, rq, freq->sg_table.sgl);
> +       op->nents = blk_rq_map_sg(rq, freq->sg_table.sgl);
>         WARN_ON(op->nents > blk_rq_nr_phys_segments(rq));
>         freq->sg_cnt = fc_dma_map_sg(ctrl->lport->dev, freq->sg_table.sgl,
>                                 op->nents, rq_dma_dir(rq));
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 950289405ef2..a0b1c57067aa 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -812,7 +812,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>         if (!iod->sgt.sgl)
>                 return BLK_STS_RESOURCE;
>         sg_init_table(iod->sgt.sgl, blk_rq_nr_phys_segments(req));
> -       iod->sgt.orig_nents = blk_rq_map_sg(req->q, req, iod->sgt.sgl);
> +       iod->sgt.orig_nents = blk_rq_map_sg(req, iod->sgt.sgl);
>         if (!iod->sgt.orig_nents)
>                 goto out_free_sg;
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 86a2891d9bcc..b5a0295b5bf4 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1476,8 +1476,7 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
>         if (ret)
>                 return -ENOMEM;
>
> -       req->data_sgl.nents = blk_rq_map_sg(rq->q, rq,
> -                                           req->data_sgl.sg_table.sgl);
> +       req->data_sgl.nents = blk_rq_map_sg(rq, req->data_sgl.sg_table.sgl);
>
>         *count = ib_dma_map_sg(ibdev, req->data_sgl.sg_table.sgl,
>                                req->data_sgl.nents, rq_dma_dir(rq));
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index a9d112d34d4f..a5c41144667c 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -162,7 +162,7 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
>                 }
>
>                 iod->req.sg = iod->sg_table.sgl;
> -               iod->req.sg_cnt = blk_rq_map_sg(req->q, req, iod->sg_table.sgl);
> +               iod->req.sg_cnt = blk_rq_map_sg(req, iod->sg_table.sgl);
>                 iod->req.transfer_len = blk_rq_payload_bytes(req);
>         }
>
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index f1cfe0bb89b2..0d29470e86b0 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1149,7 +1149,7 @@ blk_status_t scsi_alloc_sgtables(struct scsi_cmnd *cmd)
>          * Next, walk the list, and fill in the addresses and sizes of
>          * each segment.
>          */
> -       count = __blk_rq_map_sg(rq->q, rq, cmd->sdb.table.sgl, &last_sg);
> +       count = __blk_rq_map_sg(rq, cmd->sdb.table.sgl, &last_sg);
>
>         if (blk_rq_bytes(rq) & rq->q->limits.dma_pad_mask) {
>                 unsigned int pad_len =
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index fa2a76cc2f73..f2eff998913d 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -1165,14 +1165,13 @@ static inline unsigned short blk_rq_nr_discard_segments(struct request *rq)
>         return max_t(unsigned short, rq->nr_phys_segments, 1);
>  }
>
> -int __blk_rq_map_sg(struct request_queue *q, struct request *rq,
> -               struct scatterlist *sglist, struct scatterlist **last_sg);
> -static inline int blk_rq_map_sg(struct request_queue *q, struct request *rq,
> -               struct scatterlist *sglist)
> +int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
> +               struct scatterlist **last_sg);
> +static inline int blk_rq_map_sg(struct request *rq, struct scatterlist *sglist)
>  {
>         struct scatterlist *last_sg = NULL;
>
> -       return __blk_rq_map_sg(q, rq, sglist, &last_sg);
> +       return __blk_rq_map_sg(rq, sglist, &last_sg);
>  }
>  void blk_dump_rq_flags(struct request *, char *);
>
> --
> 2.25.1
>

