Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711544069ED
	for <lists+linux-block@lfdr.de>; Fri, 10 Sep 2021 12:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhIJKQF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 10 Sep 2021 06:16:05 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39939 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233028AbhIJKPw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Sep 2021 06:15:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B458D5C0134;
        Fri, 10 Sep 2021 06:14:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 10 Sep 2021 06:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=/wNS6+
        or464rDz3sY0LcWdGJtIegU66I3vn7RxITel4=; b=ixc+is5ewLeMt2ZWDhbj5L
        LfY9wtMjuhJ5SjEko9OAPNqOeOlC3UirV1YLhye04C6w3G7P07EPSbWk6sargoaR
        ektsl/n6lNBCK7OGAxG28qpTWDU8aPfbfMcKX/xQJOlgn4uy+Q2aT0vh+qHHJld6
        1oUnvpCbtEK2NL3/Q64R+XwssHRECXjXIcaqw3zg9oJy0Dlv6pnl64IQhLbWp+dk
        c36aze02e4H4q9caIlTiFRBp89dI3+wN9KBp9ZMflYJUAF+cVhkA0p5FDBjSZByA
        IU18tkfmEMnEH4GQ9GBb/ELPnomqy7iQsmuGbeke18aB2eahJ0AaDuCb9D3etSHw
        ==
X-ME-Sender: <xms:EDA7YUwM28sR5NGGJjXqMSnz_hn3JYUHBtFMjbC94lJl7Nj_8k2eTA>
    <xme:EDA7YYSgVh-JJK3SK8VidWG6aBBC1pw7HLLmmPt9LESE1CNgGC7NLnIPFHiUgj6ZU
    4Wf8LZHHnoE1g>
X-ME-Received: <xmr:EDA7YWVIKZU4XlPPDoryRgVvTVOPSeVyUFJM1w9pDfs52i5IVsr-zl9N5o5Sm9eWAlpoI8T5U6gTCaRpgwVM8hdpr4V3SJJO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeguddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghrvghk
    ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeetveff
    iefghfekhffggeeffffhgeevieektedthfehveeiheeiiedtudegfeetffenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhes
    ihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:EDA7YSj9nTHQKF1bDS1CtxKM6t9TLU6eSM29aS1M9dg8424dbutpPw>
    <xmx:EDA7YWB-2l5VUhCyPkEZHHBamW5_0jRPiUmo8iMH5lRmF-wiOeLu5A>
    <xmx:EDA7YTKr-PE2ixBo5wmEQ7vv8tBMV7JiaquyjmJYnsR99TEBRjDLvw>
    <xmx:EDA7YcBTedB7etV_vVbWJQW8gzxfjc2co8Md5IrRLq998BojXTywnA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Sep 2021 06:14:38 -0400 (EDT)
Date:   Fri, 10 Sep 2021 12:14:35 +0200
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Beulich <jbeulich@suse.com>
Subject: Re: [PATCH v3 2/3] xen/blkfront: don't take local copy of a request
 from the ring page
Message-ID: <YTswC2T2cvsEw2dP@mail-itl>
References: <20210730103854.12681-1-jgross@suse.com>
 <20210730103854.12681-3-jgross@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bm4wVgWanBEqw53D"
Content-Disposition: inline
In-Reply-To: <20210730103854.12681-3-jgross@suse.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--bm4wVgWanBEqw53D
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Sep 2021 12:14:35 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Juergen Gross <jgross@suse.com>
Cc: xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Jan Beulich <jbeulich@suse.com>
Subject: Re: [PATCH v3 2/3] xen/blkfront: don't take local copy of a request
 from the ring page

On Fri, Jul 30, 2021 at 12:38:53PM +0200, Juergen Gross wrote:
> In order to avoid a malicious backend being able to influence the local
> copy of a request build the request locally first and then copy it to
> the ring page instead of doing it the other way round as today.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Reviewed-by: Jan Beulich <jbeulich@suse.com>
> Acked-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
> ---
> V2:
> - init variable to avoid potential compiler warning (Jan Beulich)
> ---
>  drivers/block/xen-blkfront.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index 15e840287734..b7301006fb28 100644

(...)

> @@ -827,10 +832,10 @@ static int blkif_queue_rw_req(struct request *req, =
struct blkfront_ring_info *ri
>  	if (setup.segments)
>  		kunmap_atomic(setup.segments);
> =20
> -	/* Keep a private copy so we can reissue requests when recovering. */
> -	rinfo->shadow[id].req =3D *ring_req;
> +	/* Copy request(s) to the ring page. */
> +	*final_ring_req =3D *ring_req;

Is this guaranteed to not be optimized by the compiler in an unsafe way
(like, do the operation the other way around)?
My version of the patch had "wmb()" just before, maybe a good idea to
add it here too?

>  	if (unlikely(require_extra_req))
> -		rinfo->shadow[extra_id].req =3D *extra_ring_req;
> +		*final_extra_ring_req =3D *extra_ring_req;
> =20
>  	if (new_persistent_gnts)
>  		gnttab_free_grant_references(setup.gref_head);
> --=20
> 2.26.2
>=20
>=20

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--bm4wVgWanBEqw53D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmE7MAwACgkQ24/THMrX
1ywDTgf/cDDueolNeVBsdSwc5Iux/HGLE7puVzmumjIhi8y29ZXfN2PQ2sb2B/dj
/cQLAGsch4KXU0IzHIAzzG8RHMLAToSTCisFHArlrpIYkxy1MlmbpboffrxqTohl
GEbW+f3lh+NT2/z5bA/iBVNnbWk4fLX/IdxuohxpsDKC/W1LKihh5HDO1lJAWmCj
uw+Ijvw7ljCAHlQaJVoGjjZv21OOu0bnT5+SCJjceL32UFQhOmBdL5bcGfvpcJRL
lLF27Bw4jMLYwF7uhZVxPthldKLqCz2x4vqCNMQWc17bSAJzXTdSFxE9KeyaYy1l
spoh1nVkPtrC+hrflObZihp/IQPX6g==
=mjV6
-----END PGP SIGNATURE-----

--bm4wVgWanBEqw53D--
