Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8FB2FBA12
	for <lists+linux-block@lfdr.de>; Tue, 19 Jan 2021 15:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404048AbhASOlU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 19 Jan 2021 09:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393034AbhASNAI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jan 2021 08:00:08 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233D9C061575
        for <linux-block@vger.kernel.org>; Tue, 19 Jan 2021 04:59:07 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id t17so5303985qtq.2
        for <linux-block@vger.kernel.org>; Tue, 19 Jan 2021 04:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B3Cy0Hm6xTRsmff/JkHOzD1P8m+ZaMSZbwZ78cwq0GQ=;
        b=ZGSI5bxWjU+x6vpwy6aJhb0H6QN8FxL1hxmj/KVTU1+omQptO3f8ci9LDt5IMdmEm1
         c4v/0lgymC7G0E3l+2BOtcBk1DueLIbZR8J5cxMMLK3Yi0npvu/r/IIOp2wnIuuEiMOE
         DrJjzANZhdQ53CfuySR1LOimnUnSIDo4FGY/QmSEA0+i1UEodaNTu5jJ1/O7oInHnfdm
         qtOg4X7Kif7h5aJ2gi3ToQZLQMqsAQcD3DKwsenq41fiLGO26hoqLlrhFHOsM+1Ha+/8
         g1zHKQfTf/f2IFzFEdXrbT2v96nn6w01sjb/AslAOhGMjo1PLV9/0FdTcZ/CTpaHjkXR
         P6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B3Cy0Hm6xTRsmff/JkHOzD1P8m+ZaMSZbwZ78cwq0GQ=;
        b=m7BZTKfV7naV7HHBhRzYoimXV9P111YUnLkA5v7qrIycJssh5cNQ5CEfw+Vx3DsmWk
         f6rcaBNWk/jRAezAQVjz7+g+9DdOOgm6p+5x3hh7erWNZLps/5Cb3u8DQ/T4GDNo1l/i
         UJUHYA2RO5ht9sUF15K4wEXsYcQ0SRcWiLhQYKsQ+Oze2XSIdoBJeIBZSGa8QG57M4M1
         2qg8yN0Ye9dWr6IvCkUhluyFBvcae0i37bkXz182ctL9FyzlDaIkDLfH3FCryblNWONt
         WOV9UKckHzADi6Dx8Q3hBMLPFBlt/ye9MeJNSF1m38N6svLfItlkKscsUTo7fLsLFNyj
         +d1g==
X-Gm-Message-State: AOAM530WKKhQZVmqv3Cw8xwRRY9QXnlPAAZzcSNv3SbkNU9dxD8KZnws
        4fAPuDcu2yHHvi3ou7JKbZM7ig==
X-Google-Smtp-Source: ABdhPJwlbXLZsM8EZ3zbiuP95L7daX8Gjcn61F+rGmL6G3gAj59bCjoRgpcQVVChw0oLTnlsG4kHzA==
X-Received: by 2002:a05:622a:4d1:: with SMTP id q17mr4030813qtx.272.1611061145938;
        Tue, 19 Jan 2021 04:59:05 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id k64sm13021228qkc.110.2021.01.19.04.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 04:59:05 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l1qbA-003bfs-PA; Tue, 19 Jan 2021 08:59:04 -0400
Date:   Tue, 19 Jan 2021 08:59:04 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     Bodo Stroesser <bostroesser@gmail.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, target-devel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, ddiss@suse.de,
        bvanassche@acm.org
Subject: Re: [PATCH v6 1/4] sgl_alloc_order: remove 4 GiB limit, sgl_free()
 warning
Message-ID: <20210119125904.GR4605@ziepe.ca>
References: <20210118163006.61659-1-dgilbert@interlog.com>
 <20210118163006.61659-2-dgilbert@interlog.com>
 <20210118182854.GJ4605@ziepe.ca>
 <59707b66-0b6c-b397-82fe-5ad6a6f99ba1@interlog.com>
 <20210118202431.GO4605@ziepe.ca>
 <7f443666-b210-6f99-7b50-6c26d87fa7ca@gmail.com>
 <20210118234818.GP4605@ziepe.ca>
 <770a562e-52b9-ba93-59d3-1026340bf4f3@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <770a562e-52b9-ba93-59d3-1026340bf4f3@interlog.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 18, 2021 at 08:27:09PM -0500, Douglas Gilbert wrote:

> To protect against the "unsigned long long" length being too big why
> not pick a large power of two and if someone can justify a larger
> value, they can send a patch.
> 
>         if (length > 64ULL * 1024 * 1024 * 1024)
> 		return NULL;

That is not how we protect against arithemetic overflows in the kernel

Jason
