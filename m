Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B585F1978AF
	for <lists+linux-block@lfdr.de>; Mon, 30 Mar 2020 12:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgC3KR6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 30 Mar 2020 06:17:58 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:46420 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgC3KR5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Mar 2020 06:17:57 -0400
Received: by mail-il1-f195.google.com with SMTP id i75so7905725ild.13
        for <linux-block@vger.kernel.org>; Mon, 30 Mar 2020 03:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=upalIYLMXEqgwroFLz8o7p1PD72FjazAP3WakghPkvM=;
        b=OB4YBY85n9imsGg6EVlp5X/dL5sesnMAd72Zo5+hI1ARiBUrhnAzxB/iJsUa8pYWZt
         uywkv307dGztvTZSdxthv7uCWf5rfs2oJ+vTEBgwL+gyV+AudjJkW59Zke2qHHtcuGUW
         xE71y94apvMy8hrexN1N2yhqBRsULLRvozIfYHz+1sIOQk68iZjzngdqzAmPvuQwmTHG
         ygMNdF+jcxrmm+zClKcjrdoT4GmCFSl+TJMk9Xg5EEEn0nplMGUlVVMGtibcdEhNIQzy
         fU8a56p2Q5VYcmgcwrWcDDH2Ny7XCSSOM8WVTR4volSYtDUVHg8/gDDt8jdmAGcADyHc
         2GZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upalIYLMXEqgwroFLz8o7p1PD72FjazAP3WakghPkvM=;
        b=f8VoTIs6C4hy1k/oHvo7AzrXGjPOhUNKcpPWITUy7YkQEhRLVJm1dB8N0mUDL1PAqO
         JP5LnTwHifF3/dckUsula9HjFE+/QXhmKNW3SxuNhrWIo91gOGnkmDVC525//29Iy/Ct
         iw9zitoRl0DO8oiyiMTLk7HXK/AJWxD0Y3/Ko9JZEJBsWlyb6g0BsKybxEzHQ2NTEPLI
         jOC0gC59O+CSj7e3L7eJOz0mTLGevEZRrNvFUwy8wXMeSZJslee+aXws3OGVjuB2F0Q/
         ffvLG/WbO7jULsecGumtlMy3cV7r3KpIyzWByTicl12y3Qy9HlCcgQ9azd9SIzZp2waO
         5s7Q==
X-Gm-Message-State: ANhLgQ0by/2lRH1xhE582xPwPADW846jf/S25/5rK1Xqpfzs52Hxl/Qs
        x1Q7awfebURaRmCITm3JqxPApFarpawgVQWwC4Q4
X-Google-Smtp-Source: ADFU+vtM5O5MKf06RLTuQxKEjmU+bK0fCa5rUBlA50W1+2VdL5TlEICp27mWm8Phqc2kq+4f78AN0ULdS3rHbG9Lask=
X-Received: by 2002:a92:9f13:: with SMTP id u19mr10500655ili.111.1585563476283;
 Mon, 30 Mar 2020 03:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-26-jinpu.wang@cloud.ionos.com> <619d2dda-3c4e-a909-ab78-1201057b542c@acm.org>
In-Reply-To: <619d2dda-3c4e-a909-ab78-1201057b542c@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Mon, 30 Mar 2020 12:17:45 +0200
Message-ID: <CAHg0HuyBtKRca=8k_O9ZvPREMry4L7pcmKsm=GUCq_w8Gtjd-g@mail.gmail.com>
Subject: Re: [PATCH v11 25/26] block/rnbd: a bit of documentation
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 28, 2020 at 8:40 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-03-20 05:16, Jack Wang wrote:
> > +RNBD (RDMA Network Block Device) is a pair of kernel modules
> > +(client and server) that allow for remote access of a block device on
> > +the server over RTRS protocol using the RDMA (InfiniBand, RoCE, iWarp)
>                                                                    ^^^^^
> Isn't this protocol usually spelled as iWARP? See also
> https://en.wikipedia.org/wiki/IWARP.

Right.

> > +dev_search_path option can also contain %SESSNAME% in order to provide
> > +different deviec namespaces for different sessions.  See "device_path"
>              ^^^^^^
>              device?
Will fix the typo.

> > +option for details.


> Otherwise this patch looks fine to me. Hence:
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Thank you.
