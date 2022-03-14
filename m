Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676F04D7B16
	for <lists+linux-block@lfdr.de>; Mon, 14 Mar 2022 08:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbiCNHB3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 14 Mar 2022 03:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbiCNHB2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 03:01:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8902E40900
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 00:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647241218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3jsmSRbQAyLumWypnn3oe4S1peFrLuJMeMjB9icAC+g=;
        b=NL2jPtTRvyevvfoHKAMF5Bap9GpK+XJCA4/5L38cU1iJ8uoHDUUClmhS/3awwld5Szj6uG
        bzxmVvea1JSgfXW0LT68CMhht5W/jvfZNQPjt+AtUzMB5Rmaljev/st8XWczi5X8WaBuS1
        244mUax5Ed2tf251QcMEAezbkJSA15c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-y1MEpWqzNtGrAIzQ0QrAtg-1; Mon, 14 Mar 2022 03:00:16 -0400
X-MC-Unique: y1MEpWqzNtGrAIzQ0QrAtg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3038219705A9;
        Mon, 14 Mar 2022 07:00:16 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E380C44AE6;
        Mon, 14 Mar 2022 07:00:11 +0000 (UTC)
Date:   Mon, 14 Mar 2022 15:00:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [bug report] worker watchdog timeout in dispatch loop for
 null_blk
Message-ID: <Yi7n9mgblKcC7msM@T590>
References: <20220310091649.zypaem5lkyfadymg@shindev>
 <YinMWPiuUluinom8@T590>
 <20220310124023.tkax52chul265bus@shindev>
 <a6d6b858-4bee-10da-884c-20b16e4ad0de@kernel.dk>
 <20220311062441.vsa54rie5fxhjtps@shindev>
 <YisblCKgf6xC0/ai@T590>
 <20220314052434.zud5zb5wqrjljk4b@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314052434.zud5zb5wqrjljk4b@shindev>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 14, 2022 at 05:24:34AM +0000, Shinichiro Kawasaki wrote:
