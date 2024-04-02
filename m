Return-Path: <linux-block+bounces-5562-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44ADA8953E5
	for <lists+linux-block@lfdr.de>; Tue,  2 Apr 2024 14:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3222842DF
	for <lists+linux-block@lfdr.de>; Tue,  2 Apr 2024 12:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A040A7E796;
	Tue,  2 Apr 2024 12:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="o4c2yRDJ"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598547E788
	for <linux-block@vger.kernel.org>; Tue,  2 Apr 2024 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062393; cv=none; b=G12Ou9Y/N4JIt1L5kDMS48Am9TYMgxAR4OHEeJvQvc5aLNWILFJ0TtCAgih4GmIixcuE0ir+3cQfe6kgpOZcvpROaIz0jZeMO30lrz8ciSu8VHtH0ejxTZO61p/YYEcjZ8wky9DG0LjRC1383XRsFeDNwEEZNZu+gvowSQBErXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062393; c=relaxed/simple;
	bh=LPp1LoXc/iUZYcuArnYpygWNYI02olIHB5JtN31wm9k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nBthZ4fqPEH9aiOMS3SdBu+gd/55MX3X1W4qYSmP04KT/MwcF+sYijVfbX/HwFE00XkyP5qjcaptCMPvBz7YbYspXB5OfAViSfx07VOEqoLHVUosc1iLmwfQa1kcc98HugXFyCpS7WgNQx7hGM+AAELUJQyXPrk0LRSJoW79Oic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=o4c2yRDJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-415446af364so25578305e9.0
        for <linux-block@vger.kernel.org>; Tue, 02 Apr 2024 05:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1712062389; x=1712667189; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hvhw9LsqhxNzOOOcCfIt2sSk317Q3WM4yG9zmNorI5c=;
        b=o4c2yRDJgM3FdYuyKdOtPkrfHXHH1na/mQ97sp3uQABI3rP/3C4O/Rj15z0p87Weh/
         LWUS8CEbpCpQbI/BFouhOaeWciwdti4frjfPtQvfXRlgmhN60XeiyjOakE8vBLqglaLs
         TcObTXber3pmshpfrz46coJ4htxtYTihGX27qcSDP5kFw/dMm6kYWJ6XP1tsX5ILF1U0
         QmKAVskJuYGrA+BQYvzDRg9qCD/ZyqbsCjFXcREXrhz1d0lBQ6SKKQx8QtlVbcxfRhW5
         8O1bYnBxj+9hLWNyyDDtnTTf+ZbBOIaZJJBTQqqEFZWDMns5tYEsxiaHVPDSqP01i3I5
         xxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712062389; x=1712667189;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvhw9LsqhxNzOOOcCfIt2sSk317Q3WM4yG9zmNorI5c=;
        b=ecn1tIbs6mjHku/Gakis/3Rog1S0x/H4xjE4IIzLlyNN4ob/HDlnZlYh2xzEhKYB90
         zMHiuRpfOOt+FnAsWi5Sfx5IjgVjEB0WLg/VHYCTK1tGN+9CtzE4/wRlNFqUUCHb7Ypo
         mUZEIkKdp5iD49yCROXVm1LleWuy0o21OW/JQLMJHwJ2zsmaRED7Yuxx6/qwjQUWsUxq
         Di4ZDepDQMGPkXccYOdFNG7KOJPYTUuBK0ffTHule/G/CrJu78tcjx7T8vD5QFCpQfAD
         GukiQpht8JYdIPxbZB5TqdLDzWRF1WwVt67eUbY1Cbb05882nVWQ0agpYWjaA+7VR0tk
         fIPg==
X-Forwarded-Encrypted: i=1; AJvYcCWcvHUvjHOkIMhG8VXgdjUXU3+fq+j4RMtWB/voKvXUKb1dtqnYEsKU8NRlMpRQd1YN82P9z3QoQ1AkJe1CbtOQ8tlXgxYkqyLGZaM=
X-Gm-Message-State: AOJu0Yxx7ZWth6LTGmNk7r25N6SbP5Wo6aNZNV2cZQxwdmohND/a3L9h
	n2FFZeum69Jk03oDzdzN1W2jJKmuIA8HZQ0XvO7v+gkNoshOanrsI8SEMMxNl14=
X-Google-Smtp-Source: AGHT+IEFz3AepeyAQxN36Z0IfK+JwdPVjtp4Sb8ReYgZAqLDYPFoVzfevNH+l3YXMt9M9NS/Rc5Www==
X-Received: by 2002:a05:600c:310f:b0:415:6bd7:96a0 with SMTP id g15-20020a05600c310f00b004156bd796a0mr3331124wmo.20.1712062388718;
        Tue, 02 Apr 2024 05:53:08 -0700 (PDT)
