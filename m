Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F21521A1AC4
	for <lists+linux-block@lfdr.de>; Wed,  8 Apr 2020 06:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgDHELr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 8 Apr 2020 00:11:47 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:35489 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgDHELp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Apr 2020 00:11:45 -0400
Received: by mail-vk1-f195.google.com with SMTP id f17so1519885vkk.2
        for <linux-block@vger.kernel.org>; Tue, 07 Apr 2020 21:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=29RESvw14n3QpfFzCuKFjHgcSWrNtIXHAxmZ77r+Fng=;
        b=DAf1pyACJDlNGd5wltvkCLb8cJP7sqJtdNTxJSU3iYq3ShjQhmCstm/IEX7gZuRciW
         YiK0a5LnOxqVjkFES7eoMnlr5j/CylspI8sDORtxgaA5U3bK99kH31Ukn5/Kr2PGUwzl
         8cvA/kIAiYiB+5gV9sjVYMlKW7Ja/V7T2AQ38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=29RESvw14n3QpfFzCuKFjHgcSWrNtIXHAxmZ77r+Fng=;
        b=TVcYRMcQJzfKu0azNZAkM52H/HlfMVEytg546yCF0QV22CNhKPLPSNIr+YQdKYs8p2
         c3lrzv6QV/w+UFot/h3AxKWbf0SJPd7Q75Tdfqk16hEu42jdFeqHV5buXZgGPFG24+nr
         7sxQ9P/tRv9ok9idG2lRcOAe/XlUV+m1/yCoYE82Oz/4TkORqUvV2Ey78XbDKJShtoHW
         GsimaSwtardVw9IawDvwQaY0DQBXEkqwQEM4PXIa8WNGNYDtBBkaVZFf30qhmOqOXydK
         Q4BkeHNisVUL4KIjxEDL/uBTTq9hN8MqGTzzsav2ri3qILaApRyvkklviro3Nc6D32J5
         xlvg==
X-Gm-Message-State: AGi0PubthW5m/ZVeQ4kAU07+mCUNAu7SUedc60Bc6iBmBlghgYIwRiHu
        p0SbJQSMVVfCwIghAbJwhoCeZBJDK8I=
X-Google-Smtp-Source: APiQypIJtHMaUzDqsSTZJm5bOKsYugRN49BGwcK0fwkxw65pba2fQxkebBCpdT+IgeFg9Fa6mBTjvg==
X-Received: by 2002:a1f:ce83:: with SMTP id e125mr4067068vkg.10.1586319102665;
        Tue, 07 Apr 2020 21:11:42 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id x4sm6114638vke.14.2020.04.07.21.11.41
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 21:11:41 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id z125so3852581vsb.13
        for <linux-block@vger.kernel.org>; Tue, 07 Apr 2020 21:11:41 -0700 (PDT)
X-Received: by 2002:a05:6102:3204:: with SMTP id r4mr4521784vsf.109.1586319100640;
 Tue, 07 Apr 2020 21:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200407220005.119540-1-dianders@chromium.org>
 <20200407145906.v3.3.I28278ef8ea27afc0ec7e597752a6d4e58c16176f@changeid>
 <20200408020936.GB337494@localhost.localdomain> <CAD=FV=WY8sTZQq3NtNe4Ux-C0Q0JOR4V1Z+cjVvj791rFDL+=Q@mail.gmail.com>
 <20200408030625.GC337494@localhost.localdomain>
