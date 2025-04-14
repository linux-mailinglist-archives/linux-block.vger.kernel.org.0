Return-Path: <linux-block+bounces-19555-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C028A87E16
	for <lists+linux-block@lfdr.de>; Mon, 14 Apr 2025 12:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7A31896536
	for <lists+linux-block@lfdr.de>; Mon, 14 Apr 2025 10:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1256B27E1AC;
	Mon, 14 Apr 2025 10:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="BegFfWdY"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4501D27CB3B
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744627991; cv=none; b=dCEDkHE4OWyXYQGgs2hbc0rDDBPoiPrumd1rxjOg2nM/QwPUHNBbXKLfwJzBqnUg5ZQeVQyvK2YAyZ7J0GwU2AQ6Kjt1N0pDOa+gnXFVh0L7UpM6OOkdsjAYEmEWneCggQYQAIPedvlT7sblWL4AMUnnxntGXkXI+Wl5JxqdVTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744627991; c=relaxed/simple;
	bh=hp/iT9vRY4WLbkXBJM0HMTKnmsgkT83gkCn0+xI8TDs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDYwVvuoEQSIIzbM9dpjjyw06sfNHDtKJMZE+tBe0ubCdStCQM9K4dRhjoa2QUl9l3JRwWQM0woYPXxWRDeubklBKMJfdw7Xra9DepV4qcHkq47jy8jZsvUK5RC7t5y2snEcp1Q/rpbj5rMQHbCzg6ppVdLD3GD2IBGx7Zv8+9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=BegFfWdY; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=xkpzb5yfxnf2jeuzp7tothlcbe.protonmail; t=1744627980; x=1744887180;
	bh=cGneafMdb7E/5GcVD98UZZZtBXjzJsDf2In9bf3AS80=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=BegFfWdYH4OhAyD9Vvv7x2GV3KDqo1ZdIa4E1vDwLL1zYU+n0iu7x/BeBvqz8KItD
	 GDOj/qovBvhDYAgxwurvOPV4B5kaKfgzdIJK90kxmeSI/vZ9nc4wMn2yrjl83TNmRV
	 aUtOAtPUFwMQ4obXOllmUTSJ1Hb4ggZEdjnCh2xk3po2dfCSfYaV5Fyjns7UdfevHL
	 TpQNAPlce1lLPOQTB7WtXA13fie3Bytsq41rfbB3b5pSrw6cFQMzsIoPAxgH4iCGnJ
	 PiyPMQARv9EXxWlP0kBJ4X5NI1T61eWT7rjmyhWhDFsYvfDDkxZgDbb0NKHMbDUr0R
	 j3CebiM1XQJVw==
Date: Mon, 14 Apr 2025 10:52:54 +0000
To: Tamir Duberstein <tamird@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Nicolas Schier <nicolas.schier@linux.dev>, Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Subject: Re: [PATCH v8 6/6] rust: enable `clippy::ref_as_ptr` lint
Message-ID: <D96B00U9SS2Q.1YHLNBOIEWSNE@proton.me>
In-Reply-To: <20250409-ptr-as-ptr-v8-6-3738061534ef@gmail.com>
References: <20250409-ptr-as-ptr-v8-0-3738061534ef@gmail.com> <20250409-ptr-as-ptr-v8-6-3738061534ef@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 192a33aecbd50a9b6c4225576203521e98318959
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Apr 9, 2025 at 4:47 PM CEST, Tamir Duberstein wrote:
> In Rust 1.78.0, Clippy introduced the `ref_as_ptr` lint [1]:
>
>> Using `as` casts may result in silently changing mutability or type.
>
> While this doesn't eliminate unchecked `as` conversions, it makes such
> conversions easier to scrutinize.  It also has the slight benefit of
> removing a degree of freedom on which to bikeshed. Thus apply the
> changes and enable the lint -- no functional change intended.
>
> Link: https://rust-lang.github.io/rust-clippy/master/index.html#ref_as_pt=
r [1]
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/all/D8PGG7NTWB6U.3SS3A5LN4XWMN@proton.me/
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  Makefile                 |  1 +
>  rust/bindings/lib.rs     |  1 +
>  rust/kernel/device_id.rs |  3 ++-
>  rust/kernel/fs/file.rs   |  3 ++-
>  rust/kernel/str.rs       |  6 ++++--
>  rust/kernel/uaccess.rs   | 10 ++++------
>  rust/uapi/lib.rs         |  1 +
>  7 files changed, 15 insertions(+), 10 deletions(-)


