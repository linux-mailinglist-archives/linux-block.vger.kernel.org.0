Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80B147AA14
	for <lists+linux-block@lfdr.de>; Mon, 20 Dec 2021 14:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhLTNDp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 20 Dec 2021 08:03:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29933 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231980AbhLTNDp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Dec 2021 08:03:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640005424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XBpnjd0qJqx5setzEXTieOlKMvhEu72PDNDbPO3CE2U=;
        b=EvY2EzcC+dvaX1FljiqA1mEQKDuPoQ+bd9+jCDmvtDzlTjLgNNnd80oOTRqtajAcTi2T/m
        m9rJ0Y17BAWQCAUpBa8YGq3oRwqwHENpHMejlbbJMsFrvkq1iIjoBCIOULZQnVZkyv2Trr
        IjdtvVX60vEPAyI1ZsbmiSs0SDrW/qs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-U9ptFzlzP0mXMbdHpyj-kg-1; Mon, 20 Dec 2021 08:03:43 -0500
X-MC-Unique: U9ptFzlzP0mXMbdHpyj-kg-1
Received: by mail-ed1-f70.google.com with SMTP id w17-20020a056402269100b003f7ed57f96bso7477952edd.16
        for <linux-block@vger.kernel.org>; Mon, 20 Dec 2021 05:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XBpnjd0qJqx5setzEXTieOlKMvhEu72PDNDbPO3CE2U=;
        b=7BIbN73Lp/lzL9eyvCR1RJtJZIgzQh6Wn0WsE+zZV7swoiZI57rv61sSO8v/2i3BCM
         aAtaRZ86MuNJIXMpY6hIVSZ+mjvQc23ccTeyrtOmtV0X49m9eeowAmxWp8JBrY+qSDVO
         RT+DL+s//dkdKt16UFTVrNMA/kGldDcdd0RfURSR/DzoncceeaDyRf74Lym3MFl+SGV5
         GQynmccqXUj6bo38u3hNK7vQyUSnp/1KgS/GstMgd7Ft2YmAby5P4R9ln1B8dU60o8xM
         saYcQAi44qzO772ZXYX5yHwK4lPIVbpavb7raHDKxb/o384jiILsDu10sawjmwpvNh1F
         XHWQ==
X-Gm-Message-State: AOAM530HZR2pNLJ5pM1obOI01/LSVtJ9r2DV8Dlk1HefucXzdInO3B0q
        cOfiKg9HJ6Bkke/87mvRVgZRb5D9DYrf0f0u3xxMkWFh0yhm0OV2qLgMXZKlRUE7cog/vd5uCT/
        gPilgYqNctAEKcHYJMhaIw+iACchibUDaG+I/DIc=
X-Received: by 2002:a05:6402:292e:: with SMTP id ee46mr16034900edb.222.1640005422139;
        Mon, 20 Dec 2021 05:03:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5qkWn7Z2+JMkK3+w0SkB4ygK8sjuRNxin0OqX57PkQ1C+0NTUgch9nFnWhDS5hJhjh2ZJJB37/uIp3Zw0bQM=
X-Received: by 2002:a05:6402:292e:: with SMTP id ee46mr16034878edb.222.1640005421923;
 Mon, 20 Dec 2021 05:03:41 -0800 (PST)
