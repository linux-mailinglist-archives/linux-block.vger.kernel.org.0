Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DF01BBB13
	for <lists+linux-block@lfdr.de>; Tue, 28 Apr 2020 12:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgD1KUR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Apr 2020 06:20:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:56796 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbgD1KUR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 06:20:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 168ABABF4;
        Tue, 28 Apr 2020 10:20:14 +0000 (UTC)
Date:   Tue, 28 Apr 2020 12:20:09 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, sandeen@sandeen.net, linux-block@vger.kernel.org,
        Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: Re: [PATCH] block: remove the bd_openers checks in
 blk_drop_partitions
Message-ID: <20200428102009.GA8616@blackbook>
References: <20200428085203.1852494-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20200428085203.1852494-1-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

On Tue, Apr 28, 2020 at 10:52:03AM +0200, Christoph Hellwig <hch@lst.de> wrote:
> So instead of trying to come up with a logical check for all openers,
> just remove the check entirely.
I ignored the original suppression patch and I just confirm that
v5.7-rc3 has still broken partscan, whereas v5.7-rc3 + this patch works
as expected.

Michal

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl6oA0sACgkQia1+riC5
qSgqBg/+Oj+n2gW9moN9GyNVzaM731Thk+ZuCk3dDcWPxajHttZXYDfHkpuq52LT
kjsiCxk31xOIDbFIdWY724CHBdXn1ow7lZDazIhgb1JtAPpTe5pEuy0Su6HtNc8d
E7qDrtzdstdsG8dLDJGo2SUhv4iQZGXYBFjyLeU7W6li5rC4z3mbZ62jRB9FgSHc
m540J2xCoMrOUwN9LjFCfsB3YrKgn5QadpRxv/LGch54BC8idJzS9My62ENZzeXS
Fj72xe4Vuj+aouSvvb4TuWEePfL5/I7xR7yYq1fbD54evrIX/bzvEfp8m1D6hlMk
B9lp1A/eJQUinTouDKn0duu+Z1NaiNvVajUlR/Dv3F+XWK03pY5qv/7EyWWh4rLB
8HcRet7nm0c+LLxjk9x2BILrgtipxnjnjfopeUjZ21rs8mX9dtiw9SQzohL/SV2E
8tLld32ftwSMYJbYVtfx32liy8jKsK8TJkzQkz712ZkZeIF7/I6L98Zato6CTcJ2
x0TA/0vRkzMlCErjv7lqYR91lNadWGvOmqCQ9qPVUI2pmM9wySF4/VvB4YfPs9tZ
mNsWYeHzZNL6GGyNE228j4OxuX1IBYY26NUiMVyt49mPAUfjgLL7l2/q1LQzfe8g
COE3JmY2B9/2RwcdKunerkRvA+WGCaFsH/tVgdcXf7jDjd1+rbw=
=NWJ3
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
