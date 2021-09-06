Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10004401519
	for <lists+linux-block@lfdr.de>; Mon,  6 Sep 2021 04:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbhIFC5O (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 5 Sep 2021 22:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238842AbhIFC5N (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 Sep 2021 22:57:13 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A75C061575;
        Sun,  5 Sep 2021 19:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1630896967;
        bh=gVuz8afyJ/HunKgJw2vF5XMPhVB1a8pcL5e5aB23HhA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BY+sYAKh5QV2OoKud0iQ+Dva/XcEZ09UqUgKA7u7+wOiNLF7XT//xCJ0wmeEMdZnh
         XZGsM2V7c7aj0IwZE5krcP1sjszG9PEsoOV6CFgPB9TYxdiOqGk//LBrio+rsh0DvL
         VmkHObNCX8WfWISkLYxZAvqwuXHoiMVY+e1W58fj+tYlqroJd4k/2LP4eCl4rZF07M
         JYbFVHvxEKiOFByaoxT8YRdYrDkC+cqnHRHOsSPUrdyODg0HuzPVYs7haX1wUxEHQ+
         bRgZrXAlGTbV7HXkHTOOQ8LT7ak8PNfWZl3JQdX+0N/6DxfZbzPqiIfvv9Q1YGs6dn
         ZEOgbhHz245eA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4H2tMB6cqRz9sW4;
        Mon,  6 Sep 2021 12:56:06 +1000 (AEST)
Date:   Mon, 6 Sep 2021 12:56:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block/mq-deadline: Move dd_queued() to fix defined but
 not used warning
Message-ID: <20210906125605.658fe211@canb.auug.org.au>
In-Reply-To: <caf2449c-e86d-195d-3635-9be49159166a@kernel.dk>
References: <20210830091128.1854266-1-geert@linux-m68k.org>
        <caf2449c-e86d-195d-3635-9be49159166a@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0TbvdZ.k.mzgR5pRSS1_teB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--Sig_/0TbvdZ.k.mzgR5pRSS1_teB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Thu, 2 Sep 2021 06:35:47 -0600 Jens Axboe <axboe@kernel.dk> wrote:
>
> On 8/30/21 3:11 AM, Geert Uytterhoeven wrote:
> > If CONFIG_BLK_DEBUG_FS=3Dn:
> >=20
> >     block/mq-deadline.c:274:12: warning: =E2=80=98dd_queued=E2=80=99 de=
fined but not used [-Wunused-function]
> >       274 | static u32 dd_queued(struct deadline_data *dd, enum dd_prio=
 prio)
> > 	  |            ^~~~~~~~~
> >=20
> > Fix this by moving dd_queued() just before the sole function that calls
> > it. =20
>=20
> Applied, thanks.

Can we get this to Linus ASAP as he has now made warnings fatal, so
this is causing lots of build failures.

--=20
Cheers,
Stephen Rothwell

--Sig_/0TbvdZ.k.mzgR5pRSS1_teB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmE1g0UACgkQAVBC80lX
0GxoqQf/c+RsNXvAYNILKQnSN2h4RX5Hp1KPTrRTqtA2fIfg75H0AkkRSes12lPZ
+3k4bbPJ11iELiCSTycYsDH457PjYcKAOA2/AQwy2rIsCBjvjx0w95TyaYok7Id6
bvQFxzgW0e0yHgic84UF8eGd4uM74Kl9R9n6hN9lolMaSfM+6iEVRtJ22HvfeyhF
bOnv4PVAvioibwbBthL1k+wmHu9dbhGzXuNpd9UiG8K6s65rn/P1aAqonea5Jhfi
xTmaRGbmsAaec2+qMbxhIaFifmQx784TCus7NGi426B0pCa/OFwM2YRsVrUsq3hY
QNHk/JxwgOfot/N3uibvER/dw5jU+Q==
=ePjo
-----END PGP SIGNATURE-----

--Sig_/0TbvdZ.k.mzgR5pRSS1_teB--
