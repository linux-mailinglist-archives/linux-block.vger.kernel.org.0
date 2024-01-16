Return-Path: <linux-block+bounces-1849-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DBF82EC72
	for <lists+linux-block@lfdr.de>; Tue, 16 Jan 2024 11:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CFE81C21124
	for <lists+linux-block@lfdr.de>; Tue, 16 Jan 2024 10:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B141A134B1;
	Tue, 16 Jan 2024 09:59:50 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0864A134AA;
	Tue, 16 Jan 2024 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TDky42PDwz4f3jR1;
	Tue, 16 Jan 2024 17:59:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0DE591A0392;
	Tue, 16 Jan 2024 17:59:44 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBGOU6Zlhe4BBA--.6758S3;
	Tue, 16 Jan 2024 17:59:43 +0800 (CST)
Subject: Re: [PATCH for-6.8/block] block: support to account io_ticks
 precisely
To: Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>
Cc: hch@lst.de, bvanassche@acm.org, axboe@kernel.dk,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240109071332.2216253-1-yukuai1@huaweicloud.com>
 <ZaUZH8v2i7YBklyc@fedora>
 <bdbbaff8-bdb6-0416-b4f4-bbebb64fb1fc@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1960aea3-3daa-d899-7daf-39dbcc1b7a9d@huaweicloud.com>
Date: Tue, 16 Jan 2024 17:59:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bdbbaff8-bdb6-0416-b4f4-bbebb64fb1fc@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBGOU6Zlhe4BBA--.6758S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw4UXF1DWr4DArW8XF17trb_yoWxCr43pr
	ykJF1DJr98Xr1rCr1jyw1UJFy8Jw48Jw1UXr1xJFy7Ar17Jr12qr18XrZYgF18Xrs7AF4U
	Xr1UZr9rZr15A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Ming

在 2024/01/15 19:54, Yu Kuai 写道:
> Hi,
> 
> 在 2024/01/15 19:38, Ming Lei 写道:
>> On Tue, Jan 09, 2024 at 03:13:32PM +0800, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Currently, io_ticks is accounted based on sampling, specifically
>>> update_io_ticks() will always account io_ticks by 1 jiffies from
>>> bdev_start_io_acct()/blk_account_io_start(), and the result can be
>>> inaccurate, for example(HZ is 250):
>>>
>>> Test script:
>>> fio -filename=/dev/sda -bs=4k -rw=write -direct=1 -name=test 
>>> -thinktime=4ms
>>>
>>> Test result: util is about 90%, while the disk is really idle.
>>
>> Just be curious, what is result with this patch? 0%?

I ran some tests on null_blk and found out that this patch actually
doesn't have any performance overhead, and I finially figure out that
it's true even in theroy.

Notice that there is a cmpxchg() in update_ticks():

update_io_ticks:
  stamp = part->bd_stamp;
  if (time_after(now, stamp))
   if (try_cmpxchg())
    __part_stat_add()

Hence only one task can pass cmpxchg in 1 jiffies, and part_stat_add() 
be called at most once in 1 jiffies. Which means with this patch,
part_in_flight() will also be called at most once in 1 jiffies(not per
IO). And part_in_flight() once per jiffies really doesn't affect IO
performance at all.

Befor this cmpxchg():

part_round_stats:
  if (part->stamp != now)
   stats |= 1;

  part_in_flight()
-> there can be lots of task here in 1 jiffies.
  part_round_stats_single()
   __part_stat_add()
  part->stamp = now;

