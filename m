Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8646329267F
	for <lists+linux-block@lfdr.de>; Mon, 19 Oct 2020 13:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgJSLkP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 19 Oct 2020 07:40:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:44484 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgJSLkP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Oct 2020 07:40:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603107613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SSs1O1InoOlCF59eFFQsx8VtfWEtNgznhwL4lQxQydU=;
        b=F1HkXC8CTRjdHRaMQnpslvAIzpzB81yHyVDyrEzXQAj72BQucTwGVouULydotSEQJIR4mC
        rpP/J1o5etlaR5L6XTTU+io6aumU4xmKVprAouxkrOSFbI3V3V6xI9F0KcIGPvTp9sOG8I
        LgoTvUk5pScVkMiNAlLBCRV3tVteIDI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3A38BAC55;
        Mon, 19 Oct 2020 11:40:13 +0000 (UTC)
Date:   Mon, 19 Oct 2020 13:40:11 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     axboe@kernel.dk, raghavendra.kt@linux.vnet.ibm.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: remove the calling of local_memory_node()
Message-ID: <20201019114011.GE27114@dhcp22.suse.cz>
References: <20201019082047.31113-1-tian.xianting@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019082047.31113-1-tian.xianting@h3c.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon 19-10-20 16:20:47, Xianting Tian wrote:
> We don't need to check whether the node is memoryless numa node before
> calling allocator interface. SLUB(and SLAB,SLOB) relies on the page
> allocator to pick a node. Page allocator should deal with memoryless
> nodes just fine. It has zonelists constructed for each possible nodes.
> And it will automatically fall back into a node which is closest to the
> requested node. As long as __GFP_THISNODE is not enforced of course.
> 
> The code comments of kmem_cache_alloc_node() of SLAB also showed this:
>  * Fallback to other node is possible if __GFP_THISNODE is not set.
> 
> blk-mq code doesn't set __GFP_THISNODE, so we can remove the calling
> of local_memory_node().

yes, this is indeed the case. I cannot really judge the blg-mq code but
it seems to be unnecessary. Maybe there are some subtle details not
explained by bffed457160ab though.

> Fixes: bffed457160ab ("blk-mq: Avoid memoryless numa node encoded in hctx numa_node")

But the existing code is not broken. It just overdoes what needs to be
done. So effectively bffed457160ab was not needed. I do not think that
Fixes is really necessary.

> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> ---
>  block/blk-mq-cpumap.c | 2 +-
>  block/blk-mq.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> index 0157f2b34..3db84d319 100644
> --- a/block/blk-mq-cpumap.c
> +++ b/block/blk-mq-cpumap.c
> @@ -89,7 +89,7 @@ int blk_mq_hw_queue_to_node(struct blk_mq_queue_map *qmap, unsigned int index)
>  
>  	for_each_possible_cpu(i) {
>  		if (index == qmap->mq_map[i])
> -			return local_memory_node(cpu_to_node(i));
> +			return cpu_to_node(i);
>  	}
>  
>  	return NUMA_NO_NODE;
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index cdced4aca..48f8366b2 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2737,7 +2737,7 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
>  		for (j = 0; j < set->nr_maps; j++) {
>  			hctx = blk_mq_map_queue_type(q, j, i);
>  			if (nr_hw_queues > 1 && hctx->numa_node == NUMA_NO_NODE)
> -				hctx->numa_node = local_memory_node(cpu_to_node(i));
> +				hctx->numa_node = cpu_to_node(i);
>  		}
>  	}
>  }
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
