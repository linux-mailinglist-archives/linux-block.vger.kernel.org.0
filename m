Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94493D7C3A
	for <lists+linux-block@lfdr.de>; Tue, 27 Jul 2021 19:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbhG0RfV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 27 Jul 2021 13:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhG0RfU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 13:35:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0F1C061757;
        Tue, 27 Jul 2021 10:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CtJSDCNVg4ODCFxbc9s2lq4PD4KRlQlX7HvhdKxAPe4=; b=Kh3HFN8R3JopyQjHnjOaWTv1Bx
        GbJJ48B22E72i9GZFvbYYQSp5zlOhQuGMjHhnAjVnPgNbfBpelQqOnVfokNF3bbTBm0SbopxiJ9Xm
        SS/ySejntjT9DUbQ83gFpLJMXslPl++vocF8ejRUgYDn1k/UFJcff+oT6S6ddk4UTpEVWw1oNOWOI
        jfg8qOLmPvcH/HXShcJGEHEpuaktY6hr1Tuf2ldpcTu/qijv26xjsFhWUo5kHDkSx+vPn63SNaLOs
        iS1+7TZuiCGZpGUWmoMSMCOvAHLPhVfh/hl0Jf+J+RKbfadvZwb3EVJ2mIZblohXtOIJCLq+35zth
        dTaQ9lhw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8Qz0-00FaLj-8x; Tue, 27 Jul 2021 17:35:10 +0000
Date:   Tue, 27 Jul 2021 10:35:10 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>
Cc:     akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        rafael@kernel.org, axboe@kernel.dk, tj@kernel.org, mbenes@suse.com,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        jikos@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] zram: fix deadlock with sysfs attribute usage and
 module removal
Message-ID: <YQBDzoSohQ0wbLN4@bombadil.infradead.org>
References: <20210703001958.620899-1-mcgrof@kernel.org>
 <20210703001958.620899-3-mcgrof@kernel.org>
 <YPgFGd+FZQZWODY7@kroah.com>
 <20210722221705.kyrdkpt6fwf5k56o@garbanzo>
 <YPqk5WCBgvNQzq4S@kroah.com>
 <20210723174919.ka3tzyre432uilf7@garbanzo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723174919.ka3tzyre432uilf7@garbanzo>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 23, 2021 at 10:49:19AM -0700, Luis Chamberlain wrote:
> We are talking about sysfs files and you're argument is that
> try_module_get() should lock the module, and so cannot be used
> in sysfs files. My point is that such module lock is inferred:
> 
> 1) Sysfs files are created by a module, that same module is responsible
>    for removing the same sysfs files.
> 2) The module can only be removed and gone, once *all* sysfs files are
>    removed first.
> 3) If any of the module's sysfs files are present the module must
>    still be present
> 4) kernfs ensures that if a file is opened the file will not be
>    removed until any pending operation completes
> 5) If a sysfs file is used to write something, that means the
>    sysfs file has not yet been removed, and we know it will
>    remain in existance throughout its entire operation
> 6) When a sysfs file operation is being run, the module must
>    always exist

Greg,

I'm inclined to believe my original generic solution would be better
again [0]. Specially since we can drop the dev_type_get() / dev_type_put()
stuff.

Thoughts?

[0] https://lore.kernel.org/linux-block/20210401235925.GR4332@42.do-not-panic.com/

  Luis
