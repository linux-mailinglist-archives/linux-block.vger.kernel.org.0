Return-Path: <linux-block+bounces-5740-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3ABA8983F7
	for <lists+linux-block@lfdr.de>; Thu,  4 Apr 2024 11:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200731C22638
	for <lists+linux-block@lfdr.de>; Thu,  4 Apr 2024 09:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E698745CB;
	Thu,  4 Apr 2024 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZlkmF29g"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CC271B27
	for <linux-block@vger.kernel.org>; Thu,  4 Apr 2024 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712222976; cv=none; b=MWauPBnrnGjP1iCYX4tngS/Ay8bLO65mJ248G2gfSPcjnLnWVyfXVrI/xapOAsP5Dcsqxd0d6WpIO/BWILGlBFe/bmBrhd/H8Sz6m2QWUPyczFNpYqrlcqD0JZErQmNwJqBHxDaEPxU0g95AsqdWISYCqqgYTWpcHqtQtMjOf74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712222976; c=relaxed/simple;
	bh=99E4HG7gzVmYikL3IhYBrGsNdGq09JueIkPk+dyBQHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufRAqtmMmgbrXRIZm5t6stuGrfwFRHbal8ikbNoo/I2+oQM76D9W+7vPD5q9AaUpJAokZm3hZx/sVfw6dDw4WoQ1q3n+Y5OlRjt412kz83XEQv4BQg8Hycfmn6HqnO0aghbHmq34nYmrBunH5VWm11tk0A6KrdyWhx1MBIa5EPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZlkmF29g; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so779424276.1
        for <linux-block@vger.kernel.org>; Thu, 04 Apr 2024 02:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712222972; x=1712827772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOEdb/OWzmz8JqwZJnI/08OTrl5N7pe653ZiOSh3hP4=;
        b=ZlkmF29g/bdzOvcVW0b0FUTsUAzcLlurbNMRIeiBVsq/rFx7jjwmo5RyzlRt2VJbwF
         8nSH1NOwZdSd+/FBpouyHqZIyjL/DM2eeMkGWfJ00F+Vq40DU3g3H/mwf6FotVLpt8LE
         jMscFdcmWc2aAI/Y19M1fnUPTVj5+bm4LQ0Lmzt8HfoKYj2sAW4lSBK1vBd3hw5tsIXi
         GOujJX8oIQAJ8J5eCIxU3ZCwccSg1EMgaXG4/BsdJSC2whq1EDIXI9PZoBf72Gm+5e3o
         J8C5AMUfhSJBtaZER8hHDYZZe+bUpjYlSfoS/ijr4dff0HUtO1/u3KubHWsrs5KXfta0
         crcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712222972; x=1712827772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOEdb/OWzmz8JqwZJnI/08OTrl5N7pe653ZiOSh3hP4=;
        b=Zv/G2LYc7Etq8x4Kya0hAVdZlmrB1JpMSQ21tgVDFbhtT7J+SFn2E+MwgcHjvjAIeK
         MO8kg+v8H3ZFBRklSbcdqjGBW69EepiP3xB+n8KQcmyxRvaHGSzf9DQmYjMS12Ov/Ryk
         RGZJ/nqybDVZ+HJTtpU+a7thu1GTPLRXxwMEAY51lfCNy3tKIxTwMc/ZIRk6Ac/LU69m
         rS4Sso2TZBRf9o61yAEksRNs4BguY2wwF2tGEb/ulhuqsqZUZYmDdgIZb0+vVQ2WPAm9
         s9MTIImYOX3baIr4eTlu37f29fpvY3lGvfw5qL9JqUelGjnQxZxgVjMMwgSdz1mwYm+n
         OAlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN2NC6UVv88YJZyaZL2jABICvQbfEr3rfNGc1LAAxjJyZqsezKDwlpoUlONar3KiKrrzzRDtK2THEhvrEyUlPwG91CWlnpvVNb56Y=
