Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C32D12FA30
	for <lists+linux-block@lfdr.de>; Fri,  3 Jan 2020 17:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgACQTw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 3 Jan 2020 11:19:52 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:36647 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbgACQTw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jan 2020 11:19:52 -0500
Received: by mail-il1-f194.google.com with SMTP id b15so37005074iln.3
        for <linux-block@vger.kernel.org>; Fri, 03 Jan 2020 08:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05YrvVWWk/rZpAFGYlfJ9p7bDX0zz0zCE+5tItikZfU=;
        b=Nv+QYmAf83A9eeErqft4+JNO24vhDOKS3zlOVz8dAGoyHDiLftgoqMKaJCgyFYhqL5
         czZyHtXFPnj8DrLHX1UpX64zE1phGGImVeNAU5sqH3UXwMkREeFAIfHtjwS7OErAZa1n
         njhzTi4cuzht+uDYEtKYj2lk+VmX7pWxOd5PYLKsPW+Q2n/E+Jr9190HxUWFkiuC+KuS
         J16M49nhNMZMEkKZRHPCtqndCOVAsneD5rJ+0KUjjtZ33FFX7SYWMoaNk0OvMQR9guSi
         HKhbXGAMo3KKNidvEqCISwqsHzUXRxSbMAAhFXRaQxTna1F6hQYLTs0HdAEtQBp8d+lO
         E1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05YrvVWWk/rZpAFGYlfJ9p7bDX0zz0zCE+5tItikZfU=;
        b=Z7kYI4dtQ3zKqjM/gPabQ9ammkjP1OHYc0FIImYjVeA/t6B1zaplpHYDdh3S5wZp89
         BJG4BHKmsUAwV3gvXd0c2fYlYnPBFqLVqGI65fLJnBH6tHBw/TmlRvH5kV5B+FRb1CwO
         /M2qREIrDFZ5pZ74Iim7mOpCh+VHmbVOM6MuyRTsegskt6RQsoZtJGhCC7rA01FFKr0R
         bgn6+M6KszUESmXDE4bUhZr9lxSijmctw9IiJye4g4EDT9M3vHoLn/6qWIUTZCgoAl98
         QhsJUUUtECrwwvtpVZA0Gwf3mJ6d7E+mKMWWdcvtK6T6LnVMzEZkUkU95yxFqoJyr94y
         VCdA==
X-Gm-Message-State: APjAAAXj6rPnXANzXO1iqhNGHKZCMMjpNJ8ZcIc8PcTNXEhebVdQFSFJ
        TLin7AOCb11ckz2mtjKspRl59ji5k+tsyCvWY4DHzg==
X-Google-Smtp-Source: APXvYqzovU0uBZ8ftzlLa62V+oIwtTpAa3pkdA26wZQ8mkNz8WV1vZilOv8yUwml4zAnr0ro4Ji8+WZoeAsDpn0EcK4=
X-Received: by 2002:a92:8d88:: with SMTP id w8mr77578935ill.71.1578068391465;
 Fri, 03 Jan 2020 08:19:51 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-14-jinpuwang@gmail.com>
 <81414f0d-ee6e-9477-ef85-12476faa257d@acm.org>
In-Reply-To: <81414f0d-ee6e-9477-ef85-12476faa257d@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 3 Jan 2020 17:19:40 +0100
Message-ID: <CAMGffE=6Zvu08qeWCiK6poa787V+OcNQ+71ivdTiGK0mZu-z5w@mail.gmail.com>
Subject: Re: [PATCH v6 13/25] rtrs: include client and server modules into
 kernel compilation
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 2, 2020 at 11:11 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 12/30/19 2:29 AM, Jack Wang wrote:
> > +config INFINIBAND_RTRS
> > +     tristate
> > +     depends on INFINIBAND_ADDR_TRANS
> > +
> > +config INFINIBAND_RTRS_CLIENT
> > +     tristate "RTRS client module"
> > +     depends on INFINIBAND_ADDR_TRANS
> > +     select INFINIBAND_RTRS
> > +     help
> > +       RDMA transport client module.
> > +
> > +       RTRS client allows for simplified data transfer and connection
> > +       establishment over RDMA (InfiniBand, RoCE, iWarp). Uses BIO-like
> > +       READ/WRITE semantics and provides multipath capabilities.
>
> What does "simplified" mean in this context? I'm concerned that
> including that word will cause confusion. How about writing that RTRS
> implements a reliable transport layer and also multipathing
> functionality and that it is intended to be the base layer for a block
> storage initiator over RDMA?
Sounds fine, will explains what the RTRS abbreviation
>
> > +config INFINIBAND_RTRS_SERVER
> > +     tristate "RTRS server module"
> > +     depends on INFINIBAND_ADDR_TRANS
> > +     select INFINIBAND_RTRS
> > +     help
> > +       RDMA transport server module.
> > +
> > +       RTRS server module processing connection and IO requests received
> > +       from the RTRS client module, it will pass the IO requests to its
> > +       user eg. RNBD_server.
>
> Users who see these help texts will be left wondering what RTRS stands
> for. Please add some text that explains what the RTRS abbreviation
> stands for.
>
> Thanks,
>
> Bart.
Thanks.
