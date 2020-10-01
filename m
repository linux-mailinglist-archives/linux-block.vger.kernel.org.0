Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7842E27F95A
	for <lists+linux-block@lfdr.de>; Thu,  1 Oct 2020 08:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgJAGOy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 1 Oct 2020 02:14:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:63039 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgJAGOy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Oct 2020 02:14:54 -0400
IronPort-SDR: mtdpLrjVCvM0zxb5KIqib2ZHn7/xXyIi36J2BnHPBC45E802E6LcpwOICRE7r4qsOsnu62hwTb
 1kfnvGBLboXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="247360807"
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="247360807"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 23:14:51 -0700
IronPort-SDR: Kw8OL9GB7bZvImxOzpFI6w+PPa2RTVwRv8IQ8FtfookSqgQZbnBi+egsocVTgvUmVppGs+Zlxl
 iYZh47glhksA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="457977689"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.190]) ([10.237.72.190])
  by orsmga004.jf.intel.com with ESMTP; 30 Sep 2020 23:14:46 -0700
Subject: Re: [PATCH] mmc: core: don't set limits.discard_granularity as 0
To:     Coly Li <colyli@suse.de>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Vicente Bergas <vicencb@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20200930160854.65710-1-colyli@suse.de>
 <5178b9e0-6b95-45ef-80f1-862de554e625@intel.com>
 <026e4bab-5d1d-50b9-29c4-e871fcd27b8b@suse.de>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3cc59ace-d4b5-d10b-05a0-8677c95515ff@intel.com>
Date:   Thu, 1 Oct 2020 09:14:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <026e4bab-5d1d-50b9-29c4-e871fcd27b8b@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/10/20 7:36 am, Coly Li wrote:
> On 2020/10/1 01:23, Adrian Hunter wrote:
>> On 30/09/20 7:08 pm, Coly Li wrote:
>>> In mmc_queue_setup_discard() the mmc driver queue's discard_granularity
>>> might be set as 0 (when card->pref_erase > max_discard) while the mmc
>>> device still declares to support discard operation. This is buggy and
>>> triggered the following kernel warning message,
>>>
>>> WARNING: CPU: 0 PID: 135 at __blkdev_issue_discard+0x200/0x294
>>> CPU: 0 PID: 135 Comm: f2fs_discard-17 Not tainted 5.9.0-rc6 #1
>>> Hardware name: Google Kevin (DT)
>>> pstate: 00000005 (nzcv daif -PAN -UAO BTYPE=--)
>>> pc : __blkdev_issue_discard+0x200/0x294
>>> lr : __blkdev_issue_discard+0x54/0x294
>>> sp : ffff800011dd3b10
>>> x29: ffff800011dd3b10 x28: 0000000000000000 x27: ffff800011dd3cc4 x26: ffff800011dd3e18 x25: 000000000004e69b x24: 0000000000000c40 x23: ffff0000f1deaaf0 x22: ffff0000f2849200 x21: 00000000002734d8 x20: 0000000000000008 x19: 0000000000000000 x18: 0000000000000000 x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000 x14: 0000000000000394 x13: 0000000000000000 x12: 0000000000000000 x11: 0000000000000000 x10: 00000000000008b0 x9 : ffff800011dd3cb0 x8 : 000000000004e69b x7 : 0000000000000000 x6 : ffff0000f1926400 x5 : ffff0000f1940800 x4 : 0000000000000000 x3 : 0000000000000c40 x2 : 0000000000000008 x1 : 00000000002734d8 x0 : 0000000000000000 Call trace:
>>> __blkdev_issue_discard+0x200/0x294
>>> __submit_discard_cmd+0x128/0x374
>>> __issue_discard_cmd_orderly+0x188/0x244
>>> __issue_discard_cmd+0x2e8/0x33c
>>> issue_discard_thread+0xe8/0x2f0
>>> kthread+0x11c/0x120
>>> ret_from_fork+0x10/0x1c
>>> ---[ end trace e4c8023d33dfe77a ]---
>>>
>>> This patch fixes the issue by setting discard_granularity as SECTOR_SIZE
>>> instead of 0 when (card->pref_erase > max_discard) is true. Now no more
>>> complain from __blkdev_issue_discard() for the improper value of discard
>>> granularity.
>>>
>>> Fixes: commit e056a1b5b67b ("mmc: queue: let host controllers specify maximum discard timeout")
>>
>> That "Fixes" tag is a bit misleading.  For some time, the block layer had
>> no problem with discard_granularity of zero, and blk_bio_discard_split()
>> still doesn't (see below).
>>
>> static struct bio *blk_bio_discard_split(struct request_queue *q,
>> 					 struct bio *bio,
>> 					 struct bio_set *bs,
>> 					 unsigned *nsegs)
>> {
>> 	unsigned int max_discard_sectors, granularity;
>> 	int alignment;
>> 	sector_t tmp;
>> 	unsigned split_sectors;
>>
>> 	*nsegs = 1;
>>
>> 	/* Zero-sector (unknown) and one-sector granularities are the same.  */
>> 	granularity = max(q->limits.discard_granularity >> 9, 1U);
>>
> 
>>From Documentation/block/queue-sysfs.rst, the discard_granularity is
> described as,
> 
> discard_granularity (RO)
> ------------------------
> This shows the size of internal allocation of the device in bytes, if
> reported by the device. A value of '0' means device does not support
> the discard functionality.
> 
> 
> And from Documentation/ABI/testing/sysfs-block, the discard_granularity
> is described as,
> 
> What:           /sys/block/<disk>/queue/discard_granularity
> Date:           May 2011
> Contact:        Martin K. Petersen <martin.petersen@oracle.com>
> Description:
>                 Devices that support discard functionality may
>                 internally allocate space using units that are bigger
>                 than the logical block size. The discard_granularity
>                 parameter indicates the size of the internal allocation
>                 unit in bytes if reported by the device. Otherwise the
>                 discard_granularity will be set to match the device's
>                 physical block size. A discard_granularity of 0 means
>                 that the device does not support discard functionality.
> 
> 
> Therefore I took it as a bug when a driver sets its queue
> discard_granularity as 0 but still announces to support discard operation.
> 
> But if you don't like the Fixes: tag, it is OK for me to remove it in
> next version.

Not at all.  I just wrote "a bit misleading" because people might also want
to know from what patch things stopped working.

> 
> (CC Martin because he is the origin of the above information)
> 
> Thanks.
> 
> Coly Li
> 

