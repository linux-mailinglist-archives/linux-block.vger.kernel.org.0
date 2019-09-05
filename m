Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8995CAAE41
	for <lists+linux-block@lfdr.de>; Fri,  6 Sep 2019 00:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbfIEWQV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 5 Sep 2019 18:16:21 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:44820 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730995AbfIEWQV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Sep 2019 18:16:21 -0400
Received: by mail-lf1-f41.google.com with SMTP id y4so3311262lfe.11
        for <linux-block@vger.kernel.org>; Thu, 05 Sep 2019 15:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3+bS8S77AzTpTBzzxsdlLs0HnCbtRjNnmkiZK0MPy0c=;
        b=LbASCsGx0k6udtd2AsgFeBhmCaCLrlsklx+62iSSE5Gkytkq0WN1acnDpFn5oCNEQS
         KMkfsxyWBngO5Ing5S64rk5RN/Socr904CmKtCx01r5GqFjCKXQfIr7B9uXv9DslB2br
         7qADnXCimEFjoVvgCL5m3EkgAFlL+VHV2J5FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3+bS8S77AzTpTBzzxsdlLs0HnCbtRjNnmkiZK0MPy0c=;
        b=EMff2R4oQ+u/iAE0EhKMu7oC6VNC6ehqMtcmxl2l+EXboDNohiBJ4JIjqewbFPpB2z
         JCdYQH0UOJbaWZOi08goZUuiE9btkbeJf1PttHCecqsMp+ntoQKmWN/EcdMDa1/Gqmaf
         ce9ryqDgwLutumEAKfI+bGtkl2G2j2oF+G2/ABu+Sm4EfmdJhY87Yczjr7pwFcX//aLB
         Nwa4pg54b5joSZRf1EMQq1PiIeTlBKzaJKXnAYVOUGhkoP09mLsUckoRqggAdRGQiLOf
         7UdFnRpl5ikG8ZA1Vu62fW5YkOowvQWrETMePzF4y3jKrSDPzwMmG90SO+zCe9Bq8Co5
         FMzQ==
X-Gm-Message-State: APjAAAVPu9IQnjv8VKgR03THv0IF89s1Owq9NGG2HW0tFVh6QHKV2Kny
        pQrCB8bsBdSFGlea1n6Aa4JaVDZF4bI=
X-Google-Smtp-Source: APXvYqz1uIHdItuGSvYJptY8btdm5sg2rNdEBLQMrIzPkwevk+RcctzSoe2BnvM8P8t9JZFTnbk7vQ==
X-Received: by 2002:a19:c709:: with SMTP id x9mr4106303lff.20.1567721779207;
        Thu, 05 Sep 2019 15:16:19 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id o17sm671366ljd.9.2019.09.05.15.16.18
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 15:16:18 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id u29so3323801lfk.7
        for <linux-block@vger.kernel.org>; Thu, 05 Sep 2019 15:16:18 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr3910741lfh.29.1567721338167;
 Thu, 05 Sep 2019 15:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk>
 <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com>
 <17703.1567702907@warthog.procyon.org.uk> <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com>
 <CAKCoTu7ms_Mr-q08d9XB3uascpzwBa5LF9JTT2aq8uUsoFE8aQ@mail.gmail.com>
 <CAHk-=wjcsxQ8QB_v=cwBQw4pkJg7pp-bBsdWyPivFO_OeF-y+g@mail.gmail.com> <5396.1567719164@warthog.procyon.org.uk>
In-Reply-To: <5396.1567719164@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Sep 2019 15:08:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgbCXea1a9OTWgMMvcsCGGiNiPp+ty-edZrBWn63NCYdw@mail.gmail.com>
Message-ID: <CAHk-=wgbCXea1a9OTWgMMvcsCGGiNiPp+ty-edZrBWn63NCYdw@mail.gmail.com>
Subject: Re: Why add the general notification queue and its sources
To:     David Howells <dhowells@redhat.com>
Cc:     Ray Strode <rstrode@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Ray, Debarshi" <debarshi.ray@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 5, 2019 at 2:32 PM David Howells <dhowells@redhat.com> wrote:
>
>  (1) /dev/watch_queue just implements locked-in-memory buffers.  It gets you
>      no events by simply opening it.

Cool. In-memory buffers.

But I know - we *have* one of those. There's already a system call for
it, and has been forever. One that we then extended to allow people to
change the buffer size, and do a lot of other things with.

It's called "pipe()". And you can give the writing side to other user
space processes too, in case you are running an older kernel that
didn't have some "event pipe support". It comes with resource
management, because people already use those things.

If you want to make a message protocol on top of it, it has cool
atomicity guarantees for any message size less than PIPE_BUF, but to
make things simple, maybe just say "fixed record sizes of 64 bytes" or
something like that for events.

Then you can use them from things like perl scripts, not just magical
C programs.

Why do we need a new kind of super-fancy high-speed thing for event reporting?

If you have *so* many events that pipe handling is a performance
issue, you have something seriously wrong going on.

So no. I'm not interested in a magical memory-mapped pipe that is
actually more limited than the real thing.

                  Linus
