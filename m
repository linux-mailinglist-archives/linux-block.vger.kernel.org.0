Return-Path: <linux-block+bounces-707-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB384804518
	for <lists+linux-block@lfdr.de>; Tue,  5 Dec 2023 03:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11317281421
	for <lists+linux-block@lfdr.de>; Tue,  5 Dec 2023 02:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF6BCA58;
	Tue,  5 Dec 2023 02:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EWTqBpey"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93B1B6
	for <linux-block@vger.kernel.org>; Mon,  4 Dec 2023 18:39:40 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b9ba82d8ccso693541b6e.1
        for <linux-block@vger.kernel.org>; Mon, 04 Dec 2023 18:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701743980; x=1702348780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H3tOJXY8IizW0u24gL21FfDp3aMmLoVYHrrK5m++rGY=;
        b=EWTqBpeysG0Ffixnn6IDwVLVP7ZaTePIuc5EXLJvsOZRHSMM359zyD4v8jR1M7w3JY
         Moi6RWYqRJJt1g+k6Tlz8ebdPZWpbdBFeqSIbo5oi/KgO0nuEDUprrwQqOSVdhpC8fql
         EtrvCB+JUHTb3ilteiMCFEw5Rh5LWPnXSzAdFi4uQjLDDSyrVvHtIZe+tORknzn3ufPP
         Vxvk3JgGjBQQw06h4fy/FzfdsvV7S28HrwizqtI8zZ2Ebd6kEm/AXnBsyhKkZpNCh95c
         iP+AqfsmbPjTlsh039M8uITBQo5f1wf11Blivzl7iSqFrIENSIV8RDVPj1w9rBQ8Bhdg
         T+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701743980; x=1702348780;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H3tOJXY8IizW0u24gL21FfDp3aMmLoVYHrrK5m++rGY=;
        b=L34+r1ddRsdyCHsWsmNdUSPImPg2u0hgSNyXFfGzkK2BWhHTUdaWyPb8FRnTt0sY6H
         g9a21hxDqjOEe8RJwABb4foXdbOCjmLBsKYQmlDyl2RwRslFwK3wM05Mwog0OwVbySxT
         2FO584XWqAECfi945gf+chL7u+B+lFOQahAIwNduUQDVKizt/42d4vIF7vZzApsyKiQR
         J+6rTupwOmc3HTKxWJ93NOo9mairPYepe+O0biuW73J0ETIx67mEAt1rqpD4OISDeRCe
         jurmJHGU2yrVmFVKtQx1C6afbxIhekdmbYsHTfeFHOXCEIay4gAliFje4utrkDYdiKVi
         a4SQ==
X-Gm-Message-State: AOJu0YwmdVcA3wYJMYO45azlXHHAiEZvPkH5xPycxwBXvlRMp2lkE9SX
	FvwFT0EbLcQtq+ts104oWwRIOA==
X-Google-Smtp-Source: AGHT+IF6wyUzi1d6qZQ9qidrICNEvSECadlo+kwhV9QQutoYLrx7Xql9+XRRN62a5erALuknzEMtBA==
X-Received: by 2002:a05:6808:1204:b0:3b8:b063:505f with SMTP id a4-20020a056808120400b003b8b063505fmr6332590oil.96.1701743980087;
        Mon, 04 Dec 2023 18:39:40 -0800 (PST)
Received: from [10.255.170.18] ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id bm10-20020a056a00320a00b006cbafd6996csm8319731pfb.123.2023.12.04.18.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 18:39:39 -0800 (PST)
Message-ID: <ef07f915-e598-402e-bb2b-011bb0aebd7f@bytedance.com>
Date: Tue, 5 Dec 2023 10:39:29 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/35] block: null_blk: fix opencoded
 find_and_set_bit() in get_tag()
Content-Language: en-US
To: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Ming Lei <ming.lei@redhat.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Akinobu Mita
 <akinobu.mita@gmail.com>, Shin'ichiro Kawasaki
 <shinichiro.kawasaki@wdc.com>, linux-block@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Mirsad Todorovac
 <mirsad.todorovac@alu.unizg.hr>, Matthew Wilcox <willy@infradead.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
 Alexey Klimov <klimov.linux@gmail.com>, Bart Van Assche
 <bvanassche@acm.org>, Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
 <20231203193307.542794-23-yury.norov@gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20231203193307.542794-23-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023/12/4 03:32, Yury Norov wrote:
> get_tag() opencodes find_and_set_bit(). Switch the code to use the
> dedicated function, and get rid of get_tag entirely.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Looks good to me!

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

> ---
>  drivers/block/null_blk/main.c | 41 +++++++++++------------------------
>  1 file changed, 13 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 3021d58ca51c..671dbb9ab928 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -760,19 +760,6 @@ static void put_tag(struct nullb_queue *nq, unsigned int tag)
>  		wake_up(&nq->wait);
>  }
>  
> -static unsigned int get_tag(struct nullb_queue *nq)
> -{
> -	unsigned int tag;
> -
> -	do {
> -		tag = find_first_zero_bit(nq->tag_map, nq->queue_depth);
> -		if (tag >= nq->queue_depth)
> -			return -1U;
> -	} while (test_and_set_bit_lock(tag, nq->tag_map));
> -
> -	return tag;
> -}
> -
>  static void free_cmd(struct nullb_cmd *cmd)
>  {
>  	put_tag(cmd->nq, cmd->tag);
> @@ -782,24 +769,22 @@ static enum hrtimer_restart null_cmd_timer_expired(struct hrtimer *timer);
>  
>  static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq)
>  {
> +	unsigned int tag = find_and_set_bit_lock(nq->tag_map, nq->queue_depth);
>  	struct nullb_cmd *cmd;
> -	unsigned int tag;
> -
> -	tag = get_tag(nq);
> -	if (tag != -1U) {
> -		cmd = &nq->cmds[tag];
> -		cmd->tag = tag;
> -		cmd->error = BLK_STS_OK;
> -		cmd->nq = nq;
> -		if (nq->dev->irqmode == NULL_IRQ_TIMER) {
> -			hrtimer_init(&cmd->timer, CLOCK_MONOTONIC,
> -				     HRTIMER_MODE_REL);
> -			cmd->timer.function = null_cmd_timer_expired;
> -		}
> -		return cmd;
> +
> +	if (tag >= nq->queue_depth)
> +		return NULL;
> +
> +	cmd = &nq->cmds[tag];
> +	cmd->tag = tag;
> +	cmd->error = BLK_STS_OK;
> +	cmd->nq = nq;
> +	if (nq->dev->irqmode == NULL_IRQ_TIMER) {
> +		hrtimer_init(&cmd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +		cmd->timer.function = null_cmd_timer_expired;
>  	}
>  
> -	return NULL;
> +	return cmd;
>  }
>  
>  static struct nullb_cmd *alloc_cmd(struct nullb_queue *nq, struct bio *bio)

