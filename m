Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 332F714C3B9
	for <lists+linux-block@lfdr.de>; Wed, 29 Jan 2020 00:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgA1Xt4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Jan 2020 18:49:56 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36338 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgA1Xt4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jan 2020 18:49:56 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00SNccTa019736;
        Tue, 28 Jan 2020 23:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=4PmPLszAfnqdg6GbKq/IMJkwu4IcVarU/V0OY6XF19Y=;
 b=fwDUAbt2GAyXSYDBK+1siSOz/mzVEj30Rnyf8aUI88pYcq0WfqzIkYJSC3Zgd0T+7kU/
 kjYWDD9AsdVrz1cjffPhRXVWLyz6Qk5gsYreAy1KMaIo+tDvaZPfo5zM+kBcUuCVyv2/
 uy8QqiJA4TdW7pTxbjocxIV7wiF80foT9wp4Eo5UuHyRiXdOYB5Q1nqAj1WOn7t5F0pO
 M7cu6JDQYThp7K7PQmiRryrNi622u1cuuzzQsYVWNm8KU4mIFsyfNUGHv2NELnf7rGMr
 RBwas7qVHhKsqP7Cg0lkis3mmEaeUkl7NjTQlF0JnqaVbuxzmn6JPJ5t0hIcmEWiHlrY xA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2xrd3u9sm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 23:49:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00SNcUTw031238;
        Tue, 28 Jan 2020 23:49:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2xtmr54k6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 23:49:48 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00SNnlSc014734;
        Tue, 28 Jan 2020 23:49:48 GMT
Received: from [10.154.146.35] (/10.154.146.35)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Jan 2020 15:49:47 -0800
Subject: Re: [RFC 2/2] io_uring: acquire ctx->uring_lock before calling
 io_issue_sqe()
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@gmail.com>
References: <1579142266-64789-1-git-send-email-bijan.mottahedeh@oracle.com>
 <1579142266-64789-3-git-send-email-bijan.mottahedeh@oracle.com>
 <9b359dde-3bb6-5886-264b-4bee90be9e25@kernel.dk>
 <8f7986c7-e5b4-8f24-1c71-666c01b16c8b@kernel.dk>
 <1397cd55-37a6-4e14-91ac-eb3c35e7d962@kernel.dk>
 <b43835cd-3bd6-705e-df51-923bbec78c67@oracle.com>
 <18346d15-d89d-9d28-1ef8-77574d44dce7@kernel.dk>
 <229bd8ea-cd65-c77a-ad58-2a79f3bd0c5b@oracle.com>
 <a316d3fe-4162-8274-a74a-2d13a4caf011@kernel.dk>
 <f56a8767-c754-b2e9-bfea-1ced197a05d7@oracle.com>
 <3f3f8b48-2e50-d0bb-b912-6d03961b2d6a@kernel.dk>
