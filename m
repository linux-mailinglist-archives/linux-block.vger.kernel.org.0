Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB893071CB
	for <lists+linux-block@lfdr.de>; Thu, 28 Jan 2021 09:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhA1IkT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 28 Jan 2021 03:40:19 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:42153 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhA1IkO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 03:40:14 -0500
Received: by mail-wr1-f53.google.com with SMTP id c4so1799155wru.9
        for <linux-block@vger.kernel.org>; Thu, 28 Jan 2021 00:39:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mu+S+hqRggK7XQj7o+cIO4Mbz3GyYl5LYdtGdY1J+hs=;
        b=JXExkSprsUgxg2AXAUWXz2X/+v8gxrncqdBwoYQGuPcxaRC+xJ0xR5bgk02LnzRZHr
         WqI35+6/m8x4EfZuBq/o6E2Izx7EI5xitYBa9WHkFb+jGQoaaK3NjWP1RIJn9YEFt85L
         rKYOd1MHsNObS/RHK2u57farAhtUOepfk4dbkYeNUyhfbAlHDr+TouakVrEsOX2HBV9N
         9TOxNOVsxGua53YDLwZ7V4CzHWnB6tY/4HkkawsjIXBYnJ/3ju8+m0pGLbrzLDrnDXT3
         ZXeB6lAPChW03RajaD2NBAd8LEVL7gKOAe9Ri4NAUAPO6Hy61MVQkayrINXYGL7/yKsr
         jTPw==
X-Gm-Message-State: AOAM531zLFz8VVRLd0ncvNkoGRyFhIx+JF/jc4yhJ/COgvijiiyOxB9K
        9c4pD/ikUIe5JLAy0ST5cs0=
X-Google-Smtp-Source: ABdhPJwJX/zZdKjn3i78+g76uoWeeUxUJ5+E5kUzS9g9Zxp/h8jaZ+7p9Nlocg7OB1gmdOesHPwH0A==
X-Received: by 2002:adf:f749:: with SMTP id z9mr14713756wrp.327.1611823172369;
        Thu, 28 Jan 2021 00:39:32 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:4d86:226e:ca4b:6bef? ([2601:647:4802:9070:4d86:226e:ca4b:6bef])
        by smtp.gmail.com with ESMTPSA id w20sm5072019wmm.12.2021.01.28.00.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 00:39:31 -0800 (PST)
Subject: Re: [PATCH v4 4/5] nvme-rdma: avoid IO error for nvme native
 multipath
To:     Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de,
        linux-block@vger.kernel.org, axboe@kernel.dk
References: <20210126081539.13320-1-lengchao@huawei.com>
 <20210126081539.13320-5-lengchao@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5a368693-65fd-1bdf-924a-f90df7f59b2a@grimberg.me>
Date:   Thu, 28 Jan 2021 00:39:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126081539.13320-5-lengchao@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> @@ -2084,8 +2085,10 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
>   
>   	err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
>   			req->mr ? &req->reg_wr.wr : NULL);
> -	if (unlikely(err))
> +	if (unlikely(err)) {
> +		driver_error = true;
>   		goto err_unmap;

Why not just call set the status and call nvme_rdma_complete_rq and
return here?
