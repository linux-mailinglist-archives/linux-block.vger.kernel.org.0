Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E97811C37F
	for <lists+linux-block@lfdr.de>; Thu, 12 Dec 2019 03:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfLLCrq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 11 Dec 2019 21:47:46 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34405 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbfLLCrp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 21:47:45 -0500
Received: by mail-lf1-f66.google.com with SMTP id l18so478946lfc.1
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 18:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mHahO8LZCdU8zaS7EVF3B7S7ImGonfhaVfJ1tDELB24=;
        b=HQtj4NOC4GpXxt0IO2bvTeez5WRIJN4iBxbju4l+SfUr9aGQjQQVxEEqv0iSvAH9Cf
         9oCv9CE4ffHGIPUk2jakyqwdkFRFRmmhpkingwTTi0fiZ9fYFLy2E+IJnHkXNmeji7HD
         t9R7bmUbOJQIYUbypH6AG8tdoLgT7EDiX9sBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mHahO8LZCdU8zaS7EVF3B7S7ImGonfhaVfJ1tDELB24=;
        b=kvUK/E7VIF+6bFVrWbh3ncXHUXUQ7bsEide3BgVGy8cspATWccFy9JxnnYa0Ubm0Xm
         WGa9t3YIHXbt9rFV5NQ4bW572nQ2jexP6PiaTOjb6eVTNlqiCwtmi3FMG4nMrIf4hB5S
         UsiGv6rHPSanliiHhZqwVdyZ6e8ue4SuiUBpO4IfvFNfOGsfwVD0zriqerFNlyRhOJlg
         mJB4YerrY4OWpjCdqiFvks5z2GYxYFhpySIDGu8tqS2871/Y+4od67QRK5ajr8lMGSM8
         nu8hnz2Wpi5r3xvVoFFax1TD7zk7ewsMROkTdnaOBmKc5fybokAPbG2bpz40n55nyRi7
         ttvQ==
X-Gm-Message-State: APjAAAUiqyjMJexLLUTmUhNbLJT49jXKgKZCq2mAYTDg4aWbsveEkFZ7
        6tqCfSiaGPKJRQyR/2tAhKOZ0SyoMMw=
X-Google-Smtp-Source: APXvYqyloDubZws/TaOCbZ09LC03KYJIBaKadRt/Du61TPXSfLr4G1HeNazha1NJukEAfwtS5Phpmg==
X-Received: by 2002:a19:f619:: with SMTP id x25mr4110668lfe.146.1576118863327;
        Wed, 11 Dec 2019 18:47:43 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id b63sm2061600lfg.79.2019.12.11.18.47.41
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 18:47:42 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id 203so434382lfa.12
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 18:47:41 -0800 (PST)
X-Received: by 2002:a19:4351:: with SMTP id m17mr4341762lfj.61.1576118861439;
 Wed, 11 Dec 2019 18:47:41 -0800 (PST)
MIME-Version: 1.0
References: <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk> <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
 <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk> <CAHk-=wg=hHUFg3i0vDmKEg8HFbEKquAsoC8CJoZpP-8_A1jZDA@mail.gmail.com>
 <1c93194a-ed91-c3aa-deb5-a3394805defb@kernel.dk> <CAHk-=wj0pXsngjWKw5p3oTvwkNnT2DyoZWqPB+-wBY+BGTQ96w@mail.gmail.com>
 <d8a8ea42-7f76-926c-ae9a-d49b11578153@kernel.dk> <CAHk-=whtf0-f5wCcSAj=oTK2TEaesF43UdHnPyvgE9X1EuwvBw@mail.gmail.com>
 <20191212015612.GP32169@bombadil.infradead.org>
In-Reply-To: <20191212015612.GP32169@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Dec 2019 18:47:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjr1G0xXDs7R=2ZAB=YSs-WLk4GsVwLafw+96XVwo7jyg@mail.gmail.com>
Message-ID: <CAHk-=wjr1G0xXDs7R=2ZAB=YSs-WLk4GsVwLafw+96XVwo7jyg@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 11, 2019 at 5:56 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> It _should_ be the same order of complexity.  Since there's already
> a page in the page cache, xas_create() just walks its way down to the
> right node calling xas_descend() and then xas_store() does the equivalent
> of __radix_tree_replace().  I don't see a bug that would make it more
> expensive than the old code ... a 10GB file is going to have four levels
> of radix tree node, so it shouldn't even spend that long looking for
> the right node.

The profile seems to say that 85% of the cost of xas_create() is two
instructions:

# lib/xarray.c:143:     return (index >> node->shift) & XA_CHUNK_MASK;
        movzbl  (%rsi), %ecx    # MEM[(unsigned char *)node_13],
MEM[(unsigned char *)node_13]
...
# ./include/linux/xarray.h:1145:        return
rcu_dereference_check(node->slots[offset],
# ./include/linux/compiler.h:199:       __READ_ONCE_SIZE;
        movq    (%rax), %rax    # MEM[(volatile __u64 *)_80], <retval>

where that first load is "node->shift", and the second load seems to
be just the node dereference.

I think both of them are basically just xas_descend(), but it's a bit
hard to read the several levels of inlining.

I suspect the real issue is that going through kswapd means we've lost
almost all locality, and with the random walking the LRU list is
basically entirely unordered so you don't get any advantage of the
xarray having (otherwise) possibly good cache patterns.

So we're just missing in the caches all the time, making it expensive.

              Linus
