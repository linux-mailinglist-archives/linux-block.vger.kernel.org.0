Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EA262EB56
	for <lists+linux-block@lfdr.de>; Fri, 18 Nov 2022 02:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbiKRBv4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 17 Nov 2022 20:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiKRBvz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Nov 2022 20:51:55 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FFB1ADB4
        for <linux-block@vger.kernel.org>; Thu, 17 Nov 2022 17:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668736313; x=1700272313;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eVYIumUrfyCAQ4SC9FSPKid1CWSFQ3W2L42G6q/cqyM=;
  b=fuP4sj2jRIxnpTbv8fIj4H8LO7e06nPTwR86hxyHevEMQTUvxN1bFz8/
   GjibR4Dsp7sBw/DAZcmXYp1KIIW8QEPth1ZZgk5w591dXSgRRfUl0qcOi
   jAjS/f6mywra+nmCIERUeX3E8hcpjpt8QG3ibqmR1zBMKb1HGcOwcoVSZ
   FZ7F2rMggc8XXaxKhPyPbqEnx6KenBeJTl/pgiQg0tqErv4jvrk5kS9Zv
   A0pnrG2DCBme8UuEMNRth9LpBQBHCqZznkSfLF/p2y8LI+yEF8uDsJWgn
   fD4mBoi5qsRl0aBrcDv7M/BUme9sz9SQbFRSyg9FpbCqvqKm2enwXFhlW
   A==;
X-IronPort-AV: E=Sophos;i="5.96,172,1665417600"; 
   d="scan'208";a="328672573"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Nov 2022 09:51:53 +0800
IronPort-SDR: LYjSAeZMTz8ez2D6cRbF+3D37uAaIAHHzQIgPz2BKmObLFtyjwG9rzb/HGLCGiPAaX8T4wx8og
 Mxf7p6uVqSW5hgvLeetWtfjMqm+YgVyROLNkrweLFfBHWyl0MQizeYBVjqYzzxuTb6Uo8STFXz
 s6LA80xehVBPUEi9V9pO1/tgZSFdNz67bqGt7VzzFA2e4xq0R3P54ASf7p5XlUFHnBPKH7y4qB
 WEwNSoEzPoQdckaygHm64G31xo1PX061WRdBKrl2pjxj6+rjWprLt7RvBj3TPKSn80mbnoTeqZ
 nbQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Nov 2022 17:05:02 -0800
IronPort-SDR: xmKwqJOxZInxKj/DEAKz6QmKMr+ZSSYuy+722+R8T+lJixOG/6jKvQFH3nbbhknPrOuhLf916o
 NuLHGq8MpYs6j3YZ/SbwvQ3VQD3GCGbxMBBdFyEIlacAaS2Py0PinOXYXcrvpYyUswrnEDAO5H
 A3y9AoTVJAKn3JGTaYhO4dnmA+cmcbx0oaSYMjeOQfT44q95SkdArKFYd1DXZeEM4Z4C/02OZq
 yeSRBbn78/z2tKeEyz/ZG7EbInY0kaPrxte177uCrAud7GFld5VsBuTlP7ml+ws1ZKf2gmkp14
 KHA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Nov 2022 17:51:52 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4ND0Bw0LNCz1RvTr
        for <linux-block@vger.kernel.org>; Thu, 17 Nov 2022 17:51:52 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668736310; x=1671328311; bh=eVYIumUrfyCAQ4SC9FSPKid1CWSFQ3W2L42
        G6q/cqyM=; b=hoZUSUuTTqL3N8PP8xE0UbHFrFkoNMHhlTDX3r7sxfYUGJOO5Jm
        Q3qtvHeqgy6vmeP95VZpq//QQwHndzJWo/WMQ4YQ7z9ZlehH9HrYLi9mbNTl5vir
        FtCOes8sS9r60A05KGzw1/zpqB5XHfSpNOFGinLL3uhT0F4W0NfsgUNXAy+Xvb7c
        P46wgk5LEnlC3arzOYucGVJyq3ZuLZHZRGf9DQ6gtL706UtdNYnrqkGamGaelLSn
        h2qfzhzr71Y7PzGBWpDHUQxY+aea0WrOXdpT2dsFVUxkZR/D2GuvINKnkNdsyv/H
        D1NyFzSYGYw95HGVl0W8XAoDgQzPijTgUkw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5dXvt7JIqoPx for <linux-block@vger.kernel.org>;
        Thu, 17 Nov 2022 17:51:50 -0800 (PST)
