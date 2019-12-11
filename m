Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0F3511BECD
	for <lists+linux-block@lfdr.de>; Wed, 11 Dec 2019 22:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfLKVEE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 11 Dec 2019 16:04:04 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:39973 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfLKVEE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 16:04:04 -0500
Received: by mail-qv1-f68.google.com with SMTP id k10so39696qve.7
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 13:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R2PsJGyUpT/iCCg3Yu1TE62l+3HqSX40NgPM4bJnXXE=;
        b=ns0LNqCK0sYLbEaXEgQbTfsQKmSRApUdDpdU2giNA2frUZuVy2AITBGjQhQCZ5XAa0
         OHf1XkkRoh7S2lLFqDTDbkqwjISEBUfNG24iQrcfZZ1haypZdUbUWHPjIxpK/bkmMBep
         B4hRCgqs/F0xu5pP7Gg7dF4ox3R0hHZIzlLeI9dfHw1fXzvWshQvz/0yNkyv/pvgKa9P
         q0uHYaraQXOIRT5ZpD26hDr+If9EUKfw1sBVqVMHKNM+6OmHzWl7vfyZfrbAAA0iPFVF
         aIHDbRd/baN0rTREQXjK3D4I2V3SvB/4naasUMiqpOrxucdePn9SUxooXkbrbtKXECHz
         JI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R2PsJGyUpT/iCCg3Yu1TE62l+3HqSX40NgPM4bJnXXE=;
        b=B9F9cTNkK80cb9oURurCWDvHlBFHx51tXK/WWW6ucwTx/3/Fu6G8X0hs+/izT22jpU
         N5rQ2fk6G8OZAhuj84j0QgjRRjTJxvHU5aGN8LQFNm07ehQoyZ9G/B5fS5BJaJ6wn7dT
         0OYWzcts0odMU4CvUb/B2YwuwEl8X9gOFY+gn6b9B50iFUQB+Ev/k0l1AnqG77SESuvo
         XEne0RfLVIoPZWrFD7ixx3B+r/3e55CqWvnV1ugCTGtjFd1a+yQKf18tA3hHG7nMPLtG
         Lqq5EgtAwqLzCDUTe3ttRzpRGz5y1xcXMuJnGfLNCoEmwOniHLQzKXRG96Rx3a1l9M5S
         7a2A==
X-Gm-Message-State: APjAAAX2lnHqyp94jSu6hjHYQHSV4JXoRU1OCIs2EsSDLsQCxUgtY+ic
        I4p5E1iJ9WMSLG3CTVFy37owaw==
X-Google-Smtp-Source: APXvYqxq7v6drlnORg/gNcxlU4z0/vNmm+oh4UJTRbqnR5xBG4N1pG1N3WEFTCGN7D9u37ud9MdVmg==
X-Received: by 2002:a0c:e14f:: with SMTP id c15mr4886674qvl.169.1576098243448;
        Wed, 11 Dec 2019 13:04:03 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::151b])
        by smtp.gmail.com with ESMTPSA id h34sm1307215qtc.62.2019.12.11.13.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 13:04:02 -0800 (PST)
Date:   Wed, 11 Dec 2019 16:04:01 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
Message-ID: <20191211210401.GA158617@cmpxchg.org>
References: <20191211152943.2933-1-axboe@kernel.dk>
 <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk>
 <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk>
 <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 11, 2019 at 12:18:38PM -0800, Linus Torvalds wrote:
> On Wed, Dec 11, 2019 at 12:08 PM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > $ cat /proc/meminfo | grep -i active
> > Active:           134136 kB
> > Inactive:       28683916 kB
> > Active(anon):      97064 kB
> > Inactive(anon):        4 kB
> > Active(file):      37072 kB
> > Inactive(file): 28683912 kB
> 
> Yeah, that should not put pressure on some swap activity. We have 28
> GB of basically free inactive file data, and the VM is doing something
> very very bad if it then doesn't just quickly free it with no real
> drama.

I was looking at this with Jens offline last week. One thing to note
is the rate of IO that Jens is working with: combined with the low
cache hit rate, it was pushing upwards of half a million pages through
the page cache each second.

There isn't anything obvious sticking out in the kswapd profile: it's
dominated by cache tree deletions (or rather replacing pages with
shadow entries, hence the misleading xas_store()), tree lock
contention, etc. - all work that a direct reclaimer would have to do
as well, with one exceptions: RWC_UNCACHED doesn't need to go through
the LRU list, and 8-9% of kswapd cycles alone are going into
physically getting pages off the list. (And I suspect part of that is
also contention over the LRU lock as kswapd gets overwhelmed and
direct reclaim kicks in).

Jens, how much throughput difference does kswapd vs RWC_UNCACHED make?
