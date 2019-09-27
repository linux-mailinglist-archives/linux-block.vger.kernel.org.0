Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFB5BC034E
	for <lists+linux-block@lfdr.de>; Fri, 27 Sep 2019 12:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfI0KSa (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 27 Sep 2019 06:18:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36748 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfI0KSa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Sep 2019 06:18:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id y19so2095057wrd.3
        for <linux-block@vger.kernel.org>; Fri, 27 Sep 2019 03:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W4mjtQG5Imh75tKdsAQD42fSl5ICCejDjueWh/TvKFo=;
        b=Y7wUpUWS4BGj/yBD9aEkqcS+T04JarEjRIPFZUOMIKQ7ugHxgQTWXepHdGnJ0Di+Ar
         c1azyowTmw35FO0hl3swnVpGCC2QPmnRUZNjoHTjg4jBj2TJWlNnC59DPrTOvxCsmJKG
         Xoi6W24xM51eUlWEFI9BKeY3eEEO7wCiGsntodBTlXTvIwhFqkJWFQn90eHiR/G+owf+
         D3mUabb9OVjDVDKE9rzq0+YPh7+A03s8bsBpuROJoO1xFgoCAdrcE3aU9oQ6s+YKzwlc
         RO0aJ0B7ItdxszBWng0MTg4B5I0YnWT5IlDbkeB/zCS7Vu1UaPI5hfX+4sFjngbw5BAG
         YDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W4mjtQG5Imh75tKdsAQD42fSl5ICCejDjueWh/TvKFo=;
        b=f91iqk7nPqdt+ya1zcNQ7xYpFUe5HysCPiQABJkfWcHyxIy5JRVVhO3vFbgTPEBhTd
         Lg5lgXfVhPIaxRWgHDQ++GxqshE5FT9qGK01A0u6L9gCws05YpJ8lKrjfQ8pIUTljCD7
         K6+waRky1Tk1Scr1IlUq1TU1iC5/NTd8kNsJblywWsQsAnW9d37gXkhfpUUdj9hoflrC
         QuvhddC62tt2XpErxnhEi63yS7r0Pqbf+7xI3MKLQg8Kl5YtAD9tXcRuPxhdKwrtU2sH
         cgIHymtnINix1dVQ9wNbqBnwDmLtCkz8PnRnFHMab7th51xObZjKYWJwvnYAhAu7jIX0
         tjZg==
X-Gm-Message-State: APjAAAUhhDYm9ac0p68ZyB83i+RZu9Z6GGWcENrnu4/FKkUKJLwqzlai
        60hJEPk43RWeyYg/aKwaNUqCTIOR5gYfq39vmI9rWKXx
X-Google-Smtp-Source: APXvYqzX0ZjWxyaCqAdZsGw2n7sDYuJCK0i67LsmWdLWDK2vHQHVu3LYMxYVHRsitGAOi36pv/BKeBIZ7wJmyef1aGE=
X-Received: by 2002:adf:d192:: with SMTP id v18mr1365357wrc.9.1569579508188;
 Fri, 27 Sep 2019 03:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-6-jinpuwang@gmail.com>
 <c74a0a2b-c095-42e0-8cf9-e38e0cd6d6a7@acm.org>
In-Reply-To: <c74a0a2b-c095-42e0-8cf9-e38e0cd6d6a7@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 27 Sep 2019 12:18:17 +0200
Message-ID: <CAMGffEnH3A0S7WhRseiLFK5oLbw3L6ndLt7wuW5QYggV+QXJnQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/25] ibtrs: client: private header with client
 structs and functions
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

On Tue, Sep 24, 2019 at 1:05 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 6/20/19 8:03 AM, Jack Wang wrote:
> > +static inline const char *ibtrs_clt_state_str(enum ibtrs_clt_state state)
> > +{
> > +     switch (state) {
> > +     case IBTRS_CLT_CONNECTING:
> > +             return "IBTRS_CLT_CONNECTING";
> > +     case IBTRS_CLT_CONNECTING_ERR:
> > +             return "IBTRS_CLT_CONNECTING_ERR";
> > +     case IBTRS_CLT_RECONNECTING:
> > +             return "IBTRS_CLT_RECONNECTING";
> > +     case IBTRS_CLT_CONNECTED:
> > +             return "IBTRS_CLT_CONNECTED";
> > +     case IBTRS_CLT_CLOSING:
> > +             return "IBTRS_CLT_CLOSING";
> > +     case IBTRS_CLT_CLOSED:
> > +             return "IBTRS_CLT_CLOSED";
> > +     case IBTRS_CLT_DEAD:
> > +             return "IBTRS_CLT_DEAD";
> > +     default:
> > +             return "UNKNOWN";
> > +     }
> > +}
>
> Since this code is not in the hot path, please move it from a .h into a
> .c file.
ok.
>
> > +static inline struct ibtrs_clt_con *to_clt_con(struct ibtrs_con *c)
> > +{
> > +     return container_of(c, struct ibtrs_clt_con, c);
> > +}
> > +
> > +static inline struct ibtrs_clt_sess *to_clt_sess(struct ibtrs_sess *s)
> > +{
> > +     return container_of(s, struct ibtrs_clt_sess, s);
> > +}
>
> Is it really useful to define functions for these conversions? Has it
> been considered to inline these functions?
We use them quite some places, it does make the code shorter.


Thanks
Jinpu Wang
