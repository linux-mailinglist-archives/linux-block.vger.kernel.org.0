Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD59DE7E6
	for <lists+linux-block@lfdr.de>; Mon, 21 Oct 2019 11:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfJUJT3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 21 Oct 2019 05:19:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4694 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726981AbfJUJT3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 05:19:29 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 348E6D9C474C109B106D;
        Mon, 21 Oct 2019 17:19:27 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Mon, 21 Oct 2019
 17:19:23 +0800
Subject: Re: [PATCH V4 0/5] blk-mq: improvement on handling IO during CPU
 hotplug
To:     Ming Lei <ming.lei@redhat.com>
References: <20191014015043.25029-1-ming.lei@redhat.com>
 <d30420d7-74d9-4417-1bbe-8113848e74fa@huawei.com>
 <20191016120729.GB5515@ming.t460p>
 <9dbc14ab-65cd-f7ac-384c-2dbe03575ee7@huawei.com>
 <55a84ea3-647d-0a76-596c-c6c6b2fc1b75@huawei.com>
 <20191020101404.GA5103@ming.t460p>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <10aac76a-26bb-bcda-c6ea-b39ca66d6740@huawei.com>
Date:   Mon, 21 Oct 2019 10:19:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20191020101404.GA5103@ming.t460p>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 20/10/2019 11:14, Ming Lei wrote:
>>> ght? If so, I need to find some simple sysfs entry to
>>> > > tell me of this occurrence, to trigger the capture. Or add something. My
>>> > > script is pretty dump.
>>> > >
>>> > > BTW, I did notice that we the dump_stack in __blk_mq_run_hw_queue()
>>> > > pretty soon before the problem happens - maybe a clue or maybe coincidence.
>>> > >
>> >
>> > I finally got to capture that debugfs dump at the point the SCSI IOs
>> > timeout, as attached. Let me know if any problem receiving it.
>> >
>> > Here's a kernel log snippet at that point (I added some print for the
>> > timeout):
>> >
>> > 609] psci: CPU6 killed.
>> > [  547.722217] CPU5: shutdown
>> > [  547.724926] psci: CPU5 killed.
>> > [  547.749951] irq_shutdown
>> > [  547.752701] IRQ 800: no longer affine to CPU4
>> > [  547.757265] CPU4: shutdown
>> > [  547.759971] psci: CPU4 killed.
>> > [  547.790348] CPU3: shutdown
>> > [  547.793052] psci: CPU3 killed.
>> > [  547.818330] CPU2: shutdown
>> > [  547.821033] psci: CPU2 killed.
>> > [  547.854285] CPU1: shutdown
>> > [  547.856989] psci: CPU1 killed.
>> > [  575.925307] scsi_timeout req=0xffff0023b0dd9c00 reserved=0
>> > [  575.930794] scsi_timeout req=0xffff0023b0df2700 reserved=0
>>From the debugfs log, 66 requests are dumped, and 63 of them has
> been submitted to device, and the other 3 is in ->dispatch list
> via requeue after timeout is handled.
>

Hi Ming,

> You mentioned that:
>
> " - I added some debug prints in blk_mq_hctx_drain_inflight_rqs() for when
>  inflights rqs !=0, and I don't see them for this timeout"
>
> There might be two reasons:
>
> 1) You are still testing a multiple reply-queue device?

As before, I am testing by exposing mutliple queues to the SCSI 
midlayer. I had to make this change locally, as on mainline we still 
only expose a single queue and use the internal reply queue when 
enabling managed interrupts.

As I
> mentioned last times, it is hard to map reply-queue into blk-mq
> hctx correctly.

Here's my branch, if you want to check:

https://github.com/hisilicon/kernel-dev/commits/private-topic-sas-5.4-mq-v4

It's a bit messy (sorry), but you can see that the reply-queue in the 
LLDD is removed in commit 087b95af374.

I am now thinking of actually making this change to the LLDD in mainline 
to avoid any doubt in future.

>
> 2) concurrent dispatch to device, which can be observed by the
> following patch.
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 06081966549f..3590f6f947eb 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -679,6 +679,8 @@ void blk_mq_start_request(struct request *rq)
>  {
>         struct request_queue *q = rq->q;
>
> +       WARN_ON_ONCE(test_bit(BLK_MQ_S_INTERNAL_STOPPED, &rq->mq_hctx->state));
> +
>         trace_block_rq_issue(q, rq);
>
>         if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
>
> However, I think it is hard to be 2#, since the current CPU is the last
> CPU in hctx->cpu_mask.
>

I'll try it.

Thanks as always,
John

>
> Thanks,
> Ming
>
>
> .
>


