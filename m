Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308AE427875
	for <lists+linux-block@lfdr.de>; Sat,  9 Oct 2021 11:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhJIJgt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 9 Oct 2021 05:36:49 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56698 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbhJIJgr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Oct 2021 05:36:47 -0400
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1999YksO093143;
        Sat, 9 Oct 2021 18:34:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Sat, 09 Oct 2021 18:34:46 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1999YjUX093140
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 9 Oct 2021 18:34:45 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] block: fix syzbot report UAF in bdev_free_inode()
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk
References: <20211009065951.11567-1-qiang.zhang1211@gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <ad09fde9-9655-fc28-4298-4b43d57cd76c@i-love.sakura.ne.jp>
Date:   Sat, 9 Oct 2021 18:34:43 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211009065951.11567-1-qiang.zhang1211@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/10/09 15:59, Zqiang wrote:
> The xa_insert() may be return error in __alloc_disk_node(), and the disk
> object will be release, however there are two operations that will release
> it, kfree(disk) and iput(disk->part0->bd_inode), the iput operations
> will call call_rcu(), because the rcu callback executed is an asynchronous
> actionthe, so when free disk object in rcu callback, the disk object haven
> been released. solve it through a unified release action.
> 
> Reported-by: syzbot+8281086e8a6fbfbd952a@syzkaller.appspotmail.com
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Thanks. But my patch is ready for 5.15.

https://lore.kernel.org/all/e6dd13c5-8db0-4392-6e78-a42ee5d2a1c4@i-love.sakura.ne.jp/T/#u
