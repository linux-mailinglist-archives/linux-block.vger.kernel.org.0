Return-Path: <linux-block+bounces-5395-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D85AA890E4E
	for <lists+linux-block@lfdr.de>; Fri, 29 Mar 2024 00:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83511282AFB
	for <lists+linux-block@lfdr.de>; Thu, 28 Mar 2024 23:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28AF3BB25;
	Thu, 28 Mar 2024 23:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZ+KVxDB"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD4F1CAA4
	for <linux-block@vger.kernel.org>; Thu, 28 Mar 2024 23:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711667403; cv=none; b=J95sfQw+2GkO/KriNPeV2Ge9vnBfi6MyrSFxY9nkY7NsgeG6hMoy6A8yMN025639PA5HuxmBYl7bN7oqjkEDUNbg2muXiTK+3J6208/zq/w6jv5ZPI4Jmmd9e5LvNJVw9K8fIFuu0memWzruUn0q73fzpjYLs47TfVyl0B2bwwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711667403; c=relaxed/simple;
	bh=kvmTcmHWQT5BDi0XbGATB1yNB1cSxJT9/zwntUh/tFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQHPxYuAORHqlDa2VwneohdtNnJCV8ZsUXQ2pUINI/S28OW0SIKWMkJZ9bCe1nrBSLqSaR0DDtbRPuvMnNeNCPrSutcjT4fN1FZRut/hLUo2uH6BlxENJjgtZxwPknIMPun7nkJN9QZqK9d7/TEvo+YRQ3mJuwRn7OtLzOYov+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SZ+KVxDB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711667401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rndfg4XfB22ONXO19F0as1oglujXnoi27yaTdnHvC0g=;
	b=SZ+KVxDB6w9ewMOk6gTffM/blgYTelyM5en7aeWHcJUFBVJVw099nunbb+eMyjBjtxjoQh
	QcZKv0HJ9Xqye1FeFfVdDQhCyWmN2QwvsoobuQ6T31oR6+GhUxB/EfOnqrFoZiW4WSlp1f
	5aFwjsGkn8/dW6f2LXpuTaZq3Nxbfs8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-aWGgeugXPACFN4sPZ5mRhA-1; Thu,
 28 Mar 2024 19:09:59 -0400
X-MC-Unique: aWGgeugXPACFN4sPZ5mRhA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36AB71C05AB5;
	Thu, 28 Mar 2024 23:09:59 +0000 (UTC)
Received: from localhost (unknown [10.39.194.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7785B2166B31;
	Thu, 28 Mar 2024 23:09:58 +0000 (UTC)
Date: Thu, 28 Mar 2024 19:09:52 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	David Teigland <teigland@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Joe Thornber <ejt@redhat.com>
Subject: Re: [RFC 0/9] block: add llseek(SEEK_HOLE/SEEK_DATA) support
Message-ID: <20240328230952.GB2373362@fedora>
References: <20240328203910.2370087-1-stefanha@redhat.com>
 <e2lcp3n5gpf7zmlpyn4nj7wsr36sffn23z5bmzlsghu6oapi5u@sdkcbpimi5is>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L5fVNxigY5xSFlqK"
Content-Disposition: inline
In-Reply-To: <e2lcp3n5gpf7zmlpyn4nj7wsr36sffn23z5bmzlsghu6oapi5u@sdkcbpimi5is>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6


--L5fVNxigY5xSFlqK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 05:16:54PM -0500, Eric Blake wrote:
> On Thu, Mar 28, 2024 at 04:39:01PM -0400, Stefan Hajnoczi wrote:
> > This can speed up the process by reducing the amount of data read and it
> > preserves sparseness when writing to the output file.
> >=20
> > This patch series is an initial attempt at implementing
> > llseek(SEEK_HOLE/SEEK_DATA) for block devices. I'm looking for feedback=
 on this
> > approach and suggestions for resolving the open issues.
>=20
> One of your open issues was whether adjusting the offset of the block
> device itself should also adjust the file offset of the underlying
> file (at least in the case of loopback and dm-linear).  What would the

Only the loop block driver has this issue. The dm-linear driver uses
blkdev_seek_hole_data(), which does not update the file offset because
it operates on a struct block_device instead of a struct file.

>=20
> >=20
> > In the block device world there are similar concepts to holes:
> > - SCSI has Logical Block Provisioning where the "mapped" state would be
> >   considered data and other states would be considered holes.
>=20
> BIG caveat here: the SCSI spec does not necessarily guarantee that
> unmapped regions read as all zeroes; compare the difference between
> FALLOC_FL_ZERO_RANGE and FALLOC_FL_PUNCH_HOLE.  While lseek(SEEK_HOLE)
> on a regular file guarantees that future read() in that hole will see
> NUL bytes, I'm not sure whether we want to make that guarantee for
> block devices.  This may be yet another case where we might want to
> add new SEEK_* constants to the *seek() family of functions that lets
> the caller indicate whether they want offsets that are guaranteed to
> read as zero, vs. merely offsets that are not allocated but may or may
> not read as zero.  Skipping unallocated portions, even when you don't
> know if the contents reliably read as zero, is still a useful goal in
> some userspace programs.

SCSI initiators can check the Logical Block Provisioning Read Zeroes
(LBPRZ) field to determine whether or not zeroes are guaranteed. The sd
driver would only rely on the device when LPBRZ indicates that zeroes
will be read. Otherwise the driver would report that the device is
filled with data.

>=20
> > - NBD has NBD_CMD_BLOCK_STATUS for querying whether blocks are present.
>=20
> However, utilizing it in nbd.ko would require teaching the kernel to
> handle structured or extended headers (right now, that is an extension
> only supported in user-space implementations of the NBD protocol).  I
> can see why you did not tackle that in this RFC series, even though
> you mention it in the cover letter.

Yes, I'm mostly interested in dm-thin. The loop block driver and
dm-linear are useful for testing so I modified them. I didn't try SCSI
or NBD.

Thanks,
Stefan

--L5fVNxigY5xSFlqK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmYF+MAACgkQnKSrs4Gr
c8igigf/UDJaxtkdbmVL4Uer+bQYsOyVoZO0KIJ2d4vKGyQMZyoLt/teOilDZbji
TnmcqrRqRbpIIiaIajLleTUUEwFArHq0LcENf5ONMKhShi1xVvX9OG2/v7iWlmzg
RHI9mPKgu2S3/C3Vb5wPTjxAQjqGKzudy8JoiZ60dTYbUVoAlgkSp5wf3EPeVURm
h63dZy2Gy4jgHWrnpYwcjXEa5T4i1xhTDwXfR7QFCtlOFYqpyfqrZBqj8CY+LNQ0
8nSabkb+YiU+mOWXSr6qWr7BlPqn92bGazdSQRCEHsMKpxwUT8k5xz+zILF/KnrC
f9wF1Fgl6oASE8MLEk9uAw3kzRYaOA==
=PLlk
-----END PGP SIGNATURE-----

--L5fVNxigY5xSFlqK--


