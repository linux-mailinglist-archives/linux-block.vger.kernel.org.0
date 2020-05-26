Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E221D24AA
	for <lists+linux-block@lfdr.de>; Thu, 14 May 2020 03:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgENB2Q (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 May 2020 21:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725925AbgENB2Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 21:28:16 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE0BC061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 18:28:16 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t9so11874984pjw.0
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 18:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0xGGSYe+BQqYqYFoH9whZ4u9Bu9OVcRtZw6GuoVg+ok=;
        b=SStmV+xDKFJSciV8M2LKYps0okGgExcq2JVURBsYCW49Z3ru5Lsky5OF0FUcPcXavl
         Bi4DFw2OGC4pnEqPn7p+ar1MmWBhgE5NSvEoSumYokcchVosk4kJHHA9PN2xtN5+6+CU
         7tK1MTWBbehl5Uk5sBG0Osbxn34hyrCfxyCoQOD/IsyJ027Hph90RWkWG/VgzRgp0b24
         2TE2f5b3ki32tqqbeFkpyCQG22pt0Arz9SYXudgqIhEvgfS02W4yVMI5G5bjJIo3VAMb
         v9KYxNlZzphBbfz/BjmDirl9MrB5wEi193zFi2IQED3T4836mMvySP/xWyWq1KfCucgT
         OGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0xGGSYe+BQqYqYFoH9whZ4u9Bu9OVcRtZw6GuoVg+ok=;
        b=J00QRlgSYs/Z4b4UTUkKKQ9krGyKpO+J7qqbsNsvO7vCgiqerAdzv64TNVnw3Zz9mr
         pVKCPmAVHHH7vC5o+brJsdygIXYG9vCAtAetPX7i9dgM2R8aGE30Of5jz1eiyyOuTxt3
         Qf6eiVTE4gljN2LWKbkZQPCEWN+0VGPxTXe6DnvSdAG0niIDNGzbDbC5gIJJwUqjPhzJ
         bq99qfisk9H/gq8VpGkwuo0D0JbOFsp6kYqkoRoIOlZf2XtNJS6cIe8AaF4diOpkW7O2
         yJJ5vOpdCBj1fSsGIXva5Z8Eas/N16f6P3oToulGmESTxUfiKJyGwNyBwTGi+o3M6iDh
         P8tw==
X-Gm-Message-State: AGi0PuYLkJUdgGJKlHZZHGhrWY9MkQvj2iRLdfLpevBwpcG5f49ICFav
        nOM3tTEJUu/ktldRHh9c2j8rzHp+S/NFZg==
X-Google-Smtp-Source: APiQypLLqCNPuIWd67cNxcFLXDbZVcl9FGwVdRMWbht05pj31tZ3fnCczttAqKX0LFW/PB2VehFj0A==
X-Received: by 2002:a17:90b:1993:: with SMTP id mv19mr39034330pjb.88.1589419695567;
        Wed, 13 May 2020 18:28:15 -0700 (PDT)
Received: from google.com (240.242.82.34.bc.googleusercontent.com. [34.82.242.240])
        by smtp.gmail.com with ESMTPSA id gq6sm16682292pjb.54.2020.05.13.18.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 18:28:15 -0700 (PDT)
Date:   Thu, 14 May 2020 01:28:11 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Salman Qazi <sqazi@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V2] block: add blk_io_schedule() for avoiding task hung
 in sync dio
Message-ID: <20200514012811.GA84853@google.com>
References: <20200503015422.1123994-1-ming.lei@redhat.com>
 <20200514011110.GA79384@google.com>
 <20200514011710.GF2073570@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514011710.GF2073570@T590>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 14, 2020 at 09:17:10AM +0800, Ming Lei wrote:
