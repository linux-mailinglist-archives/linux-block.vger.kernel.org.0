Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E78E3EA120
	for <lists+linux-block@lfdr.de>; Thu, 12 Aug 2021 10:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbhHLI6u (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Aug 2021 04:58:50 -0400
Received: from verein.lst.de ([213.95.11.211]:43467 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234600AbhHLI6u (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 04:58:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C3B2E67373; Thu, 12 Aug 2021 10:58:23 +0200 (CEST)
Date:   Thu, 12 Aug 2021 10:58:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH V4 1/7] mm: memcontrol: add helper of memcg_get_e_css
Message-ID: <20210812085823.GC2867@lst.de>
References: <20210806080302.298297-1-ming.lei@redhat.com> <20210806080302.298297-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806080302.298297-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 06, 2021 at 04:02:56PM +0800, Ming Lei wrote:
> And helper of memcg_get_e_css() so that the consumer needn't to
> call cgroup_get_e_css(cgroup, &memory_cgrp_subsys) directly, since
> &memory_cgrp_subsys has to be used in case that MEMCG is enabled.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  include/linux/memcontrol.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index bfe5c486f4ad..741852addbd7 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1101,6 +1101,11 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>  						gfp_t gfp_mask,
>  						unsigned long *total_scanned);
>  
> +static inline
> +struct cgroup_subsys_state *memcg_get_e_css(struct cgroup_subsys_state *css)

Please avoid this totally weird placement of the static and inline
specifiers.
