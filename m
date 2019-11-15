Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C59ABFE713
	for <lists+linux-block@lfdr.de>; Fri, 15 Nov 2019 22:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfKOVRq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 15 Nov 2019 16:17:46 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46408 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfKOVRq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Nov 2019 16:17:46 -0500
Received: by mail-lf1-f67.google.com with SMTP id o65so9003506lff.13
        for <linux-block@vger.kernel.org>; Fri, 15 Nov 2019 13:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xLz3Xr8TvGk1oVGrR5pjuIrOELVV7mBaTprlBhmoJyk=;
        b=SbNXGQStFbr6YPNF0PX5qOYwuwzYSHH6C/gh2SfkUZ3bVCJAXxguUaymm8QDaGsGA9
         hiSl+MVdSwpN74B1S20lnglblgO8cAGGhj2lx2beFn8Dy/JoLnsMSaxtzsMo0d8FUYEf
         eAhtAW6zQRLQBmo3UrMpIgpFdNt58OCbgVOJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xLz3Xr8TvGk1oVGrR5pjuIrOELVV7mBaTprlBhmoJyk=;
        b=KDI+FWMFeal2Zm6FMESik1Eu3K+kJ7KFqGvKBHlU2ZfzMe65pAw15N7oR20gy7T6ri
         kUyFxuIA53e8a4MxjjHCdc6/rNTrzjiQalcu3FN8vIL3Ax23DtsUmeo+JHJ4UeJGrr+R
         EQtrq0yJmmz2cHDgXuNLI3cmfzTxIxwJVfTvEkACpKjoqJ6nFn4i7uK/FizZ55HdUAkL
         TNuw9FcpTccEb2maDN5Il9a1V4uufDzyjQ9t2jScC/qJzOFqpB7v4gVBrByHLrgDya2u
         mY2Ikwi4DOjQXDjGnrWchZBIKBr6Jgun7BfTXJ3xcxUz6wI3B7pCZNRDDIxyCNT15EqR
         acTA==
X-Gm-Message-State: APjAAAVimLMbVMuosTIF8fPlQ6kkFhkXX5x8JyEhlMn2BZveObeYB7M8
        QzmH0BLqJ6uNgApMmO7JkhhXIiw7zNY=
X-Google-Smtp-Source: APXvYqyqyBSUn8WvwpTcgbU5+tZGWiMALcJZpQldj3mEuBuSAQ4ci6U/sd0oFmGo06XMzEFq99kp7w==
X-Received: by 2002:ac2:5685:: with SMTP id 5mr951924lfr.32.1573852663320;
        Fri, 15 Nov 2019 13:17:43 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 12sm4599651lju.55.2019.11.15.13.17.42
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 13:17:42 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id r14so2403751lff.3
        for <linux-block@vger.kernel.org>; Fri, 15 Nov 2019 13:17:42 -0800 (PST)
X-Received: by 2002:ac2:498a:: with SMTP id f10mr12685140lfl.170.1573852661750;
 Fri, 15 Nov 2019 13:17:41 -0800 (PST)
MIME-Version: 1.0
References: <749566df-9390-2b57-ca8e-7f3b6493eae8@kernel.dk>
In-Reply-To: <749566df-9390-2b57-ca8e-7f3b6493eae8@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Nov 2019 13:17:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjm-UQpZS2T03z2iVxCQUUQN5BGvzVguDStQw2WddM46Q@mail.gmail.com>
Message-ID: <CAHk-=wjm-UQpZS2T03z2iVxCQUUQN5BGvzVguDStQw2WddM46Q@mail.gmail.com>
Subject: Re: [GIT PULL] Fixes for 5.4-rc8/final
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 15, 2019 at 11:40 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> - Fix impossible-to-hit overflow merge condition, that still hit some
>   folks very rarely (Junichi)

Hmm. This sounded intriguing, so I looked at it.

It sounds like the 32-bit "bi_size" overflowed, which is one of the
things that bio_full() checks for.

However.

Looking at the *users* of bio_full(), it's not obvious that everything
is ok. For example, in __bio_add_pc_page(), the code does that

        if (((bio->bi_iter.bi_size + len) >> 9) > queue_max_hw_sectors(q))
                return 0;

*before* checking for the overflow condition.

So it could cause that bio_try_merge_pc_page() to be done despite the
overflow, and happily that path ends up having the bio_full() test
later anyway, but it does look a bit worrisome.

There's also __bio_add_page(), which does have a WARN_ON_ONCE(), but
then goes on and does the bi_size update regardless. Hmm.. It does
look like all callers either check bio_full() before, or do it with a
newly allocated bio.

             Linus
