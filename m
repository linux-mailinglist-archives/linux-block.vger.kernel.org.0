Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C300421A1C4
	for <lists+linux-block@lfdr.de>; Thu,  9 Jul 2020 16:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgGIOFt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 9 Jul 2020 10:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgGIOFt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Jul 2020 10:05:49 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D88C08C5DD
        for <linux-block@vger.kernel.org>; Thu,  9 Jul 2020 07:05:49 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id r12so2122806ilh.4
        for <linux-block@vger.kernel.org>; Thu, 09 Jul 2020 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oMnI/eFxxJ+Rr9dk/y2RZbs/7bqRU/Yv7VYpCv09jjQ=;
        b=C5rui48LchhJZsNpOpZKkjblQ0CTY2MPXDSz4bmp81soQ7GL+mRU0qziWXkLkqg+Dy
         lClg6xJDkVIHrL8Byb8utF+/Zz69CsyFMkZixqLUf0DOuUj2n0BQCP4Bk5D2gBsKxhub
         CBPhvXRkP+8oivA89E8UF3wklQjxODE8+urJ2PPzWPWnLX2tv7Xxejg8j4fifP/zXzHx
         mBwYe35MwDctRpH4PI4J7EB6hiRDTkPI1JB7SjlZHlxXzRgPIM5VED8dHafaq/fYNO2O
         4Vqc4dTq6q+GOACFAaLZVj4+gp1Wxs//znqmRO+lqNQcRWZfa/bn2cIi8LnZn7I05H3A
         LesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oMnI/eFxxJ+Rr9dk/y2RZbs/7bqRU/Yv7VYpCv09jjQ=;
        b=EUEOONNlTqoD1lR7HV7oAsxjWMUdFdWEwvCWISI/I02ry2K0GHxQ3SR4mD7sT7MAMs
         OnJo2jpOpxwCmZjpvl5aV/VX7w4BFwkgEhK6cSJRLWKiE5fNRxeu+tH1dikfb+5NrKhp
         BXIDmAiSnMmVUZSHa3gzg+3NXLPxGuM15TsDLNlh1rVwVlYDjvRDatrpMg9z1/MgQwzJ
         vwO3kdG+BekLrGw8P6h5ygOOVi4ppEvbg5ZDFXNXUJd+yD31zRDXikCz/3fnMvdB/jPp
         Hx2fArIufSI/sbAcN4H+NzdhFW2QD2WnTI35LQwx7P2sa+u5ph6qQZFITOVz7LWxw9xF
         9A0w==
X-Gm-Message-State: AOAM532M91pBqpLkDfUusDCxcR5jSIPBFjmh9V8gmuHMKGyhgbfeb/Ej
        noUed3L6Lt4Jrdo221XwsOFOAg==
X-Google-Smtp-Source: ABdhPJya7WxrYyOKxMjO9jamdVLBDLUrjy8VegR37opYbGRoDIWCNtaSbFAkPSzRltHkfkNagHedyg==
X-Received: by 2002:a92:bb57:: with SMTP id w84mr47025123ili.104.1594303548684;
        Thu, 09 Jul 2020 07:05:48 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h11sm1910739ilh.69.2020.07.09.07.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 07:05:47 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] io_uring: add support for zone-append
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, viro@zeniv.linux.org.uk,
        bcrl@kvack.org, Damien.LeMoal@wdc.com, asml.silence@gmail.com,
        linux-fsdevel@vger.kernel.org, mb@lightnvm.io,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        Selvakumar S <selvakuma.s1@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
References: <1593974870-18919-1-git-send-email-joshi.k@samsung.com>
 <CGME20200705185227epcas5p16fba3cb92561794b960184c89fdf2bb7@epcas5p1.samsung.com>
 <1593974870-18919-5-git-send-email-joshi.k@samsung.com>
 <fe0066b7-5380-43ee-20b2-c9b17ba18e4f@kernel.dk>
 <20200709085501.GA64935@infradead.org>
 <adc14700-8e95-10b2-d914-afa5029ae80c@kernel.dk>
 <20200709140053.GA7528@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2270907f-670c-5182-f4ec-9756dc645376@kernel.dk>
Date:   Thu, 9 Jul 2020 08:05:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709140053.GA7528@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/9/20 8:00 AM, Christoph Hellwig wrote:
> On Thu, Jul 09, 2020 at 07:58:04AM -0600, Jens Axboe wrote:
>>> We don't actually need any new field at all.  By the time the write
>>> returned ki_pos contains the offset after the write, and the res
>>> argument to ->ki_complete contains the amount of bytes written, which
>>> allow us to trivially derive the starting position.
>>
>> Then let's just do that instead of jumping through hoops either
>> justifying growing io_rw/io_kiocb or turning kiocb into a global
>> completion thing.
> 
> Unfortunately that is a totally separate issue - the in-kernel offset
> can be trivially calculated.  But we still need to figure out a way to
> pass it on to userspace.  The current patchset does that by abusing
> the flags, which doesn't really work as the flags are way too small.
> So we somewhere need to have an address to do the put_user to.

Right, we're just trading the 'append_offset' for a 'copy_offset_here'
pointer, which are stored in the same spot...

-- 
Jens Axboe

