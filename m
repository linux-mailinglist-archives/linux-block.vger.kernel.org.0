Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67749174E9F
	for <lists+linux-block@lfdr.de>; Sun,  1 Mar 2020 18:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgCARBI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 1 Mar 2020 12:01:08 -0500
Received: from hosting.gsystem.sk ([212.5.213.30]:38534 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgCARBI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 1 Mar 2020 12:01:08 -0500
Received: from [192.168.0.253] (rev-81-92-251-198.radiolan.sk [81.92.251.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id B8DC07A0198;
        Sun,  1 Mar 2020 18:01:05 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH 00/10] floppy driver cleanups (deobfuscation)
Date:   Sun, 1 Mar 2020 18:01:03 +0100
User-Agent: KMail/1.9.10
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Denis Efremov <efremov@linux.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-block" <linux-block@vger.kernel.org>
References: <20200224212352.8640-1-w@1wt.eu> <202003010019.14391.linux@zary.sk> <20200301064601.GA24037@1wt.eu>
In-Reply-To: <20200301064601.GA24037@1wt.eu>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202003011801.03950.linux@zary.sk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sunday 01 March 2020 07:46:01 Willy Tarreau wrote:
> On Sun, Mar 01, 2020 at 12:19:14AM +0100, Ondrej Zary wrote:
> > On Saturday 29 February 2020 16:58:11 Linus Torvalds wrote:
> > > On Sat, Feb 29, 2020 at 8:14 AM Willy Tarreau <w@1wt.eu> wrote:
> > > > So if you or Denis think there's some value in me continuing to
> > > > explore one of these areas, I can continue, otherwise I can simply
> > > > resend the last part of my series with the few missing Cc and be done
> > > > with it.
> > >
> > > It's fine - this driver isn't worth spending a ton of effort on.
> > >
> > > The only users are virtualization, and even they are going away
> > > because floppies are so small, and other things have become more
> > > standard anyway (ie USB disk) or easier to emulate (NVMe or whatever).
> > >
> > > So I suspect the only reason floppy is used even in that area is just
> > > legacy "we haven't bothered updating to anything better and we have
> > > old scripts and images that work".
> > >
> > >               Linus
> >
> > There are real users with real floppy drives out there.
>
> OK thanks for the feedback. Then I'll continue the minimum cleanups to
> try to focus on maintainability and on the principle of least surprise,
> and I'll have a quick look at the possible simplifications brought by
> the limitation to one FDC, in case that really helps.

Thank you very much for the work.

I haven't ever seen a machine with more than single FDC so that case might be 
hard to test. There are some ISA FDCs with configurable I/O addresses (maybe 
I have one of them somewhere) but they might not work properly together with 
on-board super I/O FDCs.
The most common case - one FDC with at most two drives should be enough for 
the modern simplified driver.

-- 
Ondrej Zary