In-Reply-To: <20200408030625.GC337494@localhost.localdomain>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Apr 2020 21:11:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VUAyuMnvVwz7OGoe03o4ty1S=44sjkGsFaDR5OJbeCPg@mail.gmail.com>
Message-ID: <CAD=FV=VUAyuMnvVwz7OGoe03o4ty1S=44sjkGsFaDR5OJbeCPg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] blk-mq: Rerun dispatching in the case of budget contention
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Salman Qazi <sqazi@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-block <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On Tue, Apr 7, 2020 at 8:06 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Tue, Apr 07, 2020 at 07:17:49PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Apr 7, 2020 at 7:09 PM Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > On Tue, Apr 07, 2020 at 03:00:04PM -0700, Douglas Anderson wrote:
> > > > If ever a thread running blk-mq code tries to get budget and fails it
> > > > immediately stops doing work and assumes that whenever budget is freed
> > > > up that queues will be kicked and whatever work the thread was trying
> > > > to do will be tried again.
> > > >
> > > > One path where budget is freed and queues are kicked in the normal
> > > > case can be seen in scsi_finish_command().  Specifically:
> > > > - scsi_finish_command()
> > > >   - scsi_device_unbusy()
> > > >     - # Decrement "device_busy", AKA release budget
> > > >   - scsi_io_completion()
> > > >     - scsi_end_request()
> > > >       - blk_mq_run_hw_queues()
> > > >
> > > > The above is all well and good.  The problem comes up when a thread
> > > > claims the budget but then releases it without actually dispatching
> > > > any work.  Since we didn't schedule any work we'll never run the path
> > > > of finishing work / kicking the queues.
> > > >
> > > > This isn't often actually a problem which is why this issue has
> > > > existed for a while and nobody noticed.  Specifically we only get into
> > > > this situation when we unexpectedly found that we weren't going to do
> > > > any work.  Code that later receives new work kicks the queues.  All
> > > > good, right?
> > > >
> > > > The problem shows up, however, if timing is just wrong and we hit a
> > > > race.  To see this race let's think about the case where we only have
> > > > a budget of 1 (only one thread can hold budget).  Now imagine that a
> > > > thread got budget and then decided not to dispatch work.  It's about
> > > > to call put_budget() but then the thread gets context switched out for
> > > > a long, long time.  While in this state, any and all kicks of the
> > > > queue (like the when we received new work) will be no-ops because
> > > > nobody can get budget.  Finally the thread holding budget gets to run
> > > > again and returns.  All the normal kicks will have been no-ops and we
> > > > have an I/O stall.
> > > >
> > > > As you can see from the above, you need just the right timing to see
> > > > the race.  To start with, the only case it happens if we thought we
> > > > had work, actually managed to get the budget, but then actually didn't
> > > > have work.  That's pretty rare to start with.  Even then, there's
> > > > usually a very small amount of time between realizing that there's no
> > > > work and putting the budget.  During this small amount of time new
> > > > work has to come in and the queue kick has to make it all the way to
> > > > trying to get the budget and fail.  It's pretty unlikely.
> > > >
> > > > One case where this could have failed is illustrated by an example of
> > > > threads running blk_mq_do_dispatch_sched():
> > > >
> > > > * Threads A and B both run has_work() at the same time with the same
> > > >   "hctx".  Imagine has_work() is exact.  There's no lock, so it's OK
> > > >   if Thread A and B both get back true.
> > > > * Thread B gets interrupted for a long time right after it decides
> > > >   that there is work.  Maybe its CPU gets an interrupt and the
> > > >   interrupt handler is slow.
> > > > * Thread A runs, get budget, dispatches work.
> > > > * Thread A's work finishes and budget is released.
> > > > * Thread B finally runs again and gets budget.
> > > > * Since Thread A already took care of the work and no new work has
> > > >   come in, Thread B will get NULL from dispatch_request().  I believe
> > > >   this is specifically why dispatch_request() is allowed to return
> > > >   NULL in the first place if has_work() must be exact.
> > > > * Thread B will now be holding the budget and is about to call
> > > >   put_budget(), but hasn't called it yet.
> > > > * Thread B gets interrupted for a long time (again).  Dang interrupts.
> > > > * Now Thread C (maybe with a different "hctx" but the same queue)
> > > >   comes along and runs blk_mq_do_dispatch_sched().
> > > > * Thread C won't do anything because it can't get budget.
> > >
> > > Thread C will re-run queue in this case:
> > >
> > > Just thought scsi_mq_get_budget() does handle the case via re-run queue:
> > >
> > >         if (atomic_read(&sdev->device_busy) == 0 && !scsi_device_blocked(sdev))
> > >                 blk_mq_delay_run_hw_queue(hctx, SCSI_QUEUE_DELAY);
> > >
> > > So looks no such race.
> >
> > Thread B is holding budget and hasn't released it yet, right?  In the
> > context of scsi, that means "device_busy >= 1", right?  So how can the
> > code you point at help us?  When Thread C reads "device_busy" it will
> > be 1 and that code won't run.  What did I miss?
>
> Oh, this is my fault, sorry for the noise.
>
> >
> >
> > > > * Finally Thread B will run again and put the budget without kicking
> > > >   any queues.
> > > >
> > > > Even though the example above is with blk_mq_do_dispatch_sched() I
> > > > believe the race is possible any time someone is holding budget but
> > > > doesn't do work.
> > > >
> > > > Unfortunately, the unlikely has become more likely if you happen to be
> > > > using the BFQ I/O scheduler.  BFQ, by design, sometimes returns "true"
> > > > for has_work() but then NULL for dispatch_request() and stays in this
> > > > state for a while (currently up to 9 ms).  Suddenly you only need one
> > > > race to hit, not two races in a row.  With my current setup this is
> > > > easy to reproduce in reboot tests and traces have actually shown that
> > > > we hit a race similar to the one describe above.
> > > >
> > > > In theory we could choose to just fix blk_mq_do_dispatch_sched() to
> > > > kick the queues when it puts budget.  That would fix the BFQ case and
> > > > one could argue that all the other cases are just theoretical.  While
> > > > that is true, for all the other cases it should be very uncommon to
> > > > run into the case where we need put_budget().  Having an extra queue
> > > > kick for safety there shouldn't affect much and keeps the race at bay.
> > > >
> > > > One last note is that (at least in the SCSI case) budget is shared by
> > > > all "hctx"s that have the same queue.  Thus we need to make sure to
> > > > kick the whole queue, not just re-run dispatching on a single "hctx".
> > > >
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > ---
> > > >
> > > > Changes in v3:
> > > > - Always kick when putting the budget.
> > > > - Delay blk_mq_do_dispatch_sched() kick by 3 ms for inexact has_work().
> > > > - Totally rewrote commit message.
> > > >
> > > > Changes in v2:
> > > > - Replace ("scsi: core: Fix stall...") w/ ("blk-mq: Rerun dispatch...")
> > > >
> > > >  block/blk-mq.h | 14 +++++++++++++-
> > > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/block/blk-mq.h b/block/blk-mq.h
> > > > index 10bfdfb494fa..1270505367ab 100644
> > > > --- a/block/blk-mq.h
> > > > +++ b/block/blk-mq.h
> > > > @@ -180,12 +180,24 @@ unsigned int blk_mq_in_flight(struct request_queue *q, struct hd_struct *part);
> > > >  void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
> > > >                        unsigned int inflight[2]);
> > > >
> > > > +#define BLK_MQ_BUDGET_DELAY  3               /* ms units */
> > > > +
> > > >  static inline void blk_mq_put_dispatch_budget(struct blk_mq_hw_ctx *hctx)
> > > >  {
> > > >       struct request_queue *q = hctx->queue;
> > > >
> > > > -     if (q->mq_ops->put_budget)
> > > > +     if (q->mq_ops->put_budget) {
> > > >               q->mq_ops->put_budget(hctx);
> > > > +
> > > > +             /*
> > > > +              * The only time we call blk_mq_put_dispatch_budget() is if
> > > > +              * we released the budget without dispatching.  Holding the
> > > > +              * budget could have blocked any "hctx"s with the same queue
> > > > +              * and if we didn't dispatch then there's no guarantee anyone
> > > > +              * will kick the queue.  Kick it ourselves.
> > > > +              */
> > > > +             blk_mq_delay_run_hw_queues(q, BLK_MQ_BUDGET_DELAY);
> > >
> > > No, please don't do that un-conditionally we just need to re-run queue
> > > when there has work to do.
> >
> > ...what function would you like me to call to check?  The code you
>
> At least we only need to call it in blk_mq_do_dispatch_sched() and
> blk_mq_do_dispatch_ctx(), in which no request is dequeued yet. Other
> callers can handle the run queue cause request has been there.

Sure, I can move it so it's only in blk_mq_do_dispatch_sched() and
blk_mq_do_dispatch_ctx().  That would definitely make it so that I
can't reproduce problems anymore, at least.

The one thing that worries me is that I couldn't come up with a
convincing argument about why the race wasn't possible when we put the
budget in blk_mq_dispatch_rq_list() and __blk_mq_try_issue_directly().
Perhaps you can explain.  In blk_mq_dispatch_rq_list() I can see that
we will call blk_mq_run_hw_queue() or blk_mq_delay_run_hw_queue(), but
I guess I'm at least slightly worried that we'd also need to kick the
other "hctx"s on the same queue.  In theory holding budget could have
block those as well.  Do we care?  Maybe we should always assume that
the scheduler has a global queue across all "hctx"s?


> > wrote in response to v2 only checked work for the given "hctx".  What
> > about other "hctx" that are part of the same "queue".  Are we
> > guaranteed that has_work() returns the same value for all "hctx"s on
> > the same "queue"?
>
> In theory has_work() should return ture when there is work associated with
> this hctx. However, some schedulers put all requests in global scheduler
> queue instead of per-hctx, then this scheduler's
> has_work() returns true when there is any request in scheduler queue.

Assuming we care about supporting schedulers that don't have a global
scheduler queue, it seems important to kick all the queues.  However,
if you tell me that all the code is already assuming a global
scheduler code then I can change my code to assume that too.


> > If so, why doesn't has_work() take the "queue" as a
> > parameter?
>
> In theory has_work() needs to be checked before run queue, however this
> code path should be called very unusually, so it is fine to just run all
> hctxs.

OK, thanks for confirming.  If you tell me that we should assume that
all IO schedulers have a global scheduler queue then I'll add the
has_work() check back in.  Otherwise I'll leave it as-is.

-Doug
