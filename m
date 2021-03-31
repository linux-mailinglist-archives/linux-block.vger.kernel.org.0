Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B2434E187
	for <lists+linux-block@lfdr.de>; Tue, 30 Mar 2021 08:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhC3Gu7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 30 Mar 2021 02:50:59 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:35376 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229950AbhC3Guy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 02:50:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UTpnuEy_1617087051;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UTpnuEy_1617087051)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 30 Mar 2021 14:50:52 +0800
Subject: Re: [PATCH V4 11/12] block: add poll_capable method to support
 bio-based IO polling
To:     Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com
References: <20210329152622.173035-1-ming.lei@redhat.com>
 <20210329152622.173035-12-ming.lei@redhat.com>
 <162f000f-7f86-8988-4a15-2c3bf70de1b7@suse.de>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <a213b9b1-992d-3deb-200d-c74eac500747@linux.alibaba.com>
Date:   Tue, 30 Mar 2021 14:50:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <162f000f-7f86-8988-4a15-2c3bf70de1b7@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/30/21 2:26 PM, Hannes Reinecke wrote:
> On 3/29/21 5:26 PM, Ming Lei wrote:
>> From: Jeffle Xu <jefflexu@linux.alibaba.com>
>>
>> This method can be used to check if bio-based device supports IO polling
>> or not. For mq devices, checking for hw queue in polling mode is
>> adequate, while the sanity check shall be implementation specific for
>> bio-based devices. For example, dm device needs to check if all
>> underlying devices are capable of IO polling.
>>
>> Though bio-based device may have done the sanity check during the
>> device initialization phase, cacheing the result of this sanity check
>> (such as by cacheing in the queue_flags) may not work. Because for dm
>> devices, users could change the state of the underlying devices through
>> '/sys/block/<dev>/io_poll', bypassing the dm device above. In this case,
>> the cached result of the very beginning sanity check could be
>> out-of-date. Thus the sanity check needs to be done every time 'io_poll'
>> is to be modified.
>>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>> ---
>>   block/blk-sysfs.c      | 14 +++++++++++---
>>   include/linux/blkdev.h |  1 +
>>   2 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> index db3268d41274..c8e7e4af66cb 100644
>> --- a/block/blk-sysfs.c
>> +++ b/block/blk-sysfs.c
>> @@ -426,9 +426,17 @@ static ssize_t queue_poll_store(struct
>> request_queue *q, const char *page,
>>       unsigned long poll_on;
>>       ssize_t ret;
>>   -    if (!q->tag_set || q->tag_set->nr_maps <= HCTX_TYPE_POLL ||
>> -        !q->tag_set->map[HCTX_TYPE_POLL].nr_queues)
>> -        return -EINVAL;
>> +    if (queue_is_mq(q)) {
>> +        if (!q->tag_set || q->tag_set->nr_maps <= HCTX_TYPE_POLL ||
>> +            !q->tag_set->map[HCTX_TYPE_POLL].nr_queues)
>> +            return -EINVAL;
>> +    } else {
>> +        struct gendisk *disk = queue_to_disk(q);
>> +
>> +        if (!disk->fops->poll_capable ||
>> +            !disk->fops->poll_capable(disk))
>> +            return -EINVAL;
>> +    }
>>         ret = queue_var_store(&poll_on, page, count);
>>       if (ret < 0)
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index bfab74b45f15..a46f975f2a2f 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -1881,6 +1881,7 @@ struct block_device_operations {
>>       int (*report_zones)(struct gendisk *, sector_t sector,
>>               unsigned int nr_zones, report_zones_cb cb, void *data);
>>       char *(*devnode)(struct gendisk *disk, umode_t *mode);
>> +    bool (*poll_capable)(struct gendisk *disk);
>>       struct module *owner;
>>       const struct pr_ops *pr_ops;
>>   };
>>
> I really wonder how this would work for nvme multipath; but I guess it
> doesn't change the current situation.

I wonder, at least, md/dm, which is built upon other devices, or
'virtual device' in other words, should be distinguished from other
'original' bio-based device (e.g., nvme multipath) then. Maybe one extra
flag or something.

-- 
Thanks,
Jeffle
