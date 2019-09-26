Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCBEBBF488
	for <lists+linux-block@lfdr.de>; Thu, 26 Sep 2019 15:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfIZN6B (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Sep 2019 09:58:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2788 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726094AbfIZN6B (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Sep 2019 09:58:01 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5E0B922FDB2BD02140E3;
        Thu, 26 Sep 2019 21:57:55 +0800 (CST)
Received: from [127.0.0.1] (10.177.219.49) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 26 Sep 2019
 21:57:53 +0800
Subject: Re: [PATCH] rq-qos: get rid of redundant wbt_update_limits()
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>
References: <20190917120427.15008-1-yuyufen@huawei.com>
Message-ID: <5fb9e8f0-bfd1-b5aa-e9c1-48c48ee6ab69@huawei.com>
Date:   Thu, 26 Sep 2019 21:57:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190917120427.15008-1-yuyufen@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping


On 2019/9/17 20:04, Yufen Yu wrote:
> We have updated limits after calling wbt_set_min_lat(). No need to
> update again.
>
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>   block/blk-sysfs.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 9bfa3ea4ed63..62d79916e429 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -482,7 +482,6 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
>   	blk_mq_quiesce_queue(q);
>   
>   	wbt_set_min_lat(q, val);
> -	wbt_update_limits(q);
>   
>   	blk_mq_unquiesce_queue(q);
>   	blk_mq_unfreeze_queue(q);


