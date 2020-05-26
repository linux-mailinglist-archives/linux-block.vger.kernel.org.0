Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B1A1C3542
	for <lists+linux-block@lfdr.de>; Mon,  4 May 2020 11:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgEDJIb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 May 2020 05:08:31 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2150 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726625AbgEDJIb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 May 2020 05:08:31 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id B971EE4C47A9C6E82259;
        Mon,  4 May 2020 10:08:29 +0100 (IST)
Received: from [127.0.0.1] (10.210.171.25) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 4 May 2020
 10:08:29 +0100
Subject: Re: [PATCH V9 00/11] blk-mq: improvement CPU hotplug
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200502235454.1118520-1-ming.lei@redhat.com>
 <5db8635b-b606-3dd9-ce1d-5280097acbd3@huawei.com>
 <20200504083831.GA1139563@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4892e8d0-0a4b-2f35-130c-eae23d578549@huawei.com>
Date:   Mon, 4 May 2020 10:07:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200504083831.GA1139563@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.171.25]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 04/05/2020 09:38, Ming Lei wrote:
>> [67.602937]  refcount_warn_saturate+0x6c/0x13c
>> [67.607369]  aio_complete_rw+0x350/0x384
>> [67.611279]  blkdev_bio_end_io+0xc4/0x12c
>> [67.615276]  bio_endio+0x104/0x130
>> [67.618665]  blk_update_request+0x98/0x37c
>> [67.622748]  blk_mq_end_request+0x24/0x138
>> [67.626831]  blk_mq_resubmit_end_rq+0x40/0x58
>> [67.631174]  __blk_mq_end_request+0xb0/0x10c
>> [67.635432]  scsi_end_request+0xdc/0x20c
> Looks an old issue, I believe the following patch can fix the issue:
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 12dee4ecd5cc..3fc79d4b2fe0 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2415,6 +2415,10 @@ static void blk_mq_resubmit_rq(struct request *rq)
>   	nrq->bio = rq->bio;
>   	nrq->biotail = rq->biotail;
>   
> +	/* Now all bios ownership is transfered to 'nrq' */
> +	rq->bio = rq->biotail = NULL;
> +	rq->__data_len = 0;
> +
>   	if (blk_insert_cloned_request(nrq->q, nrq) != BLK_STS_OK)
>   		blk_mq_request_bypass_insert(nrq, false, true);
>   }

ok, looks much better.

I'll test this a bit more now.

cheers