X-Gm-Message-State: AOJu0YxahISivz+lQPjWdBH1oanwpwE86/QPXuED2eTZuhpc0cptu669
	PYytyGbLAZv34craJOe06K/QWT1YMOCknAH2XWJCOEboCELcHrgD5pTS6qK2YY1zN3fk8w3+TLY
	G8ihlndnPZOJZW20+2SzFtHKdjaaBDyD/jtSftg==
X-Google-Smtp-Source: AGHT+IEJZ6xOy8uL7K7v48vhoxukNtRZ0YN8Iqho231EFU66OmF4NH8X0iYgBBX9Pgy1/61AdDVdjz5dkHUDRWNwCo8=
X-Received: by 2002:a25:9111:0:b0:dc7:4f61:5723 with SMTP id
 v17-20020a259111000000b00dc74f615723mr1778216ybl.39.1712222972517; Thu, 04
 Apr 2024 02:29:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306232052.21317-1-semen.protsenko@linaro.org>
 <8896bcc5-09b1-4886-9081-c8ce0afc1c40@app.fastmail.com> <CAPLW+4mu3K38_sPnTDj-gkvdsnfN3OKXwfDSBUg_jUj+f122cA@mail.gmail.com>
In-Reply-To: <CAPLW+4mu3K38_sPnTDj-gkvdsnfN3OKXwfDSBUg_jUj+f122cA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Apr 2024 11:28:55 +0200
Message-ID: <CAPDyKFoKmOf__GP3tx4fU_qGcDn5je-8cuLoCiCUzGLz=HdoDg@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Christoph Hellwig <hch@lst.de>, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@gmail.com>, 
	Matt Fleming <matt@console-pimps.org>, Christian Brauner <brauner@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, 
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Apr 2024 at 00:43, Sam Protsenko <semen.protsenko@linaro.org> wro=
te:
>
> On Thu, Mar 7, 2024 at 1:52=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrot=
e:
> >
> > On Thu, Mar 7, 2024, at 00:20, Sam Protsenko wrote:
> > > Commit 616f87661792 ("mmc: pass queue_limits to blk_mq_alloc_disk") [=
1]
> > > revealed the long living issue in dw_mmc.c driver, existing since the
> > > time when it was first introduced in commit f95f3850f7a9 ("mmc: dw_mm=
c:
> > > Add Synopsys DesignWare mmc host driver."), also making kernel boot
> > > broken on platforms using dw_mmc driver with 16K or 64K pages enabled=
,
> > > with this message in dmesg:
> > >
> > >     mmcblk: probe of mmc0:0001 failed with error -22
> > >
> > > That's happening because mmc_blk_probe() fails when it calls
> > > blk_validate_limits() consequently, which returns the error due to
> > > failed max_segment_size check in this code:
> > >
> > >     /*
> > >      * The maximum segment size has an odd historic 64k default that
> > >      * drivers probably should override.  Just like the I/O size we
> > >      * require drivers to at least handle a full page per segment.
> > >      */
> > >     ...
> > >     if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
> > >         return -EINVAL;
> > >
> > > In case when IDMAC (Internal DMA Controller) is used, dw_mmc.c always
> > > sets .max_seg_size to 4 KiB:
> > >
> > >     mmc->max_seg_size =3D 0x1000;
> > >
> > > The comment in the code above explains why it's incorrect. Arnd
> > > suggested setting .max_seg_size to .max_req_size to fix it, which is
> > > also what some other drivers are doing:
> > >
> > >    $ grep -rl 'max_seg_size.*=3D.*max_req_size' drivers/mmc/host/ | \
> > >      wc -l
> > >    18
> >
> > Nice summary!
> >
> > > This change is not only fixing the boot with 16K/64K pages, but also
> > > leads to a better MMC performance. The linear write performance was
> > > tested on E850-96 board (eMMC only), before commit [1] (where it's
> > > possible to boot with 16K/64K pages without this fix, to be able to d=
o
> > > a comparison). It was tested with this command:
> > >
> > >     # dd if=3D/dev/zero of=3Dsomefile bs=3D1M count=3D500 oflag=3Dsyn=
c
> > >
> > > Test results are as follows:
> > >
> > >   - 4K pages,  .max_seg_size =3D 4 KiB:                   94.2 MB/s
> > >   - 4K pages,  .max_seg_size =3D .max_req_size =3D 512 KiB: 96.9 MB/s
> > >   - 16K pages, .max_seg_size =3D 4 KiB:                   126 MB/s
> > >   - 16K pages, .max_seg_size =3D .max_req_size =3D 2 MiB:   128 MB/s
> > >   - 64K pages, .max_seg_size =3D 4 KiB:                   138 MB/s
> > >   - 64K pages, .max_seg_size =3D .max_req_size =3D 8 MiB:   138 MB/s
> >
> > Thanks for sharing these results. From what I can see here, the
> > performance changes significantly with the page size, but barely
> > with the max_seg_size, so this does not have the effect I was
> > hoping for. On a more positive note this likely means that we
> > don't have to urgently backport your fix.
> >
> > This could mean that either there is not much coalescing across
> > pages after all, or that the bottleneck is somewhere else.
> >
> > > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > > index 8e2d676b9239..cccd5633ff40 100644
> > > --- a/drivers/mmc/host/dw_mmc.c
> > > +++ b/drivers/mmc/host/dw_mmc.c
> > > @@ -2951,8 +2951,8 @@ static int dw_mci_init_slot(struct dw_mci *host=
)
> > >       if (host->use_dma =3D=3D TRANS_MODE_IDMAC) {
> > >               mmc->max_segs =3D host->ring_size;
> > >               mmc->max_blk_size =3D 65535;
> > > -             mmc->max_seg_size =3D 0x1000;
> > > -             mmc->max_req_size =3D mmc->max_seg_size * host->ring_si=
ze;
> > > +             mmc->max_req_size =3D DW_MCI_DESC_DATA_LENGTH * host->r=
ing_size;
> > > +             mmc->max_seg_size =3D mmc->max_req_size;
> >
> > The change looks good to me.
> >
> > I see that the host->ring_size depends on PAGE_SIZE as well:
> >
> > #define DESC_RING_BUF_SZ        PAGE_SIZE
> > host->ring_size =3D DESC_RING_BUF_SZ / sizeof(struct idmac_desc_64addr)=
;
> > host->sg_cpu =3D dmam_alloc_coherent(host->dev,
> >                DESC_RING_BUF_SZ, &host->sg_dma, GFP_KERNEL);
> >
> > I don't see any reason for the ring buffer size to be tied to
> > PAGE_SIZE at all, it was probably picked as a reasonable
> > default in the initial driver but isn't necessarily ideal.
> >
> > From what I can see, the number of 4KB elements in the
> > ring can be as small as 128 (4KB pages, 64-bit addresses)
> > or as big as 4096 (64KB pages, 32-bit addresses), which is
> > quite a difference. If you are still motivated to drill
> > down into this, could you try changing DESC_RING_BUF_SZ
> > to a fixed size of either 4KB or 64KB and test again
> > with the opposite page size, to see if that changes the
> > throughput?
> >
>
> Hi Arnd,
>
> Sorry for the late reply. I'm a bit of busy with something else right
> now (trying to enable this same driver for Exynos850 in U-Boot, hehe),
> I'll try to carve out some time later and tinker with
> DESC_RING_BUF_SZ. But for now, can we just apply this patch as is? As
> I understand, it's fixing quite a major issue (at least from what I
> heard), so it would be nice to have it in -next and -stable. Does that
> sound reasonable?

Ideally, I would prefer it if you could try out Arnd's proposal,
unless you think that's too far ahead for you, of course? The point
is, that I would rather avoid us from messing around with these kinds
of configurations.

>
> Thanks!
>
> > If a larger ring buffer gives us significantly better
> > throughput, we may want to always use a higher number
> > independent of page size. On the other hand, if the
> > 64KB number (the 138MB/s) does not change with a smaller
> > ring, we may as well reduce that in order to limit the
> > maximum latency that is caused by a single I/O operation.
> >
> >      Arnd

Kind regards
Uffe

