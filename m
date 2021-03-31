Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1193486F8
	for <lists+linux-block@lfdr.de>; Thu, 25 Mar 2021 03:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhCYCee (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 24 Mar 2021 22:34:34 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:17325 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232495AbhCYCeP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 22:34:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UTDnjuT_1616639642;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UTDnjuT_1616639642)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Mar 2021 10:34:03 +0800
Subject: Re: [PATCH V3 04/13] block: create io poll context for submission and
 poll task
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com
References: <20210324121927.362525-1-ming.lei@redhat.com>
 <20210324121927.362525-5-ming.lei@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <0bc4e13a-53ba-5f29-5a6d-5cda1aea098a@linux.alibaba.com>
Date:   Thu, 25 Mar 2021 10:34:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210324121927.362525-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/24/21 8:19 PM, Ming Lei wrote:
> Create per-task io poll context for both IO submission and poll task
> if the queue is bio based and supports polling.
> 
> This io polling context includes two queues:
> 
> 1) submission queue(sq) for storing HIPRI bio, written by submission task
>    and read by poll task.
> 2) polling queue(pq) for holding data moved from sq, only used in poll
>    context for running bio polling.
> 
> Following patches will support bio based io polling.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-core.c          | 71 ++++++++++++++++++++++++++++++++-------
>  block/blk-ioc.c           |  1 +
>  block/blk-mq.c            | 14 ++++++++
>  block/blk.h               | 45 +++++++++++++++++++++++++
>  include/linux/iocontext.h |  2 ++
>  5 files changed, 121 insertions(+), 12 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d58f8a0c80de..4671bbf31fd3 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -792,16 +792,59 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
>  	return BLK_STS_OK;
>  }
>  
> -static inline void blk_create_io_context(struct request_queue *q)
> +static inline struct blk_bio_poll_ctx *blk_get_bio_poll_ctx(void)
>  {
> -	/*
> -	 * Various block parts want %current->io_context, so allocate it up
> -	 * front rather than dealing with lots of pain to allocate it only
> -	 * where needed. This may fail and the block layer knows how to live
> -	 * with it.
> -	 */
> -	if (unlikely(!current->io_context))
> -		create_task_io_context(current, GFP_ATOMIC, q->node);
> +	struct io_context *ioc = current->io_context;
> +
> +	return ioc ? ioc->data : NULL;
> +}
> +
> +static inline unsigned int bio_grp_list_size(unsigned int nr_grps)
> +{
> +	return sizeof(struct bio_grp_list) + nr_grps *
> +		sizeof(struct bio_grp_list_data);
> +}
> +
> +static void bio_poll_ctx_init(struct blk_bio_poll_ctx *pc)
> +{
> +	pc->sq = (void *)pc + sizeof(*pc);
> +	pc->sq->max_nr_grps = BLK_BIO_POLL_SQ_SZ;
> +
> +	pc->pq = (void *)pc->sq + bio_grp_list_size(BLK_BIO_POLL_SQ_SZ);
> +	pc->pq->max_nr_grps = BLK_BIO_POLL_PQ_SZ;
> +
> +	spin_lock_init(&pc->sq_lock);
> +	spin_lock_init(&pc->pq_lock);
> +}
> +
> +void bio_poll_ctx_alloc(struct io_context *ioc)
> +{
> +	struct blk_bio_poll_ctx *pc;
> +	unsigned int size = sizeof(*pc) +
> +		bio_grp_list_size(BLK_BIO_POLL_SQ_SZ) +
> +		bio_grp_list_size(BLK_BIO_POLL_PQ_SZ);
> +
> +	pc = kzalloc(GFP_ATOMIC, size);
> +	if (pc) {
> +		bio_poll_ctx_init(pc);
> +		if (cmpxchg(&ioc->data, NULL, (void *)pc))
> +			kfree(pc);
> +	}

Why don't put these in blk-ioc.c?


> +}
> +
> +static inline bool blk_queue_support_bio_poll(struct request_queue *q)
> +{
> +	return !queue_is_mq(q) && blk_queue_poll(q);
> +}
> +
> +static inline void blk_bio_poll_preprocess(struct request_queue *q,
> +		struct bio *bio)
> +{
> +	if (!(bio->bi_opf & REQ_HIPRI))
> +		return;
> +
> +	if (!blk_queue_poll(q) || (!queue_is_mq(q) && !blk_get_bio_poll_ctx()))
> +		bio->bi_opf &= ~REQ_HIPRI;
>  }
>  
>  static noinline_for_stack bool submit_bio_checks(struct bio *bio)
> @@ -848,10 +891,14 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
>  		}
>  	}
>  
> -	blk_create_io_context(q);
> +	/*
> +	 * Create per-task io poll ctx if bio polling supported and HIPRI
> +	 * set.
> +	 */
> +	blk_create_io_context(q, blk_queue_support_bio_poll(q) &&
> +			(bio->bi_opf & REQ_HIPRI));
>  
> -	if (!blk_queue_poll(q))
> -		bio->bi_opf &= ~REQ_HIPRI;
> +	blk_bio_poll_preprocess(q, bio);
>  
>  	switch (bio_op(bio)) {
>  	case REQ_OP_DISCARD:
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index b0cde18c4b8c..5574c398eff6 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -19,6 +19,7 @@ static struct kmem_cache *iocontext_cachep;
>  
>  static inline void free_io_context(struct io_context *ioc)
>  {
> +	kfree(ioc->data);
>  	kmem_cache_free(iocontext_cachep, ioc);
>  }
>  
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 63c81df3b8b5..c832faa52ca0 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3852,6 +3852,17 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
>  	return blk_mq_poll_hybrid_sleep(q, rq);
>  }
>  
> +static int blk_bio_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
> +{
> +	/*
> +	 * Create poll queue for storing poll bio and its cookie from
> +	 * submission queue
> +	 */
> +	blk_create_io_context(q, true);
> +
> +	return 0;
> +}
> +
>  /**
>   * blk_poll - poll for IO completions
>   * @q:  the queue
> @@ -3875,6 +3886,9 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
>  	if (current->plug)
>  		blk_flush_plug_list(current->plug, false);
>  
> +	if (!queue_is_mq(q))
> +		return blk_bio_poll(q, cookie, spin);
> +
>  	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
>  
>  	/*
> diff --git a/block/blk.h b/block/blk.h
> index 3b53e44b967e..424949f2226d 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -357,4 +357,49 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
>  		struct page *page, unsigned int len, unsigned int offset,
>  		unsigned int max_sectors, bool *same_page);
>  
> +/* Grouping bios that share same data into one list */
> +struct bio_grp_list_data {
> +	void *grp_data;
> +
> +	/* all bios in this list share same 'grp_data' */
> +	struct bio_list list;
> +};
> +
> +struct bio_grp_list {
> +	unsigned int max_nr_grps, nr_grps;
> +	struct bio_grp_list_data head[0];
> +};
> +
> +struct blk_bio_poll_ctx {
> +	spinlock_t sq_lock;
> +	struct bio_grp_list *sq;
> +
> +	spinlock_t pq_lock;
> +	struct bio_grp_list *pq;
> +};
> +
> +#define BLK_BIO_POLL_SQ_SZ		16U
> +#define BLK_BIO_POLL_PQ_SZ		(BLK_BIO_POLL_SQ_SZ * 2)

