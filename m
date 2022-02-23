Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F078B4C06E1
	for <lists+linux-block@lfdr.de>; Wed, 23 Feb 2022 02:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbiBWBaE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Feb 2022 20:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbiBWBaD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 20:30:03 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EBC49FAB
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 17:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645579775; x=1677115775;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nSHdp0a4GmD+jXxAqqT79DZ6hE1s0OTI3GXP9NWFpG4=;
  b=Kb+HqX7AHZrZ1ImzNv9RCnuDg+322JEEr2d1OwKgNUa2F4KzjRSUGmPS
   SQGggy2PXqg1aocHtqTunpeWL2RLcdjhsQ7PyHiHmxSAXTnMk49OYXuxB
   N4tDywGkEHbbU6FlZmx+1g/ovKP5prZhNL8pos3uqOEk59YcTmWswF6Lo
   vPnMAtOW/peHYDRiLcVU2uayyeNdvTr7cKEk/Jc6LIelLkrXeRD1xekRS
   uBNEDMLST2qB0ES8WB+VvnzZK0WUak+GAeSAchLyJ6Q1nQaxawju2BiaN
   bjTQuT3r49Nd/NBSHIKCGHJYlL6Hk5XzEs8K660kTpDMi4tEFAQdwcFy5
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,389,1635177600"; 
   d="scan'208";a="305621090"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2022 09:29:27 +0800
IronPort-SDR: pcmFT/ldJY1o6HaVDwY2hA0E0u7XqZ/cA3J+Hav53aUcXx0Zon7CnQu7GM5uFEVXThZnjcY9HS
 BDyNOyL9WhNj9QDtb35AqaVUToAeoMmMtpeG8sh6pEmt+XEzwQsCga2c1/BtmoPMRlqeYbXaxU
 DORo1xsLUpHhr1dtkYmz68JI9t8fuWx2ffjHSo/Q9BhXKe46BdCcZ+gX/fUVw++DXZeu0J7Ul/
 L/xPzfzH0qOYBxeU0WWGEXJumV/UHNcLKd2a/0BEx9RwBGXyt/DmgxVB8aqphgITs/nz2Mx71h
 3oa28BzXl/QT1epgDMWqBhEX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 17:02:05 -0800
IronPort-SDR: Bc9b+jf2dL4Kpa8X+yxWnaS59sGTenx0yXd2C7g8CTg6HTfMz+ECYlhWaZ+h2xF/l67utwqkqE
 sMiBB3/SliewqhJbvuZ25LrKajjcfAMMjLcQKqcAJpecDrFHv+HXKOpY8szg1e+00Q1Splr5KR
 m6GTgu5FstLS2rnDx0mqAwx2QZu6UAwgjyAeOHpk4xLxnWaS1Sp0ZSKG1fYNZ0V3VrG5+jlWXQ
 6tz84TF23IFUzZLLS4DXIxXvxGUBhRCgw6tc3h1EKx7d96e9Yk/KbDBCU0di54tKVa80muj6zQ
 GUw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 17:29:28 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K3JNk6nQYz1SVp9
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 17:29:26 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645579766; x=1648171767; bh=nSHdp0a4GmD+jXxAqqT79DZ6hE1s0OTI3GX
        P9NWFpG4=; b=KKQVRAyjau51Pr3UeBfi5TuayEPGl++8gnnXlp2g8aNDH6xeOvW
        U918Vy4SwenFuFF97KR2qLFDtoyJBtfphmAwLab247cfnberH6iiUD3dycLIpt6t
        sIDCi6XfagreGWjzq9T7wNbZGtCf+l6+EmtwJRUTOpGVnYbmIJlzwwoP5zqknv2S
        VEyGa5CaA6qAaKi3/GPnVIdGL7Zisv7gCccVmKT0COg0gMsGh9ZA+yZiQxrnDxIC
        ktsRh2afLTZIvPcntL1GAH5Yt4xLheVnrWrw3baxC8UakDHI5XXOmJDGadGvQyYJ
        WMmDdFKJkSF3FCBu0qcFds0P3w2kS1oapRw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id F09kUK0x8KAF for <linux-block@vger.kernel.org>;
        Tue, 22 Feb 2022 17:29:26 -0800 (PST)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K3JNb3h1Dz1Rvlx;
        Tue, 22 Feb 2022 17:29:19 -0800 (PST)
