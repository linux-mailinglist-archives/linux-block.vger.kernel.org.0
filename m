Return-Path: <linux-block+bounces-27626-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D80E1B8AE19
	for <lists+linux-block@lfdr.de>; Fri, 19 Sep 2025 20:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A515864B1
	for <lists+linux-block@lfdr.de>; Fri, 19 Sep 2025 18:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA91F25DCE0;
	Fri, 19 Sep 2025 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8h8t1FO"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0995261B64
	for <linux-block@vger.kernel.org>; Fri, 19 Sep 2025 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305709; cv=none; b=FBnFu0moaenEbHZTaSYg9UWUgzwCKNN3nDq98xONRQODTnnzGUAOOYkCYXPMX6ZNLLlzHlBn/An5WRh9E+qpZunOxMrxFzN2ADxdKyqdhaH9lmjopAr2Cms8DlTfK0hnwx3J4uhayEVidfX3fDw1x5Z9Z3UpGYm2ipEw6Ygz730=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305709; c=relaxed/simple;
	bh=SU7ouAUS4fSEsX0AQf3RRT7FNWxnC3izv7DdmJIVxho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkT4+/IO3ZD43A72rvfBdk/bP+vX4xODRiSAEysKRsXqY5/iC0V1lRJ+fhckyuMCFIhSzt/RzMo7lHYCpUv5SpYInFawcVZTYS+GzSd/TFn1BYuAjDV/PX62RAYYi2Oq4li5SZLMCT7lrYHAN1iTacwduUodQlaO0V7mJGZkQv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8h8t1FO; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b794e9a850so18717361cf.2
        for <linux-block@vger.kernel.org>; Fri, 19 Sep 2025 11:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758305705; x=1758910505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Rc3o0DtMuxjBD1JkaH5/eYeaLZxutE0LWJ2BWNFmsE=;
        b=Q8h8t1FOkV8QAhLeMmDjN5OIZwpQtvb0LBdiHlVebFzkJ3dIF22epcu1V4lPBXbNKq
         dkjo9AGwNjlgLrBYQkkvOBmFRc7XSrlHQnuLGCkORH3xrLBLYaFd1PPenwn7EHdEm1Px
         6I8sCsgxYgbKJXT7L8kAWS6uCN9OibPhB2pf8GmhqTwCEhwq+Pl5kEwprOvCKJYfEhr8
         pFCcKSh7LyIg1KsmIviqIz949LB98/twp4b1W5bXC1RTE/C2/QkCR4+qEkz4ofUGNwmJ
         BbgfcfhbaTUlXwKjvwWC55j5o18s9PRKs0HVRLPrjA5sk5Nk7tiKoTCs75YgeodnwdBD
         A//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305705; x=1758910505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Rc3o0DtMuxjBD1JkaH5/eYeaLZxutE0LWJ2BWNFmsE=;
        b=ujegUY3xdRJxiPkFoMOVyBKAm7emrDnJvOV7OUvug2H11T9xQh/HtTnbr4ma+jj6BZ
         IGoCY4Pre5v8j5vNoECD7EsvVYreDpj93bolBSBnuNqduNeUrZu4Jld6E8MWNvxD19AV
         8gQVw6ez5SwdesAlEvnGkV78SSF5GtJZiRL1rJv1hTPiNl5o6BamqhOuSgWDdhSPkbb+
         sxL5uRJzozgnrb1813HSHSH2bj8eBh+OBx+2u6INuCsSRZi8fLJo+oBP2S/bcGRMd4XI
         8jQh4TgqTIGXjKiVRenjC9gHouljIxY2BflmkGgyPDfTnh8ZlDvMVAVALHzSZYraQD/7
         gCJg==
X-Forwarded-Encrypted: i=1; AJvYcCWZi+YLYednoKSqt4tXOZ38Ccv6oABGIXmo1fWqm8bH3sG1GWgS8dhofA2FVp94/gSNJG1V6ffu8Epxgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfBLsE3yje27ekmR/li/L0UsnBHSpUcS1N03Qlbiq/glSwWVGu
	adw3/0zYJdm7OZgrS/WQtwTD1Was8xJcHvIHKgJfOQ96tUf6pxda+5oxZEkJT7y5vWJLYrKSeXF
	J01Byq9gctRHqHItJbWIdVdXJ1K/byy0=
X-Gm-Gg: ASbGncu3p6rTu43dZBAg33YWV1zOcH/yR2jByzil5keK+/sul+c/tNr9MM0LAkbRxNc
	G/a0Tp2Ctm6kp3vjpTYV8WdDplYdFSbTbwwXx7yIukZpKgv1JgBssXASDhsj8qZ/YKkSEmVHBVI
	sUH9SAvT3NQPCuty2959PXnj5F83GJdB5PHRqAnxiG79Zxd3MVwUV0tHO7WKvFoJevcvLKmEz6N
	gJlYd57ERTEZWX2uzs3+09n2ZJRAa3Q75nGghSH
