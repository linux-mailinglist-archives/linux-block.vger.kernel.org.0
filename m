Return-Path: <linux-block+bounces-19639-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A7AA893B5
	for <lists+linux-block@lfdr.de>; Tue, 15 Apr 2025 08:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB107A37FD
	for <lists+linux-block@lfdr.de>; Tue, 15 Apr 2025 06:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A4A274FDA;
	Tue, 15 Apr 2025 06:13:42 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3C12417C2
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 06:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744697622; cv=none; b=jo7F3XunfFnKOVAG5mVe+SOYhP0iehCFc7SRu39IU+rWNO12AXWiC2/74JpY1Eyxhs4W38ndkdxFdjrMkhrtKiVfSCYlCzET2StYZREZP/eVAasHKixu91s8QEZ1GSimPJrxmhZbsVtt0ZMUOT4XBMoZdxbWspCGX+RsafaE2UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744697622; c=relaxed/simple;
	bh=pOc1syN6rVxcEj8D3zy8QsPNkKRMLaJ9MKDKfTII7JQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rdwN6xHalEIrl7yTtiFhCMsfZ9X3jUHOcdziZxDUQ2Vg08t2ifjC9sIKQ3Si/urJHRLmhggjwUul6YdpA6bJgYoy2kkviNrkEAgO7N5x6w5wJPabLYFlGrWTePuGelWsAyjSAPswkoWzsC3n2/EP5oSuMol0Nv75GH8p/h5OSyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZcDP062TCz2TS7N;
	Tue, 15 Apr 2025 14:13:24 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id E9466140142;
	Tue, 15 Apr 2025 14:13:30 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Apr 2025 14:13:30 +0800
Message-ID: <e37717f0-3704-4bc4-88f8-dc3e7d812aac@huawei.com>
Date: Tue, 15 Apr 2025 14:13:29 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] blk-throttle: Refactor tg_dispatch_time by extracting
 tg_dispatch_bps/iops_time
To: Yu Kuai <yukuai1@huaweicloud.com>, <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>
CC: <yangerkun@huawei.com>, <ming.lei@redhat.com>, <tj@kernel.org>, "yukuai
 (C)" <yukuai3@huawei.com>
References: <20250414132731.167620-1-wozizhi@huawei.com>
 <20250414132731.167620-3-wozizhi@huawei.com>
 <58cabe9f-86c6-d26a-d27b-0a138b00e7ec@huaweicloud.com>
From: Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <58cabe9f-86c6-d26a-d27b-0a138b00e7ec@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100017.china.huawei.com (7.202.181.16)



