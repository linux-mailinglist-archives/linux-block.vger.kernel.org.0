Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943704102F2
	for <lists+linux-block@lfdr.de>; Sat, 18 Sep 2021 04:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbhIRCZO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 17 Sep 2021 22:25:14 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:58401 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232711AbhIRCZN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Sep 2021 22:25:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UojoMEt_1631931828;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UojoMEt_1631931828)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 18 Sep 2021 10:23:48 +0800
Subject: Re: [PATCH] block/mq-deadline: Fix unused-function compilation
 warning
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210901064705.55071-1-tianjia.zhang@linux.alibaba.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <90507369-7beb-5337-5bb3-f5e2798dee2f@linux.alibaba.com>
Date:   Sat, 18 Sep 2021 10:23:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210901064705.55071-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping.

On 9/1/21 2:47 PM, Tianjia Zhang wrote:
> If CONFIG_BLK_DEBUG_FS is not defined, the following compilation warning
> will be reported:
> 
>    block/mq-deadline.c:274:12: warning: ‘dd_queued’ defined but not used [-Wunused-function]
>     static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
> 
> Move the function dd_queued() to the scope of this config and mark it
> inline.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>   block/mq-deadline.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 3c3693c34f06..084314ee878d 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -270,12 +270,6 @@ deadline_move_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>   	deadline_remove_request(rq->q, per_prio, rq);
>   }
>   
> -/* Number of requests queued for a given priority level. */
> -static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
> -{
> -	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
> -}
> -
>   /*
>    * deadline_check_fifo returns 0 if there are no expired requests on the fifo,
>    * 1 otherwise. Requires !list_empty(&dd->fifo_list[data_dir])
> @@ -953,6 +947,12 @@ static int dd_async_depth_show(void *data, struct seq_file *m)
>   	return 0;
>   }
>   
> +/* Number of requests queued for a given priority level. */
> +static inline u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
> +{
> +	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
> +}
> +
>   static int dd_queued_show(void *data, struct seq_file *m)
>   {
>   	struct request_queue *q = data;
> 
