Return-Path: <linux-block+bounces-5703-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9716189720A
	for <lists+linux-block@lfdr.de>; Wed,  3 Apr 2024 16:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F2E1C26907
	for <lists+linux-block@lfdr.de>; Wed,  3 Apr 2024 14:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9466D1494C9;
	Wed,  3 Apr 2024 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LeQXs/9G"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A4A148FF5
	for <linux-block@vger.kernel.org>; Wed,  3 Apr 2024 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153531; cv=none; b=ZUcmeL6IKS4F7q9i0shJWDyOKv/43+b8z/KPpVwqntv2eb3gcCyP50HYxmBvh4vHQ33i6ozBtG8SWxWG42GyzhvNRRTIq3g2sCWl3GQrsShq+AvguM4N/WGNOoS5Cu5GQhx6MrkMTp76F/jXPmbiqp+gabGzmN/L+OqGEgYanKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153531; c=relaxed/simple;
	bh=/fDWm8esWJBJi3kmg8ERGpkeInWqby7ydHB7ZhiRVlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koTmgoBkM7ur6Tnm3z/+pYglsEzfLbn8zvhGwr/Js5wBc4lXgb45PU46vFe933itjiGFNQZy43pvTpJPuVgOHnQDK1dQPVfNYlE9c6hvwNNfUKtUJagOB1+ajtgVMDR7WszfrHc5+Bnq+sA8LifpjhZILOTpGVx2m/S3/VmqqLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LeQXs/9G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712153528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i2sn3zuLpcX9s0qaTltEbf78p6kZvbUqe87t+xT18Y4=;
	b=LeQXs/9G4fYGKIDmYsZuCtugWoxsrl7+61m9BfT9Mjd+YakIeZW+E2zALHJEMVJ7TpY7t1
	JLKxkvyXdTyxJibT3s0JSv9jsZGf0za1mTxTArwEEKKpZnLBIUGIUtbIHNP/dkClu54rhp
	2vn4jWzKQH6Vm/iqnZMGdflPtHd2zKE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-rP2PObr8MBeSc1RLyRmLww-1; Wed, 03 Apr 2024 10:11:54 -0400
X-MC-Unique: rP2PObr8MBeSc1RLyRmLww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D962D185A788;
	Wed,  3 Apr 2024 14:11:53 +0000 (UTC)
Received: from localhost (unknown [10.39.194.118])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 22D512024517;
	Wed,  3 Apr 2024 14:11:52 +0000 (UTC)
Date: Wed, 3 Apr 2024 10:11:47 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	David Teigland <teigland@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Joe Thornber <ejt@redhat.com>
Subject: Re: [RFC 4/9] dm: add llseek(SEEK_HOLE/SEEK_DATA) support
Message-ID: <20240403141147.GD2524049@fedora>
References: <20240328203910.2370087-1-stefanha@redhat.com>
 <20240328203910.2370087-5-stefanha@redhat.com>
 <6awt5gq36kzwhuobabtye5vhnexc6cufuamy4frymehuv57ky5@esel3f5naqyu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E298U7bhRnuOmnTB"
Content-Disposition: inline
In-Reply-To: <6awt5gq36kzwhuobabtye5vhnexc6cufuamy4frymehuv57ky5@esel3f5naqyu>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4


