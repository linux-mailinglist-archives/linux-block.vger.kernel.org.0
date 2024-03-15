Return-Path: <linux-block+bounces-4501-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A50587D311
	for <lists+linux-block@lfdr.de>; Fri, 15 Mar 2024 18:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32C11F23E50
	for <lists+linux-block@lfdr.de>; Fri, 15 Mar 2024 17:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0433524BA;
	Fri, 15 Mar 2024 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="kwuuV351"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C027050A6D
	for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710524998; cv=none; b=p3RSbw4bnZnSC/Y+opVuCGgjrBhlUIU3d8SLRbZcPYREKgaQcBQL6hV9N1OHKTRauPikyXCq7I+e/c5kgpMtKPTNGoENDQIycOesf9JCnBZ0aNJpxW0DLHM+MoHE1na1yO/thVLp0Jdm8GXdcHhzNfie31LIyQhNFzmRV7XQjoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710524998; c=relaxed/simple;
	bh=AgjuwmLizdLncxaEVdxa5G6gYOJ9fxm5TNQBPG1v8Pk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CRLLgfQQAF2V3LKm97OeT+ArY1SO2I5jXg0FuLeSIMkyOfi7azP1yu0zKTYAvlh6YSxfmnmiejsZfPTuf4FrkwDX4aiO59Q1khQD1WCX5SLzjFr9bFD0AEmhWxbW/Y3W1++CFgqz0/iSw6qy9tDV7I8Cbn55Bk9HKqFgQx17sNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=kwuuV351; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5689ebef670so2750717a12.1
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 10:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1710524995; x=1711129795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBckmq0lRrEdCK7ZRxBGutF7hwnT74BhLWa7MU2ofao=;
        b=kwuuV351SoqwiUc8IlJ3y4N/7NVBzmKH8k5RPQS98Bl0FsT2zVujPnVNorGuQ1unQh
         TWayNZsBbU93LTSRjZMcOrTpPrxeKL0tjBvCwDFz86zjgxoAKxgFtI3UNyuYBVuG6oFY
         3Ve6/V3b3kB/yagJp7MiPxJODljfFmSjKmm+qPLEEi1dL9jphe6ldIu3wakKnTCGaQfF
         9F9exDrS5O0hdK98PJApcTcoJshKNozpDOQ4AKz4R5V/1ih3kujvVCTkTbwS+1TAphFN
         E++zLrEjZ0Dbf/IJD9Jdb+8iZFaCzG/456yWtE7IAnfA7o+r9I0DNoOa7sqod6+juI3K
         Xusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710524995; x=1711129795;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IBckmq0lRrEdCK7ZRxBGutF7hwnT74BhLWa7MU2ofao=;
        b=hkkJOIHn9Ja5rN9ta/878IfW0Mv0XKfzTBrFMiDYPwGOUfhQj4VM8LJyOiAzk0ziOr
         VhCNHbxjvlAUDJIoKHOQAZlQRZpSJFLPU4TDT9xqb4pfkYAsATAw2Kc5+nr/MMqet/gK
         ObXgTEHjokcPAEKttzjC/M33IudrNMS8y0lw0I2935+4aXoOLjCGTjQs6FGgvORklJn/
         BfaQN7khsTMj4C/kJghOmBrcwCDqk/IhjgfvX3MZbiP6HLwUH1JjbAyA3emDv7z5fWDR
         0MdRMes4YlmU9TnjBCTM4cKBASz7f2rku9FopI3aQDn/MCoi5CXYXqwYyedEM9HPRbYI
         AlEA==
X-Forwarded-Encrypted: i=1; AJvYcCXgwhzZ0VMuWghmMAb2nP9GMUe3X2KQI5P5fseVzvLBvpZrq1QtC5oCwxA5y4d0WxB5Nrb3mPBU95JT6oL/OC7m8a4F8tWbJnJw180=
X-Gm-Message-State: AOJu0Yw7dVXTLiNckaV8MXiAAqAilUhA1WW+y6yDs7+s1fUoa7EcQcji
	C3Ig8l6nJz8MTCwV9biXEIjjn6dw0ilCmWfEyACY2g2ZQr1sqj0HGG15DwH9OYs=
