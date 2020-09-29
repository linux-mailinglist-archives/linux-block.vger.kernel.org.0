Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8933527CD19
	for <lists+linux-block@lfdr.de>; Tue, 29 Sep 2020 14:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733098AbgI2Mlv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 29 Sep 2020 08:41:51 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:42069 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732975AbgI2Mlf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Sep 2020 08:41:35 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 62F5BA50;
        Tue, 29 Sep 2020 08:41:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 29 Sep 2020 08:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=50mbcJ
        AAnnSrPE9ZtE8TKsqOXOwAXnyPaol4sZNt/DM=; b=ZbCGj6I8c+w1lnxESq2GXM
        02Or7kr5MtWgwxAwF9MQf4KZyfhsakKM5xBFif+PVbOt9DF+6CDrGqZz7k9td+x+
        dLyuRybzSbk+9VRZxZnwhzLDt1lN3ILZ1PYVaZHzNZ31mHaVJ+V+thsKefayXBss
        X5XAGSz6oDey+qeJHEZathwy/Cnn3SfKspI1A08blVGng5LgcMCpsikxK3ERmagG
        BAeb9IONzbm0kJri8iaXhxSiy8pM+dHu53uyUDtzSp+YrLUJsvl+urRZo9nFE5/4
        DmJfktKP/10eiFBs6ir6Y06N2G0ocoIMzDVUlm+3y8iyZ5l2X4K8Jsc/JIh1NK4w
        ==
X-ME-Sender: <xms:eStzX3Iy7cBhvehzFvydRO5gNTzwEefJ8azaC9NBN9bdDsc9olpqGA>
    <xme:eStzX7ICX-WOAF-5og--N1arOm0jSiiPVHokgJuC4LQXLmm3m_aoR1mjjCqAbCMxi
    wbVNm8aU1KhGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdekgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrrhgvkhcu
    ofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinhhvih
    hsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepkeegtdfg
    vdeihefhhedtvdelieeiueetveehteffjeejjedvieejvefhueeffeegnecuffhomhgrih
    hnpehgihhthhhusgdrtghomhenucfkphepledurdeigedrudejtddrkeelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghkse
    hinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:eStzX_tpWNXctFOW-Z5vyJdIglcIRmSpOHcJaCvycGDiiD9OkMMbuw>
    <xmx:eStzXwYOJOj0KNvv0iu_q8FPoM8VGKBYDyEXbqet2KQ1nhcmLbYfJA>
    <xmx:eStzX-Ygv5mcIBohUagua1cmR3lJL3oHoXzFX6ylkUbD12k8aUAn1w>
    <xmx:eytzX-GvtJavW8Sf3cI_r9hzuGFfIVPpU72zkAXHKDNVgTMNBhrlPA>
Received: from mail-itl (ip5b40aa59.dynamic.kabel-deutschland.de [91.64.170.89])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9CD9A3064685;
        Tue, 29 Sep 2020 08:41:28 -0400 (EDT)
Date:   Tue, 29 Sep 2020 14:41:26 +0200
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Denis Efremov <efremov@linux.com>
Cc:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        xen-devel <xen-devel@lists.xenproject.org>,
        Roman Shaposhnik <roman@zededa.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Kernel panic on 'floppy' module load, Xen HVM, since 4.19.143
Message-ID: <20200929124126.GD1482@mail-itl>
References: <20200927111405.GJ3962@mail-itl>
 <26fe7920-d6a8-fb8a-b97c-59565410eff4@suse.com>
 <20200928093654.GW1482@mail-itl>
 <fc9c3b03-bb2c-f80d-0540-7456fc0821b2@linux.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sgof50bbbY3Ojj4a"
Content-Disposition: inline
In-Reply-To: <fc9c3b03-bb2c-f80d-0540-7456fc0821b2@linux.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--sgof50bbbY3Ojj4a
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Kernel panic on 'floppy' module load, Xen HVM, since 4.19.143

On Tue, Sep 29, 2020 at 03:27:43PM +0300, Denis Efremov wrote:
> Hi,
>=20
> On 9/28/20 12:36 PM, Marek Marczykowski-G=C3=B3recki wrote:
> > On Mon, Sep 28, 2020 at 07:02:19AM +0200, J=C3=BCrgen Gro=C3=9F wrote:
> >> On 27.09.20 13:14, Marek Marczykowski-G=C3=B3recki wrote:
> >>> Hi all,
> >>>
> >>> I get kernel panic on 'floppy' module load. If I blacklist the module,
> >>> then everything works.
> >>> The issue happens in Xen HVM, other virtualization modes (PV, PVH) wo=
rks
> >>> fine. PV dom0 works too. I haven't tried bare metal, but I assume it
> >>> works fine too.
> >>
> >> Could you please try bare metal?
> >=20
> > I don't have any hw with floppy controller at hand...
> > Booting on what I have, it works, loading floppy just says -ENODEV.
>=20
> I saw that the issue was bisected [1] to commit
> c330fb1ddc0a ("XEN uses irqdesc::irq_data_common::handler_data to store a
> per interrupt XEN data pointer which contains XEN specific information.")
>=20
> I have hardware, but I've never worked with Xen. It will take me some time
> to set it up and reproduce the problem. I think I will do it in a week.

Can you try to boot 4.19.143 (or any other including that commit)
directly on the hardware and make sure floppy module is loaded? We do
know it's broken in Xen HVM, it would be interested to see if it works
without Xen. Even better if you could use the same kernel config:
https://gist.github.com/marmarek/1e6a359c9a99af3ed8fc16af0f36d8a6

> [1] https://github.com/QubesOS/qubes-issues/issues/6074#issuecomment-6996=
36351

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--sgof50bbbY3Ojj4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAl9zK3QACgkQ24/THMrX
1yxvAAf/bE8nXZGK/5rzSHsFmVNBR14inSsT6jjs3wDRz0lCcXe69fmOg9okhcZg
8pvklLOuPkkoiG/jK3ALp+e+AeIeBqjsZ+dG+/Qe6jSwPeAGi2GqGyAoBgLT3uvJ
13sFTriBPGuix3gQIVdIlU9Qc4VoqPaOQyIqYoCmbqgxWz32Hp/Vo0RDHRm1Q2jN
yyZFNi4Aug6KHBrdlvx1bBFrV5cqYjOW5RCqIao/cCQzgQQcD+hBHOP7evcWXmAL
Il27dzbe2HudXH4HKTsOTuRIsTzQoVZv9vfaQSsbKfjA+rDticIBPCZeYoS+cHV2
qwT7B66QCmuSk6F4tEEYDiM7YcdYOw==
=i3dY
-----END PGP SIGNATURE-----

--sgof50bbbY3Ojj4a--
