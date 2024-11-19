Return-Path: <linux-block+bounces-14337-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D9D9D2551
	for <lists+linux-block@lfdr.de>; Tue, 19 Nov 2024 13:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8C42822C4
	for <lists+linux-block@lfdr.de>; Tue, 19 Nov 2024 12:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7661CBEA9;
	Tue, 19 Nov 2024 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZ61ogbz"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8151CBEB3
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732018261; cv=none; b=fi1dwPtBzxdMIPbPrbfcwTeZbul1zmKE3A15mafHb1y99+vTOvhWSnasv+MNSMNgY+1roeIA4SpOdBAtF3raFd2K4kIPBdn0IoE2fTzSPLheLUybGafPg133jASCuD74p/TIdHUbXg97r08OYJe5AydWLA1ZGIT0FuWv3EzUf0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732018261; c=relaxed/simple;
	bh=I/WKuNZIb/72amKCFT6zun8ph0MFLDtkptnk5ECw6Bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdvRKIjYut0mJx4PLwp0pxr4YIT1Cu3kpaPNWl0tEDfemPm16xtk/oRe86AAcn5aPQQ7IfrQmeHFk8AXTQFnmZHct88ZxPzLDvFCNfDdRljsSN3Ha6CxtdHWM9NK+7R58sF16xAjmiDxqYU+Do0zO8Vh9Z0zNo+ZPVHY+cTe/Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZ61ogbz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732018259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1pI7tMfFo6N7qAAprfaSnS3NWeGTnzmZIZzGrSOrSVc=;
	b=cZ61ogbz7U11FJ44fSYTHNp4GqmrV7yBB+F7T4AsITxgTIb7fXTVu7ZjNf1d0X2WNUtOi2
	ZyGhI+DEp7VCv8xtu2r0vF0HzwEV7iF8J2f1Dj1QXtcDzbHYxgwHKsg0k8WO1CjRAtyqOr
	DDgokNAFT7DXWq60kCUs7eAWbyxdwwc=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-EphBMXM0PmSQbiYhrp0L2w-1; Tue, 19 Nov 2024 07:10:57 -0500
X-MC-Unique: EphBMXM0PmSQbiYhrp0L2w-1
X-Mimecast-MFC-AGG-ID: EphBMXM0PmSQbiYhrp0L2w
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-50d401bac6eso1568517e0c.3
        for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 04:10:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732018257; x=1732623057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1pI7tMfFo6N7qAAprfaSnS3NWeGTnzmZIZzGrSOrSVc=;
        b=mSJAK96s+o0XW+iul+VaMgsc/4keHNrPaUpa8UKqPkdJKjO09Y58qoIy18+pfE6Rf8
         lc/NRZiS/wnuoJ5jfqSdXTzUHEZjJ3ul7KDH4zASA6dLXyU5Ew72Pmr+T/4C1DyKcn2j
         O1uANdkAWpoRll/9P4g95PwVuU1dnaSQWewrC9mgc0c2FlDlo26QJA/uwOG7bgcmnZ1+
         oYL44mh7lEVehkrtjFozsVvftQv9hNS8/ie+QmD8w3qsuoNUgokvXAhDeAPZGrvQG+p0
         /R5TlgB42H8nPKDBUXpOC7E17Ib+blxZSI3C2pJo1DTsWb7qaul2jxNkGpI8eOg7JC4/
         XFkw==
X-Forwarded-Encrypted: i=1; AJvYcCXHfaT9rKC3/NZVeOF47r1Wgb8d0Fm/Mqe0bLwIUeGaSi57oM/bGenKHnv83w9iin/SdjFN0V7voTAiCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ3NzUL/LILsrpp6LnulwjVWMvWQmgOCxUkk4a3N3Bgut8gQFb
	+mNUSJ7wR8sZ66FilTMqoPM9npCsPRvqofLYRHshR9hTGoFCo+EQy2eExhdwjCY3oS6/UOPvqzN
	8qs6Fko5/bOQlBBO/0WTLR87V03/g22NI4YUMzMVM4toWv0GvCiRNvM2R8AH7sCZ3p0zyh0XwbZ
	I3msXXB5ha1aUOrTGl2SCaywmBgrpw7dCm8IE=
X-Received: by 2002:a05:6122:3bcb:b0:50d:a577:dec0 with SMTP id 71dfb90a1353d-51477eed1b9mr14301080e0c.5.1732018257392;
        Tue, 19 Nov 2024 04:10:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIYs+5pfjdVFKDbgb2W5AjOIyXHoTuM2BVY1IbxBylt3iWe5/9ZG4NqXLW2FjLgfUKaVWmNSSQQYLxkcqFPoc=
X-Received: by 2002:a05:6122:3bcb:b0:50d:a577:dec0 with SMTP id
 71dfb90a1353d-51477eed1b9mr14301066e0c.5.1732018257139; Tue, 19 Nov 2024
 04:10:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67313d9e.050a0220.138bd5.0054.GAE@google.com> <8734jxsyuu.fsf@mail.parknet.co.jp>
In-Reply-To: <8734jxsyuu.fsf@mail.parknet.co.jp>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 19 Nov 2024 20:10:46 +0800
Message-ID: <CAFj5m9+FmQLLQkO7EUKnuuj+mpSUOY3EeUxSpXjJUvWtKfz26w@mail.gmail.com>
Subject: Re: [syzbot] [exfat?] possible deadlock in fat_count_free_clusters
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	syzbot <syzbot+a5d8c609c02f508672cc@syzkaller.appspotmail.com>, 
	linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 12:44=E2=80=AFAM OGAWA Hirofumi
