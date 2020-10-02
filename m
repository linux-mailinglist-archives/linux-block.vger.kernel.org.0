Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68394280BF3
	for <lists+linux-block@lfdr.de>; Fri,  2 Oct 2020 03:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbgJBB2I (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 1 Oct 2020 21:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgJBB2I (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Oct 2020 21:28:08 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EEDC0613E2
        for <linux-block@vger.kernel.org>; Thu,  1 Oct 2020 18:28:08 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u24so418493pgi.1
        for <linux-block@vger.kernel.org>; Thu, 01 Oct 2020 18:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i49beg2TUcxlSmAmpEnMzD9aInnD0fnuYKI/AnJhgbE=;
        b=xMJQ47fDFDHqQa476XcpKAZXW7TuVWgvZW/QmHcAqIuIV9DFSbAX7elelGWEA/G4aX
         0UnWntItvp/GDW1fAGXNRlpurLCpNL5zedDqrGYI4NIZGfSGPh5g2byO4WCkXTikRQBH
         f/PfDKhHOm6HGp8xBUm2NQLkJu7sS8jwyKOpTRBN2npTR+/UwGR5Fu9BNXvE94hwPILb
         Cq6YpCYma90tIC9HKbxtX+YyCnbbOGVUecsie8ED3ZvkRvI3CIl9RKSt79nqpeEV6i3J
         H8ZQPo6+6oEQw3S8eTFVmE1Eh0Atu1iq4y3B6rHUzxXiCqT9XfOKZEfKFg6+Yegy+neP
         xOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i49beg2TUcxlSmAmpEnMzD9aInnD0fnuYKI/AnJhgbE=;
        b=jTp9d98QCYpftIkolVu90DcIwfhSFi9xSPz6LoFUn6tNIT14ttozRB8Bv+sfimJAPs
         7cw3Ibgiz4v1ajA48gJkQsPomZQiq2B5Seod9rixhNsb/NCeAaZ0/TuL1ZkwjPOJXJBi
         +uGJoEnS7IASg8Vt20J6sofeEZMQeUfYCe+FO7OsKpR1UgJHuIQ2Mhw0e5r2P5JiwWKo
         JEgxlqGHmFdbxMBlJZ053c5HZN1Qa4Q0dQB3YKYQSpw1t0YyUspDbVXuQAUHU1Urv3O9
         GmPg62GA5SL7PSD0JJq7aQQwIHkxmqK9O+kve6WYTaCm+rLUFocm1QhyQzNi2h2Lw82f
         H+Cw==
X-Gm-Message-State: AOAM533ywf+0f/LS8ZUI8FSh7ZPyTqa3UN6vOMxbVrIp/L6xA9BSK9Nd
        FNOEvRIQNskMGwGuj/JcU6P0rQ==
X-Google-Smtp-Source: ABdhPJx4J9xNU2tN+51Poiudt5CAv0U+oeVjUvc0hIUy4PR0CzIyI8s7265jfYspdpKb4EBcKmIdgA==
X-Received: by 2002:aa7:8ec7:0:b029:13e:d13d:a080 with SMTP id b7-20020aa78ec70000b029013ed13da080mr10086938pfr.23.1601602087508;
        Thu, 01 Oct 2020 18:28:07 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w203sm7729589pfc.97.2020.10.01.18.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 18:28:06 -0700 (PDT)
Subject: Re: [PATCH blk-next 0/2] Delete the get_vector_affinity leftovers
To:     Leon Romanovsky <leonro@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>
References: <20200929091358.421086-1-leon@kernel.org>
 <20201001050101.GT3094@unreal>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <063a6648-a8bc-cefd-ced8-573d78a9cb8d@kernel.dk>
Date:   Thu, 1 Oct 2020 19:28:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201001050101.GT3094@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/30/20 11:01 PM, Leon Romanovsky wrote:
> On Tue, Sep 29, 2020 at 12:13:56PM +0300, Leon Romanovsky wrote:
>> From: Leon Romanovsky <leonro@nvidia.com>
>>
>> There are no drivers that implement .get_vector_affinity(), so delete
>> the RDMA function and simplify block code.
>>
>> Thanks
>>
>> P.S. Probably it should go through block tree.
>>
>> Leon Romanovsky (2):
>>   blk-mq-rdma: Delete not-used multi-queue RDMA map queue code
>>   RDMA/core: Delete not-implemented get_vector_affinity
> 
> Jens, Keith
> 
> How can we progress here?

I'd really like for the nvme side to sign off on this first.

-- 
Jens Axboe

