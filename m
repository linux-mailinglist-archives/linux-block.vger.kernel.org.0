Return-Path: <linux-block+bounces-2526-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FC8840845
	for <lists+linux-block@lfdr.de>; Mon, 29 Jan 2024 15:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7CE02845F7
	for <lists+linux-block@lfdr.de>; Mon, 29 Jan 2024 14:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE6366B36;
	Mon, 29 Jan 2024 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="Bnk4P57t"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D2266B24
	for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538465; cv=none; b=TuCLsXn+JbUX3B4vJ+D1vevqNw/zeN0d1Q5cl0k62wX/eXMPS1VQZ7/dpQ3e3MUZTdskqWpXpvIetAbAN9HxXLnLeZOHdboOgfCy6GJ/GD2ziC2Sr6rCZ/efgPxZTQXqTpOiyAaf2TKNMWOEU1uv+g2NKJM/CfM10C62piL5OKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538465; c=relaxed/simple;
	bh=6bzM16UBxP08WHaFfcFo1ofPi4ev583qMl2qYHoKPgo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=BUxXtnbUMFRkxpwX2WzKgg71G8CzhY2XQSB5mKDCeTLLTekDw8CHtm9zvIITFXDxB7a3WcTOY8nYe3bdyAk32W9r9sjKcacTMSxcaHGkTxuIrDRzIHxNfzMgPUtX+20aHENjDQ64+V/Xt/BVEv1tu9m78FEqeea13Oj5K282Id4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=Bnk4P57t; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e76626170so34669385e9.2
        for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 06:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1706538461; x=1707143261; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=9SpRD2seb2hFO2F2eYuqqQkOpWG+jBIz46VQxNPe840=;
        b=Bnk4P57t6cpXMr9bIHUjebrMow12H1ie7eOrIl+eYVcEK14V+XJm67zHWjQzAY9qPN
         0/MLDsIWOmGgetC79xU08NO79JGNx3RS1FRPQeDLArzYBIoOL5gtzq9xRt/M3ERBm6Tu
         T8shhjG6BpUS/vm9QYbdpcaUdnLIPbzCyfA2xUsIg2A4GWg6q2rIiHlZMCZfjg5xqm6q
         SUT5D6DcQe6r2l00cs4tM2hnbtfIlGAUtsO3v+jFfm+dv3+TUBa9jvPtVO5UAgxsGY4I
         kcqvzyuAUGcHAzQQ3OWyQq+OQUghA25FwbNF21uaieDNFzflnrA6Dmm8D38z80KirOoS
         sX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706538461; x=1707143261;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SpRD2seb2hFO2F2eYuqqQkOpWG+jBIz46VQxNPe840=;
        b=pUN7ci7pHukal9za2gDsGezsX6SesbKx/updqHr6RqyJf6PpPgaUvbcqo/saEa33Sg
         3NbVB6GRcNpjmykZyWjD4ZMqzS1PCS6kHAtNmSlyZdlTKVIbiSjHx83RQiwG0QoajHF7
         mzkpBJvTR1tWYRDeRngy30Vom6hAyKY43pVaysA6Sv3AeCJPp7jK8Jg0KRutm9hPmkRZ
         g9Wb5sPbw5oV84vHytuCkyC/qFS+/vn6Oh2BI/3aOjYt5G8gp6LgGlvCG9aYOMv4Aoni
         7ox9q47JqhUwur23wbICsH73hJwWqiR8n5OHBwzgJVKqCV416RR2Og/pEu4RxGvfowz6
         p0FA==
X-Gm-Message-State: AOJu0Yze7vzRzF13/WFEWirFynRUWdmY/uyC1/2h9aA4lTQULjA1ORKK
	MxEpjKD9hnwSNR0/QxPLwTdDkfVhEjuozjLvdC9TcLadfiUo7PwVdM8lpxGbsBk=
X-Google-Smtp-Source: AGHT+IF687yIs+FI2jGNHFF+JBGNUG60+S+Rqe4sHIAnRad9l9UQH5/3KSyty1FjpSpCXMtpmut+RQ==
X-Received: by 2002:adf:8b56:0:b0:33a:e598:cabb with SMTP id v22-20020adf8b56000000b0033ae598cabbmr3910064wra.70.1706538460714;
        Mon, 29 Jan 2024 06:27:40 -0800 (PST)
Received: from localhost ([165.225.194.205])
        by smtp.gmail.com with ESMTPSA id eo9-20020a056000428900b0033ae9e7f6b6sm4015743wrb.111.2024.01.29.06.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 06:27:40 -0800 (PST)
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <20230503090708.2524310-4-nmi@metaspace.dk>
 <iL2M45BoRlK6yS9y8uo0A5yUXcZWMkdk3vtH3LRFSWXfvPVagVZ-0YC7taIKOBFUcjJYA_2xNNFPoC4WL-_ulCHOLkbqvsZlIshE_LEeYtU=@proton.me>
 <87il3kjgk0.fsf@metaspace.dk>
 <104a22f7-a5bb-4fb6-9ce9-aa2d4e63417f@proton.me>
 <874jf3kflx.fsf@metaspace.dk>
 <59f007a0-bb30-4291-ab49-0e69112e2566@proton.me>
