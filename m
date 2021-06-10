Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256683A2247
	for <lists+linux-block@lfdr.de>; Thu, 10 Jun 2021 04:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhFJCcy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 9 Jun 2021 22:32:54 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5473 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFJCcx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 22:32:53 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G0nvV0LfQzZfHM;
        Thu, 10 Jun 2021 10:28:06 +0800 (CST)
Received: from dggpeml500009.china.huawei.com (7.185.36.209) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 10:30:56 +0800
Received: from [10.174.179.197] (10.174.179.197) by
 dggpeml500009.china.huawei.com (7.185.36.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 10:30:55 +0800
Subject: Re: [PATCH] block: check disk exist before trying to add partition
To:     Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <jack@suse.cz>, <hare@suse.de>,
        <ming.lei@redhat.com>, <damien.lemoal@wdc.com>
References: <20210608092707.1062259-1-yuyufen@huawei.com>
 <8e7e4b2a-b0e2-9830-e2bc-cbc6e9fd7b41@kernel.dk>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <1221eb2f-d778-755e-f69f-58ce549c5771@huawei.com>
Date:   Thu, 10 Jun 2021 10:30:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <8e7e4b2a-b0e2-9830-e2bc-cbc6e9fd7b41@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.197]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500009.china.huawei.com (7.185.36.209)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/6/9 5:08, Jens Axboe wrote:
> On 6/8/21 3:27 AM, Yufen Yu wrote:
>> If disk have been deleted, we should return fail for ioctl
>> BLKPG_DEL_PARTITION. Otherwise, the directory /sys/class/block
>> may remain invalid symlinks file. The race as following:
>>
>> blkdev_open
>> 				del_gendisk
>> 				    disk->flags &= ~GENHD_FL_UP;
>> 				    blk_drop_partitions
>> blkpg_ioctl
>>      bdev_add_partition
>>      add_partition
>>          device_add
>> 	    device_add_class_symlinks
>>
>> ioctl may add_partition after del_gendisk() have tried to delete
>> partitions. Then, symlinks file will be created.
> 
> Let's do this for 5.14, which means send it against for-5.14/block
> please. Thanks.
> 

OK, I have send v2 for 5.14/block.
https://lore.kernel.org/linux-block/20210610023241.3646241-1-yuyufen@huawei.com/T/#u

Thanks,
Yufen
