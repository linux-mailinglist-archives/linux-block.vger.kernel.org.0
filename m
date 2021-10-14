Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8742442D0AE
	for <lists+linux-block@lfdr.de>; Thu, 14 Oct 2021 04:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhJNCrq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 Oct 2021 22:47:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229972AbhJNCrp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 22:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634179541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eXsQtbYu8ZrTVNpDyzuEjrd6+BUlfzHFpmt5fkpzD3E=;
        b=XRU9q8FRGSz2fciD9ULj4gNC530Yr5JOydSpAc7aHZxio5lB0t4mCZiIwTml8JOS29TNKy
        50sYGQxLmgeL3tcPTtMojFI9UCbUmJBiVv8shtXj3KudU8IYZtKnQdSObNLIxoJ8fNl06z
        gEgDA43RisG6iiBMv0wpwDvBQfcVbU0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210--1BUw_hFMoeLJVllyO0N1Q-1; Wed, 13 Oct 2021 22:45:40 -0400
X-MC-Unique: -1BUw_hFMoeLJVllyO0N1Q-1
Received: by mail-lf1-f69.google.com with SMTP id d12-20020a0565123d0c00b003fdb52f1cdcso1441558lfv.4
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 19:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eXsQtbYu8ZrTVNpDyzuEjrd6+BUlfzHFpmt5fkpzD3E=;
        b=8LBSZDeq2BvfiAP6o3ambyDNGInYZPCx0vxRDoex1VTagXJ7ztqtTzb2mhn1R53kcc
         fr49hb5v50rbV++BjARM+PIL+WhsYTznhySIjR23Y2I+a2GkO3vWfNdRaeuNJmmbozdE
         8p3IApATNQXzmbklYAx4c5NR7BB61VxLv1rIXSDMSIVTT+dYpceJCqalmaP0xPJ0UGcK
         Z8w/X5CwdBx9q8zjE15tEUV93t2DvPLSPKSquhokMpAYl0465yVqfBWvdkvnu72eYbTD
         FJwGVmSBtn72kzp7VlnGwl2Zss/QGGTAp4UsGywVjIbaW1JRkNwxsx+7cuGYPNJYL3C1
         ITNw==
X-Gm-Message-State: AOAM531VCH7wmhqXUUcGeYyiNC5Whyx9CLzE3+V7OzpTYDYVk+Rsv9BU
        4TgG8VAWxOiDgFOt/B2Hns0rJ4++svdgVFb0khBIthN82K9LAmvh8lYqvquLrbsz5WS0oF1GlP3
        Lz0nloQToU/q/zCGSqJ9lgxLApa7H7rn1VXi4icI=
X-Received: by 2002:a2e:a553:: with SMTP id e19mr3434294ljn.420.1634179538430;
        Wed, 13 Oct 2021 19:45:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+xgpkEUubYfnpn/vaAsfXQ0rhxqRYeg+wRyCTA86C+jYoPsMcxaiuymric4yv4DqVOdlgczVxxUcTpfzpW1c=
X-Received: by 2002:a2e:a553:: with SMTP id e19mr3434279ljn.420.1634179538228;
 Wed, 13 Oct 2021 19:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211013124553.23803-1-mst@redhat.com>
In-Reply-To: <20211013124553.23803-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 14 Oct 2021 10:45:25 +0800
Message-ID: <CACGkMEvoE8+FxvX_vJEqEuqHptHu1-0TyM4j1P=cnRiBD6-1vA@mail.gmail.com>
Subject: Re: [PATCH] Revert "virtio-blk: Add validation for block size in
 config space"
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 8:46 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> It turns out that access to config space before completing the feature
> negotiation is broken for big endian guests at least with QEMU hosts up
> to 6.1 inclusive.  This affects any device that accesses config space in
> the validate callback: at the moment that is virtio-net with
> VIRTIO_NET_F_MTU but since 82e89ea077b9 ("virtio-blk: Add validation for
> block size in config space") that also started affecting virtio-blk with
> VIRTIO_BLK_F_BLK_SIZE.

Ok, so it looks like I need to do something similar in my series to
validate max_nr_ports in probe() instead of validate()? (multi port is
not enabled by default).

I wonder if we need to document this and rename the validate to
validate_features() (since we can do very little thing if we can't
read config in .validate()).

> Further, unlike VIRTIO_NET_F_MTU which is off by
> default on QEMU, VIRTIO_BLK_F_BLK_SIZE is on by default, which resulted
> in lots of people not being able to boot VMs on BE.
>
> The spec is very clear that what we are doing is legal so QEMU needs to
> be fixed, but given it's been broken for so many years and no one
> noticed, we need to give QEMU a bit more time before applying this.
>
> Further, this patch is incomplete (does not check blk size is a power
> of two) and it duplicates the logic from nbd.
>
> Revert for now, and we'll reapply a cleaner logic in the next release.
>
> Cc: stable@vger.kernel.org
> Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
> Cc: Xie Yongji <xieyongji@bytedance.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: jason Wang <jasowang@redhat.com>

> ---
>  drivers/block/virtio_blk.c | 37 ++++++-------------------------------
>  1 file changed, 6 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 9b3bd083b411..303caf2d17d0 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -689,28 +689,6 @@ static const struct blk_mq_ops virtio_mq_ops = {
>  static unsigned int virtblk_queue_depth;
>  module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
>
> -static int virtblk_validate(struct virtio_device *vdev)
> -{
> -       u32 blk_size;
> -
> -       if (!vdev->config->get) {
> -               dev_err(&vdev->dev, "%s failure: config access disabled\n",
> -                       __func__);
> -               return -EINVAL;
> -       }
> -
> -       if (!virtio_has_feature(vdev, VIRTIO_BLK_F_BLK_SIZE))
> -               return 0;
> -
> -       blk_size = virtio_cread32(vdev,
> -                       offsetof(struct virtio_blk_config, blk_size));
> -
> -       if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)
> -               __virtio_clear_bit(vdev, VIRTIO_BLK_F_BLK_SIZE);
> -
> -       return 0;
> -}
> -
>  static int virtblk_probe(struct virtio_device *vdev)
>  {
>         struct virtio_blk *vblk;
> @@ -722,6 +700,12 @@ static int virtblk_probe(struct virtio_device *vdev)
>         u8 physical_block_exp, alignment_offset;
>         unsigned int queue_depth;
>
> +       if (!vdev->config->get) {
> +               dev_err(&vdev->dev, "%s failure: config access disabled\n",
> +                       __func__);
> +               return -EINVAL;
> +       }
> +
>         err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
>                              GFP_KERNEL);
>         if (err < 0)
> @@ -836,14 +820,6 @@ static int virtblk_probe(struct virtio_device *vdev)
>         else
>                 blk_size = queue_logical_block_size(q);
>
> -       if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE) {
> -               dev_err(&vdev->dev,
> -                       "block size is changed unexpectedly, now is %u\n",
> -                       blk_size);
> -               err = -EINVAL;
> -               goto out_cleanup_disk;
> -       }
> -
>         /* Use topology information if available */
>         err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
>                                    struct virtio_blk_config, physical_block_exp,
> @@ -1009,7 +985,6 @@ static struct virtio_driver virtio_blk = {
>         .driver.name                    = KBUILD_MODNAME,
>         .driver.owner                   = THIS_MODULE,
>         .id_table                       = id_table,
> -       .validate                       = virtblk_validate,
>         .probe                          = virtblk_probe,
>         .remove                         = virtblk_remove,
>         .config_changed                 = virtblk_config_changed,
> --
> MST
>