Received: from [10.225.163.51] (unknown [10.225.163.51])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4ND0Bs5Vxkz1RvLy;
        Thu, 17 Nov 2022 17:51:49 -0800 (PST)
Message-ID: <0f0ef3e2-5585-6187-6f61-d2fb1af54441@opensource.wdc.com>
Date:   Fri, 18 Nov 2022 10:51:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Reordering of ublk IO requests
Content-Language: en-US
To:     Andreas Hindborg <andreas.hindborg@wdc.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
References: <87sfii99e7.fsf@wdc.com> <Y3WZ41tKFZHkTSHL@T590>
 <87o7t67zzv.fsf@wdc.com> <Y3X2M3CSULigQr4f@T590> <87k03u7x3r.fsf@wdc.com>
 <Y3YfUjrrLJzPWc4H@T590> <87fseh92aa.fsf@wdc.com>
 <b8c15259-f8ab-6c47-46ab-872c658f1052@opensource.wdc.com>
 <87bkp58zuw.fsf@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <87bkp58zuw.fsf@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/17/22 22:31, Andreas Hindborg wrote:
> 
> Damien Le Moal <damien.lemoal@opensource.wdc.com> writes:
> 
>> On 11/17/22 20:59, Andreas Hindborg wrote:
>>>
>>> Ming Lei <ming.lei@redhat.com> writes:
>>>
>>>> On Thu, Nov 17, 2022 at 10:07:14AM +0100, Andreas Hindborg wrote:
>>>>>
>>>>> Ming Lei <ming.lei@redhat.com> writes:
>>>>>
>>>>>> On Thu, Nov 17, 2022 at 09:05:48AM +0100, Andreas Hindborg wrote:
>>>>>>>
>>>>>>> Ming Lei <ming.lei@redhat.com> writes:
>>>>>>>
>>>>>>>> Hi Andreas,
>>>>>>>>
>>>>>>>> On Wed, Nov 16, 2022 at 04:00:15PM +0100, Andreas Hindborg wrote:
>>>>>>>>>
>>>>>>>>> Hi Ming,
>>>>>>>>>
>>>>>>>>> I have a question regarding ublk. For context, I am working on adding
>>>>>>>>> zoned storage support to ublk, and you have been very kind to help me on
>>>>>>>>> Github [1].
>>>>>>>>>
>>>>>>>>> I have a problem with ordering of requests after they are issued to the
>>>>>>>>> ublk driver. Basically ublk will reverse the ordering of requests that are
>>>>>>>>> batched. The behavior can be observed with the following fio workload:
>>>>>>>>>
>>>>>>>>>> fio --name=test --ioengine=io_uring --rw=read --bs=4m --direct=1
>>>>>>>>>> --size=4m --filename=/dev/ublkb0
>>>>>>>>>
>>>>>>>>> For a loopback ublk target I get the following from blktrace:
>>>>>>>>>
>>>>>>>>>> 259,2    0     3469   286.337681303   724  D   R 0 + 1024 [fio]
>>>>>>>>>> 259,2    0     3470   286.337691313   724  D   R 1024 + 1024 [fio]
>>>>>>>>>> 259,2    0     3471   286.337694423   724  D   R 2048 + 1024 [fio]
>>>>>>>>>> 259,2    0     3472   286.337696583   724  D   R 3072 + 1024 [fio]
>>>>>>>>>> 259,2    0     3473   286.337698433   724  D   R 4096 + 1024 [fio]
>>>>>>>>>> 259,2    0     3474   286.337700213   724  D   R 5120 + 1024 [fio]
>>>>>>>>>> 259,2    0     3475   286.337702723   724  D   R 6144 + 1024 [fio]
>>>>>>>>>> 259,2    0     3476   286.337704323   724  D   R 7168 + 1024 [fio]
>>>>>>>>>> 259,1    0     1794   286.337794934   390  D   R 6144 + 2048 [ublk]
>>>>>>>>>> 259,1    0     1795   286.337805504   390  D   R 4096 + 2048 [ublk]
>>>>>>>>>> 259,1    0     1796   286.337816274   390  D   R 2048 + 2048 [ublk]
>>>>>>>>>> 259,1    0     1797   286.337821744   390  D   R 0 + 2048 [ublk]
>>>>>>>>>
>>>>>>>>> And enabling debug prints in ublk shows that the reversal happens when
>>>>>>>>> ublk defers work to the io_uring context:
>>>>>>>>>
>>>>>>>>>> kernel: ublk_queue_rq: qid 0, tag 180, sect 0
>>>>>>>>>> kernel: ublk_queue_rq: qid 0, tag 181, sect 1024
>>>>>>>>>> kernel: ublk_queue_rq: qid 0, tag 182, sect 2048
>>>>>>>>>> kernel: ublk_queue_rq: qid 0, tag 183, sect 3072
>>>>>>>>>> kernel: ublk_queue_rq: qid 0, tag 184, sect 4096
>>>>>>>>>> kernel: ublk_queue_rq: qid 0, tag 185, sect 5120
>>>>>>>>>> kernel: ublk_queue_rq: qid 0, tag 186, sect 6144
>>>>>>>>>> kernel: ublk_queue_rq: qid 0, tag 187, sect 7168
>>>>>>>>>> kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 187 io_flags 1 addr 7f245d359000, sect 7168
>>>>>>>>>> kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 186 io_flags 1 addr 7f245fcfd000, sect 6144
>>>>>>>>>> kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 185 io_flags 1 addr 7f245fd7f000, sect 5120
>>>>>>>>>> kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 184 io_flags 1 addr 7f245fe01000, sect 4096
>>>>>>>>>> kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 183 io_flags 1 addr 7f245fe83000, sect 3072
>>>>>>>>>> kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 182 io_flags 1 addr 7f245ff05000, sect 2048
>>>>>>>>>> kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 181 io_flags 1 addr 7f245ff87000, sect 1024
>>>>>>>>>> kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 180 io_flags 1 addr 7f2460009000, sect 0
>>>>>>>>>
>>>>>>>>> The problem seems to be that the method used to defer work to the
>>>>>>>>> io_uring context, task_work_add(), is using a stack to queue the
>>>>>>>>> callbacks.
>>>>>>>>
>>>>>>>> Is the observation done on zoned ublk or plain ublk-loop?
>>>>>>>
>>>>>>> I collected this trace on my fork, but since the behavior comes from
>>>>>>> task_work.c using a stack to queue work, it would be present on upstream
>>>>>>> ublk as well. For completeness, I have verified that this is the case.
>>>>>>>
>>>>>>>> If it is plain ublk-loop, the reverse order can be started from
>>>>>>>> blk_add_rq_to_plug(), but it won't happen for zoned write request
>>>>>>>> which isn't queued to plug list.
>>>>>>>
>>>>>>> I forgot to mention that I set the deadline scheduler for both ublkb0
>>>>>>> and the loopback target. No reordering should happen in mq with the
>>>>>>> deadline scheduler, as far as I understand.
>>>>>>
>>>>>> I meant you need to setup one zoned ublk-loop for observing write request
>>>>>> order, block layer never guarantees request order for other devices.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Otherwise, can you observe zoned write req reorder from ublksrv side?
>>>>>>>>
>>>>>>>
>>>>>>> Yes, the reverse order is observable in ublk server. Reordering happens
>>>>>>> in ublk kernel driver.
>>>>>>>
>>>>>>>>>
>>>>>>>>> As you probably are aware, writes to zoned storage must
>>>>>>>>> happen at the write pointer, so when order is lost there is a problem.
>>>>>>>>> But I would assume that this behavior is also undesirable in other
>>>>>>>>> circumstances.
>>>>>>>>>
>>>>>>>>> I am not sure what is the best approach to change this behavor. Maybe
>>>>>>>>> having a separate queue for the requests and then only scheduling work
>>>>>>>>> if a worker is not already processing the queue?
>>>>>>>>>
>>>>>>>>> If you like, I can try to implement a fix?
>>>>>>>>
>>>>>>>> Yeah, I think zoned write requests could be forwarded to ublk server out of order.
>>>>>>>
>>>>>>> In reverse order for requests that are issued without a context switch,
>>>>>>> as far as I can tell.
>>>>>>>
>>>>>>>>
>>>>>>>> Is it possible for re-order the writes in ublksrv side? I guess it is
>>>>>>>> be doable:
>>>>>>>>
>>>>>>>> 1) zoned write request is sent to ublk_queue_rq() in order always
>>>>>>>>
>>>>>>>> 2) when ublksrv zone target/backend code gets zoned write request in each
>>>>>>>> zone, it can wait until the next expected write comes, then handle the
>>>>>>>> write and advance write pointer, then repeat the whole process.
>>>>>>>>
>>>>>>>> 3) because of 1), the next expected zoned write req is guaranteed to
>>>>>>>> come without much delay, and the per-zone queue won't be long.
>>>>>>>
>>>>>>> I think it is not feasible to have per zone data structures. Instead, I
>>>>>>
>>>>>> If one mapping data structure is used for ordering per-zone write
>>>>>> request, it could be pretty easy, such as C++'s map or hash table, and it
>>>>>> won't take much memory given the max in-flight IOs are very limited and
>>>>>> the zone mapping entry can be reused among different zone, and quite easy
>>>>>> to implement.
>>>>>>
>>>>>> Also most of times, the per-zone ordering can be completed in current
>>>>>> batch(requests completed from single io_uring_enter()), then the extra
>>>>>> cost could be close to zero, you can simply run the per-zone ordering in
>>>>>> ->handle_io_background() callback, when all requests could come for each
>>>>>> zone most of times.
>>>>>>
>>>>>>> considered adding a sequence number to each request, and then queue up
>>>>>>> requests if there is a gap in the numbering.
>>>>>>
>>>>>> IMO, that won't be doable, given you don't know when the sequence will be over.
>>>>>
>>>>> We would not need to know when the sequence is over. If in ubdsrv we see
>>>>> request number 1,2,4, we could hold 4 until 3 shows up. When 3 shows up
>>>>> we go ahead and submit all requests from 3 and up, until there is
>>>>> another gap. If ublk_drv is setting the sequence numbers,
>>>>> cancelled/aborted requests would not be an issue.
>>>>>
>>>>> I think this would be less overhead than having per zone data structure.
>>>>
>>>> You can only assign it to zoned write request, but you still have to check
>>>> the sequence inside each zone, right? Then why not just check LBAs in
>>>> each zone simply?
>>>
>>> We would need to know the zone map, which is not otherwise required.
>>> Then we would need to track the write pointer for each open zone for
>>> each queue, so that we can stall writes that are not issued at the write
>>> pointer. This is in effect all zones, because we cannot track when zones
>>> are implicitly closed. Then, if different queues are issuing writes to
>>> the same zone, we need to sync across queues. Userspace may have
>>> synchronization in place to issue writes with multiple threads while
>>> still hitting the write pointer.
>>>
>>> It is not good enough to only impose ordering within a zone if we have
>>> requests in flight for that zone. For the first write to a zone when there
>>> are no writes in flight to that zone, we can not know if the write is at
>>> the write pointer, or if more writes to lower LBA is on the way. Not
>>> without tracking the write pointer.
>>>
>>> With a sequence number, the sequence number can be queue local. It would
>>> not guarantee that writes always happen at the write pointer, but it
>>> would guarantee that requests are not reordered by ublk_drv, which is
>>> all that is required. As long as userspace is issuing at the write
>>> pointer (as they are required to for zoned storage), this solution would
>>> work, even across multiple queues issuing writes to the same zone.
>>>
>>>>
>>>>>
>>>>> But I still think it is an unnecessary hack. We could just fix the driver.
>>>>
>>>> But not sure if it is easy to make io_uring_cmd_complete_in_task() or
>>>> task_work_add to complete request in order efficiently.
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>> But really, the issue should be resolved by changing the way
>>>>>>> ublk_queue_rq() is sending work to uring context with task_add_work().
>>>>>>
>>>>>> Not sure it can be solved easily given llist is implemented in this way.
>>>>>
>>>>> If we queue requests on a separate queue, we are fine. I can make a
>>>>> patch suggestion.
>>>>
>>>> The problem is that io_uring_cmd_complete_in_task() or task_work_add() may
>>>> re-order the request, can you explain why the issue can be solved by
>>>> separate queue?
>>>
>>> I would suggest to still use task_work_add() to queue a callback, but
>>> instead of carrying the pdu as the callback argument, use it as a
>>> notification that one or more work items are queued. Then we add the pdu
>>> to a hwctx local FIFO queue.
>>>
>>> __ublk_rq_task_work() would then check this FIFO queue and submit all
>>> the requests on the queue to userspace.
>>>
>>> Without further optimization __ublk_rq_task_work() would some times be
>>> called with an empty queue, but this should not be too much overhead.
>>> Maybe we could decide to not call task_work_add() if the hwctx local
>>> queue of pdus is not empty.
>>>
>>>>
>>>>>
>>>>>>
>>>>>>> Fixing in ublksrv is a bit of a hack and will have performance penalty.
>>>>>>
>>>>>> As I mentioned, ordering zoned write request in each zone just takes
>>>>>> a little memory(mapping, or hashing) and the max size of the mapping
>>>>>> table is queue depth, and basically zero cpu cost, not see extra
>>>>>> performance penalty is involved.
>>>>>
>>>>> I could implement all three solutions. 1) fix the dirver, 2) per zone
>>>>> structure and 3) sequence numbers. Then I benchmark them and we will
>>>>> know what works. It's a lot of work though.
>>>>
>>>> Let's prove if the theory for each solution is correct first.
>>>
>>> Alright.
>>>
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Also, it can not be good for any storage device to have sequential
>>>>>>> requests delivered in reverse order? Fixing this would benefit all targets.
>>>>>>
>>>>>> Only zoned target has strict ordering requirement which does take cost, block
>>>>>> layer never guarantees request order. As I mentioned, blk_add_rq_to_plug()
>>>>>> can re-order requests in reverse order too.
>>>>>
>>>>> When mq-deadline scheduler is set for a queue, requests are not
>>>>> reordered, right?
>>>>
>>>> In case of batching submission, mq-deadline will order requests by
>>>> LBA in this whole batch.
>>>
>>> That is not what I am seeing in practice. I tried looking through
>>> mq-deadline.c, but I could not find code that would order by LBA. Could
>>> you point me to the code that implements this policy?
>>
>> see the use of the rb tree, deadline_add_rq_rb() and friends. The rb tree
>> maintains the requests in LBA order. The fifo list, maintains an arrival
>> order for starvation control.
> 
> Thanks!
> 
>>
>>>
>>>>
>>>>>
>>>>> I am no block layer expert, so I cannot argue about the implementation.
>>>>> But I think that both spinning rust and flash would benefit from having
>>>>> sequential requests delivered in order? Would it not hurt performance to
>>>>> reverse order for sequential requests all the time? I have a hard time
>>>>> understanding why the block layer would do this by default.
>>>>>
>>>>> One thing is to offer no guarantees, but to _always_ reverse the
>>>>> ordering of sequential requests seem a little counter productive to me.
>>>>
>>>> If io_uring_cmd_complete_in_task()/task_work_add() can complete io
>>>> commands to ublksrv in order without extra cost, that is better.
>>>
>>> I agree :)
>>>
>>>>
>>>> But I don't think it is a big deal for HDD. because when these requests
>>>> are re-issued from ublksrv to block layer, deadline or bfq will order
>>>> them too since all are submitted via io_uring in batch.
>>>
>>> As I wrote, that is not what I am seeing in my experiment. Repeating the
>>> output of blktrace from the top of this email:
>>>
>>> 259,2    0     3469   286.337681303   724  D   R 0 + 1024 [fio]
>>> 259,2    0     3470   286.337691313   724  D   R 1024 + 1024 [fio]
>>> 259,2    0     3471   286.337694423   724  D   R 2048 + 1024 [fio]
>>> 259,2    0     3472   286.337696583   724  D   R 3072 + 1024 [fio]
>>> 259,2    0     3473   286.337698433   724  D   R 4096 + 1024 [fio]
>>> 259,2    0     3474   286.337700213   724  D   R 5120 + 1024 [fio]
>>> 259,2    0     3475   286.337702723   724  D   R 6144 + 1024 [fio]
>>> 259,2    0     3476   286.337704323   724  D   R 7168 + 1024 [fio]
>>> 259,1    0     1794   286.337794934   390  D   R 6144 + 2048 [ublk]
>>> 259,1    0     1795   286.337805504   390  D   R 4096 + 2048 [ublk]
>>> 259,1    0     1796   286.337816274   390  D   R 2048 + 2048 [ublk]
>>> 259,1    0     1797   286.337821744   390  D   R 0 + 2048 [ublk]
>>>
>>> Here the read of 6144:
>>> 259,1    0     1794   286.337794934   390  D   R 6144 + 2048 [ublk]
>>>
>>> is clearly issued before the read of 4096:
>>> 259,1    0     1795   286.337805504   390  D   R 4096 + 2048 [ublk]
>>>
>>> It is not because there are no IO in flight for the target device. Here
>>> is he trace with completions included:
>>>
>>> 259,2   10        1     0.000000000   468  D   R 0 + 1024 [fio]
>>> 259,2   10        2     0.000005680   468  D   R 1024 + 1024 [fio]
>>> 259,2   10        3     0.000007760   468  D   R 2048 + 1024 [fio]
>>> 259,2   10        4     0.000009140   468  D   R 3072 + 1024 [fio]
>>> 259,2   10        5     0.000010420   468  D   R 4096 + 1024 [fio]
>>> 259,2   10        6     0.000011640   468  D   R 5120 + 1024 [fio]
>>> 259,2   10        7     0.000013350   468  D   R 6144 + 1024 [fio]
>>> 259,2   10        8     0.000014350   468  D   R 7168 + 1024 [fio]
>>> 259,1   10        1     0.000280540   412  D   R 6144 + 2048 [ublk]
>>> 259,1   10        2     0.000433260   412  D   R 4096 + 2048 [ublk]
>>> 259,1   10        3     0.000603920   412  D   R 2048 + 2048 [ublk]
>>> 259,1   10        4     0.000698070   412  D   R 0 + 2048 [ublk]
>>> 259,1   10        5     0.000839250     0  C   R 6144 + 2048 [0]
>>> 259,2   10        9     0.000891270   412  C   R 7168 + 1024 [0]
>>> 259,2   10       10     0.000919780   412  C   R 6144 + 1024 [0]
>>> 259,1   10        6     0.001258791     0  C   R 4096 + 2048 [0]
>>> 259,2   10       11     0.001306541   412  C   R 5120 + 1024 [0]
>>> 259,2   10       12     0.001335291   412  C   R 4096 + 1024 [0]
>>> 259,1   10        7     0.001469911     0  C   R 2048 + 2048 [0]
>>> 259,2   10       13     0.001518281   412  C   R 3072 + 1024 [0]
>>> 259,2   10       14     0.001547041   412  C   R 2048 + 1024 [0]
>>> 259,1   10        8     0.001600801     0  C   R 0 + 2048 [0]
>>> 259,2   10       15     0.001641871   412  C   R 1024 + 1024 [0]
>>> 259,2   10       16     0.001671921   412  C   R 0 + 1024 [0]
>>>
>>> This last trace is vanilla Linux 6.0 with mq-deadline enabled for ublkb0(259,2)
>>> and the loopback target nvme0n1(259,1).
>>
>> queue at head that should be queue at tail ? if nvme0n1 is a multi queue
>> device and does not have a scheduler, there may be a lot of "issue
>> directly" that can really destroy the order of requests.
> 
> It is a regular nvme drive handled by the nvme driver. So multi queue
> with mq-deadline set.
> 
> Unless I am reading the trace wrong there are 3 reads issued to 259,1
> sectors 6144, 4096 and 2048 in that order. This is the order userspace
> is issuing the reads, so the trace matches what I would expect. But now
> you tell me that the mq-deadline scheduler should reorder the requests
> based on LBA? But maybe the ordering by LBA is only for writes? I'll
> rerun the test with writes.

Nope. Reordering is for reads too. But reordering happens only if the
commands are issued in batch or if the drive is busy (all tags used) and
commands accumulate in the scheduler.

If the user issues these reads one at a time, they will go through the
scheduler without reordering. You can see that with blktrace:
If you see a G-Q-I-D sequence for each read, then it is not a batch and
they are going through as is. If you see G-Q-I-G-Q-I-G-Q-I-D-D-D, then
that was a batch and the "D" should be ordered in increasing LBA, even if
the I (insert) where out of order.

> 
> Best regards,
> Andreas
> 

-- 
Damien Le Moal
Western Digital Research

