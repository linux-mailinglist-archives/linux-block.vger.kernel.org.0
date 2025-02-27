Return-Path: <linux-block+bounces-17797-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF420A47788
	for <lists+linux-block@lfdr.de>; Thu, 27 Feb 2025 09:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71E43AFA17
	for <lists+linux-block@lfdr.de>; Thu, 27 Feb 2025 08:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1FE217F5D;
	Thu, 27 Feb 2025 08:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJzdRIqO"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE642236FF
	for <linux-block@vger.kernel.org>; Thu, 27 Feb 2025 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644278; cv=none; b=n0qL4XjWruGyAdvaqQYKsuwSYbjJGQGGpjlQyc3QmfBPgLYBWlXWEqjrNG8Ydzzi0II+AA0isn1BNVd+lZf/wf1Qn5QMazLbpgOm4s/wXjk5ziLhj96R2HntO/TaSoM5sSQaaBbTn4tDScQu1yXUbjpB7LFhvpswZ5nuW+7sbso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644278; c=relaxed/simple;
	bh=ppCVTAZkwq6pSeEeOz2wefs/aJ7u0wo/CB8TjQe33uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUofZ6/wpVWy2iSsqF/+2/PSfGRN3QvAsVqLBhhupPUig1cj4LOc59E0g9BTF6xS3XsindbvmUwGdF4lDP4kxw8b/K2jdyd0h7KgCfPerIhV3m90STO/ARqrC2+g+6ZO9g99BzYPrLQUBjapB3nuzsrKYW6C29wRkH86Bx3tKwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DJzdRIqO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740644275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bGFf9XhJAmxvcbiIpcAO/HwjvjYRDjmbkov0Jee0OCk=;
	b=DJzdRIqOl+aFHnj/E1Wa2lwimirXUbDUR82scJC6Ol4trYcMbBJBdPSSyw3a2eBLYHR2R1
	WK/zs2rRqZwb8BGgHUHn/ZVYQkXbEuIWwzFtoUIHMb6MWNVWE/hqB8FPz+FNjAYNUXgx4t
	iM6gAdqITeaMaHQmRA//6AhdlXxm/Hw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-tptHJse-MCO6uoMVx9ming-1; Thu,
 27 Feb 2025 03:17:53 -0500
X-MC-Unique: tptHJse-MCO6uoMVx9ming-1
X-Mimecast-MFC-AGG-ID: tptHJse-MCO6uoMVx9ming_1740644271
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 522021800874;
	Thu, 27 Feb 2025 08:17:51 +0000 (UTC)
Received: from localhost (unknown [10.2.16.46])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F67219560AE;
	Thu, 27 Feb 2025 08:17:49 +0000 (UTC)
Date: Thu, 27 Feb 2025 16:17:47 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, mst@redhat.com
Cc: israelr@nvidia.com, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org, oren@nvidia.com, nitzanc@nvidia.com,
	dbenbasat@nvidia.com, smalin@nvidia.com, larora@nvidia.com,
	izach@nvidia.com, aaptel@nvidia.com, parav@nvidia.com,
	kvm@vger.kernel.org
Subject: Re: [PATCH v1 0/2] virtio: Add length checks for device writable
 portions
Message-ID: <20250227081747.GE85709@fedora>
References: <20250224233106.8519-1-mgurtovoy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f+x1X24VaVRvn0jX"
Content-Disposition: inline
In-Reply-To: <20250224233106.8519-1-mgurtovoy@nvidia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


--f+x1X24VaVRvn0jX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 01:31:04AM +0200, Max Gurtovoy wrote:
> Hi,
>=20
> This patch series introduces safety checks in virtio-blk and virtio-fs
> drivers to ensure proper handling of device-writable buffer lengths as
> specified by the virtio specification.
>=20
> The virtio specification states:
> "The driver MUST NOT make assumptions about data in device-writable
> buffers beyond the first len bytes, and SHOULD ignore this data."
>=20
> To align with this requirement, we introduce checks in both drivers to
> verify that the length of data written by the device is at least as
> large as the expected/needed payload.
>=20
> If this condition is not met, we set an I/O error status to prevent
> processing of potentially invalid or incomplete data.
>=20
> These changes improve the robustness of the drivers and ensure better
> compliance with the virtio specification.
>=20
> Max Gurtovoy (2):
>   virtio_blk: add length check for device writable portion
>   virtio_fs: add length check for device writable portion
>=20
>  drivers/block/virtio_blk.c | 20 ++++++++++++++++++++
>  fs/fuse/virtio_fs.c        |  9 +++++++++
>  2 files changed, 29 insertions(+)
>=20
> --=20
> 2.18.1
>=20

There are 3 cases:
1. The device reports len correctly.
2. The device reports len incorrectly, but the in buffers contain valid
   data.
3. The device reports len incorrectly and the in buffers contain invalid
   data.

Case 1 does not change behavior.

Case 3 never worked in the first place. This patch might produce an
error now where garbage was returned in the past.

It's case 2 that I'm worried about: users won't be happy if the driver
stops working with a device that previously worked.

Should we really risk breakage for little benefit?

I remember there were cases of invalid len values reported by devices in
the past. Michael might have thoughts about this.

Stefan

--f+x1X24VaVRvn0jX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfAH6oACgkQnKSrs4Gr
c8hxfwf/VmLq+08Uen59ob/dkIRuawyd1+lItLEY21Wqs8YWrJJgR8PPhWY9iDv4
0D/cw0UbhhYQ/kGYO2YH0ZE5LY5d2eqVn4oMp9f9az55RJjXj+ceGK8FvcUIeZrS
nAY8duXrrspauEQ9z06BVjUKDs631GLLaXnanlII2HfjQw44lFIuO9MAMBg8a61A
FpUhVsa6Jtq74OCcJsr3+XGsYSJCRuEW+CPMgy4aYSE+eWXMV+JlfKUsPuDrzjN5
9VPjyC08Oa1JPrBZa9qKGiXGX7zBe8xy6I5rlXTvu70d3tqFqDptjXbqffU8l4ON
IPmE5dmLfRq3ghOwLEuynKuVymc1lw==
=CMlU
-----END PGP SIGNATURE-----

--f+x1X24VaVRvn0jX--


