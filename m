Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7943D0DC6
	for <lists+linux-block@lfdr.de>; Wed, 21 Jul 2021 13:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbhGUKxC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 21 Jul 2021 06:53:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239453AbhGUKtz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jul 2021 06:49:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16F6E60FED;
        Wed, 21 Jul 2021 11:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626867031;
        bh=LdfjugS48dS+nRJKJaM5T5js8ElP2wpZ0Stt/chye58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1UZh1i8UWofDwaM8TulKCVQinJZZPH2JCRJw7prirEbtDhmt+UX4vUqTQjxk1mxDH
         2Wmlh7vH6oAY6HVi5AnY22IvbCwImKWt90XZAbC7j1v4KuJCx4DSp6WQ1sAPUxmiHK
         GRasP1jL4IJayZj/eLNd4lpNLJWCpxpNx8dpSsDo=
Date:   Wed, 21 Jul 2021 13:30:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, rafael@kernel.org, davem@davemloft.net,
        kuba@kernel.org, ast@kernel.org, andriin@fb.com,
        daniel@iogearbox.net, atenart@kernel.org, alobakin@pm.me,
        weiwan@google.com, ap420073@gmail.com, jeyu@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        minchan@kernel.org, axboe@kernel.dk, mbenes@suse.com,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        jikos@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] sysfs: fix kobject refcount to address races with
 kobject removal
Message-ID: <YPgFVRAMQ9hN3dnB@kroah.com>
References: <20210623215007.862787-1-mcgrof@kernel.org>
 <YNRnzxTabyoToKKJ@kroah.com>
 <20210625215558.xn4a24ts26bdyfzo@garbanzo>
 <20210701224816.pkzeyo4uqu3kbqdo@garbanzo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701224816.pkzeyo4uqu3kbqdo@garbanzo>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 01, 2021 at 03:48:16PM -0700, Luis Chamberlain wrote:
> On Fri, Jun 25, 2021 at 02:56:03PM -0700, Luis Chamberlain wrote:
> > On Thu, Jun 24, 2021 at 01:09:03PM +0200, Greg KH wrote:
> > > thanks for making this change and sticking with it!
> > > 
> > > Oh, and with this change, does your modprobe/rmmod crazy test now work?
> > 
> > It does but I wrote a test_syfs driver and I believe I see an issue with
> > this. I'll debug a bit more and see what it was, and I'll then also use
> > the driver to demo the issue more clearly, and then verification can be
> > an easy selftest test.
> 
> OK my conclusion based on a new selftest driver I wrote is we can drop
> this patch safely. The selftest will cover this corner case well now.
> 
> In short: the kernfs active reference will ensure the store operation
> still exists. The kernfs mutex is not enough, but if the driver removes
> the operation prior to getting the active reference, the write will just
> fail. The deferencing inside of the sysfs operation is abstract to
> kernfs, and while kernfs can't do anything to prevent a driver from
> doing something stupid, it at least can ensure an open file ensure the
> op is not removed until the operation completes.

Ok, so all is good?  Then why is your zram test code blowing up so
badly?  Where is the reference counting going wrong?

thanks,

greg k-h
