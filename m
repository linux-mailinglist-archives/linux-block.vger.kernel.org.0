Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2114B15048B
	for <lists+linux-block@lfdr.de>; Mon,  3 Feb 2020 11:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgBCKtH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 3 Feb 2020 05:49:07 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2347 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726992AbgBCKtH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Feb 2020 05:49:07 -0500
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 1E274D4C96AC0B9B91B6;
        Mon,  3 Feb 2020 10:49:05 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML713-CAH.china.huawei.com (10.201.108.36) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 3 Feb 2020 10:49:04 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 3 Feb 2020
 10:49:03 +0000
Subject: Re: [PATCH V5 0/6] blk-mq: improvement CPU hotplug
From:   John Garry <john.garry@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "Ming Lei" <tom.leiming@gmail.com>
CC:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Hannes Reinecke" <hare@suse.com>, Christoph Hellwig <hch@lst.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        Keith Busch <kbusch@kernel.org>,
        "liudongdong (C)" <liudongdong3@huawei.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Zhou Wang" <wangzhou1@hisilicon.com>
References: <20200115114409.28895-1-ming.lei@redhat.com>
 <929dbfac-de46-a947-6a2c-f4d8d504c631@huawei.com>
 <6dbe8c9f-af4e-3157-b6e9-6bbf43efb1e1@huawei.com>
 <CACVXFVN8io2Pj1HZWLy=z1dbDrE3h9Q6B0DA4gdGOdK3+bRRPg@mail.gmail.com>
 <b1f67efb-585d-e0c1-460f-52be0041b37a@huawei.com>
 <CACVXFVOk3cnRqyngYjHPPtLM1Wn8p3=hP8C3tBns9nDQAnoCyQ@mail.gmail.com>
 <14cb0d17-f9e6-ffa8-7a98-bd602c72273f@huawei.com>
 <56502aa9-d4ad-5ede-5184-13f1817c77d7@huawei.com>
 <CACVXFVNiBOBdtwuW=q4aSmUMAnn6Gfpg6BGhcQu44s58NZ08Ww@mail.gmail.com>
 <20200201110539.03db5434@why> <87sgjutufz.fsf@nanos.tec.linutronix.de>
 <3db522f4-c0c3-ce0f-b0e3-57ee1176bbf8@huawei.com>
