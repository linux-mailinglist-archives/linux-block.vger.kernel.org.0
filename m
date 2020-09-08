Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEBD261D7B
	for <lists+linux-block@lfdr.de>; Tue,  8 Sep 2020 21:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731359AbgIHThu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 8 Sep 2020 15:37:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:48792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730849AbgIHPzp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Sep 2020 11:55:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E7EC8B603;
        Tue,  8 Sep 2020 15:54:18 +0000 (UTC)
Subject: Re: PROBLEM: Long Workqueue delays V2
To:     Jim Baxter <jim_baxter@mentor.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Cc:     linux-usb@vger.kernel.org,
        "Frkuska, Joshua" <Joshua_Frkuska@mentor.com>,
        "Resch Carsten (CM/ESO6)" <Carsten.Resch@de.bosch.com>,
        "Rosca, Eugeniu (ADITG/ESB)" <erosca@de.adit-jv.com>,
        "Craske, Mark" <Mark_Craske@mentor.com>,
        "Brown, Michael" <michael_brown@mentor.com>
References: <625615f2-3a6b-3136-35f9-2f2fb3c110cf@mentor.com>
 <066753ec-eddc-d7f6-5cc8-fe282baba6ec@mentor.com>
 <bf3d7f89-e652-a26b-bb27-c6dbef08e28c@mentor.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <335b22f6-e579-5ff1-5353-7ab14ca43662@suse.cz>
Date:   Tue, 8 Sep 2020 17:54:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <bf3d7f89-e652-a26b-bb27-c6dbef08e28c@mentor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/27/20 2:06 PM, Jim Baxter wrote:
> Has anyone any ideas of how to investigate this delay further?
> 
> Comparing the perf output for unplugging the USB stick and using umount
> which does not cause these delays in other workqueues the main difference

I don't have that much insight in this, but isn't it that in case of umount, the
exactly same work is done in the umount process context and not workqueues? So
it might take the same time and cpu, stress the same paths, but as it's
attributed to the process, there are no workqueue delays reported? Or does your
measurements suggest otherwise?

