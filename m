Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CB21CC64B
	for <lists+linux-block@lfdr.de>; Sun, 10 May 2020 05:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgEJDgk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 9 May 2020 23:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726067AbgEJDgk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 9 May 2020 23:36:40 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FE1C061A0C
        for <linux-block@vger.kernel.org>; Sat,  9 May 2020 20:36:40 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id r17so1524905lff.9
        for <linux-block@vger.kernel.org>; Sat, 09 May 2020 20:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C3sNE7/R3wLoLlTARZrhafNKuUEQMhRiGUVOrVB7ud4=;
        b=bP4cgr5RHFUE4qTztEKNwBif3xwzOOTJwgJJNzbcSVARklXOsoYWP5EhnQ6fIsYs5h
         YDDsUNnicR+sfKEEvmcfYEaed4zYCEOyEszhKQT6rNsOuNixbyM9LE1raanDJ8Vhr0wx
         pSsN64JMNxcRs2VZqlJmj0GdGcexrg2g4z9x0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C3sNE7/R3wLoLlTARZrhafNKuUEQMhRiGUVOrVB7ud4=;
        b=c0BSL31RT2AzxXC9L2IaWHred24VUbHtp1tK+Xv6Qq9+46YLWn1hmbqzaYi5PHENAG
         skialhA3Evq75ACWCEYtn6g4nkLGAhG4Fcd/wqE9gD06U/Du+gh0bIM5PMjXqzg4c99k
         ++sE66IL/Cd7lCIUw7cqr7BEQGFtx1TkToHogqV6eqstKAeQUwhTHP3RXtR3ZnzO9QOD
         wiGpaQGhGmyV9Gt++KF8boshF146mL8rH3Ub6EcTCKSUYjIM0NoLlH98iP33VaIdOND+
         3ofSUP+CrOMif4Iwc+FTqgne6i6iexWloULEydC7iRk48q3wx8sZXMloMEMrZswOuOv1
         zMmQ==
X-Gm-Message-State: AOAM531e0/fUcwOovFWBLBwXFBLtCDH73rlu0kwEVcGPdDwl2Z46bFGF
        U2r1sFKxg65O6K1I42s43mKWNKqve00=
X-Google-Smtp-Source: ABdhPJxwgJNGMzjMzThYhKk+f8SB/q0ItREKBCFHemVwM08oO7yPIH0PAN4DWnkLcDVbzpHD2fsUHQ==
X-Received: by 2002:a19:700b:: with SMTP id h11mr6703302lfc.62.1589081798005;
        Sat, 09 May 2020 20:36:38 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id i76sm5916469lfi.83.2020.05.09.20.36.36
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 20:36:37 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id z22so4602483lfd.0
        for <linux-block@vger.kernel.org>; Sat, 09 May 2020 20:36:36 -0700 (PDT)
X-Received: by 2002:a19:6e4e:: with SMTP id q14mr6527170lfk.192.1589081796547;
 Sat, 09 May 2020 20:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <98383cfe-ef17-45f3-a799-9eff8fc0f2fd@kernel.dk>
In-Reply-To: <98383cfe-ef17-45f3-a799-9eff8fc0f2fd@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 May 2020 20:36:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wheALnWv1jaZM9yWhyrD_2nWppt96UYCQNE6V-DN_gGuA@mail.gmail.com>
Message-ID: <CAHk-=wheALnWv1jaZM9yWhyrD_2nWppt96UYCQNE6V-DN_gGuA@mail.gmail.com>
Subject: Re: [GIT PULL v2] Block fixes for 5.7-rc5
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 9, 2020 at 6:33 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Let's try this again... BFQ was missing a header, I fixed that up.

The fix looked trivial to me. That wasn't what worries me.

Why did you send me something that was clearly NOT TESTED AT ALL.

If it hadn't even gotten build-testing, what _did_ it get?

The fact that it now builds doesn't make me much happier.

Why should I believe that this clearly totally untested pull request
is now any good?

Why should I believe that your _future_ pull requests are any good,
when they clearly have absolutely _zero_ testing at all?

Jens, in case you didn't catch on, this is a BIG PROBLEM.

Sending me completely untested crap is a bigger deal than "let's just
polish the crap until it at least compiles".

What have you done to make sure this doesn't happen again?

             Linus
