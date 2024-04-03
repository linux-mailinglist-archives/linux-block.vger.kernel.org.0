Return-Path: <linux-block+bounces-5701-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C3B897198
	for <lists+linux-block@lfdr.de>; Wed,  3 Apr 2024 15:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F972289ED6
	for <lists+linux-block@lfdr.de>; Wed,  3 Apr 2024 13:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC541494A1;
	Wed,  3 Apr 2024 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHO6Q++1"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9E31487F3
	for <linux-block@vger.kernel.org>; Wed,  3 Apr 2024 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152261; cv=none; b=aQxJztLQvB4nwBlVkSiRr+S3KYL896iVaU1LC9Wdv/+TaHZKg9ghw6Bq+nIHC33djz0D9WgC+mfHewZFJTkSl8vYoNx0nJMigQOhJc2cqdoSUmZnJARz8lt01jFdPxX+a8IJM9iLCKIMpgLycPXZNWndV6RekPYY68QEF2y/09Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152261; c=relaxed/simple;
	bh=0w2WrMPgBEF7P+KBFC1PiBOaaNAE12UV7ArGCbs4Fpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfF6bCOyWt/lOlkglCBzqZDtsEQkPOehlqXc9tBqv+TQ8BhLKnjSX5MKMFolHKcJTmiK+aSiFotmNowi++GFWObb94sFjyLwWa8zsBhdBUNSsDLiUbNbcx1pJtVag4Hz29Szrj8QesE+b3rb8NmB3tOduTa4cOl2JyZ9uVhNt14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VHO6Q++1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712152258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fbnyxTPoivxdulGiRzybrkcGRwKo49Gh1MYbg192HZY=;
	b=VHO6Q++1e8CJty+Th9buuW+T68Cpjs8J39iShsNp8T82/ippZwilAaxBqLf0K8HS/tvYim
	mlrtdra6E9zwkckF2+nCeAi9kFbzLE3PgqI4vGEu+i8Huq2PYZClALiGeleG8GSUFsoypE
	1MRY2m4osiJZks09Q/OIR61dAvVmduY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-h1MQqg0sPVK2IoQWIgyF3g-1; Wed, 03 Apr 2024 09:50:55 -0400
X-MC-Unique: h1MQqg0sPVK2IoQWIgyF3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A10DA101A535;
	Wed,  3 Apr 2024 13:50:54 +0000 (UTC)
Received: from localhost (unknown [10.39.194.118])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9649A40735E1;
	Wed,  3 Apr 2024 13:50:53 +0000 (UTC)
Date: Wed, 3 Apr 2024 09:50:32 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	David Teigland <teigland@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Joe Thornber <ejt@redhat.com>
Subject: Re: [RFC 3/9] selftests: block_seek_hole: add loop block driver tests
Message-ID: <20240403135032.GB2524049@fedora>
References: <20240328203910.2370087-1-stefanha@redhat.com>
 <20240328203910.2370087-4-stefanha@redhat.com>
 <xh2nqmndk4rfnvghhmv6xlueleb4mdfa6v5vvamnxfyxb3eomb@yz5u2nldqewf>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wef+JxaAyeGLmzI+"
Content-Disposition: inline
In-Reply-To: <xh2nqmndk4rfnvghhmv6xlueleb4mdfa6v5vvamnxfyxb3eomb@yz5u2nldqewf>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2


--wef+JxaAyeGLmzI+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 07:11:30PM -0500, Eric Blake wrote:
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
> > +++ b/tools/testing/selftests/block_seek_hole/test.py
>=20
> > +
> > +# Different data layouts to test
> > +
> > +def data_at_beginning_and_end(f):
> > +    f.write(b'A' * 4 * KB)
> > +    f.seek(256 * MB)
> > +
> > +    f.write(b'B' * 64 * KB)
> > +
> > +    f.seek(1024 * MB - KB)
> > +    f.write(b'C' * KB)
> > +
> > +def holes_at_beginning_and_end(f):
> > +    f.seek(128 * MB)
> > +    f.write(b'A' * 4 * KB)
> > +
> > +    f.seek(512 * MB)
> > +    f.write(b'B' * 64 * KB)
> > +
> > +    f.truncate(1024 * MB)
> > +
> > +def no_holes(f):
> > +    # Just 1 MB so test file generation is quick
> > +    mb =3D b'A' * MB
> > +    f.write(mb)
> > +
> > +def empty_file(f):
> > +    f.truncate(1024 * MB)
>=20
> Is it also worth attempting to test a (necessarily sparse!) file
> larger than 2GiB to prove that we are 64-bit clean, even on a 32-bit
> system where lseek is different than lseek64?  (I honestly have no
> idea if python always uses 64-bit seek even on 32-bit systems,
> although I would be surprised if it were not)

Yes, it wouldn't hurt to add a test case for that. I'll do that.

Stefan

--wef+JxaAyeGLmzI+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmYNXqcACgkQnKSrs4Gr
c8haRQf6AwEcxzTy4yYaPyNMUFI4yW1gzKFlXN451KGhjcejq6HevACTbBTLUy4o
uIiH5kiBM2XSl5k5m8E4oZeB5x6sWdHR+3OpwP9KoPvJfZinyoJbQM4CqIMQsWMM
RJ5pIM9XRqG6BkeNT5ni8zs7VgF8aIxXkzhuSLf5H3WKKpqcXNfmMTuHUOWyOhtn
AkfAYK6Mvzwucyv3HonafDbHokCB09BY5SKOcx4U2dz+7PKmiGxkjdanEOsAPHko
SUAF2pM1Koi3X+9xfs63eJAfwVGqMZB9W36nAMEybCnNedVPoJUiT6JUdfjQSDa+
hbxtZbvKkwZvaSxNRS81RwSszsK4vQ==
=qDQS
-----END PGP SIGNATURE-----

--wef+JxaAyeGLmzI+--


