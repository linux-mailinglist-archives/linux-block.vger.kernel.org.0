Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3C4473A27
	for <lists+linux-block@lfdr.de>; Tue, 14 Dec 2021 02:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243183AbhLNBZC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 13 Dec 2021 20:25:02 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:29189 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243119AbhLNBZB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Dec 2021 20:25:01 -0500
Received: from kwepemi100005.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JCgbr0FRdz8vls;
        Tue, 14 Dec 2021 09:22:48 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100005.china.huawei.com (7.221.188.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 09:24:59 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 09:24:58 +0800
Subject: Re: Use after free with BFQ and cgroups
To:     Jan Kara <jack@suse.cz>
CC:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        <linux-block@vger.kernel.org>, <fvogt@suse.de>,
        <cgroups@vger.kernel.org>
References: <20211125172809.GC19572@quack2.suse.cz>
 <20211126144724.GA31093@blackbody.suse.cz>
 <20211129171115.GC29512@quack2.suse.cz>
 <f03b2b1c-808a-c657-327d-03165b988e7d@huawei.com>
 <20211213173354.GE14044@quack2.suse.cz>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <896161a3-922c-63b3-6e6f-9f6005a46bd4@huawei.com>
Date:   Tue, 14 Dec 2021 09:24:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20211213173354.GE14044@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

在 2021/12/14 1:33, Jan Kara 写道:
> Hello!
> 
> On Thu 09-12-21 10:23:33, yukuai (C) wrote:
>> 在 2021/11/30 1:11, Jan Kara 写道:
>>> On Fri 26-11-21 15:47:24, Michal Koutný wrote:
>>>> Hello.
>>>>
>>>> On Thu, Nov 25, 2021 at 06:28:09PM +0100, Jan Kara <jack@suse.cz> wrote:
>>>> [...]
>>>> +Cc cgroups ML
>>>> https://lore.kernel.org/linux-block/20211125172809.GC19572@quack2.suse.cz/
>>>>
>>>>
>>>> I understand there are more objects than blkcgs but I assume it can
>>>> eventually boil down to blkcg references, so I suggest another
>>>> alternative. (But I may easily miss the relations between BFQ objects,
>>>> so consider this only high-level opinion.)
>>>>
>>>>> After some poking, looking into crashdumps, and applying some debug patches
>>>>> the following seems to be happening: We have a process P in blkcg G. Now
>>>>> G is taken offline so bfq_group is cleaned up in bfq_pd_offline() but P
>>>>> still holds reference to G from its bfq_queue. Then P submits IO, G gets
>>>>> inserted into service tree despite being already offline.
>>>>
>>>> (If G is offline, P can only be zombie, just saying. (I guess it can
>>>> still be Q's IO on behalf of G.))
>>>>
>>>> IIUC, the reference to G is only held by P. If the G reference is copied
>>>> into another structure (the service tree) it should get another
>>>> reference. My naïve proposal would be css_get(). (1)
>>>
>>> So I was looking into this puzzle. The answer is following:
>>>
>>> The process P (podman, pid 2571) is currently attached to the root cgroup
>>> but it has io_context with BFQ queue that points to the already-offline G
>>> as a parent. The bio is thus associated with the root cgroup (via
>>> bio->bi_blkg) but BFQ uses io_context to lookup the BFQ queue where IO
>>> should be queued and then uses its parent to determine blkg which it should
>>> be charged and thus gets to the dying cgroup.
>>
>> After some code review, we found that the root cause of the problem
>> semms to be different.
>>
>> If the process is moved from group G to root group, and a new io is
>> issued from the process, then bfq should detect this and changing
>> bfq_queue's parent to root bfq_group:
>>
>> bfq_insert_request
>>   bfq_init_rq
>>    bfq_bic_update_cgroup
>>     serial_nr = __bio_blkcg(bio)->css.serial_nr; -> from root group
>>     bic->blkcg_serial_nr == serial_nr -> this do not pass，because
>> bic->blkcg_serial_nr is still from group G
> 
> So in the crashdump I have available, I can see that
> _bio_blkcg(bio)->css.serial_nr is 4. Also bic->blkcg_serial_nr is 4. But
> bic->bfqq[1] is a bfq_queue that has its entity->parent set to already
> offlined bfq_group. Not sure how that is possible...
> 
>>     __bfq_bic_change_cgroup -> bfq_queue parent will be changed to root group
>>
>> And we think the following path is possible to trigger the problem:
>>
>> 1) process P1 and P2 is currently in cgroup C1, corresponding to
>> bfq_queue q1, q2 and bfq_group g1. And q1 and q2 are merged:
>> q1->next_bfqq = q2.
> 
> I agree shared queues are some factor in this - the problematic bfq_queue
> pointing to the dead bfq_group has 'coop' flag set, pid == -1, bic ==
> NULL. So clearly it has been merged with another bfq_queue.
> 
>> 2) move P1 from C1 to root_cgroup, q1->next_bfqq is still q2
>> and flag BFQQF_split_coop is not set yet.
> 
> There's no next_bfqq in the kernel I'm looking into... Generally the merge
> code seems to be working somewhat differently to what you describe (I'm
> looking into 5.16-rc3 kernel).

Hi, Jan

Sorry, It should be new_bfqq, which will be set if the queue is merged
to other queue.
> 
>> 3) P2 exit, q2 won't exit because it's still referenced through
>> queue merge.
>>
>> 4) delete C1, g1 is offlined
>>
>> 5) issue a new io in q1, q1's parent entity will change to root,
>> however the io will end up in q1->next_bfqq = q2, and thus the
>> offlined g1 is inserted to service tree through q2.
>>
>> 6) P1 exit, q2 exit, and finially g1 is freed, while g1 is still
>> in service tree of it's parent.
>>
>> We confirmed this by our reproducer through a simple patch:
>> stop merging bfq_queues if their parents are different.
>>
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 1ce1a99a7160..14c1d1c3811e 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -2626,6 +2626,11 @@ bfq_setup_merge(struct bfq_queue *bfqq, struct
>> bfq_queue *new_bfqq)
>>          while ((__bfqq = new_bfqq->new_bfqq)) {
>>                  if (__bfqq == bfqq)
>>                          return NULL;
>> +               if (__bfqq->entity.parent != bfqq->entity.parent) {
>> +                       if (bfq_bfqq_coop(__bfqq))
>> +                               bfq_mark_bfqq_split_coop(__bfqq);
>> +                       return NULL;
>> +               }
>>                  new_bfqq = __bfqq;
>>          }
>>
>> @@ -2825,8 +2830,16 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct
>> bfq_queue *bfqq,
>>          if (bfq_too_late_for_merging(bfqq))
>>                  return NULL;
>>
>> -       if (bfqq->new_bfqq)
>> -               return bfqq->new_bfqq;
>> +       if (bfqq->new_bfqq) {
>> +               struct bfq_queue *new_bfqq = bfqq->new_bfqq;
>> +
>> +               if(bfqq->entity.parent == new_bfqq->entity.parent)
>> +                       return new_bfqq;
>> +
>> +               if(bfq_bfqq_coop(new_bfqq))
>> +                       bfq_mark_bfqq_split_coop(new_bfqq);
>> +               return NULL;
>> +       }
>>
>> Do you think this analysis is correct?
> 
> Honestly, I'm not sure. At this point I'm not sure why the bfqq pointed to
> from bic didn't get reparented to the new cgroup when bio was submitted...

After queue merging, bic is set to the new bfqq, for example:

__bfq_insert_request
  new_bfqq = bfq_setup_cooperator
  bfq_merge_bfqqs -> before this is done, bic is set to old bfqq
   bic_set_bfqq(bic, new_bfqq, 1); -> bic is set to new bfqq
  rq->elv.priv[1] = new_bfqq;

I think current problem is that if bfq_queue is merged, task migration
won't break such cooperation，thus issue io from one cgroup may endup to
a bfq_queue that is from another cgroup, which might be offlined.

Thanks,
Kuai
> 
> 								Honza
> 
