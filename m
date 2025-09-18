Return-Path: <linux-block+bounces-25237-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D96C4B1C2E6
	for <lists+linux-block@lfdr.de>; Wed,  6 Aug 2025 11:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AC43161392
	for <lists+linux-block@lfdr.de>; Wed,  6 Aug 2025 09:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37AE28AAE6;
	Wed,  6 Aug 2025 09:06:18 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFFF28A70C
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754471178; cv=none; b=f40wELNQBzRjNByuCbhIPf8tG+x7i2dpDtqFe6oF0jRJvh25BJaruRYSfE2O89GpsaGj0UbBD6mexOHGTsEWeXLOAyArv02pvaJO7C2aK9d+04Oa20FwgfDbaYQeiYtoOKG2jErfiLXgzm4F8Pw5u+RUaAAqPUFs43LU4doh6ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754471178; c=relaxed/simple;
	bh=eAn8hl1Q+zNzkST7g/ue5uxAVSIHWo8WyRs/m2Db9vc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WGmuw69fljymtpGeIO5jqvpIxHuFen5j6Js4sIiU3e/spTVFOgpUm8a95CxaqPqN+FXEa5peEljHo1x9n44R8xTbUOAjWgb5d152zhNgsozBdCG2dZL7w9rZYE29Iqh8wzRImzMBqiWJisvoB/5JhOU1PHF9xt08xiRWJ9u7YAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bxktG6mdczYQtv1
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 17:06:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 940451A0BD0
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 17:06:13 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgA3sxMDG5NoAzEGCw--.58891S3;
	Wed, 06 Aug 2025 17:06:13 +0800 (CST)
Subject: Re: [PATCH 5/5] blk-mq: Replace tags->lock with SRCU for tag
 iterators
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 John Garry <john.garry@huawei.com>,
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250801114440.722286-1-ming.lei@redhat.com>
 <20250801114440.722286-6-ming.lei@redhat.com>
 <b86b9098-fb76-bdfe-bdf0-1344386d067a@huaweicloud.com>
 <aJCaWLgfB_oMMdrC@fedora>
 <88ad7326-b55f-7e33-fa81-0317843fc15b@huaweicloud.com>
 <700bd14f-74da-9c10-9917-d5d56ecd2921@huaweicloud.com>
 <aJHFVdqDs5KKKuM8@fedora>
 <383cb150-9a46-8377-79df-66e8eafc7eb5@huaweicloud.com>
 <aJMZYvCwsR8f3cJZ@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <14ea1968-8087-6e5a-1e6f-6a02696fcdda@huaweicloud.com>
Date: Wed, 6 Aug 2025 17:06:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aJMZYvCwsR8f3cJZ@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3sxMDG5NoAzEGCw--.58891S3
X-Coremail-Antispam: 1UD129KBjvJXoW3ArWrKryDtF48JFWDXF18Xwb_yoWxXF4rpr
	W8JF4jkrW5Xr18Jr42qw45Jryktw1Dtw18Xrn5JFyrXr1qkrnIqr18Xr1j9r18Jr4xAr48
	Xr1UtrW3ZF1UJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbSfO7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/08/06 16:59, Ming Lei 写道:
