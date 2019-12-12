Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2939911CC15
	for <lists+linux-block@lfdr.de>; Thu, 12 Dec 2019 12:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfLLLUO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Dec 2019 06:20:14 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45124 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728959AbfLLLUO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 06:20:14 -0500
Received: by mail-lj1-f193.google.com with SMTP id d20so1815709ljc.12
        for <linux-block@vger.kernel.org>; Thu, 12 Dec 2019 03:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P1W0z4HqV64jzJwtaYcGadzOgRZCn2v4chbYC9m9FGs=;
        b=ejIqzn/RWAjyKo7RBVFzhGkFkF2lSZiGd2eJMd8SI1r0ISOjFbygsYsgAQN8XmQzQk
         0lLFXQhwKM1eITsy4avAQxAh9YW73FCSxA30SOO4ebLCpg54/FqhH1kVEkL7cqr550+3
         I9a9nPQN0ywXQrPzcfOaggdXetKiYHLmJjI+1DZc9EUMx2O/iWPayKLBlkjZYv4V8NgJ
         nan9YSgU3ufNHuyQvCbLyfmekHqbVqfxJNEwf9KzEqsovts3q/fPjhlFqhuzDFb1nWyW
         xAcA0eUqzW/MADBAAmUvKLx8NNJDQc7mcfuqeaYrbAn5Geo/v9v5h5dAUr3AVBKVcV47
         h5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P1W0z4HqV64jzJwtaYcGadzOgRZCn2v4chbYC9m9FGs=;
        b=sDct5llod5x3UA35cRor4xztZJg0ws7AOpWeZ4WXkwcgr7H7wwxZkHytHoXgJVizhP
         aFgDs48uF2TE3RaL86lA2mo7zy7tVpLYfvwdT1n80VdjiRHkNEOzczWU61a1n1WC7H+2
         JNjV9MsfvWQrXjttBM4gxtzge7DtlfaSyypXSU7uxobpT6mTivDMNP7Qt8aA8ZTYoZmw
         Yb4XFH4lWHHth/tLePBggTzO4Ba2HiZBhWs7r66m1BXuboVqSgdFK3eBpQMKvbn3FD/J
         wVCyLnyOiTs7AD13TfAFZuuvmqOY8YENEkcstarldUBD6BbFHfMNdi4VPztRwoHAagwi
         bqeQ==
X-Gm-Message-State: APjAAAWM0r5TGZObv//oQb9635QQfaZWMr2kZtws3aXx3lDDj7qLSEAy
        gCTVjEh4tXea50r3ADOErir/CukpeHDFgSrfjH2kpg==
X-Google-Smtp-Source: APXvYqwcNMZYiNwnTt8iXUn4bZLBe/VVIuZbWOxdaGwBRPCIZF6vo/z0Flel1o/NxhVXsNhFkAgOrX3kstFVUuexBm4=
X-Received: by 2002:a2e:9a51:: with SMTP id k17mr5118022ljj.206.1576149612570;
 Thu, 12 Dec 2019 03:20:12 -0800 (PST)
MIME-Version: 1.0
References: <20191120220313.GC18056@pauld.bos.csb> <20191121132937.GW4114@hirez.programming.kicks-ass.net>
 <20191209165122.GA27229@linux.vnet.ibm.com> <20191209231743.GA19256@dread.disaster.area>
 <20191210054330.GF27253@linux.vnet.ibm.com> <20191210172307.GD9139@linux.vnet.ibm.com>
 <20191211173829.GB21797@linux.vnet.ibm.com> <20191211224617.GE19256@dread.disaster.area>
 <20191212101031.GV2827@hirez.programming.kicks-ass.net> <20191212101424.GH2871@hirez.programming.kicks-ass.net>
 <20191212102327.GI2871@hirez.programming.kicks-ass.net>
In-Reply-To: <20191212102327.GI2871@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 12 Dec 2019 12:20:01 +0100
Message-ID: <CAKfTPtCUm5vuvNiWszJ5tWHxmcZ2v_KexOxnBHLUkBcqC-P3fw@mail.gmail.com>
Subject: Re: [PATCH v4] sched/core: Preempt current task in favour of bound kthread
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Phil Auld <pauld@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fs <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 12 Dec 2019 at 11:23, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Dec 12, 2019 at 11:14:24AM +0100, Peter Zijlstra wrote:
> > On Thu, Dec 12, 2019 at 11:10:31AM +0100, Peter Zijlstra wrote:
> > > @@ -4156,13 +4159,13 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> > >     if (delta_exec < sysctl_sched_min_granularity)
> > >             return;
> > >
> > > -   se = __pick_first_entity(cfs_rq);
> > > +   se = __pick_next_entity(cfs_rq, NULL);
> > >     delta = curr->vruntime - se->vruntime;
> > >
> > >     if (delta < 0)
> > >             return;
> >
> > What I mean with the below comment is, when this isn't enough, try
> > something like:
> >
> >       if (se == cfs_rq->next)
> >               ideal_runtime /= 2;
> >
> > to make it yield sooner to 'next' buddies. Sadly, due to the whole
> > cgroup mess, we can't say what actual task is on the end of it (without
> > doing a full hierarchy pick, which is more expensive still).
>
> Just for giggles, that'd look something like:
>
>         while (!entity_is_task(se) {
>                 cfs_rq = group_cfs_rq(se);
>                 se = pick_next_entity(cfs_rq, cfs_rq->curr);
>         }
>         p = task_of(se);
>
>         if (is_per_cpu_kthread(p))
>                 ideal_runtime /= 2;
>
> the core-scheduling patch set includes the right primitive for this I
> think, pick_task_fair().

why not only updating wan_gran() which is the only function which uses
sysctl_sched_wakeup_granularity ?

For per cpu kthread, we could set the gran to sched_min_granularity
instead of scaling it with thread's priority so per cpu kthread can
still preempt current ask even if sysctl_sched_wakeup_granularity is
large

>
> > > -   if (delta > ideal_runtime)
> > > +   if (delta > ideal_runtime) // maybe frob this too ?
> > >             resched_curr(rq_of(cfs_rq));
> > >  }
