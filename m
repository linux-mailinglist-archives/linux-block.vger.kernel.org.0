Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45ADD4545ED
	for <lists+linux-block@lfdr.de>; Wed, 17 Nov 2021 12:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbhKQLyG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 17 Nov 2021 06:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbhKQLyF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 06:54:05 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF7CC061570
        for <linux-block@vger.kernel.org>; Wed, 17 Nov 2021 03:51:06 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b1so6949639lfs.13
        for <linux-block@vger.kernel.org>; Wed, 17 Nov 2021 03:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Cavz8giz7nRbnUmfk4z8/DCWkMdAcAjIcTcWpMQfKU=;
        b=H7Jwj6kyxygIuVvrkhLSA2ntz3NieAsUZprHoTh56FBFdGn2KcNMBy1fuds3ElDKbI
         CqRZneAEKfMitoqh/4TE1OVbGEIoAq1UVS2FOKIwOQaAzEb/usgu+N/QT0U/XfdN8OI9
         S8ZHR63T4NwJn+Oqq9EbEI88Kl2kk4CPcxdYgl91B5T6XNuBJvsfurkV5DS9aMqxMGYX
         JfFVjG3bNscr7aRrtuLOq8WaJyIFkRk/1gelWUvQ+kTgQtxK+5CpU7cFSGaAFOLL3RaD
         iy0VSlMKXRFbwZngY14YY1e29u/lnPPJ2oRyvYNEaB0/x15dmZF6uUHDo+jEuVUfKf5d
         F6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Cavz8giz7nRbnUmfk4z8/DCWkMdAcAjIcTcWpMQfKU=;
        b=RX09Lnlgk5Lo9a6C9hIT0Tst4/v2nW6WHVDAytfpnsGJPyVMGrnmdURVkN9SJZNYB8
         /Un0mXJnjU70GzpGaV0I/IvABr+TDtp0sQDNeyV6Q05T3WEVjOd4Rv65qTMa/kchMXe2
         Ms5hwXwPL+2TGHbSRYb9RSNd9P4Fr3DUoHIHSo0FiIx8AWxUzBmj5ZF+xeio1+dmNsGQ
         gpwpq/xvTHfqjfUsWWZIm/RDTPWdBQSW1wxLjXdsTgnmeSJvPNl4XJ3bEisrSpAIXB08
         IB+e42KGU+3WOlNIuMSc4+CtaJOsdZ11vMSHXJxKhEczNzdpCJnkZrmSDYcRq+oszVdH
         mWNA==
X-Gm-Message-State: AOAM5307r2iuROo/l1yZUqbLJxd0LEA1OYoMQ97hpraCJu8otFiDHUa2
        J0Xbn/VsW6LnXdp/LHoQXxuM+TIslMvEya+RBCU+BA==
X-Google-Smtp-Source: ABdhPJxRs1ft6K/fv4DzHGQp7lSSJdlMvX2FsfoputMFoKvlwOpsnHRmu8ev2YAz0HqGRCZuuCFZor1tDqQYjY7pquA=
X-Received: by 2002:a2e:985a:: with SMTP id e26mr7079623ljj.265.1637149864907;
 Wed, 17 Nov 2021 03:51:04 -0800 (PST)
MIME-Version: 1.0
References: <CAJpMwyixY_-AbMvtGGMBWBO3+oOEF9fuWHkYpLWDbXo3dcAGfg@mail.gmail.com>
 <YYsiqUpLdNtshZms@T590> <CAJpMwyhv0ccnLc1YjJypGs6khar+GjfgmBUH_f-ugo9hpM1Pig@mail.gmail.com>
 <YZJ1aty1WVkW55aI@T590>