<hirofumi@mail.parknet.co.jp> wrote:
>
> Hi,
>
> syzbot <syzbot+a5d8c609c02f508672cc@syzkaller.appspotmail.com> writes:
>
> > syzbot found the following issue on:
> >
> > HEAD commit:    929beafbe7ac Add linux-next specific files for 20241108
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1621bd87980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D75175323f20=
78363
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Da5d8c609c02f5=
08672cc
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
>
> This patch is to fix the above race. Please check this.
>
> Thanks
>
>
> From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> Subject: [PATCH] loop: Fix ABBA locking race
> Date: Mon, 11 Nov 2024 21:53:36 +0900
>
> Current loop calls vfs_statfs() while holding the q->limits_lock. If
> FS takes some locking in vfs_statfs callback, this may lead to ABBA
> locking bug (at least, FAT fs has this issue actually).
>
> So this patch calls vfs_statfs() outside q->limits_locks instead,
> because looks like there is no reason to hold q->limits_locks while
> getting discard configs.
>
> Chain exists of:
>   &sbi->fat_lock --> &q->q_usage_counter(io)#17 --> &q->limits_lock
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&q->limits_lock);
>                                lock(&q->q_usage_counter(io)#17);
>                                lock(&q->limits_lock);
>   lock(&sbi->fat_lock);
>
>  *** DEADLOCK ***
>
> Reported-by: syzbot+a5d8c609c02f508672cc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Da5d8c609c02f508672cc
> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> ---
>  drivers/block/loop.c |   31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 78a7bb2..5f3ce51 100644
> --- a/drivers/block/loop.c      2024-09-16 13:45:20.253220178 +0900
> +++ b/drivers/block/loop.c      2024-11-11 21:51:00.910135443 +0900
> @@ -770,12 +770,11 @@ static void loop_sysfs_exit(struct loop_
>                                    &loop_attribute_group);
>  }
>
> -static void loop_config_discard(struct loop_device *lo,
> -               struct queue_limits *lim)
> +static void loop_get_discard_config(struct loop_device *lo,
> +                                   u32 *granularity, u32 *max_discard_se=
ctors)
>  {
>         struct file *file =3D lo->lo_backing_file;
>         struct inode *inode =3D file->f_mapping->host;
> -       u32 granularity =3D 0, max_discard_sectors =3D 0;
>         struct kstatfs sbuf;
>
>         /*
> @@ -788,8 +787,9 @@ static void loop_config_discard(struct l
>         if (S_ISBLK(inode->i_mode)) {
>                 struct request_queue *backingq =3D bdev_get_queue(I_BDEV(=
inode));
>
> -               max_discard_sectors =3D backingq->limits.max_write_zeroes=
_sectors;
> -               granularity =3D bdev_discard_granularity(I_BDEV(inode)) ?=
:
> +               *max_discard_sectors =3D
> +                       backingq->limits.max_write_zeroes_sectors;
> +               *granularity =3D bdev_discard_granularity(I_BDEV(inode)) =
?:
>                         queue_physical_block_size(backingq);
>
>         /*
> @@ -797,16 +797,9 @@ static void loop_config_discard(struct l
>          * image a.k.a. discard.
>          */
>         } else if (file->f_op->fallocate && !vfs_statfs(&file->f_path, &s=
buf)) {
> -               max_discard_sectors =3D UINT_MAX >> 9;
> -               granularity =3D sbuf.f_bsize;
> +               *max_discard_sectors =3D UINT_MAX >> 9;
> +               *granularity =3D sbuf.f_bsize;
>         }
> -
> -       lim->max_hw_discard_sectors =3D max_discard_sectors;
> -       lim->max_write_zeroes_sectors =3D max_discard_sectors;
> -       if (max_discard_sectors)
> -               lim->discard_granularity =3D granularity;
> -       else
> -               lim->discard_granularity =3D 0;
>  }
>
>  struct loop_worker {
> @@ -992,6 +985,7 @@ static int loop_reconfigure_limits(struc
>         struct inode *inode =3D file->f_mapping->host;
>         struct block_device *backing_bdev =3D NULL;
>         struct queue_limits lim;
> +       u32 granularity =3D 0, max_discard_sectors =3D 0;
>
>         if (S_ISBLK(inode->i_mode))
>                 backing_bdev =3D I_BDEV(inode);
> @@ -1001,6 +995,8 @@ static int loop_reconfigure_limits(struc
>         if (!bsize)
>                 bsize =3D loop_default_blocksize(lo, backing_bdev);
>
> +       loop_get_discard_config(lo, &granularity, &max_discard_sectors);
> +
>         lim =3D queue_limits_start_update(lo->lo_queue);
>         lim.logical_block_size =3D bsize;
>         lim.physical_block_size =3D bsize;
> @@ -1010,7 +1006,12 @@ static int loop_reconfigure_limits(struc
>                 lim.features |=3D BLK_FEAT_WRITE_CACHE;
>         if (backing_bdev && !bdev_nonrot(backing_bdev))
>                 lim.features |=3D BLK_FEAT_ROTATIONAL;
> -       loop_config_discard(lo, &lim);
> +       lim.max_hw_discard_sectors =3D max_discard_sectors;
> +       lim.max_write_zeroes_sectors =3D max_discard_sectors;
> +       if (max_discard_sectors)
> +               lim.discard_granularity =3D granularity;
> +       else
> +               lim.discard_granularity =3D 0;
>         return queue_limits_commit_update(lo->lo_queue, &lim);
>  }

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>


