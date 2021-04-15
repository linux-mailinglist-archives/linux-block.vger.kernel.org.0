Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6227036082B
	for <lists+linux-block@lfdr.de>; Thu, 15 Apr 2021 13:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbhDOLWV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 15 Apr 2021 07:22:21 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:55198 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231482AbhDOLWR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 07:22:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UVeFt.m_1618485712;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UVeFt.m_1618485712)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Apr 2021 19:21:53 +0800
Subject: Re: [PATCH V5 11/12] block: add poll_capable method to support
 bio-based IO polling
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
References: <20210401021927.343727-1-ming.lei@redhat.com>
 <20210401021927.343727-12-ming.lei@redhat.com>
 <20210412093856.GA978201@infradead.org>
 <a6d46979-810e-bc53-bc19-8acd449e3718@linux.alibaba.com>
 <YHbQ/rZUPoTFUMDs@T590>
 <5f30059d-6650-8268-b681-d8567ac1c509@linux.alibaba.com>
 <YHfumsTKHuvPGp47@T590>
 <0ceb3060-bce4-c39d-26cf-8c715ebbfd51@linux.alibaba.com>
 <YHgQNL4byNCEmh3/@T590>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <5f2542e4-1c36-71e8-5c72-a85b23c98b72@linux.alibaba.com>