X-Google-Smtp-Source: AGHT+IFqVuAbTud8sr5sQDzUbR4SVBdcuk43pldjIoGePaUBz5b0yq9EV02amkv9JjhitX99n9+uqsw7zVrBa9moCeo=
X-Received: by 2002:a05:622a:13c6:b0:4b5:d9a1:fe38 with SMTP id
 d75a77b69052e-4c0720ab81emr54958861cf.38.1758305705459; Fri, 19 Sep 2025
 11:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
 <20250916234425.1274735-8-joannelkoong@gmail.com> <20250918214953.GW1587915@frogsfrogsfrogs>
In-Reply-To: <20250918214953.GW1587915@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 19 Sep 2025 11:14:53 -0700
X-Gm-Features: AS18NWBx_3JdX9ikwterXg-lOW9lZ51jYQabtjy-zedgbMsJztKl5lVrFUJr6dY
Message-ID: <CAJnrk1Z1Cqi_PGhjRyiAOV-QrYLJyq=jh0_c+E9q0xYPjBmz_Q@mail.gmail.com>
Subject: Re: [PATCH v3 07/15] iomap: track read/readahead folio ownership internally
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org, 
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 2:49=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Tue, Sep 16, 2025 at 04:44:17PM -0700, Joanne Koong wrote:
> > The purpose of "struct iomap_read_folio_ctx->cur_folio_in_bio" is to
> > track folio ownership to know who is responsible for unlocking it.
> > Rename "cur_folio_in_bio" to "cur_folio_owned" to better reflect this
> > purpose and so that this can be generically used later on by filesystem=
s
> > that are not block-based.
>
> Hrmm, well if this is becoming a private variable, then I'd shorten it
> to "folio_owned" since it's not really in the ctx/cur anymore, but I
> might be bikeshedding now. :)

Oo I'll do this for ->read_folio (and for the arg name in
iomap_read_folio_iter()) since there's only 1 folio which makes it
obvious which folio it is, but for ->readahead I'll keep it as
"cur_folio_owned" to make it more obvious that the folio owned state
refers to the folio in ctx->cur_folio.

>
> > Since "struct iomap_read_folio_ctx" will be made a public interface
> > later on when read/readahead takes in caller-provided callbacks, track
> > the folio ownership state internally instead of exposing it in "struct
> > iomap_read_folio_ctx" to make the interface simpler for end users.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/iomap/buffered-io.c | 34 +++++++++++++++++++++++-----------
> >  1 file changed, 23 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 6c5a631848b7..587bbdbd24bc 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -352,7 +352,6 @@ static void iomap_read_end_io(struct bio *bio)
> >
> >  struct iomap_read_folio_ctx {
> >       struct folio            *cur_folio;
> > -     bool                    cur_folio_in_bio;
> >       void                    *read_ctx;
> >       struct readahead_control *rac;
> >  };
> > @@ -376,7 +375,6 @@ static void iomap_bio_read_folio_range(const struct=
 iomap_iter *iter,
> >       sector_t sector;
> >       struct bio *bio =3D ctx->read_ctx;
> >
> > -     ctx->cur_folio_in_bio =3D true;
> >       if (ifs) {
> >               spin_lock_irq(&ifs->state_lock);
> >               ifs->read_bytes_pending +=3D plen;
> > @@ -413,7 +411,7 @@ static void iomap_bio_read_folio_range(const struct=
 iomap_iter *iter,
> >  }
> >
> >  static int iomap_read_folio_iter(struct iomap_iter *iter,
> > -             struct iomap_read_folio_ctx *ctx)
> > +             struct iomap_read_folio_ctx *ctx, bool *cur_folio_owned)
> >  {
> >       const struct iomap *iomap =3D &iter->iomap;
> >       loff_t pos =3D iter->pos;
> > @@ -450,6 +448,7 @@ static int iomap_read_folio_iter(struct iomap_iter =
*iter,
> >                       folio_zero_range(folio, poff, plen);
> >                       iomap_set_range_uptodate(folio, poff, plen);
> >               } else {
> > +                     *cur_folio_owned =3D true;
> >                       iomap_bio_read_folio_range(iter, ctx, pos, plen);
> >               }
> >
> > @@ -472,16 +471,22 @@ int iomap_read_folio(struct folio *folio, const s=
truct iomap_ops *ops)
> >       struct iomap_read_folio_ctx ctx =3D {
> >               .cur_folio      =3D folio,
> >       };
> > +     /*
> > +      * If an external IO helper takes ownership of the folio, it is
> > +      * responsible for unlocking it when the read completes.
>
> Not sure what "external" means here -- I think for your project it means
> a custom folio read method supplied by a filesystem, but for the exist
> code (xfs submitting unaltered bios), that part is still mostly internal
> to iomap.
>
> If we were *only* refactoring code I would suggest s/external/async/
> because that's what the bio code does, but a filesystem supplying its
> own folio read function could very well fill the folio synchronously and
> it'd still have to unlock the folio.
>
> Maybe just get rid of the word external?  The rest of the code changes
> look fine to me.

Sounds good, I'll get rid of "external".

Thanks for reviewing this patchset!
>
> --D
>

