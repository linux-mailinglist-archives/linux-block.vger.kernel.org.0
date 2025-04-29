Return-Path: <linux-block+bounces-20853-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 604AEAA01F2
	for <lists+linux-block@lfdr.de>; Tue, 29 Apr 2025 07:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E943A3607
	for <lists+linux-block@lfdr.de>; Tue, 29 Apr 2025 05:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DA225E819;
	Tue, 29 Apr 2025 05:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="edJao+ht"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C6112C544
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 05:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745905556; cv=none; b=DH1+htGavBbnCR2Pny79OKnkUj5I0fxyjcCKLX6aLDygrAKWsV3Fp0AY1Lbw8HtRiH9EJ+UU87Io10CAGN8fu6FmtBp2sj5Gw3FwIjoKbue1GAv7cZVQ+sYjEVwpCSlbJ/vAYhGyFP1eKFzRqjDmbX7GjpXgh7pGYHQkTh+bOA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745905556; c=relaxed/simple;
	bh=1AltS1U7rXI+nbxreQt4Shg9muPzA1k0S/IYgQuAsNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAhC0xoPHzvPAijexUeux6u5YGUFmgByTQACPD24pAadOI1jid7PK/929HYUo+CPouQcwrPE+Sqh1IjOwGkG6yoRUd/89gEFp1tdiahpQi2zG0O94/q5TYo+kpfmTzgag4DNf1qsoICpIsjZvrT/BkqPXHTVeTgDm43GgU045jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=edJao+ht; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745905553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mCGCzan43sDzHJpqF7l2F8e1AHxNrX5P/gKx+st5FUQ=;
	b=edJao+htOrWj22vpjpJW2cJi7M8oftboPsmrYpiF/e/P6ygvz7hqoPeiyZwsP6jBNwMYJ4
	PvQA0uIdjga8eJOiqowYA3XsLmRXRp2Y/WAUCUn7g7Ooh6OJgiOpy8ZXf7DQo7I+z4hvyR
	IdNwLTWna7Kyq6lTeWwyOO1CmdgERsQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-2tBMWpxPMqKuLUVPjTaSxw-1; Tue, 29 Apr 2025 01:45:50 -0400
X-MC-Unique: 2tBMWpxPMqKuLUVPjTaSxw-1
X-Mimecast-MFC-AGG-ID: 2tBMWpxPMqKuLUVPjTaSxw_1745905549
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2262051205aso39708655ad.3
        for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 22:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745905549; x=1746510349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mCGCzan43sDzHJpqF7l2F8e1AHxNrX5P/gKx+st5FUQ=;
        b=vextWdYrKsq8PibF2ehvd0pjU0hrAo51sq/oEiHywmyzSWDFJ95uhl60SJHTJpxbpE
         1H/JwP61zjeREMKo55l7mrv07maZSbf4xBYibsjPWprdP4zT9Jdse0t+rXeJg94oeigw
         KBuzgRzMFN9IP0JrwHMeO5bsv1whlvAyxd9MB1Xf9PU7WUhL8fxfJaZsF+v8RfTpcy5I
         bw9SgI/LMRE2zOIGbMMMBYCR0x9UtfVHCUdhTnD5FctkFefR+2dCteLA0A198oWVHzml
         tUiifUHc+aXqXiCzhvIyZX19G6ycfPILIr573d9SPCG3fiyJonWyjZ6u6MRGApghhspM
         XLDA==
X-Forwarded-Encrypted: i=1; AJvYcCVH61UsufVqHF2rUAW0sRq7gMHHn8Ru//F1u/QMKa8rfd+NSxUcEY9oSPCvaj1MwCl+uFFF+p6Z4IKsWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4s2AjCCieARTleKevzI0+CG6S8l0GFqpW2cTUZS1lEk/1NbfE
	qDcvYXHv05kA29jgN0eTXUro6Owj5FC6P0MdzPsiZjnUNL4DaN2BlnJQcs+OqRBfUWC6C1OKajB
	nHrM011S9hLwzf5fU3w85ZEjzhFrTK/m6F/mdk0xt7Mj44G0VYQ1Jh516E8D0
X-Gm-Gg: ASbGncs6SMgXt4oNDu3Eu0wV9Us5Qq/H8fE1JcS/piEh46keYZfjCFXt8tkbD6PiZH8
	fAWr8g1wFJ+tN/QqmraqvLdfcdHu7K5X/teMMFVFnQ22sOBwASgiLa4cojWkHqRy1VZrBZjs9mD
	dxOlVPgz/J4/9rxzmMW8cBl/MyfxeXXeAS9c6cuzmz1M6SfslldSo/d/HBfOkcDhkgsFMUxTsEk
	HdsL9R5STJxpdGDV2H2xdm0gM7N2/skhhQEbQinMv7sGP9/JqD/Wat0vBDSMU90EevsxognX0A8
	o/9/W76uRBds2RS38HU=