Message-ID: <98ddab1b-6702-f121-9fef-0ce185888a1a@opensource.wdc.com>
Date:   Wed, 23 Feb 2022 10:29:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 02/10] block: Introduce queue limits for copy-offload
 support
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Nitesh Shetty <nj.shetty@samsung.com>
Cc:     hch@lst.de, javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        nitheshshetty@gmail.com, SelvaKumar S <selvakuma.s1@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
References: <20220214080002.18381-1-nj.shetty@samsung.com>
 <CGME20220214080605epcas5p16868dae515a6355cf9fecf22df4f3c3d@epcas5p1.samsung.com>
 <20220214080002.18381-3-nj.shetty@samsung.com>
 <20220217090700.b7n33vbkx5s4qbfq@garbanzo> <20220217125901.GA3781@test-zns>
 <YhWGDUyQkUcE6itt@bombadil.infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YhWGDUyQkUcE6itt@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/23/22 09:55, Luis Chamberlain wrote:
> On Thu, Feb 17, 2022 at 06:29:01PM +0530, Nitesh Shetty wrote:
>>  Thu, Feb 17, 2022 at 01:07:00AM -0800, Luis Chamberlain wrote:
>>> The subject says limits for copy-offload...
>>>
>>> On Mon, Feb 14, 2022 at 01:29:52PM +0530, Nitesh Shetty wrote:
>>>> Add device limits as sysfs entries,
>>>>         - copy_offload (RW)
>>>>         - copy_max_bytes (RW)
>>>>         - copy_max_hw_bytes (RO)
>>>>         - copy_max_range_bytes (RW)
>>>>         - copy_max_range_hw_bytes (RO)
>>>>         - copy_max_nr_ranges (RW)
>>>>         - copy_max_nr_ranges_hw (RO)
>>>
>>> Some of these seem like generic... and also I see a few more max_hw ones
>>> not listed above...
>>>
>> queue_limits and sysfs entries are differently named.
>> All sysfs entries start with copy_* prefix. Also it makes easy to lookup
>> all copy sysfs.
>> For queue limits naming, I tried to following existing queue limit
>> convention (like discard).
> 
> My point was that your subject seems to indicate the changes are just
> for copy-offload, but you seem to be adding generic queue limits as
> well. Is that correct? If so then perhaps the subject should be changed
> or the patch split up.
> 
>>>> +static ssize_t queue_copy_offload_store(struct request_queue *q,
>>>> +				       const char *page, size_t count)
>>>> +{
>>>> +	unsigned long copy_offload;
>>>> +	ssize_t ret = queue_var_store(&copy_offload, page, count);
>>>> +
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	if (copy_offload && !q->limits.max_hw_copy_sectors)
>>>> +		return -EINVAL;
>>>
>>>
>>> If the kernel schedules, copy_offload may still be true and
>>> max_hw_copy_sectors may be set to 0. Is that an issue?
>>>
>>
>> This check ensures that, we dont enable offload if device doesnt support
>> offload. I feel it shouldn't be an issue.
> 
> My point was this:
> 
> CPU1                                       CPU2
> Time
> 1) if (copy_offload 
> 2)    ---> preemption so it schedules      
> 3)    ---> some other high priority task  Sets q->limits.max_hw_copy_sectors to 0
> 4) && !q->limits.max_hw_copy_sectors)
> 
> Can something bad happen if we allow for this?

max_hw_copy_sectors describes the device capability to offload copy. So
this is read-only and "max_hw_copy_sectors != 0" means that the device
supports copy offload (this attribute should really be named
max_hw_copy_offload_sectors).

The actual loop to issue copy offload BIOs, however, must use the soft
version of the attribute: max_copy_sectors, which defaults to
max_hw_copy_sectors if copy offload is truned on and I guess to
max_sectors for the emulation case.

Now, with this in mind, I do not see how allowing max_copy_sectors to be
0 makes sense. I fail to see why that should be allowed since:
1) If copy_offload is true, we will rely on the device and chunk copy
offload BIOs up to max_copy_sectors
2) If copy_offload is false (or device does not support it), emulation
will be used by issuing read/write BIOs of up to max_copy_sectors.

Thus max_copy_sectors must always be at least equal to the device
minimum IO size, that is, the logical block size.


-- 
Damien Le Moal
Western Digital Research
