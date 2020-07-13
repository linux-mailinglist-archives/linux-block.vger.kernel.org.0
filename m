Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75FC21A886
	for <lists+linux-block@lfdr.de>; Thu,  9 Jul 2020 22:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgGIUCw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 9 Jul 2020 16:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgGIUCv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Jul 2020 16:02:51 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1A8C08C5CE
        for <linux-block@vger.kernel.org>; Thu,  9 Jul 2020 13:02:50 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id a12so3615655ion.13
        for <linux-block@vger.kernel.org>; Thu, 09 Jul 2020 13:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JGsBY8NWFajOfKxgC4THe4iCtzTBmZ3nu7fkyGWluuk=;
        b=XH4jxoNhJ0Pym36f5N5Q+4Yj/Jvk//jDAfERgIQszBYWiUzDu8mWQaqH8A34pganp1
         /lsyEGbZpUv76658zyVxEsun7ZQc3DSMQksOyp4RPzsMyHnDJJneq3XRQBgmHoRzHBfL
         bu6dGNv458JmEwgTGnmzgh1FWv2CIYsyPytZgwfdJQDijmpGN7uAii38rTDWK45R9bsV
         CTmf/bvStvQLdWVpAD0ebQX5gScdJjxHICnFqKiKRSSYNNFtlHHVj49IqxxP0u/NxOrv
         OlH/CL2tsfDa+lih3KeN94QbSZc2VdOH7BEQ6HpZilAQwu8eD86Nfmqv24AKMaoyGJdA
         /K1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JGsBY8NWFajOfKxgC4THe4iCtzTBmZ3nu7fkyGWluuk=;
        b=RAN80W5mUpak40NVS30gjs8OeL+1lELI+gMtUc+5c19mu/fpq0I24omC6FihxPfxeY
         FEbnfwilbWn6f4nKIXGaMhdi3HExbBo+r9zQAyuhn5jPm9m+iutW2BJhzFnp0NUFeXdz
         5MhZpZDrR783b7IrVqOdn33pUVyM8p/ZqIL/cB4zLxopgH3cD+VbHP79qwBcZBQA877v
         t2Kh0m7+qqX3PJStGIr+9CfeRpS0d8wXUKKTBgqiNvYkIwwQAwwDtepC3MhCUegd+GXt
         69h7G826fHNWqYADS3WzLWpXRkdjQ6JJKeHCXUmPyImId61f7LYSQz+rCDsuqjojJL7h
         UnBQ==
X-Gm-Message-State: AOAM531SuUlfGRFhUNLOEYUgQhF1p41RpCLjYeCB4d0nz5Whfd7+0khP
        X9WVGzP60A9Wpd5LQNQTS8Ip6sBtLisy9w==
X-Google-Smtp-Source: ABdhPJxXZuW58xFKRzJlGDI+HMA2tnrsyogQYTFWWUPgFA8kJoTzpbyn2MF7/Xyt4FXyF0A+8psSuA==
X-Received: by 2002:a05:6638:d05:: with SMTP id q5mr72200611jaj.2.1594324969841;
        Thu, 09 Jul 2020 13:02:49 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u10sm2732919iow.38.2020.07.09.13.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 13:02:49 -0700 (PDT)
Subject: Re: [PATCH 02/21] block: add flag for internal commands
To:     John Garry <john.garry@huawei.com>, Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        Don Brace <don.brace@microchip.com>,
        linux-scsi@vger.kernel.org,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20200703130122.111448-1-hare@suse.de>
 <20200703130122.111448-3-hare@suse.de>
 <699d432d-eb5e-a928-5391-c31643620b27@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1577e01a-445d-3843-389f-6f4b004461c0@kernel.dk>
Date:   Thu, 9 Jul 2020 14:02:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <699d432d-eb5e-a928-5391-c31643620b27@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/8/20 3:27 AM, John Garry wrote:
> On 03/07/2020 14:01, Hannes Reinecke wrote:
> 
> +linux-block
> 
> I figure that linux-block should be cc'ed here
> 
>> Some drivers require to allocate requests for internal command
>> submission. These request will never be passed through the block
>> layer, but nevertheless require a valid tag to avoid them clashing
>> with normal I/O commands.
>> This patch adds a new request flag REQ_INTERNAL to mark such
>> requests and a terminates any such commands in blk_execute_rq_nowait()
>> with a WARN_ON_ONCE to signal such an invalid usage.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   block/blk-exec.c          | 5 +++++
>>   include/linux/blk_types.h | 2 ++
>>   include/linux/blkdev.h    | 5 +++++
>>   3 files changed, 12 insertions(+)
>>
>> diff --git a/block/blk-exec.c b/block/blk-exec.c
>> index 85324d53d072..6869877e0d21 100644
>> --- a/block/blk-exec.c
>> +++ b/block/blk-exec.c
>> @@ -55,6 +55,11 @@ void blk_execute_rq_nowait(struct request_queue *q, struct gendisk *bd_disk,
>>   	rq->rq_disk = bd_disk;
>>   	rq->end_io = done;
>>   
>> +	if (WARN_ON_ONCE(blk_rq_is_internal(rq))) {
>> +		blk_mq_end_request(rq, BLK_STS_NOTSUPP);
>> +		return;
>> +	}
>> +
>>   	blk_account_io_start(rq);

The whole concept seems very odd, and then there's this seemingly
randomly placed check and error condition. As I haven't seen the
actual use case for this, hard to make suggestions though.

-- 
Jens Axboe