X-Google-Smtp-Source: AGHT+IHzKA6T/kTdxjZzryYHUw8kiG5csH6fJyqFozq6TcVX1w5BXWmD5wF5QCCPdc0DSKotCQBbjA==
X-Received: by 2002:a05:6402:28c9:b0:567:29d9:99ae with SMTP id ef9-20020a05640228c900b0056729d999aemr3184644edb.28.1710524995058;
        Fri, 15 Mar 2024 10:49:55 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id eo14-20020a056402530e00b00568a1897dbesm1671784edb.77.2024.03.15.10.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 10:49:54 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Ming Lei <ming.lei@redhat.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,  Jens Axboe
 <axboe@kernel.dk>,  Keith Busch <kbusch@kernel.org>,  Boqun Feng
 <boqun.feng@gmail.com>,  Christoph Hellwig <hch@lst.de>,  Damien Le Moal
 <Damien.LeMoal@wdc.com>,  Bart Van Assche <bvanassche@acm.org>,  Hannes
 Reinecke <hare@suse.de>,  "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>,  Andreas Hindborg <a.hindborg@samsung.com>,
  Wedson Almeida Filho <wedsonaf@gmail.com>,  Niklas Cassel
 <Niklas.Cassel@wdc.com>,  Greg KH <gregkh@linuxfoundation.org>,  Matthew
 Wilcox <willy@infradead.org>,  Miguel Ojeda <ojeda@kernel.org>,  Alex
 Gaynor <alex.gaynor@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>,  Benno Lossin <benno.lossin@proton.me>,
  Alice Ryhl <aliceryhl@google.com>,  Chaitanya Kulkarni
 <chaitanyak@nvidia.com>,  Luis Chamberlain <mcgrof@kernel.org>,  Yexuan
 Yang <1182282462@bupt.edu.cn>,  Sergio =?utf-8?Q?Gonz=C3=A1lez?= Collado
 <sergio.collado@gmail.com>,  Joel Granados <j.granados@samsung.com>,
  "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,  Daniel Gomez
 <da.gomez@samsung.com>,  open list <linux-kernel@vger.kernel.org>,
  "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
  "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
  "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 1/5] rust: block: introduce `kernel::block::mq` module
