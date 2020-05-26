Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7F21D2479
	for <lists+linux-block@lfdr.de>; Thu, 14 May 2020 03:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgENBMF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 May 2020 21:12:05 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46097 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgENBME (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 21:12:04 -0400
Received: by mail-pl1-f193.google.com with SMTP id b12so503731plz.13
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 18:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vBAV9bEjRLQ8YH5GMGVFpAB/4LkEhPG0Aj2HTObo9yc=;
        b=Z+pU2Bwz8PPgT0mOKU3bAD75PCzibLKTRevsCHYpQWTy21suUm0VnLSIQmwJ0/ULHv
         E+dCF5xnaTLexNimAelLLOSppIyPO731cDdJDijGNEijanp0OXdsGlPkciovSSXgpOSR
         gGe5GVBhiNK4nUsb8bGS2AfA4LaNfxNJB1m/VwmV8hNMhBeIWyjEZdX/nq2ll7W+ktec
         fgnwctLYOZm6yLwN34xf0mj0O7jcIY82u9fA+b72+IReTNGD3pNVocxTwIzm7O35keyQ
         g/746iebnkjhUTZe62QgTmj4behUQoqf9HfmBxOc+kiocdc9AtNjrBocwAsBmZxs2Vy5
         mwHg==
X-Gm-Message-State: AOAM532RdvWnoH+BzPZw4wGBNybosLFNV/F9VqrZ7nJ+IyDzdWv5dKGc
        UkkKYHENrRrIQK5TyiZTJn3R5UAY
X-Google-Smtp-Source: ABdhPJzmD3NDjIG3VWTh7RLmGyYIN9cg+ScwUPXCzW0TerdTrrJKQlWJumUaeES8PvloZgFB6M4q4Q==
X-Received: by 2002:a17:902:be12:: with SMTP id r18mr1688836pls.206.1589418723870;
        Wed, 13 May 2020 18:12:03 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:89b0:7138:eb9:79bf? ([2601:647:4000:d7:89b0:7138:eb9:79bf])
        by smtp.gmail.com with ESMTPSA id j24sm749728pga.51.2020.05.13.18.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 18:12:03 -0700 (PDT)
Subject: Re: [PATCH V11 07/12] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200513034803.1844579-1-ming.lei@redhat.com>
 <20200513034803.1844579-8-ming.lei@redhat.com> <20200513115932.GC6297@lst.de>
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
Message-ID: <29dba56b-88ec-cb9e-605c-0ac9c8f85d2d@acm.org>
Date:   Wed, 13 May 2020 18:12:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513115932.GC6297@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-13 04:59, Christoph Hellwig wrote:
>> +	if (unlikely(direct_issue && rq->mq_ctx->cpu != raw_smp_processor_id()))
>> +		smp_mb();
>> +	else
>> +		barrier();
> 
> Independ of the fact that I still think this is horrible and hacky,
> I also still don't see what the barrier() is trying to help with.

I'm also less than enthusiast about this code.

Bart.


