Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045C9343C18
	for <lists+linux-block@lfdr.de>; Mon, 22 Mar 2021 09:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhCVIvw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 22 Mar 2021 04:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhCVIvp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Mar 2021 04:51:45 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A370C061574;
        Mon, 22 Mar 2021 01:51:45 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id o66so5729422ybg.10;
        Mon, 22 Mar 2021 01:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zZUxxolYENOQUENZ+lfutKQF2Z8w97jGbJjNKrdcc9g=;
        b=Z7CGvbRXcrH2XSgFW9+mh2v0GRrKstIS8N0qY5Rphs3xkClbYWn68vvaomgnjmRkN2
         hASXnD6t7XWGn4QHKx43+lL5PUBNR4IinpLdcW6JB2FuoeCp0ectnCHu77GBrKFE5txL
         EIlRkWu6KoGPMR7LHBV7hWtRJ+hCMBxlMN/GHO1b3JVZPh+mWgs4BVhGwjP4DNUfueuq
         3vC3aH6hCcsRxBSJg5u9e2OH059B1K4y9jYFTGeFPSSZkSdxXTwVOYmRlWjICwNa4hfX
         5dUN4oBuJc5zQ8d0a1GgSsIeQ/GC/V0BgylyklV9ha8nuN9MStBoqM9sLxIOh0CqqiF1
         Sh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zZUxxolYENOQUENZ+lfutKQF2Z8w97jGbJjNKrdcc9g=;
        b=DPDWhMwwSNWwYRtnRfaeC8uzaXivrESAmy7Yw3F2IAus+hDjO11T52TwGaETs7vZnw
         6SllTN1kVkHf8Cxr2m5cr2MXxZlxNJXIkIvWcfIYHt/eK/HQ0nBXYawwrzZlB5dg5HvJ
         iK6oRbdFBZyAYcnq3q8gH0ENnbre0C3gTibj0P6XqUYDQzL0HBuP9BUSzkrQM/4wA9HG
         bqR486Bxxdyyp7WZD8Sy9lY+jfqA4zAK6bFna16u/QZx3J0001o46QP37AsuRYsT5X4M
         sXU4+pIiTymTrRXnab+YiTe+ABbeO5TZM9n/WpzdRT2ga17kztzIcV3vTN1a7o4SVTsE
         rB7A==
X-Gm-Message-State: AOAM533x+3bqRSCNo9R+ZPy14tVVVlOC9ZcfEw/y1scjDb0/GRRRcALE
        WaBef2c7/jmKPkFViW8KUx/SYgJ1KlHvJXsWWC8=
X-Google-Smtp-Source: ABdhPJzeZH+/7T21996w0VxHXZr5xna1/hURv2Axs+T48Vx91u9Ni1YOP3GghPknR0e9eDKcRVxrSjoWb8Bz7InFJlA=
X-Received: by 2002:a5b:3cc:: with SMTP id t12mr23113193ybp.144.1616403105033;
 Mon, 22 Mar 2021 01:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000053da9405bd7d2644@google.com>
In-Reply-To: <00000000000053da9405bd7d2644@google.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 22 Mar 2021 16:51:33 +0800
Message-ID: <CACVXFVO-6A_u-zNvkUt4x57gAwxJBDHx=Arc6KPKh560X3G29w@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in disk_part_iter_next (2)
To:     syzbot <syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 14, 2021 at 7:10 PM syzbot
<syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    280d542f Merge tag 'drm-fixes-2021-03-05' of git://anongit..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15ade5aed00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=952047a9dbff6a6a
> dashboard link: https://syzkaller.appspot.com/bug?extid=8fede7e30c7cee0de139
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com

#syz test: https://github.com/ming1/linux.git v5.12-block-test
