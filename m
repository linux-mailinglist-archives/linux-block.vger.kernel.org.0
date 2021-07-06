Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E31A3BDBDB
	for <lists+linux-block@lfdr.de>; Tue,  6 Jul 2021 19:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhGFRE6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 6 Jul 2021 13:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhGFRE5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Jul 2021 13:04:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D935C061574;
        Tue,  6 Jul 2021 10:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uJIT3dm6mx3Tqmh6M5+HoZYsvVKHFl5euHMB7oy41lg=; b=tU9XorQJwosNGcInsMhMDI0hR4
        9VgUdFSwceciUVrd8cX+FczNOAKB7BTLNjnx5uaFcVD1SLOocyF72gE7OHifR+K90VH75X0UCviBQ
        aVaIwn+V1d6EuFCD2vhRQIaf8dQV9p3r+ugkgBh0HueV3c+Dw41nSaH91RKazYjfExBugQ4wf0BiX
        HvtPa1Zy3FK9zNlJLg7FA73/NrTt8rTRVVb3hYlS6bbfEa1c3KRHm3mu/ScqZXc9BcBycCDIxNJ9V
        smCrIYIwy2NN072VFAkHsXwjXRo8Wn8Zf1dSpAxQ8N352ka9cWsZXKsZYxMNlGgAiXkVATU7FoLMY
        0awvPsqA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0oS2-00Bb1Z-Tb; Tue, 06 Jul 2021 17:01:41 +0000
Date:   Tue, 6 Jul 2021 18:01:38 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Bernardo Innocenti <bernie@develer.com>,
        "torvalds@linux-foundation.org Abd-Alrhman Masalkhi" 
        <abd.masalkhi@gmail.com>
Cc:     hch@infradead.org, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.carpenter@oracle.com,
        linux-parisc@vger.kernel.org
Subject: div_u64/do_div stack size usage, was Re: [v3] block: Removed a
 warning while compiling with a cross compiler for parisc
Message-ID: <YOSMct1YHs++E1vt@infradead.org>
References: <YORh3XGNiRKzjDbS@infradead.org>
 <20210706153054.145461-1-abd.masalkhi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706153054.145461-1-abd.masalkhi@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 06, 2021 at 05:30:54PM +0200, Abd-Alrhman Masalkhi wrote:
> Thank you for your comment, the div_u64 function is called 5 times
> inside diskstats_show function, so I have made a test case; I have
> replaced one call with a constant number then I have compiled the 
> kernel, the result was instead of emitting "the frame size of 1656
> bytes is larger than 1280 bytes" warning, it has emitted "the frame
> size of 1328 bytes is larger than 1280 bytes" warning, so I came to the
> conclusion that each call to div_u64 will add 328 bytes to the stack
> frame of diskstats_show function, since it is an inlined function. so I
> thought it might be the solution that to preventing div_u64 to be
> inlined in diskstats_show function.

Adding a bunch of relevant parties to the CC list - any idea how we
can make the generic do_div / div_u64 not use up such gigantic amounts
of stack?
