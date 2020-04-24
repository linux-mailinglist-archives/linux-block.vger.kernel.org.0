Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAC11B759B
	for <lists+linux-block@lfdr.de>; Fri, 24 Apr 2020 14:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgDXMnK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 24 Apr 2020 08:43:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:56516 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgDXMnK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 08:43:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 07802AD0F;
        Fri, 24 Apr 2020 12:43:08 +0000 (UTC)
Subject: Re: [PATCH V8 01/11] block: clone nr_integrity_segments and
 write_hint in blk_rq_prep_clone
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-2-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <43e63bfd-fd63-b9b8-d8db-64bff93f84be@suse.de>
Date:   Fri, 24 Apr 2020 14:43:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424102351.475641-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/24/20 12:23 PM, Ming Lei wrote:
> So far blk_rq_prep_clone() is only used for setup one underlying cloned
> request from dm-rq request. block intetrity can be enabled for both dm-rq
> and the underlying queues, so it is reasonable to clone rq's
> nr_integrity_segments. Also write_hint is from bio, it should have been
> cloned too.
> 
> So clone nr_integrity_segments and write_hint in blk_rq_prep_clone.
> 
> Cc: John Garry <john.garry@huawei.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: dm-devel@redhat.com
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-core.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 7e4a1da0715e..91537e526b45 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1636,9 +1636,13 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
>   		rq->rq_flags |= RQF_SPECIAL_PAYLOAD;
>   		rq->special_vec = rq_src->special_vec;
>   	}
> +#ifdef CONFIG_BLK_DEV_INTEGRITY
> +	rq->nr_integrity_segments = rq_src->nr_integrity_segments;
> +#endif
>   	rq->nr_phys_segments = rq_src->nr_phys_segments;
>   	rq->ioprio = rq_src->ioprio;
>   	rq->extra_len = rq_src->extra_len;
> +	rq->write_hint = rq_src->write_hint;
>   
>   	return 0;
>   
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
