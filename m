Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2B83DBEE3
	for <lists+linux-block@lfdr.de>; Fri, 30 Jul 2021 21:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhG3TSe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 30 Jul 2021 15:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbhG3TSd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jul 2021 15:18:33 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AF0C061765
        for <linux-block@vger.kernel.org>; Fri, 30 Jul 2021 12:18:28 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j1so16640242pjv.3
        for <linux-block@vger.kernel.org>; Fri, 30 Jul 2021 12:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GxQ+HQk3cdftqAN6ekEINRB7/ckK/Y3btr+5Ktub3O8=;
        b=WS5dYESChuBnCxT0C846oXNdS39ELe0+GVYff+8CDiB/+f/gvQwIUAsaHdpyWtgQI9
         Ksdmzxs2AfVddKWJDuxET2t1XvdH74XtC3HtYpRTl4M2aix9P85mPUTWk0m4skcu2rUY
         hkzUA5m/uNIuqcBh7EgcpFhsleAuHbj8eKL2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GxQ+HQk3cdftqAN6ekEINRB7/ckK/Y3btr+5Ktub3O8=;
        b=szL6lgPVZxdonZ8zQP85gtg466tc9SLEMjdVzLalA1sNC5FxCyCmXcFbBAzKcGDwft
         hRa+cUJd3JhRX6X+J2pJlL+CHxeBzCnYxPIUiJi0fDMKPeTMvmKKkzU8lXItXmufQRH9
         CfHUx726iq1ZV3UjOJjAWhvbkIbzPpgTTzl7CAjRB8vs8Gxn2WfJJn9tuhxgsgem+4gd
         nRaOsA0CLG2rmoue1Xim7tJkXe2B7vyKElDp/0baXM4Gdjka2ctsLvrrcjAwHJBTKFFo
         peJRvjQd4iWrYMyF9BOdnqyUMZGPLoUa7BteXr1xpxwf/T340J+iDkoiYCNJnDVGSo06
         2Zgw==
X-Gm-Message-State: AOAM533FPs23/7DL2Hua11nhF4DGyQ9lN6Z1OltIQxSw6YYQ+sZ0goO+
        gvzur9AXwzereC0OosFM5ekDlA==
X-Google-Smtp-Source: ABdhPJyCK3+AR/s/Pq/itPZjFA3DL77BZcO4l8s7xQqT+jnGem6TdAj1wqpo6cwifM6sSr5c8f1XQQ==
X-Received: by 2002:a65:498a:: with SMTP id r10mr500564pgs.7.1627672708339;
        Fri, 30 Jul 2021 12:18:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 26sm3040727pjj.27.2021.07.30.12.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 12:18:27 -0700 (PDT)
Date:   Fri, 30 Jul 2021 12:18:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, dsterba@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        nborisov@suse.com
Subject: Re: [PATCH 01/64] media: omap3isp: Extract struct group for memcpy()
 region
Message-ID: <202107301217.46EA9DA@keescook>
References: <20210728091434.GQ1931@kadam>
 <c52a52d9-a9e0-5020-80fe-4aada39035d3@acm.org>
 <20210728213730.GR5047@suse.cz>
 <YQJDCw01gSp1d1/M@kroah.com>
 <20210729082039.GX25548@kadam>
 <202107291952.C08EAE039B@keescook>
 <20210730083845.GD5047@suse.cz>
 <20210730090054.GX1931@kadam>
 <202107300937.C7016A82@keescook>
 <CAKwvOdmtKszUS0-OyGMHuhqjyXQC_283KOQOouWWtimYCvsAoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmtKszUS0-OyGMHuhqjyXQC_283KOQOouWWtimYCvsAoA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 30, 2021 at 10:08:03AM -0700, Nick Desaulniers wrote:
> On Fri, Jul 30, 2021 at 9:44 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Jul 30, 2021 at 12:00:54PM +0300, Dan Carpenter wrote:
> > > On Fri, Jul 30, 2021 at 10:38:45AM +0200, David Sterba wrote:
> > > > Then is explicit memset the only reliable way accross all compiler
> > > > flavors and supported versions?
> > > >
> > >
> > > The = { } initializer works.  It's only when you start partially
> > > initializing the struct that it doesn't initialize holes.
> >
> > No, partial works. It's when you _fully_ initialize the struct where the
> > padding doesn't get initialized. *sob*
> 
> I'm pretty sure that this has more to do with whether or not the
> compiler applies SROA then observes uses of the individual members or
> not.

Ultimately, it's just not consistent, so thank goodness for
-ftrivial-auto-var-init=zero. :)

-- 
Kees Cook
