Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0421F638F
	for <lists+linux-block@lfdr.de>; Thu, 11 Jun 2020 10:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgFKI1u (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 11 Jun 2020 04:27:50 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2297 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726623AbgFKI1u (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 04:27:50 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id E48EA95E10717449BC20;
        Thu, 11 Jun 2020 09:27:48 +0100 (IST)
Received: from [127.0.0.1] (10.210.169.30) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 11 Jun
 2020 09:27:47 +0100
Subject: Re: [PATCH RFC v7 02/12] blk-mq: rename blk_mq_update_tag_set_depth()
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <don.brace@microsemi.com>,
        <kashyap.desai@broadcom.com>, <sumit.saxena@broadcom.com>,
        <bvanassche@acm.org>, <hare@suse.com>, <hch@lst.de>,
        <shivasharan.srikanteshwara@broadcom.com>,
        <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <esc.storagedev@microsemi.com>, <chenxiang66@hisilicon.com>,
        <megaraidlinux.pdl@broadcom.com>, Hannes Reinecke <hare@suse.de>
References: <1591810159-240929-1-git-send-email-john.garry@huawei.com>
 <1591810159-240929-3-git-send-email-john.garry@huawei.com>
 <20200611025759.GA453671@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6ef76cdf-2fb3-0ce8-5b5a-0d7af0145901@huawei.com>
Date:   Thu, 11 Jun 2020 09:26:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200611025759.GA453671@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.169.30]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/06/2020 03:57, Ming Lei wrote:
> On Thu, Jun 11, 2020 at 01:29:09AM +0800, John Garry wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> The function does not set the depth, but rather transitions from
>> shared to non-shared queues and vice versa.
>> So rename it to blk_mq_update_tag_set_shared() to better reflect
>> its purpose.
> 
> It is fine to rename it for me, however:
> 
> This patch claims to rename blk_mq_update_tag_set_shared(), but also
> change blk_mq_init_bitmap_tags's signature.

I was going to update the commit message here, but forgot again...

> 
> So suggest to split this patch into two or add comment log on changing
> blk_mq_init_bitmap_tags().

I think I'll just split into 2x commits.

Thanks,
John
