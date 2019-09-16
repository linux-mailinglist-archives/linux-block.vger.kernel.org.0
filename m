Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D731B331A
	for <lists+linux-block@lfdr.de>; Mon, 16 Sep 2019 03:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfIPBxy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 15 Sep 2019 21:53:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbfIPBxy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Sep 2019 21:53:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C90F318CB8F5;
        Mon, 16 Sep 2019 01:53:53 +0000 (UTC)
Received: from [10.72.12.58] (ovpn-12-58.pek2.redhat.com [10.72.12.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A573600CD;
        Mon, 16 Sep 2019 01:53:48 +0000 (UTC)
Subject: Re: [RFC PATCH] blk-mq: Avoid memory reclaim when allocating request
 map
To:     Ming Lei <ming.lei@redhat.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, mchristi@redhat.com,
        linux-block@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
References: <20190915122656.11376-1-xiubli@redhat.com>
 <20190916014915.GB5162@ming.t460p>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <4a0a4ffb-3e5e-4fea-6436-1720c52243aa@redhat.com>
Date:   Mon, 16 Sep 2019 09:53:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190916014915.GB5162@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Mon, 16 Sep 2019 01:53:53 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/9/16 9:49, Ming Lei wrote:
> On Sun, Sep 15, 2019 at 05:56:56PM +0530, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> For some storage drivers, such as the nbd, when there has new socket
>> connections added, it will update the hardware queue number by calling
>> blk_mq_update_nr_hw_queues(), in which it will freeze all the queues
>> first. And then tries to do the hardware queue updating stuff.
>>
>> But int blk_mq_alloc_rq_map()-->blk_mq_init_tags(), when allocating
>> memory for tags, it may cause the mm do the memories direct reclaiming,
>> since the queues has been freezed, so if needs to flush the page cache
>> to disk, it will stuck in generic_make_request()-->blk_queue_enter() by
>> waiting the queues to be unfreezed and then cause deadlock here.
>>
>> Since the memory size requested here is a small one, which will make
>> it not that easy to happen with a large size, but in theory this could
>> happen when the OS is running in pressure and out of memory.
>>
>> Gabriel Krisman Bertazi has hit the similar issue by fixing it in
>> commit 36e1f3d10786 ("blk-mq: Avoid memory reclaim when remapping
>> queues"), but might forget this part.
>>
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> CC: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
>> ---
>>   block/blk-mq-tag.c | 5 +++--
>>   block/blk-mq-tag.h | 5 ++++-
>>   block/blk-mq.c     | 3 ++-
>>   3 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>> index 008388e82b5c..04ee0e4c3fa1 100644
>> --- a/block/blk-mq-tag.c
>> +++ b/block/blk-mq-tag.c
>> @@ -462,7 +462,8 @@ static struct blk_mq_tags *blk_mq_init_bitmap_tags(struct blk_mq_tags *tags,
>>   
>>   struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
>>   				     unsigned int reserved_tags,
>> -				     int node, int alloc_policy)
>> +				     int node, int alloc_policy,
>> +				     gfp_t flags)
>>   {
>>   	struct blk_mq_tags *tags;
>>   
>> @@ -471,7 +472,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
>>   		return NULL;
>>   	}
>>   
>> -	tags = kzalloc_node(sizeof(*tags), GFP_KERNEL, node);
>> +	tags = kzalloc_node(sizeof(*tags), flags, node);
>>   	if (!tags)
>>   		return NULL;
>>   
>> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
>> index 61deab0b5a5a..296e0bc97126 100644
>> --- a/block/blk-mq-tag.h
>> +++ b/block/blk-mq-tag.h
>> @@ -22,7 +22,10 @@ struct blk_mq_tags {
>>   };
>>   
>>   
>> -extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags, unsigned int reserved_tags, int node, int alloc_policy);
>> +extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags,
>> +					    unsigned int reserved_tags,
>> +					    int node, int alloc_policy,
>> +					    gfp_t flags);
>>   extern void blk_mq_free_tags(struct blk_mq_tags *tags);
>>   
>>   extern unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data);
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 240416057f28..9c52e4dfe132 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2090,7 +2090,8 @@ struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
>>   		node = set->numa_node;
>>   
>>   	tags = blk_mq_init_tags(nr_tags, reserved_tags, node,
>> -				BLK_MQ_FLAG_TO_ALLOC_POLICY(set->flags));
>> +				BLK_MQ_FLAG_TO_ALLOC_POLICY(set->flags),
>> +				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY);
> Now, there are three uses on 'GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY',
> and code gets cleaner if you make it as one const variable in
> blk_mq_alloc_rq_map.

@Ming Lei

Yeah, this makes sense and will post a V2 to fix it.

Thanks very much.
BRs
Xiubo
> Otherwise, looks fine:
>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
>
>
> thanks,
> Ming


