Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681EF22395A
	for <lists+linux-block@lfdr.de>; Fri, 17 Jul 2020 12:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgGQKeC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 17 Jul 2020 06:34:02 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2496 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbgGQKeC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jul 2020 06:34:02 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 192DCD1A857AB92C51D8;
        Fri, 17 Jul 2020 11:34:01 +0100 (IST)
Received: from [127.0.0.1] (10.210.167.164) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 17 Jul
 2020 11:34:00 +0100
Subject: Re: [PATCH 02/21] block: add flag for internal commands
To:     Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        Don Brace <don.brace@microchip.com>,
        <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20200703130122.111448-1-hare@suse.de>
 <20200703130122.111448-3-hare@suse.de>
 <699d432d-eb5e-a928-5391-c31643620b27@huawei.com>
 <1577e01a-445d-3843-389f-6f4b004461c0@kernel.dk>
From:   John Garry <john.garry@huawei.com>
Message-ID: <09c655ad-c82e-5393-62f0-aef19429e9a6@huawei.com>
Date:   Fri, 17 Jul 2020 11:32:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1577e01a-445d-3843-389f-6f4b004461c0@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.167.164]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09/07/2020 21:02, Jens Axboe wrote:
> On 7/8/20 3:27 AM, John Garry wrote:
>> On 03/07/2020 14:01, Hannes Reinecke wrote:
>>
>> +linux-block
>>
>> I figure that linux-block should be cc'ed here
>>
>>> Some drivers require to allocate requests for internal command
>>> submission. These request will never be passed through the block
>>> layer, but nevertheless require a valid tag to avoid them clashing
>>> with normal I/O commands.
>>> This patch adds a new request flag REQ_INTERNAL to mark such
>>> requests and a terminates any such commands in blk_execute_rq_nowait()
>>> with a WARN_ON_ONCE to signal such an invalid usage.

So if these requests will never be passed through the block layer - as 
you say - then why add a check for this? Surely you will find out in 
nasty and obvious ways that it should be done.

Thanks,
John

>>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>    block/blk-exec.c          | 5 +++++
>>>    include/linux/blk_types.h | 2 ++
>>>    include/linux/blkdev.h    | 5 +++++
>>>    3 files changed, 12 insertions(+)
>>>
>>> diff --git a/block/blk-exec.c b/block/blk-exec.c
>>> index 85324d53d072..6869877e0d21 100644
>>> --- a/block/blk-exec.c
>>> +++ b/block/blk-exec.c
>>> @@ -55,6 +55,11 @@ void blk_execute_rq_nowait(struct request_queue *q, struct gendisk *bd_disk,
>>>    	rq->rq_disk = bd_disk;
>>>    	rq->end_io = done;
>>>    
>>> +	if (WARN_ON_ONCE(blk_rq_is_internal(rq))) {
>>> +		blk_mq_end_request(rq, BLK_STS_NOTSUPP);
>>> +		return;
>>> +	}
>>> +
>>>    	blk_account_io_start(rq);
> 
> The whole concept seems very odd, and then there's this seemingly
> randomly placed check and error condition. As I haven't seen the
> actual use case for this, hard to make suggestions though.
> 

