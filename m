Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 619871999BA
	for <lists+linux-block@lfdr.de>; Tue, 31 Mar 2020 17:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbgCaPcO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 31 Mar 2020 11:32:14 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:44313 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730858AbgCaPcO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 11:32:14 -0400
Received: by mail-il1-f196.google.com with SMTP id j69so19783539ila.11
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2020 08:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=li//ce4gCM94vSCLaU1o9Egryn4gqs/h3gSPzXycttU=;
        b=ibvRqpSGA7Zfwhc3qcAiXb6YELt5ONP8ZiOcKdRsJmS3c9PHM2gwSNpWcRxoJYLWwE
         VB0DTMlNgwpFRwt1Vj7qlyI1HbRgSKfQSuKvrDRzbBv+rPRp9itLZ0dz8aCsbdJOCNip
         ZSShCeGk4EzEIMq2W4NQEJBU3YsNKws2zexbdp2jmSUoFsBGk7I9hVN5R9USCEGqB7xT
         383bvL4QfWLWex9PAH2r3ZL0u/o3SLqluu6E5C5IBNE9h9B2GoFuvH5p9MmDPGU1zAKz
         9ujRXMfJrZ2EPiCwNitJkiZ7I4Fy3pitaRz7zZe1Wt4mNH4TCAoWCmdWmlsaOgRoOkbC
         9d+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=li//ce4gCM94vSCLaU1o9Egryn4gqs/h3gSPzXycttU=;
        b=hIIhN/seHOglPC7ZjPjm4380ZhGih9If2EOG6YzPnpP1A69RDxOSU+UEWXXe46NVIX
         RlJKv9r3QaAZpebB/kyeUPXChkZFsTPgzHpEX3qq4N9ZvNERlkIhPQ5j8Y8Om1SJ2LUn
         G2JaQ0jBFYMBUsZwtix9lwmR0cmAqgyH3Fkoqssk1Rm9P2PG1Ts2wrNnCfCwEiNBPjvi
         XjGQidCxglmwtDLu1REcE2D5DBHHtJwCJwElRQ+o6CMg7twKYU7nCSRQDpYVnR2u+Wte
         1AHYDxDlzaxS3F/+v7EDJbvtMEfhvhwrVxSqpNTexGR9yXn8/s6GD2PIZq7voYUTpfBG
         xaDg==
X-Gm-Message-State: ANhLgQ1Fb8ENy/6e5qVVd620LFRfcr0aTfOOs3W3eIBMRVOZjvIq4Pqt
        wznHV6a/zcpQAwxnqVDwhAG5vjtYdhc7QiRGm1wxbQ==
X-Google-Smtp-Source: ADFU+vvE19wxL5rtzSJHtfP24vYg2RQ0hPsamDTSZSey9uqeZcOOUdGtWyRWVTq6NO8KjW7bNWK1TLSyh25Kf6XZSwM=
X-Received: by 2002:a05:6e02:543:: with SMTP id i3mr18189252ils.223.1585668732571;
 Tue, 31 Mar 2020 08:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-22-jinpu.wang@cloud.ionos.com> <ba7c258f-a169-f2d5-3d62-62a7d09908a4@acm.org>
 <CAMGffE=4LNom-aWJhogqjgD+mHPp1_B9g=rEzHzdr=x9Zy6vAw@mail.gmail.com>
In-Reply-To: <CAMGffE=4LNom-aWJhogqjgD+mHPp1_B9g=rEzHzdr=x9Zy6vAw@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 31 Mar 2020 17:32:01 +0200
Message-ID: <CAMGffEn2yPkxHAtrAO6CipJ=65Cbw9ENHxe_eatZNh=9fuNsow@mail.gmail.com>
Subject: Re: [PATCH v11 21/26] block/rnbd: server: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
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

snip
> >
> > > +static char *rnbd_srv_get_full_path(struct rnbd_srv_session *srv_sess,
> > > +                                  const char *dev_name)
> > > +{
> > > +     char *full_path;
> > > +     char *a, *b;
> > > +
> > > +     full_path = kmalloc(PATH_MAX, GFP_KERNEL);
> > > +     if (!full_path)
> > > +             return ERR_PTR(-ENOMEM);
> > > +
> > > +     /*
> > > +      * Replace %SESSNAME% with a real session name in order to
> > > +      * create device namespace.
> > > +      */
> > > +     a = strnstr(dev_search_path, "%SESSNAME%", sizeof(dev_search_path));
> > > +     if (a) {
> > > +             int len = a - dev_search_path;
> > > +
> > > +             len = snprintf(full_path, PATH_MAX, "%.*s/%s/%s", len,
> > > +                            dev_search_path, srv_sess->sessname, dev_name);
> > > +             if (len >= PATH_MAX) {
> > > +                     pr_err("Tooooo looong path: %s, %s, %s\n",
> > > +                            dev_search_path, srv_sess->sessname, dev_name);
> > > +                     kfree(full_path);
> > > +                     return ERR_PTR(-EINVAL);
> > > +             }
> > > +     } else {
> > > +             snprintf(full_path, PATH_MAX, "%s/%s",
> > > +                      dev_search_path, dev_name);
> > > +     }
> >
> > Has it been considered to use kasprintf() instead of kmalloc() + snprintf()?

I tried to convert to kasprintf, but it doesn't save line of code or
nor looks cleaner, I will keep as it is.

Thanks
