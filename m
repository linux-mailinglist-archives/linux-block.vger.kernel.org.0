Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FA74D5846
	for <lists+linux-block@lfdr.de>; Fri, 11 Mar 2022 03:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345702AbiCKCoP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 10 Mar 2022 21:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240820AbiCKCoO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 21:44:14 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525CBF3907
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 18:43:11 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v4so6982465pjh.2
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 18:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qM/UV7FHcZxY+IHV+9o1h4m2AAXBVlhwLsCWQjNFw6I=;
        b=ydMQnwYy5mk0UrEDpFa+OzSqWyno7VdmtQZ4bfjscLiVtXeeYVJVHVu+Mb0h4Vw71X
         E68oqQvdJ3eJnjrN7LMFdsbQp+X/kQR+b5pTXoHqtJJ0G3cy9tx5mAW3nACCkJbRvM4v
         EdCOHa+OmJlmb8Pwo1s8JJQOmxxHn7wWh8kDfOtJYSFSqRGDndPW0eep+1xcaLzpklDl
         OWKyTEVLemVTMmWChdzBievwdhqW8ewCBeTaTyeCznVALCNKda8tXPHMFl633q7NQsRH
         jPSdf4WiEE6bUCFmPOXjx6QaQhT9JsVH2qu17vIbBtAFWu8LN8fSWPVolwDwwFOvyurF
         WkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qM/UV7FHcZxY+IHV+9o1h4m2AAXBVlhwLsCWQjNFw6I=;
        b=NCXiDGgh4l/HXMbohVH1C0Gelc3fGeVaodbHDvubTBvHATiW3zmiMsOFOKrDAWoEIV
         suajcrH/NW9MW94YHPoU5YpQFlNYVz0x3tKETQvD4bYFJ/cZDtSsnTOVdMPrfFQMF0ky
         0SxfzSHF0cs6rKi2XINE4DZSymB8baWdwdUCdeUPhV4LwoPDWW66/dY0HW9h0wWgTK0o
         d/4E9dGqQfO348BqI1UHeBPPLE4CBR6hfi/ou2SYZrQXxfg56vSvRHmE17qyvHBp7Rn9
         R6NQ+HUZdeMD0GK/7dEulQo2rF2lj72MVP4CwkHNDQvC7ZP+eCNx6ESE5LkgdNCw39I0
         +QDw==
X-Gm-Message-State: AOAM532f7+FvrT+3AAV8idFWOIOcVbh6N9JfpDDnl5OQUTonrfuIWEX4
        dwDGDTC/2ZOpUrN13xV8vgTSew==
X-Google-Smtp-Source: ABdhPJxncp1/88IEQE5teKvz0gCS+nBv5XeRvmq3TMQgymIIQ+EEz1/9y6h1o6JnJMOSOqyGfVWtBw==
X-Received: by 2002:a17:902:c215:b0:14f:f1c2:9fe3 with SMTP id 21-20020a170902c21500b0014ff1c29fe3mr8274323pll.145.1646966590724;
        Thu, 10 Mar 2022 18:43:10 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d16-20020a17090ad99000b001bcbc4247a0sm7161458pjv.57.2022.03.10.18.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 18:43:10 -0800 (PST)
Message-ID: <e3bfd028-ece7-d969-f47c-1181b17ac919@kernel.dk>
Date:   Thu, 10 Mar 2022 19:43:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 03/17] io_uring: add infra and support for
 IORING_OP_URING_CMD
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kanchan Joshi <joshi.k@samsung.com>, jmorris@namei.org,
        serge@hallyn.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-security-module@vger.kernel.org
Cc:     hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com,
        io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, sbates@raithlin.com,
        logang@deltatee.com, pankydev8@gmail.com, javier@javigon.com,
        a.manzanares@samsung.com, joshiiitr@gmail.com, anuj20.g@samsung.com
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152658epcas5p3929bd1fcf75edc505fec71901158d1b5@epcas5p3.samsung.com>
 <20220308152105.309618-4-joshi.k@samsung.com>
 <YiqrE4K5TWeB7aLd@bombadil.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YiqrE4K5TWeB7aLd@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/10/22 6:51 PM, Luis Chamberlain wrote:
> On Tue, Mar 08, 2022 at 08:50:51PM +0530, Kanchan Joshi wrote:
>> From: Jens Axboe <axboe@kernel.dk>
>>
>> This is a file private kind of request. io_uring doesn't know what's
>> in this command type, it's for the file_operations->async_cmd()
>> handler to deal with.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>> ---
> 
> <-- snip -->
> 
>> +static int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
>> +{
>> +	struct file *file = req->file;
>> +	int ret;
>> +	struct io_uring_cmd *ioucmd = &req->uring_cmd;
>> +
>> +	ioucmd->flags |= issue_flags;
>> +	ret = file->f_op->async_cmd(ioucmd);
> 
> I think we're going to have to add a security_file_async_cmd() check
> before this call here. Because otherwise we're enabling to, for
> example, bypass security_file_ioctl() for example using the new
> iouring-cmd interface.
> 
> Or is this already thought out with the existing security_uring_*() stuff?

Unless the request sets .audit_skip, it'll be included already in terms
of logging. But I'd prefer not to lodge this in with ioctls, unless
we're going to be doing actual ioctls.

But definitely something to keep in mind and make sure that we're under
the right umbrella in terms of auditing and security.

-- 
Jens Axboe

