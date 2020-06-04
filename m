Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9338E1EE723
	for <lists+linux-block@lfdr.de>; Thu,  4 Jun 2020 16:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgFDO7n (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 4 Jun 2020 10:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729201AbgFDO7n (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Jun 2020 10:59:43 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BE5C08C5C2
        for <linux-block@vger.kernel.org>; Thu,  4 Jun 2020 07:59:42 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x207so3370857pfc.5
        for <linux-block@vger.kernel.org>; Thu, 04 Jun 2020 07:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xZR3lWkoYpLFg4eE+Etif6ukCUL5ApBdi/GoHnvWaEk=;
        b=TupHTdygAigywhS3pB8tAlBUKta4lXvoAYH4dzNzhrASd2l3DGn01fOXPA/fx+ddwx
         e63Z0EnMX9EmBApvSxhudimZg0Kyu1Ran7gh+CyYHPG3fZ0CjgSq6NhbXpLphCrF+Ouq
         t2GxHonz+RRUwsB+KYTkj8rNjo2/BKZIMEe8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xZR3lWkoYpLFg4eE+Etif6ukCUL5ApBdi/GoHnvWaEk=;
        b=nDR0uM8FbJdmnTV/pbIGvXSStsQEXiaH0UK8M7VXhiA0LI7RXC0MuCAWhXUZCzRjca
         YRVL2P977ojrnDmbU+TOFJhuRMPl/1iQo814Y+pivGxSN28myu+Rw4f0xnPIiN832k7K
         Xlj/9pycZ+pDVwhxAdBms0fQ19+BtQUfaPRZKIb9YLd9/SM5FI3aH2Q1QGZhUEKCvVlX
         xGQmqBB69jDkwYq4pCwHmJ1P32Pv5VGAPVOGTRZSP9qm+MH/NK9khcMJMavIvzjetSqM
         2c0RoI0HmJDTjM3eEabLRc9HdlxvmXh5AiDXE0b8rnzxJXeiQZP9+Jj82YvZbJuLeTll
         tifw==
X-Gm-Message-State: AOAM530odkKvlEwfA2+S4tdksuT4kutaD42o4uGsQpz2xct7/9e9CrOE
        GgUrpBAfZ8wgmThnduh4bAtdUQ==
X-Google-Smtp-Source: ABdhPJwvM5Okdp4t/lqPdqt9FJOxz3H8PoeKTiCxL62lJBkvY0bVXGWNEvmo0e7yAT0Y8leJzLPW1g==
X-Received: by 2002:a63:d544:: with SMTP id v4mr4979382pgi.60.1591282782325;
        Thu, 04 Jun 2020 07:59:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w65sm4752697pfb.160.2020.06.04.07.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 07:59:41 -0700 (PDT)
Date:   Thu, 4 Jun 2020 07:59:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, x86@kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mm@kvack.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 09/10] treewide: Remove uninitialized_var() usage
Message-ID: <202006040757.0DFC3F28E@keescook>
References: <20200603233203.1695403-1-keescook@chromium.org>
 <20200603233203.1695403-10-keescook@chromium.org>
 <20200604132306.GO6578@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604132306.GO6578@ziepe.ca>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 04, 2020 at 10:23:06AM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 03, 2020 at 04:32:02PM -0700, Kees Cook wrote:
> > Using uninitialized_var() is dangerous as it papers over real bugs[1]
> > (or can in the future), and suppresses unrelated compiler warnings
> > (e.g. "unused variable"). If the compiler thinks it is uninitialized,
> > either simply initialize the variable or make compiler changes.
> > 
> > I preparation for removing[2] the[3] macro[4], remove all remaining
> > needless uses with the following script:
> > 
> > git grep '\buninitialized_var\b' | cut -d: -f1 | sort -u | \
> > 	xargs perl -pi -e \
> > 		's/\buninitialized_var\(([^\)]+)\)/\1/g;
> > 		 s:\s*/\* (GCC be quiet|to make compiler happy) \*/$::g;'
> > 
> > drivers/video/fbdev/riva/riva_hw.c was manually tweaked to avoid
> > pathological white-space.
> > 
> > No outstanding warnings were found building allmodconfig with GCC 9.3.0
> > for x86_64, i386, arm64, arm, powerpc, powerpc64le, s390x, mips, sparc64,
> > alpha, and m68k.
> 
> At least in the infiniband part I'm confident that old gcc versions
> will print warnings after this patch.
> 
> As the warnings are wrong, do we care? Should old gcc maybe just -Wno-
> the warning?

I *think* a lot of those are from -Wmaybe-uninitialized, but Linus just
turned that off unconditionally in v5.7:
78a5255ffb6a ("Stop the ad-hoc games with -Wno-maybe-initialized")

I'll try to double-check with some older gcc versions. My compiler
collection is mostly single-axis: lots of arches, not lots of versions. ;)

> Otherwise the IB bits look ok to me
> 
> Acked-by: Jason Gunthorpe <jgg@mellanox.com>

Thanks!

-- 
Kees Cook
