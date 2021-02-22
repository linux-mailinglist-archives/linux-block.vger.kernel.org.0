Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766F932136E
	for <lists+linux-block@lfdr.de>; Mon, 22 Feb 2021 10:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhBVJuc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 22 Feb 2021 04:50:32 -0500
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:49094 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhBVJuH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 04:50:07 -0500
Received: from [127.0.0.1] (unknown [157.0.31.124])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id 6043AAC0460;
        Mon, 22 Feb 2021 17:49:10 +0800 (CST)
Subject: Re: [PATCH v2] kyber: introduce kyber_depth_updated()
From:   Yang Yang <yang.yang@vivo.com>
To:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>
Cc:     onlyfever@icloud.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20210205091311.129498-1-yang.yang@vivo.com>
Message-ID: <c1ac179d-5d22-e4bb-e661-87981c8535f3@vivo.com>
Date:   Mon, 22 Feb 2021 17:49:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210205091311.129498-1-yang.yang@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZH0NOSxhNTkhIQxofVkpNSkhCQ0xITktOSklVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KyI6UQw*ED8UExgNKxkNFi8u
        FTwaFBFVSlVKTUpIQkNMSE5LQ0NPVTMWGhIXVQIaFRxVAhoVHDsNEg0UVRgUFkVZV1kSC1lBWUpO
        TFVLVUhKVUpJT1lXWQgBWUFPQ0hDNwY+
X-HM-Tid: 0a77c92487c8b039kuuu6043aac0460
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/2/5 17:13, Yang Yang wrote:
> Hang occurs when user changes the scheduler queue depth, by writing to
> the 'nr_requests' sysfs file of that device.
> 
> The details of the environment that we found the problem are as follows:
>    an eMMC block device
>    total driver tags: 16
>    default queue_depth: 32
>    kqd->async_depth initialized in kyber_init_sched() with queue_depth=32
> 
> Then we change queue_depth to 256, by writing to the 'nr_requests' sysfs
> file. But kqd->async_depth don't be updated after queue_depth changes.
> Now the value of async depth is too small for queue_depth=256, this may
> cause hang.
> 
> This patch introduces kyber_depth_updated(), so that kyber can update
> async depth when queue depth changes.
> 
> Signed-off-by: Yang Yang <yang.yang@vivo.com>
> ---
> v2:
> - Change the commit message
> - Change from sbitmap::depth to 2^sbitmap::shift
> ---
>   block/kyber-iosched.c | 29 +++++++++++++----------------
>   1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
> index dc89199bc8c6..17215b6bf482 100644
> --- a/block/kyber-iosched.c
> +++ b/block/kyber-iosched.c
> @@ -353,19 +353,9 @@ static void kyber_timer_fn(struct timer_list *t)
>   	}
>   }
>   
> -static unsigned int kyber_sched_tags_shift(struct request_queue *q)
> -{
> -	/*
> -	 * All of the hardware queues have the same depth, so we can just grab
> -	 * the shift of the first one.
> -	 */
> -	return q->queue_hw_ctx[0]->sched_tags->bitmap_tags->sb.shift;
> -}
> -
>   static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
>   {
>   	struct kyber_queue_data *kqd;
> -	unsigned int shift;
>   	int ret = -ENOMEM;
>   	int i;
>   
> @@ -400,9 +390,6 @@ static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
>   		kqd->latency_targets[i] = kyber_latency_targets[i];
>   	}
>   
> -	shift = kyber_sched_tags_shift(q);
> -	kqd->async_depth = (1U << shift) * KYBER_ASYNC_PERCENT / 100U;
> -
>   	return kqd;
>   
>   err_buckets:
> @@ -458,9 +445,19 @@ static void kyber_ctx_queue_init(struct kyber_ctx_queue *kcq)
>   		INIT_LIST_HEAD(&kcq->rq_list[i]);
>   }
>   
> -static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
> +static void kyber_depth_updated(struct blk_mq_hw_ctx *hctx)
>   {
>   	struct kyber_queue_data *kqd = hctx->queue->elevator->elevator_data;
> +	struct blk_mq_tags *tags = hctx->sched_tags;
> +	unsigned int shift = tags->bitmap_tags->sb.shift;
> +
> +	kqd->async_depth = (1U << shift) * KYBER_ASYNC_PERCENT / 100U;
> +
> +	sbitmap_queue_min_shallow_depth(tags->bitmap_tags, kqd->async_depth);
> +}
> +
> +static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
> +{
>   	struct kyber_hctx_data *khd;
>   	int i;
>   
> @@ -502,8 +499,7 @@ static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
>   	khd->batching = 0;
>   
>   	hctx->sched_data = khd;
> -	sbitmap_queue_min_shallow_depth(hctx->sched_tags->bitmap_tags,
> -					kqd->async_depth);
> +	kyber_depth_updated(hctx);
>   
>   	return 0;
>   
> @@ -1022,6 +1018,7 @@ static struct elevator_type kyber_sched = {
>   		.completed_request = kyber_completed_request,
>   		.dispatch_request = kyber_dispatch_request,
>   		.has_work = kyber_has_work,
> +		.depth_updated = kyber_depth_updated,
>   	},
>   #ifdef CONFIG_BLK_DEBUG_FS
>   	.queue_debugfs_attrs = kyber_queue_debugfs_attrs,
> 

Hello,

Ping...

Thanks!