> On Wed, Aug 06, 2025 at 09:06:28AM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2025/08/05 16:48, Ming Lei 写道:
>>> On Tue, Aug 05, 2025 at 04:38:56PM +0800, Yu Kuai wrote:
>>>> Hi,
>>>>
>>>> 在 2025/08/05 16:33, Yu Kuai 写道:
>>>>> Hi,
>>>>>
>>>>> 在 2025/08/04 19:32, Ming Lei 写道:
>>>>>> On Mon, Aug 04, 2025 at 02:30:43PM +0800, Yu Kuai wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> 在 2025/08/01 19:44, Ming Lei 写道:
>>>>>>>> Replace the spinlock in blk_mq_find_and_get_req() with an
>>>>>>>> SRCU read lock
>>>>>>>> around the tag iterators.
>>>>>>>>
>>>>>>>> This is done by:
>>>>>>>>
>>>>>>>> - Holding the SRCU read lock in blk_mq_queue_tag_busy_iter(),
>>>>>>>> blk_mq_tagset_busy_iter(), and blk_mq_hctx_has_requests().
>>>>>>>>
>>>>>>>> - Removing the now-redundant tags->lock from blk_mq_find_and_get_req().
>>>>>>>>
>>>>>>>> This change improves performance by replacing a spinlock with a more
>>>>>>>> scalable SRCU lock, and fixes lockup issue in
>>>>>>>> scsi_host_busy() in case of
>>>>>>>> shost->host_blocked.
>>>>>>>>
>>>>>>>> Meantime it becomes possible to use blk_mq_in_driver_rw() for io
>>>>>>>> accounting.
>>>>>>>>
>>>>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>>>>>> ---
>>>>>>>>      block/blk-mq-tag.c | 12 ++++++++----
>>>>>>>>      block/blk-mq.c     | 24 ++++--------------------
>>>>>>>>      2 files changed, 12 insertions(+), 24 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>>>>>>>> index 6c2f5881e0de..7ae431077a32 100644
>>>>>>>> --- a/block/blk-mq-tag.c
>>>>>>>> +++ b/block/blk-mq-tag.c
>>>>>>>> @@ -256,13 +256,10 @@ static struct request
>>>>>>>> *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
>>>>>>>>              unsigned int bitnr)
>>>>>>>>      {
>>>>>>>>          struct request *rq;
>>>>>>>> -    unsigned long flags;
>>>>>>>> -    spin_lock_irqsave(&tags->lock, flags);
>>>>>>>>          rq = tags->rqs[bitnr];
>>>>>>>>          if (!rq || rq->tag != bitnr || !req_ref_inc_not_zero(rq))
>>>>>>>>              rq = NULL;
>>>>>>>> -    spin_unlock_irqrestore(&tags->lock, flags);
>>>>>>>>          return rq;
>>>>>>>>      }
>>>>>>>>
>>>>>>> Just wonder, does the lockup problem due to the tags->lock contention by
>>>>>>> concurrent scsi_host_busy?
>>>>>>
>>>>>> Yes.
>>>>>>
>>>>>>>
>>>>>>>> @@ -440,7 +437,9 @@ void blk_mq_tagset_busy_iter(struct
>>>>>>>> blk_mq_tag_set *tagset,
>>>>>>>>              busy_tag_iter_fn *fn, void *priv)
>>>>>>>>      {
>>>>>>>>          unsigned int flags = tagset->flags;
>>>>>>>> -    int i, nr_tags;
>>>>>>>> +    int i, nr_tags, srcu_idx;
>>>>>>>> +
>>>>>>>> +    srcu_idx = srcu_read_lock(&tagset->tags_srcu);
>>>>>>>>          nr_tags = blk_mq_is_shared_tags(flags) ? 1 :
>>>>>>>> tagset->nr_hw_queues;
>>>>>>>> @@ -449,6 +448,7 @@ void blk_mq_tagset_busy_iter(struct
>>>>>>>> blk_mq_tag_set *tagset,
>>>>>>>>                  __blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
>>>>>>>>                                BT_TAG_ITER_STARTED);
>>>>>>>>          }
>>>>>>>> +    srcu_read_unlock(&tagset->tags_srcu, srcu_idx);
>>>>>>>
>>>>>>> And should we add cond_resched() after finish interating one tags, even
>>>>>>> with the srcu change, looks like it's still possible to lockup with
>>>>>>> big cpu cores & deep queue depth.
>>>>>>
>>>>>> The main trouble is from the big tags->lock.
>>>>>>
>>>>>> IMO it isn't needed, because max queue depth is just 10K, which is much
>>>>>> bigger than actual queue depth. We can add it when someone shows it is
>>>>>> really needed.
>>>>>
>>>>> If we don't want this, why not using srcu here? Looks like just use
>>>>> rcu_read_lock and rcu_read_unlock to protect blk_mq_find_and_get_req()
>>>>> will be enough.
>>>>
>>>> Like following patch:
>>>>
>>>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>>>> index d880c50629d6..e2381ee9747d 100644
>>>> --- a/block/blk-mq-tag.c
>>>> +++ b/block/blk-mq-tag.c
>>>> @@ -255,11 +255,11 @@ static struct request *blk_mq_find_and_get_req(struct
>>>> blk_mq_tags *tags,
>>>>           struct request *rq;
>>>>           unsigned long flags;
>>>>
>>>> -       spin_lock_irqsave(&tags->lock, flags);
>>>> +       rcu_read_lock();
>>>>           rq = tags->rqs[bitnr];
>>>>           if (!rq || rq->tag != bitnr || !req_ref_inc_not_zero(rq))
>>>>                   rq = NULL;
>>>> -       spin_unlock_irqrestore(&tags->lock, flags);
>>>> +       rcu_read_unlock();
>>>>           return rq;
>>>>    }
>>>
>>> srcu read lock has to be grabbed when request reference is being accessed,
>>> so the above change is wrong, otherwise plain rcu is enough.
>>>
>> I don't quite understand, I think it's enough to protect grabbing req
>> reference, because IO issue path grab q_usage_counter before setting
>> req reference to 1, and IO complete path decrease req reference to 0
>> before dropping q_usage_counter.
> 
> In theory it is true, but the implementation is pretty fragile, because the
> correctness replies on the implied memory barrier(un-documented) in blk_mq_get_tag()
> between blk_try_enter_queue() and req_ref_set(rq, 1).
> 
>>
>>>>
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index b1d81839679f..a70959cad692 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -3442,12 +3442,8 @@ static void blk_mq_clear_rq_mapping(struct
>>>> blk_mq_tags *drv_tags,
>>>>
>>>>           /*
>>>>            * Wait until all pending iteration is done.
>>>> -        *
>>>> -        * Request reference is cleared and it is guaranteed to be observed
>>>> -        * after the ->lock is released.
>>>>            */
>>>> -       spin_lock_irqsave(&drv_tags->lock, flags);
>>>> -       spin_unlock_irqrestore(&drv_tags->lock, flags);
>>>> +       synchronize_rcu();
>>>
>>> We do want to avoid big delay in this code path, so call_srcu() is much
>>> better.
>>
>> Agreed, however, there is rcu verion helper as well, call_rcu().
> 
> I prefer to srcu, which is simple & straight-forward, especially the background
> of this issue has been tough enough.
> 
Thanks for the explanation, I'm good with srcu now :)
Kuai

> 
> Thanks,
> Ming
> 
> 
> .
> 


