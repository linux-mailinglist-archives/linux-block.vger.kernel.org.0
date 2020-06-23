Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513BF20520C
	for <lists+linux-block@lfdr.de>; Tue, 23 Jun 2020 14:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732572AbgFWMLZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 Jun 2020 08:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732539AbgFWMLY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 08:11:24 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836ABC061573
        for <linux-block@vger.kernel.org>; Tue, 23 Jun 2020 05:11:24 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i3so5628098qtq.13
        for <linux-block@vger.kernel.org>; Tue, 23 Jun 2020 05:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=ahUTe9XRJ8acBkcpa6ONk60UI2intY15Pgk4PKOCgS0=;
        b=RQY/ESzGkhxZji4tPsplhJBlbizm0USPsgYnucQWPz8SHWSSoAw4/LTAKi6sTLEal+
         xY0al366iH0mojctdZHNzLkJPa19z7iagNLr3MJI4rc2l1BefNfXO4H4bD5BV/yDlFx2
         h5PhEtYHarUcz5i7AXqxQDuqyd/GZyUoQ8VxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=ahUTe9XRJ8acBkcpa6ONk60UI2intY15Pgk4PKOCgS0=;
        b=oV9Dkifq5Lq90vAxcfcfK5LP5KV4OLawNhudMvdtFRoektdnSaPpKsWOii4J8Gg+MD
         Aco3fXtufVLblpctn6Yo38uUkMOW0VAFbN1sY1EfSDKUbpxVyYlbFo7h34XUSMbxDyw3
         jF7dmqG+/g33L9U2RdvEEN7s3x/j4XESlrTbdW+Z2sgj0fp4O5upbzabuE/NFNebRqYR
         F5CQNhiXA0vDS0Jnag+yi136YScSRmzBUX4YWcuJUepuKZghWlEdTHmcFrjDMNnxsCYd
         JPa+0wAZmDJnGWtwMJIRQ8Z9S2Pj6pb7EM3sZAAq1h67oVzaCRTTM9BjbqI9elXvc/W/
         HAtw==
X-Gm-Message-State: AOAM5328/CKVuKBIBSjoNMNnj1G1ufbpXvXdWgxIbrZpjkYd69k1Kpm/
        aRpGNa8iQ+yXv3WWjOCCHC86qvkFTtQvzpIRKSGHzw==
X-Google-Smtp-Source: ABdhPJwcuKC3ED8V1jFmIuyDFa9N+YG59CVVkkvAHStB6GsAg7XHNCw/a3+6RE2IEopKCaWNjyRYMJZdUfl1u6TRJts=
X-Received: by 2002:ac8:7cb8:: with SMTP id z24mr20283577qtv.190.1592914283499;
 Tue, 23 Jun 2020 05:11:23 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <1591810159-240929-1-git-send-email-john.garry@huawei.com>
 <20200611030708.GB453671@T590> <c033f445-97fd-6dc9-c270-9890681b39d9@huawei.com>
 <bbdec3b3fbeb9907d2ec66a2afa56c29@mail.gmail.com> <20200615021355.GA4012@T590>
 <e49f164d867b53fd4495f1e05a85df03@mail.gmail.com> <20200616010055.GA27192@T590>
 <f9a05331a46a8c60c10e35df4aa08c45@mail.gmail.com> <67d626a6-1b7c-fbc8-24b6-8d6b6df8a7b8@suse.de>
 <20200623005518.GA843366@T590> 3b3c83d2ea14c73561f215ba15322702@mail.gmail.com
In-Reply-To: 3b3c83d2ea14c73561f215ba15322702@mail.gmail.com
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQBVjmvxAE7FMYb7GtMRWGcwtMcECgGaerxUAVTJvjECMFFU0QGrq6UsAuDJt2sC5poHDQH30JQYAZ8VPSMDEFRlXqtNvHgwgAAGEeA=
Date:   Tue, 23 Jun 2020 17:41:20 +0530
Message-ID: <541b79b7007feda09cb810d55a6f0b73@mail.gmail.com>
Subject: RE: [PATCH RFC v7 00/12] blk-mq/scsi: Provide hostwide shared tags
 for SCSI HBAs
To:     Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>
Cc:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        don.brace@microsemi.com, Sumit Saxena <sumit.saxena@broadcom.com>,
        bvanassche@acm.org, hare@suse.com, hch@lst.de,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        esc.storagedev@microsemi.com, chenxiang66@hisilicon.com,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> > > >
> > > Would it make sense to move it into the elevator itself?
>
> I am not sure where exactly I should add this counter since I need
counter per
> hctx. Elevator data is per request object.
> Please suggest.
>
> >
> > That is my initial suggestion, and the counter is just done for bfq &
> > mq- deadline, then we needn't to pay the cost for others.
>
> I have updated patch -
>
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c index
a1123d4..3e0005c
> 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4640,6 +4640,12 @@ static bool bfq_has_work(struct blk_mq_hw_ctx
> *hctx)  {
>         struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
>
> +       /* If current hctx has not queued any request, there is no need
to run.
> +        * blk_mq_run_hw_queue() on hctx which has queued IO will handle
> +        * running specific hctx.
> +        */
> +       if (!atomic_read(&hctx->elevator_queued))
> +               return false;
>         /*
>          * Avoiding lock: a race on bfqd->busy_queues should cause at
>          * most a call to dispatch for nothing @@ -5554,6 +5561,7 @@
static void
> bfq_insert_requests(struct blk_mq_hw_ctx *hctx,
>                 rq = list_first_entry(list, struct request, queuelist);
>                 list_del_init(&rq->queuelist);
>                 bfq_insert_request(hctx, rq, at_head);
> +              atomic_inc(&hctx->elevator_queued);
>         }
>  }
>
> @@ -5925,6 +5933,7 @@ static void bfq_finish_requeue_request(struct
> request *rq)
>
>         if (likely(rq->rq_flags & RQF_STARTED)) {
>                 unsigned long flags;
> +              struct blk_mq_hw_ctx *mq_hctx = rq->mq_hctx;
>
>                 spin_lock_irqsave(&bfqd->lock, flags);
>
> @@ -5934,6 +5943,7 @@ static void bfq_finish_requeue_request(struct
> request *rq)
>                 bfq_completed_request(bfqq, bfqd);
>                 bfq_finish_requeue_request_body(bfqq);
>
> +              atomic_dec(&hctx->elevator_queued);
>                 spin_unlock_irqrestore(&bfqd->lock, flags);
>         } else {
>                 /*
> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h index
> 126021f..946b47a 100644
> --- a/block/blk-mq-sched.h
> +++ b/block/blk-mq-sched.h
> @@ -74,6 +74,13 @@ static inline bool blk_mq_sched_has_work(struct
> blk_mq_hw_ctx *hctx)  {
>         struct elevator_queue *e = hctx->queue->elevator;
>
> +       /* If current hctx has not queued any request, there is no need
to run.
> +        * blk_mq_run_hw_queue() on hctx which has queued IO will handle
> +        * running specific hctx.
> +        */
> +       if (!atomic_read(&hctx->elevator_queued))
> +               return false;
> +

I have missed this. I will remove above code since it is now managed
within mq-deadline and bfq-iosched *has_work* callback.

>         if (e && e->type->ops.has_work)
>                 return e->type->ops.has_work(hctx);
>
