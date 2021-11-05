Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C7D445D7D
	for <lists+linux-block@lfdr.de>; Fri,  5 Nov 2021 02:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhKEBtD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 4 Nov 2021 21:49:03 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15362 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbhKEBtC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 21:49:02 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hljyp0lktz90VB;
        Fri,  5 Nov 2021 09:46:10 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 5 Nov 2021 09:46:19 +0800
Received: from [10.174.179.189] (10.174.179.189) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 5 Nov 2021 09:46:18 +0800
Subject: Re: [PATCH RESEND] nbd: code clean for nbd_genl_status()
To:     Christoph Hellwig <hch@infradead.org>
CC:     <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <linfeilong@huawei.com>
References: <1636000703-13217-1-git-send-email-wubo40@huawei.com>
 <YYOeYwPlLnn7JR+W@infradead.org>
From:   Wu Bo <wubo40@huawei.com>
Message-ID: <6cdbd618-918a-3674-122f-039180ea316b@huawei.com>
Date:   Fri, 5 Nov 2021 09:46:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <YYOeYwPlLnn7JR+W@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.189]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/11/4 16:48, Christoph Hellwig wrote:
> On Thu, Nov 04, 2021 at 12:38:23PM +0800, Wu Bo wrote:
>>   	if (!reply_head) {
>> -		nlmsg_free(reply);
>>   		goto out;
>>   	}
> 
> Please also drop the now pointless braces.
> 
ok. Will do in v2.
>>   out:
>> +	if (reply)
>> +		nlmsg_free(reply);
> 
> Please just use a different label for just unlocking vs also freeing
> the reply.
> .
ok. Will do in v2.

Thanks.

Wu Bo