In-Reply-To: <YZJ1aty1WVkW55aI@T590>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Wed, 17 Nov 2021 12:50:54 +0100
Message-ID: <CAJpMwyj4--c7OKdo2e_V4F87bX=CqKCpgYsRR4h1PvAYzUrkwA@mail.gmail.com>
Subject: Re: Observing an fio hang with RNBD device in the latest v5.10.78
 Linux kernel
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        sashal@kernel.org, jack@suse.cz, Jinpu Wang <jinpu.wang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 15, 2021 at 3:58 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Mon, Nov 15, 2021 at 02:01:32PM +0100, Haris Iqbal wrote:
> > On Wed, Nov 10, 2021 at 2:39 AM Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > Hello Haris,
> > >
> > > On Tue, Nov 09, 2021 at 10:32:32AM +0100, Haris Iqbal wrote:
> > > > Hi,
> > > >
> > > > We are observing an fio hang with the latest v5.10.78 Linux kernel
> > > > version with RNBD. The setup is as follows,
> > > >
> > > > On the server side, 16 nullblk devices.
> > > > On the client side, map those 16 block devices through RNBD-RTRS.
> > > > Change the scheduler for those RNBD block devices to mq-deadline.
> > > >
> > > > Run fios with the following configuration.
> > > >
> > > > [global]
> > > > description=Emulation of Storage Server Access Pattern
> > > > bssplit=512/20:1k/16:2k/9:4k/12:8k/19:16k/10:32k/8:64k/4
> > > > fadvise_hint=0
> > > > rw=randrw:2
> > > > direct=1
> > > > random_distribution=zipf:1.2
> > > > time_based=1
> > > > runtime=60
> > > > ramp_time=1
> > > > ioengine=libaio
> > > > iodepth=128
> > > > iodepth_batch_submit=128
> > > > iodepth_batch_complete=128
> > > > numjobs=1
> > > > group_reporting
> > > >
> > > >
> > > > [job1]
> > > > filename=/dev/rnbd0
> > > > [job2]
> > > > filename=/dev/rnbd1
> > > > [job3]
> > > > filename=/dev/rnbd2
> > > > [job4]
> > > > filename=/dev/rnbd3
> > > > [job5]
> > > > filename=/dev/rnbd4
> > > > [job6]
> > > > filename=/dev/rnbd5
> > > > [job7]
> > > > filename=/dev/rnbd6
> > > > [job8]
> > > > filename=/dev/rnbd7
> > > > [job9]
> > > > filename=/dev/rnbd8
> > > > [job10]
> > > > filename=/dev/rnbd9
> > > > [job11]
> > > > filename=/dev/rnbd10
> > > > [job12]
> > > > filename=/dev/rnbd11
> > > > [job13]
> > > > filename=/dev/rnbd12
> > > > [job14]
> > > > filename=/dev/rnbd13
> > > > [job15]
> > > > filename=/dev/rnbd14
> > > > [job16]
> > > > filename=/dev/rnbd15
> > > >
> > > > Some of the fio threads hangs and the fio never finishes.
> > > >
> > > > fio fio.ini
> > > > job1: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > > > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > > > job2: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > > > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > > > job3: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > > > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > > > job4: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > > > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > > > job5: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > > > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > > > job6: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > > > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > > > job7: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > > > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > > > job8: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > > > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > > > job9: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > > > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > > > job10: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > > > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > > > job11: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > > > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > > > job12: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > > > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > > > job13: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > > > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > > > job14: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > > > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > > > job15: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > > > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > > > job16: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > > > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > > > fio-3.12
> > > > Starting 16 processes
> > > > Jobs: 16 (f=12):
> > > > [m(3),/(2),m(5),/(1),m(1),/(1),m(3)][0.0%][r=130MiB/s,w=130MiB/s][r=14.7k,w=14.7k
> > > > IOPS][eta 04d:07h:4
> > > > Jobs: 15 (f=11):
> > > > [m(3),/(2),m(5),/(1),_(1),/(1),m(3)][51.2%][r=7395KiB/s,w=6481KiB/s][r=770,w=766
> > > > IOPS][eta 01m:01s]
> > > > Jobs: 15 (f=11): [m(3),/(2),m(5),/(1),_(1),/(1),m(3)][52.7%][eta 01m:01s]
> > > >
> > > > We checked the block devices, and there are requests waiting in their
> > > > fifo (not on all devices, just few whose corresponding fio threads are
> > > > hung).
> > > >
> > > > $ cat /sys/kernel/debug/block/rnbd0/sched/read_fifo_list
> > > > 00000000ce398aec {.op=READ, .cmd_flags=,
> > > > .rq_flags=SORTED|ELVPRIV|IO_STAT|HASHED, .state=idle, .tag=-1,
> > > > .internal_tag=209}
> > > > 000000005ec82450 {.op=READ, .cmd_flags=,
> > > > .rq_flags=SORTED|ELVPRIV|IO_STAT|HASHED, .state=idle, .tag=-1,
> > > > .internal_tag=210}
> > > >
> > > > $ cat /sys/kernel/debug/block/rnbd0/sched/write_fifo_list
> > > > 000000000c1557f5 {.op=WRITE, .cmd_flags=SYNC|IDLE,
> > > > .rq_flags=SORTED|ELVPRIV|IO_STAT|HASHED, .state=idle, .tag=-1,
> > > > .internal_tag=195}
> > > > 00000000fc6bfd98 {.op=WRITE, .cmd_flags=SYNC|IDLE,
> > > > .rq_flags=SORTED|ELVPRIV|IO_STAT|HASHED, .state=idle, .tag=-1,
> > > > .internal_tag=199}
> > > > 000000009ef7c802 {.op=WRITE, .cmd_flags=SYNC|IDLE,
> > > > .rq_flags=SORTED|ELVPRIV|IO_STAT|HASHED, .state=idle, .tag=-1,
> > > > .internal_tag=217}
> > >
> > > Can you post the whole debugfs log for rnbd0?
> > >
> > > (cd /sys/kernel/debug/block/rnbd0 && find . -type f -exec grep -aH . {} \;)
> >
> > Attached the logfile.
>
> logfile just shows that there are requests in scheduler queue.
>
> >
> > >
> > > >
> > > >
> > > > Potential points which fixes the hang
> > > >
> > > > 1) Using no scheduler (none) on the client side RNBD block devices
> > > > results in no hang.
> > > >
> > > > 2) In the fio config, changing the line "iodepth_batch_complete=128"
> > > > to the following fixes the hang,
> > > > iodepth_batch_complete_min=1
> > > > iodepth_batch_complete_max=128
> > > > OR,
> > > > iodepth_batch_complete=0
> > > >
> > > > 3) We also tracked down the version from which the hang started. The
> > > > hang started with v5.10.50, and the following commit was one which
> > > > results in the hang
> > > >
> > > > commit 512106ae2355813a5eb84e8dc908628d52856890
> > > > Author: Ming Lei <ming.lei@redhat.com>
> > > > Date:   Fri Jun 25 10:02:48 2021 +0800
> > > >
> > > >     blk-mq: update hctx->dispatch_busy in case of real scheduler
> > > >
> > > >     [ Upstream commit cb9516be7708a2a18ec0a19fe3a225b5b3bc92c7 ]
> > > >
> > > >     Commit 6e6fcbc27e77 ("blk-mq: support batching dispatch in case of io")
> > > >     starts to support io batching submission by using hctx->dispatch_busy.
> > > >
> > > >     However, blk_mq_update_dispatch_busy() isn't changed to update
> > > > hctx->dispatch_busy
> > > >     in that commit, so fix the issue by updating hctx->dispatch_busy in case
> > > >     of real scheduler.
> > > >
> > > >     Reported-by: Jan Kara <jack@suse.cz>
> > > >     Reviewed-by: Jan Kara <jack@suse.cz>
> > > >     Fixes: 6e6fcbc27e77 ("blk-mq: support batching dispatch in case of io")
> > > >     Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > >     Link: https://lore.kernel.org/r/20210625020248.1630497-1-ming.lei@redhat.com
> > > >     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > > >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > >
> > > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > > index 00d6ed2fe812..a368eb6dc647 100644
> > > > --- a/block/blk-mq.c
> > > > +++ b/block/blk-mq.c
> > > > @@ -1242,9 +1242,6 @@ static void blk_mq_update_dispatch_busy(struct
> > > > blk_mq_hw_ctx *hctx, bool busy)
> > > >  {
> > > >         unsigned int ewma;
> > > >
> > > > -       if (hctx->queue->elevator)
> > > > -               return;
> > > > -
> > > >         ewma = hctx->dispatch_busy;
> > > >
> > > >         if (!ewma && !busy)
> > > >
> > > > We reverted the commit and tested and there is no hang.
> > > >
> > > > 4) Lastly, we tested newer version like 5.13, and there is NO hang in
> > > > that also. Hence, probably some other change fixed it.
> > >
> > > Can you observe the issue on v5.10? Maybe there is one pre-patch of commit cb9516be7708
> > > ("blk-mq: update hctx->dispatch_busy in case of real scheduler merged")
> > > which is missed to 5.10.y.
> >
> > If you mean v5.10.0, then no, I see no hang there. As I mentioned
> > before, there is no hang till v5.10.49.
> >
> > >
> > > And not remember that there is fix for commit cb9516be7708 in mainline.
> > >
> > > commit cb9516be7708 is merged to v5.14, instead of v5.13, did you test v5.14 or v5.15?
> > >
> > > BTW, commit cb9516be7708 should just affect performance, not supposed to cause
> > > hang.
> >
> > True. It does look like that from the small code change.
>
> ->dispatch_busy just affects the batching size for dequeuing request
> from scheduler queue, see the following code in
> __blk_mq_do_dispatch_sched():
>
>         if (hctx->dispatch_busy)
>                 max_dispatch = 1;
>         else
>                 max_dispatch = hctx->queue->nr_requests;
>
>
> Also see blk_mq_do_dispatch_sched():
>
> static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> {
>         int ret;
>
>         do {
>                 ret = __blk_mq_do_dispatch_sched(hctx);
>         } while (ret == 1);
>
>         return ret;
> }
>
> If any request can be dispatched to driver, blk-mq will continue to
> dispatch until -EAGAIN or 0 is returned from __blk_mq_do_dispatch_sched().
>
> In case of -EAGAIN, blk-mq will try again to dispatch request and run
> queue asynchronously if another -EAGAIN is returend.
>
> In case of 0 returned, blk_mq_dispatch_rq_list() can't make progress,
> the request will be moved to hctx->dispatch, and blk-mq covers the
> re-run uueue until all requests in hctx->dispatch are dispatched, then
> still dispatch request from scheduler queue.
>
> So the current code has provided forward-progress, and I don't see how
> patch 'blk-mq: update hctx->dispatch_busy in case of real scheduler' can
> cause this issue.
>
> Also not see any request in hctx->dispatch from debugfs log.
>
> >
> > I wasn't able to test in v5.14 and v5.15 because we are seeing some
> > other errors in those versions, most probably related to the
> > rdma-core/rxe driver.
>
> I'd rather see test result on upstream kernel of v5.14 or v5.15 or recent
> v5.15-rc.

We were finally able to test in 5.15.2, and there is no hang.


>
>
>
> Thanks,
> Ming
>