From:   Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Message-ID: <5d110b77-fdd3-d907-69b2-26894b5ad43a@oracle.com>
Date:   Tue, 28 Jan 2020 15:49:44 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3f3f8b48-2e50-d0bb-b912-6d03961b2d6a@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Antivirus: Avast (VPS 200127-0, 01/27/2020), Outbound message
X-Antivirus-Status: Clean
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001280175
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001280175
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/2020 3:37 PM, Jens Axboe wrote:
> On 1/28/20 1:34 PM, Bijan Mottahedeh wrote:
>> On 1/16/2020 1:26 PM, Jens Axboe wrote:
>>> On 1/16/20 2:04 PM, Bijan Mottahedeh wrote:
>>>> On 1/16/2020 12:02 PM, Jens Axboe wrote:
>>>>> On 1/16/20 12:08 PM, Bijan Mottahedeh wrote:
>>>>>> On 1/16/2020 8:22 AM, Jens Axboe wrote:
>>>>>>> On 1/15/20 9:42 PM, Jens Axboe wrote:
>>>>>>>> On 1/15/20 9:34 PM, Jens Axboe wrote:
>>>>>>>>> On 1/15/20 7:37 PM, Bijan Mottahedeh wrote:
>>>>>>>>>> io_issue_sqe() calls io_iopoll_req_issued() which manipulates poll_list,
>>>>>>>>>> so acquire ctx->uring_lock beforehand similar to other instances of
>>>>>>>>>> calling io_issue_sqe().
>>>>>>>>> Is the below not enough?
>>>>>>>> This should be better, we have two that set ->in_async, and only one
>>>>>>>> doesn't hold the mutex.
>>>>>>>>
>>>>>>>> If this works for you, can you resend patch 2 with that? Also add a:
>>>>>>>>
>>>>>>>> Fixes: 8a4955ff1cca ("io_uring: sqthread should grab ctx->uring_lock for submissions")
>>>>>>>>
>>>>>>>> to it as well. Thanks!
>>>>>>> I tested and queued this up:
>>>>>>>
>>>>>>> https://git.kernel.dk/cgit/linux-block/commit/?h=io_uring-5.5&id=11ba820bf163e224bf5dd44e545a66a44a5b1d7a
>>>>>>>
>>>>>>> Please let me know if this works, it sits on top of the ->result patch you
>>>>>>> sent in.
>>>>>>>
>>>>>> That works, thanks.
>>>>>>
>>>>>> I'm however still seeing a use-after-free error in the request
>>>>>> completion path in nvme_unmap_data().  It happens only when testing with
>>>>>> large block sizes in fio, typically > 128k, e.g. bs=256k will always hit it.
>>>>>>
>>>>>> This is the error:
>>>>>>
>>>>>> DMA-API: nvme 0000:00:04.0: device driver tries to free DMA memory it
>>>>>> has not allocated [device address=0x6b6b6b6b6b6b6b6b] [size=1802201963
>>>>>> bytes]
>>>>>>
>>>>>> and this warning occasionally:
>>>>>>
>>>>>> WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);
>>>>>>
>>>>>> It seems like a request might be issued multiple times but I can't see
>>>>>> anything in io_uring code that would account for it.
>>>>> Both of them indicate reuse, and I agree I don't think it's io_uring. It
>>>>> really feels like an issue with nvme when a poll queue is shared, but I
>>>>> haven't been able to pin point what it is yet.
>>>>>
>>>>> The 128K is interesting, that would seem to indicate that it's related to
>>>>> splitting of the IO (which would create > 1 IO per submitted IO).
>>>>>
>>>> Where does the split take place?  I had suspected that it might be
>>>> related to the submit_bio() loop in __blkdev_direct_IO() but I don't
>>>> think I saw multiple submit_bio() calls or maybe I missed something.
>>> See the path from blk_mq_make_request() -> __blk_queue_split() ->
>>> blk_bio_segment_split(). The bio is built and submitted, then split if
>>> it violates any size constraints. The splits are submitted through
>>> generic_make_request(), so that might be why you didn't see multiple
>>> submit_bio() calls.
>>>
>> I think the problem is in __blkdev_direct_IO() and not related to
>> request size:
>>
>>                           qc = submit_bio(bio);
>>
>>                           if (polled)
>>                                   WRITE_ONCE(iocb->ki_cookie, qc);
>>
>>
>> The first call to submit_bio() when dio->is_sync is not set won't have
>> acquired a bio ref through bio_get() and so the bio/dio could be freed
>> when ki_cookie is set.
>>
>> With the specific io_uring test, this happens because
>> blk_mq_make_request()->blk_mq_get_request() fails and so terminates the
>> request.
>>
>> As for the fix for polled io (!is_sync) case, I'm wondering if
>> dio->multi_bio is really necessary in __blkdev_direct_IO(). Can we call
>> bio_get() unconditionally after the call to bio_alloc_bioset(), set
>> dio->ref = 1, and increment it for additional submit bio calls?  Would
>> it make sense to do away with multi_bio?
> It's not ideal, but not sure I see a better way to fix it. You see the
> case on failure, which we could check for (don't write cookie if it's
> invalid). But this won't fix the case where the IO complete fast, or
> even immediately.
>
> Hence I think you're right, there's really no way around doing the bio
> ref counting, even for the sync case. Care to cook up a patch we can
> take a look at? I can run some high performance sync testing too, so we
> can see how badly it might hurt.

Sure, I'll take a stab at it.

>
>> Also, I'm not clear on how is_sync + mult_bio case is supposed to work.
>> __blkdev_direct_IO() polls for *a* completion in the request's hctx and
>> not *the* request completion itself, so what does that tell us for
>> multi_bio + is_sync? Is the polling supposed to guarantee that all
>> constituent bios for a mult_bio request have completed before return?
> The polling really just ignores that, it doesn't take multi requests
> into account. We just poll for the first part of it.
>

Even for a single request though, the poll doesn't guarantee that the 
request just issued completes; it just says that some request from the 
same hctx completes, right?

--bijan
