Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439061EF62D
	for <lists+linux-block@lfdr.de>; Fri,  5 Jun 2020 13:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgFELJh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 5 Jun 2020 07:09:37 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2285 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726225AbgFELJg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Jun 2020 07:09:36 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 3314F31A5F9519CE70AA;
        Fri,  5 Jun 2020 12:09:35 +0100 (IST)
Received: from [127.0.0.1] (10.210.169.114) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 5 Jun 2020
 12:09:34 +0100
Subject: Re: [PATCH] blk-mq: don't fail driver tag allocation because of
 inactive hctx
From:   John Garry <john.garry@huawei.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
References: <20200603105128.2147139-1-ming.lei@redhat.com>
 <20200603115347.GA8653@lst.de> <20200603133608.GA2149752@T590>
 <6b58e473-16a4-4ce2-a4ac-50b952d364d7@huawei.com>
 <6fbd3669-4358-6d9f-5c94-e1bc7acecb86@oracle.com>
 <b37b1f30-722b-4767-0627-103b94c7421c@huawei.com>
 <20200604112615.GA2336493@T590>
 <7291fd02-3c2c-f3f9-f3eb-725cd85d5523@huawei.com>
 <20200604120747.GB2336493@T590>
 <38b4c7a3-057f-c52c-993b-523660085e3c@huawei.com>
 <20200605083349.GA2392879@T590>
 <161ad789-11f9-b422-99e3-0abf18e1b167@huawei.com>
Message-ID: <14dcaacd-f3b5-ee79-b11a-d9a65c807098@huawei.com>
Date:   Fri, 5 Jun 2020 12:08:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <161ad789-11f9-b422-99e3-0abf18e1b167@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.210.169.114]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05/06/2020 10:27, John Garry wrote:
> On 05/06/2020 09:33, Ming Lei wrote:
>>> LLDD does not use request->tag - it generates its own.
>>>
>>>   and suggest you to double check
>>>> hisi_sas's queue mapping which has to be exactly same with blk-mq's
>>>> mapping.
>>>>
>>> scheduler=none is ok, so I am skeptical of a problem there.
>> Please try the following patch, and we may not drain in-flight
>> requests correctly:
>>
>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>> index 97bb650f0ed6..ae110e2754bf 100644
>> --- a/block/blk-mq-tag.c
>> +++ b/block/blk-mq-tag.c
>> @@ -265,6 +265,7 @@ struct bt_tags_iter_data {
>>   #define BT_TAG_ITER_RESERVED        (1 << 0)
>>   #define BT_TAG_ITER_STARTED        (1 << 1)
>> +#define BT_TAG_ITER_STATIC_RQS        (1 << 2)
>>   static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, 
>> void *data)
>>   {
>> @@ -280,7 +281,10 @@ static bool bt_tags_iter(struct sbitmap *bitmap, 
>> unsigned int bitnr, void *data)
>>        * We can hit rq == NULL here, because the tagging functions
>>        * test and set the bit before assining ->rqs[].

assigning

>>        */
>> -    rq = tags->rqs[bitnr];
>> +    if (iter_data->flags & BT_TAG_ITER_STATIC_RQS)
>> +        rq = tags->static_rqs[bitnr];
>> +    else
>> +        rq = tags->rqs[bitnr];
>>       if (!rq)
>>           return true;
>>       if ((iter_data->flags & BT_TAG_ITER_STARTED) &&
>> @@ -335,11 +339,13 @@ static void __blk_mq_all_tag_iter(struct 
>> blk_mq_tags *tags,
>>    *        indicates whether or not @rq is a reserved request. Return
>>    *        true to continue iterating tags, false to stop.
>>    * @priv:    Will be passed as second argument to @fn.
>> + *
>> + * Caller has to pass the tag map from which requests are allocated.
>>    */
>>   void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn 
>> *fn,
>>           void *priv)
>>   {
>> -    return __blk_mq_all_tag_iter(tags, fn, priv, 0);
>> +    return __blk_mq_all_tag_iter(tags, fn, priv, 
>> BT_TAG_ITER_STATIC_RQS);
>>   }
>>   /**
>>
> 
> ok, so early test shows that this is ok. I didn't try scheduler=none 
> though.
> 

So that looks ok for scheduler=none also.

So can we please get both patches sent formally? (I was using 
Christoph's patch, which introduces__blk_mq_get_driver_tag()).

Cheers,
John

Ps. if sending a series, can you also fix up the spelling mistake? I 
don't think it's worth sending a single patch for that, which may conflict.

