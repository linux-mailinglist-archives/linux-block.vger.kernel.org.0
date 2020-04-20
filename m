Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0BA1B0216
	for <lists+linux-block@lfdr.de>; Mon, 20 Apr 2020 09:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgDTHCB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 20 Apr 2020 03:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTHCB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 03:02:01 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10B4C061A0C
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 00:02:00 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id c16so1801794ilr.3
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 00:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UeK1G+MEeshIQlAw2ukA6k5dmclkKmqKslpAbKo5XIY=;
        b=gDVywrrS8MK11AaOEaiZpPlE9hTMRnk8bhDUYeX21LT2dQjIQrltq74rWmkaMXkjca
         ssdYH/LmLgwPZp7f9qCUyxzF8aDiX9h4JPSRRTbWAYqaogj3iTDOQ8tTHvNEaDLDHdmX
         juAdFHBKpT1FgGBZm7RQiq/tfjGijW2pjyVyM+FHALn7gX1aMI/F1i2M33P8hgNXyEwu
         A/Y7igRWjr3uGe/hCDYR/sD58TchP9gf34DwZ6p6izliWTaSQSTWoqzxPL3qFknkKFs4
         9RiIYwITqbQfjLGdsQyKZm3ri1wIzWxmI3syu+m6gkXAPW5IStI06YSn4hOCR+SwqY7P
         oxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UeK1G+MEeshIQlAw2ukA6k5dmclkKmqKslpAbKo5XIY=;
        b=swns6vG8hXhg6SIdNZYG3SuC//x4J63gV2OeI4mbHg0yhDZTYpAxFKgK0xnpzTKkG5
         3woYOgDfE/Mc62m/ZmscSrKdzlfDNDU2lifzxf47nW0PmGOaur6nUVODPWZO0ugRm5zb
         uN+Gbt17Li2WAb2pC2Ur1N3JBezI2XCgC1O2xDGE+JFtosBMv3jIPBs1Vx/rvk2SjWv1
         DA8LkK/DkGo9Qzncsm24CfS0se+qUJ3ooo6EPlcp5aR2HWEV1iwFCun3ZEp9L3o1Id57
         Fcp45P8T7xcSPBckoSVcA6U5JoiweqQzYEBWp0PTqKlJ5r9zi+T7boi/JsFYD3NktURB
         Rukg==
X-Gm-Message-State: AGi0PuYBP7za9wxnl65deXtfvwu0acu+juP2P1pHHOWR0KJm9+Cw2xf2
        3c0lOfogc71a3KF9GjxAGOgkgNyDqTx/uVBbus7vrg==
X-Google-Smtp-Source: APiQypJK/oBDMpDFUCDDfHGhTJVdFzlBHky4uJxOcT9LqRZzFl3VVHMuGoObVkLbtdMkq8lVkx+wY99J6GyU9p2ejF0=
X-Received: by 2002:a92:485b:: with SMTP id v88mr14365464ila.271.1587366120347;
 Mon, 20 Apr 2020 00:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
 <20200415092045.4729-18-danil.kipnis@cloud.ionos.com> <feb3bb89-5258-6c86-0a14-1b9a4d94188e@acm.org>
In-Reply-To: <feb3bb89-5258-6c86-0a14-1b9a4d94188e@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 20 Apr 2020 09:01:52 +0200
Message-ID: <CAMGffEkHXn0KR+5sGrrQjXfkXR3kGiCw5CrdB6kTJSxtNwhBjg@mail.gmail.com>
Subject: Re: [PATCH v12 17/25] block/rnbd: client: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 19, 2020 at 1:17 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 4/15/20 2:20 AM, Danil Kipnis wrote:
> > This is main functionality of rnbd-client module, which provides
> > interface to map remote device as local block device /dev/rnbd<N>
> > and feeds RTRS with IO requests.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>
Thanks Bart!
