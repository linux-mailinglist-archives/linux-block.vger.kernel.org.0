Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26F363E696
	for <lists+linux-block@lfdr.de>; Thu,  1 Dec 2022 01:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiLAAjQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 30 Nov 2022 19:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLAAjQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2022 19:39:16 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AC159FF7
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 16:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669855155; x=1701391155;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pgc+p5PDA6K847LjDI8dN8wGPApGRqqSYi2al8gE+q0=;
  b=I+rV0cL9qHoIhoP03Ls1rp92MCdqgnovyLxbY5cQ/jYVWNKM7K47WvhC
   EaA1vXXeV6jT9sfRvji3pu9KNZ80tmfAvhcKSRMppla53MTPuzHNg0MmG
   7pG5HYHCk/K3VenNUeWuoj4EoBZbiNrSZTiBgNO3ngnnB5RDLE/lVZmpR
   DD5OfOcYOGgXGA0F/aKYUOuuTj6J23wCbNyCiGzG4tmDiIj3jbtKhTgXZ
   iZ+JK4RKp9KlIxKojcDC2BfLhS+Y4z00OJrqmjeHvpk5I/3ob/3GobYFu
   5WLhQrQBqilM4fiq0EbkxEYY5taHH6JuwOZZOrkg0P1N/BluWogB4v3+U
   g==;
X-IronPort-AV: E=Sophos;i="5.96,207,1665417600"; 
   d="scan'208";a="215832918"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2022 08:39:14 +0800
IronPort-SDR: wbMHOYdjB5SfxWofrmPbvmlWvpO8Zhc7UQow3Is4IhHXYOM12Op092xVgxjoafhzsP573Mqp2v
 WZ8xBNkcOHoVMNPt2kAXn+9SDDSA8ngSvE2071IwwdtE487lz1bbOlM2VhME85LorJMnQU+Qt0
 t79TXGCNNmxB5xYn6tNdfJywgcIKpFf6IgrPzUtsV30Axew3OprKiInc23tgFSGT8foV6+eYoP
 G7sSrGPC/5oY1tG5Gj7a1bTX67+JONYsHSZODFLqPpeHdRb10oYS3+1M36B1INOw3RQYUS0vP8
 mQw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Nov 2022 15:57:53 -0800
IronPort-SDR: nneZChkC1ijduzvGaEPZHIkaRMNJvvwP1KCdkD15DIU5Zy0M8M5uhrfuS53gD0vYQYQGlW3EVv
 tawgQPzjHpq6a4Bo/sCztVtPVNuGAo4WJExIB/4+WGPCo9FEe753NeOX9ZD+xGiXmGEViQa9aF
 hlYvrXgJZeXHGnAD6zSjK6+g/7b8W0KXsLz4VXg9RSRtC4uKGuBrnmh1Xc3X5h/hcn0WDvgbpL
 RkgVFHBxsnT8jLfoQPP5a3/2HxHesAyEVsJcT1w8FsjI8YhRGSVQqNjEW6NVhR96PlrYAQpGrY
 vIE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Nov 2022 16:39:14 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NMxz62568z1RvTr
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 16:39:14 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1669855153; x=1672447154; bh=pgc+p5PDA6K847LjDI8dN8wGPApGRqqSYi2
        al8gE+q0=; b=tD6vpG7Z82qbE3CipPvSIVmkpkXKxKQB4BnoveZ9oe6iF4H/G10
        UIZ+gEeDpa0fIxUOB1FNa39KmJAZezf4rGNjBkmQLSSUzlrfb430U7rds+Jddjnj
        0cipDt7l+vIUMoRpR7jWrm+jIj7Y3liIQ0/DmzvkJnjcMfMf15MUUqbUL/ucXg9u
        YJ11ojvONMTbyZqWn+wIfXXRZSO5pcjwr0MpAe/JQz2dzwjFIcZpn6UAZhxxAC4a
        vxkLO239c1Og4IXYrxroOiZumh/Ik0Ewpd3m2Bm/IXRkva1vIxIgLA892oUjyjwB
        sDXayqD7kqFE5BBQe4jglUQa9PjzGyO7Wsg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vXoVIVedu27Q for <linux-block@vger.kernel.org>;
        Wed, 30 Nov 2022 16:39:13 -0800 (PST)
Received: from [10.225.163.66] (unknown [10.225.163.66])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NMxz36Dp3z1RvLy;
        Wed, 30 Nov 2022 16:39:11 -0800 (PST)
Message-ID: <687161b4-3e92-9fbf-c0a6-e8dceee3d250@opensource.wdc.com>
Date:   Thu, 1 Dec 2022 09:39:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 8/8] null_blk: Support configuring the maximum segment
 size
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
References: <20221123205740.463185-1-bvanassche@acm.org>
 <20221123205740.463185-9-bvanassche@acm.org>
 <32feb681-e858-1a0c-b91d-3f0d85615a6d@opensource.wdc.com>
 <6c41f85b-7add-60d7-e131-71c3cfae80d0@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <6c41f85b-7add-60d7-e131-71c3cfae80d0@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/1/22 07:29, Bart Van Assche wrote:
> On 11/23/22 17:40, Damien Le Moal wrote:
>> On 11/24/22 05:57, Bart Van Assche wrote:
>>> +static unsigned int g_max_segment_size = 1UL << 31;
>>
>> 1UL is unsigned long be this var is unsigned int. Why not simply use
>> UINT_MAX here ? You prefer the 2GB value ? If yes, then may be at least
>> change that to "1U << 31", no ?
>>
>> [ ... ]
>>> @@ -2106,6 +2119,7 @@ static int null_add_dev(struct nullb_device *dev)
>>>   	dev->max_sectors = min_t(unsigned int, dev->max_sectors,
>>>   				 BLK_DEF_MAX_SECTORS);
>>>   	blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);
>>> +	blk_queue_max_segment_size(nullb->q, dev->max_segment_size);
>>
>> Should we keep the ability to use the kernel default value as the default
>> here ?
>> E.g.
>>
>> 	if (dev->max_segment_size)
>> 		blk_queue_max_segment_size(nullb->q,
>> 				dev->max_segment_size);
>>
>> If yes, then g_max_segment_size initial value should be 0, meaning "kernel
>> default".
> 
> Hi Damien,
> 
> How about changing the default value for g_max_segment_size from
> 1UL << 31 into BLK_MAX_SEGMENT_SIZE? That will simplify the code and 
> also prevents that this patch changes the behavior of the null_blk 
> driver if g_max_segment_size is not modified by the user.

Sounds good to me.

> 
> Thanks,
> 
> Bart.
> 

-- 
Damien Le Moal
Western Digital Research

