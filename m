Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E07962D1D
	for <lists+linux-block@lfdr.de>; Tue,  9 Jul 2019 02:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfGIAlr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 8 Jul 2019 20:41:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44806 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfGIAlr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jul 2019 20:41:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so6037507plr.11
        for <linux-block@vger.kernel.org>; Mon, 08 Jul 2019 17:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cg//n3SSkgBmws5ERHwpvdMmCdbjQUOmo/aUsu8D0Ik=;
        b=d8cZSMq3dYKKJgjOIJo3kx9/VcKTAxSSJD0TYOSJVKAtpgolVAGFEeVo8CoVuh3m4g
         itYoXMEu9ZlOldj1Mrsy2s/aW5tsxMzrr2Me1zjHZZL6raHY8Jet+afMKMqCYMR+Z740
         NrmKN556yLJAjgA3L3gmDXJZUzFYh05uKCubYtYPNp2U2kOpDhrCm59ZIMfc+xu+iegX
         Q08Y99990gVELbQDjf3eszayJRiWKVMBKw9kd6in7PFGqMLnqSjGPuYXbZ7aiar84D+q
         BJfArQ/4mKSPgS84Fs6/7acYsrE6KVwlFWjKdZHLPRNpj/Bn6eU+1WQRnxu4ox83Lfyj
         9REw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cg//n3SSkgBmws5ERHwpvdMmCdbjQUOmo/aUsu8D0Ik=;
        b=cl0dy4Zs4sVJ364WXqBYmnAt8iosT2mryk5khA+P5Pwl98mjpsfnXDlHUhEPHtdS+z
         TNeFrpeCfZ2yqwUkViCyy5Dh6C+Vcrwk53N31oqII4j0Mdjo7hGHFtbMuAz0+HwkwQPa
         mNt6ZdFjCCxFaGmBFXTuol+uT+uNXBZkqSrRqqw8Ifi52t9GIAsFgavx8NpFGKqFB8zo
         90GI20cIjDFUmHmAbgw+i3VzSiu8xDe2/dHTyo45QfyJ5GCYQGV2duCytDueoRuZi4gl
         WB7p2gmMA0BMhIUkiDo/GhtWBLCmSWu4f1i6yh8O1I8+v/QrBouPmAiy8kV4WMCmo66L
         ur0w==
X-Gm-Message-State: APjAAAWtz1q9TwL05l+OLIsXEO+l2OyCvJXniWrk6EhPxtWi+4Ct0SnX
        TRB6qdAwZLTC+8bKYnlDijL48B/uIak=
X-Google-Smtp-Source: APXvYqzU2YOLDIlCHwPxN/8ZwvTTlNxCDP7sl9SR+hYnedf3vE//8BIIB4NtRHSRGg3Emml4T26zOQ==
X-Received: by 2002:a17:902:4c88:: with SMTP id b8mr29380718ple.29.1562632905805;
        Mon, 08 Jul 2019 17:41:45 -0700 (PDT)
Received: from ?IPv6:2600:380:494b:ede:ed86:6f7f:b700:35e1? ([2600:380:494b:ede:ed86:6f7f:b700:35e1])
        by smtp.gmail.com with ESMTPSA id a26sm6347574pgl.77.2019.07.08.17.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 17:41:44 -0700 (PDT)
Subject: Re: [PATCH v3] io_uring: fix io_sq_thread_stop running in front of
 io_sq_thread
To:     JackieLiu <liuyun01@kylinos.cn>
Cc:     ebiggers@kernel.org,
        =?UTF-8?B?5YiY5q2j5YWD?= <liuzhengyuan@kylinos.cn>,
        linux-block@vger.kernel.org
References: <1562564472-18277-1-git-send-email-liuyun01@kylinos.cn>
 <d157c7f6-712b-a904-5335-2b4ac803376c@kernel.dk>
 <29EFA309-E42B-423B-9260-0E5FD0A2D7ED@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7db0b9eb-ae1a-f133-ed49-83813e0ed632@kernel.dk>
