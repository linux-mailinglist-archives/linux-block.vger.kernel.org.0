Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CDF46B207
	for <lists+linux-block@lfdr.de>; Tue,  7 Dec 2021 05:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbhLGE7o (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 6 Dec 2021 23:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbhLGE7n (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Dec 2021 23:59:43 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B7EC061746
        for <linux-block@vger.kernel.org>; Mon,  6 Dec 2021 20:56:14 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id h24so9401947pjq.2
        for <linux-block@vger.kernel.org>; Mon, 06 Dec 2021 20:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vfk7CqoztkD1HFR8OkKYPFrRCf+3sHfsZdA7qyQ/7N0=;
        b=EcOcbfCOFRfSCWQ46N29k7xqIx+75pRxi1/vKhuibKum+tm4X1t/qcoZFgUwCFhTys
         D8vGkMMpTqY6Gu7aJ1uJNtkkDeZxFNes3Z2qquBc5gO32LtUwVgvQLUfbS6zCCBsehfD
         jWUPZkF0YAGCIGc439scNe2cLzA8wo/SwBpIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vfk7CqoztkD1HFR8OkKYPFrRCf+3sHfsZdA7qyQ/7N0=;
        b=iG6KXRD3ms475vQPQgMGc86upJ275h/iH5BwQd5ySlyiBjJRKSrhc3MBzolqYtYMtv
         OPPXO6VWzfa757uAIF6bus2Jcyh6iZEx3CmRtSplqHu8OtooIrbcPNZMeb50BWI9uNlb
         sXcEddVIHJRlebpnw6Bx5j3wt/PzV1bex53NFHd0+SLlTfVVbzRfKVG+MU2k1GdBnjQ8
         Poqpjb0wN/8+J5ATXhUKtdMVA+E6jQMbKlj0Fac0GBD5kxPIHLhfRlrSwjP/Q9ub9rBz
         bn0Y8Y0UVDVtA6EPdbqPg6wSmuaHeWMoeurYsWeD+txD0Uy/IFeXDKLShspYbTyqC8wA
         ld8Q==
X-Gm-Message-State: AOAM533jhvqWb/vahll7CR7vsKOqFLVbukDpEDCllt1KMsxpVWefdjvH
        KtK90Y8rDZUZfnhHCDiOmKrWmG3OqsajpQ==
X-Google-Smtp-Source: ABdhPJyKERAriy5ko5uP7qvV/cSmj/QqxhbhuhGGsvjUxznfwAESoUpWMKn4Z5RZXnqAQOczzv27+g==
X-Received: by 2002:a17:902:b08a:b0:142:51be:57e2 with SMTP id p10-20020a170902b08a00b0014251be57e2mr48470411plr.53.1638852973792;
        Mon, 06 Dec 2021 20:56:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t67sm13888134pfd.24.2021.12.06.20.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 20:56:13 -0800 (PST)
Date:   Mon, 6 Dec 2021 20:56:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: switch to atomic_t for request references
Message-ID: <202112062004.EFB6BFE1@keescook>
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org>
 <Ya3KZiLg5lYjsGcQ@hirez.programming.kicks-ass.net>
 <CAHk-=wjXmGt9-JQp-wvup4y2tFNUCVjvx2W7MHzuAaxpryP4mg@mail.gmail.com>
 <282666e2-93d4-0302-b2d0-47d03395a6d4@kernel.dk>
 <202112061247.C5CD07E3C@keescook>
 <CAHk-=wh0RhnMfZG6xQJ=yHTgmPTaxjQOo1Q2=r+_ZR56yiRi4A@mail.gmail.com>
 <202112061455.F23512C3CB@keescook>
 <CAHk-=whLU+dk7EmPu5UC6DDSd76_dO4bVd4BkvxmR4W5-mmAgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whLU+dk7EmPu5UC6DDSd76_dO4bVd4BkvxmR4W5-mmAgg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 06, 2021 at 04:13:00PM -0800, Linus Torvalds wrote:
> On Mon, Dec 6, 2021 at 3:28 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > I'm not arguing for refcount_t -- I'm arguing for an API that isn't a
> > regression of features that have been protecting the kernel from bugs.
> 
> Maybe somebody could actually just fix refcount_t instead. Somebody
> who cares about that currently horrendously bad interface.
> 
> Fix it to not do the fundamentally broken saturation that actively
> destroys state: fix it to have a safe "try to increment", instead of
> an unsafe "increment and do bad things".

There would need to be a pretty hefty transition -- there are a lot of
refcount_inc() uses that would need checking and error handling (which
might not be sane to add to ancient drivers):

      2 block
      2 crypto
      2 ipc
      2 virt
      3 mm
      4 sound
      5 rust
     10 arch
     13 security
     31 kernel
     88 include
    192 fs
    192 net
    358 drivers

refcount_inc_not_zero() already uses __must_check, etc.

I'm not afraid of giant transitions, but this could be pretty tricky.
I'm open to ideas. Maybe a treewide change of refcount_inc() ->
refcount_inc_saturating() and then start fixing all the _unsafe() cases
where a sensible error path could be created and tested?

-- 
Kees Cook
