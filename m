Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC6B7B1686
	for <lists+linux-block@lfdr.de>; Thu, 28 Sep 2023 10:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjI1IzM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 28 Sep 2023 04:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjI1IzK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Sep 2023 04:55:10 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE853AC;
        Thu, 28 Sep 2023 01:55:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rx6kJ5PGTz4f3kkN;
        Thu, 28 Sep 2023 16:55:04 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAnt9ZnPxVlpvdfBg--.53473S3;
        Thu, 28 Sep 2023 16:55:05 +0800 (CST)
Subject: Re: [PATCH] nbd: pass nbd_sock to nbd_read_reply() instead of index
To:     Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linan666@huaweicloud.com, josef@toxicpanda.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, linan122@huawei.com,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230911023308.3467802-1-linan666@huaweicloud.com>
 <ZRT7cVFcE6QMHfie@fedora>
 <47669fb6-3700-e327-11af-93a92b0984a0@huaweicloud.com>
 <ZRUt/vAQNGNp6Ugx@fedora>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <41161d21-299c-3657-6020-0a3a9cf109ec@huaweicloud.com>
Date:   Thu, 28 Sep 2023 16:55:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ZRUt/vAQNGNp6Ugx@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnt9ZnPxVlpvdfBg--.53473S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWUGw4xZF15tF4fCFW8tFb_yoW5Gr13pF
        WFyF1xCF4UJFySvwsYqw47WryFq34xK3yfu3yrA342yr909FZakr4xtFyFgF90vr17Xw40
        vr4YgFyfAa48JrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

在 2023/09/28 15:40, Ming Lei 写道:
> On Thu, Sep 28, 2023 at 02:03:28PM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2023/09/28 12:05, Ming Lei 写道:
>>> On Mon, Sep 11, 2023 at 10:33:08AM +0800, linan666@huaweicloud.com wrote:
>>>> From: Li Nan <linan122@huawei.com>
>>>>
>>>> If a socket is processing ioctl 'NBD_SET_SOCK', config->socks might be
>>>> krealloc in nbd_add_socket(), and a garbage request is received now, a UAF
>>>> may occurs.
>>>>
>>>>     T1
>>>>     nbd_ioctl
>>>>      __nbd_ioctl
>>>>       nbd_add_socket
>>>>        blk_mq_freeze_queue
>>>> 				T2
>>>>     				recv_work
>>>>     				 nbd_read_reply
>>>>     				  sock_xmit
>>>>        krealloc config->socks
>>>> 				   def config->socks
>>>>
>>>> Pass nbd_sock to nbd_read_reply(). And introduce a new function
>>>> sock_xmit_recv(), which differs from sock_xmit only in the way it get
>>>> socket.
>>>>
>>>
>>> I am wondering why not grab queue usage counter before calling nbd_read_reply()
>>> for avoiding such issue, something like the following change:
>>>
>>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>>> index df1cd0f718b8..09215b605b12 100644
>>> --- a/drivers/block/nbd.c
>>> +++ b/drivers/block/nbd.c
>>> @@ -837,9 +837,6 @@ static void recv_work(struct work_struct *work)
>>>    	while (1) {
>>>    		struct nbd_reply reply;
>>> -		if (nbd_read_reply(nbd, args->index, &reply))
>>> -			break;
>>> -
>>>    		/*
>>>    		 * Grab .q_usage_counter so request pool won't go away, then no
>>>    		 * request use-after-free is possible during nbd_handle_reply().
>>> @@ -852,6 +849,9 @@ static void recv_work(struct work_struct *work)
>>>    			break;
>>>    		}
>>
>> This break how nbd works, if there is no reply yet, recv_work() will
>> wait for reply in:
>>
>> nbd_read_reply
>>   sock_xmit
>>    sock_recvmsg
>>
>> After this change, recv_work() will just return if there is no io.
> 
> OK, got it, thanks for the input.
> 
> But I feel it isn't necessary & fragile to store one extra reference of nsock in
> `recv_thread_args`.
> 
> Just run a quick look, the only potential UAF on config->socks should be recv_work(),
> so you can retrieve the `nsock` reference at the entry of recv_work(),

I don't understand what you mean retrieve the 'nsock', is following what
you expected?

blk_queue_enter() -> prevent concurrent with nbd_add_socket
nsock = config->socks[args->index]
blk_queue_exit()

while (1) {
	...
	// pass nsock to nbd_read_reply() and nbd_handle_reply()
}

> and just pass it(local variable) to nbd_read_reply() and nbd_handle_reply()
> since `nsock` won't be freed.
> 
> 
> Thanks,
> Ming
> 
> .
> 

