Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC36923E9B6
	for <lists+linux-block@lfdr.de>; Fri,  7 Aug 2020 11:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgHGJEo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 7 Aug 2020 05:04:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47964 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726655AbgHGJEo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Aug 2020 05:04:44 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7D33C9F3918C2CFFF1A8;
        Fri,  7 Aug 2020 17:04:42 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 7 Aug 2020
 17:04:39 +0800
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
To:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
CC:     <paulmck@kernel.org>, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        Ming Lin <mlin@kernel.org>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me> <20200728071859.GA21629@lst.de>
 <20200728091633.GB1326626@T590>
 <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
 <20200728135436.GP9247@paulmck-ThinkPad-P72>
 <d1ba2009-130a-d423-1389-c7af72e25a6a@grimberg.me>
 <20200729003124.GT9247@paulmck-ThinkPad-P72>
 <07c90cf1-bb6f-a343-b0bf-4c91b9acb431@grimberg.me>
 <20200729005942.GA2729664@dhcp-10-100-145-180.wdl.wdc.com>
 <2f17c8ed-99f6-c71c-edd1-fd96481f432c@grimberg.me>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <31a9ba72-1322-4b7c-fb73-db0cb52989da@huawei.com>
Date:   Fri, 7 Aug 2020 17:04:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2f17c8ed-99f6-c71c-edd1-fd96481f432c@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/7/29 12:39, Sagi Grimberg wrote:
> 
>>>>> Dynamically allocating each one is possible but not very scalable.
>>>>>
>>>>> The question is if there is some way, we can do this with on-stack
>>>>> or a single on-heap rcu_head or equivalent that can achieve the same
>>>>> effect.
>>>>
>>>> If the hctx structures are guaranteed to stay put, you could count
>>>> them and then do a single allocation of an array of rcu_head structures
>>>> (or some larger structure containing an rcu_head structure, if needed).
>>>> You could then sequence through this array, consuming one rcu_head per
>>>> hctx as you processed it.  Once all the callbacks had been invoked,
>>>> it would be safe to free the array.
>>>>
>>>> Sounds too simple, though.  So what am I missing?
>>>
>>> We don't want higher-order allocations...
>>
>> So:
>>
>>    (1) We don't want to embed the struct in the hctx because we allocate
>>    so many of them that this is non-negligable to add for something we
>>    typically never use.
>>
>>    (2) We don't want to allocate dynamically because it's potentially
>>    huge.
>>
>> As long as we're using srcu for blocking hctx's, I think it's "pick your
>> poison".
>>
>> Alternatively, Ming's percpu_ref patch(*) may be worth a look.
>>
>>   * https://www.spinics.net/lists/linux-block/msg56976.html1
> I'm not opposed to having this. Will require some more testing
> as this affects pretty much every driver out there..
> 
> If we are going with a lightweight percpu_ref, can we just do
> it also for non-blocking hctx and have a single code-path?
> .
I tried to optimize the patch，support for non blocking queue and
blocking queue.
See next email.
