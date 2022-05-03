Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3F2518A48
	for <lists+linux-block@lfdr.de>; Tue,  3 May 2022 18:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239728AbiECQq6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 3 May 2022 12:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239702AbiECQq6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 May 2022 12:46:58 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF022C138
        for <linux-block@vger.kernel.org>; Tue,  3 May 2022 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651596204; x=1683132204;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gtowxbHk/V4v64RtsKyaAcMJzf5VQm5Xqlz1mGZPWVc=;
  b=GGFmBHyjanv/U0u8ziVcXoKadgkfIzkW/w4DwYkHl80JPIqpDEFXxo5a
   cZLcL2SUc/4JkwoHwaRPrZGZ6321YXooXFxSvDID8LY0khQZ865Z3ORbF
   IGQXkfEBx+1NE1uWdIZWYi4PGB0877dGNL+8Iio1XZ0igcvoBptBF09Dc
   OE4W1YEhbyNxIpDKyjllklGwLeIN0n2JKF808teYcanHWkj9dmW/1satx
   yIXgrUbFYhI7yswDuLXEc1LEoLv8ETZOc+y9f/5VDZoD82eMucmX07dQ7
   rZAIMkk7xr3W//12tt2jqqmg5aPmZwkdZaiOjZ3hZaRYMNLxHByHMVasr
   w==;
X-IronPort-AV: E=Sophos;i="5.91,195,1647273600"; 
   d="scan'208";a="204304549"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2022 00:43:24 +0800
IronPort-SDR: 7UyyfiVw5EBB3lwK/Jpt4cxIhAJ4coplV3kVmsotenuts7+GTb6+IvvL1XR5dMYXV/O2cuhgjS
 oCzFjseEJfX7nj5tZhzsAYXeCqlxTbMWECxE1COJl78tW6DZFdN7Qt0ApI3djRNi9WZL9XrNgt
 lH571kakkyxQ7+oKHLKqkVOkLKYZr/qLoouF/RJTg16S/v8Oai28eaF/Z4oyi0wCCXcICvuFuF
 Ydk4f4jrrwC4fv7KY9SYao5BQFmjJN4nFKzVxgGzC2wRkwpusI7cBpv0CBQS1ddOWKKyvOHimc
 fswtsUPm9nQICTe45ypx0smM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 May 2022 09:14:08 -0700
IronPort-SDR: HEyd9SpzQMma9KW5WvK6ybz8AT6lMvgH4AmEc3+nrYr+AT2rCJp3dhr6vOBihLAsm8qrz7QuVy
 lH5LrSRwtvhKNvCq/3nZYfJtOg5bIKwWBkf9HCyFfEzKgl7+VPIkiKln7IhleIO5SfZmr3FvKb
 ZrL9RyvQo1j6b909TZah43nvizmTOK8cHUVwmN22xO+kBpZUUrPGfDiZzUkvTurxt/3zttBUIp
 +oAuHCjFnyemiOhtmz19ff+2enrmVcg3THwHr/OK7/FWsXQQ/fu1pNx/tZtpXgyzWhJzbWPw9i
 hus=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 May 2022 09:43:25 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kt5PS0hLhz1SVny
        for <linux-block@vger.kernel.org>; Tue,  3 May 2022 09:43:24 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651596202; x=1654188203; bh=gtowxbHk/V4v64RtsKyaAcMJzf5VQm5Xqlz
        1mGZPWVc=; b=Ityt6SU6TevwYDEz6MSmerOiufvkNZb2RIhnCnh/ZzJetTfhCg1
        T2xnTAstXa6+Ux9X2hffUZ60DlE6LuATHx09TQlSTEyF7xbXDspT5fE2m7o1saXk
        MsfXOxTR1OWaHqY/5UwRsV92T41rLy/lvWZXfBA8RCgHqYpGkO7HkepzxgPEd0IS
        4TRsTkM5OD6EvKA9wrLXkqM2gLGZOlrZHM78kWu3x6V0E18uYRfRzzagItYzWXSW
        JSBcD3u1LzWPwvIazUKiZH8E9Nd04PQVh3LjktI2Mbdf2b5RDfBKfwP7DQmDJsGE
        VucI8+dA13DJavMELzscR9PAFibWA0na59Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZUz5S2IWK_6o for <linux-block@vger.kernel.org>;
        Tue,  3 May 2022 09:43:22 -0700 (PDT)