And these in iocontext.h?


> +
> +void bio_poll_ctx_alloc(struct io_context *ioc);
> +
> +static inline void blk_create_io_context(struct request_queue *q,
> +		bool need_poll_ctx)
> +{
> +	struct io_context *ioc;
> +
> +	/*
> +	 * Various block parts want %current->io_context, so allocate it up
> +	 * front rather than dealing with lots of pain to allocate it only
> +	 * where needed. This may fail and the block layer knows how to live
> +	 * with it.
> +	 */
> +	if (unlikely(!current->io_context))
> +		create_task_io_context(current, GFP_ATOMIC, q->node);
> +
> +	ioc = current->io_context;
> +	if (need_poll_ctx && unlikely(ioc && !ioc->data))
> +		bio_poll_ctx_alloc(ioc);
> +}
> +
>  #endif /* BLK_INTERNAL_H */
> diff --git a/include/linux/iocontext.h b/include/linux/iocontext.h
> index 0a9dc40b7be8..f9a467571356 100644
> --- a/include/linux/iocontext.h
> +++ b/include/linux/iocontext.h
> @@ -110,6 +110,8 @@ struct io_context {
>  	struct io_cq __rcu	*icq_hint;
>  	struct hlist_head	icq_list;
>  
> +	void			*data;
> +
>  	struct work_struct release_work;
>  };
>  
> 

-- 
Thanks,
Jeffle
