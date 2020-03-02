Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E194E175DB9
	for <lists+linux-block@lfdr.de>; Mon,  2 Mar 2020 15:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgCBO6y (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 2 Mar 2020 09:58:54 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:36980 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbgCBO6x (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Mar 2020 09:58:53 -0500
Received: by mail-il1-f194.google.com with SMTP id a6so9561220ilc.4
        for <linux-block@vger.kernel.org>; Mon, 02 Mar 2020 06:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cG4KsHZknk99RFAGLY2oUd12iQAqEbe0ngzbaTgxBLs=;
        b=d+DRBDf95wOhIma41cTAJGdPgDW+Dp7ZGUVmhK86PIS6GGy+8+4wxd6vVd8cMFTxRN
         TrB6Di0ODdvMFlE6L3MiH90+4JSMzRuBCHECqG/UFx/E5CNXTQXL0dnBOthwKX6QT2dA
         zPM7nR18XM7G5tG5W+b5E3U6WUSHbjBFQR4FczIfwfu/I5ehmRdfNeAqQPsvTh12RCzl
         9E5b8lfBOs4di9iXeCD1TEPGFUyyqXyguVaJkP40q0JtP5HUl9yENvlLHTO3wrsL1LLF
         1lHhK1AuiG5BTqMZrgkfdLaj7VBGClnd2EN6pTanzL9cNP0+3BWbu9InSwX4/3kMy3jG
         ox1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cG4KsHZknk99RFAGLY2oUd12iQAqEbe0ngzbaTgxBLs=;
        b=Z8jyyYsqau7raoIGaq9JmSmJ1aiDmY1eXub/UA4CWiC6b3arXgWo80iFOFANXph1F7
         qVUYrIWIksiPRPXB9bnNN//deDc+htOd6I32cPirWPC1cb3BGBNgwAHvyisbjCHtX/19
         tqbPzROLQHpMH0xkgpwHyxK0IIgCeL3KkN86zP284TtolYcIztUNGIs9OQOOuZ5XWK09
         QLuVvHDxTBvuNjCYWVVIVxOD0+cdY/W3EjJnzNWWKoJ4euU452awaJf+cJzF4aKCHhAN
         kLt7rry6k71Pj4JF3IYSC+gSuOB2xBVmLzU+naBNIAvkDchNLEfiN/Y6JZ0NMMVcgBw6
         Kr1A==
X-Gm-Message-State: APjAAAVRcC48tyaTyxIrA9+fHnoXptJW7q/I7Q3vpSfsG4tnT91b9Kdq
        nuh3FMWTdL8Tw1Z0WPwZwI3iIEf0yI0TgAQTMricmg==
X-Google-Smtp-Source: APXvYqzrdXEjLFBQzui9YPT8H0wMTdTYQjUtGiULMNldXhahY4Q5ydkZR7S7q2efjkrij8R52Foz1s0IrydUfWKsakc=
X-Received: by 2002:a92:af08:: with SMTP id n8mr16230470ili.217.1583161132897;
 Mon, 02 Mar 2020 06:58:52 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-18-jinpuwang@gmail.com>
 <16e946dd-b244-594b-937e-689f2f23614e@acm.org>
In-Reply-To: <16e946dd-b244-594b-937e-689f2f23614e@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 2 Mar 2020 15:58:42 +0100
Message-ID: <CAMGffEnrX0+ktLPOocEt6kOYJ93F1yOYYCwrvnZQuWVCQG3qRQ@mail.gmail.com>
Subject: Re: [PATCH v9 17/25] block/rnbd: client: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 1, 2020 at 3:46 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-02-21 02:47, Jack Wang wrote:
> > +/**
> > + * rnbd_get_cpu_qlist() - finds a list with HW queues to be rerun
> > + * @sess:    Session to find a queue for
> > + * @cpu:     Cpu to start the search from
> > + *
> > + * Description:
> > + *     Each CPU has a list of HW queues, which needs to be rerun.  If a list
> > + *     is not empty - it is marked with a bit.  This function finds first
> > + *     set bit in a bitmap and returns corresponding CPU list.
> > + */
> > +static struct rnbd_cpu_qlist *
> > +rnbd_get_cpu_qlist(struct rnbd_clt_session *sess, int cpu)
> > +{
> > +     int bit;
> > +
> > +     /* First half */
> > +     bit = find_next_bit(sess->cpu_queues_bm, nr_cpu_ids, cpu);
> > +     if (bit < nr_cpu_ids) {
> > +             return per_cpu_ptr(sess->cpu_queues, bit);
> > +     } else if (cpu != 0) {
> > +             /* Second half */
> > +             bit = find_next_bit(sess->cpu_queues_bm, cpu, 0);
> > +             if (bit < cpu)
> > +                     return per_cpu_ptr(sess->cpu_queues, bit);
> > +     }
> > +
> > +     return NULL;
> > +}
>
> Please make the "first half" and "second half" comments unambiguous. To
> me it seems like the code under "first half" searches through the second
> half of the bitmap and that the code under "second half" searches
> through the first half of the bitmap.
Ok, will improve the comments, say searching  "cpu to nr_cpu_ids" and "0 to cpu"
>
> > +     /**
> > +      * That is simple percpu variable which stores cpu indeces, which are
> > +      * incremented on each access.  We need that for the sake of fairness
> > +      * to wake up queues in a round-robin manner.
> > +      */
>
> Please start block comments with "/*".
ok
>
> > +static void wait_for_rtrs_disconnection(struct rnbd_clt_session *sess)
> > +     __releases(&sess_lock)
> > +     __acquires(&sess_lock)
> > +{
> > +     DEFINE_WAIT_FUNC(wait, autoremove_wake_function);
>
> Please use DEFINE_WAIT() instead of open-coding it.
ok
>
> Thanks,
>
> Bart.

Thanks!
