Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB9A5D09F8
	for <lists+linux-block@lfdr.de>; Wed,  9 Oct 2019 10:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbfJIIeI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 9 Oct 2019 04:34:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36638 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfJIIeI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Oct 2019 04:34:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5CBF2307D989;
        Wed,  9 Oct 2019 08:34:08 +0000 (UTC)
Received: from localhost (unknown [10.36.118.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3AC660BEC;
        Wed,  9 Oct 2019 08:34:07 +0000 (UTC)
Date:   Wed, 9 Oct 2019 09:34:06 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>
Subject: liburing 0.2 release?
Message-ID: <20191009083406.GA4327@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 09 Oct 2019 08:34:08 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jens,
I would like to add a liburing package to Fedora.  The liburing 0.1
release was in January and there have been many changes since then.  Is
now a good time for a 0.2 release?

Thanks,
Stefan

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2dm3sACgkQnKSrs4Gr
c8ibowf/bOwwadfbAAaYuvT4AAv+sdx+0+wro+e36lGoOn5bzE5B7gx79M559yIc
SfUmF5usc1INHR193oVxfrmwInzbCSHaN1ICHDKTT7hX7/RUcWa1zSuxX08OWM8y
ey0hjUwA6JBHZ7Rch20uUFNgLxhej7+51EKGfUUaUi2hKB3+67+0PDdU7Fx6t2Nr
PE3DSa64/N9Fepi+j58YHKb3SVfOi1RQoCNOmnBm7d6S7nPx44IUzbXY/RNyr0t/
WWhpYQ0kr8J9/5bxi/bHWdHSdvz9UbdOfH38/7OMFhorQkHri0gUTXoZA139bbb3
1j6NP2EGV2Fme/eCpMrPsOEaeq1QnQ==
=40J5
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