Date:   Mon, 8 Jul 2019 18:41:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <29EFA309-E42B-423B-9260-0E5FD0A2D7ED@kylinos.cn>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/8/19 6:37 PM, JackieLiu wrote:
> 
> 
>> �� 2019��7��9�գ�06:31��Jens Axboe <axboe@kernel.dk> д����
>>
>> On 7/7/19 11:41 PM, Jackie Liu wrote:
>>> INFO: task syz-executor.5:8634 blocked for more than 143 seconds.
>>>         Not tainted 5.2.0-rc5+ #3
>>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>> syz-executor.5  D25632  8634   8224 0x00004004
>>> Call Trace:
>>>    context_switch kernel/sched/core.c:2818 [inline]
>>>    __schedule+0x658/0x9e0 kernel/sched/core.c:3445
>>>    schedule+0x131/0x1d0 kernel/sched/core.c:3509
>>>    schedule_timeout+0x9a/0x2b0 kernel/time/timer.c:1783
>>>    do_wait_for_common+0x35e/0x5a0 kernel/sched/completion.c:83
>>>    __wait_for_common kernel/sched/completion.c:104 [inline]
>>>    wait_for_common kernel/sched/completion.c:115 [inline]
>>>    wait_for_completion+0x47/0x60 kernel/sched/completion.c:136
>>>    kthread_stop+0xb4/0x150 kernel/kthread.c:559
>>>    io_sq_thread_stop fs/io_uring.c:2252 [inline]
>>>    io_finish_async fs/io_uring.c:2259 [inline]
>>>    io_ring_ctx_free fs/io_uring.c:2770 [inline]
>>>    io_ring_ctx_wait_and_kill+0x268/0x880 fs/io_uring.c:2834
>>>    io_uring_release+0x5d/0x70 fs/io_uring.c:2842
>>>    __fput+0x2e4/0x740 fs/file_table.c:280
>>>    ____fput+0x15/0x20 fs/file_table.c:313
>>>    task_work_run+0x17e/0x1b0 kernel/task_work.c:113
>>>    tracehook_notify_resume include/linux/tracehook.h:185 [inline]
>>>    exit_to_usermode_loop arch/x86/entry/common.c:168 [inline]
>>>    prepare_exit_to_usermode+0x402/0x4f0 arch/x86/entry/common.c:199
>>>    syscall_return_slowpath+0x110/0x440 arch/x86/entry/common.c:279
>>>    do_syscall_64+0x126/0x140 arch/x86/entry/common.c:304
>>>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>> RIP: 0033:0x412fb1
>>> Code: 80 3b 7c 0f 84 c7 02 00 00 c7 85 d0 00 00 00 00 00 00 00 48 8b 05 cf
>>> a6 24 00 49 8b 14 24 41 b9 cb 2a 44 00 48 89 ee 48 89 df <48> 85 c0 4c 0f
>>> 45 c8 45 31 c0 31 c9 e8 0e 5b 00 00 85 c0 41 89 c7
>>> RSP: 002b:00007ffe7ee6a180 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
>>> RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000412fb1
>>> RDX: 0000001b2d920000 RSI: 0000000000000000 RDI: 0000000000000003
>>> RBP: 0000000000000001 R08: 00000000f3a3e1f8 R09: 00000000f3a3e1fc
>>> R10: 00007ffe7ee6a260 R11: 0000000000000293 R12: 000000000075c9a0
>>> R13: 000000000075c9a0 R14: 0000000000024c00 R15: 000000000075bf2c
>>>
>>> =============================================
>>>
>>> There is an wrong logic, when kthread_park running
>>> in front of io_sq_thread.
>>>
>>> CPU#0					CPU#1
>>>
>>> io_sq_thread_stop:			int kthread(void *_create):
>>>
>>> kthread_park()
>>> 					__kthread_parkme(self);	 <<< Wrong
>>> kthread_stop()
>>>      << wait for self->exited
>>>      << clear_bit KTHREAD_SHOULD_PARK
>>>
>>> 					ret = threadfn(data);
>>> 					   |
>>> 					   |- io_sq_thread
>>> 					       |- kthread_should_park()	<< false
>>> 					       |- schedule() <<< nobody wake up
>>>
>>> stuck CPU#0				stuck CPU#1
>>>
>>> So, use a new variable sqo_thread_started to ensure that io_sq_thread
>>> run first, then io_sq_thread_stop.
>>
>> I think this looks fine now, I'll apply it. Thanks!
>>
>> Do you have the test case as well? Would like to add it to the
>> liburing arsenal of regression tests.
> 
> Yes, I will. but what's the rules for naming file, they look like sha1
> or MD5 values.

It's the git sha of the commit that fixed the problem. But don't worry
about that, call it whatever and I'll fix it up, if need be.

-- 
Jens Axboe

