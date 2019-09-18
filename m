Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C70D8B62FB
	for <lists+linux-block@lfdr.de>; Wed, 18 Sep 2019 14:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfIRMWc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 18 Sep 2019 08:22:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40234 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbfIRMWc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Sep 2019 08:22:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id l3so6664288wru.7
        for <linux-block@vger.kernel.org>; Wed, 18 Sep 2019 05:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m4xmVhO4aVmWQpZQri7DsxSTEfwJAB057bj26n65Zok=;
        b=UCNZmbmD2GDn+g+EDmNepoyb2UzByJvJPs503pqvEf0SmwF6sj6oMPkCW/9oHrEY8T
         veuJag53n4J65fLiYAzr2Zc+pkNUY5vYlrCR+YmRszw64Fk21SMkeLM9CQadGUvxRByf
         L+jaGnGMc7REC5ZLuZiP5FLVYp5fg6uYhwga8fDdYAE3rjSFyJ5YBHLBAuU0bS1CAdRG
         MDEHsL6+UE4HIX/k3Go7MUouR9I21Dj9OZVdOMW7vzPhFNeZUZmuMuFVnEM1zxZJmqmp
         aJTGDz1DCYSds3yqcv93sH3hV2vXxJ3/wKi2lgjhvgK3hp9cBQABXhhd9r+dQRqe3eEO
         Zbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m4xmVhO4aVmWQpZQri7DsxSTEfwJAB057bj26n65Zok=;
        b=SyP5j+bH4AfQHlT421TDiVYfVAbfainO3hmo1I2bbCGTpTaYbloK/ZNBDKlLahvjQ/
         GLQtKTgEuA8/Xld2qLw1NSiIuJR7Ajsv7eF7WSv8NYa31f3PD6+lhyhNtY96Op7l11x2
         UKDTwJ/SY+Iu5cWPxCJRzqjSp6H6vCccGxDAiZAHRDF43Z1F1ZA1CJcVcU7i7vDumn/o
         1uDJPDAKUl0NGAiTMFP72hMs223vYxcG5cKlH2mon/znoQYbZRMQ+i3PG5uXkS5opDJ4
         06+196V5/Tr+5O5vU6p+Ynz+1Quzc+Ra8p9ChMMl6NDo4zBrB3BUcdPhJC34+4R5ucYi
         xMMw==
X-Gm-Message-State: APjAAAXN1j6WtG/yjs8I7oYsxvR22szVOXj6EWirFA+ZUj+7wqsQsMED
        PA/oHR+zjnZ7nqcJ1N7Z7piaHvTWhbL2v93LWBf/EA==
X-Google-Smtp-Source: APXvYqzCUT4tP0P7kaqvmlAhxGIGeZIJobnt5M+Q2IZYU3eBvDQ/Xc2dz92RXzxIT2ujmdlLkjAl0qnVJM4HGGc88cg=
X-Received: by 2002:adf:8444:: with SMTP id 62mr3077746wrf.202.1568809349137;
 Wed, 18 Sep 2019 05:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-25-jinpuwang@gmail.com>
 <f9e6014b-9123-8cfb-77a2-57af953a5031@acm.org>
In-Reply-To: <f9e6014b-9123-8cfb-77a2-57af953a5031@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 18 Sep 2019 14:22:18 +0200
Message-ID: <CAMGffE=SQa54CmY+c=qqUMFFOE1zfNi4hVtcHxkZ1meWbXX9-A@mail.gmail.com>
Subject: Re: [PATCH v4 24/25] ibnbd: a bit of documentation
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Sep 14, 2019 at 1:58 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 6/20/19 8:03 AM, Jack Wang wrote:
> > From: Roman Pen <roman.penyaev@profitbricks.com>
> >
> > README with description of major sysfs entries.
>
> Please have a look at Documentation/ABI/README and follow the
> instructions from that document.
>
> Thanks,
>
> Bart.

Thanks, will move the sysfs description to
Documentation/ABI/testing/[sysfs-class-ibnbd-client|sysfs-block-ibnbd],
will also move ibtrs sysfs description there.


Regards,
Jinpu
