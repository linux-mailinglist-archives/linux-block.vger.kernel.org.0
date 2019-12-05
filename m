Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10D91114571
	for <lists+linux-block@lfdr.de>; Thu,  5 Dec 2019 18:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfLERNF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 5 Dec 2019 12:13:05 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39891 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbfLERNE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Dec 2019 12:13:04 -0500
Received: by mail-lf1-f67.google.com with SMTP id c9so2553417lfi.6
        for <linux-block@vger.kernel.org>; Thu, 05 Dec 2019 09:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zYNLY1IlQbFxutIFweWCQvjwN9b0IsGYV2okK9HrfFg=;
        b=Q0FUaDCgejnj2j913m9DkZ5BcPyxfvWCsvBxLXqstFY2bocRU9mYGGdVT6TyixAaF9
         S2hdwaxlIrLjm/VudylZUBLif/OSS4AVyaDGMpzqZdSB/9DnkfX4SEUoI9oj/pbE/ewR
         2kNMP8DNxG23lhz/9/1l0TfZQjJpzTexlyrHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zYNLY1IlQbFxutIFweWCQvjwN9b0IsGYV2okK9HrfFg=;
        b=h+XiXLG2tHt/NNa20anVVQBv5N11V2dtvJ9Z8aMs7bVsvOgnwgRhdMXa36gVrMMhbv
         EqUV1C1E3rVzR5ZSeoM+dFBfzueyIy51m8yLL/7/gBuZCLyoojd/ExAID+RCHnVstpN6
         rlh2MGc57kq4PPnF/R1vSO0DePN0WyJaV4TK78h7k+/i000GgJO6LHuzmQFyzLKA/3Om
         VJIQouPG2QRPE631/oYtXyycr/K6PiEzapvO4CmTC5SO1j5Ro+yLYU1v4WBatM5VKjOk
         g6FVAJFqEnrhOAf40KhhF84+w7Sv6RvmgaYujbEKFHjCB7kR+HSZJ+W9LCttFDzI4pwp
         2Jeg==
X-Gm-Message-State: APjAAAWR69K2O/pWjHKMcZBG5T3TZ9eNk3k4WXNUjgZs+p4ZRxcUSVYe
        79tW217ellpurtKUAAKxh1UhEelkTeI=
X-Google-Smtp-Source: APXvYqyoY/DKv82nUGTdHeoxXQDNwb7NUFAceX978aANHl3YBfVpxQyumCdqxRpkO6cpsC6Eoov1PQ==
X-Received: by 2002:ac2:43a7:: with SMTP id t7mr5374034lfl.125.1575565980988;
        Thu, 05 Dec 2019 09:13:00 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id h19sm5271894ljl.57.2019.12.05.09.12.59
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 09:12:59 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id f15so2244421lfl.13
        for <linux-block@vger.kernel.org>; Thu, 05 Dec 2019 09:12:59 -0800 (PST)
X-Received: by 2002:a19:4351:: with SMTP id m17mr6095833lfj.61.1575565978909;
 Thu, 05 Dec 2019 09:12:58 -0800 (PST)
MIME-Version: 1.0
References: <31452.1574721589@warthog.procyon.org.uk> <20191205125826.GK2734@twin.jikos.cz>
 <1593.1575554217@warthog.procyon.org.uk>
In-Reply-To: <1593.1575554217@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Dec 2019 09:12:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgwwJ+ZEtycujFdNmpS8TjwCYyT+oHfV7d-GekyaX91xg@mail.gmail.com>
Message-ID: <CAHk-=wgwwJ+ZEtycujFdNmpS8TjwCYyT+oHfV7d-GekyaX91xg@mail.gmail.com>
Subject: Re: [GIT PULL] pipe: Notification queue preparation
To:     David Howells <dhowells@redhat.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 5, 2019 at 5:57 AM David Howells <dhowells@redhat.com> wrote:
>
> David Sterba <dsterba@suse.cz> wrote:
>
> > [<0>] pipe_write+0x1be/0x4b0
>
> Can you get me a line number of that?  Assuming you've built with -g, load
> vmlinux into gdb and do "i li pipe_write+0x1be".

If the kernel is built with debug info (which you need for the gdb
command anyway), it's much better to just use

   ./scripts/decode_stacktrace.sh

which gives all the information for the whole backtrace.

It would be interesting to hear if somebody else is waiting on the
read side too.

             Linus
