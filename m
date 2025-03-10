Return-Path: <linux-block+bounces-18178-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44755A59DB1
	for <lists+linux-block@lfdr.de>; Mon, 10 Mar 2025 18:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148283A7EE1
	for <lists+linux-block@lfdr.de>; Mon, 10 Mar 2025 17:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D0D233159;
	Mon, 10 Mar 2025 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b="COdf3x8q"
X-Original-To: linux-block@vger.kernel.org
Received: from mail77.out.titan.email (mail77.out.titan.email [3.216.99.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AB1230BC8
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.216.99.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627407; cv=none; b=cPiyGF+FyGDkqX1YOskcbMiWC4LcHyT5N6bmodb9mkKvammZAVF8C0aI0L9zYrUIISgsRCId0KK6zssQOuGIsQsl7XnOkXZwXuwsCWoSdv6OyI/fHcsLf2wnBl75rrA1CRu845Ec0mfLf7dJxJboMZWVPVXGnii8uFxo2k0ANn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627407; c=relaxed/simple;
	bh=o3jo8Yp6GBl1EzB187l+mO+RUd+WDfgcPP/VmFEaNZQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dvDfkx/q9YI1oaTR7bdMOjv2GMvfQqbE65NTN9nHN9gmoofRXnJmr+TEFJavtAQIZaZMlKR92VSfwvzqBC7pqlDEIstYp+/DFaY31VYcvGIBA8hOwZO5AvY/jwYsckDemIlctHPLkB6Uxye2zyugeckUxaxfeSwoAw/7tzdGNwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li; spf=pass smtp.mailfrom=coly.li; dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b=COdf3x8q; arc=none smtp.client-ip=3.216.99.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coly.li
Received: from smtp-out.flockmail.com (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id CC1D61401F6;
	Mon, 10 Mar 2025 13:45:20 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=o3jo8Yp6GBl1EzB187l+mO+RUd+WDfgcPP/VmFEaNZQ=;
	c=relaxed/relaxed; d=t12smtp-sign004.email;
	h=references:to:message-id:cc:in-reply-to:from:subject:date:mime-version:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1741614320; v=1;
	b=COdf3x8q/G6sh/SlMX1MIuCocHsUU2QTZbEq5tislkAxOL2SV7FE1mWOu5xNQ2R2HvxkABQW
	Ed8VN2LD15VFAAjzNyM9Gbh4DZfFP+o8oy3V8h0PLmR6+bQSGRVEPvnOm7bFg2tyIKJopQHBox1
	HpBIDqRIHyaOPxxRVDc5/vHw=
Received: from smtpclient.apple (v133-18-178-219.vir.kagoya.net [133.18.178.219])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id 28BED14032A;
	Mon, 10 Mar 2025 13:45:17 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH] badblocks: Fix a nonsense WARN_ON() which checks whether
 a u64 variable < 0
Feedback-ID: :i@coly.li:coly.li:flockmailId
From: Coly Li <i@coly.li>
In-Reply-To: <de3a5313-b0b5-432f-ace2-f6859eeb4436@kernel.dk>
Date: Mon, 10 Mar 2025 21:44:59 +0800
Cc: linux-block@vger.kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DB1BA32F-C77C-4606-A886-B519ADC3FCB5@coly.li>
References: <20250309160556.42854-1-colyli@kernel.org>
 <18D3673D-575E-4002-B5A8-FEE56A732EDC@coly.li>
 <de3a5313-b0b5-432f-ace2-f6859eeb4436@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1741614320748111132.32605.5504476676342156083@prod-use1-smtp-out1003.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=IeV9WXqa c=1 sm=1 tr=0 ts=67ceecf0
	a=6yy/x1GoN29p2+/2k52XZQ==:117 a=6yy/x1GoN29p2+/2k52XZQ==:17
	a=IkcTkHD0fZMA:10 a=CEWIc4RMnpUA:10 a=i1v2BhhCwKSZKKg_S70A:9
	a=QEXdDO2ut3YA:10
X-Virus-Scanned: ClamAV using ClamSMTP



> 2025=E5=B9=B43=E6=9C=8810=E6=97=A5 21:42=EF=BC=8CJens Axboe =
<axboe@kernel.dk> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 3/9/25 10:12 AM, Coly Li wrote:
>> Hi Jens,
>>=20
>> Could you please take a look at it and pick this patch into the =
for-6.15/block branch? The patch is generated based on the =
for-6.15/block branch.
>=20
> Just a heads-up - you don't need to send these emails outside of
> just sending the patch, I do get the patches. If I didn't, then that'd
> be a problem. If you feel patches need extra context, then just do a
> cover letter for them.

So if you are the receiver of the patch email, then I don=E2=80=99t need =
to worry that you will treat it as a normal patch for review. Can I take =
this as a rule?

Thanks.

Coly Li=

