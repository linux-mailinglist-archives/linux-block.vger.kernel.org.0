Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB24C24A033
	for <lists+linux-block@lfdr.de>; Wed, 19 Aug 2020 15:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgHSNh1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 19 Aug 2020 09:37:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44308 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728699AbgHSNhZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Aug 2020 09:37:25 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D40A8D67AE4401AA64B9;
        Wed, 19 Aug 2020 21:37:15 +0800 (CST)
Received: from [10.174.179.185] (10.174.179.185) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Wed, 19 Aug 2020 21:37:11 +0800
Subject: Re: [PATCH v2] blkcg: fix memleak for iolatency
From:   Yufen Yu <yuyufen@huawei.com>
To:     <jbacik@fb.com>, <tj@kernel.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>
References: <20200811022116.1824539-1-yuyufen@huawei.com>
Message-ID: <21951039-d191-3c1f-3976-f2e2a84c541f@huawei.com>
Date:   Wed, 19 Aug 2020 21:37:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200811022116.1824539-1-yuyufen@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.185]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping

On 2020/8/11 10:21, Yufen Yu wrote:
> Normally, blkcg_iolatency_exit() will free related memory in iolatency
> when cleanup queue. But if blk_throtl_init() return error and queue init
> fail, blkcg_iolatency_exit() will not do that for us. Then it cause
> memory leak.
> 
> Fixes: d70675121546 ("block: introduce blk-iolatency io controller")
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>   block/blk-cgroup.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 619a79b51068..c195365c9817 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1152,13 +1152,15 @@ int blkcg_init_queue(struct request_queue *q)
>   	if (preloaded)
>   		radix_tree_preload_end();
>   
> -	ret = blk_iolatency_init(q);
> +	ret = blk_throtl_init(q);
>   	if (ret)
>   		goto err_destroy_all;
>   
> -	ret = blk_throtl_init(q);
> -	if (ret)
> +	ret = blk_iolatency_init(q);
> +	if (ret) {
> +		blk_throtl_exit(q);
>   		goto err_destroy_all;
> +	}
>   	return 0;
>   
>   err_destroy_all:
> 
