Return-Path: <linux-block+bounces-738-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 841DC80570D
	for <lists+linux-block@lfdr.de>; Tue,  5 Dec 2023 15:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6CAB1C20FBC
	for <lists+linux-block@lfdr.de>; Tue,  5 Dec 2023 14:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4B05FF19;
	Tue,  5 Dec 2023 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrHxK9dg"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6F0B9;
	Tue,  5 Dec 2023 06:19:37 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1fb40253680so1242506fac.0;
        Tue, 05 Dec 2023 06:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701785977; x=1702390777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcdWCGeTNWPKv5Volp7VVK1y/yfIdhFJ0eCugNnIkp0=;
        b=nrHxK9dgwblbkHtBfRLDZQVR0FfZmMlX90PCaBRVEqCrZG2898hTIILPuyKZyEKBxU
         +tCFn1ZVnTNSsvSPq5r8733iPLecPvnzlYUcv4+7eBJJrHWrQZ3vrmBfbuCk/ZK8d9ie
         j/JezZIna3xfNSmlDdtyRak7z5ygEY3AmgBAZCgugJPbd0DkYyyu3UAr7/2pbgrQNC/Z
         yO9hugxqrX7Ao46ES/QEPaoApRKJQWHz6gnidfhSBvRyMeprMVH83QzdrU+bLj828fPQ
         RDd3RcfCEIcLwTlab3Vu0YcpZDAesxcRyuHDVR6skM814WP3k5zkheHdEtruuiPCf/4d
         VyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701785977; x=1702390777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcdWCGeTNWPKv5Volp7VVK1y/yfIdhFJ0eCugNnIkp0=;
        b=IYBdY/Vmu9Q8VzG+BzqPYY3meOE/Zh0g8WlsROEvoeFk+aqqg77CC7AUwhfAuHrbkZ
         +nMhfOpwJm+0hGW4L+dB1Da16BAYtw7SY907SCDWjhcvqbIlE679lsi7nkM9UIUUpO3k
         8rRYFOU2ylKu7Cj5sMWEF/CTqQSVWDibY2sjfi6MmjrlqcJGlPdmFyOELOfY1Sc9DEdl
         FeZuNzctxUM9U4N3e8oxTtVR/mjc1DoIWvI9BYugRshhHKqyzZwsQ5w+LjP6miNvCbTt
         QEKxZ+JyN26w27kGM2CUFXZXTKoSQItjxNO/JvnYr4hk7O/A5kBQrSyRYhKPcUAKyYI0
         INqw==
X-Gm-Message-State: AOJu0Yxx2nvqbh9rl1lPFSENmsEdy90qNYG9pCXvBoX0QEFH3Q+6e0Ju
	R1hunfKH0xM6xUOHpbQOVY//v1kIKXbXZuA57/s=
X-Google-Smtp-Source: AGHT+IGKHbTXlOimAxgVOe6WFunYwRxPJpYDvHgcXklUon6LpkHVYjQBVIWohh7Zlbzds0qqX49jUwUnfcnGWNC/Ufw=
X-Received: by 2002:a05:6871:e40b:b0:1fb:75a:c441 with SMTP id
 py11-20020a056871e40b00b001fb075ac441mr5934960oac.106.1701785976925; Tue, 05
 Dec 2023 06:19:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204140743.1487843-1-stefanha@redhat.com> <1c1d57ba13c2497f99e5e0a9c5954667@AcuMS.aculab.com>
In-Reply-To: <1c1d57ba13c2497f99e5e0a9c5954667@AcuMS.aculab.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 5 Dec 2023 09:19:24 -0500
Message-ID: <CAJSP0QUkb936K7kzW7-4bFSCbvcfFW0QJ9v=8yT6voAwkdBQRQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: fix snprintf truncation compiler warning
To: David Laight <David.Laight@aculab.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Jason Wang <jasowang@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Suwan Kim <suwan.kim027@gmail.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Dec 2023 at 08:54, David Laight <David.Laight@aculab.com> wrote:
>
> From: Stefan Hajnoczi
> > Sent: 04 December 2023 14:08
> >
> > Commit 4e0400525691 ("virtio-blk: support polling I/O") triggers the
> > following gcc 13 W=3D1 warnings:
> >
> > drivers/block/virtio_blk.c: In function =E2=80=98init_vq=E2=80=99:
> > drivers/block/virtio_blk.c:1077:68: warning: =E2=80=98%d=E2=80=99 direc=
tive output may be truncated writing between 1
> > and 11 bytes into a region of size 7 [-Wformat-truncation=3D]
> >  1077 |                 snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_p=
oll.%d", i);
> >       |                                                                =
    ^~
> > drivers/block/virtio_blk.c:1077:58: note: directive argument in the ran=
ge [-2147483648, 65534]
> >  1077 |                 snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_p=
oll.%d", i);
> >       |                                                          ^~~~~~=
~~~~~~~
> > drivers/block/virtio_blk.c:1077:17: note: =E2=80=98snprintf=E2=80=99 ou=
tput between 11 and 21 bytes into a destination
> > of size 16
> >  1077 |                 snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_p=
oll.%d", i);
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~
> >
> > This is a false positive because the lower bound -2147483648 is
> > incorrect. The true range of i is [0, num_vqs - 1] where 0 < num_vqs <
> > 65536.
> >
> > The code mixes int, unsigned short, and unsigned int types in addition
> > to using "%d" for an unsigned value. Use unsigned short and "%u"
> > consistently to solve the compiler warning.
> >
> > Cc: Suwan Kim <suwan.kim027@gmail.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202312041509.DIyvEt9h-lkp=
@intel.com/
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  drivers/block/virtio_blk.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index d53d6aa8ee69..47556d8ccc32 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -1019,12 +1019,12 @@ static void virtblk_config_changed(struct virti=
o_device *vdev)
> >  static int init_vq(struct virtio_blk *vblk)
> >  {
> >       int err;
> > -     int i;
> > +     unsigned short i;
> >       vq_callback_t **callbacks;
> >       const char **names;
> >       struct virtqueue **vqs;
> >       unsigned short num_vqs;
> > -     unsigned int num_poll_vqs;
> > +     unsigned short num_poll_vqs;
> >       struct virtio_device *vdev =3D vblk->vdev;
> >       struct irq_affinity desc =3D { 0, };
> >
> > @@ -1068,13 +1068,13 @@ static int init_vq(struct virtio_blk *vblk)
> >
> >       for (i =3D 0; i < num_vqs - num_poll_vqs; i++) {
>
> Ugg doing arithmetic on char/short is likely to generate horrid
> code (especially on non-x86).
> Hint, there will be explicit masking and/or sign/zero extension.
>
> Even the array index might add extra code (although there'll be
> an explicit sign extend to 64bit with the current code).
>
> There really ought to be a better way to make gcc STFU.
>
> In this case 'unsigned int i' might be enough since gcc seems
> to have a small enough upper bound.

Sounds good, I'll send a v2 that uses unsigned int. The core virtio
code uses unsigned int for virtqueue indices too.

Stefan

>
>         David
>
>
> >               callbacks[i] =3D virtblk_done;
> > -             snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%d", i);
> > +             snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%u", i);
> >               names[i] =3D vblk->vqs[i].name;
> >       }
> >
> >       for (; i < num_vqs; i++) {
> >               callbacks[i] =3D NULL;
> > -             snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i=
);
> > +             snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%u", i=
);
> >               names[i] =3D vblk->vqs[i].name;
> >       }
> >
> > --
> > 2.43.0
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)

