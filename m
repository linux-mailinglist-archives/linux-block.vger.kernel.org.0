Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126C9328506
	for <lists+linux-block@lfdr.de>; Mon,  1 Mar 2021 17:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhCAQrf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 1 Mar 2021 11:47:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:39158 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232958AbhCAQoi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Mar 2021 11:44:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BAD35AE05;
        Mon,  1 Mar 2021 16:43:49 +0000 (UTC)
Subject: Re: [PATCH] block: Drop leftover references to RQF_SORTED
To:     Jean Delvare <jdelvare@suse.de>, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.com>
References: <20210301120439.1fd0eb7b@endymion>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <16974aa3-8aca-3ae4-26a2-ae48ca603931@suse.de>
Date:   Mon, 1 Mar 2021 17:43:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210301120439.1fd0eb7b@endymion>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/1/21 12:04 PM, Jean Delvare wrote:
> Commit a1ce35fa49852db60fc6e268038530be533c5b15 ("block: remove dead
> elevator code") removed all users of RQF_SORTED. However it is still
> defined, and there is one reference left to it (which in effect is
> dead code). Clear it all up.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>   block/blk-mq-debugfs.c |    1 -
>   block/blk-mq-sched.c   |    3 ---
>   include/linux/blkdev.h |    2 --
>   3 files changed, 6 deletions(-)
> 
> --- linux-5.11.orig/block/blk-mq-sched.c	2021-02-14 23:32:24.000000000 +0100
> +++ linux-5.11/block/blk-mq-sched.c	2021-03-01 11:06:49.629077653 +0100
> @@ -408,9 +408,6 @@ static bool blk_mq_sched_bypass_insert(s
>   	if ((rq->rq_flags & RQF_FLUSH_SEQ) || blk_rq_is_passthrough(rq))
>   		return true;
>   
> -	if (has_sched)
> -		rq->rq_flags |= RQF_SORTED;
> -
>   	return false;
>   }
>   
> --- linux-5.11.orig/include/linux/blkdev.h	2021-02-14 23:32:24.000000000 +0100
> +++ linux-5.11/include/linux/blkdev.h	2021-03-01 11:07:16.006408847 +0100
> @@ -65,8 +65,6 @@ typedef void (rq_end_io_fn)(struct reque
>    * request flags */
>   typedef __u32 __bitwise req_flags_t;
>   
> -/* elevator knows about this request */
> -#define RQF_SORTED		((__force req_flags_t)(1 << 0))
>   /* drive already may have started this one */
>   #define RQF_STARTED		((__force req_flags_t)(1 << 1))
>   /* may not be passed by ioscheduler */
> --- linux-5.11.orig/block/blk-mq-debugfs.c	2021-02-14 23:32:24.000000000 +0100
> +++ linux-5.11/block/blk-mq-debugfs.c	2021-03-01 11:24:00.031637425 +0100
> @@ -292,7 +292,6 @@ static const char *const cmd_flag_name[]
>   
>   #define RQF_NAME(name) [ilog2((__force u32)RQF_##name)] = #name
>   static const char *const rqf_name[] = {
> -	RQF_NAME(SORTED),
>   	RQF_NAME(STARTED),
>   	RQF_NAME(SOFTBARRIER),
>   	RQF_NAME(FLUSH_SEQ),
> 
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