X-Received: by 2002:a17:903:1b2e:b0:215:bc30:c952 with SMTP id d9443c01a7336-22de70072f4mr22218865ad.6.1745905549490;
        Mon, 28 Apr 2025 22:45:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb9l/j3iC5srMYm+HjvS5dxz7BCYXoHWfxMyc+UogHly0iM8HYkIMxcNYPQTkCj4F+Tjulkg==
X-Received: by 2002:a17:903:1b2e:b0:215:bc30:c952 with SMTP id d9443c01a7336-22de70072f4mr22218535ad.6.1745905549079;
        Mon, 28 Apr 2025 22:45:49 -0700 (PDT)
Received: from [10.72.120.13] ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dbe328sm93748265ad.88.2025.04.28.22.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 22:45:48 -0700 (PDT)
Message-ID: <2e517b58-3a7b-4212-8b91-defd8345b2bb@redhat.com>
Date: Tue, 29 Apr 2025 13:45:39 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] md: fix is_mddev_idle()
To: Paul Menzel <pmenzel@molgen.mpg.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@infradead.org, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
 mpatocka@redhat.com, song@kernel.org, yukuai3@huawei.com, cl@linux.com,
 nadav.amit@gmail.com, ubizjak@gmail.com, akpm@linux-foundation.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250427082928.131295-1-yukuai1@huaweicloud.com>
 <20250427082928.131295-9-yukuai1@huaweicloud.com>
 <fefeda56-6b28-45b8-bc35-75f537613142@molgen.mpg.de>
