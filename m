Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E487B2ED5F9
	for <lists+linux-block@lfdr.de>; Thu,  7 Jan 2021 18:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbhAGRrM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 7 Jan 2021 12:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbhAGRrL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Jan 2021 12:47:11 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E49C0612F9
        for <linux-block@vger.kernel.org>; Thu,  7 Jan 2021 09:46:31 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id h4so6185055qkk.4
        for <linux-block@vger.kernel.org>; Thu, 07 Jan 2021 09:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CNK3GvEL4U8HNz+MK8A+YotA76v+OyTJ7DMDgcIh4hA=;
        b=K845TS0CJJvuvFjUj0/sOIf8ijCuVcy9Rrl8aFb3820OKBUWOcx+gm8R4Go8dLn4k7
         10usGfYNKrO3Dn7k10RIjdXiBYhbGLFYuuVaxFPvW44RQCk+hmBONOLVCwN3ooyzcxnZ
         TjTxetXJakVoUOQ5iFjr608k+SiM4Xf4dr968ZRG+nJn2CNhIn0g0LTo64NQVlhO5VC1
         xBJ4FqAtnsca75tRq3wez0V3QiAhd/j17TM8ryuO3S8hnxU1iWvGtYnFOFQuMeMzOZ3H
         sJ17/FpXL5LIIG8fydoHgoWmOhNvAfw/urnEq+3WwWrKeoO3vlTfqI/PNdKtRWhff3BO
         a4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CNK3GvEL4U8HNz+MK8A+YotA76v+OyTJ7DMDgcIh4hA=;
        b=HNOCBHEjLnI9Eq6HROoo9KEWQoQEb0htpTl+c7uy744uzqeHjSV45GgLdW7G3D5ZQ1
         Wt5c7fdhCXwpcR0aG7tD6X7wfEZTl4iqGb4yXxVALJoVl5KyA5/jJZE2KGSiZ59sYz1C
         L8rASrLGT7+NUqlLt9dqLzEL8cHMgX4BlptcGmvtLBz/jCpGkYtAnciA3/Jnh0OiEELC
         ZC+eQ/aM4SvqDBJLCP7V9nLDrSVc7sZfsZZAq+SB98oHBbnQbw+vIcN4BosYX+BJUiID
         gEZAnsTPHEZ3G2vLY4QKr3Fhbe5qafgThnsTYkepTzhYvOLom37CSIJrUsy95RSJbTCm
         YG9A==
X-Gm-Message-State: AOAM530+uUnguikqPlKZcuJh78GOND0cusmrjACTF8hv90oxoR7Yx1a5
        qbZq4KOlaGGONx8pid3rTAXqKA==
X-Google-Smtp-Source: ABdhPJz9vaq8bg7IjIElCsf54gkPa23NreE78PAjXOcXgIgk1qq0jaVgdhKg55lZfp/2GgHu7fk7og==
X-Received: by 2002:a37:584:: with SMTP id 126mr5587qkf.332.1610041590660;
        Thu, 07 Jan 2021 09:46:30 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id j142sm3555681qke.117.2021.01.07.09.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 09:46:30 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kxZMj-003lto-I9; Thu, 07 Jan 2021 13:46:29 -0400
Date:   Thu, 7 Jan 2021 13:46:29 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, bostroesser@gmail.com, bvanassche@acm.org,
        ddiss@suse.de
Subject: Re: [PATCH v5 4/4] scatterlist: add sgl_memset()
Message-ID: <20210107174629.GC504133@ziepe.ca>
References: <20201228234955.190858-1-dgilbert@interlog.com>
 <20201228234955.190858-5-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228234955.190858-5-dgilbert@interlog.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 28, 2020 at 06:49:55PM -0500, Douglas Gilbert wrote:
> The existing sg_zero_buffer() function is a bit restrictive. For
> example protection information (PI) blocks are usually initialized
> to 0xff bytes. As its name suggests sgl_memset() is modelled on
> memset(). One difference is the type of the val argument which is
> u8 rather than int. Plus it returns the number of bytes (over)written.
> 
> Change implementation of sg_zero_buffer() to call this new function.
> 
> Reviewed-by: Bodo Stroesser <bostroesser@gmail.com>
> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
>  include/linux/scatterlist.h |  3 ++
>  lib/scatterlist.c           | 65 +++++++++++++++++++++++++------------
>  2 files changed, 48 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index 71be65f9ebb5..70d3f1f73df1 100644
> +++ b/include/linux/scatterlist.h
> @@ -333,6 +333,9 @@ bool sgl_compare_sgl_idx(struct scatterlist *x_sgl, unsigned int x_nents, off_t
>  			 struct scatterlist *y_sgl, unsigned int y_nents, off_t y_skip,
>  			 size_t n_bytes, size_t *miscompare_idx);
>  
> +size_t sgl_memset(struct scatterlist *sgl, unsigned int nents, off_t skip,
> +		  u8 val, size_t n_bytes);
> +
>  /*
>   * Maximum number of entries that will be allocated in one piece, if
>   * a list larger than this is required then chaining will be utilized.
> diff --git a/lib/scatterlist.c b/lib/scatterlist.c
> index 9332365e7eb6..f06614a880c8 100644
> +++ b/lib/scatterlist.c
> @@ -1038,26 +1038,7 @@ EXPORT_SYMBOL(sg_pcopy_to_buffer);
>  size_t sg_zero_buffer(struct scatterlist *sgl, unsigned int nents,
>  		       size_t buflen, off_t skip)
>  {
> -	unsigned int offset = 0;
> -	struct sg_mapping_iter miter;
> -	unsigned int sg_flags = SG_MITER_ATOMIC | SG_MITER_TO_SG;
> -
> -	sg_miter_start(&miter, sgl, nents, sg_flags);
> -
> -	if (!sg_miter_skip(&miter, skip))
> -		return false;
> -
> -	while (offset < buflen && sg_miter_next(&miter)) {
> -		unsigned int len;
> -
> -		len = min(miter.length, buflen - offset);
> -		memset(miter.addr, 0, len);
> -
> -		offset += len;
> -	}
> -
> -	sg_miter_stop(&miter);
> -	return offset;
> +	return sgl_memset(sgl, nents, skip, 0, buflen);
>  }
>  EXPORT_SYMBOL(sg_zero_buffer);

May as well make this one liner a static inline in the header. Just
rename this function to sgl_memset so the diff is clearer

Jason
