Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E12544B9FE
	for <lists+linux-block@lfdr.de>; Wed, 10 Nov 2021 02:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhKJBl6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 9 Nov 2021 20:41:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25028 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229473AbhKJBlz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Nov 2021 20:41:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636508348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nkza7GLjFY3z+TGfBNiWRQZF1T0i4Xhq+0Fdi4dPVMU=;
        b=Y4VY/fR4IN/zbIeYe2CWPjSu01a55pHdHhUMKIL10HJehYVW4ko8/yyepUYvVAnuqpjqAe
        6Fe0TTOd6h3+kvWB4ZTTSou5vMZdgoGi3b/0ia4P2K6ceIK5u/z79704ST5ch0Nd5GU8IR
        QZ2FB9I5o9BqmuDvybxnnvHkK+IyiIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-HsyxnW2vOYqCp0cNfDH5Hw-1; Tue, 09 Nov 2021 20:39:07 -0500
X-MC-Unique: HsyxnW2vOYqCp0cNfDH5Hw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EBCB802C96;
        Wed, 10 Nov 2021 01:39:05 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C61B310016F2;
        Wed, 10 Nov 2021 01:38:56 +0000 (UTC)
Date:   Wed, 10 Nov 2021 09:38:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        sashal@kernel.org, jack@suse.cz, Jinpu Wang <jinpu.wang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>, ming.lei@rehdat.com
Subject: Re: Observing an fio hang with RNBD device in the latest v5.10.78
 Linux kernel
Message-ID: <YYsiqUpLdNtshZms@T590>
References: <CAJpMwyixY_-AbMvtGGMBWBO3+oOEF9fuWHkYpLWDbXo3dcAGfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJpMwyixY_-AbMvtGGMBWBO3+oOEF9fuWHkYpLWDbXo3dcAGfg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Haris,