From: Xiao Ni <xni@redhat.com>
In-Reply-To: <fefeda56-6b28-45b8-bc35-75f537613142@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/4/27 下午5:51, Paul Menzel 写道:
> Dear Kuai,
>
>
> Thank you for your patch.
>
>
> Am 27.04.25 um 10:29 schrieb Yu Kuai:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> If sync_speed is above speed_min, then is_mddev_idle() will be called
>> for each sync IO to check if the array is idle, and inflihgt sync_io
>
> infli*gh*t
>
>> will be limited if the array is not idle.
>>
>> However, while mkfs.ext4 for a large raid5 array while recovery is in
>> progress, it's found that sync_speed is already above speed_min while
>> lots of stripes are used for sync IO, causing long delay for mkfs.ext4.
>>
>> Root cause is the following checking from is_mddev_idle():
>>
>> t1: submit sync IO: events1 = completed IO - issued sync IO
>> t2: submit next sync IO: events2  = completed IO - issued sync IO
>> if (events2 - events1 > 64)
>>
>> For consequence, the more sync IO issued, the less likely checking will
>> pass. And when completed normal IO is more than issued sync IO, the
>> condition will finally pass and is_mddev_idle() will return false,
>> however, last_events will be updated hence is_mddev_idle() can only
>> return false once in a while.
>>
>> Fix this problem by changing the checking as following:
>>
>> 1) mddev doesn't have normal IO completed;
>> 2) mddev doesn't have normal IO inflight;
>> 3) if any member disks is partition, and all other partitions doesn't
>>     have IO completed.
>
> Do you have benchmarks of mkfs.ext4 before and after your patch? It’d 
> be great if you added those.
>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md.c | 84 +++++++++++++++++++++++++++----------------------
>>   drivers/md/md.h |  3 +-
>>   2 files changed, 48 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 541151bcfe81..955efe0b40c6 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -8625,50 +8625,58 @@ void md_cluster_stop(struct mddev *mddev)
>>       put_cluster_ops(mddev);
>>   }
>>   -static int is_mddev_idle(struct mddev *mddev, int init)
>> +static bool is_rdev_holder_idle(struct md_rdev *rdev, bool init)
>>   {
>> +    unsigned long last_events = rdev->last_events;
>> +
>> +    if (!bdev_is_partition(rdev->bdev))
>> +        return true;
>
> Will the compiler generate code, that the assignment happens after 
> this condition?
>
>> +
>> +    /*
>> +     * If rdev is partition, and user doesn't issue IO to the array, 
>> the
>> +     * array is still not idle if user issues IO to other partitions.
>> +     */
>> +    rdev->last_events = 
>> part_stat_read_accum(rdev->bdev->bd_disk->part0,
>> +                         sectors) -
>> +                part_stat_read_accum(rdev->bdev, sectors);
>> +
>> +    if (!init && rdev->last_events > last_events)
>> +        return false;
>> +
>> +    return true;
>
> Could be one return statement, couldn’t it?
>
>     return init || rdev->last_events <= last_events;


For me, I prefer the way of this patch. It's easy to understand. One 
return statement is harder to understand than the two return statements.

>
>> +}
>> +
>> +/*
>> + * mddev is idle if following conditions are match since last check:
>
> … *the* following condition are match*ed* …
>
> (or are met)
>
>> + * 1) mddev doesn't have normal IO completed;
>> + * 2) mddev doesn't have inflight normal IO;
>> + * 3) if any member disk is partition, and other partitions doesn't 
>> have IO
>
> don’t
>
>> + *    completed;
>> + *
>> + * Noted this checking rely on IO accounting is enabled.
>> + */
>> +static bool is_mddev_idle(struct mddev *mddev, int init)
>> +{
>> +    unsigned long last_events = mddev->normal_IO_events;
>> +    struct gendisk *disk;
>>       struct md_rdev *rdev;
>> -    int idle;
>> -    int curr_events;
>> +    bool idle = true;
>>   -    idle = 1;
>> -    rcu_read_lock();
>> -    rdev_for_each_rcu(rdev, mddev) {
>> -        struct gendisk *disk = rdev->bdev->bd_disk;
>> +    disk = mddev_is_dm(mddev) ? mddev->dm_gendisk : mddev->gendisk;
>> +    if (!disk)
>> +        return true;
>>   -        if (!init && !blk_queue_io_stat(disk->queue))
>> -            continue;
>> +    mddev->normal_IO_events = part_stat_read_accum(disk->part0, 
>> sectors);
>> +    if (!init && (mddev->normal_IO_events > last_events ||
>> +              bdev_count_inflight(disk->part0)))
>> +        idle = false;
>>   -        curr_events = (int)part_stat_read_accum(disk->part0, 
>> sectors) -
>> -                  atomic_read(&disk->sync_io);
>> -        /* sync IO will cause sync_io to increase before the disk_stats
>> -         * as sync_io is counted when a request starts, and
>> -         * disk_stats is counted when it completes.
>> -         * So resync activity will cause curr_events to be smaller than
>> -         * when there was no such activity.
>> -         * non-sync IO will cause disk_stat to increase without
>> -         * increasing sync_io so curr_events will (eventually)
>> -         * be larger than it was before.  Once it becomes
>> -         * substantially larger, the test below will cause
>> -         * the array to appear non-idle, and resync will slow
>> -         * down.
>> -         * If there is a lot of outstanding resync activity when
>> -         * we set last_event to curr_events, then all that activity
>> -         * completing might cause the array to appear non-idle
>> -         * and resync will be slowed down even though there might
>> -         * not have been non-resync activity.  This will only
>> -         * happen once though.  'last_events' will soon reflect
>> -         * the state where there is little or no outstanding
>> -         * resync requests, and further resync activity will
>> -         * always make curr_events less than last_events.
>> -         *
>> -         */
>> -        if (init || curr_events - rdev->last_events > 64) {
>> -            rdev->last_events = curr_events;
>> -            idle = 0;
>> -        }
>> -    }
>> +    rcu_read_lock();
>> +    rdev_for_each_rcu(rdev, mddev)
>> +        if (!is_rdev_holder_idle(rdev, init))
>> +            idle = false;
>>       rcu_read_unlock();
>> +
>>       return idle;
>>   }
>>   diff --git a/drivers/md/md.h b/drivers/md/md.h
>> index b57842188f18..da3fd514d20c 100644
>> --- a/drivers/md/md.h
>> +++ b/drivers/md/md.h
>> @@ -132,7 +132,7 @@ struct md_rdev {
>>         sector_t sectors;        /* Device size (in 512bytes sectors) */
>>       struct mddev *mddev;        /* RAID array if running */
>> -    int last_events;        /* IO event timestamp */
>> +    unsigned long last_events;    /* IO event timestamp */
>
> Please mention in the commit message, why the type is changed.
>
>>         /*
>>        * If meta_bdev is non-NULL, it means that a separate device is
>> @@ -520,6 +520,7 @@ struct mddev {
>>                                * adding a spare
>>                                */
>>   +    unsigned long            normal_IO_events; /* IO event 
>> timestamp */
>
> Make everything lower case?


agree+

Regards

Xiao

>
>>       atomic_t            recovery_active; /* blocks scheduled, but 
>> not written */
>>       wait_queue_head_t        recovery_wait;
>>       sector_t            recovery_cp;
>
>
> Kind regards,
>
> Paul
>


