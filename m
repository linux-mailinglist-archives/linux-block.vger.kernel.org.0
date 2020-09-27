Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF0627A12F
	for <lists+linux-block@lfdr.de>; Sun, 27 Sep 2020 15:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgI0NNB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 27 Sep 2020 09:13:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58298 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726149AbgI0NNB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Sep 2020 09:13:01 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 91A3627846F6F203A2D7;
        Sun, 27 Sep 2020 21:12:59 +0800 (CST)
Received: from [10.174.179.185] (10.174.179.185) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Sun, 27 Sep 2020 21:12:57 +0800
Subject: Re: [PATCH] block: remove redundant mq check
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>
References: <20200916111712.4011701-1-yuyufen@huawei.com>
Message-ID: <7024794c-18a9-4fb4-42dd-2e20dd616dda@huawei.com>
Date:   Sun, 27 Sep 2020 21:12:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200916111712.4011701-1-yuyufen@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.185]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Gently ping.

On 2020/9/16 19:17, Yufen Yu wrote:
> elv_support_iosched() will check queue_is_mq() for us. So, remove
> the redundant check to clean code.
> 
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>   block/elevator.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index f0db80fec5a4..b564129a9f2d 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -616,7 +616,7 @@ int elevator_switch_mq(struct request_queue *q,
>   
>   static inline bool elv_support_iosched(struct request_queue *q)
>   {
> -	if (!q->mq_ops ||
> +	if (!queue_is_mq(q) ||
>   	    (q->tag_set && (q->tag_set->flags & BLK_MQ_F_NO_SCHED)))
>   		return false;
>   	return true;
> @@ -764,7 +764,7 @@ ssize_t elv_iosched_store(struct request_queue *q, const char *name,
>   {
>   	int ret;
>   
> -	if (!queue_is_mq(q) || !elv_support_iosched(q))
> +	if (!elv_support_iosched(q))
>   		return count;
>   
>   	ret = __elevator_change(q, name);
> 