User-agent: mu4e 1.10.8; emacs 29.2
From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, Hannes
 Reinecke <hare@suse.de>, lsf-pc@lists.linux-foundation.org,
 rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, Matthew
 Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, linux-kernel@vger.kernel.org,
 gost.dev@samsung.com
Subject: Re: [RFC PATCH 03/11] rust: block: introduce `kernel::block::mq`
 module
Date: Mon, 29 Jan 2024 15:14:50 +0100
In-reply-to: <59f007a0-bb30-4291-ab49-0e69112e2566@proton.me>
Message-ID: <87r0i0gqp8.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Benno Lossin <benno.lossin@proton.me> writes:

> On 23.01.24 19:39, Andreas Hindborg (Samsung) wrote:
>>>>>> +/// A generic block device
>>>>>> +///
>>>>>> +/// # Invariants
>>>>>> +///
>>>>>> +///  - `gendisk` must always point to an initialized and valid `struct gendisk`.
>>>>>> +pub struct GenDisk<T: Operations> {
>>>>>> +    _tagset: Arc<TagSet<T>>,
>>>>>> +    gendisk: *mut bindings::gendisk,
>>>>>
>>>>> Why are these two fields not embedded? Shouldn't the user decide where
>>>>> to allocate?
>>>>
>>>> The `TagSet` can be shared between multiple `GenDisk`. Using an `Arc`
>>>> seems resonable?
>>>>
>>>> For the `gendisk` field, the allocation is done by C and the address
>>>> must be stable. We are owning the pointee and must drop it when it goes out
>>>> of scope. I could do this:
>>>>
>>>> #[repr(transparent)]
>>>> struct GenDisk(Opaque<bindings::gendisk>);
>>>>
>>>> struct UniqueGenDiskRef {
>>>>       _tagset: Arc<TagSet<T>>,
>>>>       gendisk: Pin<&'static mut GenDisk>,
>>>>
>>>> }
>>>>
>>>> but it seems pointless. `struct GenDisk` would not be pub in that case. What do you think?
>>>
>>> Hmm, I am a bit confused as to how you usually use a `struct gendisk`.
>>> You said that a `TagSet` might be shared between multiple `GenDisk`s,
>>> but that is not facilitated by the C side?
>>>
>>> Is it the case that on the C side you create a struct containing a
>>> tagset and a gendisk for every block device you want to represent?
>> 
>> Yes, but the `struct tag_set` can be shared between multiple `struct
>> gendisk`.
>> 
>> Let me try to elaborate:
>> 
>> In C you would first allocate a `struct tag_set` and partially
>> initialize it. The allocation can be dynamic, static or part of existing
>> allocation. You would then partially initialize the structure and finish
>> the initialization by calling `blk_mq_alloc_tag_set()`. This populates
>> the rest of the structure which includes more dynamic allocations.
>> 
>> You then allocate a `struct gendisk` by calling `blk_mq_alloc_disk()`,
>> passing in a pointer to the `struct tag_set` you just created. This
>> function will return a pointer to a `struct gendisk` on success.
>> 
>> In the Rust abstractions, we allocate the `TagSet`:
>> 
>> #[pin_data(PinnedDrop)]
>> #[repr(transparent)]
>> pub struct TagSet<T: Operations> {
>>      #[pin]
>>      inner: Opaque<bindings::blk_mq_tag_set>,
>>      _p: PhantomData<T>,
>> }
>> 
>> with `PinInit` [^1]. The initializer will partially initialize the struct and
>> finish the initialization like C does by calling
>> `blk_mq_alloc_tag_set()`. We now need a place to point the initializer.
>> `Arc::pin_init()` is that place for now. It allows us to pass the
>> `TagSet` reference to multiple `GenDisk` if required. Maybe we could be
>> generic over `Deref<TagSet>` in the future. Bottom line is that we need
>> to hold on to that `TagSet` reference until the `GenDisk` is dropped.
>
> I see, thanks for the elaborate explanation! I now think that using `Arc`
> makes sense.
>
>> `struct tag_set` is not reference counted on the C side. C
>> implementations just take care to keep it alive, for instance by storing
>> it next to a pointer to `struct gendisk` that it is servicing.
>
> This is interesting, is this also done in the case where it is shared
> among multiple `struct gendisk`s?

Yes. The architecture is really quite flexible. For instance C NVMe uses
one tag set for the admin queue of a nvme controller, and one tag set
shared for all IO queues of a controller. The admin queue tag set is not
actually attached to a `struct gendisk` and does not appear as a block
device to the user. The IO queue tag set serves a number `struct
gendisk`, one for each name space of the controller.

> Does this have some deeper reason? Or am I right to assume that creating
> `Gendisk`/`TagSet` is done rarely (i.e. only at initialization of the
> driver)?

I am not sure. It could probably be reference counted on C side. Perhaps
nobody felt the need for it, since the lifetime of it is not that
complex. And yes, it is relatively rare as it is only as part of
initialization and tear down that you would create or destroy this
structure.

Best regards,
Andreas


