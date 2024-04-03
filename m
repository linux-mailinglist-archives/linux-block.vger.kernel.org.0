Return-Path: <linux-block+bounces-5702-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5F189719D
	for <lists+linux-block@lfdr.de>; Wed,  3 Apr 2024 15:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2B51F25700
	for <lists+linux-block@lfdr.de>; Wed,  3 Apr 2024 13:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1C5148823;
	Wed,  3 Apr 2024 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjgGsusJ"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79A81487CB
	for <linux-block@vger.kernel.org>; Wed,  3 Apr 2024 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152314; cv=none; b=qKkfp5I9NMjLvdlrywqIHJ/JIG4sIb6e/aQli+87ZeJRlhriZCWCLxzX+HyAFfbMPRs4CqhZBojfXf/9hc6nLLgSZhLMw0fxiJcKKYnIxsWXsE7aHBBMO+wp++k74CESkgRzVSQPoNcuJWQZxkVUYRCSkrSmEtc8YAeO7rEE9bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152314; c=relaxed/simple;
	bh=pHG2tsAWxZn37gkN2Ny9kczSaLWLC3JNDuMK3nNmWfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFhdUYtbrn6Ht+npOkAqs8dJkNFCKGrW59MS125G5S6FRQqV2TW07iGX5ZYBQn6LQpauCFWnkcnRXStKyzuKvl1+c/GM+kw/lzJsCjcZll00tyX+Sxv+XY/TYhFzmjWND8rZtdEi8kBaLRGzaJjRWcYDjsxXIWZFW59dF9mwe7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CjgGsusJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712152311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PllW2rrzDmRw3e0KEKEhY+erPYkfL+5VU6NwuszEdv4=;
	b=CjgGsusJm9WNE2U7EMj8duXWVTq2s+HV5ejpaoXj83hEH8R3xiJ2t71BYd6lGL6nU/ffWZ
	v/oOn08JeBjH4S+b93MWjU/Q/YzUKJrtBK27zmreplwYAouLMPZNZ1T8UKPwmIVCLEI0NB
	j3wbXumSknJM3zokp9iDvvkt/7eWK5E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-VpdpYk3KMV-H449pwJ6bOw-1; Wed, 03 Apr 2024 09:51:49 -0400
X-MC-Unique: VpdpYk3KMV-H449pwJ6bOw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB85B8828C2;
	Wed,  3 Apr 2024 13:51:48 +0000 (UTC)
Received: from localhost (unknown [10.39.194.118])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F351BC04122;
	Wed,  3 Apr 2024 13:51:47 +0000 (UTC)
Date: Wed, 3 Apr 2024 09:51:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	David Teigland <teigland@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Joe Thornber <ejt@redhat.com>
Subject: Re: [RFC 3/9] selftests: block_seek_hole: add loop block driver tests
Message-ID: <20240403135142.GC2524049@fedora>
References: <20240328203910.2370087-1-stefanha@redhat.com>
 <20240328203910.2370087-4-stefanha@redhat.com>
 <6mssvnoq4bpaf53kkla45np5lijptyh4c2orayqx4mqacj572u@6s4y6bhdtcpm>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x2om3oEq6ukG/tIJ"
Content-Disposition: inline
In-Reply-To: <6mssvnoq4bpaf53kkla45np5lijptyh4c2orayqx4mqacj572u@6s4y6bhdtcpm>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8


--x2om3oEq6ukG/tIJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 07:38:17AM -0500, Eric Blake wrote:
> On Thu, Mar 28, 2024 at 04:39:04PM -0400, Stefan Hajnoczi wrote:
> > Run the tests with:
> >=20
> >   $ make TARGETS=3Dblock_seek_hole -C tools/selftests run_tests
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  tools/testing/selftests/Makefile              |   1 +
> >  .../selftests/block_seek_hole/Makefile        |  17 +++
> >  .../testing/selftests/block_seek_hole/config  |   1 +
> >  .../selftests/block_seek_hole/map_holes.py    |  37 +++++++
> >  .../testing/selftests/block_seek_hole/test.py | 103 ++++++++++++++++++
> >  5 files changed, 159 insertions(+)
> >  create mode 100644 tools/testing/selftests/block_seek_hole/Makefile
> >  create mode 100644 tools/testing/selftests/block_seek_hole/config
> >  create mode 100755 tools/testing/selftests/block_seek_hole/map_holes.py
> >  create mode 100755 tools/testing/selftests/block_seek_hole/test.py
> >=20
>=20
> > +
> > +def map_holes(fd):
> > +    end =3D os.lseek(fd, 0, os.SEEK_END)
> > +    offset =3D 0
> > +
> > +    print('TYPE START END SIZE')
> > +
> > +    while offset < end:
> > +        contents =3D 'DATA'
> > +        new_offset =3D os.lseek(fd, offset, os.SEEK_HOLE)
> > +        if new_offset =3D=3D offset:
> > +            contents =3D 'HOLE'
> > +            try:
> > +              new_offset =3D os.lseek(fd, offset, os.SEEK_DATA)
> > +            except OSError as err:
> > +                if err.errno =3D=3D errno.ENXIO:
> > +                    new_offset =3D end
> > +                else:
> > +                    raise err
> > +            assert new_offset !=3D offset
> > +        print(f'{contents} {offset} {new_offset} {new_offset - offset}=
')
> > +        offset =3D new_offset
>=20
> Over the years, I've seen various SEEK_HOLE implementation bugs where
> things work great on the initial boundary, but fail when requested on
> an offset not aligned to the start of the extent boundary.  It would
> probably be worth enhancing the test to prove that:
>=20
> if lseek(fd, offset, SEEK_HOLE) =3D=3D offset:
>   new_offset =3D lseek(fd, offset, SEEK_DATA)
>   assert new_offset > offset
>   assert lseek(fd, new_offset - 1, SEEK_HOLE) =3D=3D new_offset - 1
> else:
>   assert lseek(fd, offset, SEEK_DATA) =3D=3D offset
>   new_offset =3D lseek(fd, offset, SEEK_HOLE)
>   assert new_offset > offset
>   assert lseek(fd, new_offset - 1, SEEK_DATA) =3D=3D new_offset - 1
>=20
> Among other things, this would prove that even though block devices
> generally operate on a minimum granularity of a sector, lseek() still
> gives byte-accurate results for a random offset that falls in the
> middle of a sector, and doesn't accidentally round down reporting an
> offset less than the value passed in to the request.

Sure. I'll add a test for that.

Stefan

--x2om3oEq6ukG/tIJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmYNXu4ACgkQnKSrs4Gr
c8jiRAgAlRZwKBwtx8HTSPWTyPF1aDumwwjfPHI+L3n47d0TYnJk8hmb5wCBUAnr
FLm8+SC46srUixEQEdwLL9DdVEu3QHMKHJtQVWU3ShF+izCE3rlGT9BhNl+ZyBDY
xWrnBy8kgmdxqvjwyca49jOTLmnS/LaM6uBybK3hk9zQZgcI36phl+OZCwyct7dj
3L3UuOAYCwnqxDdNvm9mVhCeAAnf5F8WECCR8ZUfw7ejPASc9Gzw90tyDn7RrQKU
Gubm9DS0I0vTe5XWwnDY0PtUxE/Y+waT1YIkwE9FrE//uswssKJ01cZT0FW8HZhD
1Z4wdIuFUendZtJhVZpMcXp+cUM9lg==
=chJ4
-----END PGP SIGNATURE-----

--x2om3oEq6ukG/tIJ--


