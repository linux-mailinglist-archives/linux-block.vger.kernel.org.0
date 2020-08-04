Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408D223BEB4
	for <lists+linux-block@lfdr.de>; Tue,  4 Aug 2020 19:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgHDRPV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 4 Aug 2020 13:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgHDRPT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Aug 2020 13:15:19 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659DAC06174A
        for <linux-block@vger.kernel.org>; Tue,  4 Aug 2020 10:15:19 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id z17so19766391ill.6
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2020 10:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LvVAc3higftpuTNQCEYcbhjK/E4SRXQZoiVYparcCz0=;
        b=LAl3Qh8cfi6/x34HJhytzP+56VvFuiPeE9QuikOooh9mVi1LOsSbxxg5MHndqXUvaa
         rjv25l7lH78bkq43mhXTkXwZMQjUgAQfP8z/bhmUR0Y7LYW8mfJxAM+mIbRDRueFe7ZO
         1ZsHWKZi0iewd9asbj2ZJUtohBJmfwbSdygYzWBC16ZjcjnqPClPyoZwexmKf9baiOZi
         +uDsB0+SOeKBXSoopyuYCQwzBn0+gkRJ4yC6bVntNtRAjeHAAz00iCk+0yIkSoPSh/OP
         41XvT2qfeAjXjQcxmPS08QXoskg3BIyUbmijE6X3gkAuAiK3P6Olw3K8FzJa0c6AdOYo
         xGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LvVAc3higftpuTNQCEYcbhjK/E4SRXQZoiVYparcCz0=;
        b=p52EhIZex4zkqyezEhkgiAhypVJ9YP8F/X0RKBCiQD3eMAxojZ8VAUMyx0HdQHE34f
         z0DNl3fQenfYCaKQL28GfJ1B9iyQOr6/VU861UndaJOyn7axnQwjC5EeD7jKo8BRozxc
         7skc6sMlE+cGwF7DMCbTKdxFMBbvf6I4GPG6KPeMRYcFDCBFBfM9dTV+NAK/vYq53Dzo
         8pn+qkThb90Vl9BjVZUwJYllQ2qC9QaN1GsWfDM1Y0zeIuN2gAtv0pjYkvq1jW8fqGbG
         W9IMYs9UnCKwC7wDUdr0f/bfXDoPrr96F233rqqzIlOLTmmXUKVwsSs+sHtS0KGJPBTW
         1/Pg==
X-Gm-Message-State: AOAM533SDWI/J6G2BBvaI/ksz3M+1GTJbR9JUWYeBQgdasiqYONdkZIA
        XObptJOhET3tBLHlwRgKXUgGfq8pVaI=
X-Google-Smtp-Source: ABdhPJzKVG+yuakPDy/1iTndB3wNH7/0L/lF2s3F1ndKOvmhn43Xl3piicg96Qv9R+2jV/DR1XEn7g==
X-Received: by 2002:a92:35da:: with SMTP id c87mr5541076ilf.61.1596561318668;
        Tue, 04 Aug 2020 10:15:18 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t18sm10670432ild.46.2020.08.04.10.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 10:15:18 -0700 (PDT)
Subject: Re: [PATCH] fs/io_uring.c: fix null ptr deference in
 io_send_recvmsg()
To:     xiao lin <pkfxxxing@gmail.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>
References: <20200804125637.GA22088@ubuntu>
 <701640d6-fa20-0b38-f86b-b1eff07597dd@gmail.com>
 <0350a653-8a3e-2e09-c7fc-15fcea727d8a@kernel.dk>
 <CAGAoTxzadSphnE2aLsFKS04TjTKYVq2uLFgH9dvLPwWiyqEGEQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c7194bbc-06ed-30d1-704a-cb0d9f9e2b8d@kernel.dk>
Date:   Tue, 4 Aug 2020 11:15:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGAoTxzadSphnE2aLsFKS04TjTKYVq2uLFgH9dvLPwWiyqEGEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/4/20 11:02 AM, xiao lin wrote:
> 在 2020年8月4日星期二，Jens Axboe <axboe@kernel.dk <mailto:axboe@kernel.dk>> 写道：
> 
>     On 8/4/20 7:18 AM, Pavel Begunkov wrote:
>     > On 04/08/2020 15:56, Liu Yong wrote:
>     >> In io_send_recvmsg(), there is no check for the req->file.
>     >> User can change the opcode from IORING_OP_NOP to IORING_OP_SENDMSG
>     >> through competition after the io_req_set_file().
>     >
>     > After sqe->opcode is read and copied in io_init_req(), it only uses
>     > in-kernel req->opcode. Also, io_init_req() should check for req->file
>     > NULL, so shouldn't happen after.
>     >
>     > Do you have a reproducer? What kernel version did you use?
> 
>     Was looking at this too, and I'm guessing this is some 5.4 based kernel.
>     Unfortunately the oops doesn't include that information.

> Sorry, I forgot to mention that the kernel version I am using is 5.4.55.

I think there are two options here:

1) Backport the series that ensured we only read those important bits once
2) Make s->sqe a full sqe, and memcpy it in

-- 
Jens Axboe

