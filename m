Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2172112E6D5
	for <lists+linux-block@lfdr.de>; Thu,  2 Jan 2020 14:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgABNgH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 2 Jan 2020 08:36:07 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39208 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbgABNgG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jan 2020 08:36:06 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so8447283ioh.6
        for <linux-block@vger.kernel.org>; Thu, 02 Jan 2020 05:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XhevothgagHI/veyJj2E2XrnFq71ibbj9OxsYGO/W/8=;
        b=RZpmITJ4Lwv/7mlo2ll/BdQMzDDlZ6/oCbITnVj1EOZrF8i45ontXkvhz9ATxd2Wx0
         o13jvuIoaOUEmRZFWtsKKUJFdFKhilb3V7/YwZhOW7PVk9FE5HQ/xTxItp+AVcAqo0Z+
         yP+9lxeSoZYWJW9GgDIsbqPRJ1ZRNI0wODlCEWLcYs8TZzP2NXKKchVDlhbuuqyeOU3w
         58xxyW0pagAf3ocjtRe1UG/D/lxKSIqgVkW+PkbI/9AMwLMJajttLBZL0RBw6myPqyj7
         oE94d6PEwlmP6VMVrZJfdJ/fhCKQHUJDy+CILsJn3yKtUoJhyER2qcVUYOr28XkeA1/O
         xgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XhevothgagHI/veyJj2E2XrnFq71ibbj9OxsYGO/W/8=;
        b=hWyhbSdkRi5nFX1VVwcYfgqJ80H8+HMyuhU8Ltg3F2X8Ztj7OegToQvAQYjDhBVxnn
         46Aig45+UYeKgUlaJtb1ZdN2treH8ENDr43KykUualo69CqbH2N/UhVivCnbQQ8la8mX
         vRURHivbAH5e/xp+gwW24AYhwwLh9BIeoILfwfajo9lzMXWZfiD56Xe8z8hoS9SqIXVr
         O4aORNc6USQkI/R5L4o9aSI6x6HdypLi4Fck+mIdc+rQkFQaMDZqur4ycwnQnmcYHOoR
         PvNGGQyw46g10dg8GOacXl3/5YR8PD+bWYtUNZdlkNdstDcZyRJMN7rI1BoHf1WzaBSA
         DgCQ==
X-Gm-Message-State: APjAAAWIspkgKNdKE9U0eMVptngHRbpvMwKZFOHQ+Bia5Y382EuqVFdn
        gyiV9RbfiQjgXxIjhb8F/cM+1sCVjn7pWLKufYR+fA==
X-Google-Smtp-Source: APXvYqxF3bXG0cTEkPkpJKkFSi24+QpjzmsOhJ2ejAl8Z4LWgZgw0joytarQoEBuVO764JgLKpmtmd6idHK7Vp69DbA=
X-Received: by 2002:a02:6957:: with SMTP id e84mr62172486jac.11.1577972166002;
 Thu, 02 Jan 2020 05:36:06 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-3-jinpuwang@gmail.com>
 <cc66bb26-68da-8add-6813-a330dc23facd@acm.org>
In-Reply-To: <cc66bb26-68da-8add-6813-a330dc23facd@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 2 Jan 2020 14:35:55 +0100
Message-ID: <CAMGffEmdQ2SuP6JTrPYyP70ZYPC+H+GSyL2Lib7mbG4-DUN6Kg@mail.gmail.com>
Subject: Re: [PATCH v6 02/25] rtrs: public interface header to establish RDMA connections
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

On Mon, Dec 30, 2019 at 8:25 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2019-12-30 02:29, Jack Wang wrote:
> > +/*
> > + * Here goes RTRS client API
> > + */
>
> A comment that explains what the abbreviation "RTRS" stands for would be
> welcome here. Additionally, I think that "Here goes" can be left out.
will do.
>
> > +/**
> > + * rtrs_clt_open() - Open a session to an RTRS server
> > + * @priv: User supplied private data.
> > + * @link_ev: Event notification for connection state changes
>
> Please mention that @link_ev is a callback function.
Ok.
>
> > + *   @priv: User supplied data that was passed to rtrs_clt_open()
> > + *   @ev: Occurred event
>
> Is this patch series W=1 clean? @link_ev arguments should be documented
> above the link_clt_ev_fn typedef.
We will make sure it's W=1 clean in next round.
>
> > + * @path_cnt: Number of elemnts in the @paths array
>
> elemnts -> elements?
will fix.
>
> > + * Starts session establishment with the rtrs_server. The function can block
> > + * up to ~2000ms until it returns.
>
> until -> before?
will fix
>
> > +struct rtrs_clt *rtrs_clt_open(void *priv, link_clt_ev_fn *link_ev,
> > +                              const char *sessname,
> > +                              const struct rtrs_addr *paths,
> > +                              size_t path_cnt, short port,
> > +                              size_t pdu_sz, u8 reconnect_delay_sec,
> > +                              u16 max_segments,
> > +                              s16 max_reconnect_attempts);
>
> Since the range for port numbers is 1..65535, please change "short port"
> into "u16 port".
ok.
>
> > +/**
> > + * enum rtrs_clt_con_type() type of ib connection to use with a given permit
>
> What is a "permit"?
Does use rtrs_permit sound better?
>
> > + * @vec:     Message that is send to server together with the request.
>
> send -> sent?
right.
>
> > + *           Sum of len of all @vec elements limited to <= IO_MSG_SIZE.
> > + *           Since the msg is copied internally it can be allocated on stack.
> > + * @nr:              Number of elements in @vec.
> > + * @len:     length of data send to/from server
>
> send -> sent?
right.
>
> > +/**
> > + * link_ev_fn():     Events about connective state changes
>
> connective -> connection?
connectivity I think, will fix.
>
> > +/**
> > + * rtrs_srv_open() - open RTRS server context
> > + * @ops:             callback functions
> > + *
> > + * Creates server context with specified callbacks.
> > + *
> > + * Return a valid pointer on success otherwise PTR_ERR.
> > + */
> > +struct rtrs_srv_ctx *rtrs_srv_open(rdma_ev_fn *rdma_ev, link_ev_fn *link_ev,
> > +                                  unsigned int port);
>
> Is this patch series W=1 clean? The documented argument does not match
> the actual argument list.
As replied above we will make sure it's W=1 clean when sending next round.
>
> Bart.
Thanks, Bart
