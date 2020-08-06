Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EB423DEA0
	for <lists+linux-block@lfdr.de>; Thu,  6 Aug 2020 19:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbgHFR2H (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 6 Aug 2020 13:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbgHFRBX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Aug 2020 13:01:23 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9197EC0A888C
        for <linux-block@vger.kernel.org>; Thu,  6 Aug 2020 07:37:43 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id p25so4628155qkp.2
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2020 07:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=uofPzPo8/gz5keGiK/hNj2Xy1wAVilpSBR98FKRPkhY=;
        b=FHoOBE7obGEB61oBI5zKOHvyR/Tx13CR6Xl6YoQBzDOScOx6dS3ZZgpkLm6xhEy9lX
         oHkqhzTq8LKg0oGXWQSGbz3iUT77UIupmbyJhj/l6TsylziXPT8Z/NpUTLrelfsfBt1u
         6G6hlEBkxoFVTcb8Obe/9E45WlL/xECEI38Lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=uofPzPo8/gz5keGiK/hNj2Xy1wAVilpSBR98FKRPkhY=;
        b=DcFut4dBkyTDMZT/TeD3y5Oz466c0lW2cEvvCjCd+HcYpwVAdCY8iHpg3uxi4bbUEX
         22UaAWNmpEs/fmva18nUjT1TtR3NhlaYXuco2OQM3f9s1j2EFy3qY1Znx0U03Vc34eIz
         hU92V0jeNcMiN7Jh6j9SyHhpf700x9Hpnt/3rgJJ7awSiIQg4/QlXtF0Nq4QtdvKuMVH
         ScfbSi21g/Tad1xXkJ+eu10MelcKUriZ4fOS4QNGtfOoQRND7FHXoxQrVxxnSxYS/pZ8
         SgErCwseVwrvI+xW/Gq8tHm/saSNekmtkxpmHIPL1Jnky29IYHRsZLRgEIJSFnr2qNXk
         mM5w==
X-Gm-Message-State: AOAM530mcrxcv89RnM3qEnmHVyv2kF/g1pg7172/stGhiCPVsqjJUan4
        kiVDFxjBFxu0UdZ9t03gdQOO6vyg0k8Xnq8dr4BWiQ==
X-Google-Smtp-Source: ABdhPJx2s3aCngtA0GA62InvUK4OfjmKQBTtkFInH2OLtfXpz9p9YQ34+Dg8V2LS++ho9T+hfOYkenONUXxzKMkfob4=
X-Received: by 2002:ae9:e507:: with SMTP id w7mr8719554qkf.264.1596724661604;
 Thu, 06 Aug 2020 07:37:41 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <20200724024704.GB957464@T590> <6531e06c-9ce2-73e6-46fc-8e97400f07b2@huawei.com>
 <20200728084511.GA1326626@T590> <965cf22eea98c00618570da8424d0d94@mail.gmail.com>
 <20200729153648.GA1698748@T590> <7f94eaf2318cc26ceb64bde88d59d5e2@mail.gmail.com>
 <20200804083625.GA1958244@T590> <afe5eb1be7f416a48d7b5d473f3053d0@mail.gmail.com>
 <20200805084031.GA1995289@T590> <5adffdf805179428bdd0dd6c293a4f7d@mail.gmail.com>
 <20200806133819.GA2046861@T590>
In-Reply-To: <20200806133819.GA2046861@T590>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQE/+OJyWFKAouEWqnJEgB8EdgAUOQD9MwXwAyMjvw0CEOgTfwH/A0ecAffP3/8CJdMLTAMjpyDDAVIktm0BrCL65wHaXRyJqbWyCAA=
Date:   Thu, 6 Aug 2020 20:07:38 +0530
Message-ID: <f1ac35dfca34193e6c9bcedbc11911d2@mail.gmail.com>
Subject: RE: [PATCH RFC v7 10/12] megaraid_sas: switch fusion adapters to MQ
To:     Ming Lei <ming.lei@redhat.com>
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

> > Hi Ming -
> >
> > There is still some race which is not handled.  Take a case of IO is
> > not able to get budget and it has already marked <restarts> flag.
> > <restarts> flag will be seen non-zero in completion path and
> > completion path will attempt h/w queue run. (But this particular IO is
> > still not in s/w queue.).
> > Attempt of running h/w queue from completion path will not flush any
> > IO since there is no IO in s/w queue.
>
> Then where is the IO to be submitted in case of running out of budget?

Typical race in your latest patch is - (Lets consider command A,B and C)
Command A did not receive budget. Command B completed  (which was already
submitted earlier) at the same time and it make sdev->device_busy = 0 from
" scsi_finish_command".
Command B has still not called "scsi_end_request". Command C get the
budget and it will make sdev->device_busy = 1. Now, Command A set  set
sdev->restarts flags but will not run h/w queue since sdev->device_busy =
1.
Command B run h/w queue (make sdev->restart = 0) from completion path, but
command -A is still not in the s/w queue. Command-A is in now in s/w
queue. Command-C completed but it will not run h/w queue because
sdev->restarts = 0.


>
> Any IO request which is going to be added to hctx->dispatch, the queue
will be
> re-run via blk-mq core.
>
> Any IO request being issued directly when running out of budget will be
insert
> to hctx->dispatch or sw/scheduler queue, will be run in the submission
path.

I have *not* included below changes we discussed in my testing - If I
include below patch, it is correct that queue will be run in submission
path (at least the path which is impacted in my testing). You have already
mentioned that most of the submission path has fix now in latest kernel
w.r.t running h/w queue from submission path.  Below path is missing for
running h/w queue from submission path.

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c index
54f9015..bcfd33a 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -173,8 +173,10 @@ static int blk_mq_do_dispatch_ctx(struct
blk_mq_hw_ctx *hctx)
                if (!sbitmap_any_bit_set(&hctx->ctx_map))
                        break;

-               if (!blk_mq_get_dispatch_budget(hctx))
+               if (!blk_mq_get_dispatch_budget(hctx)) {
+                       blk_mq_delay_run_hw_queue(hctx,
+ BLK_MQ_BUDGET_DELAY);
                        break;
+               }

                rq = blk_mq_dequeue_from_ctx(hctx, ctx);
                if (!rq) {

Are you saying above fix should be included along with your latest patch ?

>
>
> Thanks,
> Ming
