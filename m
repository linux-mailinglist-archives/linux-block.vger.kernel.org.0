Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF261E06F5
	for <lists+linux-block@lfdr.de>; Mon, 25 May 2020 08:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388704AbgEYGch (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 25 May 2020 02:32:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47110 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388605AbgEYGch (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 May 2020 02:32:37 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 05A24E4C9963CA8EEDC7;
        Mon, 25 May 2020 14:32:33 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.224) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Mon, 25 May 2020
 14:32:28 +0800
Subject: Re: [PATCH 1/1] blk-mq: remove the pointless call of list_entry_rq()
 in hctx_show_busy_rq()
To:     <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
CC:     Bart Van Assche <bvanassche@acm.org>
References: <20200427131250.13725-1-houtao1@huawei.com>
 <244626f4-3469-1127-377c-d54c589d829b@acm.org>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <51b569f8-57a0-58bb-4f41-ab1f10363918@huawei.com>
Date:   Mon, 25 May 2020 14:32:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <244626f4-3469-1127-377c-d54c589d829b@acm.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.224]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping ?

On 2020/4/28 1:27, Bart Van Assche wrote:
> On 2020-04-27 06:12, Hou Tao wrote:
>> And use rq directly.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  block/blk-mq-debugfs.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
>> index b3f2ba483992..7a79db81a63f 100644
>> --- a/block/blk-mq-debugfs.c
>> +++ b/block/blk-mq-debugfs.c
>> @@ -400,8 +400,7 @@ static bool hctx_show_busy_rq(struct request *rq, void *data, bool reserved)
>>  	const struct show_busy_params *params = data;
>>  
>>  	if (rq->mq_hctx == params->hctx)
>> -		__blk_mq_debugfs_rq_show(params->m,
>> -					 list_entry_rq(&rq->queuelist));
>> +		__blk_mq_debugfs_rq_show(params->m, rq);
>>  
>>  	return true;
>>  }
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> 
> 

