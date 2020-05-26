Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39ABA1A34DF
	for <lists+linux-block@lfdr.de>; Thu,  9 Apr 2020 15:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgDIN2Q (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 9 Apr 2020 09:28:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12633 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726632AbgDIN2Q (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Apr 2020 09:28:16 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C3598BF0368A815B026B;
        Thu,  9 Apr 2020 21:28:12 +0800 (CST)
Received: from [10.173.220.74] (10.173.220.74) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 9 Apr 2020 21:28:08 +0800
Subject: Re: [PATCH v4 0/6] bdi: fix use-after-free for bdi device
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <tj@kernel.org>, <jack@suse.cz>, <bvanassche@acm.org>,
        <tytso@mit.edu>, <gregkh@linuxfoundation.org>, <hch@infradead.org>
References: <20200325123843.47452-1-yuyufen@huawei.com>
Message-ID: <1a735dce-c72b-5b2e-66c5-b5db30f1139b@huawei.com>
Date:   Thu, 9 Apr 2020 21:28:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200325123843.47452-1-yuyufen@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.74]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping

On 2020/3/25 20:38, Yufen Yu wrote:
> Hi, all
> 
> We have reported a use-after-free crash for bdi device in __blkg_prfill_rwstat().
> The bug is caused by printing device kobj->name while the device and kobj->name
> has been freed by bdi_unregister().
> 
> In fact, commit 68f23b8906 "memcg: fix a crash in wb_workfn when a device disappears"
> has tried to address the issue, but the code is till somewhat racy after that commit.
> 
> In this patchset, we try to protect bdi->dev with spinlock and copy device name
> into caller buffer, avoiding use-after-free.
> 
> V4:
>    * Fix coding error in bdi_get_dev_name()
>    * Write one patch for each broken caller
> 
> V3:
>    https://www.spinics.net/lists/linux-block/msg51111.html
>    Use spinlock to protect bdi->dev and copy device name into caller buffer
> 
> V2:
>    https://www.spinics.net/lists/linux-fsdevel/msg163206.html
>    Try to protect device lifetime with RCU.
> 
> V1:
>    https://www.spinics.net/lists/linux-block/msg49693.html
>    Add a new spinlock and copy kobj->name into caller buffer.
>    Or using synchronize_rcu() to wait until reader complete.
> 
> Yufen Yu (6):
>    bdi: use bdi_dev_name() to get device name
>    bdi: protect bdi->dev with spinlock
>    bfq: fix potential kernel crash when print error info
>    memcg: fix crash in wb_workfn when bdi unregister
>    blk-wbt: replace bdi_dev_name() with bdi_get_dev_name()
>    blkcg: fix use-after-free for bdi->dev
> 
>   block/bfq-iosched.c              |  6 +++--
>   block/blk-cgroup-rwstat.c        |  6 +++--
>   block/blk-cgroup.c               | 19 +++++-----------
>   block/blk-iocost.c               | 14 +++++++-----
>   block/blk-iolatency.c            |  5 +++--
>   block/blk-throttle.c             |  6 +++--
>   fs/ceph/debugfs.c                |  2 +-
>   fs/fs-writeback.c                |  4 +++-
>   include/linux/backing-dev-defs.h |  1 +
>   include/linux/backing-dev.h      | 26 ++++++++++++++++++++++
>   include/linux/blk-cgroup.h       |  1 -
>   include/trace/events/wbt.h       |  8 +++----
>   include/trace/events/writeback.h | 38 ++++++++++++++------------------
>   mm/backing-dev.c                 |  9 ++++++--
>   14 files changed, 88 insertions(+), 57 deletions(-)
> 
