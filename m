Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D933488E37
	for <lists+linux-block@lfdr.de>; Mon, 10 Jan 2022 02:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237969AbiAJBtj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 9 Jan 2022 20:49:39 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:34890 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237943AbiAJBti (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Jan 2022 20:49:38 -0500
Received: from kwepemi500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JXGvZ5xZRzXtLt;
        Mon, 10 Jan 2022 09:48:58 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500002.china.huawei.com (7.221.188.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 09:49:36 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 09:49:35 +0800
Subject: Re: [PATCH 0/5 v2] bfq: Avoid use-after-free when moving processes
 between cgroups
To:     Jan Kara <jack@suse.cz>
CC:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
References: <20220105143037.20542-1-jack@suse.cz>
 <527c2294-9a53-872a-330a-f337506cd08b@huawei.com>
 <20220107145853.jvgupijrq2ejnhdt@quack3.lan>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <db449ed5-85db-37e5-deb6-62fdeb124c90@huawei.com>
Date:   Mon, 10 Jan 2022 09:49:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220107145853.jvgupijrq2ejnhdt@quack3.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

在 2022/01/07 22:58, Jan Kara 写道:
> On Fri 07-01-22 17:15:43, yukuai (C) wrote:
>> 在 2022/01/05 22:36, Jan Kara 写道:
>>> Hello,
>>>
>>> here is the second version of my patches to fix use-after-free issues in BFQ
>>> when processes with merged queues get moved to different cgroups. The patches
>>> have survived some beating in my test VM but so far I fail to reproduce the
>>> original KASAN reports so testing from people who can reproduce them is most
>>> welcome. Thanks!
>>>
>>> Changes since v1:
>>> * Added fix for bfq_put_cooperator()
>>> * Added fix to handle move between cgroups in bfq_merge_bio()
>>>
>>> 								Honza
>>> Previous versions:
>>> Link: http://lore.kernel.org/r/20211223171425.3551-1-jack@suse.cz # v1
>>> .
>>>
>>
>> Hi,
>>
>> I repoduced the problem again with this patchset...
> 
> Thanks for testing!
> 
>> [   71.004788] BUG: KASAN: use-after-free in
>> __bfq_deactivate_entity+0x21/0x290
>> [   71.006328] Read of size 1 at addr ffff88817a3dc0b0 by task rmmod/801
>> [   71.007723]
>> [   71.008068] CPU: 7 PID: 801 Comm: rmmod Tainted: G        W
>> 5.16.0-rc5-next-2021127
>> [   71.009995] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>> ?-20190727_073836-4
>> [   71.012274] Call Trace:
>> [   71.012603]  <TASK>
>> [   71.012886]  dump_stack_lvl+0x34/0x44
>> [   71.013379]  print_address_description.constprop.0.cold+0xab/0x36b
>> [   71.014182]  ? __bfq_deactivate_entity+0x21/0x290
>> [   71.014795]  ? __bfq_deactivate_entity+0x21/0x290
>> [   71.015398]  kasan_report.cold+0x83/0xdf
>> [   71.015904]  ? _raw_read_lock_bh+0x20/0x40
>> [   71.016433]  ? __bfq_deactivate_entity+0x21/0x290
>> [   71.017033]  __bfq_deactivate_entity+0x21/0x290
>> [   71.017617]  bfq_pd_offline+0xc1/0x110
>> [   71.018105]  blkcg_deactivate_policy+0x14b/0x210
> ...
> 
>> Here is the caller of  __bfq_deactivate_entity:
>> (gdb) list *(bfq_pd_offline+0xc1)
>> 0xffffffff81c504f1 is in bfq_pd_offline (block/bfq-cgroup.c:942).
>> 937                      * entities to the idle tree. It happens if, in some
>> 938                      * of the calls to bfq_bfqq_move() performed by
>> 939                      * bfq_reparent_active_queues(), the queue to move
>> is
>> 940                      * empty and gets expired.
>> 941                      */
>> 942                     bfq_flush_idle_tree(st);
>> 943             }
>> 944
>> 945             __bfq_deactivate_entity(entity, false);
> 
> So this is indeed strange. The group has in some of its idle service trees
> an entity whose entity->sched_data points to already freed cgroup. In
> particular it means the bfqq_entity_service_tree() leads to somewhere else
> than the 'st' we called bfq_flush_idle_tree() with. This looks like a
> different kind of problem AFAICT but still it needs fixing :). Can you
> please run your reproducer with my patches + the attached debug patch on
> top? Hopefully it should tell us more about the problematic entity and how
> it got there... Thanks!

Hi,

I'm not sure I understand what you mean... I reporduced again with your
debug patch applied, however, no extra messages are printed.

I think this is exactly the same problem we discussed before:

1) bfqq->new_bfqq is set, they are under g1
2) bfqq is moved to another group, and user thread of new_bfqq exit
3) g1 is offlied
3) io issued from bfqq will end up in new_bfqq, and the offlined
g1 will be inserted to st of g1's parent.

Currently such entity should be in active tree, however, I think it's
prossible that it can end up in idle tree throuph deactivation of
entity?

4) io is done, new_bfqq is deactivated
5) new_bfqq is freed, and then g1 is freed
6) the problem is triggered when g1's parent is offlined.

Thanks,
Kuai
> 
> 								Honza
> 
