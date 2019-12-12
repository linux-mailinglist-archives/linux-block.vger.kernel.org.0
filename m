Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13A5611D883
	for <lists+linux-block@lfdr.de>; Thu, 12 Dec 2019 22:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbfLLV13 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Dec 2019 16:27:29 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43094 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731040AbfLLV12 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 16:27:28 -0500
Received: by mail-io1-f68.google.com with SMTP id s2so160095iog.10
        for <linux-block@vger.kernel.org>; Thu, 12 Dec 2019 13:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yOdrSKjwBaIUNlnjyLGfplxUyqRliUQ2CbbCdbPdvKw=;
        b=0anD1AKhF8+1e4+tzUPBr9aEdQeWlDbhp8IdcQMpmh4rVsn3eVS2fy+qQC9dxtANYJ
         n51g5T5EPuD3UDX6YfFk1qsXQcWQs9SARJ4OmqSwrF3SJgB9ylht7xjVpU9nsRhWIBN7
         V93IrP6ADXMu1aTjyofn8qnxAycFjSUyYy712xMWkyBDNGiOGLLPc2GSluLJXt6TJNXM
         ji3NTsGoZ908lBuUd5Jyj99Br+/0QUfvkNbkMaErQ4vUrhmQMc7vlAdFxHteb93ykhSV
         P9UmVAiCXgENqb61dNG17y4SyHHSTTgDY3dm8uMuMW/QRlRZXQZmJoOlrSf6jSdDOB1I
         dzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yOdrSKjwBaIUNlnjyLGfplxUyqRliUQ2CbbCdbPdvKw=;
        b=LiBRcWw/n0uIHKlUWzDbvPi4dIG/7UT2M/jv57esYmFXUqY3ip45eJxC5YuONyyHHl
         1bl3s+ikNllZ+gVjAEYS3upFgrT3EeaGvyMnKJXA1iv8CxeP8FlgLgqXA6i3oLf432JZ
         BjH/I/BmVECOhyC7WrDZj+hqi9WZK5uUB/kgaHQVAUc9w333HFsMrsebLA//7RCN+WJ4
         1qRvqdtfS9ixKmJ8Y62mUWLikfVuR5Nc+VsSqGmFu9Gv3jdrA8ee6YSVKYtCENJVF8Zw
         AonRSw6ixabwG9whE9sIERIDrOGk7n7w6lW8GwjnD9LZ21cT6ZAy4ASVr4Ysq3YdkOpl
         W4cw==
X-Gm-Message-State: APjAAAWyX42qoyV0SGI5Lehe/8QfE2DEtIhKaTqPHexnP4EHRkUrsglj
        M3dFiyS9BEJsFueQfX5siS8yRA==
X-Google-Smtp-Source: APXvYqxRT+DvN0BmaDDXcy+bUuJ3mR8C/EPBFjXjYTTFz3UCuEGzat1l+IkMSejpu2oS3UVdNYkiWw==
X-Received: by 2002:a5d:9d4a:: with SMTP id k10mr5065272iok.134.1576186047344;
        Thu, 12 Dec 2019 13:27:27 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p21sm1543378ioh.53.2019.12.12.13.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 13:27:26 -0800 (PST)
Subject: Re: [PATCH 1/5] fs: add read support for RWF_UNCACHED
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, clm@fb.com,
        torvalds@linux-foundation.org, david@fromorbit.com
References: <20191212190133.18473-1-axboe@kernel.dk>
 <20191212190133.18473-2-axboe@kernel.dk>
 <20191212212146.GV32169@bombadil.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <003c3aaf-6672-972e-4056-26f81c704230@kernel.dk>
Date:   Thu, 12 Dec 2019 14:27:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212212146.GV32169@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/12/19 2:21 PM, Matthew Wilcox wrote:
> On Thu, Dec 12, 2019 at 12:01:29PM -0700, Jens Axboe wrote:
>> @@ -2234,7 +2250,15 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
>>  			error = -ENOMEM;
>>  			goto out;
>>  		}
>> -		error = add_to_page_cache_lru(page, mapping, index,
> [...]
>> +		error = add_to_page_cache(page, mapping, index,
>>  				mapping_gfp_constraint(mapping, GFP_KERNEL));
> 
> Surely a mistake?  (and does this mistake invalidate the testing you
> did earlier?)

Yeah I already caught that one too - this is new in the v4 patchset, so
doesn't invalidate any of the earlier buffered testing.

-- 
Jens Axboe

