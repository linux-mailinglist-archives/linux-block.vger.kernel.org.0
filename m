Return-Path: <linux-block+bounces-978-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFF580DF84
	for <lists+linux-block@lfdr.de>; Tue, 12 Dec 2023 00:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69BE01F202A3
	for <lists+linux-block@lfdr.de>; Mon, 11 Dec 2023 23:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9B45675D;
	Mon, 11 Dec 2023 23:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glzyQQ6a"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E87156474
	for <linux-block@vger.kernel.org>; Mon, 11 Dec 2023 23:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A840DC433C8;
	Mon, 11 Dec 2023 23:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702337481;
	bh=DgbCvgyHK/s3+736W6JdynWX2EfKxLlFQUfizpxJbHk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=glzyQQ6azQmy+DYaY70N/Q8CDnNJxba7n3Om+3fFJ0ZfBWMfRovrWLjjfot1WUDSw
	 /HUluiYDSrRu78+CyxFW9dQL0f+UkvBJCdRnTzZzclj8AMtoNv01HW3XjBsMfgNdy0
	 pX4pNET3N0FiJVd9nEY6FJJEWK+TI4TwDv8zCmXw+v2XQByNwTiZyp2IEcGhElvutb
	 AF6a78QSAiaVSTR814atnS7tQRz2VEy6QGtog4G3w+0GzLrYqlQHV9dl1OY7YIi+5B
	 LLdu3EdYiu2ZoF0wPS1rNo9acd2v1LFPLEqQpOD3W/wOEzvqU4vAax1ltBdM043Gl4
	 AkBcAVDsNpDvA==
Message-ID: <19eaaa5b-e4b7-41aa-b5a2-7d5a89927a91@kernel.org>
Date: Tue, 12 Dec 2023 08:31:19 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/blk-ioprio: Skip zoned writes that are not append
 operations
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20231211231451.1452979-1-bvanassche@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231211231451.1452979-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/23 08:14, Bart Van Assche wrote:
> If REQ_OP_WRITE or REQ_OP_WRITE_ZEROES operations for the same zone
> originate from different cgroups that could result in different
> priorities being assigned to these operations. Do not modify the I/O
> priority of these write operations to prevent that these would be
> executed in the wrong order when using the mq-deadline I/O

...to prevent them from being executed in the wrong...

> scheduler.
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-ioprio.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
> index 4051fada01f1..09ce083a0e3a 100644
> --- a/block/blk-ioprio.c
> +++ b/block/blk-ioprio.c
> @@ -192,6 +192,17 @@ void blkcg_set_ioprio(struct bio *bio)
>  	if (!blkcg || blkcg->prio_policy == POLICY_NO_CHANGE)
>  		return;
>  
> +	/*
> +	 * If REQ_OP_WRITE or REQ_OP_WRITE_ZEROES operations for the same zone
> +	 * originate from different cgroups that could result in different
> +	 * priorities being assigned to these operations. Do not modify the I/O
> +	 * priority of these write operations to prevent that these would be
> +	 * executed in the wrong order when using the mq-deadline I/O
> +	 * scheduler.
> +	 */
> +	if (bdev_op_is_zoned_write(bio->bi_bdev, bio_op(bio)))

Ideally, we want the bio equivalent of blk_rq_is_seq_zoned_write() here so that
writes to conventional zones are not affected (these can be reordered).

> +		return;
> +
>  	if (blkcg->prio_policy == POLICY_PROMOTE_TO_RT ||
>  	    blkcg->prio_policy == POLICY_NONE_TO_RT) {
>  		/*

-- 
Damien Le Moal
Western Digital Research