Received: from [10.225.81.200] (hq6rw33.ad.shared [10.225.81.200])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kt5PN0Cqnz1Rvlc;
        Tue,  3 May 2022 09:43:19 -0700 (PDT)
Message-ID: <2c275ab0-c813-22ae-16e3-b16885d06c4c@opensource.wdc.com>
Date:   Wed, 4 May 2022 01:43:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH 01/16] block: make blkdev_nr_zones and blk_queue_zone_no
 generic for npo2 zsze
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
        axboe@kernel.dk, snitzer@kernel.org, hch@lst.de, mcgrof@kernel.org,
        naohiro.aota@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        johannes.thumshirn@wdc.com
Cc:     linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        clm@fb.com, gost.dev@samsung.com, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, josef@toxicpanda.com,
        jonathan.derrick@linux.dev, agk@redhat.com, kbusch@kernel.org,
        kch@nvidia.com, linux-nvme@lists.infradead.org,
        dm-devel@redhat.com, jiangbo.365@bytedance.com,
        linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
        linux-block@vger.kernel.org
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160257eucas1p21fb58d0129376a135fdf0b9c2fe88895@eucas1p2.samsung.com>
 <20220427160255.300418-2-p.raghav@samsung.com>
 <3a178153-62c0-e298-ccb0-0edfd41b7ee2@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <3a178153-62c0-e298-ccb0-0edfd41b7ee2@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/05/04 1:37, Bart Van Assche wrote:
> On 4/27/22 09:02, Pankaj Raghav wrote:
>> Adapt blkdev_nr_zones and blk_queue_zone_no function so that it can
>> also work for non-power-of-2 zone sizes.
>>
>> As the existing deployments of zoned devices had power-of-2
>> assumption, power-of-2 optimized calculation is kept for those devices.
>>
>> There are no direct hot paths modified and the changes just
>> introduce one new branch per call.
>>
>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> ---
>>   block/blk-zoned.c      | 8 +++++++-
>>   include/linux/blkdev.h | 8 +++++++-
>>   2 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>> index 38cd840d8838..1dff4a8bd51d 100644
>> --- a/block/blk-zoned.c
>> +++ b/block/blk-zoned.c
>> @@ -117,10 +117,16 @@ EXPORT_SYMBOL_GPL(__blk_req_zone_write_unlock);
>>   unsigned int blkdev_nr_zones(struct gendisk *disk)
>>   {
>>   	sector_t zone_sectors = blk_queue_zone_sectors(disk->queue);
>> +	sector_t capacity = get_capacity(disk);
>>   
>>   	if (!blk_queue_is_zoned(disk->queue))
>>   		return 0;
>> -	return (get_capacity(disk) + zone_sectors - 1) >> ilog2(zone_sectors);
>> +
>> +	if (is_power_of_2(zone_sectors))
>> +		return (capacity + zone_sectors - 1) >>
>> +		       ilog2(zone_sectors);
>> +
>> +	return div64_u64(capacity + zone_sectors - 1, zone_sectors);
>>   }
>>   EXPORT_SYMBOL_GPL(blkdev_nr_zones);
> 
> Does anyone need support for more than 4 billion sectors per zone? If 
> not, do_div() should be sufficient.
> 
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 60d016138997..c4e4c7071b7b 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -665,9 +665,15 @@ static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
>>   static inline unsigned int blk_queue_zone_no(struct request_queue *q,
>>   					     sector_t sector)
>>   {
>> +	sector_t zone_sectors = blk_queue_zone_sectors(q);
>> +
>>   	if (!blk_queue_is_zoned(q))
>>   		return 0;
>> -	return sector >> ilog2(q->limits.chunk_sectors);
>> +
>> +	if (is_power_of_2(zone_sectors))
>> +		return sector >> ilog2(zone_sectors);
>> +
>> +	return div64_u64(sector, zone_sectors);
>>   }
> 
> Same comment here.

sector_t is 64-bits even on 32-bits arch, no ?
so div64_u64 is needed here I think, which will be a simple regular division for
64-bit arch.

> 
> Thanks,
> 
> Bart.


-- 
Damien Le Moal
Western Digital Research