MIME-Version: 1.0
References: <20211217141656.8720-1-wander@redhat.com> <YcBVcOkWumdpjtvI@linutronix.de>
In-Reply-To: <YcBVcOkWumdpjtvI@linutronix.de>
From:   Wander Costa <wcosta@redhat.com>
Date:   Mon, 20 Dec 2021 10:03:30 -0300
Message-ID: <CAAq0SU=5_K-qk9C5KWjot-FtN8fK88V7iAFynDf=-MGhfitqBg@mail.gmail.com>
Subject: Re: [PATCH v3] blktrace: switch trace spinlock to a raw spinlock
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 20, 2021 at 7:05 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2021-12-17 11:16:56 [-0300], Wander Lairson Costa wrote:
>
> Assuming neither Steven nor Jens object,
>
> > TRACE_EVENT disables preemption before calling the callback. Because of
> > that blktrace triggers the following bug under PREEMPT_RT:
>
> The tracepoint is invoked with disabled preemption.
>
> >  BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35
> >  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 119, name: kworker/u2:2
> >  5 locks held by kworker/u2:2/119:
> >   #0: ffff8c2e4a88f538 ((wq_completion)xfs-cil/dm-0){+.+.}-{0:0}, at: process_one_work+0x200/0x450
> >   #1: ffffab3840ac7e68 ((work_completion)(&cil->xc_push_work)){+.+.}-{0:0}, at: process_one_work+0x200/0x450
> >   #2: ffff8c2e4a887128 (&cil->xc_ctx_lock){++++}-{3:3}, at: xlog_cil_push_work+0xb7/0x670 [xfs]
> >   #3: ffffffffa6a63780 (rcu_read_lock){....}-{1:2}, at: blk_add_trace_bio+0x0/0x1f0
> >   #4: ffffffffa6610620 (running_trace_lock){+.+.}-{2:2}, at: __blk_add_trace+0x3ef/0x480
> >  Preemption disabled at:
> >  [<ffffffffa4d35c05>] migrate_enable+0x45/0x140
> >  CPU: 0 PID: 119 Comm: kworker/u2:2 Kdump: loaded Not tainted 5.14.0-25.rt21.25.light.el9.x86_64+debug #1
> >  Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> >  Workqueue: xfs-cil/dm-0 xlog_cil_push_work [xfs]
> >  Call Trace:
> >   ? migrate_enable+0x45/0x140
> >   dump_stack_lvl+0x57/0x7d
> >   ___might_sleep.cold+0xe3/0xf7
> >   rt_spin_lock+0x3a/0xd0
> >   ? __blk_add_trace+0x3ef/0x480
> >   __blk_add_trace+0x3ef/0x480
> >   blk_add_trace_bio+0x18d/0x1f0
> >   trace_block_bio_queue+0xb5/0x150
> >   submit_bio_checks+0x1f0/0x520
> >   ? sched_clock_cpu+0xb/0x100
> >   submit_bio_noacct+0x30/0x1d0
> >   ? bio_associate_blkg+0x66/0x190
> >   xlog_cil_push_work+0x1b6/0x670 [xfs]
> >   ? register_lock_class+0x43/0x4f0
> >   ? xfs_swap_extents+0x5f0/0x5f0 [xfs]
> >   process_one_work+0x275/0x450
> >   ? process_one_work+0x200/0x450
> >   worker_thread+0x55/0x3c0
> >   ? process_one_work+0x450/0x450
> >   kthread+0x188/0x1a0
> >   ? set_kthread_struct+0x40/0x40
> >   ret_from_fork+0x22/0x30
>
> The above fills 90% of my screen with _no_ additional information. What
> about:
>
>    The running_trace_lock protects running_trace_list and is acquired
>    within the tracepoint which implies disabled preemption. The spinlock_t
>    typed lock can not be acquired with disabled preemption on PREEMPT_RT
>    because it becomes a sleeping lock.
>    The runtime of the tracepoint depends on the number of entries in
>    running_trace_list and has no limit. The blk-tracer is considered debug
>    code and higher latencies here are okay.
>
>    Make running_trace_lock a raw_spinlock_t
>
> > To avoid this bug, we switch the trace lock to a raw spinlock.
>
> Basically I want to give rationale _why_ changing a lock to
> raw_spinlock_t _here_ is okay. I want to avoid that people slap a
> s/spinlock_t/raw_spinlock_t/ each time they see warning of this kind.
>

Thanks, this sounds great. I am going to send v4 with the modified
commit message right now.

> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
>
> Sebastian
>

