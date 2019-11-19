Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F40D101239
	for <lists+linux-block@lfdr.de>; Tue, 19 Nov 2019 04:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfKSDc5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 18 Nov 2019 22:32:57 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:55612 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727112AbfKSDc4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Nov 2019 22:32:56 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 318A879CF8B82179E162;
        Tue, 19 Nov 2019 11:32:54 +0800 (CST)
Received: from [127.0.0.1] (10.74.219.194) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 19 Nov 2019
 11:32:48 +0800
Subject: Re: The irq Affinity is changed after the patch(Fixes: b1a5a73e64e9
 ("genirq/affinity: Spread vectors on node according to nr_cpu ratio"))
To:     Ming Lei <ming.lei@redhat.com>
References: <d59f7f7a-975a-2032-aa61-7cbff7585d33@hisilicon.com>
 <20191119014204.GA391@ming.t460p>
 <a8a89884-8323-ff70-f35e-0fcf5d7afefc@hisilicon.com>
 <20191119031700.GE391@ming.t460p>
CC:     <lkml@sdf.org>, <tglx@linutronix.de>, <kbusch@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <75a630b2-029b-0a3e-79a9-d11143a033ad@hisilicon.com>
Date:   Tue, 19 Nov 2019 11:32:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20191119031700.GE391@ming.t460p>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.219.194]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



在 2019/11/19 11:17, Ming Lei 写道:
> On Tue, Nov 19, 2019 at 11:05:55AM +0800, chenxiang (M) wrote:
>> Hi Ming,
>>
>> 在 2019/11/19 9:42, Ming Lei 写道:
>>> On Tue, Nov 19, 2019 at 09:25:30AM +0800, chenxiang (M) wrote:
>>>> Hi,
>>>>
>>>> There are 128 cpus and 16 irqs for SAS controller in my system, and there
>>>> are 4 Nodes, every 32 cpus are for one node (cpu0-31 for node0, cpu32-63 for
>>>> node1, cpu64-95 for node2, cpu96-127 for node3).
>>>> We use function pci_alloc_irq_vectors_affinity() to set the affinity of
>>>> irqs.
>>>>
>>>> I find that  before the patch (Fixes: b1a5a73e64e9 ("genirq/affinity: Spread
>>>> vectors on node according to nr_cpu ratio")), the relationship between irqs
>>>> and cpus is: irq0 bind to cpu0-7, irq1 bind to cpu8-15,
>>>> irq2 bind to cpu16-23, irq3 bind to cpu24-31,irq4 bind to cpu32-39... irq15
>>>> bind to cpu120-127. But after the patch, the relationship is changed: irq0
>>>> bind to cpu32-39,
>>>> irq1 bind to cpu40-47, ..., irq11 bind to cpu120-127, irq12 bind to cpu0-7,
>>>> irq13 bind to cpu8-15, irq14 bind to cpu16-23, irq15 bind to cpu24-31.
>>>>
>>>> I notice that before calling the sort() in function alloc_nodes_vectors(),
>>>> the id of array node_vectors[] is from 0,1,2,3. But after function sort(),
>>>> the index of array node_vectors[] is 1,2,3,0.
>>>> But i think it sorts according to the numbers of cpus in those nodes, so it
>>>> should be the same as before calling sort() as the numbers of cpus in every
>>>> node are 32.
>>> Maybe there are more non-present CPUs covered by node 0.
>>>
>>> Could you provide the following log?
>>>
>>> 1) lscpu
>>>
>>> 2) ./dump-io-irq-affinity $PCI_ID_SAS
>>>
>>> 	http://people.redhat.com/minlei/tests/tools/dump-io-irq-affinity
>>>
>>> You need to figure out the PCI ID(the 1st column of lspci output) of the SAS
>>> controller via lspci.
>> Sorry, I can't access the link you provide, but i can provide those irqs'
>> affinity in the attachment.
>> I also write a small testcase, and find id is 1, 2, 3, 0 after calling
>> sort() .
> Runtime log from /proc/interrupts isn't useful for investigating
> affinity allocation issue, please use the attached script for collecting
> log.

