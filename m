Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD3D1893B3
	for <lists+linux-block@lfdr.de>; Wed, 18 Mar 2020 02:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgCRBfu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 Mar 2020 21:35:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48508 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbgCRBft (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Mar 2020 21:35:49 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 99E943A8A22EE1B9E395;
        Wed, 18 Mar 2020 09:35:37 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 18 Mar 2020
 09:37:32 +0800
Subject: Re: [PATCH] block, bfq: fix use-after-free in
 bfq_idle_slice_timer_body
To:     Paolo Valente <paolo.valente@linaro.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>,
        Yanxiaodan <yanxiaodan@huawei.com>,
        "wubo (T)" <wubo40@huawei.com>, renxudong <renxudong1@huawei.com>,
        Louhongxiang <louhongxiang@huawei.com>
References: <6c0d0b36-751b-a63a-418b-888a88ce58f4@huawei.com>
 <C69604D5-CBB7-4A5F-AD73-7A9C0B6B3360@linaro.org>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <0a6e190a-3393-53f9-b127-d57d67cdcdc8@huawei.com>
Date:   Wed, 18 Mar 2020 09:35:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <C69604D5-CBB7-4A5F-AD73-7A9C0B6B3360@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.183]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/3/18 1:44, Paolo Valente wrote:
> 
> 
>> Il giorno 17 mar 2020, alle ore 15:06, Zhiqiang Liu <liuzhiqiang26@huawei.com> ha scritto:
>>
>> In bfq_idle_slice_timer func, bfqq = bfqd->in_service_queue is
>> not in bfqd-lock critical section. The bfqq, which is not
>> equal to NULL in bfq_idle_slice_timer, may be freed after passing
>> to bfq_idle_slice_timer_body. So we will access the freed memory.
>>
>> KASAN log is given as follows:
>> [13058.354613] ==================================================================
>> [13058.354640] BUG: KASAN: use-after-free in bfq_idle_slice_timer+0xac/0x290
>> [13058.354644] Read of size 8 at addr ffffa02cf3e63f78 by task fork13/19767
>> [13058.354646]
>> [13058.354655] CPU: 96 PID: 19767 Comm: fork13
>> [13058.354661] Call trace:
>> [13058.354667]  dump_backtrace+0x0/0x310
>> [13058.354672]  show_stack+0x28/0x38
>> [13058.354681]  dump_stack+0xd8/0x108
>> [13058.354687]  print_address_description+0x68/0x2d0
>> [13058.354690]  kasan_report+0x124/0x2e0
>> [13058.354697]  __asan_load8+0x88/0xb0
>> [13058.354702]  bfq_idle_slice_timer+0xac/0x290
>> [13058.354707]  __hrtimer_run_queues+0x298/0x8b8
>> [13058.354710]  hrtimer_interrupt+0x1b8/0x678
>> [13058.354716]  arch_timer_handler_phys+0x4c/0x78
>> [13058.354722]  handle_percpu_devid_irq+0xf0/0x558
>> [13058.354731]  generic_handle_irq+0x50/0x70
>> [13058.354735]  __handle_domain_irq+0x94/0x110
>> [13058.354739]  gic_handle_irq+0x8c/0x1b0
>> [13058.354742]  el1_irq+0xb8/0x140
>> [13058.354748]  do_wp_page+0x260/0xe28
>> [13058.354752]  __handle_mm_fault+0x8ec/0x9b0
>> [13058.354756]  handle_mm_fault+0x280/0x460
>> [13058.354762]  do_page_fault+0x3ec/0x890
>> [13058.354765]  do_mem_abort+0xc0/0x1b0
>> [13058.354768]  el0_da+0x24/0x28
>> [13058.354770]
>> [13058.354773] Allocated by task 19731:
>> [13058.354780]  kasan_kmalloc+0xe0/0x190
>> [13058.354784]  kasan_slab_alloc+0x14/0x20
>> [13058.354788]  kmem_cache_alloc_node+0x130/0x440
>> [13058.354793]  bfq_get_queue+0x138/0x858
>> [13058.354797]  bfq_get_bfqq_handle_split+0xd4/0x328
>> [13058.354801]  bfq_init_rq+0x1f4/0x1180
>> [13058.354806]  bfq_insert_requests+0x264/0x1c98
>> [13058.354811]  blk_mq_sched_insert_requests+0x1c4/0x488
>> [13058.354818]  blk_mq_flush_plug_list+0x2d4/0x6e0
>> [13058.354826]  blk_flush_plug_list+0x230/0x548
>> [13058.354830]  blk_finish_plug+0x60/0x80
>> [13058.354838]  read_pages+0xec/0x2c0
>> [13058.354842]  __do_page_cache_readahead+0x374/0x438
>> [13058.354846]  ondemand_readahead+0x24c/0x6b0
>> [13058.354851]  page_cache_sync_readahead+0x17c/0x2f8
>> [13058.354858]  generic_file_buffered_read+0x588/0xc58
>> [13058.354862]  generic_file_read_iter+0x1b4/0x278
>> [13058.354965]  ext4_file_read_iter+0xa8/0x1d8 [ext4]
>> [13058.354972]  __vfs_read+0x238/0x320
>> [13058.354976]  vfs_read+0xbc/0x1c0
>> [13058.354980]  ksys_read+0xdc/0x1b8
>> [13058.354984]  __arm64_sys_read+0x50/0x60
>> [13058.354990]  el0_svc_common+0xb4/0x1d8
>> [13058.354994]  el0_svc_handler+0x50/0xa8
>> [13058.354998]  el0_svc+0x8/0xc
>> [13058.354999]
>> [13058.355001] Freed by task 19731:
>> [13058.355007]  __kasan_slab_free+0x120/0x228
>> [13058.355010]  kasan_slab_free+0x10/0x18
>> [13058.355014]  kmem_cache_free+0x288/0x3f0
>> [13058.355018]  bfq_put_queue+0x134/0x208
>> [13058.355022]  bfq_exit_icq_bfqq+0x164/0x348
>> [13058.355026]  bfq_exit_icq+0x28/0x40
>> [13058.355030]  ioc_exit_icq+0xa0/0x150
>> [13058.355035]  put_io_context_active+0x250/0x438
>> [13058.355038]  exit_io_context+0xd0/0x138
>> [13058.355045]  do_exit+0x734/0xc58
>> [13058.355050]  do_group_exit+0x78/0x220
>> [13058.355054]  __wake_up_parent+0x0/0x50
>> [13058.355058]  el0_svc_common+0xb4/0x1d8
>> [13058.355062]  el0_svc_handler+0x50/0xa8
>> [13058.355066]  el0_svc+0x8/0xc
>> [13058.355067]
>> [13058.355071] The buggy address belongs to the object at ffffa02cf3e63e70#012 which belongs to the cache bfq_queue of size 464
>> [13058.355075] The buggy address is located 264 bytes inside of#012 464-byte region [ffffa02cf3e63e70, ffffa02cf3e64040)
>> [13058.355077] The buggy address belongs to the page:
>> [13058.355083] page:ffff7e80b3cf9800 count:1 mapcount:0 mapping:ffff802db5c90780 index:0xffffa02cf3e606f0 compound_mapcount: 0
>> [13058.366175] flags: 0x2ffffe0000008100(slab|head)
>> [13058.370781] raw: 2ffffe0000008100 ffff7e80b53b1408 ffffa02d730c1c90 ffff802db5c90780
>> [13058.370787] raw: ffffa02cf3e606f0 0000000000370023 00000001ffffffff 0000000000000000
>> [13058.370789] page dumped because: kasan: bad access detected
>> [13058.370791]
>> [13058.370792] Memory state around the buggy address:
>> [13058.370797]  ffffa02cf3e63e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fb fb
>> [13058.370801]  ffffa02cf3e63e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> [13058.370805] >ffffa02cf3e63f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> [13058.370808]                                                                 ^
>> [13058.370811]  ffffa02cf3e63f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> [13058.370815]  ffffa02cf3e64000: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>> [13058.370817] ==================================================================
>> [13058.370820] Disabling lock debugging due to kernel taint
>>
>> Here, we directly pass the bfqd to bfq_idle_slice_timer_body func.
>>
>> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>> Signed-off-by: Feilong Lin <linfeilong@huawei.com>
>> ---
>> block/bfq-iosched.c | 10 +++++-----
>> 1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 8c436abfaf14..f470b9daa98b 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -6215,20 +6215,20 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
>> 	return bfqq;
>> }
>>
>> -static void bfq_idle_slice_timer_body(struct bfq_queue *bfqq)
>> +static void
>> +bfq_idle_slice_timer_body(struct bfq_data *bfqd, struct bfq_queue *bfqq)
>> {
>> -	struct bfq_data *bfqd = bfqq->bfqd;
>> 	enum bfqq_expiration reason;
>> 	unsigned long flags;
>>
>> 	spin_lock_irqsave(&bfqd->lock, flags);
>> -	bfq_clear_bfqq_wait_request(bfqq);
>> -
>> 	if (bfqq != bfqd->in_service_queue) {
>> 		spin_unlock_irqrestore(&bfqd->lock, flags);
>> 		return;
>> 	}
>>
>> +	bfq_clear_bfqq_wait_request(bfqq);
>> +
> 
> Please add a comment on why you (correctly) clear this flag only if bfqq is in service.
> 
> For the rest, seems ok to me.
> 
> Thank you very much for spotting and fixing this bug,
> Paolo
> 
Thanks for your reply.
Considering that the bfqq may be in race, we should firstly check whether bfqq is in service before
doing something on it.

I will add a comment before 'if (bfqq != bfqd->in_service_queue) {'

In addition, the fix tag is missing. I will add it in v2 patch.

>> 	if (bfq_bfqq_budget_timeout(bfqq))
>> 		/*
>> 		 * Also here the queue can be safely expired
>> @@ -6273,7 +6273,7 @@ static enum hrtimer_restart bfq_idle_slice_timer(struct hrtimer *timer)
>> 	 * early.
>> 	 */
>> 	if (bfqq)
>> -		bfq_idle_slice_timer_body(bfqq);
>> +		bfq_idle_slice_timer_body(bfqd, bfqq);
>>
>> 	return HRTIMER_NORESTART;
>> }
>> -- 
>> 2.19.1
>>
>>
> 
> 
> .
> 

