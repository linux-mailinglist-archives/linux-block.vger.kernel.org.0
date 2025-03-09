Return-Path: <linux-block+bounces-18119-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0ECA58644
	for <lists+linux-block@lfdr.de>; Sun,  9 Mar 2025 18:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE50B16AB9C
	for <lists+linux-block@lfdr.de>; Sun,  9 Mar 2025 17:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD8A1EB5F9;
	Sun,  9 Mar 2025 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b="JAf9AETs"
X-Original-To: linux-block@vger.kernel.org
Received: from mail72.out.titan.email (mail72.out.titan.email [209.209.25.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0002C1DF244
	for <linux-block@vger.kernel.org>; Sun,  9 Mar 2025 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.209.25.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541459; cv=none; b=Lo/6sMeBVHU7A+G3bUubGAzVg4Z1cJodcgkvMLOhc/B5VR8AvwAN3bxSa1XbRmLSg8lNaenZyGjUcdnyAMleiItXxie5vDfWmcrM3ru1m8Omn3CUeUoIYQa/GfrPCFjz/yp5fIyybFoGQDzc7C5tGiJPUdXO2EmNP1z4q/s7gjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541459; c=relaxed/simple;
	bh=nYsezjtEawGbIotwS0oewzdbvfdj0cxmn3BQAbWPMko=;
	h=From:Content-Type:Mime-Version:Subject:Date:References:Cc:To:
	 Message-Id; b=tXQ7p4pBwzqun6ntsq6EfV0WQMimL1XBKuLKvu/4sBq2kmHewowiQB7W4qW/HFxJYfR27xX1PS2kHZFOQ++/eh8QGHJsdi78c+znxQeUvCs79svNxap9CTA8TBxb6fOoMLNL2eqpMWUkUfrZ+ai0cl2Xlfil4w9qETNijbsDIB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li; spf=pass smtp.mailfrom=coly.li; dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b=JAf9AETs; arc=none smtp.client-ip=209.209.25.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coly.li
DKIM-Signature: a=rsa-sha256; bh=cDdiEW5jhUv92NCXLbxub9APdfK5JMV/G6z6IwfEcKU=;
	c=relaxed/relaxed; d=t12smtp-sign004.email;
	h=cc:message-id:subject:mime-version:from:references:to:date:from:to:cc:subject:date:message-id:references:in-reply-to:reply-to;
	q=dns/txt; s=titan1; t=1741536741; v=1;
	b=JAf9AETsPBJ2J5KuRKoF1UFn3swNJnlrrh9j9AMGHOWFA2NIaomXgYUOhttw0aCtd5CYN4Ze
	jn1J6wV18UOt0mv6n7FSHli42/NJhM/gKDTgDfdITehxrP3aOC97HeawEoDe2+XHm+pgGlvRWrE
	hpljsmIM1wTHXmrkCQzCT2Hc=
Received: from smtpclient.apple (v133-18-178-219.vir.kagoya.net [133.18.178.219])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id EA70D1001D6;
	Sun,  9 Mar 2025 16:12:19 +0000 (UTC)
Feedback-ID: :i@coly.li:coly.li:flockmailId
From: Coly Li <i@coly.li>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Fwd: [PATCH] badblocks: Fix a nonsense WARN_ON() which checks whether
 a u64 variable < 0
Date: Mon, 10 Mar 2025 00:12:06 +0800
References: <20250309160556.42854-1-colyli@kernel.org>
Cc: linux-block@vger.kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Message-Id: <18D3673D-575E-4002-B5A8-FEE56A732EDC@coly.li>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1741536741337664736.29396.8333416838371928616@prod-use1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=I9+fRMgg c=1 sm=1 tr=0 ts=67cdbde5
	a=6yy/x1GoN29p2+/2k52XZQ==:117 a=6yy/x1GoN29p2+/2k52XZQ==:17
	a=kj9zAlcOel0A:10 a=CEWIc4RMnpUA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
	a=O8RVhBXIRMEz6hEWSBwA:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22

Hi Jens,

Could you please take a look at it and pick this patch into the =
for-6.15/block branch? The patch is generated based on the =
for-6.15/block branch.

Thanks in advance.

Coly Li


> From: Coly Li <colyli@kernel.org>
>=20
> In _badblocks_check(), there are lines of code like this,
> 1246         sectors -=3D len;
> [snipped]
> 1251         WARN_ON(sectors < 0);
>=20
> The WARN_ON() at line 1257 doesn't make sense because sectors is
> unsigned long long type and never to be <0.
>=20
> Fix it by checking directly checking whether sectors is less than len.
>=20
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Coly Li <colyli@kernel.org>
> ---
> block/badblocks.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/badblocks.c b/block/badblocks.c
> index 673ef068423a..ece64e76fe8f 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -1242,14 +1242,15 @@ static int _badblocks_check(struct badblocks =
*bb, sector_t s, sector_t sectors,
> 	len =3D sectors;
>=20
> update_sectors:
> +	/* This situation should never happen */
> +	WARN_ON(sectors < len);
> +
> 	s +=3D len;
> 	sectors -=3D len;
>=20
> 	if (sectors > 0)
> 		goto re_check;
>=20
> -	WARN_ON(sectors < 0);
> -
> 	if (unacked_badblocks > 0)
> 		rv =3D -1;
> 	else if (acked_badblocks > 0)
> --=20
> 2.47.2
>=20


