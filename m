Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEFF4FA1B1
	for <lists+linux-block@lfdr.de>; Sat,  9 Apr 2022 04:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238164AbiDIChA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 8 Apr 2022 22:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiDICg7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Apr 2022 22:36:59 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D2C66C81;
        Fri,  8 Apr 2022 19:34:54 -0700 (PDT)
Received: from kwepemi100017.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KZzgQ2cHwzgYZN;
        Sat,  9 Apr 2022 10:33:06 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100017.china.huawei.com (7.221.188.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 9 Apr 2022 10:34:52 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 9 Apr 2022 10:34:51 +0800
Subject: Re: [PATCH -next RFC v2 0/8] improve tag allocation under heavy load
To:     Jens Axboe <axboe@kernel.dk>, <andriy.shevchenko@linux.intel.com>,
        <john.garry@huawei.com>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220408073916.1428590-1-yukuai3@huawei.com>
 <d50a0ee1-c7e2-1b99-8d3f-ce2edeea92cd@kernel.dk>
 <d02f416f-a1de-f7d9-881e-a88c1bdd25c1@huawei.com>
 <98d3b9b9-1786-837c-d316-cc991305c8aa@kernel.dk>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <014e945b-6336-e04c-c87c-d36cd09a3be8@huawei.com>
Date:   Sat, 9 Apr 2022 10:34:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <98d3b9b9-1786-837c-d316-cc991305c8aa@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

在 2022/04/09 10:28, Jens Axboe 写道:
> On 4/8/22 8:26 PM, yukuai (C) wrote:
>> 在 2022/04/09 3:10, Jens Axboe 写道:
>>> For this one, and other patches you send, they send up in spam because
>>> the sender can't be verified. I would encourage you to figure out what
>>> is going wrong here, because a lot of your patches end up getting
>>> dropped or missed because of it.
>>>
>>
>> Hi,
>>
>> Thanks for your notice, however, I have no clue what is going on right
>> now. I'll look for some help and hopefully that can be fixed.
> 
> The easiest is probably to try and send patches to a gmail account. If
> you don't have one, just create one. That will help you see the issue
> and verify whatever the fix might be. It might be a company email
> server issue, hower.
> 
Thanks very much for your advice, I'll try that asap.
