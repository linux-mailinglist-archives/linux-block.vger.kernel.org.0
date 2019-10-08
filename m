Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8500CF59C
	for <lists+linux-block@lfdr.de>; Tue,  8 Oct 2019 11:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbfJHJGl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 8 Oct 2019 05:06:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3219 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729926AbfJHJGk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Oct 2019 05:06:40 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6B4501630ADD6AEE8753;
        Tue,  8 Oct 2019 17:06:37 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 8 Oct 2019
 17:06:31 +0800
Subject: Re: [PATCH V3 0/5] blk-mq: improvement on handling IO during CPU
 hotplug
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20191008041821.2782-1-ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <bf9687ef-4a90-73f7-3028-4c5d56c8d66b@huawei.com>
Date:   Tue, 8 Oct 2019 10:06:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20191008041821.2782-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 08/10/2019 05:18, Ming Lei wrote:
> Hi,
>
> Thomas mentioned:
>     "
>      That was the constraint of managed interrupts from the very beginning:
>
>       The driver/subsystem has to quiesce the interrupt line and the associated
>       queue _before_ it gets shutdown in CPU unplug and not fiddle with it
>       until it's restarted by the core when the CPU is plugged in again.
>     "
>
> But no drivers or blk-mq do that before one hctx becomes dead(all
> CPUs for one hctx are offline), and even it is worse, blk-mq stills tries
> to run hw queue after hctx is dead, see blk_mq_hctx_notify_dead().
>
> This patchset tries to address the issue by two stages:
>
> 1) add one new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE
>
> - mark the hctx as internal stopped, and drain all in-flight requests
> if the hctx is going to be dead.
>
> 2) re-submit IO in the state of CPUHP_BLK_MQ_DEAD after the hctx becomes dead
>
> - steal bios from the request, and resubmit them via generic_make_request(),
> then these IO will be mapped to other live hctx for dispatch
>
> Please comment & review, thanks!
>
> John, I don't add your tested-by tag since V3 have some changes,
> and I appreciate if you may run your test on V3.
>

Will do, Thanks

> V3:
> 	- re-organize patch 2 & 3 a bit for addressing Hannes's comment
> 	- fix patch 4 for avoiding potential deadlock, as found by Hannes
>
> V2:
> 	- patch4 & patch 5 in V1 have been merged to block tree, so remove
> 	  them
> 	- addres


