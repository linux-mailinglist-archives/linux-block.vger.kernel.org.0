Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817E530A239
	for <lists+linux-block@lfdr.de>; Mon,  1 Feb 2021 07:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhBAGur (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 1 Feb 2021 01:50:47 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11650 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbhBAGnw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Feb 2021 01:43:52 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DTddk6LW6z162QB;
        Mon,  1 Feb 2021 14:41:46 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Mon, 1 Feb 2021 14:43:01 +0800
Subject: Re: [PATCH] nbd: Fix NULL pointer in flush_workqueue
To:     Markus Elfring <Markus.Elfring@web.de>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jens Axboe" <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>
References: <20210128074153.1633374-1-sunke32@huawei.com>
 <1739e522-5980-f86e-cb90-19b61539a5cf@web.de>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <28c83b00-7d0b-ee0d-640b-017c9f8410eb@huawei.com>
Date:   Mon, 1 Feb 2021 14:43:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1739e522-5980-f86e-cb90-19b61539a5cf@web.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.80]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

hi，Markus

在 2021/1/29 3:42, Markus Elfring 写道:
> …
>> +++ b/drivers/block/nbd.c
>> @@ -2011,12 +2011,20 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
>>   		       index);
>>   		return -EINVAL;
>>   	}
>> +	mutex_lock(&nbd->config_lock);
>>   	if (!refcount_inc_not_zero(&nbd->refs)) {
>>   		mutex_unlock(&nbd_index_mutex);
>> +		mutex_unlock(&nbd->config_lock);
> Can an other function call order become relevant for the unlocking of these mutexes?
Do you think the nbd->config_lock  mutex here is useless?
>
>
>>   		printk(KERN_ERR "nbd: device at index %d is going down\n",
>>   		       index);
> May such an error message be moved into the lock scope?
Sure.
>
>
>>   		return -EINVAL;
>>   	}
>> +	if (!nbd->recv_workq) {
>> +		mutex_unlock(&nbd->config_lock);
>> +		mutex_unlock(&nbd_index_mutex);
>> +		return -EINVAL;
>> +	}
> How do you think about to connect the code from this if branch
> with a jump target like “unlock” so that such statements would be shareable
> for the desired exception handling?
OK, I will improve it in V2 patch.
>
>
>> +	mutex_unlock(&nbd->config_lock);
>>   	mutex_unlock(&nbd_index_mutex);
>>   	if (!refcount_inc_not_zero(&nbd->config_refs)) {
>>   		nbd_put(nbd);
>
> Regards,
> Markus
> .
