Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972193DC6A1
	for <lists+linux-block@lfdr.de>; Sat, 31 Jul 2021 17:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbhGaP0A (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 31 Jul 2021 11:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbhGaPZ7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 31 Jul 2021 11:25:59 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B903C061796
        for <linux-block@vger.kernel.org>; Sat, 31 Jul 2021 08:25:53 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso25207791pjb.1
        for <linux-block@vger.kernel.org>; Sat, 31 Jul 2021 08:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rMM6+nPYXY2uiSyyu4uBWYISUK/txh/pCdnfftmwE5I=;
        b=E0SoYgUeBE+ftZKNo9x/ExH0q8CDdIpilft8etS0hsXIxl3+Vlp6pt0MCFF4VHLSjd
         wmGidikllJX4N9GOuxdiKOtBL2OwlFFooSKknT62V/QxawH+fKFq/IN6UkGfthss0Jue
         /LaKbBpm/i7NpiK11ikcOkYrwperY7OevSA6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rMM6+nPYXY2uiSyyu4uBWYISUK/txh/pCdnfftmwE5I=;
        b=AERa8WAuOao+yGS07oemc+xyqkfC+dOz47IjMNehoeB4ySWbRlyeagKUXBVLWwo0pw
         jyMB95D4dBRj8ZpE0mROZTyQBAZQdvBIKtProOsbdkDg7HyQaBo6CGoMfhKf1SU6QM2F
         iGtAGzMuCfQfuAzjZWS1GUoN8qQWD+RVULw5PI/mSa06OZ16pdPeLa0fPw0NIybjyuFd
         c7iwAp9tv/P7Oo7gzmfwlsmEkHJkXDBClH7QWYcP8/xaHZBgnv0kh2o6aTJ4W9HzFC+f
         vlzuutL/AKmpW2jyCLb6Noq0q6khdSzaT50+Eznx26on35/9FdiWm2Yha8R63iyS5q/C
         /xhw==
X-Gm-Message-State: AOAM532sQYM05WdtpW4s25ZL1qTk+V3SYk4aMvifnDLHcvihk2K+1G6s
        HBV0UoLZyHvcW4nvo5nUackVPA==
X-Google-Smtp-Source: ABdhPJwoeVgbbn7dICfcKEt6dw6EQc8t7kiQ+j9S2D0qHZ1VpbfIunOgZUzrdbIveyTtuLa19saudA==
X-Received: by 2002:a63:8948:: with SMTP id v69mr1184969pgd.132.1627745153109;
        Sat, 31 Jul 2021 08:25:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m18sm5745081pjq.32.2021.07.31.08.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 08:25:52 -0700 (PDT)
Date:   Sat, 31 Jul 2021 08:25:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     dsterba@suse.cz, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 47/64] btrfs: Use memset_after() to clear end of struct
Message-ID: <202107310822.31BEB6E543@keescook>
References: <20210727205855.411487-1-keescook@chromium.org>
 <20210727205855.411487-48-keescook@chromium.org>
 <20210728094215.GX5047@twin.jikos.cz>
 <202107281455.2A0753F5@keescook>
 <20210729103337.GS5047@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729103337.GS5047@suse.cz>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 29, 2021 at 12:33:37PM +0200, David Sterba wrote:
> On Wed, Jul 28, 2021 at 02:56:31PM -0700, Kees Cook wrote:
> > On Wed, Jul 28, 2021 at 11:42:15AM +0200, David Sterba wrote:
> > > On Tue, Jul 27, 2021 at 01:58:38PM -0700, Kees Cook wrote:
> > > > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > > > field bounds checking for memset(), avoid intentionally writing across
> > > > neighboring fields.
> > > > 
> > > > Use memset_after() so memset() doesn't get confused about writing
> > > > beyond the destination member that is intended to be the starting point
> > > > of zeroing through the end of the struct.
> > > > 
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > ---
> > > >  fs/btrfs/root-tree.c | 5 +----
> > > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > > > 
> > > > diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> > > > index 702dc5441f03..ec9e78f65fca 100644
> > > > --- a/fs/btrfs/root-tree.c
> > > > +++ b/fs/btrfs/root-tree.c
> > > > @@ -39,10 +39,7 @@ static void btrfs_read_root_item(struct extent_buffer *eb, int slot,
> > > >  		need_reset = 1;
> > > >  	}
> > > >  	if (need_reset) {
> > > > -		memset(&item->generation_v2, 0,
> > > > -			sizeof(*item) - offsetof(struct btrfs_root_item,
> > > > -					generation_v2));
> > > > -
> > > 
> > > Please add
> > > 		/* Clear all members from generation_v2 onwards */
> > > 
> > > > +		memset_after(item, 0, level);
> > 
> > Perhaps there should be another helper memset_starting()? That would
> > make these cases a bit more self-documenting.
> 
> That would be better, yes.
> 
> > +		memset_starting(item, 0, generation_v2);
> 
> memset_from?

For v2, I bikeshed this to "memset_startat" since "from" is semantically
close to "source" which I thought might be confusing. (I, too, did not
like "starting".) :)

Can I make "bikeshed" a verb? :P

-- 
Kees Cook
