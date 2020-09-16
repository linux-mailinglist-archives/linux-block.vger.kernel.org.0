Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC40A26B89E
	for <lists+linux-block@lfdr.de>; Wed, 16 Sep 2020 02:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgIPAry (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 15 Sep 2020 20:47:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57562 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726250AbgIOMlS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Sep 2020 08:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600173676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uXKYUuptz85rmV3ZBenDNJaRTz/xaUFJKAPHVM/NEa0=;
        b=MStK9DBZdzN3seacbouY1KlLOFqS7AI8rDEozi4XZsCAJ2gL8r2XGfAwS/qX+pjX6S/nDd
        sdl+0VcVuphExdvA6+7njCSASH2VfSUDQug2gTP3xakbzpb9QxHymSGP26sjUrcXdIi8yW
        LgoEdeEJOs/TVTeLfj6LxyrCA+QkaVE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-b0KDiq_3MsWrcVhKOIJNMw-1; Tue, 15 Sep 2020 08:41:12 -0400
X-MC-Unique: b0KDiq_3MsWrcVhKOIJNMw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E1CEADC03;
        Tue, 15 Sep 2020 12:41:11 +0000 (UTC)
Received: from T590 (ovpn-12-38.pek2.redhat.com [10.72.12.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 17B8819C59;
        Tue, 15 Sep 2020 12:41:04 +0000 (UTC)
Date:   Tue, 15 Sep 2020 20:41:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ppvk@codeaurora.org
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        stummala@codeaurora.org, sayalil@codeaurora.org
Subject: Re: [PATCH V2] block: Fix use-after-free issue while accessing
 ioscheduler lock
Message-ID: <20200915124100.GA778373@T590>
References: <1600161062-43793-1-git-send-email-ppvk@codeaurora.org>
 <20200915100908.GA764869@T590>
 <38dad0eb6f1d719fc877f24cc42902ef@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38dad0eb6f1d719fc877f24cc42902ef@codeaurora.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 15, 2020 at 05:50:33PM +0530, ppvk@codeaurora.org wrote:
> On 2020-09-15 15:39, Ming Lei wrote:
> > On Tue, Sep 15, 2020 at 02:41:02PM +0530, Pradeep P V K wrote:
> > > Observes below crash while accessing (use-after-free) lock member
> > > of bfq data.
> > > 
> > > context#1			context#2
> > > 				process_one_work()
> > > kthread()			blk_mq_run_work_fn()
> > > worker_thread()			 ->__blk_mq_run_hw_queue()
> > > process_one_work()		  ->blk_mq_sched_dispatch_requests()
> > > __blk_release_queue()		    ->blk_mq_do_dispatch_sched()
> > 
> > Just found __blk_release_queue killed in v5.9 cycle.
> > 
> Yes on v5.9 blk_release_queue() will be called directly by q->kobj when
> request_queue ref. goes zero but
> where as on older kernel versions (< 5.9), blk_release_queue() will
> schedule a work to invoke/call "__blk_release_queue()".
> 
> > > ->__elevator_exit()
> > >   ->blk_mq_exit_sched()
> > >     ->exit_sched()
> > >       ->kfree()
> > >       					->bfq_dispatch_request()
> > > 					  ->spin_unlock_irq(&bfqd->lock)
> > 
> > Actually not sure if the above race is easy to trigger in recent kernel,
> > because we do call cancel_delayed_work_sync() in
> > blk_mq_hw_sysfs_release(),
> > which is usually called before __elevator_exit() from
> > blk_exit_queue()/blk_release_queue().
> > 
> blk_mq_hw_sysfs_release() will be called from blk_mq_release() i.e. with
> kobject_put(hctx->kobj), which is after __elevator_exit()
> 
> __elevator_exit() is called from blk_exit_queue() which is prior to
> blk_mq_release().
> 
> > So can you share your kernel version in which the issue is reproduced?
> > And can you reproduce this issue on v5.8 or v5.9-rc5?
> > 
> This issue is seen on v5.4 stable and it is very easy to reproduce on v5.4.
> sorry, i don't have a resource with v5.8 or with latest kernel. I can help
> you
> to get tested on v5.4. From the issue prospective, both v5.4 kernel and
> latest kernels calls blk_mq_release() -> blk_mq_hw_sysfs_release() after
> __elevator_exit(). So, i think it wont matter much here.
> 
> > > 
> > > This is because of the kblockd delayed work that might got scheduled
> > > around blk_release_queue() and accessed use-after-free member of
> > > bfq_data.
> > > 
> > > 240.212359:   <2> Unable to handle kernel paging request at
> > > virtual address ffffffee2e33ad70
> > > ...
> > > 240.212637:   <2> Workqueue: kblockd blk_mq_run_work_fn
> > > 240.212649:   <2> pstate: 00c00085 (nzcv daIf +PAN +UAO)
> > > 240.212666:   <2> pc : queued_spin_lock_slowpath+0x10c/0x2e0
> > > 240.212677:   <2> lr : queued_spin_lock_slowpath+0x84/0x2e0
> > > ...
> > > Call trace:
> > > 240.212865:   <2>  queued_spin_lock_slowpath+0x10c/0x2e0
> > > 240.212876:   <2>  do_raw_spin_lock+0xf0/0xf4
> > > 240.212890:   <2>  _raw_spin_lock_irq+0x74/0x94
> > > 240.212906:   <2>  bfq_dispatch_request+0x4c/0xd60
> > > 240.212918:   <2>  blk_mq_do_dispatch_sched+0xe0/0x1f0
> > > 240.212927:   <2>  blk_mq_sched_dispatch_requests+0x130/0x194
> > > 240.212940:   <2>  __blk_mq_run_hw_queue+0x100/0x158
> > > 240.212950:   <2>  blk_mq_run_work_fn+0x1c/0x28
> > > 240.212963:   <2>  process_one_work+0x280/0x460
> > > 240.212973:   <2>  worker_thread+0x27c/0x4dc
> > > 240.212986:   <2>  kthread+0x160/0x170
> > > 
> > > Fix this by cancelling the delayed work if any before elevator exits.
> > > 
> > > Changes since V1:
> > > - Moved the logic into blk_cleanup_queue() as per Ming comments.
> > > 
> > > Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
> > > ---
> > >  block/blk-mq.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > index 4abb714..890fded 100644
> > > --- a/block/blk-mq.c
> > > +++ b/block/blk-mq.c
> > > @@ -2598,6 +2598,7 @@ static void blk_mq_exit_hw_queues(struct
> > > request_queue *q,
> > >  			break;
> > >  		blk_mq_debugfs_unregister_hctx(hctx);
> > >  		blk_mq_exit_hctx(q, set, hctx, i);
> > > +		cancel_delayed_work_sync(&hctx->run_work);
> > >  	}
> > >  }
> > 
> > It should be better to move cancel_delayed_work_sync() into
> > blk_mq_exit_hctx(), exactly before adding hctx into unused list.
> > 
> Sure. i will do it in my next patch series.

Thinking of further, looks your 1st post is right, because hw queue
won't be run when refcount of the queue drops to zero.

Sorry for the noise.

thanks,
Ming

