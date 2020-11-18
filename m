Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7E02B7F4A
	for <lists+linux-block@lfdr.de>; Wed, 18 Nov 2020 15:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgKROUW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 18 Nov 2020 09:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgKROUW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Nov 2020 09:20:22 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0695C0613D4
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2020 06:20:21 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id s13so2878370wmh.4
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2020 06:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JW3TkOImH+F1ZGDgSHkXSBF53096a0/tudnvlTY6JYs=;
        b=auIqFm49Kta4yuE4nEjh/rHi4s9yksFEXwlAu6G+x3Ba8lmjvKD5bRRnVDKuo5qO+w
         J/utdVSgCxpjQsr+qa7wLuBiEMuYTKnSWmaFeSnslnCEhWhuUBKAAcK8BkJ+M4GiVpaL
         4+ZJW3IQzpDI3VxCUUBo0doV1bJqPJBk2xeNYF8ICXtsHHdXHTQrPXla6nOo2P2HVvqs
         53ZDdaIFnSdIWVON8VdzXywD5jq0+OFlg4D9GCq2HFA6W2X8BeBdfCRonhWiDI79RrZ/
         Y8Sor7e96+C+b+B8QS3ITrAtz0kUYBx7Zl1SkvB1mvzIbmPBNznLz+JcWSIqB53rNAcP
         FwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JW3TkOImH+F1ZGDgSHkXSBF53096a0/tudnvlTY6JYs=;
        b=NYpKdButqURnEpg69eGhzaEL4KIvsksOMqgbFx4HTNK3+6yWm5vUaDHgCrwGhUFPjf
         AHuE1yydkmRBXl5wE2QNk2D+LSn6tmFUVe40whLFyPdHqiokVqU0ehn2LT020ozZZy9j
         qsHzo4/hLPQOysIYUMBrLORjbo2Fxj45lSGqgwWtap1gZU3iyXHtSYALuPK/gvOvEheV
         MYK9ExIQbKsAMiPzGG1sK0zt8e5CPWnfWLozyCrxnUnhA5f4VT28rWYXAa+IjmlxTGs5
         Joz7brNFe7BzWA+7OTqQ1XK5gytykv6K/53uNaihUOVAZeRaYiDZfUht5ZL5NigAb+7Q
         8srg==
X-Gm-Message-State: AOAM531e9e/kaH/ZJmmGRUm09yclnXU9GKjo/ElUKPd/4YeFqpvL28ks
        /EVhosCkVJWZxvDjnjtarHU=
X-Google-Smtp-Source: ABdhPJwL3U45e+MSJN4/LxlBJYMjRjxeZXpP4Q+CoQvpZU0t4w3JUcRBuXJucWLnBpoUGvH0nSgiDA==
X-Received: by 2002:a7b:cb82:: with SMTP id m2mr256832wmi.75.1605709220528;
        Wed, 18 Nov 2020 06:20:20 -0800 (PST)
Received: from [192.168.1.125] (host109-152-100-135.range109-152.btcentralplus.com. [109.152.100.135])
        by smtp.gmail.com with ESMTPSA id u5sm28753296wro.56.2020.11.18.06.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 06:20:19 -0800 (PST)
To:     dongjoo seo <commisori28@gmail.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sbates@raithlin.com" <sbates@raithlin.com>
References: <20201118004746.GA29180@dongjoo-desktop>
 <20201118070714.GA3786@infradead.org>
 <BL0PR04MB65144A3EE2C24C430347AEBCE7E10@BL0PR04MB6514.namprd04.prod.outlook.com>
 <310b9d38-1dde-b74e-f68f-32e8c7148336@gmail.com>
 <7F6FFFCB-3FD1-4A7B-8D30-FF4BBAD4AEA4@gmail.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH] blk-mq: modify hybrid sleep time to aggressive
Message-ID: <dd1fa6ef-0730-37d6-d3a8-50a3b98e2e6a@gmail.com>
Date:   Wed, 18 Nov 2020 14:17:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <7F6FFFCB-3FD1-4A7B-8D30-FF4BBAD4AEA4@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18/11/2020 10:35, dongjoo seo wrote:
> I agree with your opinion. And your patch is also good approach.
> How about combine it? Adaptive solution with 3/4.

I couldn't disclose numbers back then, but thanks to a steep skewed
latency distribution of NAND/SSDs, it actually was automatically
adjusting it to ~3/4 for QD1 and long enough requests (~75+ us).
Also, if "max(sleep_ns, half_mean)" is removed, it was keeping the
time below 1/2 for fast requests (less than ~30us), and that is a
good thing because it was constantly oversleeping them.
Though new ultra low-latency SSDs came since then.

The real problem is to find anyone who actually uses it, otherwise
it's just a chunk of dead code. Do you? Anyone? I remember once it
was completely broken for months, but that was barely noticed.