> On Mar 11, 2022 / 17:51, Ming Lei wrote:
> > On Fri, Mar 11, 2022 at 06:24:41AM +0000, Shinichiro Kawasaki wrote:
> > > On Mar 10, 2022 / 05:47, Jens Axboe wrote:
> > > > On 3/10/22 5:40 AM, Shinichiro Kawasaki wrote:
> > > > > On Mar 10, 2022 / 18:00, Ming Lei wrote:
> > > > >> On Thu, Mar 10, 2022 at 09:16:50AM +0000, Shinichiro Kawasaki wrote:
> > > > >>> This issue does not look critical, but let me share it to ask comments for fix.
> > > > >>>
> > > > >>> When fio command with 40 jobs [1] is run for a null_blk device with memory
> > > > >>> backing and mq-deadline scheduler, kernel reports a BUG message [2]. The
> > > > >>> workqueue watchdog reports that kblockd blk_mq_run_work_fn keeps on running
> > > > >>> more than 30 seconds and other work can not run. The 40 fio jobs keep on
> > > > >>> creating many read requests to a single null_blk device, then the every time
> > > > >>> the mq_run task calls __blk_mq_do_dispatch_sched(), it returns ret == 1 which
> > > > >>> means more than one request was dispatched. Hence, the while loop in
> > > > >>> blk_mq_do_dispatch_sched() does not break.
> > > > >>>
> > > > >>> static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > > >>> {
> > > > >>>         int ret;
> > > > >>>
> > > > >>>         do {
> > > > >>>                ret = __blk_mq_do_dispatch_sched(hctx);
> > > > >>>         } while (ret == 1);
> > > > >>>
> > > > >>>         return ret;
> > > > >>> }
> > > > >>>
> > > > >>> The BUG message was observed when I ran blktests block/005 with various
> > > > >>> conditions on a system with 40 CPUs. It was observed with kernel version
> > > > >>> v5.16-rc1 through v5.17-rc7. The trigger commit was 0a593fbbc245 ("null_blk:
> > > > >>> poll queue support"). This commit added blk_mq_ops.map_queues callback. I
> > > > >>> guess it changed dispatch behavior for null_blk devices and triggered the
> > > > >>> BUG message.
> > > > >>
> > > > >> It is one blk-mq soft lockup issue in dispatch side, and shouldn't be related
> > > > >> with 0a593fbbc245.
> > > > >>
> > > > >> If queueing requests is faster than dispatching, the issue will be triggered
> > > > >> sooner or later, especially easy to trigger in SQ device. I am sure it can
> > > > >> be triggered on scsi debug, even saw such report on ahci.
> > > > > 
> > > > > Thank you for the comments. Then this is the real problem.
> > > > > 
> > > > >>
> > > > >>>
> > > > >>> I'm not so sure if we really need to fix this issue. It does not seem the real
> > > > >>> world problem since it is observed only with null_blk. The real block devices
> > > > >>> have slower IO operation then the dispatch should stop sooner when the hardware
> > > > >>> queue gets full. Also the 40 jobs for single device is not realistic workload.
> > > > >>>
> > > > >>> Having said that, it does not feel right that other works are pended during
> > > > >>> dispatch for null_blk devices. To avoid the BUG message, I can think of two
> > > > >>> fix approaches. First one is to break the while loop in blk_mq_do_dispatch_sched
> > > > >>> using a loop counter [3] (or jiffies timeout check).
> > > > >>
> > > > >> This way could work, but the queue need to be re-run after breaking
> > > > >> caused by max dispatch number. cond_resched() might be the simplest way,
> > > > >> but it can't be used here because of rcu/srcu read lock.
> > > > > 
> > > > > As far as I understand, blk_mq_run_work_fn() should return after the loop break
> > > > > to yield the worker to other works. How about to call
> > > > > blk_mq_delay_run_hw_queue() at the loop break? Does this re-run the dispatch?
> > > > > 
> > > > > 
> > > > > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > > > > index 55488ba978232..faa29448a72a0 100644
> > > > > --- a/block/blk-mq-sched.c
> > > > > +++ b/block/blk-mq-sched.c
> > > > > @@ -178,13 +178,19 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > > >  	return !!dispatched;
> > > > >  }
> > > > >  
> > > > > +#define MQ_DISPATCH_MAX 0x10000
> > > > > +
> > > > >  static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > > >  {
> > > > >  	int ret;
> > > > > +	unsigned int count = MQ_DISPATCH_MAX;
> > > > >  
> > > > >  	do {
> > > > >  		ret = __blk_mq_do_dispatch_sched(hctx);
> > > > > -	} while (ret == 1);
> > > > > +	} while (ret == 1 && count--);
> > > > > +
> > > > > +	if (ret == 1 && !count)
> > > > > +		blk_mq_delay_run_hw_queue(hctx, 0);
> > > > >  
> > > > >  	return ret;
> > > > >  }
> > > > 
> > > > Why not just gate it on needing to reschedule, rather than some random
> > > > value?
> > > > 
> > > > static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > > {
> > > > 	int ret;
> > > > 
> > > > 	do {
> > > > 		ret = __blk_mq_do_dispatch_sched(hctx);
> > > > 	} while (ret == 1 && !need_resched());
> > > > 
> > > > 	if (ret == 1 && need_resched())
> > > > 		blk_mq_delay_run_hw_queue(hctx, 0);
> > > > 
> > > > 	return ret;
> > > > }
> > > > 
> > > > or something like that.
> > > 
> > > Jens, thanks for the idea, but need_resched() check does not look working here.
> > > I tried the code above but still the BUG message is observed. My guess is that
> > > in the call stack below, every __blk_mq_do_dispatch_sched() call results in
> > > might_sleep_if() call, then need_resched() does not work as expected, probably.
> > > 
> > > __blk_mq_do_dispatch_sched
> > >   blk_mq_dispatch_rq_list
> > >     q->mq_ops->queue_rq
> > >       null_queue_rq
> > >         might_sleep_if
> > > 
> > > Now I'm trying to find similar way as need_resched() to avoid the random number.
> > > So far I haven't found good idea yet.
> > 
> > Jens patch using need_resched() looks improving the situation, also the
> > scsi_debug case won't set BLOCKING:
> > 
> > 1) without the patch, it can be easy to trigger lockup with the
> > following test.
> > 
> > - modprobe scsi_debug virtual_gb=128 delay=0 dev_size_mb=2048
> > - fio --bs=512k --ioengine=sync --iodepth=128 --numjobs=4 --rw=randrw \
> > 	--name=sdc-sync-randrw-512k --filename=/dev/sdc --direct=1 --size=60G --runtime=120
> > 
> > #sdc is the created scsi_debug disk
> 
> Thanks. I tried the work load above and observed the lockup BUG message on my
> system. So, I reconfirmed that the problem happens with both BLOCKING and
> non-BLOCKING drivers.
> 
> Regarding the solution, I can not think of any good one. I tried to remove the
> WQ_HIGHPRI flag from kblockd_workqueue, but it did not look affecting
> need_resched() behavior. I walked through workqueue API, but was not able
> to find anything useful.
> 
> As far as I understand, it is assumed and expected the each work item gets
> completed within decent time. Then this blk_mq_run_work_fn must stop within
> decent time by breaking the loop at some point. As the loop break conditions
> other than need_resched(), I can think of 1) loop count, 2) number of requests
> dispatched or 3) time spent in the loop. All of the three require a magic random
> number as the limit... Is there any other better way?
> 
> If we need to choose one of the 3 options, I think '3) time spent in the loop'
> is better than others, since workqueue watchdog monitors _time_ to check lockup
> and report the BUG message.

BTW, just tried 3), then the lockup issue can't be reproduced any more:

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index e6ad8f761474..b4de5a7ec606 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -181,10 +181,14 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 {
        int ret;
+       unsigned long start = jiffies;
 
        do {
                ret = __blk_mq_do_dispatch_sched(hctx);
-       } while (ret == 1);
+       } while (ret == 1 && !need_resched() && (jiffies - start) < HZ);
+
+       if (ret == 1 && (need_resched() || jiffies - start >= HZ))
+                blk_mq_delay_run_hw_queue(hctx, 0);
 
        return ret;
 }



Thanks, 
Ming

