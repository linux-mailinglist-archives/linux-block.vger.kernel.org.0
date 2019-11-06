Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0E0CF20D7
	for <lists+linux-block@lfdr.de>; Wed,  6 Nov 2019 22:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfKFVbH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 6 Nov 2019 16:31:07 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:37296 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732292AbfKFVbG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Nov 2019 16:31:06 -0500
Received: by mail-il1-f193.google.com with SMTP id s5so12843086iln.4
        for <linux-block@vger.kernel.org>; Wed, 06 Nov 2019 13:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PnQGbtP3kTLlYCCNGCi0FnR7p6BCR/Lr/z3o1C7g5Dc=;
        b=TFbHHQffjYKLE7lmI0ike+55iEwHZ7aWjahIPMjBg3UU95SRSKxbp1kyGMWzxEKTTZ
         j+zcamkTJAnQYmpHXBAnx/Uwjwy9sAE7HwQWED8XIOFBIBv8OA+09RAbEjEZrfQYjWXX
         OSOX1SmWlupDzH8At0ucdtzgDC+LNZu/uCrVYKRffvUJTRnOoFPStd7Ren/vUZUsADA3
         cQ1Q2cH0bIOXnqcTCqI4vQv6rn3aw/TTSkUlWC9hp7bR02/4sFm7lmIdIV1an6pxvhSz
         Lr4lJvV6nWWu4M2D4a3y/ppJAB8lp0bq7WxhoThwRs0DjAsMDeHddVCIa85JeystJhyb
         5NEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PnQGbtP3kTLlYCCNGCi0FnR7p6BCR/Lr/z3o1C7g5Dc=;
        b=NAAyBx8kgXAnankhULfxEF0YxaM4KD12Avl2FQr8JnfhsQtdd7Y1fe9EALO2qvZU70
         YDeqsG+QYu5S8IYslUO/HEjfKC5TLPLQZjhz0XqiiAxr2wHd6Gb97aOpTVWq5KIYfofC
         1LlYXLofoYayhaJTMSUHpB9FWjhsMLM+90J65MCOGvERDatIVi5K3G0rFy/B833cIIYZ
         1rUbhFGSxUDPYCF00yg797kuoQ6qElAvBAW3Kh3BePnxubED1lps3PNAs0o6NVEXQO+g
         8V1/PieENNRL3Z3b/xkQuLxaHNpjvdMnVVsvxDGV5xe65PowJW1Sh4xiKKMtsugqHUev
         cmcA==
X-Gm-Message-State: APjAAAVzsvAfAuqEn7l4kwNFmD2TNiDxya3X6g/pOwNy+RTfG5UPrgKW
        tz1V+SvkRLez6gP/FBIR08C2wA==
X-Google-Smtp-Source: APXvYqxwhlcg5ZKfl+hXYa59FHGAFXDL1InktqP4aMSn9Z5iXYAo78D4yCDGRQiredj/YcpcNZUvww==
X-Received: by 2002:a92:7405:: with SMTP id p5mr5650153ilc.261.1573075863918;
        Wed, 06 Nov 2019 13:31:03 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j87sm3622609ild.82.2019.11.06.13.31.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 13:31:03 -0800 (PST)
Subject: Re: [RFC] io_uring CQ ring backpressure
From:   Jens Axboe <axboe@kernel.dk>
To:     Jann Horn <jannh@google.com>
Cc:     io-uring@vger.kernel.org,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
References: <37d8ba3d-27c7-7636-0343-23ec56e4bee7@kernel.dk>
 <CAG48ez1_91Lk73sdpp1SiufOQShdP2zX6g9gMLW46gAvMioKOA@mail.gmail.com>
 <c01e91d3-0f20-00e9-e2c6-e4148f667fb6@kernel.dk>
