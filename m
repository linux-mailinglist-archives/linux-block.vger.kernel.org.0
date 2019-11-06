Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71989F0A41
	for <lists+linux-block@lfdr.de>; Wed,  6 Nov 2019 00:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbfKEXhF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 5 Nov 2019 18:37:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36631 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfKEXhE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Nov 2019 18:37:04 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so10497809plp.3
        for <linux-block@vger.kernel.org>; Tue, 05 Nov 2019 15:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=S9auKvEBV+sETFRScfOHE9qKwToRZk0DwQVCgin1pjI=;
        b=RIJkr9zSyIj1CHnDcygWA/9vvKZWqAW2lo74Ql+ezt50vcBSURve4kotRVR6MH4dlf
         vC9CGC1FqXM0eb0huTvLf0932S88Y7rR+bbOB4K+LONJRxxMCuWi2xh/y88l5v6NTrHa
         xaSS7Ru/wlbhvv7F/u9UAPnkBMAW/Fz8s9Yijm12JOFUz436tjkyMZl3WCAXHHc+k8Z2
         Ull0auvMwJDKemH3GiV6vykHWLmVT0wmYbdwTY6OMQok6svq6FkUqSCJwE2mimzuPiJg
         XWu28tSWmnEQ3PWA+74tHOEry6gMuejJR2vdBcN35Ak7WkGNOzZDD+IoTvC+brWj6xOX
         L9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S9auKvEBV+sETFRScfOHE9qKwToRZk0DwQVCgin1pjI=;
        b=hr+3GvuOTDZMdu0CquhqzP5LU6BIDV8BwP3I3sweam1Gv9Oo8IQWfOQTtUPZeimxb8
         teF46AYUu/KW6iCnzvfSYDqIP9XXk6+HkZPkZ10GYi++SM6gIrVdt06c+LBnG9KK8UXe
         MqwKIc+M3dNI3O7WTNZW2wRYbkzUxfmUSURgJam/GQ+psegXyz1RTBXW1sA6nG5cKpVI
         irf1d7mkAiA1yYmxO52f4fuhN27NYbxfM/OJyl2MV7Ex1HMQsquQVkq2IQrj1yz1cDSa
         s9Hz4tE5i7WYel/UbgHavkj1lviNQq+PAmFhTSFs8qoN7xhxbA+deF7NRqDLnRc5NQbW
         LDmw==
X-Gm-Message-State: APjAAAXxLVCvsUphCCwHhGuXrPzU/KG/TMBZtJuRqIUv6B7G8eU0vqsu
        I5yPvGGuptX0F1/vyp5Cazz3uCEwwmw=
X-Google-Smtp-Source: APXvYqyCGwOCnaBnVkkGbrJ03wjKeNCDjVSFvnr2vpVUd/DFdW9ljCGpq4IJ2aAocsNiyjh+TjJIOA==
X-Received: by 2002:a17:902:bcc2:: with SMTP id o2mr36554143pls.281.1572997023658;
        Tue, 05 Nov 2019 15:37:03 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::12c1? ([2620:10d:c090:180::d575])
        by smtp.gmail.com with ESMTPSA id x125sm24814559pfb.93.2019.11.05.15.37.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 15:37:02 -0800 (PST)
Subject: Re: [PATCH 3/3] io_uring: use inlined struct sqe_submit
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
References: <cover.1572993994.git.asml.silence@gmail.com>
 <e9f1f564ec60748c4ad266ec6bace9b2df392b58.1572993994.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <589994ea-6528-eac0-e0c6-b496ee5bebd2@kernel.dk>
Date:   Tue, 5 Nov 2019 16:37:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e9f1f564ec60748c4ad266ec6bace9b2df392b58.1572993994.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/5/19 4:04 PM, Pavel Begunkov wrote:
> @@ -2475,31 +2475,30 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
>   	return ret;
>   }
>   
> -static int io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
> -			struct sqe_submit *s)
> +static int io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req)
>   {
>   	int ret;
>   
> -	ret = io_req_defer(ctx, req, s->sqe);
> +	ret = io_req_defer(ctx, req);
>   	if (ret) {
>   		if (ret != -EIOCBQUEUED) {
>   			io_free_req(req, NULL);
> -			io_cqring_add_event(ctx, s->sqe->user_data, ret);
> +			io_cqring_add_event(ctx, req->submit.sqe->user_data, ret);

Cases like these are now (or can be) use-after-free. Same with this one:

> @@ -2507,12 +2506,12 @@ static int io_queue_link_head(struct io_ring_ctx *ctx, struct io_kiocb *req,
>   	 * list.
>   	 */
>   	req->flags |= REQ_F_IO_DRAIN;
> -	ret = io_req_defer(ctx, req, s->sqe);
> +	ret = io_req_defer(ctx, req);
>   	if (ret) {
>   		if (ret != -EIOCBQUEUED) {
>   			io_free_req(req, NULL);
>   			__io_free_req(shadow);
> -			io_cqring_add_event(ctx, s->sqe->user_data, ret);
> +			io_cqring_add_event(ctx, req->submit.sqe->user_data, ret);
>   			return 0;

Free the req, then deref it...

-- 
Jens Axboe

