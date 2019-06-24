Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2EC50B9A
	for <lists+linux-block@lfdr.de>; Mon, 24 Jun 2019 15:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbfFXNOg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 24 Jun 2019 09:14:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36866 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730794AbfFXNOf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 09:14:35 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C9A3C23D76724DA3C42B;
        Mon, 24 Jun 2019 21:14:32 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Mon, 24 Jun 2019
 21:14:28 +0800
Subject: Re: [PATCH 1/9] blk-mq: allow hw queues to share hostwide tags
To:     Ming Lei <ming.lei@redhat.com>
References: <20190531022801.10003-1-ming.lei@redhat.com>
 <20190531022801.10003-2-ming.lei@redhat.com>
 <0f1773af-170a-a6b5-54ce-274dacb2b63a@huawei.com>
 <20190624084614.GC10941@ming.t460p>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        "Sathya Prakash" <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <19e409fa-d734-b0b6-b62f-787a1000e2b1@huawei.com>
Date:   Mon, 24 Jun 2019 14:14:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190624084614.GC10941@ming.t460p>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 24/06/2019 09:46, Ming Lei wrote:
> On Wed, Jun 05, 2019 at 03:10:51PM +0100, John Garry wrote:
>> On 31/05/2019 03:27, Ming Lei wrote:
>>> index 32b8ad3d341b..49d73d979cb3 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -2433,6 +2433,11 @@ static bool __blk_mq_alloc_rq_map(struct blk_mq_tag_set *set, int hctx_idx)
>>>  {
>>>  	int ret = 0;
>>>
>>
>> Hi Ming,
>>
>>> +	if ((set->flags & BLK_MQ_F_HOST_TAGS) && hctx_idx) {
>>> +		set->tags[hctx_idx] = set->tags[0];
>>
>> Here we set all tags same as that of hctx index 0.
>>
>>> +		return true;
>>
>>
>> As such, I think that the error handling in __blk_mq_alloc_rq_maps() is made
>> a little fragile:
>>
>> __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
>> {
>> 	int i;
>>
>> 	for (i = 0; i < set->nr_hw_queues; i++)
>> 		if (!__blk_mq_alloc_rq_map(set, i))
>> 			goto out_unwind;
>>
>> 	return 0;
>>
>> out_unwind:
>> 	while (--i >= 0)
>> 		blk_mq_free_rq_map(set->tags[i]);
>>
>> 	return -ENOMEM;
>> }
>>
>> If __blk_mq_alloc_rq_map(, i > 1) fails for when BLK_MQ_F_HOST_TAGS FLAG is
>> set (even though today it can't), then we would try to free set->tags[0]
>> multiple times.
>

Hi Ming,

> Good catch, and the issue can be addressed easily by setting set->hctx[i] as
> NULL, then check 'tags' in blk_mq_free_rq_map().

OK, so you could do that. But I just think that it's not a great 
practice in general to have multiple pointers pointing at the same 
dynamic memory.

Thanks,
John

>
> Thanks,
> Ming
>
> .
>


