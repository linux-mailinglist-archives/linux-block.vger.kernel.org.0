Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16B23EA57E
	for <lists+linux-block@lfdr.de>; Thu, 12 Aug 2021 15:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237782AbhHLNWo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Aug 2021 09:22:44 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:51464 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237552AbhHLNTd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 09:19:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UinuYXj_1628774345;
Received: from legedeMacBook-Pro.local(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0UinuYXj_1628774345)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Aug 2021 21:19:06 +0800
Subject: Re: [PATCH] blk-mq: fix kernel panic during iterating over flush
 request
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>,
        "Blank-Burian, Markus, Dr." <blankburian@uni-muenster.de>
References: <20210811142624.618598-1-ming.lei@redhat.com>
 <fbb2f753-d28c-3400-3ad5-5ec863375428@linux.alibaba.com>
 <YRUcenpHYm6g+iBt@T590>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Message-ID: <87735642-b7b9-f43a-8417-fbbe8fc096ed@linux.alibaba.com>
Date:   Thu, 12 Aug 2021 21:19:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRUcenpHYm6g+iBt@T590>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

hi,


> On Thu, Aug 12, 2021 at 07:47:55PM +0800, Xiaoguang Wang wrote:
>> hi,
>>
>>
>>> For fixing use-after-free during iterating over requests, we grabbed
>>> request's refcount before calling ->fn in commit 2e315dc07df0 ("blk-mq:
>>> grab rq->refcount before calling ->fn in blk_mq_tagset_busy_iter").
>>> Turns out this way may cause kernel panic when iterating over one flush
>>> request:
>>>
>>> 1) old flush request's tag is just released, and this tag is reused by
>>> one new request, but ->rqs[] isn't updated yet
>>>
>>> 2) the flush request can be re-used for submitting one new flush command,
>>> so blk_rq_init() is called at the same time
>>>
>>> 3) meantime blk_mq_queue_tag_busy_iter() is called, and old flush request
>>> is retrieved from ->rqs[tag]; when blk_mq_put_rq_ref() is called,
>>> flush_rq->end_io may not be updated yet, so NULL pointer dereference
>>> is triggered in blk_mq_put_rq_ref().
>>>
>>> Fix the issue by calling refcount_set(&flush_rq->ref, 1) after
>>> flush_rq->end_io is set. So far the only other caller of blk_rq_init() is
>>> scsi_ioctl_reset() in which the request doesn't enter block IO stack and
>>> the request reference count isn't used, so the change is safe.
>>>
>>> Fixes: 2e315dc07df0 ("blk-mq: grab rq->refcount before calling ->fn in
>>> blk_mq_tagset_busy_iter")
>>> Reported-by: "Blank-Burian, Markus, Dr." <blankburian@uni-muenster.de>
>>> Tested-by: "Blank-Burian, Markus, Dr." <blankburian@uni-muenster.de>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>    block/blk-core.c  | 1 -
>>>    block/blk-flush.c | 8 ++++++++
>>>    2 files changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>> index 0874bc2fcdb4..b5098739f72a 100644
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -121,7 +121,6 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
>>>    	rq->internal_tag = BLK_MQ_NO_TAG;
>>>    	rq->start_time_ns = ktime_get_ns();
>>>    	rq->part = NULL;
>>> -	refcount_set(&rq->ref, 1);
>>>    	blk_crypto_rq_set_defaults(rq);
>>>    }
>>>    EXPORT_SYMBOL(blk_rq_init);
>>> diff --git a/block/blk-flush.c b/block/blk-flush.c
>>> index 1002f6c58181..4912c8dbb1d8 100644
>>> --- a/block/blk-flush.c
>>> +++ b/block/blk-flush.c
>>> @@ -329,6 +329,14 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
>>>    	flush_rq->rq_flags |= RQF_FLUSH_SEQ;
>>>    	flush_rq->rq_disk = first_rq->rq_disk;
>>>    	flush_rq->end_io = flush_end_io;
>>> +	/*
>>> +	 * Order WRITE ->end_io and WRITE rq->ref, and its pair is the one
>>> +	 * implied in refcount_inc_not_zero() called from
>>> +	 * blk_mq_find_and_get_req(), which orders WRITE/READ flush_rq->ref
>>> +	 * and READ flush_rq->end_io
>> Recently we run into similar panic which is a NULL dereference on
>> rq->mq_hctx in is_flush_rq(), we also
>>
>> guess there is race bug just what you have fixed.
>>
>> But I have one question here, for a blk-mq device, before issuing the first
>> flush req, flush_rq->end_io
>>
>> is NULL, and for following flush reqs on this blk-mq device,
>> flush_rq->end_io won't be NULL. I searched
>>
>> the codes and don't find any place that sets flush_rq->end_io to be NULL
>> once flush_rq has been completed.
> blk_kick_flush():
> 	blk_rq_init
> 		memset(rq, 0, sizeof(*rq));

Oh, thanks.

I searched codes for quite a while...


Regards,

Xiaoguang Wang

>
>
> Thanks,
> Ming
