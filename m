Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3925C250CB3
	for <lists+linux-block@lfdr.de>; Tue, 25 Aug 2020 02:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgHYABx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 24 Aug 2020 20:01:53 -0400
Received: from mail.hallyn.com ([178.63.66.53]:48840 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHYABw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Aug 2020 20:01:52 -0400
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Aug 2020 20:01:51 EDT
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id ABFEF11ED; Mon, 24 Aug 2020 18:51:53 -0500 (CDT)
Date:   Mon, 24 Aug 2020 18:51:53 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Khazhismel Kumykov <khazhy@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Serge Hallyn <serge@hallyn.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] block: grant IOPRIO_CLASS_RT to CAP_SYS_NICE
Message-ID: <20200824235153.GA12526@mail.hallyn.com>
References: <20200824221034.2170308-1-khazhy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824221034.2170308-1-khazhy@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 24, 2020 at 03:10:34PM -0700, Khazhismel Kumykov wrote:
> CAP_SYS_ADMIN is too broad, and ionice fits into CAP_SYS_NICE's grouping.
> 
> Retain CAP_SYS_ADMIN permission for backwards compatibility.
> 
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

> ---
>  block/ioprio.c                  | 2 +-
>  include/uapi/linux/capability.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> v2: fix embarrassing logic mistake
> diff --git a/block/ioprio.c b/block/ioprio.c
> index 77bcab11dce5..276496246fe9 100644
> --- a/block/ioprio.c
> +++ b/block/ioprio.c
> @@ -69,7 +69,7 @@ int ioprio_check_cap(int ioprio)
>  
>  	switch (class) {
>  		case IOPRIO_CLASS_RT:
> -			if (!capable(CAP_SYS_ADMIN))
> +			if (!capable(CAP_SYS_NICE) && !capable(CAP_SYS_ADMIN))
>  				return -EPERM;
>  			/* fall through */
>  			/* rt has prio field too */
> diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
> index 395dd0df8d08..c6ca33034147 100644
> --- a/include/uapi/linux/capability.h
> +++ b/include/uapi/linux/capability.h
> @@ -288,6 +288,8 @@ struct vfs_ns_cap_data {
>     processes and setting the scheduling algorithm used by another
>     process. */
>  /* Allow setting cpu affinity on other processes */
> +/* Allow setting realtime ioprio class */
> +/* Allow setting ioprio class on other processes */
>  
>  #define CAP_SYS_NICE         23
>  
> -- 
> 2.28.0.297.g1956fa8f8d-goog
