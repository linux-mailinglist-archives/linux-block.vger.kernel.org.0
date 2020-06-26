Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701B720AC8E
	for <lists+linux-block@lfdr.de>; Fri, 26 Jun 2020 08:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgFZGzt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 26 Jun 2020 02:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgFZGzs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 02:55:48 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BFFC08C5C1
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 23:55:48 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w16so8318074ejj.5
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 23:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=24b5gDylzuSdyKBvIpDVqbEw1/MYXNgLUKpTA8z0MWE=;
        b=Kqx1kT6UZOAW77lejOr7FDay+cq0DzqH5sUtObB13nvbH7Xi26tn55Hmmm6NB0XKi+
         LjEH+TFdXRHHDpWaRL0UBpi2Y4dqiy6W4yDtnOjbsph25kNKbzNZG6ACHQSklaGn2a6w
         Lxsx/oAcTovtQwwhnEB7BwR/vC8rEmc8IqZ7kDWyuPfNEpzc4TRNN1H2pUNJuKUiiei/
         EXj6I60Xl/scyZwBhYEvslCEOAIxVI/Ta76SVXnlbj7yLLEcjx7rVLDRBNK30AAXwe0w
         5GplKkYYolnJKgxiCmCLaK7VaogQkUNSu2hFVm0xnwBSpxs3hcg3oBcBTnOa0NM/qzv4
         TkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=24b5gDylzuSdyKBvIpDVqbEw1/MYXNgLUKpTA8z0MWE=;
        b=P3f81WybWegrNDDzpi3zSwbcmfrF9Cf1X27TBz1ZpKsvajJR0xghNFJfAG0+MMxJlS
         k1jpDXnYw0FrPO1DqcrRojY1oUYv2xjzxhoWqyIIB0oDQI6ixTaRaknJ2KQhlHe3B9tB
         YqT9eNBkWNSYy7dTHdqe74jAMj//HcoPo733VMAZtjeR7a0gvr0ONMENsnacLbZfe1Iy
         fT8wA2N7C/ic7G5FUWXeRURsM1JXhGqzhhpAHx+ysKtfVxAFohfG2w/KL2MyesI/NkDW
         Qr+N0M8nF+3U9C/YV+9+nISmoPmDpTuXRUIkQe68Jx2ViWjngt3crqmDDZSbv46o1V2C
         rZgA==
X-Gm-Message-State: AOAM531aJIQKnYp/Ji6ZlI9ATnYB0drHtgoRI4EV1DDKid9D9H6Mv0GT
        QcekvVKI8kA04DT3pLy9xIAOdg==
X-Google-Smtp-Source: ABdhPJys1/vocZCEORKXSfmdqU9cuvhxcgqTD4kZyktEJulCiXtYHgtGolOMluHFxgN0G6q0GuxDfw==
X-Received: by 2002:a17:906:add3:: with SMTP id lb19mr1287370ejb.308.1593154547182;
        Thu, 25 Jun 2020 23:55:47 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id l6sm20158305edn.42.2020.06.25.23.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 23:55:46 -0700 (PDT)
Date:   Fri, 26 Jun 2020 08:55:46 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 6/6] nvme: Add consistency check for zone count
Message-ID: <20200626065546.v266c3zjv2gjoycs@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-7-javier@javigon.com>
 <20200625214921.GA1773527@dhcp-10-100-145-180.wdl.wdc.com>
 <MWHPR04MB3758829D20916B73DDB5581EE7930@MWHPR04MB3758.namprd04.prod.outlook.com>
 <20200626061310.6invpvs2tzxfbida@mpHalley.localdomain>
 <CY4PR04MB375167CFC4E3CF22324C71B5E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR04MB375167CFC4E3CF22324C71B5E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26.06.2020 06:49, Damien Le Moal wrote:
