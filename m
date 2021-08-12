Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD543EA2EC
	for <lists+linux-block@lfdr.de>; Thu, 12 Aug 2021 12:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbhHLKVk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Aug 2021 06:21:40 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3642 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbhHLKVj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 06:21:39 -0400
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GljPb1Yc6z6G9MK;
        Thu, 12 Aug 2021 18:20:35 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 12 Aug 2021 12:21:13 +0200
Received: from [10.47.80.186] (10.47.80.186) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 12 Aug
 2021 11:21:12 +0100
Subject: Re: [PATCH] blk-mq: fix kernel panic during iterating over flush
 request
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        "Blank-Burian, Markus, Dr." <blankburian@uni-muenster.de>
References: <20210811142624.618598-1-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <93a6693c-9927-eff6-bd8a-5ec5aa3fef40@huawei.com>
Date:   Thu, 12 Aug 2021 11:20:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210811142624.618598-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.186]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/08/2021 15:26, Ming Lei wrote:
> For fixing use-after-free during iterating over requests, we grabbed
> request's refcount before calling ->fn in commit 2e315dc07df0 ("blk-mq:
> grab rq->refcount before calling ->fn in blk_mq_tagset_busy_iter").
> Turns out this way may cause kernel panic when iterating over one flush
> request:
> 
> 1) old flush request's tag is just released, and this tag is reused by
> one new request, but ->rqs[] isn't updated yet
> 
> 2) the flush request can be re-used for submitting one new flush command,
> so blk_rq_init() is called at the same time
> 
> 3) meantime blk_mq_queue_tag_busy_iter() is called, and old flush request
> is retrieved from ->rqs[tag]; when blk_mq_put_rq_ref() is called,
> flush_rq->end_io may not be updated yet, so NULL pointer dereference
> is triggered in blk_mq_put_rq_ref().
> 
> Fix the issue by calling refcount_set(&flush_rq->ref, 1) after
> flush_rq->end_io is set. So far the only other caller of blk_rq_init() is
> scsi_ioctl_reset() in which the request doesn't enter block IO stack and
> the request reference count isn't used, so the change is safe.
> 
> Fixes: 2e315dc07df0 ("blk-mq: grab rq->refcount before calling ->fn in
> blk_mq_tagset_busy_iter")
> Reported-by: "Blank-Burian, Markus, Dr." <blankburian@uni-muenster.de>
> Tested-by: "Blank-Burian, Markus, Dr." <blankburian@uni-muenster.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

it looks ok:

Reviewed-by: John Garry <john.garry@huawei.com>

> ---
>   block/blk-core.c  | 1 -
>   block/blk-flush.c | 8 ++++++++
>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 0874bc2fcdb4..b5098739f72a 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -121,7 +121,6 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
>   	rq->internal_tag = BLK_MQ_NO_TAG;
>   	rq->start_time_ns = ktime_get_ns();
>   	rq->part = NULL;
> -	refcount_set(&rq->ref, 1);
>   	blk_crypto_rq_set_defaults(rq);
>   }
>   EXPORT_SYMBOL(blk_rq_init);
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 1002f6c58181..4912c8dbb1d8 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -329,6 +329,14 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
>   	flush_rq->rq_flags |= RQF_FLUSH_SEQ;
>   	flush_rq->rq_disk = first_rq->rq_disk;
>   	flush_rq->end_io = flush_end_io;
> +	/*
> +	 * Order WRITE ->end_io and WRITE rq->ref, and its pair is the one
> +	 * implied in refcount_inc_not_zero() called from
> +	 * blk_mq_find_and_get_req(), which orders WRITE/READ flush_rq->ref
> +	 * and READ flush_rq->end_io
> +	 */
> +	smp_wmb();
> +	refcount_set(&flush_rq->ref, 1);
