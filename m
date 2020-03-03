Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07A5B1769D9
	for <lists+linux-block@lfdr.de>; Tue,  3 Mar 2020 02:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgCCBIR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 2 Mar 2020 20:08:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:35178 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgCCBIQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Mar 2020 20:08:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A39B1AD3F;
        Tue,  3 Mar 2020 01:08:14 +0000 (UTC)
Subject: Re: [PATCH 1/2] bcache: ignore pending signals in
 bcache_device_init()
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Oleg Nesterov <oleg@redhat.com>, Michal Hocko <mhocko@kernel.org>,
        linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        hare@suse.de, mkoutny@suse.com
References: <20200302093450.48016-1-colyli@suse.de>
 <20200302093450.48016-2-colyli@suse.de>
 <20200302122748.GH4380@dhcp22.suse.cz> <20200302134919.GB9769@redhat.com>
 <48c6480a-3b26-fb7f-034d-923f9b8875f1@suse.de>
 <dfcd5b4d-592d-fe2a-5c25-ac22729b479e@kernel.dk>
 <2e4898f0-0c2b-9320-b925-456a85ebdea0@suse.de>
 <64c2a8e9-1dc9-f81d-1c11-d9c4e7e0fd2b@kernel.dk>
From:   Coly Li <colyli@suse.de>
Organization: SUSE Labs
Message-ID: <c763699f-108a-f323-dbf1-235cf27b21e4@suse.de>
Date:   Tue, 3 Mar 2020 09:08:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <64c2a8e9-1dc9-f81d-1c11-d9c4e7e0fd2b@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/3/3 4:33 上午, Jens Axboe wrote:
> On 3/2/20 10:32 AM, Coly Li wrote:
>> On 2020/3/3 1:19 上午, Jens Axboe wrote:
>>> On 3/2/20 10:16 AM, Coly Li wrote:
>>>> On 2020/3/2 9:49 下午, Oleg Nesterov wrote:
>>>>> On 03/02, Michal Hocko wrote:
>>>>>>
>>>>>> I cannot really comment on the bcache part because I am not familiar
>>>>>> with the code.
>>>>>
>>>>> same here...
>>>>>
>>>>>>> This patch calls flush_signals() in bcache_device_init() if there is
>>>>>>> pending signal for current process. It avoids bcache registration
>>>>>>> failure in system boot up time due to bcache udev rule timeout.
>>>>>>
>>>>>> this sounds like a wrong way to address the issue. Killing the udev
>>>>>> worker is a userspace policy and the kernel shouldn't simply ignore it.
>>>>>
>>>>> Agreed. If nothing else, if a userspace process has pending SIKILL then
>>>>> flush_signals() is very wrong.
>>>>>
>>>>>> Btw. Oleg, I have noticed quite a lot of flush_signals usage in the
>>>>>> drivers land and I have really hard time to understand their purpose.
>>>>>
>>>>> Heh. I bet most if not all users of flush_signals() are simply wrong.
>>>>>
>>>>>> What is the actual valid usage of this function?
>>>>>
>>>>> I thinks it should die... It was used by kthreads, but today
>>>>> signal_pending() == T is only possible if kthread does allow_signal(),
>>>>> and in this case it should probably use kernel_dequeue_signal().
>>>>>
>>>>>
>>>>> Say, io_sq_thread(). Why does it do
>>>>>
>>>>> 		if (signal_pending(current))
>>>>> 			flush_signals(current);
>>>>>
>>>>> afaics this kthread doesn't use allow_signal/allow_kernel_signal, this
>>>>> means that signal_pending() must be impossible even if this kthread sleeps
>>>>> in TASK_INTERRUPTIBLE state. Add Jens.
>>>>
>>>> Hi Oleg,
>>>>
>>>> Can I use disallow_signal() before the registration begins and use
>>>> allow_signal() after the registration done. Is this a proper way to
>>>> ignore the signal sent by udevd for timeout ?
>>>>
>>>> For me the above method seems to solve my problem too.
>>>
>>> Really seems to me like you're going about this all wrong. The issue is
>>> that systemd is killing the startup, because it's taking too long. Don't
>>> try and work around that, ensure the timeout is appropriate.
>>>
>>
>> Copied. Then let me try how to make event_timeout works on my udevd. If
>> it works without other side effect, I will revert existing
>> flush_signals() patches.
> 
> Thanks, this one, right?
> 
> commit 0b96da639a4874311e9b5156405f69ef9fc3bef8
> Author: Coly Li <colyli@suse.de>
> Date:   Thu Feb 13 22:12:05 2020 +0800
> 
>     bcache: ignore pending signals when creating gc and allocator thread
> 
> because that definitely needs to be reverted.
> 

Yes, please revert this commit. Thank you.

-- 

Coly Li