Received: from localhost ([147.161.155.112])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c1d1400b004146a304863sm21200277wms.34.2024.04.02.05.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 05:53:08 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>,  Christoph Hellwig <hch@lst.de>,  Keith
 Busch <kbusch@kernel.org>,  Damien Le Moal <Damien.LeMoal@wdc.com>,  Bart
 Van Assche <bvanassche@acm.org>,  Hannes Reinecke <hare@suse.de>,
  "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,  Andreas
 Hindborg <a.hindborg@samsung.com>,  Niklas Cassel <Niklas.Cassel@wdc.com>,
  Greg KH <gregkh@linuxfoundation.org>,  Matthew Wilcox
 <willy@infradead.org>,  Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor
 <alex.gaynor@gmail.com>,  Wedson Almeida Filho <wedsonaf@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Alice Ryhl <aliceryhl@google.com>,
  Chaitanya Kulkarni <chaitanyak@nvidia.com>,  Luis Chamberlain
 <mcgrof@kernel.org>,  Yexuan Yang <1182282462@bupt.edu.cn>,  Sergio
 =?utf-8?Q?Gonz=C3=A1lez?= Collado <sergio.collado@gmail.com>,  Joel
 Granados
 <j.granados@samsung.com>,  "Pankaj Raghav (Samsung)"
 <kernel@pankajraghav.com>,  Daniel Gomez <da.gomez@samsung.com>,  open
 list <linux-kernel@vger.kernel.org>,  "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>,  "lsf-pc@lists.linux-foundation.org"
 <lsf-pc@lists.linux-foundation.org>,  "gost.dev@samsung.com"
 <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 3/5] rust: block: allow `hrtimer::Timer` in
 `RequestData`
In-Reply-To: <sHRsbsEAgQZOgBjItL1A-a1BOEGTeH4CWqZsrdny4vCI06o56pmKluCTbY_EwRDO1hCjEp9Cuq9_8S8Co2I9c8wquHWZH_KGjOpmbF1YiJc=@proton.me>
	(Benno Lossin's message of "Sat, 23 Mar 2024 10:51:57 +0000")
References: <20240313110515.70088-1-nmi@metaspace.dk>
	<20240313110515.70088-4-nmi@metaspace.dk>
	<sHRsbsEAgQZOgBjItL1A-a1BOEGTeH4CWqZsrdny4vCI06o56pmKluCTbY_EwRDO1hCjEp9Cuq9_8S8Co2I9c8wquHWZH_KGjOpmbF1YiJc=@proton.me>
User-Agent: mu4e 1.12.0; emacs 29.2
Date: Tue, 02 Apr 2024 14:43:51 +0200
Message-ID: <87sf043pfc.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> On 3/13/24 12:05, Andreas Hindborg wrote:> From: Andreas Hindborg <a.hindborg@samsung.com>
>> 
>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>> ---
>>   rust/kernel/block/mq/request.rs | 67 ++++++++++++++++++++++++++++++++-
>>   1 file changed, 66 insertions(+), 1 deletion(-)
>> 
>> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
>> index cccffde45981..8b7f08f894be 100644
>> --- a/rust/kernel/block/mq/request.rs
>> +++ b/rust/kernel/block/mq/request.rs
>> @@ -4,13 +4,16 @@
>>   //!
>>   //! C header: [`include/linux/blk-mq.h`](srctree/include/linux/blk-mq.h)
>> 
>> +use kernel::hrtimer::RawTimer;
>> +
>>   use crate::{
>>       bindings,
>>       block::mq::Operations,
>>       error::{Error, Result},
>> +    hrtimer::{HasTimer, TimerCallback},
>>       types::{ARef, AlwaysRefCounted, Opaque},
>>   };
>> -use core::{ffi::c_void, marker::PhantomData, ops::Deref};
>> +use core::{ffi::c_void, marker::PhantomData, ops::Deref, ptr::NonNull};
>> 
>>   use crate::block::bio::Bio;
>>   use crate::block::bio::BioIterator;
>> @@ -175,6 +178,68 @@ fn deref(&self) -> &Self::Target {
>>       }
>>   }
>> 
>> +impl<T> RawTimer for RequestDataRef<T>
>> +where
>> +    T: Operations,
>> +    T::RequestData: HasTimer<T::RequestData>,
>> +    T::RequestData: Sync,
>> +{
>> +    fn schedule(self, expires: u64) {
>> +        let self_ptr = self.deref() as *const T::RequestData;
>> +        core::mem::forget(self);
>> +
>> +        // SAFETY: `self_ptr` is a valid pointer to a `T::RequestData`
>> +        let timer_ptr = unsafe { T::RequestData::raw_get_timer(self_ptr) };
>> +
>> +        // `Timer` is `repr(transparent)`
>> +        let c_timer_ptr = timer_ptr.cast::<bindings::hrtimer>();
>> +
>> +        // Schedule the timer - if it is already scheduled it is removed and
>> +        // inserted
>> +
>> +        // SAFETY: c_timer_ptr points to a valid hrtimer instance that was
>> +        // initialized by `hrtimer_init`
>> +        unsafe {
>> +            bindings::hrtimer_start_range_ns(
>> +                c_timer_ptr as *mut _,
>> +                expires as i64,
>> +                0,
>> +                bindings::hrtimer_mode_HRTIMER_MODE_REL,
>> +            );
>> +        }
>> +    }
>> +}
>> +
>> +impl<T> kernel::hrtimer::RawTimerCallback for RequestDataRef<T>
>> +where
>> +    T: Operations,
>> +    T: Sync,
>
> Why is this needed? Shouldn't this be `T::RequestData: Sync`?
>
> Is the `run` function below executed on a different thread compared to
> the `schedule` function above?
> If yes, then `T::RequestData` probably also needs to be `Send`.
> You also would need to adjust the bounds in the impl above.

It's a typo, thanks for spotting. It should be `T::RequestData: Sync`.

BR Andreas

