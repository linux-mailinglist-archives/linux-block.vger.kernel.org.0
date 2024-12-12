Return-Path: <linux-block+bounces-15290-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 070ED9EF83B
	for <lists+linux-block@lfdr.de>; Thu, 12 Dec 2024 18:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F981899DD1
	for <lists+linux-block@lfdr.de>; Thu, 12 Dec 2024 17:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C00216E2D;
	Thu, 12 Dec 2024 17:29:54 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5763F222D67
	for <linux-block@vger.kernel.org>; Thu, 12 Dec 2024 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024594; cv=none; b=sC3eRZabfL9jtPLZhxWqQoHT8jCxutWpOQivg9RpxtYyn90v26VqigiDgkF5GSxG3XjvD0Tv/rxn2zZ5L8WPjLD2spB9ywCwxvqInwwAeyKdPUsuKMbpc9Tj12RWrb4e2Pq286alHSKmjcbEuIYUM9dCBfBc/g1+XnuX6bcTvaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024594; c=relaxed/simple;
	bh=ayFvDAuq2+Jwh2xZPoLyKRjBI+kW/hEHltWiLIYYHCs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=B7UpV5lYdntcynTvxWjSM9xmkoG37NyuBCIEBmyCGGc2ePus6pF0Nbj9HKXr8/S8l6H+8e6yAEPJeq15ykSG0KbJFb/qL7Pd8Z6QwANeZLe6IQ3W79SpgPGNcUdKPo1El+MSMqY1pUqnOUhZjwTwxDyhMn/Wpy5l+vlRp2er5EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-37-nu4osZHLMQSYbwV6FMbTtw-1; Thu, 12 Dec 2024 17:29:41 +0000
X-MC-Unique: nu4osZHLMQSYbwV6FMbTtw-1
X-Mimecast-MFC-AGG-ID: nu4osZHLMQSYbwV6FMbTtw
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 12 Dec
 2024 17:28:44 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 12 Dec 2024 17:28:44 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Tejun Heo' <tj@kernel.org>, Nathan Chancellor <nathan@kernel.org>
CC: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, Linux Kernel Functional Testing <lkft@linaro.org>,
	kernel test robot <lkp@intel.com>
Subject: RE: [PATCH] blk-iocost: Avoid using clamp() on inuse in
 __propagate_weights()
Thread-Topic: [PATCH] blk-iocost: Avoid using clamp() on inuse in
 __propagate_weights()
Thread-Index: AQHbTLneKltIssSpBEabKMv+lJlW17Li3L3A
Date: Thu, 12 Dec 2024 17:28:44 +0000
Message-ID: <5231409257664f8097c82f79869fb52b@AcuMS.aculab.com>
References: <20241212-blk-iocost-fix-clamp-error-v1-1-b925491bc7d3@kernel.org>
 <Z1sbG2zh8xmb-lxu@slm.duckdns.org>
In-Reply-To: <Z1sbG2zh8xmb-lxu@slm.duckdns.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qFKtDrmjrajSYHSVW_Eb1x6QuHmJpqC_uYnPp7W9RLs_1734024580
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Tejun Heo <tj@kernel.org>
> Sent: 12 December 2024 17:19
>=20
> On Thu, Dec 12, 2024 at 10:13:29AM -0700, Nathan Chancellor wrote:
> > After a recent change to clamp() and its variants [1] that increases th=
e
> > coverage of the check that high is greater than low because it can be
> > done through inlining, certain build configurations (such as s390
> > defconfig) fail to build with clang with:
> >
...
> > __propagate_weights() is called with an active value of zero in
> > ioc_check_iocgs(), which results in the high value being less than the
> > low value, which is undefined because the value returned depends on the
> > order of the comparisons.
> >
> > The purpose of this expression is to ensure inuse is not more than
> > active and at least 1. This could be written more simply with a ternary
> > expression that uses min(inuse, active) as the condition so that the
> > value of that condition can be used if it is not zero and one if it is.
> > Do this conversion to resolve the error and add a comment to deter
> > people from turning this back into clamp().
> >
> > Link: https://lore.kernel.org/r/34d53778977747f19cce2abb287bb3e6@AcuMS.=
aculab.com/ [1]
> > Suggested-by: David Laight <david.laight@aculab.com>
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Closes: https://lore.kernel.org/llvm/CA+G9fYsD7mw13wredcZn0L-KBA3yeoVST=
uxnss-
> AEWMN3ha0cA@mail.gmail.com/
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202412120322.3GfVe3vF-lkp=
@intel.com/
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>=20
> Acked-by: Tejun Heo <tj@kernel.org>
>=20
> This likely deserves:
>=20
> Fixes: 7caa47151ab2 ("blkcg: implement blk-iocost")
> Cc: stable@vger.kernel.org # v5.4+

Especially since the old defn was:

#define __clamp(val, lo, hi)=09\
=09((val) >=3D (hi) ? (hi) : ((val) <=3D (lo) ? (lo) : (val)))

so:
-=09=09inuse =3D clamp_t(u32, inuse, 1, active);

is zero if active is zero.

=09David

>=20
> Thanks.
>=20
> --
> tejun

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


