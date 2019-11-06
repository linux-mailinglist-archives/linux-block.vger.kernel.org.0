Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 294ABF1F49
	for <lists+linux-block@lfdr.de>; Wed,  6 Nov 2019 20:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfKFTwR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 6 Nov 2019 14:52:17 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42978 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfKFTwR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Nov 2019 14:52:17 -0500
Received: by mail-ot1-f68.google.com with SMTP id b16so21909456otk.9
        for <linux-block@vger.kernel.org>; Wed, 06 Nov 2019 11:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fywk/plM2dJuF2Bmhii1gb5GzxJYSB5K3wPTzmwhhxI=;
        b=qOFx0xEOpsZVDCbtwWlwrhilDwHYnSUBwi+LTF2X+8bcgpYLnD5ehgZ+3r6HyiwrdS
         LTaozXkqIzdqweUI2HKM3mYNtl5r1DceDZ3y4Bj537ejoCt+aUnxRgpIWsjEBztevPQV
         HyZtRpfqXb7nO56hyk9uGzapO4Cjh5/evdGQ4nOY5b/w6Zu9O7qClXq1v2yW0xW88J8x
         tjS2Jdh+Hh60wVdzK4ucAWOOBwLBPYcvRSgfWQoUtRDtgWuT2J9qcJcG7rWEwTFDUlZ7
         /tD+8uMO1b1a6gthBq2FlE+wPBuR5Cd4sNsq7SzPYVAAgS9CRc25bjSMHhri64rkM7IA
         k/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fywk/plM2dJuF2Bmhii1gb5GzxJYSB5K3wPTzmwhhxI=;
        b=siUVDLKPUszgUg1dYclYPy7USnr9TzJApIXRil6DLDN3fVrgMwnuH8Eu0w68r7a3/a
         mx/2xCTJC/vyfcwH1se1yAvnrkOPmcSyfRWbY+v1FKhWZS/OWpccLf+WUKJvutcTusdT
         gok/zedBVQfLE/8G3Yyla2tMs+iml6oeZR7Ge63KtXZNx0RNecM2gbIawj7Yib7FYDRg
         6uRijasK4fyL/gHe2z2VIng/YyHXM548Giz9Mb4ns526hdIF+34mP6Wb9Xaa1PcGaYXY
         mFf4rrWjoDNsMprFMzht1gD4hbcOQawEkX2S2Y6j6aKbiMWtZiwz44NQjEyqMapK3Do+
         XbZA==
X-Gm-Message-State: APjAAAXn89eyYdosjVi+ncdSVAxDvLEkHsobVcJxA9xsKsXQn6XZ2i7Q
        V+niwdL+Ds6Uh1xS0xllwML+XLyCURzTvYPqbGe/VsIB
X-Google-Smtp-Source: APXvYqwdu01jCn8yBHyhCGhj3PkHuuweCuHkOnR+jBRccrFosPpUeYbXF75FgeL/SRzYzJ8DU5f6SjxP1mLZdGh5cfQ=
X-Received: by 2002:a9d:4801:: with SMTP id c1mr3138962otf.32.1573069935716;
 Wed, 06 Nov 2019 11:52:15 -0800 (PST)
MIME-Version: 1.0
References: <37d8ba3d-27c7-7636-0343-23ec56e4bee7@kernel.dk>
In-Reply-To: <37d8ba3d-27c7-7636-0343-23ec56e4bee7@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 6 Nov 2019 20:51:48 +0100
Message-ID: <CAG48ez1_91Lk73sdpp1SiufOQShdP2zX6g9gMLW46gAvMioKOA@mail.gmail.com>
Subject: Re: [RFC] io_uring CQ ring backpressure
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 6, 2019 at 5:23 PM Jens Axboe <axboe@kernel.dk> wrote:
> Currently we drop completion events, if the CQ ring is full. That's fine
> for requests with bounded completion times, but it may make it harder to
> use io_uring with networked IO where request completion times are
> generally unbounded. Or with POLL, for example, which is also unbounded.
>
> This patch adds IORING_SETUP_CQ_NODROP, which changes the behavior a bit
> for CQ ring overflows. First of all, it doesn't overflow the ring, it
> simply stores backlog of completions that we weren't able to put into
> the CQ ring. To prevent the backlog from growing indefinitely, if the
> backlog is non-empty, we apply back pressure on IO submissions. Any
> attempt to submit new IO with a non-empty backlog will get an -EBUSY
> return from the kernel.
>
> I think that makes for a pretty sane API in terms of how the application
> can handle it. With CQ_NODROP enabled, we'll never drop a completion
> event (well unless we're totally out of memory...), but we'll also not
> allow submissions with a completion backlog.
[...]
> +static void io_cqring_overflow(struct io_ring_ctx *ctx, u64 ki_user_data,
> +                              long res)
> +       __must_hold(&ctx->completion_lock)
> +{
> +       struct cqe_drop *drop;
> +
> +       if (!(ctx->flags & IORING_SETUP_CQ_NODROP)) {
> +log_overflow:
> +               WRITE_ONCE(ctx->rings->cq_overflow,
> +                               atomic_inc_return(&ctx->cached_cq_overflow));
> +               return;
> +       }
> +
> +       drop = kmalloc(sizeof(*drop), GFP_ATOMIC);
> +       if (!drop)
> +               goto log_overflow;
> +
> +       drop->user_data = ki_user_data;
> +       drop->res = res;
> +       list_add_tail(&drop->list, &ctx->cq_overflow_list);
> +}

This could potentially consume moderately large amounts of atomic
memory quickly and without any guarantee that the memory will be freed
anytime soon, right? That seems moderately bad. Is there no way to
e.g. pre-reserve memory for completion events, or something like that?
