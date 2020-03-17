Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95FE0187C23
	for <lists+linux-block@lfdr.de>; Tue, 17 Mar 2020 10:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgCQJiY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 Mar 2020 05:38:24 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2567 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbgCQJiY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Mar 2020 05:38:24 -0400
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 35B138D42154FB9B4054;
        Tue, 17 Mar 2020 09:38:22 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml704-cah.china.huawei.com (10.201.108.45) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 17 Mar 2020 09:38:21 +0000
Received: from [127.0.0.1] (10.47.11.44) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 17 Mar
 2020 09:38:20 +0000
Subject: Re: [PATCH RFC v2 12/24] hpsa: use reserved commands
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hare@suse.de>, <bvanassche@acm.org>,
        <hch@infradead.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <esc.storagedev@microsemi.com>, <chenxiang66@hisilicon.com>,
        Hannes Reinecke <hare@suse.com>
References: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
 <1583857550-12049-13-git-send-email-john.garry@huawei.com>
 <20200311081059.GC31504@ming.t460p>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a76ab13a-85a3-0d88-595f-af13ef1b3fe3@huawei.com>
Date:   Tue, 17 Mar 2020 09:38:10 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200311081059.GC31504@ming.t460p>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.11.44]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/03/2020 08:10, Ming Lei wrote:
>> ands(struct ctlr_info *h)
>> @@ -5803,6 +5803,7 @@ static int hpsa_scsi_host_alloc(struct ctlr_info *h)
>>   	sh->max_lun = HPSA_MAX_LUN;
>>   	sh->max_id = HPSA_MAX_LUN;
>>   	sh->can_queue = h->nr_cmds - HPSA_NRESERVED_CMDS;
>> +	sh->nr_reserved_cmds = HPSA_NRESERVED_CMDS;
> Now .nr_reserved_cmds has been passed to blk-mq, you need to increase
> sh->can_queue to h->nr_cmds, because .can_queue is the whole queue depth
> (include the part of reserved tags), otherwise, IO tags will be
> decreased.
> 

Sounds correct.

Cheers,
John

> Not look into other drivers, I guess they need such change too.
> 
> Thanks,
> Ming
> 
> .