Message-ID: <7878d52d-d4bb-28e5-e8dc-87b2f0721b56@kernel.dk>
Date:   Wed, 6 Nov 2019 14:31:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c01e91d3-0f20-00e9-e2c6-e4148f667fb6@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/6/19 1:08 PM, Jens Axboe wrote:
> On 11/6/19 12:51 PM, Jann Horn wrote:
>> On Wed, Nov 6, 2019 at 5:23 PM Jens Axboe <axboe@kernel.dk> wrote:
>>> Currently we drop completion events, if the CQ ring is full. That's fine
>>> for requests with bounded completion times, but it may make it harder to
>>> use io_uring with networked IO where request completion times are
>>> generally unbounded. Or with POLL, for example, which is also unbounded.
>>>
>>> This patch adds IORING_SETUP_CQ_NODROP, which changes the behavior a bit
>>> for CQ ring overflows. First of all, it doesn't overflow the ring, it
>>> simply stores backlog of completions that we weren't able to put into
>>> the CQ ring. To prevent the backlog from growing indefinitely, if the
>>> backlog is non-empty, we apply back pressure on IO submissions. Any
>>> attempt to submit new IO with a non-empty backlog will get an -EBUSY
>>> return from the kernel.
>>>
>>> I think that makes for a pretty sane API in terms of how the application
>>> can handle it. With CQ_NODROP enabled, we'll never drop a completion
>>> event (well unless we're totally out of memory...), but we'll also not
>>> allow submissions with a completion backlog.
>> [...]
>>> +static void io_cqring_overflow(struct io_ring_ctx *ctx, u64 ki_user_data,
>>> +                              long res)
>>> +       __must_hold(&ctx->completion_lock)
>>> +{
>>> +       struct cqe_drop *drop;
>>> +
>>> +       if (!(ctx->flags & IORING_SETUP_CQ_NODROP)) {
>>> +log_overflow:
>>> +               WRITE_ONCE(ctx->rings->cq_overflow,
>>> +                               atomic_inc_return(&ctx->cached_cq_overflow));
>>> +               return;
>>> +       }
>>> +
>>> +       drop = kmalloc(sizeof(*drop), GFP_ATOMIC);
>>> +       if (!drop)
>>> +               goto log_overflow;
>>> +
>>> +       drop->user_data = ki_user_data;
>>> +       drop->res = res;
>>> +       list_add_tail(&drop->list, &ctx->cq_overflow_list);
>>> +}
>>
>> This could potentially consume moderately large amounts of atomic
>> memory quickly and without any guarantee that the memory will be freed
>> anytime soon, right? That seems moderately bad. Is there no way to
>> e.g. pre-reserve memory for completion events, or something like that?
> 
> As soon as there's even one entry in that backlog, the ring won't accept
> anymore new IO. So I don't think it's a huge concern. If we pre-reserve,
> we haven't really made much progress in making sure we don't drop events,
> and we'll be tying up that memory all the time.
> 
> The alternative, as Pavel also mentioned, is to re-use the io_kiocb
> for this. But that'll tie up more memory, and it's a bit tricky with
> the life times. Just because the request has completed doesn't mean
> that someone isn't still holding a reference to it, and who knows
> what they will do.

OK, I took a stab at it, here's a brain dump of the "complications"

1) Some places now use __io_free_req() to drop both references, if we
   know we haven't issued a request yet. Needs double drop, not a big
   deal.
2) Some ordering changes between io_put_req() and the fill/add event
   logic. Again not a huge deal, easy to spot.
3) We have one failure case that does not have a request, exactly because
   we failed to allocate one. Don't look at that part in the below patch,
   I think what we should do here is just reserve a request for that case.
   It won't help with the submission, but it'll get it logged correctly
   for the overflow backlog. Any new submission can't proceed with that
   request in the overflow backlog anyway, so we need just the one.
   Not super pretty, but at least we can keep this out of the fast path,
   as the only one that will free this request is the overflow flush
   path.

I'll do a prep patch that makes the fill/add event path deal in requests,
then we can build the backpressure on top.

-- 
Jens Axboe

