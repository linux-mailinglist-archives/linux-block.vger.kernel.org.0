Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8CB38CEB2
	for <lists+linux-block@lfdr.de>; Fri, 21 May 2021 22:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhEUURp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 21 May 2021 16:17:45 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:40924 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhEUURo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 May 2021 16:17:44 -0400
Received: by mail-pl1-f180.google.com with SMTP id n8so6351201plf.7;
        Fri, 21 May 2021 13:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4sAcdTInN18w5aIaTL3XxT9sMpoGjfDrBAcsxUKgHPQ=;
        b=pp2SURSg4qtVjI8PxYgCKuoO2WV4GNF/hn1AZXxHvAgvEdt41PX/rTRUCWfxewdLKZ
         s33A9TgqC7CPvOYRwelROG9SuO7+yKirQxp+3jeeKyqoeoXJUN4y8qB1CIso/BKo4BlK
         CrQwjV/mJzInriCp70WmwbJqmG4MFokzRY9OvbqY+uJu3XN2loOXW9kW3Cwnj2vU+mFu
         9wn6hOgibqlZEOYwV0Z239GH8aptYL0jAKQtVYIZVCZmlrKFiFELLrPcRYuu+kdBMwJD
         tqrsq+t9upkQxuhQMd8iU1MnkUE0ycRX7TPwFFOVhpTzmcYa44f/dggATa2VVg2ksxHa
         hstg==
X-Gm-Message-State: AOAM5339ySr2TdBHcLS/jxSzQIdlzSGOX/N3yVHWTclnQsy7qrww/SN8
        5+hQ1qC5k0qfMCNjtlz7XSk=
X-Google-Smtp-Source: ABdhPJxGlmtIIiR/TrUrmDKXT2/j648am8tJAQfWjQBd88Vnr3oPQa4J6t61UDWFu8VrYektkexT8Q==
X-Received: by 2002:a17:90a:d201:: with SMTP id o1mr13039617pju.230.1621628180914;
        Fri, 21 May 2021 13:16:20 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 125sm4904349pfg.52.2021.05.21.13.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 13:16:19 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C71A8423A3; Fri, 21 May 2021 20:16:18 +0000 (UTC)
Date:   Fri, 21 May 2021 20:16:18 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, Hannes Reinecke <hare@suse.de>,
        Douglas Gilbert <dgilbert@interlog.com>, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        mbenes@suse.com, jpoimboe@redhat.com, tglx@linutronix.de,
        keescook@chromium.org, jikos@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] zram: fix few sysfs races
Message-ID: <20210521201618.GX4332@42.do-not-panic.com>
References: <20210423011108.11988-1-mcgrof@kernel.org>
 <YKVwZVcbZBNXUpKm@google.com>
 <20210519202023.GU4332@42.do-not-panic.com>
 <YKgRsCzwp2O2mYcp@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKgRsCzwp2O2mYcp@kroah.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 21, 2021 at 10:01:52PM +0200, Greg Kroah-Hartman wrote:
> On Wed, May 19, 2021 at 08:20:23PM +0000, Luis Chamberlain wrote:
> > Greg,
> > 
> > your feedback would be appreciated here.
> 
> Appreciated where?  This is a zram patchset, what do I need to mess with
> it for?

This patchset has 2 issues which I noted in the last series that are
generic, and could best be dealt with on sysfs, and suggested
how this could actually be dealt with on sysfs / kernfs.

> > Greg, can you comment on technical levels why a general core fix is not
> > desirable upstream for those two issues?
> 
> What issues exactly?

When I suggested the generic way to fix this your main argument against
a generic solution was that we don't support module removal. Given that
argument did not seem to hold any water it begs the question if you
still would rather not see this fixed in sysfs / kernfs.

If you however are more open to it now, I can instead take that work, and
send a proper patch for review.

 Luis
