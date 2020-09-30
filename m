Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD4527E429
	for <lists+linux-block@lfdr.de>; Wed, 30 Sep 2020 10:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbgI3IvQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 30 Sep 2020 04:51:16 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43387 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725779AbgI3IvQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Sep 2020 04:51:16 -0400
X-Greylist: delayed 546 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Sep 2020 04:51:15 EDT
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 776555C0098;
        Wed, 30 Sep 2020 04:42:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 30 Sep 2020 04:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=1uykCJ
        l9z1trDjjDD6M4aj2o9DpKLTXxPN0mLPuzHPc=; b=b4Ai//IVL8ZvDwys3DJ7Sf
        p7oNgNDRhYbUkVMG+p4wbPOpJBnbaAlZETfY728yAGegSlGy/T5/ILEqcG7XRrxC
        ag46xTewvcWyY+cuULrvkG5GeFWPn/4YAotkWIzrpH+lWtxXGYdfJt72wD0O3B/x
        rkVQpiOgZOROI0Kq0Xegq0r2sNp4bf8AUbyQlsB1q5HR3Po73KauLAnAy5L1oYz7
        dJH/yqXCoUaINO0W3z+2kVmYmorPKwyC9dYcHUK/FY7v1l/K2D4jmnrG3a5ejVkf
        pJ2Qe94m1sJTWT5XdOEohXWozqNaGI2itFyL+XUYFsTfokvicEEwqDAriogmWOOg
        ==
X-ME-Sender: <xms:4ER0X704NxP3qs17sQnp02iQFjUPB-ndCxt0z7ps7ExL1YPV832uzw>
    <xme:4ER0X6ESr0cv7uXyBvxT4OnwSF6fS3Gji2D7Unx6FGCo6XDsGBFmHm5a-DKC3HwxJ
    mua99tOrLIxXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedvgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrrhgvkhcu
    ofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinhhvih
    hsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepkeegtdfg
    vdeihefhhedtvdelieeiueetveehteffjeejjedvieejvefhueeffeegnecuffhomhgrih
    hnpehgihhthhhusgdrtghomhenucfkphepledurdeigedrudejtddrkeelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghkse
    hinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:4ER0X77sE5KlZrW4nYJAi1fjZRRT0I-r8nagITP3mN9CVnQlanl3CQ>
    <xmx:4ER0Xw3tOWE8nEq1CiOl18gbW9D05lNXb73QXjl83NN4ebvSXnbm8Q>
    <xmx:4ER0X-Fg43pkif_tJHur3HpBbXqGHLT7JbkOYw7ubyxDqe3bTC_GDQ>
    <xmx:4UR0X6DsQTnsN2wlvUkpmnigJFU5rRlZTyp0RpOWXT18mbIsXuzfkQ>
Received: from mail-itl (ip5b40aa59.dynamic.kabel-deutschland.de [91.64.170.89])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3471F328005A;
        Wed, 30 Sep 2020 04:42:07 -0400 (EDT)
Date:   Wed, 30 Sep 2020 10:42:04 +0200
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        xen-devel <xen-devel@lists.xenproject.org>,
        Roman Shaposhnik <roman@zededa.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Kernel panic on 'floppy' module load, Xen HVM, since 4.19.143
Message-ID: <20200930084204.GK3962@mail-itl>
References: <20200927111405.GJ3962@mail-itl>
 <26fe7920-d6a8-fb8a-b97c-59565410eff4@suse.com>
 <20200928093654.GW1482@mail-itl>
 <fc9c3b03-bb2c-f80d-0540-7456fc0821b2@linux.com>
 <20200929124126.GD1482@mail-itl>
 <5115e96f-f054-f720-b718-ceef1950f038@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AYsPlKobQGgtCvjI"
Content-Disposition: inline
In-Reply-To: <5115e96f-f054-f720-b718-ceef1950f038@suse.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--AYsPlKobQGgtCvjI
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Kernel panic on 'floppy' module load, Xen HVM, since 4.19.143

On Tue, Sep 29, 2020 at 04:05:21PM +0200, J=C3=BCrgen Gro=C3=9F wrote:
> On 29.09.20 14:41, Marek Marczykowski-G=C3=B3recki wrote:
> > On Tue, Sep 29, 2020 at 03:27:43PM +0300, Denis Efremov wrote:
> > > Hi,
> > >=20
> > > On 9/28/20 12:36 PM, Marek Marczykowski-G=C3=B3recki wrote:
> > > > On Mon, Sep 28, 2020 at 07:02:19AM +0200, J=C3=BCrgen Gro=C3=9F wro=
te:
> > > > > On 27.09.20 13:14, Marek Marczykowski-G=C3=B3recki wrote:
> > > > > > Hi all,
> > > > > >=20
> > > > > > I get kernel panic on 'floppy' module load. If I blacklist the =
module,
> > > > > > then everything works.
> > > > > > The issue happens in Xen HVM, other virtualization modes (PV, P=
VH) works
> > > > > > fine. PV dom0 works too. I haven't tried bare metal, but I assu=
me it
> > > > > > works fine too.
> > > > >=20
> > > > > Could you please try bare metal?
> > > >=20
> > > > I don't have any hw with floppy controller at hand...
> > > > Booting on what I have, it works, loading floppy just says -ENODEV.
> > >=20
> > > I saw that the issue was bisected [1] to commit
> > > c330fb1ddc0a ("XEN uses irqdesc::irq_data_common::handler_data to sto=
re a
> > > per interrupt XEN data pointer which contains XEN specific informatio=
n.")
> > >=20
> > > I have hardware, but I've never worked with Xen. It will take me some=
 time
> > > to set it up and reproduce the problem. I think I will do it in a wee=
k.
> >=20
> > Can you try to boot 4.19.143 (or any other including that commit)
> > directly on the hardware and make sure floppy module is loaded? We do
> > know it's broken in Xen HVM, it would be interested to see if it works
> > without Xen. Even better if you could use the same kernel config:
> > https://gist.github.com/marmarek/1e6a359c9a99af3ed8fc16af0f36d8a6
>=20
> I think it is not directly related to floppy, but a more general problem
> for HVM guests.
>=20
> I'm suspecting an issue with legacy IRQs. Could you please try the
> attached patch?

Yes, this fixes the issue.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--AYsPlKobQGgtCvjI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAl90RNoACgkQ24/THMrX
1yx1Mwf+Ne2cnDVvj9o4lWKYLjjUsC0hz+l5jhGK2mJ8O6BJWwftrLptR9iGBodN
2IgQkSbd9zEhQIRL9Xj/SLerK2SzBFq4iNfzq60az1PilBumz/awss2Iuq7Kg2Y3
4EMNimTdtqIvU9DmRuMCTwvJ7mvs0wbdPpZUftNkySlP3JWFRg4IE9SaMWXsnKPX
bkWbVh8b6GctydFp/S/Dxt+e+PQwiBiO/beXY1dVowXIe6SpNurfnGn2oiJ3DNzi
27T8rzhwc7W/8u+Lfd/M66/awbYmKWace7tB1Ay/0PXgiwR0VSoXrnm2c5m1mouB
rrjBiTUGUwWXfr7Z2JBa7xURxR3Jpw==
=J3VH
-----END PGP SIGNATURE-----

--AYsPlKobQGgtCvjI--
