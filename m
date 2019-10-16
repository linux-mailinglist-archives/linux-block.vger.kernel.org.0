Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDFBBD85D9
	for <lists+linux-block@lfdr.de>; Wed, 16 Oct 2019 04:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfJPCT7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 15 Oct 2019 22:19:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4159 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726534AbfJPCT7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 22:19:59 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 41455CDD27AB83624CBE;
        Wed, 16 Oct 2019 10:19:55 +0800 (CST)
Received: from [127.0.0.1] (10.133.210.141) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 10:19:47 +0800
Subject: Re: [PATCH V3] io_uring: consider the overflow of sequence for
 timeout req
To:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <houtao1@huawei.com>
References: <20191015135929.30912-1-yangerkun@huawei.com>
 <df96c0e3-873f-6a54-9e71-0c57d3b6720d@huawei.com>
 <a9ba7785-8e69-7c00-95f9-5c91e6315a8f@kernel.dk>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <3d993f05-4b9b-3193-8626-5680d93dc1e7@huawei.com>
Date:   Wed, 16 Oct 2019 10:19:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a9ba7785-8e69-7c00-95f9-5c91e6315a8f@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.210.141]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019/10/16 9:45, Jens Axboe wrote:
> On 10/15/19 7:35 PM, yangerkun wrote:
>>
>>
>> On 2019/10/15 21:59, yangerkun wrote:
>>> Now we recalculate the sequence of timeout with 'req->sequence =
>>> ctx->cached_sq_head + count - 1', judge the right place to insert
>>> for timeout_list by compare the number of request we still expected for
>>> completion. But we have not consider about the situation of overflow:
>>>
>>> 1. ctx->cached_sq_head + count - 1 may overflow. And a bigger count for
>>> the new timeout req can have a small req->sequence.
>>>
>>> 2. cached_sq_head of now may overflow compare with before req. And it
>>> will lead the timeout req with small req->sequence.
>>>
>>> This overflow will lead to the misorder of timeout_list, which can lead
>>> to the wrong order of the completion of timeout_list. Fix it by reuse
>>> req->submit.sequence to store the count, and change the logic of
>>> inserting sort in io_timeout.
>>>
>>> Signed-off-by: yangerkun <yangerkun@huawei.com>
>>> ---
>>>     fs/io_uring.c | 27 +++++++++++++++++++++------
>>>     1 file changed, 21 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>> index 76fdbe84aff5..c9512da06973 100644
>>> --- a/fs/io_uring.c
>>> +++ b/fs/io_uring.c
>>> @@ -1884,7 +1884,7 @@ static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
>>>     
>>>     static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>>>     {
>>> -	unsigned count, req_dist, tail_index;
>>> +	unsigned count;
>>>     	struct io_ring_ctx *ctx = req->ctx;
>>>     	struct list_head *entry;
>>>     	struct timespec64 ts;
>>> @@ -1907,21 +1907,36 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>>>     		count = 1;
>>>     
>>>     	req->sequence = ctx->cached_sq_head + count - 1;
>>> +	/* reuse it to store the count */
>>> +	req->submit.sequence = count;
>>>     	req->flags |= REQ_F_TIMEOUT;
>>>     
>>>     	/*
>>>     	 * Insertion sort, ensuring the first entry in the list is always
>>>     	 * the one we need first.
>>>     	 */
>>> -	tail_index = ctx->cached_cq_tail - ctx->rings->sq_dropped;
>>> -	req_dist = req->sequence - tail_index;
>>>     	spin_lock_irq(&ctx->completion_lock);
>>>     	list_for_each_prev(entry, &ctx->timeout_list) {
>>>     		struct io_kiocb *nxt = list_entry(entry, struct io_kiocb, list);
>>> -		unsigned dist;
>>> +		unsigned nxt_sq_head;
>>> +		long long tmp, tmp_nxt;
>>>     
>>> -		dist = nxt->sequence - tail_index;
>>> -		if (req_dist >= dist)
>>> +		/*
>>> +		 * Since cached_sq_head + count - 1 can overflow, use type long
>>> +		 * long to store it.
>>> +		 */
>>> +		tmp = (long long)ctx->cached_sq_head + count - 1;
>>> +		nxt_sq_head = nxt->sequence - nxt->submit.sequence + 1;
>>> +		tmp_nxt = (long long)nxt_sq_head + nxt->submit.sequence - 1;
>>> +
>>> +		/*
>>> +		 * cached_sq_head may overflow, and it will never overflow twice
>>> +		 * once there is some timeout req still be valid.
>>> +		 */
>>> +		if (ctx->cached_sq_head < nxt_sq_head)
>>> +			tmp_nxt += UINT_MAX;
>>
>> Maybe there is a mistake, it should be tmp. So sorry about this.
> 
> I ran it through the basic testing, but I guess it doesn't catch overflow
> cases. Maybe we can come up with one? Should be pretty simple to setup a
> io_uring, post UINT_MAX - 10 nops (or something like that), then do some
> timeout testing.
> 
Good idea! I will try to add a testcase for this in liburing.

> Just send an incremental patch to fix it.

OK, will send the fix patch!

> 

