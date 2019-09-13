Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12CDBB18A5
	for <lists+linux-block@lfdr.de>; Fri, 13 Sep 2019 09:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfIMHIM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 13 Sep 2019 03:08:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:54552 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727380AbfIMHIL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Sep 2019 03:08:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 34867AF23;
        Fri, 13 Sep 2019 07:08:09 +0000 (UTC)
Subject: Re: [PATCH] io_uring: extend async work merging
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <0b62fee7-d3bd-f60e-ae81-27880f42d508@kernel.dk>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e1e49ab6-108c-6da9-ebfb-c47ffd1c89b5@suse.com>
Date:   Fri, 13 Sep 2019 10:08:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0b62fee7-d3bd-f60e-ae81-27880f42d508@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 11.09.19 г. 19:15 ч., Jens Axboe wrote:
> We currently merge async work items if we see a strict sequential hit.
> This helps avoid unnecessary workqueue switches when we don't need
> them. We can extend this merging to cover cases where it's not a strict
> sequential hit, but the IO still fits within the same page. If an
> application is doing multiple requests within the same page, we don't
> want separate workers waiting on the same page to complete IO. It's much
> faster to let the first worker bring in the page, then operate on that
> page from the same worker to complete the next request(s).
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 03fcd974fd1d..4bc3ee4ea81f 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -167,7 +167,7 @@ struct async_list {
>  	struct list_head	list;
>  
>  	struct file		*file;
> -	off_t			io_end;
> +	off_t			io_start;
>  	size_t			io_len;
>  };
>  
> @@ -1189,6 +1189,28 @@ static ssize_t io_import_iovec(struct io_ring_ctx *ctx, int rw,
>  	return import_iovec(rw, buf, sqe_len, UIO_FASTIOV, iovec, iter);
>  }
>  
> +static inline bool io_should_merge(struct async_list *al, struct kiocb *kiocb)
> +{
> +	if (al->file == kiocb->ki_filp) {
> +		off_t start, end;
> +
> +		/*
> +		 * Allow merging if we're anywhere in the range of the same
> +		 * page. Generally this happens for sub-page reads or writes,
> +		 * and it's beneficial to allow the first worker to bring the
> +		 * page in and the piggy backed work can then work on the
> +		 * cached page.
> +		 */
> +		start = al->io_start & PAGE_MASK;

nit: round_down(al->io_start, PAGE_SIZE);

> +		end = (al->io_start + al->io_len + PAGE_SIZE - 1) & PAGE_MASK;
nit: round_up(al->io_start+io_len, PAGE_SIZE)

> +		if (kiocb->ki_pos >= start && kiocb->ki_pos <= end)
> +			return true;
> +	}
> +
> +	al->file = NULL;
> +	return false;
> +}
> +
>  /*
>   * Make a note of the last file/offset/direction we punted to async
>   * context. We'll use this information to see if we can piggy back a
> @@ -1200,9 +1222,8 @@ static void io_async_list_note(int rw, struct io_kiocb *req, size_t len)
>  	struct async_list *async_list = &req->ctx->pending_async[rw];
>  	struct kiocb *kiocb = &req->rw;
>  	struct file *filp = kiocb->ki_filp;
> -	off_t io_end = kiocb->ki_pos + len;
>  
> -	if (filp == async_list->file && kiocb->ki_pos == async_list->io_end) {
> +	if (io_should_merge(async_list, kiocb)) {
>  		unsigned long max_bytes;
>  
>  		/* Use 8x RA size as a decent limiter for both reads/writes */
> @@ -1215,17 +1236,16 @@ static void io_async_list_note(int rw, struct io_kiocb *req, size_t len)
>  			req->flags |= REQ_F_SEQ_PREV;
>  			async_list->io_len += len;
>  		} else {
> -			io_end = 0;
> -			async_list->io_len = 0;
> +			async_list->file = NULL;
>  		}
>  	}
>  
>  	/* New file? Reset state. */
>  	if (async_list->file != filp) {
> -		async_list->io_len = 0;
> +		async_list->io_start = kiocb->ki_pos;
> +		async_list->io_len = len;
>  		async_list->file = filp;
>  	}
> -	async_list->io_end = io_end;
>  }
>  
>  static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
> @@ -1994,7 +2014,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
>   */
>  static bool io_add_to_prev_work(struct async_list *list, struct io_kiocb *req)
>  {
> -	bool ret = false;
> +	bool ret;
>  
>  	if (!list)
>  		return false;
> 
