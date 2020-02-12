Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41A7215A016
	for <lists+linux-block@lfdr.de>; Wed, 12 Feb 2020 05:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgBLEU7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 11 Feb 2020 23:20:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10613 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727602AbgBLEU7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Feb 2020 23:20:59 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B424F22BED64EA8E65D6;
        Wed, 12 Feb 2020 12:20:57 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.66) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 12 Feb 2020
 12:20:51 +0800
Subject: Re: [PATCH] block: rename 'q->debugfs_dir' in blk_unregister_queue()
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <ming.lei@redhat.com>
CC:     <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>,
        <luoshijie1@huawei.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200211035137.19454-1-yukuai3@huawei.com>
 <c57b050d-9ed7-9d6b-b1d0-628a197f6ea6@acm.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <18bf436a-9c6a-dba8-46a4-ef57132f467a@huawei.com>
Date:   Wed, 12 Feb 2020 12:20:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c57b050d-9ed7-9d6b-b1d0-628a197f6ea6@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.66]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/2/12 11:27, Bart Van Assche wrote:
> What is the behavior of this loop if multiple block devices are being
> removed concurrently? Does it perhaps change remove block device removal
> from an O(1) into an O(n) operation?
Yes, there may be performance overhead.(I thought it's minimal) However,
I can change the name of dir form "read_to_remove_%d" to
"read_to_remove_%s(dev_name)_%d" to fix that.
> 
> Since this scenario may only matter to syzbot tests: has it been
> considered to delay block device creation if the debugfs directory from
> a previous incarnation of the block device still exists?
> 
I think it's a bug device creation succeed when the debugfs directory
exist. Of course delay block device creation can fix the problem, but I
haven't come up with a good solution. And by renaming the dir, there is
no need to delay cration.

Thanks!
Yu Kuai