In-Reply-To: <ZfRoJxzOLZEIaQK7@fedora> (Ming Lei's message of "Fri, 15 Mar
	2024 23:24:23 +0800")
References: <20240313110515.70088-1-nmi@metaspace.dk>
	<20240313110515.70088-2-nmi@metaspace.dk> <ZfI8-14RUqGqoRd-@boqun-archlinux>
	<87il1ptck0.fsf@metaspace.dk>
	<CANiq72mzBe2npLo=CVR=ShyMuDmr0+TW4Gy0coPFQOBQZ_VnwQ@mail.gmail.com>
	<87plvwsjn5.fsf@metaspace.dk>
	<CANiq72neNUL1m0AbY78eXWJMov4fgjnNcQ_16SoT=ikJ3K7bZQ@mail.gmail.com>
	<8734ssrkxd.fsf@metaspace.dk> <ZfQ8Wz9gMqsN02Mv@fedora>
	<87o7bfr7bt.fsf@metaspace.dk> <ZfRoJxzOLZEIaQK7@fedora>
User-Agent: mu4e 1.12.0; emacs 29.2
Date: Fri, 15 Mar 2024 18:49:39 +0100
Message-ID: <87il1nqtak.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ming Lei <ming.lei@redhat.com> writes:

> On Fri, Mar 15, 2024 at 01:46:30PM +0100, Andreas Hindborg wrote:
>> Ming Lei <ming.lei@redhat.com> writes:
>> > On Fri, Mar 15, 2024 at 08:52:46AM +0100, Andreas Hindborg wrote:
>> >> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:
>> >>=20
>> >> > On Thu, Mar 14, 2024 at 8:23=E2=80=AFPM Andreas Hindborg <nmi@metas=
pace.dk> wrote:
>> >> >>
>> >> >> The way the current code compiles, <kernel::block::mq::Request as
>> >> >> kernel::types::AlwaysRefCounted>::dec_ref` is inlined into the `rn=
ull`
>> >> >> module. A relocation for `rust_helper_blk_mq_free_request_internal`
>> >> >> appears in `rnull_mod.ko`. I didn't test it yet, but if
>> >> >> `__blk_mq_free_request` (or the helper) is not exported, I don't t=
hink
>> >> >> this would be possible?
>> >> >
>> >> > Yeah, something needs to be exported since there is a generic
>> >> > involved, but even if you want to go the route of exporting only a
>> >> > different symbol, you would still want to put it in the C header so
>> >> > that you don't get the C missing declaration warning and so that we
>> >> > don't have to write the declaration manually in the helper.
>> >>=20
>> >> That is what I did:
>> >>=20
>> >> @@ -703,6 +703,7 @@ int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set=
 *set,
>> >>  		unsigned int set_flags);
>> >>  void blk_mq_free_tag_set(struct blk_mq_tag_set *set);
>> >>=20=20
>> >> +void __blk_mq_free_request(struct request *rq);
>> >>  void blk_mq_free_request(struct request *rq);
>> >>  int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
>> >>  		unsigned int poll_flags);
>> >
>> > Can you explain in detail why one block layer internal helper is
>> > called into rnull driver directly? It never happens in C driver code.
>>=20
>> It is not the rust null block driver that calls this symbol directly. It
>> is called by the Rust block device driver API. But because of inlining,
>> the symbol is referenced from the loadable object.
>
> What is the exact Rust block device driver API? The key point is that how
> the body of one exported kernel C API(EXPORT_SYMBOL) becomes inlined
> with Rust driver.

This happens when `ARef<Request<_>>` is dropped. The drop method
(destructor) of this smart pointer decrements the refcount and
potentially calls `__blk_mq_free_request`.

>>=20
>> The reason we have to call this symbol directly is to ensure proper
>> lifetime of the `struct request`. For example in C, when a driver
>
> Sounds Rust API still calls into __blk_mq_free_request() directly, right?

Yes, the Rust block device driver API will call this request if an
`ARef<Request<_>>` is dropped and the refcount goes to 0.

> If that is the case, the usecase need to be justified, and you need
> to write one standalone patch with the exact story for exporting
> __blk_mq_free_request().

Ok, I can do that.

>
>> converts a tag to a request, the developer makes sure to only ask for
>> requests which are outstanding in the driver. In Rust, for the API to be
>> sound, we must ensure that the developer cannot write safe code that
>> obtains a reference to a request that is not owned by the driver.
>>=20
>> A similar issue exists in the null block driver when timer completions
>> are enabled. If the request is cancelled and the timer fires after the
>> request has been recycled, there is a problem because the timer holds a
>> reference to the request private data area.
>>=20
>> To that end, I use the `atomic_t ref` field of the C `struct request`
>> and implement the `AlwaysRefCounted` Rust trait for the request type.
>> This is a smart pointer that owns a reference to the pointee. In this
>> way, the request is not freed and recycled until the smart pointer is
>> dropped. But if the smart pointer holds the last reference when it is
>> dropped, it must be able to free the request, and hence it has to call
>> `__blk_mq_free_request`.
>
> For callbacks(queue_rq, timeout, complete) implemented by driver, block
> layer core guaranteed that the passed request reference is live.
>
> So driver needn't to worry about request lifetime, same with Rust
> driver, I think smart pointer isn't necessary for using request in
> Rust driver.

Using the C API, there is nothing preventing a driver from using the
request after the lifetime ends. With Rust, we have to make it
impossible. Without the refcount and associated call to
`__blk_mq_free_request`, it would be possible to write Rust code that
access the request after the lifetime ends. This is not sound, and it is
something we need to avoid in the Rust abstractions.

One concrete way to do write unsound code with a Rust API where lifetime
is not tracked with refcount, is if the null block timer completion
callback fires after the request is completed. Perhaps the driver
cancels the request but forgets to cancel the timer. When the timer
fires, it will access the request via the context pointer, but the
request will be invalid. In C we have to write the driver code so this
cannot happen. In Rust, the API must prevent this from happening. So any
driver written in the safe subset of Rust using this API can never
trigger this behavior.

By using the refcount, we ensure that the request is alive until all
users who hold a reference to it are dropped.

Another concrete example is when a driver calls `blk_mq_tag_to_rq` with
an invalid tag. This can return a reference to an invalid tag, if the
driver is not implemented correctly. By using `req_ref_inc_not_zero` we
can assert that the request is live before we create a Rust reference to
it, and even if the driver code has bugs, it can never access an invalid
request, and thus it can be memory safe.

We move the responsibility of correctness, in relation to memory safety,
from the driver implementation to the API implementation.

Best regards,
Andreas

