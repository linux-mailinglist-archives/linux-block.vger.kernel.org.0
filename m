Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 016FDCFF7E
	for <lists+linux-block@lfdr.de>; Tue,  8 Oct 2019 19:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfJHREG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 8 Oct 2019 13:04:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57232 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725900AbfJHREG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Oct 2019 13:04:06 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0162E18FE7BAAD3BCC13;
        Wed,  9 Oct 2019 01:04:00 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 9 Oct 2019
 01:03:59 +0800
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH V3 3/5] blk-mq: stop to handle IO and drain IO before hctx
 becomes dead
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20191008041821.2782-1-ming.lei@redhat.com>
 <20191008041821.2782-4-ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Message-ID: <6fb931a8-48c6-0805-dc52-31f965e98803@huawei.com>
Date:   Tue, 8 Oct 2019 18:03:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20191008041821.2782-4-ming.lei@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 08/10/2019 05:18, Ming Lei wrote:
> Before one CPU becomes offline, check if it is the last online CPU
> of hctx. If yes, mark this hctx as BLK_MQ_S_INTERNAL_STOPPED, meantime
> wait for completion of all in-flight IOs originated from this hctx.
>
> This way guarantees that there isn't any inflight IO before shutdowning
> the managed IRQ line.
>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Keith Busch <keith.busch@intel.com>

Apart from nits, below, FWIW:
Reviewed-by: John Garry <john.garry@huawei.com>

> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq-tag.c |  2 +-
>  block/blk-mq-tag.h |  2 ++
>  block/blk-mq.c     | 40 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 008388e82b5c..31828b82552b 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -325,7 +325,7 @@ static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
>   *		true to continue iterating tags, false to stop.
>   * @priv:	Will be passed as second argument to @fn.
>   */
> -static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
> +void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
>  		busy_tag_iter_fn *fn, void *priv)
>  {
>  	if (tags->nr_reserved_tags)
> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
> index 61deab0b5a5a..321fd6f440e6 100644
> --- a/block/blk-mq-tag.h
> +++ b/block/blk-mq-tag.h
> @@ -35,6 +35,8 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
>  extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
>  void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
>  		void *priv);
> +void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
> +		busy_tag_iter_fn *fn, void *priv);
>
>  static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
>  						 struct blk_mq_hw_ctx *hctx)
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a664f196782a..3384242202eb 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2225,8 +2225,46 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>  	return -ENOMEM;
>  }
>
> +static bool blk_mq_count_inflight_rq(struct request *rq, void *data,
> +				     bool reserved)
> +{
> +	unsigned *count = data;
> +
> +	if ((blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT))

nit: extra parentheses

> +		(*count)++;
> +
> +	return true;
> +}
> +
> +static unsigned blk_mq_tags_inflight_rqs(struct blk_mq_tags *tags)
> +{
> +	unsigned count = 0;
> +
> +	blk_mq_all_tag_busy_iter(tags, blk_mq_count_inflight_rq, &count);
> +
> +	return count;
> +}
> +
> +static void blk_mq_hctx_drain_inflight_rqs(struct blk_mq_hw_ctx *hctx)
> +{
> +	while (1) {
> +		if (!blk_mq_tags_inflight_rqs(hctx->tags))
> +			break;
> +		msleep(5);
> +	}
> +}
> +
>  static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
>  {
> +	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
> +			struct blk_mq_hw_ctx, cpuhp_online);
> +

nit: we could make this a little neater by using an intermediate 
variable for hctx->cpumask:

	struct cpumask *cpumask = hctx->cpumask;
	
	if ((cpumask_next_and(-1, cpumask, cpu_online_mask) == cpu) &&

	...

> +	if ((cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) == cpu) &&
> +	    (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) >=
> +	     nr_cpu_ids)) {
> +		set_bit(BLK_MQ_S_INTERNAL_STOPPED, &hctx->state);
> +		blk_mq_hctx_drain_inflight_rqs(hctx);
> +        }
>  	return 0;
>  }
>
> @@ -2246,6 +2284,8 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
>  	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
>  	type = hctx->type;
>
> +	clear_bit(BLK_MQ_S_INTERNAL_STOPPED, &hctx->state);
> +
>  	spin_lock(&ctx->lock);
>  	if (!list_empty(&ctx->rq_lists[type])) {
>  		list_splice_init(&ctx->rq_lists[type], &tmp);
>


