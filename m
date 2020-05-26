Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F29A1BF728
	for <lists+linux-block@lfdr.de>; Thu, 30 Apr 2020 13:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgD3Lwq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 30 Apr 2020 07:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726053AbgD3Lwq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Apr 2020 07:52:46 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59111C035494
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2020 04:52:46 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k12so4661382qtm.4
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2020 04:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/fTUSkMdSzNBeDil9gXpnKMgTkJNNuowlWAzviUzhIA=;
        b=bJlp4btXQi+iluG8B26//lHBanaz65CntIaNXsKKlcTUDjPaV82WKf1RTHjgjUy5th
         Cu6quUoPIe7vc1gQMGw2MJCsHVRaHXn79YGudPkz4kUhPWK8I2jiTK/V9WYUdA1Asnl7
         xrTw/KUYFNOBfiNZJv+i7PzS7QZjdhQR8eARZObiFS4aR2WXgIPna8SlrCQpzcovMLsP
         Yq+pnuXAx2FKMtpBaVU2U+pawAkkUtY5WWKHWmSv2aP676ZVbMasJ5Q8geDl0xHont4C
         TFQpKSWPOpuRt7V6cwUVJOqcG9W3nQ8VJ/7Z7BxbmHaTgtKOqkU9rth5p46OVqgLcCze
         5JyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/fTUSkMdSzNBeDil9gXpnKMgTkJNNuowlWAzviUzhIA=;
        b=CQY3cbQCYtcUOpBlGWU6UEOlW283C7t2F0ODNQnxlfUuaHUeInJSzkKnevBSZgffGp
         8TikwE7vdLKD1ZkRcAI3Cnkaev+kyBl6C/yGQcZ2ZItyfe+OUsqxDQI+K79vBNGb+F6y
         KOVoZfxLOkPZ0nBMErpeyeJuNYl1I9qy2nRqyHOqz2fenNKqFBGwQjC7znesPHGba+Yw
         DLb75gMO/u4GWOQrxRFc8bSNiVuOulk3tYTKOasg1tEH5aU/Axsai1lgEiPzQKGRfePG
         TxObPjv2UZqjJ3pjH/KIUUp/eecu+bhuJKagK2vXbEbB2hZhUzi0HWx9Fg5h9ibvGSkT
         57hQ==
X-Gm-Message-State: AGi0PubQbNnRiU9R/U1wIDTy+cRhDQZnWIvXI1NXHEnZD79nTxLtihCH
        xpBzLIatsGjRRQIJHgjyvyiu3w==
X-Google-Smtp-Source: APiQypIaDDh9FjwXHlle2DW2f+wpfkBnJmXNWTEfE6Ts7tc+fy67bjtaZC+mEyYPDAqXjEKMkP92xw==
X-Received: by 2002:ac8:3808:: with SMTP id q8mr3232836qtb.245.1588247565469;
        Thu, 30 Apr 2020 04:52:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id k128sm462688qke.125.2020.04.30.04.52.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Apr 2020 04:52:44 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jU7kC-0006oW-5a; Thu, 30 Apr 2020 08:52:44 -0300
Date:   Thu, 30 Apr 2020 08:52:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Subject: Re: [PATCH v13 23/25] block/rnbd: include client and server modules
 into kernel compilation
Message-ID: <20200430115244.GM26002@ziepe.ca>
References: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
 <20200427141020.655-24-danil.kipnis@cloud.ionos.com>
 <20200429171804.GE26002@ziepe.ca>
 <CAHg0Huyvt1P1To+fxn3RZdGXJfnQXpNxJbpNxquqLw_KVtcDKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHg0Huyvt1P1To+fxn3RZdGXJfnQXpNxJbpNxquqLw_KVtcDKA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 30, 2020 at 09:42:46AM +0200, Danil Kipnis wrote:
> On Wed, Apr 29, 2020 at 7:18 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Mon, Apr 27, 2020 at 04:10:18PM +0200, Danil Kipnis wrote:
> > > +rnbd-client-y := rnbd-clt.o \
> > > +               rnbd-common.o \
> > > +               rnbd-clt-sysfs.o
> > > +
> > > +rnbd-server-y := rnbd-srv.o \
> > > +               rnbd-common.o \
> > > +               rnbd-srv-dev.o \
> > > +               rnbd-srv-sysfs.o
> >
> > keep lists of things sorted
> 
> Hi Jason, I understand you mean to sort the order of object files
> here, right? Is that the reason the kbuild robot couldn't find the
> rtrs.h include file?

Probably not, you'll need to fix those kbuild things too

Jason
