Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F39912E1AB
	for <lists+linux-block@lfdr.de>; Wed, 29 May 2019 17:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfE2Pxy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 May 2019 11:53:54 -0400
Received: from sonic303-8.consmr.mail.bf2.yahoo.com ([74.6.131.47]:40267 "EHLO
        sonic303-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727080AbfE2Pxx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 11:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559145231; bh=Mhbbs/5zWDmSATWlWIaWSZbJKp7jJqyJaP5TnNMG0Cw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=qADd6C9dYyk8KS/JPMsgMG4dSY02lpjCx3eUrn3i8pPoaQZwpwXVOaljGU9u5kB8KHIYPQa9JunT+waccGB55AKFbHuWiQXTLZPfIlOsadSGQWce4R8t5X7yVT3Rxip9j60HgY+G4hVU3/ptICnzlwewJdUkeCaLXNcJJudrHcriKspDKrN/fRDCSfJZJxcWAlh2zFp/FbyZWxtxga81R18kPHV40pfSas4Eu3B2eQXvV/+WBdnIHxzmM02R7fh3D6S+Vo5PtUv1AXp9otJfWz/Kq6PtblUogqiSycCv9a6L69ORe4P0PEPC8X9UQ7t3AGD64udX3VEdir3jGwPH7Q==
X-YMail-OSG: un8.J_sVM1kuGbHsYEm81uJHc1EgIo3WEUPpoKRMD88B4ckPYjIHzzu3KeSb98x
 Y5EsfcoCL8aaVWM26Xw4_KyP7tHf4ADBTaZPve5fZb2A91v0VuJ2Kk69t_rEFAk0iOMX7Z__Nyqt
 qAYNOQ7nhEXahnndv8QX45sGkCWwQpISHuw5nseb9UJMLc.FZHo6lVuMzEa.z41Yc.nlOfeF9LFT
 iG.NFhIMHl8fUhT9rxrvPwQWvJng0prtB920ojYer9ZUQwbpkhxa6BAATZubuY_BsqHtWi36waxq
 xfLOnA2RQ5x6Xd54IUTW8SOY8NPAegET5HYrnH2IrO89lYEpDlyDTPW2AMMabjzLVO_J5Mlzq99L
 I5vSBMEVOg9pJ4V.1sFjb0duC3SlbU5vTrQBDfVWWYjgUtwP1SRhCDyjKFxUQ2YxOBEh.XwyxYfU
 BKM41k33feB1SUQ4024vbWRSpTnCjx63UtxLNIdrlxv23VsO4SGgzX28APdEzu6XLw4.hQ0WD1WC
 mDswysk_zaD0uWc3z_Ff6jgCgyL.BgAUSEZs59scWzUdY0bYejhQYRc9nw43sNuKmtowK1C.rSUA
 BgAdyCN008k0cKyycfH0l91VvYMu6SixXnrLGlxnnwzx1AEpu9PFlfreiAP52iEzC9Rq53BAMZPm
 W6wiIe6hxOQ9KtA9HTqpHBaqj6wB_aF3KadJUr96rma1EARmY2b5L2oRG65h_E5HzGXM0ZblRc6J
 UW4h12ANx4CbV6mKSI_2cc0VV.y.TmAZe5VMG8pwIhYahKotMruLPZpfC.iw7BeReEsyTxzjpykW
 iC0bWqgm6tPwgbFHwiwm5mvH9z1GAMwdKYevY2GsZHqul2auRN5sYDzHp84kOK1WI7XpTndmJWWe
 KZOFTdqexV20nvXFEQ8PE0LeK.bjAmHvNwVoKuIiK.PV14pYo_G2SuNRSvYLJ3nhOwW.Y2hx6iZL
 uIkmj9ZaCEHEdFh0EZHvnY7BoZFTkC2_Dw4mQZ5JDZ_GXOpzoUqK1E0n8NufYZIJ0iB7GMHHS7tW
 Dp8KhOPlS9WCtb_vXu0v7GLez3rS9Qv8W14odbSUUBpPbCmTBY5hqlaY3kPwBCK5uBzxN5C3wly2
 Sl75ILGM34._zWV818b0wwUVtYf692GLllUWrHdN1WZf.Ad3NxwLrBv8kAeRnUCjohfWVyxZqe93
 Yj5UeurORKiMUBmXBc2Wja6QWyR0bvHk5BbvMIwgY7A0C._nmVF9mZxJH9tT3jpJwIjPFfQOhM18
 mJOFCgs_8nJ2ch1wn6DSN4AE1IiERihrII.S3iQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Wed, 29 May 2019 15:53:51 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp410.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9da4e0a2a8856f6c7fc42e042e64d391;
          Wed, 29 May 2019 15:53:47 +0000 (UTC)
Subject: Re: [PATCH 3/7] vfs: Add a mount-notification facility
To:     David Howells <dhowells@redhat.com>, Jann Horn <jannh@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
References: <CAG48ez2rRh2_Kq_EGJs5k-ZBNffGs_Q=vkQdinorBgo58tbGpg@mail.gmail.com>
 <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <155905933492.7587.6968545866041839538.stgit@warthog.procyon.org.uk>
 <14347.1559127657@warthog.procyon.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 mQINBFzV9HABEAC/mmv3jeJyF7lR7QhILYg1+PeBLIMZv7KCzBSc/4ZZipoWdmr77Lel/RxQ
 1PrNx0UaM5r6Hj9lJmJ9eg4s/TUBSP67mTx+tsZ1RhG78/WFf9aBe8MSXxY5cu7IUwo0J/CG
 vdSqACKyYPV5eoTJmnMxalu8/oVUHyPnKF3eMGgE0mKOFBUMsb2pLS/enE4QyxhcZ26jeeS6
 3BaqDl1aTXGowM5BHyn7s9LEU38x/y2ffdqBjd3au2YOlvZ+XUkzoclSVfSR29bomZVVyhMB
 h1jTmX4Ac9QjpwsxihT8KNGvOM5CeCjQyWcW/g8LfWTzOVF9lzbx6IfEZDDoDem4+ZiPsAXC
 SWKBKil3npdbgb8MARPes2DpuhVm8yfkJEQQmuLYv8GPiJbwHQVLZGQAPBZSAc7IidD2zbf9
 XAw1/SJGe1poxOMfuSBsfKxv9ba2i8hUR+PH7gWwkMQaQ97B1yXYxVEkpG8Y4MfE5Vd3bjJU
 kvQ/tOBUCw5zwyIRC9+7zr1zYi/3hk+OG8OryZ5kpILBNCo+aePeAJ44znrySarUqS69tuXd
 a3lMPHUJJpUpIwSKQ5UuYYkWlWwENEWSefpakFAIwY4YIBkzoJ/t+XJHE1HTaJnRk6SWpeDf
 CreF3+LouP4njyeLEjVIMzaEpwROsw++BX5i5vTXJB+4UApTAQARAQABtChDYXNleSBTY2hh
 dWZsZXIgPGNhc2V5QHNjaGF1Zmxlci1jYS5jb20+iQJUBBMBCAA+FiEEC+9tH1YyUwIQzUIe
 OKUVfIxDyBEFAlzV9HACGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQOKUV
 fIxDyBG6ag/6AiRl8yof47YOEVHlrmewbpnlBTaYNfJ5cZflNRKRX6t4bp1B2YV1whlDTpiL
 vNOwFkh+ZE0eI5M4x8Gw2Oiok+4Q5liA9PHTozQYF+Ia+qdL5EehfbLGoEBqklpGvG3h8JsO
 7SvONJuFDgvab/U/UriDYycJwzwKZuhVtK9EMpnTtUDyP3DY+Q8h7MWsniNBLVXnh4yBIEJg
 SSgDn3COpZoFTPGKE+rIzioo/GJe8CTa2g+ZggJiY/myWTS3quG0FMvwvNYvZ4I2g6uxSl7n
 bZVqAZgqwoTAv1HSXIAn9muwZUJL03qo25PFi2gQmX15BgJKQcV5RL0GHFHRThDS3IyadOgK
 P2j78P8SddTN73EmsG5OoyzwZAxXfck9A512BfVESqapHurRu2qvMoUkQaW/2yCeRQwGTsFj
 /rr0lnOBkyC6wCmPSKXe3dT2mnD5KnCkjn7KxLqexKt4itGjJz4/ynD/qh+gL7IPbifrQtVH
 JI7cr0fI6Tl8V6efurk5RjtELsAlSR6fKV7hClfeDEgLpigHXGyVOsynXLr59uE+g/+InVic
 jKueTq7LzFd0BiduXGO5HbGyRKw4MG5DNQvC//85EWmFUnDlD3WHz7Hicg95D+2IjD2ZVXJy
 x3LTfKWdC8bU8am1fi+d6tVEFAe/KbUfe+stXkgmfB7pxqW5Ag0EXNX0cAEQAPIEYtPebJzT
 wHpKLu1/j4jQcke06Kmu5RNuj1pEje7kX5IKzQSs+CPH0NbSNGvrA4dNGcuDUTNHgb5Be9hF
 zVqRCEvF2j7BFbrGe9jqMBWHuWheQM8RRoa2UMwQ704mRvKr4sNPh01nKT52ASbWpBPYG3/t
 WbYaqfgtRmCxBnqdOx5mBJIBh9Q38i63DjQgdNcsTx2qS7HFuFyNef5LCf3jogcbmZGxG/b7
 yF4OwmGsVc8ufvlKo5A9Wm+tnRjLr/9Mn9vl5Xa/tQDoPxz26+aWz7j1in7UFzAarcvqzsdM
 Em6S7uT+qy5jcqyuipuenDKYF/yNOVSNnsiFyQTFqCPCpFihOnuaWqfmdeUOQHCSo8fD4aRF
 emsuxqcsq0Jp2ODq73DOTsdFxX2ESXYoFt3Oy7QmIxeEgiHBzdKU2bruIB5OVaZ4zWF+jusM
 Uh+jh+44w9DZkDNjxRAA5CxPlmBIn1OOYt1tsphrHg1cH1fDLK/pDjsJZkiH8EIjhckOtGSb
 aoUUMMJ85nVhN1EbU/A3DkWCVFEA//Vu1+BckbSbJKE7Hl6WdW19BXOZ7v3jo1q6lWwcFYth
 esJfk3ZPPJXuBokrFH8kqnEQ9W2QgrjDX3et2WwZFLOoOCItWxT0/1QO4ikcef/E7HXQf/ij
 Dxf9HG2o5hOlMIAkJq/uLNMvABEBAAGJAjwEGAEIACYWIQQL720fVjJTAhDNQh44pRV8jEPI
 EQUCXNX0cAIbDAUJEswDAAAKCRA4pRV8jEPIEWkzEACKFUnpp+wIVHpckMfBqN8BE5dUbWJc
 GyQ7wXWajLtlPdw1nNw0Wrv+ob2RCT7qQlUo6GRLcvj9Fn5tR4hBvR6D3m8aR0AGHbcC62cq
 I7LjaSDP5j/em4oVL2SMgNTrXgE2w33JMGjAx9oBzkxmKUqprhJomPwmfDHMJ0t7y39Da724
 oLPTkQDpJL1kuraM9TC5NyLe1+MyIxqM/8NujoJbWeQUgGjn9uxQAil7o/xSCjrWCP3kZDID
 vd5ZaHpdl8e1mTExQoKr4EWgaMjmD/a3hZ/j3KfTVNpM2cLfD/QwTMaC2fkK8ExMsz+rUl1H
 icmcmpptCwOSgwSpPY1Zfio6HvEJp7gmDwMgozMfwQuT9oxyFTxn1X3rn1IoYQF3P8gsziY5
 qtTxy2RrgqQFm/hr8gM78RhP54UPltIE96VywviFzDZehMvuwzW//fxysIoK97Y/KBZZOQs+
 /T+Bw80Pwk/dqQ8UmIt2ffHEgwCTbkSm711BejapWCfklxkMZDp16mkxSt2qZovboVjXnfuq
 wQ1QL4o4t1hviM7LyoflsCLnQFJh6RSBhBpKQinMJl/z0A6NYDkQi6vEGMDBWX/M2vk9Jvwa
 v0cEBfY3Z5oFgkh7BUORsu1V+Hn0fR/Lqq/Pyq+nTR26WzGDkolLsDr3IH0TiAVH5ZuPxyz6
 abzjfg==
Message-ID: <312a138c-e5b2-4bfb-b50b-40c82c55773f@schaufler-ca.com>
Date:   Wed, 29 May 2019 08:53:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <14347.1559127657@warthog.procyon.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cNkJJFaLGPzGj0MrH4stT0km9ovmzGP9Z"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cNkJJFaLGPzGj0MrH4stT0km9ovmzGP9Z
Content-Type: multipart/mixed; boundary="CGJ0IeN7E9pxspTs8jkc4kNwow51RM68Y";
 protected-headers="v1"
From: Casey Schaufler <casey@schaufler-ca.com>
To: David Howells <dhowells@redhat.com>, Jann Horn <jannh@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>, linux-block@vger.kernel.org,
 keyrings@vger.kernel.org,
 linux-security-module <linux-security-module@vger.kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>
Message-ID: <312a138c-e5b2-4bfb-b50b-40c82c55773f@schaufler-ca.com>
Subject: Re: [PATCH 3/7] vfs: Add a mount-notification facility
References: <CAG48ez2rRh2_Kq_EGJs5k-ZBNffGs_Q=vkQdinorBgo58tbGpg@mail.gmail.com>
 <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <155905933492.7587.6968545866041839538.stgit@warthog.procyon.org.uk>
 <14347.1559127657@warthog.procyon.org.uk>
In-Reply-To: <14347.1559127657@warthog.procyon.org.uk>

--CGJ0IeN7E9pxspTs8jkc4kNwow51RM68Y
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

On 5/29/2019 4:00 AM, David Howells wrote:
> Jann Horn <jannh@google.com> wrote:
>
>>> +void post_mount_notification(struct mount *changed,
>>> +                            struct mount_notification *notify)
>>> +{
>>> +       const struct cred *cred =3D current_cred();
>> This current_cred() looks bogus to me. Can't mount topology changes
>> come from all sorts of places? For example, umount_mnt() from
>> umount_tree() from dissolve_on_fput() from __fput(), which could
>> happen pretty much anywhere depending on where the last reference gets=

>> dropped?
> IIRC, that's what Casey argued is the right thing to do from a security=
 PoV.
> Casey?

You need to identify the credential of the subject that triggered
the event. If it isn't current_cred(), the cred needs to be passed
in to post_mount_notification(), or derived by some other means.

> Maybe I should pass in NULL creds in the case that an event is being ge=
nerated
> because an object is being destroyed due to the last usage[*] being rem=
oved.

You should pass the cred of the process that removed the
last usage. If the last usage was removed by something like
the power being turned off on a disk drive a system cred
should be used. Someone or something caused the event. It can
be important who it was.

>  [*] Usage, not ref - Superblocks are a bit weird in their accounting.
>
> David


--CGJ0IeN7E9pxspTs8jkc4kNwow51RM68Y--

--cNkJJFaLGPzGj0MrH4stT0km9ovmzGP9Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEC+9tH1YyUwIQzUIeOKUVfIxDyBEFAlzuqwkACgkQOKUVfIxD
yBEWag//SJA6JpQHXqyOeXOtCod82vVguKxz7q2fheSMMS+T8bB0rX2XTO4rho9D
t5wUt9c1+HtGk8HBvbS7vOnjhXso6RshvI2uUEfE0MOQ/Y1FBIqXwrTzpSs8/FVE
tv3YFqCWlcaLOfnh/Gl0GvK+o5DGMVFDVsv0j3ke5VihJ4enHnn18AncowE5nVu3
n9GahTQcWaRIgYIHJ9Wr0olwAQsa2TQpj/0wJR3I5ni1hY10wknm9jCIw2L612xU
l5rZ73EqvgIjqsq9m1rgZqjH3QypYvTgdDCd9I/AdZmAI8QJ3JISRzZlKGw2o6GL
ZIExEzQCVMzGyqEDkTxQQlXjczfF7jHCWQ9+iyyz747JMRrx1Kr6LqZlTJsfQCc0
F+Ytx0D8RVkwkpkrzIQz5eS/R2ib2lYH7Jtk9RhreDagrzkieeyZ3A3Y0feYqIb3
O7tGYBfQVWx5dVjB5nZ7v/aUw7Wc929yiONfiHLxSg8U4xlj0mFSa0HFOYC4DzaG
C0NSVb7xvoDfpyt6m9Wv1mF7cJKkLFffeMfqUREZAcNEdiYrg90Ho6cJ5tZVreSu
rVgR81R7SSVANygbfauj9X3N3D4fsWxu+D81zz0B9CBgy8GP+p/kWrL45hRC4CLN
hG3yC60hUm54xq2H3YT775eyGBcDixyPsh5qmTXQ21MtLLm3W1c=
=qEff
-----END PGP SIGNATURE-----

--cNkJJFaLGPzGj0MrH4stT0km9ovmzGP9Z--
