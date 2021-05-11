Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7331337A0DF
	for <lists+linux-block@lfdr.de>; Tue, 11 May 2021 09:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhEKHfJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 11 May 2021 03:35:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3058 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKHfH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 May 2021 03:35:07 -0400
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FfTzP62sVz6rnLt;
        Tue, 11 May 2021 15:28:01 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 11 May 2021 09:33:58 +0200
Received: from [10.47.85.216] (10.47.85.216) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 11 May
 2021 08:33:58 +0100
Subject: Re: [PATCH] blk-mq: Use request queue-wide tags for tagset-wide
 sbitmap
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <kashyap.desai@broadcom.com>, <chenxiang66@hisilicon.com>,
        <yama@redhat.com>, Douglas Gilbert <dgilbert@interlog.com>
References: <1620037333-2495-1-git-send-email-john.garry@huawei.com>
 <YJnVasOcaVU+4+Au@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <afa41d8d-d006-5c4f-d604-047ac737fd90@huawei.com>
Date:   Tue, 11 May 2021 08:33:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YJnVasOcaVU+4+Au@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.85.216]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/05/2021 01:52, Ming Lei wrote:
>> fixed.
>>
>> Ming and Yanhui report higher CPU usage and lower throughput in scenarios
>> where the fixed total driver tag depth is appreciably lower than the total
>> scheduler tag depth:
>> https://lore.kernel.org/linux-block/440dfcfc-1a2c-bd98-1161-cec4d78c6dfc@huawei.com/T/#mc0d6d4f95275a2743d1c8c3e4dc9ff6c9aa3a76b
>>
> No difference any more wrt. fio running on scsi_debug with this patch in
> Yanhui's test machine:
> 
> 	modprobe scsi_debug host_max_queue=128 submit_queues=32 virtual_gb=256 delay=1
> vs.
> 	modprobe scsi_debug max_queue=128 submit_queues=1 virtual_gb=256 delay=1
> 
> Without this patch, the latter's result is 30% higher than the former's.
> 

ok, good. I'll post a v2 with comments addressed.

> note: scsi_debug's queue depth needs to be updated to 128 for avoiding io hang,
> which is another scsi issue.
> 
I was just carrying Doug's patch to test.

Thanks,
John
