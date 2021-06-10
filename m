Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC75C3A2486
	for <lists+linux-block@lfdr.de>; Thu, 10 Jun 2021 08:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhFJGai (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 10 Jun 2021 02:30:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21332 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229705AbhFJGah (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 02:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623306521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1FsL/mB1dSHfBUgEK6+GR9cKMoBGx44lVNDr2lSojqA=;
        b=XXyyjcgaDvPZjwtcWdxE3jO6NW8ZNZeUZaiwdi3/Uba9BdG4KFCr5ScwsGJ7f8MFMgcoDa
        wRB/KmyYewN+Ij0wRi9otAU4E7EsPnD7a3O9MVEYmZtH38l/f1NFwx41fOpNNnxzpf2wwS
        6jb5IPxiGuZH3YZDT59tGpgVkGtT6cg=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-f271hPWBMsCXBuhITk4Rig-1; Thu, 10 Jun 2021 02:28:39 -0400
X-MC-Unique: f271hPWBMsCXBuhITk4Rig-1
Received: by mail-yb1-f197.google.com with SMTP id u48-20020a25ab330000b029053982019c2dso34501062ybi.2
        for <linux-block@vger.kernel.org>; Wed, 09 Jun 2021 23:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1FsL/mB1dSHfBUgEK6+GR9cKMoBGx44lVNDr2lSojqA=;
        b=bRJdDKuyI+/1fGccy6q4HsMhun/WdGsKmJ7Iqy8bUHE8+NwsyiKYu2PE2x0HYYohG/
         u5d2XtlHONJbKOo/oTgjeUfHzDbO/a77QypjypTjhp/PAGxtsezamnpL/asaqgP+GiCk
         0TN4LY7aIRPwp+GHI1CAFsGi/ds7CoTbnBxkRf8LWPKGqacnP7UAuH5dXK6jcEaZG8tU
         StnX6akJIfi+whlWeamjddovrIgkVf5CjJRYX1SIxvCZzyDA2cnUGmYhb7ssj+PFnKGg
         8yhC89J9OlxDiavM6Q56DXX3C8qCP7VkH+SS4OFzRoAJWrr/E9dsdB+6C/OByVH4S0TR
         BLQw==
X-Gm-Message-State: AOAM531yx/tivhFMEqDT3KGIqXvSbof7qsfthkVDtC+w+ZxEOwocZGSK
        U3qpyDNVlaZaGN0oF1dNAEGeGnthLqiJukkblqjFOuO3juViVq0UhOG9r0HSt+1uq4EfipKdhGG
        K6Iiaa6lErxdS30f5RYW41J8bsHPYaVm+nlG3UYw=
X-Received: by 2002:a25:bec6:: with SMTP id k6mr5126560ybm.269.1623306519294;
        Wed, 09 Jun 2021 23:28:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwO8FHXlLLlFrK6nyaCQo++y/TWrqTGm/p80DH/RLr6cJerpX48hbVlrbRn4FRYJK8EEE+g9I56KxBq2EfrQRg=
X-Received: by 2002:a25:bec6:: with SMTP id k6mr5126550ybm.269.1623306519123;
 Wed, 09 Jun 2021 23:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210608092707.1062259-1-yuyufen@huawei.com>
In-Reply-To: <20210608092707.1062259-1-yuyufen@huawei.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Thu, 10 Jun 2021 14:28:28 +0800
Message-ID: <CAFj5m9K1Psc91zvNipb+PKp+zDeFjOKCu+rv3EC9H+1M8gPKiw@mail.gmail.com>
Subject: Re: [PATCH] block: check disk exist before trying to add partition
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        jack@suse.cz, Hannes Reinecke <hare@suse.de>, damien.lemoal@wdc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 8, 2021 at 5:21 PM Yufen Yu <yuyufen@huawei.com> wrote:
>
> If disk have been deleted, we should return fail for ioctl
> BLKPG_DEL_PARTITION. Otherwise, the directory /sys/class/block
> may remain invalid symlinks file. The race as following:
>
> blkdev_open
>                                 del_gendisk
>                                     disk->flags &= ~GENHD_FL_UP;
>                                     blk_drop_partitions
> blkpg_ioctl
>     bdev_add_partition
>     add_partition
>         device_add
>             device_add_class_symlinks
>
> ioctl may add_partition after del_gendisk() have tried to delete
> partitions. Then, symlinks file will be created.
>
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

