Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA882AB6D2
	for <lists+linux-block@lfdr.de>; Mon,  9 Nov 2020 12:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgKILaY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 9 Nov 2020 06:30:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49942 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727077AbgKILaX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Nov 2020 06:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604921421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qJPHU79Z9aFII+RXhVTkpUcHO9yLNqjEBCGqyvXY310=;
        b=V995cmrSEl54zDxw55HTc5LkSVBjkP2bV0TQekN9COsw8YV5x1PRZoXTiOQWYGIU7qeB/F
        S4Jatc89SsaTrYA2XyRpHprinR8Gwv4zs3Vt/5nvJ4nLkVnzBzM/M3xEYu8X8hmCleZFtk
        XB3dlRLouPrOoTfOtSq1W/8EfJ7ljA0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-KHfrnanvPZaSES1EoJ-8cw-1; Mon, 09 Nov 2020 06:30:20 -0500
X-MC-Unique: KHfrnanvPZaSES1EoJ-8cw-1
Received: by mail-wm1-f72.google.com with SMTP id h2so1861174wmm.0
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2020 03:30:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qJPHU79Z9aFII+RXhVTkpUcHO9yLNqjEBCGqyvXY310=;
        b=YWqFrgSA0atVku9m66cIK1Dk1MZyPb8jE/0r54DybKeNmVcQi1OzYFCS1qhpr+WP16
         d+LI+wKMzOdO9tGPizPM7LaZjm2cATUFwwrT1qsZSzQpK8VhDnWBwVqzgWkPncODbXTJ
         Wn5UgVLfZx+QijDxyHAkmzH3P4E7FS6g2HqTNLw20Nf69WQ4rPdeEXLS3UeCX4/dVHDc
         LiNMklq6Str+A3eUve7FvxoaxzebKde/ejyNzHXczlev6XkdoYEUfSxlf1OTyXEGYh/W
         jyTfmg8eOBK/kN1V58UcO99iMAKWmMPyS7Xl8qbKqj1Yj3vqgrctZGT6U1IoAcJSnkv+
         O9Xw==
X-Gm-Message-State: AOAM533sAjRmjTZNKQeBKQlhwoHPbmUuLMZDYjvMNgkAD8rfPjFOI4CL
        EoANfM32+1gFECbwDr3nCcuT+h0ARQAxLSy5bbKLFq5zxoC3rtrel50ophWZPwII5R3sGOWn9gq
        Hq7VSKNMFQX5joZv9da9oza0=
X-Received: by 2002:a05:6000:1005:: with SMTP id a5mr10320362wrx.425.1604921419108;
        Mon, 09 Nov 2020 03:30:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfMfmWa9Cv9HNLSs0dLMrckBnIhQ+LX5gsNBfqeNBoHRKN7zV/cjWgtINNh6h724r5DlDOEA==
X-Received: by 2002:a05:6000:1005:: with SMTP id a5mr10320328wrx.425.1604921418961;
        Mon, 09 Nov 2020 03:30:18 -0800 (PST)
Received: from redhat.com (bzq-79-181-34-244.red.bezeqint.net. [79.181.34.244])
        by smtp.gmail.com with ESMTPSA id 35sm10972366wro.71.2020.11.09.03.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 03:30:17 -0800 (PST)
Date:   Mon, 9 Nov 2020 06:30:10 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 23/24] virtio-blk: remove a spurious call to
 revalidate_disk_size
Message-ID: <20201109063004-mutt-send-email-mst@kernel.org>
References: <20201106190337.1973127-1-hch@lst.de>
 <20201106190337.1973127-24-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106190337.1973127-24-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 06, 2020 at 08:03:35PM +0100, Christoph Hellwig wrote:
> revalidate_disk_size just updates the block device size from the disk
> size.  Thus calling it from revalidate_disk_size doesn't actually do
> anything.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/block/virtio_blk.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 3e812b4c32e669..145606dc52db1e 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -598,7 +598,6 @@ static void virtblk_update_cache_mode(struct virtio_device *vdev)
>  	struct virtio_blk *vblk = vdev->priv;
>  
>  	blk_queue_write_cache(vblk->disk->queue, writeback, false);
> -	revalidate_disk_size(vblk->disk, true);
>  }
>  
>  static const char *const virtblk_cache_types[] = {
> -- 
> 2.28.0