>On 2020/06/26 15:13, Javier González wrote:
>> On 26.06.2020 00:04, Damien Le Moal wrote:
>>> On 2020/06/26 6:49, Keith Busch wrote:
>>>> On Thu, Jun 25, 2020 at 02:21:52PM +0200, Javier González wrote:
>>>>>  drivers/nvme/host/zns.c | 7 +++++++
>>>>>  1 file changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
>>>>> index 7d8381fe7665..de806788a184 100644
>>>>> --- a/drivers/nvme/host/zns.c
>>>>> +++ b/drivers/nvme/host/zns.c
>>>>> @@ -234,6 +234,13 @@ static int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>>>>>  		sector += ns->zsze * nz;
>>>>>  	}
>>>>>
>>>>> +	if (nr_zones < 0 && zone_idx != ns->nr_zones) {
>>>>> +		dev_err(ns->ctrl->device, "inconsistent zone count %u/%u\n",
>>>>> +				zone_idx, ns->nr_zones);
>>>>> +		ret = -EINVAL;
>>>>> +		goto out_free;
>>>>> +	}
>>>>> +
>>>>>  	ret = zone_idx;
>>>>
>>>> nr_zones is unsigned, so it's never < 0.
>>>>
>>>> The API we're providing doesn't require zone_idx equal the namespace's
>>>> nr_zones at the end, though. A subset of the total number of zones can
>>>> be requested here.
>>>>
>>
>> I did see nr_zones coming with -1; guess it is my compiler.
>
>See include/linux/blkdev.h. -1 is:
>
>#define BLK_ALL_ZONES  ((unsigned int)-1)
>
>Which is documented in block/blk-zoned.c:
>
>/**
> * blkdev_report_zones - Get zones information
> * @bdev:       Target block device
> * @sector:     Sector from which to report zones
> * @nr_zones:   Maximum number of zones to report
> * @cb:         Callback function called for each reported zone
> * @data:       Private data for the callback
> *
> * Description:
> *    Get zone information starting from the zone containing @sector for at most
> *    @nr_zones, and call @cb for each zone reported by the device.
> *    To report all zones in a device starting from @sector, the BLK_ALL_ZONES
> *    constant can be passed to @nr_zones.
> *    Returns the number of zones reported by the device, or a negative errno
> *    value in case of failure.
> *
> *    Note: The caller must use memalloc_noXX_save/restore() calls to control
> *    memory allocations done within this function.
> */
>int blkdev_report_zones(struct block_device *bdev, sector_t sector,
>                        unsigned int nr_zones, report_zones_cb cb, void *data)
>
>>
>>>
>>> Yes, absolutely. zone_idx is not an absolute zone number. It is the index of the
>>> reported zone descriptor in the current report range requested by the user,
>>> which is not necessarily for the entire drive (i.e., provided nr zones is less
>>> than the total number of zones of the disk and/or start sector is > 0). So
>>> zone_idx indicates the actual number of zones reported, it is not the total
>>
>> I see. As I can see, when nr_zones comes undefined I believed we could
>> assume that zone_idx is absolute, but I can be wrong.
>
>No. zone_idx is *always* the index of the zone in the current report. Whatever
>that report is, regardless of the report starting point and number of zones
>requested. E.g. For a single zone report (nr_zones = 1), you will always see
>zone_idx = 0. For a full report, zone_idx will correspond to the zone number.
>This is used for example in blk_revalidate_disk_zones() to initialize the zone
>bitmaps.
>
>> Does it make sense to support this check with an additional counter and
>> a explicit nr_zones initialization when undefined or you
>> prefer to just remove it as Matias suggested?
>
>The check is not needed at all.
>
>If the device is buggy and reports more zones than the device capacity or any
>other bugs, the driver can catch that when it processes the report.
>blk_revalidate_disk_zones() also has many checks.

I have managed to create a QEMU ZNS device that gave me a headache with
a little bit of extra capacity that triggered an additional zone report.
This was the motivation for the patch.

I will look at the checks to cover this case too then.

Thanks,
Javier