By the way, this cmpxchg() is added by commit 5b18b5a73760 ("block:
delete part_round_stats and switch to less precise counting"), hence
actually there is no need to switch to less precise counting in the
first place.

So I think I can just remove the switch and switch to precise io
accounting by default in the next version.

Please let me know what you think!

Thanks,
Kuai

> 
> No, it's not 0%, this actually depends on how many IO really start from
> one jiffies and complete at the next jiffies. Given that the probability
> is related to IO latency, so the result should be relatively
> accurate(Around 10% in my environment). I think we can live with that
> unless we improve time precision from jiffies to ns.
>>
>>>
>>> In order to account io_ticks precisely, update_io_ticks() must know if
>>> there are IO inflight already, and this requires overhead slightly,
>>> hence precise io accounting is disabled by default, and user can enable
>>> it through sysfs entry.
>>>
>>> Noted that for rq-based devcie, part_stat_local_inc/dec() and
>>> part_in_flight() is used to track inflight instead of iterating tags,
>>> which is not supposed to be used in fast path because 'tags->lock' is
>>> grabbed in blk_mq_find_and_get_req().
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> ---
>>> Changes from RFC v1:
>>>   - remove the new parameter for update_io_ticks();
>>>   - simplify update_io_ticks();
>>>   - use swith in queue_iostats_store();
>>>   - add missing part_stat_local_dec() in blk_account_io_merge_request();
>>> Changes from RFC v2:
>>>   - fix that precise is ignored for the first io in update_io_ticks();
>>>
>>>   Documentation/ABI/stable/sysfs-block |  8 ++++--
>>>   block/blk-core.c                     | 10 +++++--
>>>   block/blk-merge.c                    |  3 ++
>>>   block/blk-mq-debugfs.c               |  2 ++
>>>   block/blk-mq.c                       | 11 +++++++-
>>>   block/blk-sysfs.c                    | 42 ++++++++++++++++++++++++++--
>>>   block/blk.h                          |  1 +
>>>   block/genhd.c                        |  2 +-
>>>   include/linux/blk-mq.h               |  1 +
>>>   include/linux/blkdev.h               |  3 ++
>>>   10 files changed, 74 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/Documentation/ABI/stable/sysfs-block 
>>> b/Documentation/ABI/stable/sysfs-block
>>> index 1fe9a553c37b..79027bf2661a 100644
>>> --- a/Documentation/ABI/stable/sysfs-block
>>> +++ b/Documentation/ABI/stable/sysfs-block
>>> @@ -358,8 +358,12 @@ What:        /sys/block/<disk>/queue/iostats
>>>   Date:        January 2009
>>>   Contact:    linux-block@vger.kernel.org
>>>   Description:
>>> -        [RW] This file is used to control (on/off) the iostats
>>> -        accounting of the disk.
>>> +        [RW] This file is used to control the iostats accounting of the
>>> +        disk. If this value is 0, iostats accounting is disabled; If
>>> +        this value is 1, iostats accounting is enabled, but io_ticks is
>>> +        accounted by sampling and the result is not accurate; If this
>>> +        value is 2, iostats accounting is enabled and io_ticks is
>>> +        accounted precisely, but there will be slightly more overhead.
>>>   What:        /sys/block/<disk>/queue/logical_block_size
>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>> index 9520ccab3050..c70dc311e3b7 100644
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -954,11 +954,15 @@ EXPORT_SYMBOL_GPL(iocb_bio_iopoll);
>>>   void update_io_ticks(struct block_device *part, unsigned long now, 
>>> bool end)
>>>   {
>>>       unsigned long stamp;
>>> +    bool precise = blk_queue_precise_io_stat(part->bd_queue);
>>>   again:
>>>       stamp = READ_ONCE(part->bd_stamp);
>>> -    if (unlikely(time_after(now, stamp))) {
>>> -        if (likely(try_cmpxchg(&part->bd_stamp, &stamp, now)))
>>> -            __part_stat_add(part, io_ticks, end ? now - stamp : 1);
>>> +    if (unlikely(time_after(now, stamp)) &&
>>> +        likely(try_cmpxchg(&part->bd_stamp, &stamp, now))) {
>>> +        if (end || (precise && part_in_flight(part)))
>>> +            __part_stat_add(part, io_ticks, now - stamp);
>>> +        else if (!precise)
>>> +            __part_stat_add(part, io_ticks, 1);
>>
>> It should be better or readable to move 'bool precise' into the above 
>> branch,
>> given we only need to read the flag once in each tick.
>>
>> Otherwise, this patch looks fine.
> 
> Thanks for your advice, will change that in next version.
> 
> Kuai
>>
>> Thanks,
>> Ming
>>
>> .
>>
> 
> .
> 


