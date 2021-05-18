Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4C9387D09
	for <lists+linux-block@lfdr.de>; Tue, 18 May 2021 18:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350243AbhERQDl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 18 May 2021 12:03:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3588 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344303AbhERQDk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 May 2021 12:03:40 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fl10R4FdXzsRnY;
        Tue, 18 May 2021 23:59:35 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 00:02:20 +0800
Received: from [10.47.83.99] (10.47.83.99) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 18 May
 2021 17:02:17 +0100
Subject: Re: [PATCH] blk-mq: plug request for shared sbitmap
From:   John Garry <john.garry@huawei.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        <linux-block@vger.kernel.org>, Yanhui Ma <yama@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        <kashyap.desai@broadcom.com>, chenxiang <chenxiang66@hisilicon.com>
References: <20210514022052.1047665-1-ming.lei@redhat.com>
 <b38d671a-530b-244a-bc0f-0b926c796243@huawei.com> <YKOiClSTyHl5lbXV@T590>
 <185d1d58-f4e3-2024-e5e4-0831af151e3d@huawei.com> <YKOsQ4StDThlbMko@T590>
 <12a651a2-5a0e-15dc-ec40-fc3c57265cd2@huawei.com>
Message-ID: <676e9667-3022-7fde-4518-e82eb0503ec8@huawei.com>
Date:   Tue, 18 May 2021 17:01:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <12a651a2-5a0e-15dc-ec40-fc3c57265cd2@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.83.99]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18/05/2021 13:51, John Garry wrote:
> n 18/05/2021 13:00, Ming Lei wrote:
>>>> 'Before 620K' could be caused by busy queue when batching submission 
>>>> isn't
>>>> applied, so merge chance is increased. This patch applies batching
>>>> submission, so queue becomes not busy enough.
>>>>
>>>> BTW, what is the queue depth of sdev and can_queue of shost for your 
>>>> hisilision SAS?
>>> sdev queue depth is 64 (see hisi_sas_slave_configure()) and host 
>>> depth is
>>> 4096 - 96 (for reserved tags) = 4000
>> OK, so queue depth should get IO merged if there are too many requests
>> queued.
>>
>> What is the same read test result without shared tags? still 430K?
> 
> I never left a driver switch in place to disable it.
> 
> I can forward-port "reply-map" support, which is not too difficult and I 
> will let you know the result.

The 'after' results are similar to without shared sbitmap, i.e using 
reply-map:

reply-map:
450K (read), 430K IOPs (randread)

For reference, with shared shared sbitmap:
Before 620K (read), 300K IOPs (randread)
After  460K (read), 430K (randread)*

These are all mq-deadline.

* I mixed read and randread result earlier by accident

> 
>> And what is your exact read test script? And how many cpu cores in
>> your system?
> 

Thanks,
John