Message-ID: <797432ab-1ef5-92e3-b512-bdcee57d1053@huawei.com>
Date:   Mon, 3 Feb 2020 10:49:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <3db522f4-c0c3-ce0f-b0e3-57ee1176bbf8@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/02/2020 10:30, John Garry wrote:
> On 01/02/2020 11:31, Thomas Gleixner wrote:
>> Marc Zyngier <maz@kernel.org> writes:
>>> On Sat, 1 Feb 2020 09:31:17 +0800
>>> Ming Lei <tom.leiming@gmail.com> wrote:
>>>> On Sat, Feb 1, 2020 at 2:02 AM John Garry <john.garry@huawei.com> 
>>>> wrote:
>>>>
>>>> gic_set_affinity shouldn't have switched out, so looks like one gic
>>>> issue.
>>>
>>> Given that gic_set_affinity doesn't sleep, this looks pretty unlikely.
>>> And __irq_set_affinity() holds a spinlock with irq disabled, so I can't
>>> really explain how you'd get there. I've just booted a lockdep enabled
>>> v5.5 on my D05, moved SPIs around (because that's the only way to reach
>>> this code), and nothing caught fire.
>>>
>>> Either the stack trace isn't reliable (when I read things like
>>> "80d:00h:35m:42s" in the trace, I'm a bit suspicious), or CPU hotplug is
>>> doing something really funky here.
>>
>> The hotplug code cannot end up in schedule either and it holds desc lock
>> as normal affinity setting. The other backtrace is more complete,
>>
>> [  728.741808] rcu: INFO: rcu_preempt detected stalls on 
>> CPUs/tasks:80d:00h:35m:42s]
>> [  728.747895] rcu: 48-...0: (0 ticks this GP) 
>> idle=b3e/1/0x4000000000000000 softirq=5548/5548 fqs=2626
>> [  728.757197] (detected by 63, t=5255 jiffies, g=40989, q=1890)
>> [  728.763018] Task dump for CPU 48:
>> [  728.766321] irqbalance      R  running task        0  1272      1 
>> 0x00000002
>> [  728.773358] Call trace:
>> [  728.775801]  __switch_to+0xbc/0x218
>> [  728.779283]  gic_set_affinity+0x16c/0x1d8
>> [  728.783282]  irq_do_set_affinity+0x30/0xd0
>> [  728.787365]  irq_set_affinity_locked+0xc8/0xf0
>> [  728.791796]  __irq_set_affinity+0x4c/0x80
>> [  728.795794]  write_irq_affinity.isra.7+0x104/0x120
>> [  728.800572]  irq_affinity_proc_write+0x1c/0x28
>> [  728.805008]  proc_reg_write+0x78/0xb8
>> [  728.808660]  __vfs_write+0x18/0x38
>> [  728.812050]  vfs_write+0xb4/0x1e0
>> [  728.815352]  ksys_write+0x68/0xf8
>> [  728.818655]  __arm64_sys_write+0x18/0x20
>> [  728.822567]  el0_svc_common.constprop.2+0x64/0x160
>> [  728.827345]  el0_svc_handler+0x20/0x80
>> [  728.831082]  el0_sync_handler+0xe4/0x188
>> [  728.834991]  el0_sync+0x140/0x180
>>
>> But the __switch_to() there definitely does not make any sense at all.
> 
> I have put a full kernel log here for another run (hang snippet at end), 
> including scripts:
> 
> https://pastebin.com/N4Gi5it6
> 
> This does not look good:
> 
> Jobs: 6 ([  519.858094] nvme nvme1: controller is down; will reset: 
> CSTS=0xffffffff, PCI_STATUS=0xffff
> 
> And some NVMe error also coincides with the hang. Another run has this:
> 
>   [  247.015206] pcieport 0000:00:08.0: can't change power state from
>   D3cold to D0 (config space inaccessible)
> 
> I did test v5.4 previously and did not see this, but that would have 
> included the v4 patchset in the $subject. I'll test v5.4 without that 
> patchset now.

So v5.4 does have this issue also:

[  705.669512] psci: CPU24 killed (polled 0 ms)
[  705.966753] CPU25: shutdown
[  705.969548] psci: CPU25 killed (polled 0 ms)
[  706.250771] CPU26: shutdown=2347MiB/s,w=0KiB/s][r=601k,w=0 IOPS][eta 
00m:13s]
[  706.253565] psci: CPU26 killed (polled 0 ms)
[  706.514728] CPU27: shutdown
[  706.517523] psci: CPU27 killed (polled 0 ms)
[  706.826708] CPU28: shutdown
[  706.829502] psci: CPU28 killed (polled 0 ms)
[  707.130916] CPU29: shutdown=2134MiB/s,w=0KiB/s][r=546k,w=0 IOPS][eta 
00m:12s]
[  707.133714] psci: CPU29 killed (polled 0 ms)
[  707.439066] CPU30: shutdown
[  707.441870] psci: CPU30 killed (polled 0 ms)
[  707.706727] CPU31: shutdown
[  707.709526] psci: CPU31 killed (polled 0 ms)
[  708.521853] pcieport 0000:00:08.0: can't change power state from 
D3cold to D0 (config space inaccessible)
[  728.741808] rcu: INFO: rcu_preempt detected stalls on 
CPUs/tasks:80d:00h:35m:42s]
[  728.747895] rcu: 48-...0: (0 ticks this GP) 
idle=b3e/1/0x4000000000000000 softirq=5548/5548 fqs=2626
[  728.757197] (detected by 63, t=5255 jiffies, g=40989, q=1890)
[  728.763018] Task dump for CPU 48:
[  728.766321] irqbalance      R  running task        0  1272      1 
0x00000002
[  728.773358] Call trace:
[  728.775801]  __switch_to+0xbc/0x218
[  728.779283]  gic_set_affinity+0x16c/0x1d8
[  728.783282]  irq_do_set_affinity+0x30/0xd0
[  728.787365]  irq_set_affinity_locked+0xc8/0xf0
[  728.791796]  __irq_set_affinity+0x4c/0x80
[  728.795794]  write_irq_affinity.isra.7+0x104/0x120
[  728.800572]  irq_affinity_proc_write+0x1c/0x28
[  728.805008]  proc_reg_write+0x78/0xb8
[  728.808660]  __vfs_write+0x18/0x38
[  728.812050]  vfs_write+0xb4/0x1e0
[  728.815352]  ksys_write+0x68/0xf8
[  728.818655]  __arm64_sys_write+0x18/0x20
[  728.822567]  el0_svc_common.constprop.2+0x64/0x160
[  728.827345]  el0_svc_handler+0x20/0x80
[  728.831082]  el0_sync_handler+0xe4/0x188
[  728.834991]  el0_sync+0x140/0x180
[  738.993844] nvme nvme1: controller is down; will reset: 
CSTS=0xffffffff, PCI_STATUS=0xffff
[  791.761810] rcu: INFO: rcu_preempt detected stalls on 
CPUs/tasks:63d:14h:24m:13s]
[  791.767897] rcu: 48-...0: (0 ticks this GP) 
idle=b3e/1/0x4000000000000000 softirq=5548/5548 fqs=10495
[  791.777281] (detected by 54, t=21010 jiffies, g=40989, q=2396)
[  791.783189] Task dump for CPU 48:
[  791.786491] irqbalance      R  running task        0  1272      1 
0x00000002
[  791.793528] Call trace:
[  791.795964]  __switch_to+0xbc/0x218
[  791.799441]  gic_set_affinity+0x16c/0x1d8
[  791.803439]  irq_do_set_affinity+0x30/0xd0
[  791.807522]  irq_set_affinity_locked+0xc8/0xf0
[  791.811953]  __irq_set_affinity+0x4c/0x80
[  791.815949]  write_irq_affinity.isra.7+0x104/0x120
[  791.820727]  irq_affinity_proc_write+0x1c/0x28
[  791.825158]  proc_reg_write+0x78/0xb8
[  791.828808]  __vfs_write+0x18/0x38
[  791.832197]  vfs_write+0xb4/0x1e0
[  791.835500]  ksys_write+0x68/0xf8
[  791.838802]  __arm64_sys_write+0x18/0x20
[  791.842712]  el0_svc_common.constprop.2+0x64/0x160
[  791.847490]  el0_svc_handler+0x20/0x80
[  791.851226]  el0_sync_handler+0xe4/0x188
[  791.855135]  el0_sync+0x140/0x180
Jobs: 6 (f=6): [R(6)][0.0%][r=0KiB/s

Thanks,
John

