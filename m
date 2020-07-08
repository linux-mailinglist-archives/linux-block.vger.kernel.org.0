Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34AF2219338
	for <lists+linux-block@lfdr.de>; Thu,  9 Jul 2020 00:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgGHWRB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 8 Jul 2020 18:17:01 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2449 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725964AbgGHWRB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 8 Jul 2020 18:17:01 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id E357CC1D4EA5BC24D78F;
        Wed,  8 Jul 2020 23:16:59 +0100 (IST)
Received: from [127.0.0.1] (10.210.171.111) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 8 Jul 2020
 23:16:59 +0100
Subject: Re: [PATCH] blk-mq: centralise related handling into
 blk_mq_get_driver_tag
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
References: <20200706144111.3260859-1-ming.lei@redhat.com>
 <841c8170-f082-814a-70cc-b0e3e8b5be54@huawei.com>
 <20200707071652.GA3269442@T590>
 <ad3e6c97-dae9-7e21-30ba-33c06e1fe7b7@huawei.com>
 <20200708220655.GB3348426@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <26446b03-294b-674f-b49a-d4c41243a492@huawei.com>
Date:   Wed, 8 Jul 2020 23:15:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200708220655.GB3348426@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.171.111]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 08/07/2020 23:06, Ming Lei wrote:
> On Wed, Jul 08, 2020 at 03:07:05PM +0100, John Garry wrote:
>> On 07/07/2020 08:16, Ming Lei wrote:
>>> On Tue, Jul 07, 2020 at 07:37:41AM +0100, John Garry wrote:
>>>> On 06/07/2020 15:41, Ming Lei wrote:
>>>>> -	hctx = flush_rq->mq_hctx;
>>>>>     	if (!q->elevator) {
>>>>
>>>> Is there a specific reason we do:
>>>>
>>>> if (!a)
>>>> 	do x
>>>> else
>>>> 	do y
>>>>
>>>> as opposed to:
>>>>
>>>> if (a)
>>>> 	do y
>>>> else
>>>> 	do x
>>>>
>>>> Do people find this easier to read or more obvious? Just wondering.
>>>
>>> If you like the style, please go ahead to switch to this way.
>>>
>>
>> Maybe I will, but I'll try to hunt down more cases first.
> 
> You are reviewing existed context code instead of this patch!!!
> 
> One more time, please focus on change added by this patch.

ok, sorry, I'll stop hijacking your patch threads

