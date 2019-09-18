Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31DDDB58F6
	for <lists+linux-block@lfdr.de>; Wed, 18 Sep 2019 02:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfIRAWM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 Sep 2019 20:22:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43363 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfIRAWM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 20:22:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id d5so5339311lja.10
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 17:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Cf9PM2jLJRtza/6q+NTAfzE8uFLfAFlO1UFi01tfk4=;
        b=Bu5hOqwcZJPHKp8NVw+M0EEl7KMuw30eENaZGrQilKHIn/aMdhljVLnLgeveC5L5kK
         7jk+4ZflnjPL/ezRLaPi+2DZYZAHJBEu7cPjv79QvM+BGhDsRlaJOuK5cy66GTYsftFE
         r71nxtwtsPdPBWhlU8SiGaeBT1o05wxIFtmNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Cf9PM2jLJRtza/6q+NTAfzE8uFLfAFlO1UFi01tfk4=;
        b=gDd8APWE7C7Dn/ICdaFIqCiqq9bBVI4xiX5OAlmB/ph4+uugdGtfqxE/d5LNVoZtFY
         7hBuue0gX/W7aWX9ly6DamsCFjJa1Z0lT4wqwAmIObnfXJnD4DaFD9R/mvx2jcPoMjvf
         Ve69NrhWBRkCjFr++lWkmNPGKuVMdkK1JYquI+600sloXIVQcsunio6zhqQ9//riCYso
         QIYrIQwGEqpbG/cVWfi6sELsY6yaQcSSyhUP4sTAXFFhqcn2lHfxtQnOoEfq4z1MgI2k
         FRqHwmYqn+71GwElFwZpiUlayrdrAR3NpZjeiFkXTcBEWb6vPCz7TRcXEUSfiVKrmYdr
         /2Ig==
X-Gm-Message-State: APjAAAUXQNR7orMRVZzJ30ZrlzGxY0ZHHc5NSKFmA0CynAJTK7+5uwxK
        oy4pQyILWUkPhGtz/Lzk0WB93pZqphA=
X-Google-Smtp-Source: APXvYqw/ILXA2hTR6MzNqKZKt8OJuCs58DJBgFdTKkGHoxxDVz7+rixKheGLKG7zVgW1e2KTnKO7wg==
X-Received: by 2002:a2e:8147:: with SMTP id t7mr518377ljg.75.1568766129530;
        Tue, 17 Sep 2019 17:22:09 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id n12sm707828lfh.86.2019.09.17.17.22.08
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 17:22:08 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id r2so4254955lfn.8
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 17:22:08 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr482511lfh.29.1568766128199;
 Tue, 17 Sep 2019 17:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <61b11672-f41b-9708-2486-f284a99483a8@kernel.dk> <CAHk-=whhKxxJ8yM1StiPcb8866PzxLBB77_d+MEA3SKY4hhjjg@mail.gmail.com>
In-Reply-To: <CAHk-=whhKxxJ8yM1StiPcb8866PzxLBB77_d+MEA3SKY4hhjjg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Sep 2019 17:21:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=whtmdMrvVSvNOBKPqYku8dm=WsogD95wwb4NRs8U_jwjA@mail.gmail.com>
Message-ID: <CAHk-=whtmdMrvVSvNOBKPqYku8dm=WsogD95wwb4NRs8U_jwjA@mail.gmail.com>
Subject: Re: [GIT PULL] Block changes for 5.4
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 17, 2019 at 5:18 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Honestly, I would much rather have seen this as three completely
> separate pull requests:

There are two hard problems in computer science: cache invalidation,
naming things, and off-by-one errors.

I said "three" and then I listed four.

Math is hard, let's go shopping.

             Linus
