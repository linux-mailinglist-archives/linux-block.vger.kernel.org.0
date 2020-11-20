Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7A92BB4F8
	for <lists+linux-block@lfdr.de>; Fri, 20 Nov 2020 20:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbgKTTNx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 20 Nov 2020 14:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbgKTTNx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Nov 2020 14:13:53 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061FDC0613CF
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2020 11:13:53 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id y9so9526218ilb.0
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2020 11:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=tvNx5XnyWpt/n1aMipepTW4MqUSEwdEoKFXk+0/H3qI=;
        b=RDxVpA9P+JmgpmGIkLFsXCHlHxgLx/38Mh8SquDC9s24USPwHA40d5HPTYmUZL+LUd
         yeGXGQPsyd4SFqE2GqP9fVAtVTOwBNkPiRzhV4Vn14wvbEBTrfe/ueC3nwQQCK4GgNQ7
         zOqKK0IimHf9/Lt3myrkdxsHqk04UpoM/aZ8wYLR+JSCGis/xzvI9+zg4O70xYCuG1V0
         i1VW6LVg2U9kGzaW+dCnAv1Igg/3OzhNOjkA0xcPuXc07L+XkMlfiUzaf9+RcxONCWFE
         Ow0Duz6Ubccz0ZMAG71VFzAyvhiniVAs+/pvKOTIxdWVKOmRbGAHqfKMo8J6aCWG+rac
         qeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tvNx5XnyWpt/n1aMipepTW4MqUSEwdEoKFXk+0/H3qI=;
        b=OiYaxcgVVla1gI+6xQ0rJR5A0nLQgtVuykYelg99FTmhHcwRNTeDIbP0LD31177HJb
         rVTLJIWJ1DRkAU2KYYSqEeZ56pYcQ4hNkF0Z4qUkAgvC5XkoSiUoVlbqEwqKCzfVkA/P
         8CNS5Hyt/vGFfa3YW4zHH4MxTpV5hjVI3YHxPDeOq7swapU4GpeMipcd2/n9ohjlVcg3
         sT2goa59YpqARFEA+9SuAwpgpD47oK9/FOgZilHQPns+PsjshYnSDA2B4xafSJQUUTFd
         /YJ3o8Cyq2Mp+xVRvndbF+yfVOqrCn31LB5mZfD2mVD0IjKaJdIZuuQBq1SUkc9oyBf2
         0ROw==
X-Gm-Message-State: AOAM532nrl9z1HYkVConrXkgorRM1JZbweeuOYZpXUBKRsNnAFIyigJa
        g1aZ1g1pB7JsJFBsXQnOlrsREQ==
X-Google-Smtp-Source: ABdhPJwq4ixTeMPPsxO0VSepWRnWGcruHLniLW76PhfAmwVK4+kydITGWd9Sk69V9+6k/4hmT0SN9Q==
X-Received: by 2002:a92:d591:: with SMTP id a17mr10863532iln.51.1605899632350;
        Fri, 20 Nov 2020 11:13:52 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h16sm2275299ile.14.2020.11.20.11.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 11:13:51 -0800 (PST)
Subject: Re: [PATCH] block: don't ignore REQ_NOWAIT for direct IO
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <546c66d26ae71abc151aa2074c3dd75ff5efb529.1605892141.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <389a12f6-729e-327f-bef9-e3691ef4f78a@kernel.dk>
Date:   Fri, 20 Nov 2020 12:13:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <546c66d26ae71abc151aa2074c3dd75ff5efb529.1605892141.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/20/20 10:10 AM, Pavel Begunkov wrote:
> io_uring's direct nowait requests end up waiting on io_schedule() in
> sbitmap, that's seems to be so because blkdev_direct_IO() fails to
> propagate IOCB_NOWAIT to a bio and hence to blk-mq.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  fs/block_dev.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 9e84b1928b94..e7e860c78d93 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -263,6 +263,8 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
>  		bio.bi_opf = dio_bio_write_op(iocb);
>  		task_io_account_write(ret);
>  	}
> +	if (iocb->ki_flags & IOCB_NOWAIT)
> +		bio.bi_opf |= REQ_NOWAIT;
>  	if (iocb->ki_flags & IOCB_HIPRI)
>  		bio_set_polled(&bio, iocb);

Was thinking this wasn't needed, but I guess that users could do sync && NOWAIT
and get -EAGAIN if using preadv2/pwritev2.

> @@ -416,6 +418,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>  			bio->bi_opf = dio_bio_write_op(iocb);
>  			task_io_account_write(bio->bi_iter.bi_size);
>  		}
> +		if (iocb->ki_flags & IOCB_NOWAIT)
> +			bio->bi_opf |= REQ_NOWAIT;
>  
>  		dio->size += bio->bi_iter.bi_size;
>  		pos += bio->bi_iter.bi_size;

Looks fine to me, we definitely should not be waiting on tags for IOCB_NOWAIT
IO. Will run some shakedown and test for 5.11.

-- 
Jens Axboe

