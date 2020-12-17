Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319D22DCD47
	for <lists+linux-block@lfdr.de>; Thu, 17 Dec 2020 08:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgLQH6M (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 17 Dec 2020 02:58:12 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:39352 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726613AbgLQH6M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 02:58:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UIuR5Z9_1608191844;
Received: from 30.21.164.59(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UIuR5Z9_1608191844)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Dec 2020 15:57:25 +0800
Subject: Re: [PATCH 1/2] blk-iocost: Add iocg idle state tracepoint
To:     axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1ba7a38d5a6186b1e71432ef424c23ba1904a365.1607591591.git.baolin.wang@linux.alibaba.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <3aa9c1a1-5640-b60c-4fab-22ee7de40539@linux.alibaba.com>
Date:   Thu, 17 Dec 2020 15:57:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <1ba7a38d5a6186b1e71432ef424c23ba1904a365.1607591591.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

> It will be helpful to trace the iocg's whole state, including active and
> idle state. And we can easily expand the original iocost_iocg_activate
> trace event to support a state trace class, including active and idle
> state tracing.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Could you pick up patch 1 which was already acked by Tejun. Thanks.

> ---
>   block/blk-iocost.c            |  3 +++
>   include/trace/events/iocost.h | 16 +++++++++++++++-
>   2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index ffa418c..ac6078a 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -2185,6 +2185,9 @@ static int ioc_check_iocgs(struct ioc *ioc, struct ioc_now *now)
>   							    WEIGHT_ONE);
>   			}
>   
> +			TRACE_IOCG_PATH(iocg_idle, iocg, now,
> +					atomic64_read(&iocg->active_period),
> +					atomic64_read(&ioc->cur_period), vtime);
>   			__propagate_weights(iocg, 0, 0, false, now);
>   			list_del_init(&iocg->active_list);
>   		}
> diff --git a/include/trace/events/iocost.h b/include/trace/events/iocost.h
> index 0b68699..e282ce0 100644
> --- a/include/trace/events/iocost.h
> +++ b/include/trace/events/iocost.h
> @@ -11,7 +11,7 @@
>   
>   #include <linux/tracepoint.h>
>   
> -TRACE_EVENT(iocost_iocg_activate,
> +DECLARE_EVENT_CLASS(iocost_iocg_state,
>   
>   	TP_PROTO(struct ioc_gq *iocg, const char *path, struct ioc_now *now,
>   		u64 last_period, u64 cur_period, u64 vtime),
> @@ -59,6 +59,20 @@
>   	)
>   );
>   
> +DEFINE_EVENT(iocost_iocg_state, iocost_iocg_activate,
> +	TP_PROTO(struct ioc_gq *iocg, const char *path, struct ioc_now *now,
> +		 u64 last_period, u64 cur_period, u64 vtime),
> +
> +	TP_ARGS(iocg, path, now, last_period, cur_period, vtime)
> +);
> +
> +DEFINE_EVENT(iocost_iocg_state, iocost_iocg_idle,
> +	TP_PROTO(struct ioc_gq *iocg, const char *path, struct ioc_now *now,
> +		 u64 last_period, u64 cur_period, u64 vtime),
> +
> +	TP_ARGS(iocg, path, now, last_period, cur_period, vtime)
> +);
> +
>   DECLARE_EVENT_CLASS(iocg_inuse_update,
>   
>   	TP_PROTO(struct ioc_gq *iocg, const char *path, struct ioc_now *now,
> 