在 2025/4/15 10:19, Yu Kuai 写道:
> Hi, one nit below:
> 
> 在 2025/04/14 21:27, Zizhi Wo 写道:
>> tg_dispatch_time() contained both bps and iops throttling logic. We now
>> split its internal logic into tg_dispatch_bps/iops_time() to improve code
>> consistency for future separation of the bps and iops queues.
>>
>> Besides, merge time_before() from caller into throtl_extend_slice() to 
>> make
>> code cleaner.
>>
>> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
>> ---
>>   block/blk-throttle.c | 98 +++++++++++++++++++++++++-------------------
>>   1 file changed, 55 insertions(+), 43 deletions(-)
>>
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index dc23c961c028..0633ae0cce90 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -520,6 +520,9 @@ static inline void throtl_set_slice_end(struct 
>> throtl_grp *tg, bool rw,
>>   static inline void throtl_extend_slice(struct throtl_grp *tg, bool rw,
>>                          unsigned long jiffy_end)
>>   {
>> +    if (!time_before(tg->slice_end[rw], jiffy_end))
>> +        return;
>> +
>>       throtl_set_slice_end(tg, rw, jiffy_end);
>>       throtl_log(&tg->service_queue,
>>              "[%c] extend slice start=%lu end=%lu jiffies=%lu",
>> @@ -682,10 +685,6 @@ static unsigned long tg_within_iops_limit(struct 
>> throtl_grp *tg, struct bio *bio
>>       int io_allowed;
>>       unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
>> -    if (iops_limit == UINT_MAX) {
>> -        return 0;
>> -    }
>> -
>>       jiffy_elapsed = jiffies - tg->slice_start[rw];
>>       /* Round up to the next throttle slice, wait time must be 
>> nonzero */
>> @@ -711,11 +710,6 @@ static unsigned long tg_within_bps_limit(struct 
>> throtl_grp *tg, struct bio *bio,
>>       unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
>>       unsigned int bio_size = throtl_bio_data_size(bio);
>> -    /* no need to throttle if this bio's bytes have been accounted */
>> -    if (bps_limit == U64_MAX || bio_flagged(bio, BIO_BPS_THROTTLED)) {
>> -        return 0;
>> -    }
>> -
>>       jiffy_elapsed = jiffy_elapsed_rnd = jiffies - tg->slice_start[rw];
>>       /* Slice has just started. Consider one slice interval */
>> @@ -742,6 +736,54 @@ static unsigned long tg_within_bps_limit(struct 
>> throtl_grp *tg, struct bio *bio,
>>       return jiffy_wait;
>>   }
>> +/*
>> + * If previous slice expired, start a new one otherwise renew/extend 
>> existing
>> + * slice to make sure it is at least throtl_slice interval long since 
>> now.
>> + * New slice is started only for empty throttle group. If there is 
>> queued bio,
>> + * that means there should be an active slice and it should be 
>> extended instead.
>> + */
>> +static void tg_update_slice(struct throtl_grp *tg, bool rw)
>> +{
>> +    if (throtl_slice_used(tg, rw) && !(tg->service_queue.nr_queued[rw]))
>> +        throtl_start_new_slice(tg, rw, true);
>> +    else
>> +        throtl_extend_slice(tg, rw, jiffies + tg->td->throtl_slice);
>> +}
>> +
>> +static unsigned long tg_dispatch_bps_time(struct throtl_grp *tg, 
>> struct bio *bio)
>> +{
>> +    bool rw = bio_data_dir(bio);
>> +    u64 bps_limit = tg_bps_limit(tg, rw);
>> +    unsigned long bps_wait;
>> +
>> +    /* no need to throttle if this bio's bytes have been accounted */
>> +    if (bps_limit == U64_MAX || tg->flags & THROTL_TG_CANCELING ||
>> +        bio_flagged(bio, BIO_BPS_THROTTLED))
>> +        return 0;
>> +
>> +    tg_update_slice(tg, rw);
>> +    bps_wait = tg_within_bps_limit(tg, bio, bps_limit);
> 
> if (bps_wait > 0)

Since the time_before() logic has been incorporated into
throtl_extend_slice(), can we simplify the code by not adding the extra
check?

Thanks,
Zizhi Wo

>> +    throtl_extend_slice(tg, rw, jiffies + bps_wait);
>> +
>> +    return bps_wait;
>> +}
>> +
>> +static unsigned long tg_dispatch_iops_time(struct throtl_grp *tg, 
>> struct bio *bio)
>> +{
>> +    bool rw = bio_data_dir(bio);
>> +    u32 iops_limit = tg_iops_limit(tg, rw);
>> +    unsigned long iops_wait;
>> +
>> +    if (iops_limit == UINT_MAX || tg->flags & THROTL_TG_CANCELING)
>> +        return 0;
>> +
>> +    tg_update_slice(tg, rw);
>> +    iops_wait = tg_within_iops_limit(tg, bio, iops_limit);
> 
> if (iops_wait > 0)
> 
> Otherwise, LGTM
> 
> Thanks,
> Kuai
>> +    throtl_extend_slice(tg, rw, jiffies + iops_wait);
>> +
>> +    return iops_wait;
>> +}
>> +
>>   /*
>>    * Returns approx number of jiffies to wait before this bio is 
>> with-in IO rate
>>    * and can be dispatched.
>> @@ -749,9 +791,7 @@ static unsigned long tg_within_bps_limit(struct 
>> throtl_grp *tg, struct bio *bio,
>>   static unsigned long tg_dispatch_time(struct throtl_grp *tg, struct 
>> bio *bio)
>>   {
>>       bool rw = bio_data_dir(bio);
>> -    unsigned long bps_wait, iops_wait, max_wait;
>> -    u64 bps_limit = tg_bps_limit(tg, rw);
>> -    u32 iops_limit = tg_iops_limit(tg, rw);
>> +    unsigned long bps_wait, iops_wait;
>>       /*
>>         * Currently whole state machine of group depends on first bio
>> @@ -762,38 +802,10 @@ static unsigned long tg_dispatch_time(struct 
>> throtl_grp *tg, struct bio *bio)
>>       BUG_ON(tg->service_queue.nr_queued[rw] &&
>>              bio != throtl_peek_queued(&tg->service_queue.queued[rw]));
>> -    /* If tg->bps = -1, then BW is unlimited */
>> -    if ((bps_limit == U64_MAX && iops_limit == UINT_MAX) ||
>> -        tg->flags & THROTL_TG_CANCELING)
>> -        return 0;
>> -
>> -    /*
>> -     * If previous slice expired, start a new one otherwise renew/extend
>> -     * existing slice to make sure it is at least throtl_slice interval
>> -     * long since now. New slice is started only for empty throttle 
>> group.
>> -     * If there is queued bio, that means there should be an active
>> -     * slice and it should be extended instead.
>> -     */
>> -    if (throtl_slice_used(tg, rw) && !(tg->service_queue.nr_queued[rw]))
>> -        throtl_start_new_slice(tg, rw, true);
>> -    else {
>> -        if (time_before(tg->slice_end[rw],
>> -            jiffies + tg->td->throtl_slice))
>> -            throtl_extend_slice(tg, rw,
>> -                jiffies + tg->td->throtl_slice);
>> -    }
>> -
>> -    bps_wait = tg_within_bps_limit(tg, bio, bps_limit);
>> -    iops_wait = tg_within_iops_limit(tg, bio, iops_limit);
>> -    if (bps_wait + iops_wait == 0)
>> -        return 0;
>> -
>> -    max_wait = max(bps_wait, iops_wait);
>> -
>> -    if (time_before(tg->slice_end[rw], jiffies + max_wait))
>> -        throtl_extend_slice(tg, rw, jiffies + max_wait);
>> +    bps_wait = tg_dispatch_bps_time(tg, bio);
>> +    iops_wait = tg_dispatch_iops_time(tg, bio);
>> -    return max_wait;
>> +    return max(bps_wait, iops_wait);
>>   }
>>   static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
>>
> 

