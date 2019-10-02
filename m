Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8335C4AE5
	for <lists+linux-block@lfdr.de>; Wed,  2 Oct 2019 11:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfJBJ5D (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 2 Oct 2019 05:57:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59148 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbfJBJ5D (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Oct 2019 05:57:03 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 572E52B9706A7471450D;
        Wed,  2 Oct 2019 17:57:01 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 2 Oct 2019
 17:56:52 +0800
Subject: Re: [PATCH V2 0/5] blk-mq: improvement on handling IO during CPU
 hotplug
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20190812134312.16732-1-ming.lei@redhat.com>
 <a2f9e930-1b9c-dc95-78f8-70df9460669d@huawei.com>
CC:     <linux-block@vger.kernel.org>, Minwoo Im <minwoo.im.dev@gmail.com>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>,
        chenxiang <chenxiang66@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <9add1de0-9135-fd1f-8fd4-de17234d8883@huawei.com>
Date:   Wed, 2 Oct 2019 10:56:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <a2f9e930-1b9c-dc95-78f8-70df9460669d@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 22/08/2019 18:39, John Garry wrote:
> On 12/08/2019 14:43, Ming Lei wrote:
>> Hi,
>>
>> Thomas mentioned:
>>     "
>>      That was the constraint of managed interrupts from the very
>> beginning:
>>
>>       The driver/subsystem has to quiesce the interrupt line and the
>> associated
>>       queue _before_ it gets shutdown in CPU unplug and not fiddle
>> with it
>>       until it's restarted by the core when the CPU is plugged in again.
>>     "
>>
>> But no drivers or blk-mq do that before one hctx becomes dead(all
>> CPUs for one hctx are offline), and even it is worse, blk-mq stills tries
>> to run hw queue after hctx is dead, see blk_mq_hctx_notify_dead().
>>
>> This patchset tries to address the issue by two stages:
>>
>> 1) add one new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE
>>
>> - mark the hctx as internal stopped, and drain all in-flight requests
>> if the hctx is going to be dead.
>>
>> 2) re-submit IO in the state of CPUHP_BLK_MQ_DEAD after the hctx
>> becomes dead
>>
>> - steal bios from the request, and resubmit them via
>> generic_make_request(),
>> then these IO will be mapped to other live hctx for dispatch
>>
>> Please comment & review, thanks!
>>
>> V2:
>>     - patch4 & patch 5 in V1 have been merged to block tree, so remove
>>       them
>>     - address comments from John Garry and Minwoo
>>
>>
>> Ming Lei (5):
>>   blk-mq: add new state of BLK_MQ_S_INTERNAL_STOPPED
>>   blk-mq: add blk-mq flag of BLK_MQ_F_NO_MANAGED_IRQ
>>   blk-mq: stop to handle IO before hctx's all CPUs become offline
>>   blk-mq: re-submit IO in case that hctx is dead
>>   blk-mq: handle requests dispatched from IO scheduler in case that hctx
>>     is dead
>
> Hi Ming,
>
> This looks to fix the hotplug issue for me.
>
> Previously I could manufacture a scenario while running fio where I got
> IO timeouts, like this:
>
> root@(none)$ echo 0 > ./sys/devices/system/cpu/cpu0/online
> [  296.897627] process 891 (fio) no longer affine to cpu0
> [  296.898488] process 893 (fio) no longer affine to cpu0
> [  296.910270] process 890 (fio) no longer affine to cpu0
> [  296.927322] IRQ 775: no longer affine to CPU0
> [  296.932762] CPU0: shutdown
> [  296.935469] psci: CPU0 killed.
> root@(none)$ [  326.971962] sas: Enter sas_scsi_recover_host busy: 61
> failed: 61
> [  326.977978] sas: sas_scsi_find_task: aborting task 0x00000000e2cdc79b
> root@(none)$ [  333.047964] hisi_sas_v3_hw 0000:74:02.0: internal task
> abort: timeout and not done.
> [  333.055616] hisi_sas_v3_hw 0000:74:02.0: abort task: internal abort (-5)
> [  333.062306] sas: sas_scsi_find_task: querying task 0x00000000e2cdc79b
> [  333.068776] sas: sas_scsi_find_task: task 0x00000000e2cdc79b not at LU
> [  333.075295] sas: task 0x00000000e2cdc79b is not at LU: I_T recover
> [  333.081464] sas: I_T nexus reset for dev 5000c500a7b95a49
>
> Please notice the 30-second delay for the SCSI IO timeout.
>
> And now I don't see it; here's a sample for irq shutdown:
> root@(none)$ echo 0 > ./sys/devices/system/cpu/cpu0/online
> [  344.608148] process 849 (fio) no longer affine to cpu0
> [  344.608639] process 848 (fio) no longer affine to cpu0
> [  344.609454] process 850 (fio) no longer affine to cpu0
> [  344.643481] process 847 (fio) no longer affine to cpu0
> [  346.213842] IRQ 775: no longer affine to CPU0
> [  346.219712] CPU0: shutdown
> [  346.222425] psci: CPU0 killed.
>
> Please notice the ~1.5s pause, which would be the queue draining.
>
> So FWIW:
> Tested-by: John Garry <john.garry@huawei.com>
>
> JFYI, I tested on 5.3-rc5 and cherry-picked
> https://github.com/ming1/linux/commit/0d2cd3c99bb0fe81d2c0ca5d68e02bdc4521d4d6
> and "blk-mq: add callback of .cleanup_rq".
>
> Cheers,
> John

Hi Jens,

I don't mean to be pushy, but can we consider to get these patches from 
Ming merged?

As above, I tested on my SCSI driver and it works. I also tested on an 
NVMe disk, and it solves the condition which generates this message:
root@(none)$ echo 0 > /sys/devices/system/cpu/cpu2/online
[  465.635960] CPU2: shutdown
[  465.638662] psci: CPU2 killed.
[  111.381653] nvme nvme0: I/O 705 QID 18 timeout, completion polled

(that's on top off v5.4-rc1)

Thanks,
John



>
>>
>>  block/blk-mq-debugfs.c     |   2 +


