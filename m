Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8B21BC107
	for <lists+linux-block@lfdr.de>; Tue, 28 Apr 2020 16:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgD1OTg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Apr 2020 10:19:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32893 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgD1OTg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 10:19:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id x77so10755678pfc.0
        for <linux-block@vger.kernel.org>; Tue, 28 Apr 2020 07:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JBOsiozHq77TMDrm3AtBaDs+xiC5JJ/HWd9xsooIPrA=;
        b=YdqQN8B+rSqOY67+Pdb/Awb6ajoAvfICufAnAW6OJfbG2jUaXJmpbbp2wMT3hMo/2q
         BEg5S84ygQ2alsFBi6+fsHxBqRUDBw5KWG0/EuxM+BLKX3XOoZCV/2GBE8PvtI9Q/B7i
         u6w5EMTM3kMmrw5HpeMHKkwx6UAZgYvLh6L0t5RCqZBRvFrCbDCrq0VYUjol/CYua73+
         NdJ6YVKpDFgXJOrixviZn6EQvaHFrmSFa0D92dHOEeGT/fLbXd1ihMJM1A10vUMle482
         4it67G5fDU4EByY2hMpg14UstD5a1r6rCob68PDpBezvMiIVRwU4HQKcSRLr3Tkw72CH
         qEVw==
X-Gm-Message-State: AGi0PuaqvkJ7kgERUHJCMRjpVRK3x5Roqv0rtFtvpZFnA6OmiQAUEFPG
        L91+3eX4QIS5yvPxJ/Fcgwk=
X-Google-Smtp-Source: APiQypJoOPZgFoVX7M13G5z56Y3XpG5HChJ4hd/Erf2cSxRvUKCCrzzZZlBFkAegEtgJtKTraQObmA==
X-Received: by 2002:a63:ac43:: with SMTP id z3mr27515399pgn.324.1588083575290;
        Tue, 28 Apr 2020 07:19:35 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:1473:9ec8:73db:e572? ([2601:647:4000:d7:1473:9ec8:73db:e572])
        by smtp.gmail.com with ESMTPSA id x12sm15392819pfq.209.2020.04.28.07.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 07:19:34 -0700 (PDT)
Subject: Re: [PATCH 1/2] block: add blk_default_io_timeout() for avoiding task
 hung in sync IO
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Salman Qazi <sqazi@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christoph Hellwig <hch@lst.de>
References: <20200428074657.645441-1-ming.lei@redhat.com>
 <20200428074657.645441-2-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <7e339c3d-8600-4a9b-99bf-24afb023c4dd@acm.org>
Date:   Tue, 28 Apr 2020 07:19:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428074657.645441-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-04-28 00:46, Ming Lei wrote:
> +/*
> + * Used in sync IO for avoiding to triger task hung warning, which may
> + * cause system panic or reboot.
> + */
> +static inline unsigned long blk_default_io_timeout(void)
> +{
> +	return sysctl_hung_task_timeout_secs * (HZ / 2);
> +}
> +
>  #endif

This function is only used inside the block layer. Has it been
considered to move this function from the public block layer API into a
private header file, e.g. block/blk.h?

Thanks,

Bart.


