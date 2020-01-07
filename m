Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E03D132A6C
	for <lists+linux-block@lfdr.de>; Tue,  7 Jan 2020 16:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgAGPuE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 7 Jan 2020 10:50:04 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:35110 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgAGPuD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 10:50:03 -0500
Received: by mail-il1-f193.google.com with SMTP id g12so46129167ild.2
        for <linux-block@vger.kernel.org>; Tue, 07 Jan 2020 07:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dM+tQu6OkciIx8Fh2z8Ykuqej0TW6fLMjStC1bJEE7I=;
        b=gbdz0rmofSp363r0EzVMTy17sWDBslvGlYGctVZO81OyGq0IouxgVn5Lxh2+ABsLEa
         oMNNo9vvXeQQzj2xGg+AYuafuEFMsYmgC0VVs2vsNwV0cz1ufdlfWe+GWfH84y041Dye
         E+3sZLggrsV5Yw8+ORjIr0f1e9pZAlrbbNcmdRo/BsDUR+mYCBxcyzcgbtQGuJ5moBi5
         4SfxzVUvkftqvavqluEo9nRnNNV+19rqxUHZDi9/1Xc2nweL+7H1UKoMhiA/ribVYlwj
         7K+zgyxbPeWczDKOixusCrBfBB2N+g9rtSjakbAxi9CL1U40tj5L3azFw1XnyocmtKNq
         7gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dM+tQu6OkciIx8Fh2z8Ykuqej0TW6fLMjStC1bJEE7I=;
        b=mbEb2kvKzWHq+1ZvK72wfsH27kFByTHG/I4c++DnE8DGg4iU2uZvEzadp8Z0gXbWgJ
         LsMEaa9D0lGl0qgqXrkh6pk7kZHnM4qjqWMSYF+V6OgrsOxpQJgdCF2jqSQjjThS1aMo
         1vhrm/HrC17WHZkXiXkYg1fNPdsiUyTSAAFU/ta6J7QBMaSjv9uDPhGTnvqwp0FibDtH
         UDwaz6mA0plLq0OFTIYdcYPcrRiJO55g5QgKl7qmvpJrJiX50zoAJvyW9WBriXiox0we
         RV65JgCy58g1GoHBUYIMKaHue3VNUrgu/7QI+Tyy4sHctG0/FNT2aaGFpxLu0yFYMhTl
         MzAQ==
X-Gm-Message-State: APjAAAXFZz1OqSuLFbs4psN82+6+ACMNypVJyAwIp0di6h6JawFlboWV
        CGwrRW+gkfFoC7B0A35uqDdyQebcThsXuQr/sNr3Kg==
X-Google-Smtp-Source: APXvYqwtSiv4QVl4s0rBRLRrvIZh5ldy/c7Mu44zSQXNlW/uEb7q2Mf6MgtVf91SCmamEWosUmvRp+1ZqbmgKp8akac=
X-Received: by 2002:a92:8d88:: with SMTP id w8mr93382387ill.71.1578412203147;
 Tue, 07 Jan 2020 07:50:03 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-15-jinpuwang@gmail.com>
 <bb668d4e-f768-a408-c541-d862d1a2f959@acm.org>
In-Reply-To: <bb668d4e-f768-a408-c541-d862d1a2f959@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 7 Jan 2020 16:49:52 +0100
Message-ID: <CAMGffEmrHbw8wnsTD0BZV9O38-pJ0Yv7VLkNMJwGoRyOp9Yqfg@mail.gmail.com>
Subject: Re: [PATCH v6 14/25] rtrs: a bit of documentation
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 2, 2020 at 11:21 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 12/30/19 2:29 AM, Jack Wang wrote:
> > diff --git a/Documentation/ABI/testing/sysfs-class-rtrs-client b/Documentation/ABI/testing/sysfs-class-rtrs-client
> > new file mode 100644
> > index 000000000000..8b219cf6c5c4
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-class-rtrs-client
> > @@ -0,0 +1,190 @@
> > +What:                /sys/class/rtrs-client
> > +Date:                Jan 2020
> > +KernelVersion:       5.6
> > +Contact:     Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > +Description:
> > +When a user of RTRS API creates a new session, a directory entry with
> > +the name of that session is created under /sys/class/rtrs-client/<session-name>/
>
> Thank you for having included this ABI description. This is very
> helpful. Please follow the format documented in Documentation/ABI/README
> and make sure that all text, including the description, start in column
> 17 and please use tabs for indentation.
will fix.
>
> > diff --git a/drivers/infiniband/ulp/rtrs/README b/drivers/infiniband/ulp/rtrs/README
> > new file mode 100644
> > index 000000000000..59ad60318a18
> > --- /dev/null
> > +++ b/drivers/infiniband/ulp/rtrs/README
> > @@ -0,0 +1,149 @@
> > +****************************
> > +InfiniBand Transport (RTRS)
> > +****************************
> > +
> > +RTRS (InfiniBand Transport) is a reliable high speed transport library
> > +which provides support to establish optimal number of connections
> > +between client and server machines using RDMA (InfiniBand, RoCE, iWarp)
> > +transport. It is optimized to transfer (read/write) IO blocks.
>
> Is it explained somewhere how the optimal number of connections is
> determined and also according to which metric the number of connections
> is optimized? Is the number of connections chosen to minimize latency,
> maximize IOPS or perhaps to optimize yet another metric?
RTRS creates one connection per CPU, optimize for minimizing latency
and maximizing IOPS, I would say.
>
> Thanks,
>
> Bart.
Thanks Bart.
