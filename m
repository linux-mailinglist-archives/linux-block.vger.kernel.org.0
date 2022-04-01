Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2594EE6E2
	for <lists+linux-block@lfdr.de>; Fri,  1 Apr 2022 05:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244731AbiDADpW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 31 Mar 2022 23:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244734AbiDADpR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Mar 2022 23:45:17 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8DCB08;
        Thu, 31 Mar 2022 20:43:26 -0700 (PDT)
Received: from kwepemi100008.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KV5br3s6nz1HBK0;
        Fri,  1 Apr 2022 11:43:04 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 11:43:24 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 11:43:23 +0800
Subject: Re: [PATCH RFC -next 0/3] improve fairness for sbitmap waitqueues
From:   "yukuai (C)" <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220318082505.3025427-1-yukuai3@huawei.com>
 <d91e88e0-cd40-1670-2542-390dd4fb5ddf@huawei.com>
Message-ID: <c4d4b335-90b9-0211-acb4-b80f3bb5de5e@huawei.com>
Date:   Fri, 1 Apr 2022 11:43:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d91e88e0-cd40-1670-2542-390dd4fb5ddf@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

friendly ping ...

在 2022/03/25 15:30, yukuai (C) 写道:
> friendly ping ...
> 
> 在 2022/03/18 16:25, Yu Kuai 写道:
>> During some io test, I found that waitqueues can be extremly unbalanced,
>> especially when tags are little.
>>
>> For example:
>> test cmd: nr_requests is set to 64, and queue_depth is set to 32
>> [global]
>> filename=/dev/sdh
>> ioengine=libaio
>> direct=1
>> allow_mounted_write=0
>> group_reporting
>>
>> [test]
>> rw=randwrite
>> bs=4k
>> numjobs=512
>> iodepth=2
>>
>> With patch 1 applied, I observe the following status:
>> ws_active=484
>> ws={
>>          {.wait_cnt=8, .waiters_cnt=117},
>>          {.wait_cnt=8, .waiters_cnt=59},
>>          {.wait_cnt=8, .waiters_cnt=76},
>>          {.wait_cnt=8, .waiters_cnt=0},
>>          {.wait_cnt=5, .waiters_cnt=24},
>>          {.wait_cnt=8, .waiters_cnt=12},
>>          {.wait_cnt=8, .waiters_cnt=21},
>>          {.wait_cnt=8, .waiters_cnt=175},
>> }
>>
>> 'waiters_cnt' means how many threads are waitng for tags in the 'ws',
>> and such extremely unbalanced status is very frequent. After reading the
>> sbitmap code, I found there are two situations that might cause the
>> problem:
>>
>> 1) blk_mq_get_tag() can call 'bt_wait_ptr()' while the threads might get
>> tag successfully before going to wait. - patch 2
>>
>> 2) After a 'ws' is woken up, following blk_mq_put_tag() might wake up
>> the same 'ws' again instead of the next one. - patch 3
>>
>> I'm not sure if the unbalanced status is really a *problem* and need to
>> be fixed, this patchset is just to improve fairness and not a thorough
>> fix. Any comments and suggestions are welcome.
>>
>> Yu Kuai (3):
>>    sbitmap: record the number of waiters for each waitqueue
>>    blk-mq: call 'bt_wait_ptr()' later in blk_mq_get_tag()
>>    sbitmap: improve the fairness of waitqueues' wake up
>>
>>   block/blk-mq-tag.c      |  6 ++---
>>   include/linux/sbitmap.h |  5 ++++
>>   lib/sbitmap.c           | 57 ++++++++++++++++++++++-------------------
>>   3 files changed, 39 insertions(+), 29 deletions(-)
>>