Note: there are 32 irqs for SAS controller, irq0-15 are other interrupts 
(such as phy up/down/channel....), only irq 16-31 are cq interrupts 
which is processed by function pci_alloc_irq_vectors_affinity().
The log is as follows:

Euler:~ # ./dump-io-irq-affinity 74:02.0
kernel version:
Linux Euler 5.4.0-rc2-14683-g74684b1-dirty #224 SMP PREEMPT Mon Nov 18 
18:54:27 CST 2019 aarch64 aarch64 aarch64 GNU/Linux
PCI name is 74:02.0: sdd
cat: /proc/irq/65/smp_affinity_list: No such file or directory
cat: /proc/irq/65/effective_affinity_list: No such file or directory
     irq 65, cpu list , effective list
     irq 66, cpu list 0-31, effective list 0
     irq 67, cpu list 0-31, effective list 0
cat: /proc/irq/68/smp_affinity_list: No such file or directory
cat: /proc/irq/68/effective_affinity_list: No such file or directory
     irq 68, cpu list , effective list
cat: /proc/irq/69/smp_affinity_list: No such file or directory
cat: /proc/irq/69/effective_affinity_list: No such file or directory
     irq 69, cpu list , effective list
cat: /proc/irq/70/smp_affinity_list: No such file or directory
cat: /proc/irq/70/effective_affinity_list: No such file or directory
     irq 70, cpu list , effective list
cat: /proc/irq/71/smp_affinity_list: No such file or directory
cat: /proc/irq/71/effective_affinity_list: No such file or directory
     irq 71, cpu list , effective list
cat: /proc/irq/72/smp_affinity_list: No such file or directory
cat: /proc/irq/72/effective_affinity_list: No such file or directory
     irq 72, cpu list , effective list
cat: /proc/irq/73/smp_affinity_list: No such file or directory
cat: /proc/irq/73/effective_affinity_list: No such file or directory
     irq 73, cpu list , effective list
cat: /proc/irq/74/smp_affinity_list: No such file or directory
cat: /proc/irq/74/effective_affinity_list: No such file or directory
     irq 74, cpu list , effective list
cat: /proc/irq/75/smp_affinity_list: No such file or directory
cat: /proc/irq/75/effective_affinity_list: No such file or directory
     irq 75, cpu list , effective list
     irq 76, cpu list 0-31, effective list 0
cat: /proc/irq/77/smp_affinity_list: No such file or directory
cat: /proc/irq/77/effective_affinity_list: No such file or directory
     irq 77, cpu list , effective list
cat: /proc/irq/78/smp_affinity_list: No such file or directory
cat: /proc/irq/78/effective_affinity_list: No such file or directory
     irq 78, cpu list , effective list
cat: /proc/irq/79/smp_affinity_list: No such file or directory
cat: /proc/irq/79/effective_affinity_list: No such file or directory
     irq 79, cpu list , effective list
cat: /proc/irq/80/smp_affinity_list: No such file or directory
cat: /proc/irq/80/effective_affinity_list: No such file or directory
     irq 80, cpu list , effective list
     irq 81, cpu list 32-39, effective list 32
     irq 82, cpu list 40-47, effective list 40
     irq 83, cpu list 48-55, effective list 48
     irq 84, cpu list 56-63, effective list 56
     irq 85, cpu list 64-71, effective list 64
     irq 86, cpu list 72-79, effective list 72
     irq 87, cpu list 80-87, effective list 80
     irq 88, cpu list 88-95, effective list 88
     irq 89, cpu list 96-103, effective list 96
     irq 90, cpu list 104-111, effective list 104
     irq 91, cpu list 112-119, effective list 112
     irq 92, cpu list 120-127, effective list 120
     irq 93, cpu list 0-7, effective list 0
     irq 94, cpu list 8-15, effective list 8
     irq 95, cpu list 16-23, effective list 16
     irq 96, cpu list 24-31, effective list 24


>
>
> Thanks,
> Ming


