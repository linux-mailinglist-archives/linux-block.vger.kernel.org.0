Return-Path: <linux-block+bounces-18460-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D8BA62A60
	for <lists+linux-block@lfdr.de>; Sat, 15 Mar 2025 10:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D9D3BAED3
	for <lists+linux-block@lfdr.de>; Sat, 15 Mar 2025 09:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205BA1F5828;
	Sat, 15 Mar 2025 09:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RjD2trdW"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE37A32;
	Sat, 15 Mar 2025 09:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742031887; cv=none; b=ZJbdqQwVJ6fshR1eyEDfzMtc00tsMZkPHbQSfNjAyt1sge/5fhdy2Pg8V2v/K3v+1hwYIrsLKVjmQsU7jH25Fyx6uJ6f8QPGoUkSbDaAw9D73M9WEHyCi7BoigKB++ddsaAx7xA832aBRubeV2j10hza5JXeAhCJ9SPWQzh7yQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742031887; c=relaxed/simple;
	bh=9o+XY6imgq6zaQDxE/bPz6kfIxurI0uiJIyhQ04e950=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CvAb1ocnodS3rjGfUaAWwftHDDk9N0XVt//Z4u2B1SNVhTWze2HLGWt5zQFLghyM1C7Eev5bNuROhAvY4hwZUGOYXy09+Td3R0NlXaeV2ht4c9F0U601FFLLR89rM2QtH3zDPntOB+LH/8BhO+v+OppUx5/DFmhdDPvWbmQspoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RjD2trdW; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=apypmejo2zdgdad4cw5ld4bjgu.protonmail; t=1742031877; x=1742291077;
	bh=9o+XY6imgq6zaQDxE/bPz6kfIxurI0uiJIyhQ04e950=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=RjD2trdWilavDargEPJh31BaRD1d0iE94K1WTsJ/ad1+eb36FAPT3fUI7TMqp4+vp
	 BRA4qDvo3Xlw2DAHsB34qIikjLUkuGU49IhcV0xUeYfrGe+MIGFT6dyGOlcXorpdI+
	 13NdK8Gh63jNwYmwhfJges7p1LmFjkOzxniQnd7B3GsO+5ig20muHxlw1o4vm2pSyP
	 hncsfKqglFrsdmvUhR9/jlpxZlSWpm3w+aRulnnpDSv1gLMX3icQ5oNoRII6ZsZnwY
	 XOFgkjwdW0YJsEYhHa08PG3v8bxHheqxyMyHsixf+18F5nEKuGXSU12m23q8WB89W4
	 sTQ7jsUBA5SUA==
Date: Sat, 15 Mar 2025 09:44:33 +0000
To: Tamir Duberstein <tamird@gmail.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 6/6] rust: use strict provenance APIs
Message-ID: <D8GQRANRVU11.SI7SZ8RAXXF@proton.me>
In-Reply-To: <CAJ-ks9=Ec0xLg81GUYJ07uDzwtwhFkoEdxaa3kNtV6xSjZ57MQ@mail.gmail.com>
References: <20250314-ptr-as-ptr-v3-0-e7ba61048f4a@gmail.com> <20250314-ptr-as-ptr-v3-6-e7ba61048f4a@gmail.com> <D8G9LZCS7ETL.9UPPQ73CAUQM@proton.me> <CANiq72=JCgdmd+h4_2VguOO9kxdx3OuTqUmpLix3mTLLHLKbZw@mail.gmail.com> <CAJ-ks9=Ec0xLg81GUYJ07uDzwtwhFkoEdxaa3kNtV6xSjZ57MQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3cfde2319760f064666ce8d81b7235df8b240a00
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 14, 2025 at 11:20 PM CET, Tamir Duberstein wrote:
> On Fri, Mar 14, 2025 at 6:00=E2=80=AFPM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> On Fri, Mar 14, 2025 at 9:18=E2=80=AFPM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>> >
>> > I don't know when we'll be bumping the minimum version. IIRC 1.85.0 is
>> > going to be in debian trixie, so eventually we could bump it to that,
>> > but I'm not sure what the time frame will be for that.
>> >
>> > Maybe we can salvage this effort by gating both the lint and the
>> > unstable features on the versions where it works? @Miguel, what's your
>> > opinion?
>> >
>> > We could even make it simple, requiring 1.84 and not bothering with th=
e
>> > older versions.
>>
>> Regarding Debian Trixie: unknown, since my understanding is that it
>> does not have a release date yet, but apparently mid May is the Hard
>> Freeze and then it may take e.g. a month or two to the release.
>>
>> And when it releases, we may want to wait a while before bumping it,
>> depending on how much time has passed since Rust 1.85.0 and depending
>> on whether we managed to get e.g. Ubuntu LTSs to provide a versioned
>> package etc.

Yeah that's what I thought, thanks for confirming.

>> If something simple works, then let's just go for that -- we do not
>> care too much about older versions for linting purposes, since people
>> should be testing with the latest stable too anyway.
>
> It's not going to be simple because `rust_common_flags` is defined
> before the config is read, which means I'll have to sprinkle
> conditional logic in even more places to enable the lints.
>
> The most minimal version of this patch would drop all the build system
> changes and just have conditionally compiled polyfills for the strict
> provenance APIs. Are folks OK with that?

So you'd not enable the lint, but fix all occurrences? I think we should
still have the lint (if it's too cumbersome, then let's only enable it
in the kernel crate).

---
Cheers,
Benno


