Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6FB8B66B
	for <lists+linux-block@lfdr.de>; Tue, 13 Aug 2019 13:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfHMLOS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 13 Aug 2019 07:14:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53201 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfHMLOS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Aug 2019 07:14:18 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9B7B380737; Tue, 13 Aug 2019 13:14:03 +0200 (CEST)
Date:   Tue, 13 Aug 2019 13:14:15 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, pavel@denx.de
Subject: Re: [PATCH BUGFIX 0/2] block, bfq: fix user after free
Message-ID: <20190813111415.GE3635@amd>
References: <20190807141754.3567-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="o0ZfoUVt4BxPQnbU"
Content-Disposition: inline
In-Reply-To: <20190807141754.3567-1-paolo.valente@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--o0ZfoUVt4BxPQnbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> this series contains a pair of fixes for the UAF reported in
> [1]. These patches are the result of the testing described in this
> Chrome OS issue [2] since Comment 57.

This seems to have solved crashes with chromium on x220 from
"v5.3-rc2: crashes and scrolling in web browser now has audio
feedback" thread.

Best regards,
							Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--o0ZfoUVt4BxPQnbU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1Sm4cACgkQMOfwapXb+vICdwCcCB60eReiiKRUm/N94d9zpFLx
/L4AniJT1qX6xQEcdc35HpctQ+fKFgd3
=acen
-----END PGP SIGNATURE-----

--o0ZfoUVt4BxPQnbU--
