Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EBF2CD5BF
	for <lists+linux-block@lfdr.de>; Thu,  3 Dec 2020 13:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgLCMrO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 3 Dec 2020 07:47:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:33470 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728940AbgLCMrO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Dec 2020 07:47:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3FE8DAC65;
        Thu,  3 Dec 2020 12:46:32 +0000 (UTC)
Subject: Re: [PATCH 2/5] block: simplify and extended the block_bio_merge
 tracepoint class
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-s390@vger.kernel.org
References: <20201130175854.982460-1-hch@lst.de>
 <20201130175854.982460-3-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <168a66f3-326f-6cb5-3153-e7ab75e332a6@suse.de>
Date:   Thu, 3 Dec 2020 13:46:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201130175854.982460-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/20 6:58 PM, Christoph Hellwig wrote:
> The block_bio_merge tracepoint class can be reused for most bio-based
> tracepoints.  For that is just needs to lose the superflous and rq

'and rq' ?
Do you mean 'q and rq'?

> parameters.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-core.c             |   2 +-
>   block/blk-merge.c            |   4 +-
>   block/blk-mq.c               |   2 +-
>   block/bounce.c               |   2 +-
>   include/trace/events/block.h | 158 ++++++++---------------------------
>   kernel/trace/blktrace.c      |  41 +++------
>   6 files changed, 48 insertions(+), 161 deletions(-)
> 
Otherwise:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
