Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D07BEE3F
	for <lists+linux-block@lfdr.de>; Thu, 26 Sep 2019 11:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfIZJQ7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Sep 2019 05:16:59 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46941 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbfIZJQ7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Sep 2019 05:16:59 -0400
Received: by mail-io1-f68.google.com with SMTP id c6so4501105ioo.13
        for <linux-block@vger.kernel.org>; Thu, 26 Sep 2019 02:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=opU2ZI5JfOeMYpBAwSTCngXukXJ/aa9xFV3oPHd6LY0=;
        b=N8NrSTeSaDVfcR6D7xcWuYzoTniMDLqUY1aWwjU3v0ZSgVyVrut1Q3AYJxzcKCNzD+
         c0+MySLMF79j27EvLTHLgo5yvh8xCoOVMjXkjjH0Ad+CN5gRRenL1W6OahwMgYll5S9T
         sKuDr+XQcoP2cuUqyZvGCGMjyQZEnC20YK/xfdCYLnIWqO5KVqdEnYANnGEGzHeG+3iP
         yTXtY4Ia1tX3YpjICRcU6+fsqOE3rYgAlXa0HbvTXPvmG8/zqw1faZQ8NYGicNZRXWxE
         mU8Fzsly5IuaKz3adjAkC2R1Ac2K1YczGzsPIeuo6y4NfgNpeOf7qx9Z5Q9oWXcScelN
         OTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=opU2ZI5JfOeMYpBAwSTCngXukXJ/aa9xFV3oPHd6LY0=;
        b=SnqYHIGcA3Rk4Mom1hqXXDsadqHcdGfVDCuLxQ7+64FAp4iFS1BX7J5seGN+XVZX8h
         qCNoVivJSADBlyUFOQeF9wLkOq6o2deyiFg/7HmUXQiZyx2kMmJMWcismKIHZODj2VXk
         saemie37lfAjSYkl0nKL6muYGpbEi+IA86wCOKWb9TrsTvS5GIHBFhmvy8g9moE7ZCP7
         oTZ2hd6Djw745B9BfleACFmOyK0p2lXbiNKQfxDiH/FKcKqtvXa0/10BHOUuTTwUpSlf
         saAeUxOF86yS/9wjNCcZno6ZDyOEP+ATqhKtoUmHD55sDwOu8VOgaX1laOKMaPXhAIlA
         jMmw==
X-Gm-Message-State: APjAAAVPb5oct0EGHw7X8DvsohXUl+Ek/qbfiApYIJWZCCj56yrKtyZ0
        aoez4F4Y+luXJyLwBBMuPIPvscSRCJfSbnhMufNm
X-Google-Smtp-Source: APXvYqwIYSHBcJUQ3pMZh4YCYMydD9ttww2cVvSLVFh8Eoo4P7s3grDElbpXQD3jmw9i/t/GW2/r5TY2jZqXl35tb68=
X-Received: by 2002:a6b:c348:: with SMTP id t69mr2503648iof.66.1569489418455;
 Thu, 26 Sep 2019 02:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-7-jinpuwang@gmail.com>
 <d0bc1253-4f3d-981b-97f1-e44900fffb44@acm.org> <CAHg0HuzDGgmFKykAmBuAwJXoP1OGq-pQteS=vYMjcbp=cwu9GQ@mail.gmail.com>
 <ee692ec2-7f65-19f5-f122-fed544074f5f@acm.org> <CAHg0HuyMekqFehsU+-O_X8-1j1Bwu6rJzvuAwVV4LQs06ZJsFw@mail.gmail.com>
 <befbe2d4-d37e-0e67-3bf5-01024663082f@acm.org> <CAHg0Huzuw=O2CJvUGJYO0whUE6tx34iPm7ScWRn-uRafRYp5aQ@mail.gmail.com>
 <aad75dc9-1503-3c32-5d69-2180d8abe3f7@acm.org>
In-Reply-To: <aad75dc9-1503-3c32-5d69-2180d8abe3f7@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Thu, 26 Sep 2019 11:16:47 +0200
Message-ID: <CAHg0HuzaSHhGHExNzoH4pcA3H40azaRZsrAHFtDRKLu-datDVw@mail.gmail.com>
Subject: Re: [PATCH v4 06/25] ibtrs: client: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 26, 2019 at 1:21 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 9/25/19 3:53 PM, Danil Kipnis wrote:
> > Oh, you mean we just need stub functions for those, so that nobody
> > steps on a null?
>
> What I meant is that the memory that is backing a device must not be
> freed until the reference count of a device has dropped to zero. If a
> struct device is embedded in a larger structure that means signaling a
> completion from inside the release function (ibtrs_clt_dev_release())
> and not freeing the struct device memory (kfree(clt) in free_clt())
> before that completion has been triggered.

Got it, thank you. Will move free_clt into the release function.
