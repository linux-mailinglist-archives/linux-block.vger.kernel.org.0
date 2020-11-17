Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0FB2B57A2
	for <lists+linux-block@lfdr.de>; Tue, 17 Nov 2020 04:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgKQDCC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 16 Nov 2020 22:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgKQDCB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Nov 2020 22:02:01 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2178C0613D3
        for <linux-block@vger.kernel.org>; Mon, 16 Nov 2020 19:02:01 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id a15so7808683qvk.5
        for <linux-block@vger.kernel.org>; Mon, 16 Nov 2020 19:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=tHEfNcnIRkvXyGCCHO/UDmbAFAJz0dJrkFE89lZKlPk=;
        b=lPfSUWGsREiwtAsu4R9VYgvjYUXgPnRLL9z4gfQI6ZU5Y2Vm+oozIQxTEWrvJ1j9AU
         ZfGJKJuZqD6VGRjAkH2WQEFh5dycYWUB4eqq6xCkhnEkd4/ufntzUdiC0idjtbhUALPX
         1t2GIfBNwV22QcH9sYeZ67lidYJBsiic0Y+jJmkZxxs8RmSieOX4pofTAZ67gK3lDcr4
         N+Oj7IadhB4FdTPotN7/yOV33SKSKW7Bug5p9pijQamFLM6cNMe/Z3ey4SMGXDyXGQXs
         85mAHlM9pNLQvkfYiwb+0cStRohy4+0aLddqt/gSWOVJK8uad1ZRwVSDrnwa+0PWcYl+
         dm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=tHEfNcnIRkvXyGCCHO/UDmbAFAJz0dJrkFE89lZKlPk=;
        b=p8nX4ywJVnJ64QUwinHxG3/NYcG8hllgAFpkMARkgfE+aBHkGRg4vmCU5uAdCt2JGM
         6aAquHhvuDeE1fxSF9fEgscEzYS7xO8IF6tLdMhHCnw1qj87fL8cHAxF8jfgxNfd8MdO
         R9odiXLxAMU4XsQN6sIoDzY06dc59rY6tt7g5KnbelPrZIaeWFszKjPDimsQ6B9wxqTp
         SswhXiICTNzQtTHxYTWcX0BxWv0TYm7YFJwghMS3rfJHjjaVW4V3UnWL79DdEugcD1Cu
         5VC3XViN6xgT1LZPMh9oT3IvdWLiKieibhVeM2Urv9Xg8P0l2AL9+FTEP2zF4dOpZyI1
         DbWA==
X-Gm-Message-State: AOAM530+pHCSs/QX8gWDeFvIIos7bDOnK/KzSRB/jYvELw2LQ67xR8g+
        fxkdtAb1sgGFvk6q5ZJBNY441R14Rfrq2bxw16xY8Wku
X-Google-Smtp-Source: ABdhPJzCdjDTlYDKLMe1J3jfP0UtWQev5WePr2/cCRPUVtFL/wIENTh2ihcMXQX8N9k18jk6AL/IGDNsxH+TICk3Bpk=
X-Received: by 2002:a05:6214:a8a:: with SMTP id ev10mr18613569qvb.41.1605582120882;
 Mon, 16 Nov 2020 19:02:00 -0800 (PST)
MIME-Version: 1.0
References: <20201027045411.GA39796@192.168.3.9> <CAA70yB7bepwNPAMtxth8qJCE6sQM9vxr1A5sU8miFn3tSOSYQQ@mail.gmail.com>
In-Reply-To: <CAA70yB7bepwNPAMtxth8qJCE6sQM9vxr1A5sU8miFn3tSOSYQQ@mail.gmail.com>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Tue, 17 Nov 2020 11:01:49 +0800
Message-ID: <CAA70yB6caVcKjJOTkEZa9ZBzZAHPgYrsr9nZWDgm-tfPMLGXHQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] fix inaccurate io_ticks
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, mpatocka@redhat.com,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Ping

On Wed, Nov 4, 2020 at 11:26 AM Weiping Zhang <zwp10758@gmail.com> wrote:
>
> Ping
>
> On Wed, Oct 28, 2020 at 6:59 AM Weiping Zhang
> <zhangweiping@didiglobal.com> wrote:
> >
> > Hi,
> >
> > This patchset include two patches,
> >
> > 01. block: fix inaccurate io_ticks
> > fix the io_ticks if start a new IO and there is no inflight IO before.
> >
> > 02. blk-mq: break more earlier when interate hctx
> > An optimization for blk_mq_queue_inflight and blk_mq_part_is_in_flight
> > these two function only want to know if there is IO inflight and do
> > not care how many inflight IOs are there.
> > After this patch blk_mq_queue_inflight will stop interate other hctx
> > when find a inflight IO, blk_mq_part_is_in_inflight stop interate
> > other setbit/hctx when find a inflight IO.
> >
> > Changes since v4:
> >  * only get inflight in update_io_ticks when start a new IO every jiffy.
> >
> > Changes since v3:
> >  * add a parameter for blk_mq_queue_tag_busy_iter to break earlier
> >    when interate hctx of a queue, since blk_mq_part_is_in_inflight
> >    and blk_mq_queue_inflight do not care how many inflight IOs.
> >
> > Changes since v2:
> > * use blk_mq_queue_tag_busy_iter framework instead of open-code.
> > * update_io_ticks before update inflight for __part_start_io_acct
> >
> > Changes since v1:
> > * avoid iterate all tagset, return directly if find a set bit.
> > * fix some typo in commit message
> >
> > Weiping Zhang (2):
> >   block: fix inaccurate io_ticks
> >   blk-mq: break more earlier when interate hctx
> >
> >  block/blk-core.c       | 19 ++++++++++----
> >  block/blk-mq-tag.c     | 11 ++++++--
> >  block/blk-mq-tag.h     |  2 +-
> >  block/blk-mq.c         | 58 +++++++++++++++++++++++++++++++++++++++---
> >  block/blk-mq.h         |  1 +
> >  block/blk.h            |  1 +
> >  block/genhd.c          | 13 ++++++++++
> >  include/linux/blk-mq.h |  1 +
> >  8 files changed, 94 insertions(+), 12 deletions(-)
> >
> > --
> > 2.18.4
> >
