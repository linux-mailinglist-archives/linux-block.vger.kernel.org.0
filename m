Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5314071032F
	for <lists+linux-block@lfdr.de>; Thu, 25 May 2023 05:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238106AbjEYDFa (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 24 May 2023 23:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238057AbjEYDF3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 23:05:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8B6A9
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 20:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684983882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fN/1qtGDxEfn5zipNA0rEVPA37edQ00W3inRZ1lW6cA=;
        b=VkEXHRAHtaVVUdIYiNBiMg98T/gc4VnJTXFOjnbbMMN2DAEWBNzO0doPYwkjjqyi+MV/gD
        E5EWNaCJ8MhvpZsDG/2trPdK6ETV1+Ozjc6niqg0IvpzSVCXoBADqzVc5Wip5MUeVj9caG
        LYjLfuyZkUZgj0k1i12t5wOF445MZ2c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-56i0sNSrOUGffZKt-cY3bg-1; Wed, 24 May 2023 23:04:40 -0400
X-MC-Unique: 56i0sNSrOUGffZKt-cY3bg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22EC98015D8;
        Thu, 25 May 2023 03:04:40 +0000 (UTC)
Received: from [10.22.17.224] (unknown [10.22.17.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA4D81121314;
        Thu, 25 May 2023 03:04:39 +0000 (UTC)
Message-ID: <9b06dceb-f26d-7faf-460c-ba554a0757ef@redhat.com>
Date:   Wed, 24 May 2023 23:04:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V2] blk-cgroup: Flush stats before releasing blkcg_gq
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        mkoutny@suse.com
References: <20230524035150.727407-1-ming.lei@redhat.com>
 <f2c10b18-8d83-91a5-bf22-03894bf3c910@redhat.com>
 <ZG2R+jYuAZMpx49d@ovpn-8-17.pek2.redhat.com>
 <76a863b4-112e-82ae-59e4-6326fff48ffc@redhat.com>
 <bde4174a-ace4-6e2a-6536-855fb18d0890@redhat.com>
 <ZG7CJtN7ATaYZ5Ao@ovpn-8-21.pek2.redhat.com>
 <7ffbb748-46e3-44b2-388d-9199f47dc9a7@redhat.com>
 <CAJD7tkYfwVSNrTibnv5BpyAfbyY0dnK0Cp-HQK_-2nxHmveAxw@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAJD7tkYfwVSNrTibnv5BpyAfbyY0dnK0Cp-HQK_-2nxHmveAxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/24/23 22:55, Yosry Ahmed wrote:
> On Wed, May 24, 2023 at 7:50 PM Waiman Long <longman@redhat.com> wrote:
>> On 5/24/23 22:04, Ming Lei wrote:
>>> On Wed, May 24, 2023 at 01:28:41PM -0400, Waiman Long wrote:
>>>> On 5/24/23 11:43, Waiman Long wrote:
>>>>> On 5/24/23 00:26, Ming Lei wrote:
>>>>>> On Wed, May 24, 2023 at 12:19:57AM -0400, Waiman Long wrote:
>>>>>>> On 5/23/23 23:51, Ming Lei wrote:
>>>>>>>> As noted by Michal, the blkg_iostat_set's in the lockless list hold
>>>>>>>> reference to blkg's to protect against their removal. Those blkg's
>>>>>>>> hold reference to blkcg. When a cgroup is being destroyed,
>>>>>>>> cgroup_rstat_flush() is only called at css_release_work_fn() which
>>>>>>>> is called when the blkcg reference count reaches 0. This circular
>>>>>>>> dependency will prevent blkcg and some blkgs from being freed after
>>>>>>>> they are made offline.
>>>>>>>>
>>>>>>>> It is less a problem if the cgroup to be destroyed also has other
>>>>>>>> controllers like memory that will call cgroup_rstat_flush() which will
>>>>>>>> clean up the reference count. If block is the only
>>>>>>>> controller that uses
>>>>>>>> rstat, these offline blkcg and blkgs may never be freed leaking more
>>>>>>>> and more memory over time.
>>>>>>>>
>>>>>>>> To prevent this potential memory leak:
>>>>>>>>
>>>>>>>> - flush blkcg per-cpu stats list in __blkg_release(), when no new stat
>>>>>>>> can be added
>>>>>>>>
>>>>>>>> - don't grab bio->bi_blkg reference when adding the stats into blkcg's
>>>>>>>> per-cpu stat list since all stats are guaranteed to be consumed before
>>>>>>>> releasing blkg instance, and grabbing blkg reference for stats was the
>>>>>>>> most fragile part of original patch
>>>>>>>>
>>>>>>>> Based on Waiman's patch:
>>>>>>>>
>>>>>>>> https://lore.kernel.org/linux-block/20221215033132.230023-3-longman@redhat.com/
>>>>>>>>
>>>>>>>>
>>>>>>>> Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
>>>>>>>> Cc: Waiman Long <longman@redhat.com>
>>>>>>>> Cc: Tejun Heo <tj@kernel.org>
>>>>>>>> Cc: mkoutny@suse.com
>>>>>>>> Cc: Yosry Ahmed <yosryahmed@google.com>
>>>>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>>>>>> ---
>>>>>>>> V2:
>>>>>>>>       - remove kernel/cgroup change, and call blkcg_rstat_flush()
>>>>>>>>       to flush stat directly
>>>>>>>>
>>>>>>>>      block/blk-cgroup.c | 29 +++++++++++++++++++++--------
>>>>>>>>      1 file changed, 21 insertions(+), 8 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>>>>>>>> index 0ce64dd73cfe..ed0eb8896972 100644
>>>>>>>> --- a/block/blk-cgroup.c
>>>>>>>> +++ b/block/blk-cgroup.c
>>>>>>>> @@ -34,6 +34,8 @@
>>>>>>>>      #include "blk-ioprio.h"
>>>>>>>>      #include "blk-throttle.h"
>>>>>>>> +static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu);
>>>>>>>> +
>>>>>>>>      /*
>>>>>>>>       * blkcg_pol_mutex protects blkcg_policy[] and policy
>>>>>>>> [de]activation.
>>>>>>>>       * blkcg_pol_register_mutex nests outside of it and
>>>>>>>> synchronizes entire
>>>>>>>> @@ -163,10 +165,21 @@ static void blkg_free(struct blkcg_gq *blkg)
>>>>>>>>      static void __blkg_release(struct rcu_head *rcu)
>>>>>>>>      {
>>>>>>>>          struct blkcg_gq *blkg = container_of(rcu, struct
>>>>>>>> blkcg_gq, rcu_head);
>>>>>>>> +    struct blkcg *blkcg = blkg->blkcg;
>>>>>>>> +    int cpu;
>>>>>>>>      #ifdef CONFIG_BLK_CGROUP_PUNT_BIO
>>>>>>>>          WARN_ON(!bio_list_empty(&blkg->async_bios));
>>>>>>>>      #endif
>>>>>>>> +    /*
>>>>>>>> +     * Flush all the non-empty percpu lockless lists before releasing
>>>>>>>> +     * us, given these stat belongs to us.
>>>>>>>> +     *
>>>>>>>> +     * cgroup locks aren't needed here since __blkcg_rstat_flush just
>>>>>>>> +     * propagates delta into blkg parent, which is live now.
>>>>>>>> +     */
>>>>>>>> +    for_each_possible_cpu(cpu)
>>>>>>>> +        __blkcg_rstat_flush(blkcg, cpu);
>>>>>>>>          /* release the blkcg and parent blkg refs this blkg
>>>>>>>> has been holding */
>>>>>>>>          css_put(&blkg->blkcg->css);
>>>>>>>> @@ -951,17 +964,12 @@ static void blkcg_iostat_update(struct
>>>>>>>> blkcg_gq *blkg, struct blkg_iostat *cur,
>>>>>>>> u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
>>>>>>>>      }
>>>>>>>> -static void blkcg_rstat_flush(struct cgroup_subsys_state
>>>>>>>> *css, int cpu)
>>>>>>>> +static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
>>>>>>>>      {
>>>>>>>> -    struct blkcg *blkcg = css_to_blkcg(css);
>>>>>>>>          struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
>>>>>>>>          struct llist_node *lnode;
>>>>>>>>          struct blkg_iostat_set *bisc, *next_bisc;
>>>>>>>> -    /* Root-level stats are sourced from system-wide IO stats */
>>>>>>>> -    if (!cgroup_parent(css->cgroup))
>>>>>>>> -        return;
>>>>>>>> -
>>>>>>>>          rcu_read_lock();
>>>>>>>>          lnode = llist_del_all(lhead);
>>>>>>>> @@ -991,13 +999,19 @@ static void blkcg_rstat_flush(struct
>>>>>>>> cgroup_subsys_state *css, int cpu)
>>>>>>>>              if (parent && parent->parent)
>>>>>>>>                  blkcg_iostat_update(parent, &blkg->iostat.cur,
>>>>>>>>                              &blkg->iostat.last);
>>>>>>>> -        percpu_ref_put(&blkg->refcnt);
>>>>>>>>          }
>>>>>>>>      out:
>>>>>>>>          rcu_read_unlock();
>>>>>>>>      }
>>>>>>>> +static void blkcg_rstat_flush(struct cgroup_subsys_state
>>>>>>>> *css, int cpu)
>>>>>>>> +{
>>>>>>>> +    /* Root-level stats are sourced from system-wide IO stats */
>>>>>>>> +    if (cgroup_parent(css->cgroup))
>>>>>>>> +        __blkcg_rstat_flush(css_to_blkcg(css), cpu);
>>>>>>>> +}
>>>>>>>> +
>>>>>>> I think it may not safe to call __blkcg_rstat_flus() directly
>>>>>>> without taking
>>>>>>> the cgroup_rstat_cpu_lock. That is why I added a helper to
>>>>>>> kernel/cgroup/rstat.c in my patch to meet the locking requirement.
>>>>>> All stats are removed from llist_del_all(), and the local list is
>>>>>> iterated, then each blkg & its parent is touched in
>>>>>> __blkcg_rstat_flus(), so
>>>>>> can you explain it a bit why cgroup locks are needed? For protecting
>>>>>> what?
>>>>> You are right. The llist_del_all() call in blkcg_rstat_flush() is
>>>>> atomic, so it is safe for concurrent execution which is what the
>>>>> cgroup_rstat_cpu_lock protects against. That may not be the case for
>>>>> rstat callbacks of other controllers. So I will suggest you to add a
>>>>> comment to clarify that point. Other than that, you patch looks good to
>>>>> me.
>>>>>
>>>>> Reviewed: Waiman Long <longman@redhat.com>
>>>> After some more thought, I need to retract my reviewed-by tag for now. There
>>>> is a slight possibility that blkcg_iostat_update() in blkcg_rstat_flush()
>>>> can happen concurrently which will corrupt the sequence count.
>>> llist_del_all() moves all 'bis' into one local list, and bis is one percpu
>>> variable of blkg, so in theory same bis won't be flushed at the same
>>> time. And one bis should be touched in just one of stat flush code path
>>> because of llist_del_all().
>>>
>>> So 'bis' still can be thought as being flushed in serialized way.
>>>
>>> However, blk_cgroup_bio_start() runs concurrently with blkcg_rstat_flush(),
>>> so once bis->lqueued is cleared in blkcg_rstat_flush(), this same bis
>>> could be added to the percpu llist and __blkcg_rstat_flush() from blkg_release()
>>> follows. This should be the only chance for concurrent stats update.
>> That is why I have in mind. A __blkcg_rstat_flush() can be from
>> blkg_release() and another one from the regular cgroup_rstat_flush*().
>>
>>
>>> But, blkg_release() is run in RCU callback, so the previous flush has
>>> been done, but new flush can come, and other blkg's stat could be added
>>> with same story above.
>>>
>>>> One way to
>>>> avoid that is to synchronize it by cgroup_rstat_cpu_lock. Another way is to
>>>> use the bisc->lqueued for synchronization.
>>> I'd avoid the external cgroup lock here.
>>>
>>>> In that case, you need to move
>>>> WRITE_ONCE(bisc->lqueued, false) in blkcg_rstat_flush() to the end after all
>>>> the  blkcg_iostat_update() call with smp_store_release() and replace the
>>>> READ_ONCE(bis->lqueued) check in blk_cgroup_bio_start() with
>>>> smp_load_acquire().
>>> This way looks doable, but I guess it still can't avoid concurrent update on parent
>>> stat, such as when  __blkcg_rstat_flush() from blkg_release() is
>>> in-progress, another sibling blkg's bis is added, meantime
>>> blkcg_rstat_flush() is called.
>> I realized that the use of cgroup_rstat_cpu_lock or the alternative was
>> not safe enough for preventing concurrent parent blkg rstat update.
>>> Another way is to add blkcg->stat_lock for covering __blkcg_rstat_flush(), what
>>> do you think of this way?
>> I am thinking of adding a raw spinlock into blkg and take it when doing
>> blkcg_iostat_update(). This can guarantee no concurrent update to rstat
>> data. It has to be a raw spinlock as it will be under the
>> cgroup_rstat_cpu_lock raw spinlock.
> Hi Waiman,
>
> I don't have context about blkcg, but isn't this exactly what
> cgroup_rstat_lock does? Is it too expensive to just call
> cgroup_rstat_flush () here?

I have thought about that too. However, in my test, just calling 
cgroup_rstat_flush() in blkcg_destroy_blkgs() did not prevent dying 
blkcgs from increasing meaning that there are still some extra 
references blocking its removal. I haven't figured out exactly why that 
is the case. There may still be some races that we have not fully 
understood yet. On the other hand, Ming's patch is verified to not do 
that since it does not take extra blkg references. So I am leaning on 
his patch now. I just have to make sure that there is no concurrent 
rstat update.

Cheers,
Longman