--E298U7bhRnuOmnTB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 07:38:20PM -0500, Eric Blake wrote:
> On Thu, Mar 28, 2024 at 04:39:05PM -0400, Stefan Hajnoczi wrote:
> > Delegate SEEK_HOLE/SEEK_DATA to device-mapper targets. The new
> > dm_seek_hole_data() callback allows target types to customize behavior.
> > The default implementation treats the target as all data with no holes.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  include/linux/device-mapper.h |  5 +++
> >  drivers/md/dm.c               | 68 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 73 insertions(+)
> >=20
>=20
> > +/* Default implementation for targets that do not implement the callba=
ck */
> > +static loff_t dm_blk_seek_hole_data_default(loff_t offset, int whence,
> > +		loff_t size)
> > +{
> > +	switch (whence) {
> > +	case SEEK_DATA:
> > +		if ((unsigned long long)offset >=3D size)
> > +			return -ENXIO;
> > +		return offset;
> > +	case SEEK_HOLE:
> > +		if ((unsigned long long)offset >=3D size)
> > +			return -ENXIO;
> > +		return size;
>=20
> These fail with -ENXIO if offset =3D=3D size (matching what we do on file=
s)...
>=20
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static loff_t dm_blk_do_seek_hole_data(struct dm_table *table, loff_t =
offset,
> > +		int whence)
> > +{
> > +	struct dm_target *ti;
> > +	loff_t end;
> > +
> > +	/* Loop when the end of a target is reached */
> > +	do {
> > +		ti =3D dm_table_find_target(table, offset >> SECTOR_SHIFT);
> > +		if (!ti)
> > +			return whence =3D=3D SEEK_DATA ? -ENXIO : offset;
>=20
> ...but this blindly returns offset for SEEK_HOLE, even when offset is
> beyond the end of the dm.  I think you want 'return -ENXIO;'
> unconditionally here.

If the initial offset is beyond the end of the table, then SEEK_HOLE
should return -ENXIO. I agree that the code doesn't handle this case.

However, returning offset here is correct when there is data at the end
with SEEK_HOLE.

I'll update the code to address the out-of-bounds offset case, perhaps
by checking the initial offset before entering the loop.

>=20
> > +
> > +		end =3D (ti->begin + ti->len) << SECTOR_SHIFT;
> > +
> > +		if (ti->type->seek_hole_data)
> > +			offset =3D ti->type->seek_hole_data(ti, offset, whence);
>=20
> Are we guaranteed that ti->type->seek_hole_data will not return a
> value exceeding end?  Or can dm be used to truncate the view of an
> underlying device, and the underlying seek_hold_data can now return an
> answer beyond where dm_table_find_target should look for the next part
> of the dm's view?

ti->type->seek_hole_data() must not return a value larger than
(ti->begin + ti->len) << SECTOR_SHIFT.

>=20
> In which case, should the blkdev_seek_hole_data callback be passed a
> max size parameter everywhere, similar to how fixed_size_llseek does
> things?
>=20
> > +		else
> > +			offset =3D dm_blk_seek_hole_data_default(offset, whence, end);
> > +
> > +		if (whence =3D=3D SEEK_DATA && offset =3D=3D -ENXIO)
> > +			offset =3D end;
>=20
> You have a bug here.  If I have a dm contructed of two underlying targets:
>=20
> |A  |B  |
>=20
> and A is all data, then whence =3D=3D SEEK_HOLE will have offset =3D -ENX=
IO
> at this point, and you fail to check whether B is also data.  That is,
> you have silently treated the rest of the block device as data, which
> is semantically not wrong (as that is always a safe fallback), but not
> optimal.
>=20
> I think the correct logic is s/whence =3D=3D SEEK_DATA &&//.

No, with whence =3D=3D SEEK_HOLE and an initial offset in A, the new offset
will be (A->begin + A->end) << SECTOR_SHIFT. The loop will iterate and
continue seeking into B.

The if statement you commented on ensures that we also continue looping
with whence =3D=3D SEEK_DATA, because that would otherwise prematurely end
with the new offset =3D -ENXIO.

>=20
> > +	} while (offset =3D=3D end);
>=20
> I'm trying to make sure that we can never return the equivalent of
> lseek(dm, 0, SEEK_END).  If you make my above suggested changes, we
> will iterate through the do loop once more at EOF, and
> dm_table_find_target() will then fail to match at which point we do
> get the desired -ENXIO for both SEEK_HOLE and SEEK_DATA.

Wait, lseek() is supposed to return the equivalent of lseek(dm, 0,
SEEK_END) when whence =3D=3D SEEK_HOLE and there is data at the end.

>=20
> > +
> > +	return offset;
> > +}
> > +
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.
> Virtualization:  qemu.org | libguestfs.org
>=20

--E298U7bhRnuOmnTB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmYNY6MACgkQnKSrs4Gr
c8gBswgAsiZbKgKf/rUbBd/QxPkUDKRRu5h1oBb9KBNejG7yN/VQcqp6C8r2WEWW
yCWdhJL87dnNse32Xp/D1cTfaFgtVnzks86igf6ddN29a1rymvQh0SPNh4JfW3dH
K8nAzdxUoisgkWRrY/C97heynyP3Emo5aq2qoiVLSErtnQ7VpBkVvicpiW9aE2SJ
GasNYWTEx7g8qm+DGXU1fyxMBjOER63LseF73nnT2ec8nkd7TO4fyMzeEP5y3mCu
so8Sbz9yTJkWHaaEBTjLi+ryzOJmFOthldB/Syt7m+oFQAFkA1BGaC2Fmrzdlvcw
P2TW46BErnxJv4nH7LRbF4e6D5mfwg==
=W3tR
-----END PGP SIGNATURE-----

--E298U7bhRnuOmnTB--