> is that the problem case is executing the code in invalidate_mapping_pages()
> and a large part of that arch_local_irq_restore() which is part of
> releasing a lock, I would usually expect that requesting a lock would be
> where delays may occur.
> 
> 	--94.90%--invalidate_partition
> 	   __invalidate_device
> 	   |          
> 	   |--64.55%--invalidate_bdev
> 	   |  |          
> 	   |   --64.13%--invalidate_mapping_pages
> 	   |     |          
> 	   |     |--24.09%--invalidate_inode_page
> 	   |     |   |          
> 	   |     |   --23.44%--remove_mapping
> 	   |     |     |          
> 	   |     |      --23.20%--__remove_mapping
> 	   |     |        |          
> 	   |     |         --21.90%--arch_local_irq_restore
> 	   |     |          
> 	   |     |--22.44%--arch_local_irq_enable
> 
> Best regards,
> Jim
> 
> -------- Original Message --------
> Subject: Re: PROBLEM: Long Workqueue delays V2
> From: Jim Baxter <jim_baxter@mentor.com>
> To: 
> Date: Wed Aug 19 2020 14:12:24 GMT+0100 (British Summer Time)
> 
>> Added linux-block List which may also be relevant to this issue.
>> 
>> -------- Original Message --------
>> Subject: PROBLEM: Long Workqueue delays V2
>> From: Jim Baxter <jim_baxter@mentor.com>
>> To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
>> CC: "Resch Carsten (CM/ESO6)" <Carsten.Resch@de.bosch.com>, "Rosca, Eugeniu (ADITG/ESB)" <erosca@de.adit-jv.com>
>> Date: Tue, 18 Aug 2020 12:58:13 +0100
>> 
>>> I am asking this question again to include the fs-devel list.
>>>
>>>
>>> We have issues with the workqueue of the kernel overloading the CPU 0 
>>> when we we disconnect a USB stick.
>>>
>>> This results in other items on the shared workqueue being delayed by
>>> around 6.5 seconds with a default kernel configuration and 2.3 seconds
>>> on a config tailored for our RCar embedded platform.
>>>
>>>
>>>
>>> We first noticed this issue on custom hardware and we have recreated it
>>> on an RCar Starter Kit using a test module [1] to replicate the
>>> behaviour, the test module outputs any delays of greater then 9ms.
>>>
>>> To run the test we have a 4GB random file on a USB stick and perform
>>> the following test.
>>> The stick is mounted as R/O and we are copying data from the stick:
>>>
>>> - Mount the stick.
>>> mount -o ro,remount /dev/sda1
>>>
>>> - Load the Module:
>>> # taskset -c 0 modprobe latency-mon
>>>
>>> - Copy large amount of data from the stick:
>>> # dd if=/run/media/sda1/sample.txt of=/dev/zero
>>> [ 1437.517603] DELAY: 10
>>> 8388607+1 records in
>>> 8388607+1 records out
>>>
>>>
>>> - Disconnect the USB stick:
>>> [ 1551.796792] usb 2-1: USB disconnect, device number 2
>>> [ 1558.625517] DELAY: 6782
>>>
>>>
>>> The Delay output 6782 is in milliseconds.
>>>
>>>
>>>
>>> Using umount stops the issue occurring but is unfortunately not guaranteed
>>> in our particular system.
>>>
>>>
>>> From my analysis the hub_event workqueue kworker/0:1+usb thread uses around
>>> 98% of the CPU.
>>>
>>> I have traced the workqueue:workqueue_queue_work function while unplugging the USB
>>> and there is no particular workqueue function being executed a lot more then the 
>>> others for the kworker/0:1+usb thread.
>>>
>>>
>>> Using perf I identified the hub_events workqueue was spending a lot of time in
>>> invalidate_partition(), I have included a cut down the captured data from perf in
>>> [2] which shows the additional functions where the kworker spends most of its time.
>>>
>>>
>>> I am aware there will be delays on the shared workqueue, are the delays
>>> we are seeing considered normal?
>>>
>>>
>>> Is there any way to mitigate or identify where the delay is?
>>> I am unsure if this is a memory or filesystem subsystem issue.
>>>
>>>
>>> Thank you for you help.
>>>
>>> Thanks,
>>> Jim Baxter
>>>
>>> [1] Test Module:
>>> // SPDX-License-Identifier: GPL-2.0
>>> /*
>>>  * Simple WQ latency monitoring
>>>  *
>>>  * Copyright (C) 2020 Advanced Driver Information Technology.
>>>  */
>>>
>>> #include <linux/init.h>
>>> #include <linux/ktime.h>
>>> #include <linux/module.h>
>>>
>>> #define PERIOD_MS 100
>>>
>>> static struct delayed_work wq;
>>> static u64 us_save;
>>>
>>> static void wq_cb(struct work_struct *work)
>>> {
>>> 	u64 us = ktime_to_us(ktime_get());
>>> 	u64 us_diff = us - us_save;
>>> 	u64 us_print = 0;
>>>
>>> 	if (!us_save)
>>> 		goto skip_print;
>>>
>>>
>>> 	us_print = us_diff / 1000 - PERIOD_MS;
>>> 	if (us_print > 9)
>>> 		pr_crit("DELAY: %lld\n", us_print);
>>>
>>> skip_print:
>>> 	us_save = us;
>>> 	schedule_delayed_work(&wq, msecs_to_jiffies(PERIOD_MS));
>>> }
>>>
>>> static int latency_mon_init(void)
>>> {
>>> 	us_save = 0;
>>> 	INIT_DELAYED_WORK(&wq, wq_cb);
>>> 	schedule_delayed_work(&wq, msecs_to_jiffies(PERIOD_MS));
>>>
>>> 	return 0;
>>> }
>>>
>>> static void latency_mon_exit(void)
>>> {
>>> 	cancel_delayed_work_sync(&wq);
>>> 	pr_info("%s\n", __func__);
>>> }
>>>
>>> module_init(latency_mon_init);
>>> module_exit(latency_mon_exit);
>>> MODULE_AUTHOR("Eugeniu Rosca <erosca@de.adit-jv.com>");
>>> MODULE_LICENSE("GPL");
>>>
>>>
>>> [2] perf trace:
>>>     95.22%     0.00%  kworker/0:2-eve  [kernel.kallsyms]
>>>     |
>>>     ---ret_from_fork
>>>        kthread
>>>        worker_thread
>>>        |          
>>>         --95.15%--process_one_work
>>> 		  |          
>>> 		   --94.99%--hub_event
>>> 			 |          
>>> 			  --94.99%--usb_disconnect
>>> 			  <snip>
>>> 				|  
>>> 				--94.90%--invalidate_partition
>>> 				   __invalidate_device
>>> 				   |          
>>> 				   |--64.55%--invalidate_bdev
>>> 				   |  |          
>>> 				   |   --64.13%--invalidate_mapping_pages
>>> 				   |     |          
>>> 				   |     |--24.09%--invalidate_inode_page
>>> 				   |     |   |          
>>> 				   |     |   --23.44%--remove_mapping
>>> 				   |     |     |          
>>> 				   |     |      --23.20%--__remove_mapping
>>> 				   |     |        |          
>>> 				   |     |         --21.90%--arch_local_irq_restore
>>> 				   |     |          
>>> 				   |     |--22.44%--arch_local_irq_enable
>>> 				   |          
>>> 					--30.35%--shrink_dcache_sb 
>>> 					<snip>
>>> 					  |      
>>> 					  --30.17%--truncate_inode_pages_range
>>>
> 