> Because, if we get the intensive workloads then we need to 
> decrease the whole cpu utilization even with [1].
> 
> [1] https://lkml.org/lkml/2019/4/30/117 <https://lkml.org/lkml/2019/4/30/117>
> 
>> On Nov 18, 2020, at 6:26 PM, Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 18/11/2020 07:16, Damien Le Moal wrote:
>>> On 2020/11/18 16:07, Christoph Hellwig wrote:
>>>> Adding Damien who wrote this code.
>>>
>>> Nope. It wasn't me. I think it was Stephen Bates:
>>>
>>> commit 720b8ccc4500 ("blk-mq: Add a polling specific stats function")
>>>
>>> So +Stephen.
>>>>
>>>> On Wed, Nov 18, 2020 at 09:47:46AM +0900, Dongjoo Seo wrote:
>>>>> Current sleep time for hybrid polling is half of mean time.
>>>>> The 'half' sleep time is good for minimizing the cpu utilization.
>>>>> But, the problem is that its cpu utilization is still high.
>>>>> this patch can help to minimize the cpu utilization side.
>>
>> This won't work well. When I was experimenting I saw that half mean
>> is actually is too much for fast enough requests, like <20us 4K writes,
>> it's oversleeping them. Even more I'm afraid of getting in a vicious
>> cycle, when oversleeping increases statistical mean, that increases
>> sleep time, that again increases stat mean, and so on. That what
>> happened for me when the scheme was too aggressive.
>>
>> I actually sent once patches [1] for automatic dynamic sleep time
>> adjustment, but nobody cared.
>>
>> [1] https://lkml.org/lkml/2019/4/30/117 <https://lkml.org/lkml/2019/4/30/117>
>>
>>>>>
>>>>> Below 1,2 is my test hardware sets.
>>>>>
>>>>> 1. Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz + Samsung 970 pro 1Tb
>>>>> 2. Intel(R) Core(TM) i7-5820K CPU @ 3.30GHz + INTEL SSDPED1D480GA 480G
>>>>>
>>>>>        |  Classic Polling | Hybrid Polling  | this Patch
>>>>> -----------------------------------------------------------------
>>>>>        cpu util | IOPS(k) | cpu util | IOPS | cpu util | IOPS  |
>>>>> -----------------------------------------------------------------
>>>>> 1.       99.96   |   491   |  56.98   | 467  | 35.98    | 442   |
>>>>> -----------------------------------------------------------------
>>>>> 2.       99.94   |   582   |  56.3    | 582  | 35.28    | 582   |
>>>>>
>>>>> cpu util means that sum of sys and user util.
>>>>>
>>>>> I used 4k rand read for this test.
>>>>> because that case is worst case of I/O performance side.
>>>>> below one is my fio setup.
>>>>>
>>>>> name=pollTest
>>>>> ioengine=pvsync2
>>>>> hipri
>>>>> direct=1
>>>>> size=100%
>>>>> randrepeat=0
>>>>> time_based
>>>>> ramp_time=0
>>>>> norandommap
>>>>> refill_buffers
>>>>> log_avg_msec=1000
>>>>> log_max_value=1
>>>>> group_reporting
>>>>> filename=/dev/nvme0n1
>>>>> [rd_rnd_qd_1_4k_1w]
>>>>> bs=4k
>>>>> iodepth=32
>>>>> numjobs=[num of cpus]
>>>>> rw=randread
>>>>> runtime=60
>>>>> write_bw_log=bw_rd_rnd_qd_1_4k_1w
>>>>> write_iops_log=iops_rd_rnd_qd_1_4k_1w
>>>>> write_lat_log=lat_rd_rnd_qd_1_4k_1w
>>>>>
>>>>> Thanks
>>>>>
>>>>> Signed-off-by: Dongjoo Seo <commisori28@gmail.com>
>>>>> ---
>>>>> block/blk-mq.c | 3 +--
>>>>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>>> index 1b25ec2fe9be..c3d578416899 100644
>>>>> --- a/block/blk-mq.c
>>>>> +++ b/block/blk-mq.c
>>>>> @@ -3749,8 +3749,7 @@ static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
>>>>> 		return ret;
>>>>>
>>>>> 	if (q->poll_stat[bucket].nr_samples)
>>>>> -		ret = (q->poll_stat[bucket].mean + 1) / 2;
>>>>> -
>>>>> +		ret = (q->poll_stat[bucket].mean + 1) * 3 / 4;
>>>>> 	return ret;
>>>>> }
>>>>>
>>>>> -- 
>>>>> 2.17.1
>>>>>
>>>> ---end quoted text---
>>>>
>>>
>>>
>>
>> -- 
>> Pavel Begunkov
> 
> 

-- 
Pavel Begunkov
