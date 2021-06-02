Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72432398395
	for <lists+linux-block@lfdr.de>; Wed,  2 Jun 2021 09:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhFBHvY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 2 Jun 2021 03:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbhFBHvX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jun 2021 03:51:23 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38399C06175F
        for <linux-block@vger.kernel.org>; Wed,  2 Jun 2021 00:49:40 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id o5so1780547edc.5
        for <linux-block@vger.kernel.org>; Wed, 02 Jun 2021 00:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IviQGHXbohDYlY4Kaxm/cxlbY44V3tAurEYksJ8dtbE=;
        b=jCNYXrovW1sUHaOT/+lw4PCDhP0eyRFf+ELw7YXWBCDBnLin+ptT9Qqbj9mRkWWaUg
         wGBYm/DlmYSjFuDFdCiAFeYUhwBx3bN1zWIfEq4U/R6NzUaRvMrhsPRnKTgM5MVFJVxB
         CmVxljvKTCN3ZyT1LwzUVWKZgE4x9cRuQaj0TjoJvUnlN68E3Mt+4zAfSoenpZB5Ofxb
         0XLwmhqFLm1lOHsISGA/CxlwAihZibid3kenEAmMklVKKOHOy1nSq3KrSTTjFuaKWHai
         u516kaTGPG4uhGM5WuZ/+lvOuzezIo89jko54Ak3T4r5ol1iQsDze8x0V5mTappbPtSr
         aaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IviQGHXbohDYlY4Kaxm/cxlbY44V3tAurEYksJ8dtbE=;
        b=eoCrMqWnayJu1vuKhG8pIaY2CA3ZJNwN/54+2yt3nBw6pEgR+KFLBui3amrhxHMRXI
         bY2okrutKLD0WlCEH9d1Tc2mNWI2k+ghJyGnGLzXuggCurkXFlC5nWrwfAW4FYAuZZ4t
         DE+aO/NmhRIbrqoH66/Fyg7J7uvElFz9VuKGXbRtFD7JVG7H6IhB3NcD5l2LCIVBEMm5
         u2jFIclJ9/u1Dg7CBxBkcnHETmXTFvt4bKh2d5Jn43h5QG3vNK/p23oMUns6p5ZfGZrO
         rksipi5RYTySNIJhENJ9Xf8n9dg7Ukcf2HYa2hF6uZRiWvQbsSpfO+4KyiYJKpzRjVub
         nogw==
X-Gm-Message-State: AOAM531UMS5gT0e+Ze5aCdGWNpR9uV7jukoPCWKtivT8IwqYc+YYThkn
        qb0jwkqKX2TGLiFRcd0z4swzxY2pni1ddRZPPmr2Ng==
X-Google-Smtp-Source: ABdhPJzRCVGimPnGT3qQlEAMsZsY3IxcZZF186UcWgTyI7ay8iWe4IlRIEG5WowCojeDoPju71hCmgBQ+xR7PgbbWL0=
X-Received: by 2002:aa7:c693:: with SMTP id n19mr33130385edq.35.1622620178044;
 Wed, 02 Jun 2021 00:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210602065345.355274-1-hch@lst.de> <20210602065345.355274-24-hch@lst.de>
In-Reply-To: <20210602065345.355274-24-hch@lst.de>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 2 Jun 2021 09:49:27 +0200
Message-ID: <CAMGffEn7aCmTOTsuzbSr=DwomFKfizkNhzsZnAONHBq1neW2Og@mail.gmail.com>
Subject: Re: [PATCH 23/30] rnbd: use blk_mq_alloc_disk and blk_cleanup_disk
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Justin Sanders <justin@coraid.com>,
        Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Tim Waugh <tim@cyberelk.net>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-block <linux-block@vger.kernel.org>, nbd@other.debian.org,
        linuxppc-dev@lists.ozlabs.org,
        Ceph Development <ceph-devel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 2, 2021 at 8:55 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Use blk_mq_alloc_disk and blk_cleanup_disk to simplify the gendisk and
> request_queue allocation.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/rnbd/rnbd-clt.c | 35 ++++++++---------------------------
>  1 file changed, 8 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index c604a402cd5c..f4fa45d24c0b 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -1353,18 +1353,6 @@ static void rnbd_init_mq_hw_queues(struct rnbd_clt_dev *dev)
>         }
>  }
>
> -static int setup_mq_dev(struct rnbd_clt_dev *dev)
> -{
> -       dev->queue = blk_mq_init_queue(&dev->sess->tag_set);
> -       if (IS_ERR(dev->queue)) {
> -               rnbd_clt_err(dev, "Initializing multiqueue queue failed, err: %ld\n",
> -                             PTR_ERR(dev->queue));
> -               return PTR_ERR(dev->queue);
> -       }
> -       rnbd_init_mq_hw_queues(dev);
> -       return 0;
> -}
> -
>  static void setup_request_queue(struct rnbd_clt_dev *dev)
>  {
>         blk_queue_logical_block_size(dev->queue, dev->logical_block_size);
> @@ -1393,13 +1381,13 @@ static void setup_request_queue(struct rnbd_clt_dev *dev)
>         blk_queue_io_opt(dev->queue, dev->sess->max_io_size);
>         blk_queue_virt_boundary(dev->queue, SZ_4K - 1);
>         blk_queue_write_cache(dev->queue, dev->wc, dev->fua);
> -       dev->queue->queuedata = dev;
>  }
>
>  static void rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev, int idx)
>  {
>         dev->gd->major          = rnbd_client_major;
>         dev->gd->first_minor    = idx << RNBD_PART_BITS;
> +       dev->gd->minors         = 1 << RNBD_PART_BITS;
>         dev->gd->fops           = &rnbd_client_ops;
>         dev->gd->queue          = dev->queue;
>         dev->gd->private_data   = dev;
> @@ -1426,24 +1414,18 @@ static void rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev, int idx)
>
>  static int rnbd_client_setup_device(struct rnbd_clt_dev *dev)
>  {
> -       int err, idx = dev->clt_device_id;
> +       int idx = dev->clt_device_id;
>
>         dev->size = dev->nsectors * dev->logical_block_size;
>
> -       err = setup_mq_dev(dev);
> -       if (err)
> -               return err;
> +       dev->gd = blk_mq_alloc_disk(&dev->sess->tag_set, dev);
> +       if (IS_ERR(dev->gd))
> +               return PTR_ERR(dev->gd);
> +       dev->queue = dev->gd->queue;
> +       rnbd_init_mq_hw_queues(dev);
>
>         setup_request_queue(dev);
> -
> -       dev->gd = alloc_disk_node(1 << RNBD_PART_BITS,  NUMA_NO_NODE);
> -       if (!dev->gd) {
> -               blk_cleanup_queue(dev->queue);
> -               return -ENOMEM;
> -       }
> -
>         rnbd_clt_setup_gen_disk(dev, idx);
> -
>         return 0;
>  }
>
> @@ -1650,8 +1632,7 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
>  static void destroy_gen_disk(struct rnbd_clt_dev *dev)
>  {
>         del_gendisk(dev->gd);
> -       blk_cleanup_queue(dev->queue);
> -       put_disk(dev->gd);
> +       blk_cleanup_disk(dev->gd);
>  }
>
>  static void destroy_sysfs(struct rnbd_clt_dev *dev,
> --
> 2.30.2

Looks good to me, thx!
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
>