Date:   Thu, 15 Apr 2021 19:21:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YHgQNL4byNCEmh3/@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 4/15/21 6:06 PM, Ming Lei wrote:
> On Thu, Apr 15, 2021 at 05:21:56PM +0800, JeffleXu wrote:
>>
>>
>> On 4/15/21 3:43 PM, Ming Lei wrote:
>>> On Thu, Apr 15, 2021 at 09:34:36AM +0800, JeffleXu wrote:
>>>>
>>>>
>>>> On 4/14/21 7:24 PM, Ming Lei wrote:
>>>>> On Wed, Apr 14, 2021 at 04:38:25PM +0800, JeffleXu wrote:
>>>>>>
>>>>>>
>>>>>> On 4/12/21 5:38 PM, Christoph Hellwig wrote:
>>>>>>> On Thu, Apr 01, 2021 at 10:19:26AM +0800, Ming Lei wrote:
>>>>>>>> From: Jeffle Xu <jefflexu@linux.alibaba.com>
>>>>>>>>
>>>>>>>> This method can be used to check if bio-based device supports IO polling
>>>>>>>> or not. For mq devices, checking for hw queue in polling mode is
>>>>>>>> adequate, while the sanity check shall be implementation specific for
>>>>>>>> bio-based devices. For example, dm device needs to check if all
>>>>>>>> underlying devices are capable of IO polling.
>>>>>>>>
>>>>>>>> Though bio-based device may have done the sanity check during the
>>>>>>>> device initialization phase, cacheing the result of this sanity check
>>>>>>>> (such as by cacheing in the queue_flags) may not work. Because for dm
>>>>>>>> devices, users could change the state of the underlying devices through
>>>>>>>> '/sys/block/<dev>/io_poll', bypassing the dm device above. In this case,
>>>>>>>> the cached result of the very beginning sanity check could be
>>>>>>>> out-of-date. Thus the sanity check needs to be done every time 'io_poll'
>>>>>>>> is to be modified.
>>>>>>>
>>>>>>> I really don't think thi should be a method, and I really do dislike
>>>>>>> how we have all this "if (is_mq)" junk.  Why can't we have a flag on
>>>>>>> the gendisk that signals if the device can support polling that
>>>>>>> is autoamtically set for blk-mq and as-needed by bio based drivers?
>>>>>>
>>>>>> That would consume one more bit of queue->queue_flags.
>>>>>>
>>>>>> Besides, DM/MD is somehow special here that when one of the underlying
>>>>>> devices is disabled polling through '/sys/block/<dev>/io_poll',
>>>>>> currently there's no mechanism notifying the above MD/DM to clear the
>>>>>> previously set queue_flags. Thus the outdated queue_flags still
>>>>>> indicates this DM/MD is capable of polling, while in fact one of the
>>>>>> underlying device has been disabled for polling.
>>>>>
>>>>> Right, just like there isn't queue limit progagation.
>>>>>
>>>>> Another blocker could be that bio based queue doesn't support queue
>>>>> freezing.
>>>>
>>>> Do you mean the queue freezing is called in the following code snippet?
>>>>
>>>> ```
>>>> static ssize_t queue_poll_store(struct request_queue *q, const char
>>>> *page, size_t count)
>>>> {
>>>> 	...
>>>> 	if (poll_on) {
>>>> 		blk_queue_flag_set(QUEUE_FLAG_POLL, q);
>>>> 	} else {
>>>> 		blk_mq_freeze_queue(q);
>>>> 		blk_queue_flag_clear(QUEUE_FLAG_POLL, q);
>>>> 		blk_mq_unfreeze_queue(q);
>>>> 	}
>>>> ```
>>>
>>> Yes, if it is a bio based queue. Or bio queued queue(DM, MD or others) may
>>> use freeze_queue to do similar thing.
>>>
>>>>
>>>> And I can't understand how bio-based queue doesn't support queue freezing.
>>>>
>>>> ```
>>>> submit_bio_noacct
>>>> 	__submit_bio_noacct
>>>> 		bio_queue_enter
>>>> ```
>>>>
>>>> Every time submitting a bio, bio_queue_enter() will be called, and once
>>>> the queue has been frozen, bio_queue_enter() will wait there until the
>>>> queue is unfrozen.
>>>
>>> Not like blk-mq, the refcount is just grabbed during submission for bio based
>>> queue. 
>>
>> Could you please explain it more detailed ....
> 
> Please see __submit_bio(), in which the queue ref is dropped.
> 
>>
>>
>> I will research a bit and see if we can extend freeze queue for
>>> covering bio based queue. One trouble is that bio is ended before
>>> freeing request.
>>>
>>>>
>>>>>
>>>>>>
>>>>>> Mike had ever suggested that we can trust the queue_flag, and clear the
>>>>>> outdated queue_flags when later the IO submission or polling routine
>>>>>> finally finds that the device is not capable of polling. Currently
>>>>>> submit_bio_checks() will silently clear the REQ_HIPRI flag and still
>>>>>> submit the bio when the device is actually not capable of polling. To
>>>>>> fix the issue, could we break the submission and return an error code in
>>>>>> submit_bio_checks() if the device is not capable of polling when
>>>>>> submitting HIPRI bio?
>>>>>
>>>>> I think we may just leave it alone, if underlying queue becomes not pollable,
>>>>> the bio still can be submitted & completed via IRQ, just not efficient enough.
>>>>
>>>> Yes it still works. I agree if there's no better solution...
>>>>
>>>> And what about the issue Christoph originally concerned? Do we use one
>>>> more flag bit indicating if the queue capable of polling, or the
>>>> poll_capable() method way?
>>>
>>> Just wondering why we can't use QUEUE_FLAG_POLL simply? If user wants to
>>> enable it, let's do it for them. And bio driver can start with default poll
>>> state by checking underlying queues.
>>>
>>
>> Consider the following scenario: QUEUE_FLAG_POLL is set after
>> initialization, indicating the device capable of polling; then polling
>> is turned off by '/sys/block/<dev>/io_poll', thus QUEUE_FLAG_POLL is
>> cleared.
> 
> If the flag is cleared, the bio will be submitted to irq queue, what is
> the problem?
> 

The IO path has no problem. It is the control path. If you want to turn
on polling then, you have to check if the device capable of polling,
while QUEUE_FLAG_POLL has been cleared in this case. IOW you can't rely
on QUEUE_FLAG_POLL to see if the device has the **ability** of polling.
QUEUE_FLAG_POLL flag only indicates if polling is turned on or off
currently.

-- 
Thanks,
Jeffle