> On Thu, May 14, 2020 at 01:11:10AM +0000, Satya Tangirala wrote:
> > On Sun, May 03, 2020 at 09:54:22AM +0800, Ming Lei wrote:
> > > Sync dio could be big, or may take long time in discard or in case of
> > > IO failure.
> > > 
> > > We have prevented task hung in submit_bio_wait() and blk_execute_rq(),
> > > so apply the same trick for prevent task hung from happening in sync dio.
> > > 
> > > Add helper of blk_io_schedule() and use io_schedule_timeout() to prevent
> > > task hung warning.
> > > 
> > > Cc: Salman Qazi <sqazi@google.com>
> > > Cc: Jesse Barnes <jsbarnes@google.com>
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: Bart Van Assche <bvanassche@acm.org>
> > > Cc: Hannes Reinecke <hare@suse.de>
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > > V2:
> > > 	- drop helper of blk_default_io_timeout()
> > > 
> > > 
> > >  fs/block_dev.c         |  4 ++--
> > >  fs/direct-io.c         |  2 +-
> > >  fs/iomap/direct-io.c   |  2 +-
> > >  include/linux/blkdev.h | 12 ++++++++++++
> > >  4 files changed, 16 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/block_dev.c b/fs/block_dev.c
> > > index 5eb30a474f6d..3b396f8c967c 100644
> > > --- a/fs/block_dev.c
> > > +++ b/fs/block_dev.c
> > > @@ -256,7 +256,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
> > >  			break;
> > >  		if (!(iocb->ki_flags & IOCB_HIPRI) ||
> > >  		    !blk_poll(bdev_get_queue(bdev), qc, true))
> > > -			io_schedule();
> > > +			blk_io_schedule();
> > >  	}
> > >  	__set_current_state(TASK_RUNNING);
> > >  
> > > @@ -450,7 +450,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
> > >  
> > >  		if (!(iocb->ki_flags & IOCB_HIPRI) ||
> > >  		    !blk_poll(bdev_get_queue(bdev), qc, true))
> > > -			io_schedule();
> > > +			blk_io_schedule();
> > >  	}
> > >  	__set_current_state(TASK_RUNNING);
> > >  
> > > diff --git a/fs/direct-io.c b/fs/direct-io.c
> > > index 00b4d15bb811..6d5370eac2a8 100644
> > > --- a/fs/direct-io.c
> > > +++ b/fs/direct-io.c
> > > @@ -500,7 +500,7 @@ static struct bio *dio_await_one(struct dio *dio)
> > >  		spin_unlock_irqrestore(&dio->bio_lock, flags);
> > >  		if (!(dio->iocb->ki_flags & IOCB_HIPRI) ||
> > >  		    !blk_poll(dio->bio_disk->queue, dio->bio_cookie, true))
> > > -			io_schedule();
> > > +			blk_io_schedule();
> > >  		/* wake up sets us TASK_RUNNING */
> > >  		spin_lock_irqsave(&dio->bio_lock, flags);
> > >  		dio->waiter = NULL;
> > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > index 20dde5aadcdd..fd3bd06fabb6 100644
> > > --- a/fs/iomap/direct-io.c
> > > +++ b/fs/iomap/direct-io.c
> > > @@ -561,7 +561,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> > >  			    !dio->submit.last_queue ||
> > >  			    !blk_poll(dio->submit.last_queue,
> > >  					 dio->submit.cookie, true))
> > > -				io_schedule();
> > > +				blk_io_schedule();
> > >  		}
> > >  		__set_current_state(TASK_RUNNING);
> > >  	}
> > > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > > index f00bd4042295..222eb5f32279 100644
> > > --- a/include/linux/blkdev.h
> > > +++ b/include/linux/blkdev.h
> > > @@ -27,6 +27,7 @@
> > >  #include <linux/percpu-refcount.h>
> > >  #include <linux/scatterlist.h>
> > >  #include <linux/blkzoned.h>
> > > +#include <linux/sched/sysctl.h>
> > >  
> > >  struct module;
> > >  struct scsi_ioctl_command;
> > > @@ -1827,4 +1828,15 @@ static inline void blk_wake_io_task(struct task_struct *waiter)
> > >  		wake_up_process(waiter);
> > >  }
> > >  
> > > +static inline void blk_io_schedule(void)
> > > +{
> > > +	/* Prevent hang_check timer from firing at us during very long I/O */
> > > +	unsigned long timeout = sysctl_hung_task_timeout_secs * HZ / 2;
> > > +
> > > +	if (timeout)
> > > +		io_schedule_timeout(timeout);
> > > +	else
> > > +		io_schedule();
> > > +}
> > > +
> > >  #endif
> > This won't compile without CONFIG_BLOCK, since this patch includes
> 
> Thanks for the report.
> 
> > linux/sched/sysctl.h only inside the #ifdef CONFIG_BLOCK, while blk_io_schedule
> > is declared outside the #ifdef CONFIG_BLOCK, but references
> > sysctl_hung_task_timeout_secs defined in linux/sched/sysctl.h. Afaict, the
> > function isn't needed without CONFIG_BLOCK, so maybe we should move the
> > function into the #ifdef CONFIG_BLOCK too?
> 
> Given io_schedule() is always available, I'd suggest to move
> "#include <linux/sched/sysctl.h>" out of '#ifdef CONFIG_BLOCK', does the
> following patch fixes the issue?
> 
Yeah sure, that works too :).

> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 5360696d85ff..bf99a723673b 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/sched.h>
>  #include <linux/sched/clock.h>
> +#include <linux/sched/sysctl.h>
>  
>  #ifdef CONFIG_BLOCK
>  
> @@ -27,7 +28,6 @@
>  #include <linux/percpu-refcount.h>
>  #include <linux/scatterlist.h>
>  #include <linux/blkzoned.h>
> -#include <linux/sched/sysctl.h>
>  
>  struct module;
>  struct scsi_ioctl_command;
> 
> thanks,
> Ming
> 
