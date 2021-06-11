Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72073A45B5
	for <lists+linux-block@lfdr.de>; Fri, 11 Jun 2021 17:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhFKPvc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 11 Jun 2021 11:51:32 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:51058 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhFKPvb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Jun 2021 11:51:31 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 15BFnWtX032169;
        Sat, 12 Jun 2021 00:49:32 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp);
 Sat, 12 Jun 2021 00:49:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 15BFnWRO032161
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 12 Jun 2021 00:49:32 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [syzbot] possible deadlock in del_gendisk
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Petr Vorel <pvorel@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block <linux-block@vger.kernel.org>,
        syzbot <syzbot+61e04e51b7ac86930589@syzkaller.appspotmail.com>,
        Tejun Heo <tj@kernel.org>
References: <000000000000ae236f05bfde0678@google.com>
 <1435f266-9f6d-22ef-ba7d-f031c616aede@I-love.SAKURA.ne.jp>
 <7b8c9eeb-789d-e5e6-04d6-130ee8be7305@i-love.sakura.ne.jp>
 <20210609164639.GM4910@sequoia>
 <49e00adb-ccf5-8024-6403-014ca82781dd@i-love.sakura.ne.jp>
 <CA+CK2bDWb2=bsoacY-eqZExObBpXuZE0a3Mr18_FXmGZTC5GnQ@mail.gmail.com>
 <CA+CK2bBe5muuGbHgfK7JjbzRE5ogf1oeD1iYeY6eJB046p9_ZQ@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <f76628cc-8f05-56dd-fec5-b1103aedd504@i-love.sakura.ne.jp>
Date:   Sat, 12 Jun 2021 00:49:27 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CA+CK2bBe5muuGbHgfK7JjbzRE5ogf1oeD1iYeY6eJB046p9_ZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/06/12 0:18, Pavel Tatashin wrote:
>>> Well, I made commit 310ca162d779efee ("block/loop: Use global lock for ioctl() operation.")
>>> because per device lock was not sufficient. Did commit 6cc8e7430801fa23 ("loop: scale loop
>>> device by introducing per device lock") take this problem into account?
>>
>> This was my intention when I wrote 6cc8e7430801fa23 ("loop: scale loop
>> device by introducing per device lock"). This is why this change does
>> not simply revert 310ca162d779efee ("block/loop: Use global lock for
>> ioctl() operation."), but keeps loop_ctl_mutex to protect the global
>> accesses.  loop_control_ioctl() is still locked by global
>> loop_ctl_mutex.

No, loop_control_ioctl() (i.e. /dev/loop-control) is irrelevant here.
What 310ca162d779efee addressed but (I worry) 6cc8e7430801fa23 broke is
lo_ioctl() (i.e. /dev/loop$num).

syzbot was reporting NULL pointer dereference which is caused by
race condition between ioctl(loop_fd, LOOP_CLR_FD, 0) versus
ioctl(other_loop_fd, LOOP_SET_FD, loop_fd) due to traversing other
loop devices at loop_validate_file() without holding corresponding
lo->lo_mutex lock.

For example, loop_change_fd("/dev/loop0") calls loop_validate_file()
with only "/dev/loop0"->lo_mutex held. Then, loop_validate_file() finds
that is_loop_device("/dev/loop0") == true and enters the "while" loop.
In the "while" loop, there is

	if (l->lo_state != Lo_bound) {
		return -EINVAL;
	}
	f = l->lo_backing_file;

which has a race window that l->lo_backing_file suddenly becomes NULL
between these statements because __loop_clr_fd("/dev/loop1") is doing

	lo->lo_backing_file = NULL;

with only "/dev/loop1"->lo_mutex held.

In other words, loop_validate_file() is a global accesses which are
no longer protected by loop_ctl_mutex, isn't it?
