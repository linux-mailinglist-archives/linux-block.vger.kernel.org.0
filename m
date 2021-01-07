Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E072ED5E6
	for <lists+linux-block@lfdr.de>; Thu,  7 Jan 2021 18:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbhAGRoy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 7 Jan 2021 12:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbhAGRox (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Jan 2021 12:44:53 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45882C0612F6
        for <linux-block@vger.kernel.org>; Thu,  7 Jan 2021 09:44:13 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 143so6121236qke.10
        for <linux-block@vger.kernel.org>; Thu, 07 Jan 2021 09:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lHNm8uDmPy3iG7VP+rZSrjxlKRFNIPZy9iz2Yh/Sa+s=;
        b=DilJRgOjUGCkNxVbxqaEZR1cwZNNstBr627PIcTB9nAkNhFIAEdj2KP9O/SRdV1mTy
         fwsNq4eEp0F+MGgRKtNUHxsis3IsLDldIIGRF9oAp4kxNykVi2lUkquJNA3T8hZ8Y0S5
         BKEOlaehVFxfM/tqZ4q+TczmHy6izyRHS5wE/oLZtnlcdKbSvT5M8372+4oNafqS+J0c
         VbyMm00QdGgQ9hCdLJqY2hsPbrzaX+gJDeCGl6JjEHQE3ivIvZX2YeuEZjhb55hhBsEw
         O4EbR0zCO3kQRe/EiyZJNsaQLjfohF5vzinPCUFyJHNbCPwwG/MbuMJNcQcpI4/Yia9h
         tn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lHNm8uDmPy3iG7VP+rZSrjxlKRFNIPZy9iz2Yh/Sa+s=;
        b=IWUwJHJkBmSDLl1ctQ0lA9GV0uLN7AbLvdAA7PJ5S8PVK5bnPCSt78d33Ur7gkltY6
         idw4TdXTbXb2ERcXW8mk0PddrSR3e5A6Ck/IGzClhc1onKbUhfj7rFkCqVsxqRRxU9Ct
         7MJEVzQootHWLzipQdPJ4i9OuLmOnxJaLiC5sqsD6OCDlNk5t33nvNycDhAcEAf2MOd5
         OsIVTTdkCpGQmW7cWh7u5OWNwdqdJ4vkktXQBobTSoAk5PEN9V6Vqha7I4aOoRsaO/ME
         sufnYPbXnZe8G9CjBNQPFmACAN1kO4/47AnSY+qi8DAzebkjB1JtgOogeoxMgovOmJJt
         zJwA==
X-Gm-Message-State: AOAM531QW5it11C3zKEbXhDvQ1dGQZYIsybbuSiABjmkGNytWpJEmguz
        sbOXeHHYhuRm6H78SVWI58m+Ug==
X-Google-Smtp-Source: ABdhPJwTdp1mFNmZjd/uTThSUu3tREo6Dtb4VkwqpGpv7ZYVPfWDxnJ3YoPDIOWbz+jR2KjGnUR+yw==
X-Received: by 2002:a05:620a:9d7:: with SMTP id y23mr10176247qky.181.1610041452516;
        Thu, 07 Jan 2021 09:44:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id b12sm3053989qtj.12.2021.01.07.09.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 09:44:11 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kxZKU-003lqO-Rg; Thu, 07 Jan 2021 13:44:10 -0400
Date:   Thu, 7 Jan 2021 13:44:10 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, bostroesser@gmail.com, bvanassche@acm.org,
        ddiss@suse.de
Subject: Re: [PATCH v5 1/4] sgl_alloc_order: remove 4 GiB limit, sgl_free()
 warning
Message-ID: <20210107174410.GB504133@ziepe.ca>
References: <20201228234955.190858-1-dgilbert@interlog.com>
 <20201228234955.190858-2-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228234955.190858-2-dgilbert@interlog.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 28, 2020 at 06:49:52PM -0500, Douglas Gilbert wrote:
> diff --git a/lib/scatterlist.c b/lib/scatterlist.c
> index a59778946404..4986545beef9 100644
> +++ b/lib/scatterlist.c
> @@ -554,13 +554,15 @@ EXPORT_SYMBOL(sg_alloc_table_from_pages);
>  #ifdef CONFIG_SGL_ALLOC
>  
>  /**
> - * sgl_alloc_order - allocate a scatterlist and its pages
> + * sgl_alloc_order - allocate a scatterlist with equally sized elements
>   * @length: Length in bytes of the scatterlist. Must be at least one
> - * @order: Second argument for alloc_pages()
> + * @order: Second argument for alloc_pages(). Each sgl element size will
> + *	   be (PAGE_SIZE*2^order) bytes
>   * @chainable: Whether or not to allocate an extra element in the scatterlist
> - *	for scatterlist chaining purposes
> + *	       for scatterlist chaining purposes
>   * @gfp: Memory allocation flags
> - * @nent_p: [out] Number of entries in the scatterlist that have pages
> + * @nent_p: [out] Number of entries in the scatterlist that have pages.
> + *		  Ignored if NULL is given.
>   *
>   * Returns: A pointer to an initialized scatterlist or %NULL upon failure.
>   */
> @@ -574,8 +576,8 @@ struct scatterlist *sgl_alloc_order(unsigned long long length,
>  	u32 elem_len;
>  
>  	nent = round_up(length, PAGE_SIZE << order) >> (PAGE_SHIFT + order);
> -	/* Check for integer overflow */
> -	if (length > (nent << (PAGE_SHIFT + order)))
> +	/* Integer overflow if:  length > nent*2^(PAGE_SHIFT+order) */
> +	if (ilog2(length) > ilog2(nent) + PAGE_SHIFT + order)
>  		return NULL;
>  	nalloc = nent;
>  	if (chainable) {

This is a little bit too tortured now, how about this:

	if (length >> (PAGE_SHIFT + order) >= UINT_MAX)
		return NULL;
	nent = length >> (PAGE_SHIFT + order);
	if (length & ((1ULL << (PAGE_SHIFT + order)) - 1))
		nent++;

	if (chainable) {
		if (check_add_overflow(nent, 1, &nalloc))
			return NULL;
	}
	else
		nalloc = nent;

Jason