On Tue, Nov 09, 2021 at 10:32:32AM +0100, Haris Iqbal wrote:
> Hi,
> 
> We are observing an fio hang with the latest v5.10.78 Linux kernel
> version with RNBD. The setup is as follows,
> 
> On the server side, 16 nullblk devices.
> On the client side, map those 16 block devices through RNBD-RTRS.
> Change the scheduler for those RNBD block devices to mq-deadline.
> 
> Run fios with the following configuration.
> 
> [global]
> description=Emulation of Storage Server Access Pattern
> bssplit=512/20:1k/16:2k/9:4k/12:8k/19:16k/10:32k/8:64k/4
> fadvise_hint=0
> rw=randrw:2
> direct=1
> random_distribution=zipf:1.2
> time_based=1
> runtime=60
> ramp_time=1
> ioengine=libaio
> iodepth=128
> iodepth_batch_submit=128
> iodepth_batch_complete=128
> numjobs=1
> group_reporting
> 
> 
> [job1]
> filename=/dev/rnbd0
> [job2]
> filename=/dev/rnbd1
> [job3]
> filename=/dev/rnbd2
> [job4]
> filename=/dev/rnbd3
> [job5]
> filename=/dev/rnbd4
> [job6]
> filename=/dev/rnbd5
> [job7]
> filename=/dev/rnbd6
> [job8]
> filename=/dev/rnbd7
> [job9]
> filename=/dev/rnbd8
> [job10]
> filename=/dev/rnbd9
> [job11]
> filename=/dev/rnbd10
> [job12]
> filename=/dev/rnbd11
> [job13]
> filename=/dev/rnbd12
> [job14]
> filename=/dev/rnbd13
> [job15]
> filename=/dev/rnbd14
> [job16]
> filename=/dev/rnbd15
> 
> Some of the fio threads hangs and the fio never finishes.
> 
> fio fio.ini
> job1: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> 512B-64.0KiB, ioengine=libaio, iodepth=128
> job2: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> 512B-64.0KiB, ioengine=libaio, iodepth=128
> job3: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> 512B-64.0KiB, ioengine=libaio, iodepth=128
> job4: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> 512B-64.0KiB, ioengine=libaio, iodepth=128
> job5: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> 512B-64.0KiB, ioengine=libaio, iodepth=128
> job6: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> 512B-64.0KiB, ioengine=libaio, iodepth=128
> job7: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> 512B-64.0KiB, ioengine=libaio, iodepth=128
> job8: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> 512B-64.0KiB, ioengine=libaio, iodepth=128
> job9: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> 512B-64.0KiB, ioengine=libaio, iodepth=128
> job10: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> 512B-64.0KiB, ioengine=libaio, iodepth=128
> job11: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> 512B-64.0KiB, ioengine=libaio, iodepth=128
> job12: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> 512B-64.0KiB, ioengine=libaio, iodepth=128
> job13: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> 512B-64.0KiB, ioengine=libaio, iodepth=128
> job14: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> 512B-64.0KiB, ioengine=libaio, iodepth=128
> job15: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> 512B-64.0KiB, ioengine=libaio, iodepth=128
> job16: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> 512B-64.0KiB, ioengine=libaio, iodepth=128
> fio-3.12
> Starting 16 processes
> Jobs: 16 (f=12):
> [m(3),/(2),m(5),/(1),m(1),/(1),m(3)][0.0%][r=130MiB/s,w=130MiB/s][r=14.7k,w=14.7k
> IOPS][eta 04d:07h:4
> Jobs: 15 (f=11):
> [m(3),/(2),m(5),/(1),_(1),/(1),m(3)][51.2%][r=7395KiB/s,w=6481KiB/s][r=770,w=766
> IOPS][eta 01m:01s]
> Jobs: 15 (f=11): [m(3),/(2),m(5),/(1),_(1),/(1),m(3)][52.7%][eta 01m:01s]
> 
> We checked the block devices, and there are requests waiting in their
> fifo (not on all devices, just few whose corresponding fio threads are
> hung).
> 
> $ cat /sys/kernel/debug/block/rnbd0/sched/read_fifo_list
> 00000000ce398aec {.op=READ, .cmd_flags=,
> .rq_flags=SORTED|ELVPRIV|IO_STAT|HASHED, .state=idle, .tag=-1,
> .internal_tag=209}
> 000000005ec82450 {.op=READ, .cmd_flags=,
> .rq_flags=SORTED|ELVPRIV|IO_STAT|HASHED, .state=idle, .tag=-1,
> .internal_tag=210}
> 
> $ cat /sys/kernel/debug/block/rnbd0/sched/write_fifo_list
> 000000000c1557f5 {.op=WRITE, .cmd_flags=SYNC|IDLE,
> .rq_flags=SORTED|ELVPRIV|IO_STAT|HASHED, .state=idle, .tag=-1,
> .internal_tag=195}
> 00000000fc6bfd98 {.op=WRITE, .cmd_flags=SYNC|IDLE,
> .rq_flags=SORTED|ELVPRIV|IO_STAT|HASHED, .state=idle, .tag=-1,
> .internal_tag=199}
> 000000009ef7c802 {.op=WRITE, .cmd_flags=SYNC|IDLE,
> .rq_flags=SORTED|ELVPRIV|IO_STAT|HASHED, .state=idle, .tag=-1,
> .internal_tag=217}

Can you post the whole debugfs log for rnbd0? 

(cd /sys/kernel/debug/block/rnbd0 && find . -type f -exec grep -aH . {} \;)

> 
> 
> Potential points which fixes the hang
> 
> 1) Using no scheduler (none) on the client side RNBD block devices
> results in no hang.
> 
> 2) In the fio config, changing the line "iodepth_batch_complete=128"
> to the following fixes the hang,
> iodepth_batch_complete_min=1
> iodepth_batch_complete_max=128
> OR,
> iodepth_batch_complete=0
> 
> 3) We also tracked down the version from which the hang started. The
> hang started with v5.10.50, and the following commit was one which
> results in the hang
> 
> commit 512106ae2355813a5eb84e8dc908628d52856890
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Fri Jun 25 10:02:48 2021 +0800
> 
>     blk-mq: update hctx->dispatch_busy in case of real scheduler
> 
>     [ Upstream commit cb9516be7708a2a18ec0a19fe3a225b5b3bc92c7 ]
> 
>     Commit 6e6fcbc27e77 ("blk-mq: support batching dispatch in case of io")
>     starts to support io batching submission by using hctx->dispatch_busy.
> 
>     However, blk_mq_update_dispatch_busy() isn't changed to update
> hctx->dispatch_busy
>     in that commit, so fix the issue by updating hctx->dispatch_busy in case
>     of real scheduler.
> 
>     Reported-by: Jan Kara <jack@suse.cz>
>     Reviewed-by: Jan Kara <jack@suse.cz>
>     Fixes: 6e6fcbc27e77 ("blk-mq: support batching dispatch in case of io")
>     Signed-off-by: Ming Lei <ming.lei@redhat.com>
>     Link: https://lore.kernel.org/r/20210625020248.1630497-1-ming.lei@redhat.com
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 00d6ed2fe812..a368eb6dc647 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1242,9 +1242,6 @@ static void blk_mq_update_dispatch_busy(struct
> blk_mq_hw_ctx *hctx, bool busy)
>  {
>         unsigned int ewma;
> 
> -       if (hctx->queue->elevator)
> -               return;
> -
>         ewma = hctx->dispatch_busy;
> 
>         if (!ewma && !busy)
> 
> We reverted the commit and tested and there is no hang.
> 
> 4) Lastly, we tested newer version like 5.13, and there is NO hang in
> that also. Hence, probably some other change fixed it.

Can you observe the issue on v5.10? Maybe there is one pre-patch of commit cb9516be7708
("blk-mq: update hctx->dispatch_busy in case of real scheduler merged")
which is missed to 5.10.y.

And not remember that there is fix for commit cb9516be7708 in mainline.

commit cb9516be7708 is merged to v5.14, instead of v5.13, did you test v5.14 or v5.15?

BTW, commit cb9516be7708 should just affect performance, not supposed to cause
hang.

Thanks,
Ming

