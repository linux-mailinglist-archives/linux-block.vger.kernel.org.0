Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A04727B93C
	for <lists+linux-block@lfdr.de>; Tue, 29 Sep 2020 03:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgI2BSN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 28 Sep 2020 21:18:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50910 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725272AbgI2BSN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Sep 2020 21:18:13 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 97D79A21096BE3224121;
        Tue, 29 Sep 2020 09:18:11 +0800 (CST)
Received: from [10.174.179.106] (10.174.179.106) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 09:18:10 +0800
Subject: Re: [PATCH] block-mq: fix comments in blk_mq_queue_tag_busy_iter
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>, <hch@lst.de>
References: <20200919035425.3316563-1-yangerkun@huawei.com>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <e03f43b1-ffeb-0fca-3f8f-1507773ffb2e@huawei.com>
Date:   Tue, 29 Sep 2020 09:18:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200919035425.3316563-1-yangerkun@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.106]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ping...

�� 2020/9/19 11:54, yangerkun д��:
> 'f5bbbbe4d635 ("blk-mq: sync the update nr_hw_queues with
> blk_mq_queue_tag_busy_iter")' introduce a bug what we may sleep between
> rcu lock. Then '530ca2c9bd69 ("blk-mq: Allow blocking queue tag iter
> callbacks")' fix it by get request_queue's ref. And 'a9a808084d6a ("block:
> Remove the synchronize_rcu() call from __blk_mq_update_nr_hw_queues()")'
> remove the synchronize_rcu in __blk_mq_update_nr_hw_queues. We need
> update the confused comments in blk_mq_queue_tag_busy_iter.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>   block/blk-mq-tag.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 32d82e23b095..051227bd5a03 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -398,9 +398,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
>   	/*
>   	 * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and queue_hw_ctx
>   	 * while the queue is frozen. So we can use q_usage_counter to avoid
> -	 * racing with it. __blk_mq_update_nr_hw_queues() uses
> -	 * synchronize_rcu() to ensure this function left the critical section
> -	 * below.
> +	 * racing with it.
>   	 */
>   	if (!percpu_ref_tryget(&q->q_usage_counter))
>   		return;
> 
