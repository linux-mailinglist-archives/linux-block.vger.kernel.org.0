Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F518129230
	for <lists+linux-block@lfdr.de>; Mon, 23 Dec 2019 08:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfLWHUS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 23 Dec 2019 02:20:18 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40920 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfLWHUS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Dec 2019 02:20:18 -0500
Received: by mail-io1-f65.google.com with SMTP id x1so15245798iop.7
        for <linux-block@vger.kernel.org>; Sun, 22 Dec 2019 23:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ttGL4+rAzNXTX2Tnq6h3tFr0OQnGnOOLQHuyK09xGds=;
        b=Ayjkb78OydEZ0TXht2CsrKKwoCTFkm9UnPn3zsidkYkIYw2wiQnviHOcqiCaqikM9H
         Hv/Ha+zqTgmi3yLih80kG69nDr1ibnvdAlzVaBtSxGraACXYR0l1XswHDSmUE6MwMhxu
         aDqKWPdzSizb0sOnFnAIEFlcj1SF4x04ARWlbmdU0qE1LBnq/uqxjaPAEC+xSRpOE70e
         truTDaxC/v8xTLbdJgMnJUGGGvRsvz6r+tMFmoTe54FeBKkBWZvSWsNzDdWF5FRKx4hN
         Sru98DsnNTQS6rG7B9C61+LFcn8tyisIlzZuNtY4W1AX9vO66IbJB37qHG7DkfpBn9Tn
         3p+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ttGL4+rAzNXTX2Tnq6h3tFr0OQnGnOOLQHuyK09xGds=;
        b=bGoVHdocBrMASioirexoPuE8RrGDZ09+T8q4lZTi4hBAglHDYFHqplgvYN2Pilim75
         ZoULFD5y2G3G0/En0eKKHbXoL7ezst6XlQi6vN2Po2hRJ0LbWfyYZXUDx1BjjNkyNl5c
         W1Zn+qiKwYUpwS+vCqSpN8hRtqGdvGC7PZW2crLjY+iJCDaiuJIdS5duUAqAeA1gXLKu
         grDCqOBCCWyFkR/t5i0mI7SqMGyBw7JambVrn8aRUHhPlN47GYIKzsneh1Ylv/tQVwSR
         zOao0bJvSL0Yzgx7LFNw2ZJdhoTYKvdyoqrkpAQ/pDrDXmboilY90xQ9mNZ6h0rpkw8X
         pV+g==
X-Gm-Message-State: APjAAAUv15QaD3Icwe5m7s37ToyRtbH123ta0bN4WV1SgtaY4Mcy/oMm
        CCCTb2RFbdJq6i1KwRW2eXb+X5f+h+heDSz9WLJa9w==
X-Google-Smtp-Source: APXvYqxmmbOZRBX89vHfbtplFNPe+MDeKEj2hP6ww1S4gdn0Gj+xT5VYvprwy2anSIalcKcQGZ2Bi4ykXgtm9CMOFYU=
X-Received: by 2002:a5d:84d6:: with SMTP id z22mr18136770ior.54.1577085617331;
 Sun, 22 Dec 2019 23:20:17 -0800 (PST)
MIME-Version: 1.0
References: <20191220155109.8959-1-jinpuwang@gmail.com> <20191220155109.8959-26-jinpuwang@gmail.com>
 <655f25d2-7c3f-989a-0aa4-9f8f72c63c6b@amazon.com>
In-Reply-To: <655f25d2-7c3f-989a-0aa4-9f8f72c63c6b@amazon.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 23 Dec 2019 08:20:08 +0100
Message-ID: <CAMGffEmhYhhYhhZ++7hd9c3n7jOwgUKiC7vwNc4y++KMgqrEEg@mail.gmail.com>
Subject: Re: [PATCH v5 25/25] MAINTAINERS: Add maintainers for RNBD/RTRS modules
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Dec 22, 2019 at 10:55 AM Gal Pressman <galpress@amazon.com> wrote:
>
> On 20/12/2019 17:51, Jack Wang wrote:
> > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> >
> > Danil and me will maintain RNBD/RTRS modules.
> >
> > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > ---
> >  MAINTAINERS | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index cc0a4a8ae06a..e0caeac43fc8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7955,6 +7955,20 @@ IBM ServeRAID RAID DRIVER
> >  S:   Orphan
> >  F:   drivers/scsi/ips.*
> >
> > +RNBD BLOCK DRIVERS
> > +M:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > +M:   Jack Wang <jinpu.wang@cloud.ionos.com>
> > +L:   linux-block@vger.kernel.org
> > +S:   Maintained
> > +F:   drivers/block/rnbd/
> > +
> > +RTRS TRANSPORT DRIVERS
> > +M:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > +M:   Jack Wang <jinpu.wang@cloud.ionos.com>
> > +L:   linux-rdma@vger.kernel.org
> > +S:   Maintained
> > +F:   drivers/infiniband/ulp/rtrs/
> > +
> >  ICH LPC AND GPIO DRIVER
> >  M:   Peter Tyser <ptyser@xes-inc.com>
> >  S:   Maintained
> >
>
> Entries should be added in alphabetical order.
Thanks, Gal,
Will fix the next round.

Regards,
Jack
