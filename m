Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C303F6B61
	for <lists+linux-block@lfdr.de>; Tue, 24 Aug 2021 23:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbhHXV41 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 24 Aug 2021 17:56:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237295AbhHXV40 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 17:56:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D0D36138B;
        Tue, 24 Aug 2021 21:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629842141;
        bh=/TTt+oXuo/hSCieoE7VoYbJ25qUKsCPDkDJXQVoY4y4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fdlNbnB8InIiKZDFwCLm+NIDKNnaNb6Od1hqn7bQ+inC/FEI2vg0sqvUoWqAzbR3p
         G1+l0KHPXxntSLuq8qm+1duxOoFRfRwW7iZquXsWMpwCR2tWzW8xNb+CGyhBRs+vpM
         yPFtUatGNDWF4hy4+1VTf5a/gP1T5KGoc3qIcjxsyZm+iyImC9VJ6B0HWpzkwkXyx/
         bsmFGrxgj1Y8GqtpQ8DpbBpWb7k71J5INx2X4n5CJ9vJNlIc/eX328R8OKNEqqRqUz
         AC1s4q+RuQt+tbmgv25iOIGgYgeYYbUmy0FMRmdYxYm5Avw5xMgmrMpe0+FhXX9LSO
         jByK5vABkqkPw==
Received: by mail-lf1-f53.google.com with SMTP id p38so48624207lfa.0;
        Tue, 24 Aug 2021 14:55:41 -0700 (PDT)
X-Gm-Message-State: AOAM531AjZlt/IAaIIbLMAi7BjbcO3RS5tPEGH1ulsJpCNMRre7wfegq
        hE+Jvc/LbHBL5ryTlU1RLys4i7xfk8RCo4n5wYc=
X-Google-Smtp-Source: ABdhPJx7o4/wLoi+sIFaAsJmlkM1o0UHHTqdzp5bnNxGZTiAMOZM0tRXOX5BIBNFe8MSicTRSIJImcLm+HDGmmDWptY=
X-Received: by 2002:a05:6512:3e10:: with SMTP id i16mr263063lfv.10.1629842139951;
 Tue, 24 Aug 2021 14:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210824011654.3829681-1-guoqing.jiang@linux.dev>
In-Reply-To: <20210824011654.3829681-1-guoqing.jiang@linux.dev>
From:   Song Liu <song@kernel.org>
Date:   Tue, 24 Aug 2021 14:55:28 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6mivBeA0uYGT-Z9UR7h_B=4Mp+BGqzrAW9BmNysQcGTw@mail.gmail.com>
Message-ID: <CAPhsuW6mivBeA0uYGT-Z9UR7h_B=4Mp+BGqzrAW9BmNysQcGTw@mail.gmail.com>
Subject: Re: [PATCH] raid1: ensure write behind bio has less than BIO_MAX_VECS sectors
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 23, 2021 at 6:17 PM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
> From: Guoqing Jiang <jiangguoqing@kylinos.cn>
>
> We can't split write behind bio with more than BIO_MAX_VECS sectors,
> otherwise the below call trace was triggered because we could allocate
> oversized write behind bio later.
>
> [ 8.097936] bvec_alloc+0x90/0xc0
> [ 8.098934] bio_alloc_bioset+0x1b3/0x260
> [ 8.099959] raid1_make_request+0x9ce/0xc50 [raid1]
> [ 8.100988] ? __bio_clone_fast+0xa8/0xe0
> [ 8.102008] md_handle_request+0x158/0x1d0 [md_mod]
> [ 8.103050] md_submit_bio+0xcd/0x110 [md_mod]
> [ 8.104084] submit_bio_noacct+0x139/0x530
> [ 8.105127] submit_bio+0x78/0x1d0
> [ 8.106163] ext4_io_submit+0x48/0x60 [ext4]
> [ 8.107242] ext4_writepages+0x652/0x1170 [ext4]
> [ 8.108300] ? do_writepages+0x41/0x100
> [ 8.109338] ? __ext4_mark_inode_dirty+0x240/0x240 [ext4]
> [ 8.110406] do_writepages+0x41/0x100
> [ 8.111450] __filemap_fdatawrite_range+0xc5/0x100
> [ 8.112513] file_write_and_wait_range+0x61/0xb0
> [ 8.113564] ext4_sync_file+0x73/0x370 [ext4]
> [ 8.114607] __x64_sys_fsync+0x33/0x60
> [ 8.115635] do_syscall_64+0x33/0x40
> [ 8.116670] entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Thanks for the comment from Christoph.
>
> [1]. https://bugs.archlinux.org/task/70992
>
> Reported-by: Jens Stutte <jens@chianterastutte.eu>
> Tested-by: Jens Stutte <jens@chianterastutte.eu>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Guoqing Jiang <jiangguoqing@kylinos.cn>

I am confused. Which tree does this apply to?

Thanks,
Song

> ---
> V4 change:
> 1. fix issue reported by lkp.
> 2. add Reviewed-by tag.
>
> V3 change:
> 1. add comment before test WriteMostly.
> 2. reduce line length.
>
> V2 change:
> 1. add checking for write-behind case and relevant comments from Christoph.
>
>  drivers/md/raid1.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 3c44c4bb40fc..ad51a60f1a93 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1329,6 +1329,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
>         struct raid1_plug_cb *plug = NULL;
>         int first_clone;
>         int max_sectors;
> +       bool write_behind = false;
>
>         if (mddev_is_clustered(mddev) &&
>              md_cluster_ops->area_resyncing(mddev, WRITE,
> @@ -1381,6 +1382,15 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
>         max_sectors = r1_bio->sectors;
>         for (i = 0;  i < disks; i++) {
>                 struct md_rdev *rdev = rcu_dereference(conf->mirrors[i].rdev);
> +
> +               /*
> +                * The write-behind io is only attempted on drives marked as
> +                * write-mostly, which means we could allocate write behind
> +                * bio later.
> +                */
> +               if (rdev && test_bit(WriteMostly, &rdev->flags))
> +                       write_behind = true;
> +
>                 if (rdev && unlikely(test_bit(Blocked, &rdev->flags))) {
>                         atomic_inc(&rdev->nr_pending);
>                         blocked_rdev = rdev;
> @@ -1454,6 +1464,15 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
>                 goto retry_write;
>         }
>
> +       /*
> +        * When using a bitmap, we may call alloc_behind_master_bio below.
> +        * alloc_behind_master_bio allocates a copy of the data payload a page
> +        * at a time and thus needs a new bio that can fit the whole payload
> +        * this bio in page sized chunks.
> +        */
> +       if (write_behind && bitmap)
> +               max_sectors = min_t(int, max_sectors,
> +                                   BIO_MAX_VECS * PAGE_SECTORS);
>         if (max_sectors < bio_sectors(bio)) {
>                 struct bio *split = bio_split(bio, max_sectors,
>                                               GFP_NOIO, &conf->bio_split);
> --
> 2.25.1
>
