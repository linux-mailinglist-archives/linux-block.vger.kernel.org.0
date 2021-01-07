Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED492ECBB0
	for <lists+linux-block@lfdr.de>; Thu,  7 Jan 2021 09:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbhAGIZI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 7 Jan 2021 03:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbhAGIZI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Jan 2021 03:25:08 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108D8C0612F4
        for <linux-block@vger.kernel.org>; Thu,  7 Jan 2021 00:24:28 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id b5so3280037pjk.2
        for <linux-block@vger.kernel.org>; Thu, 07 Jan 2021 00:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mlsyBVdsgGrix6QJ/XCIMgJ4rdeS6CKwjhRKFJ2eHuE=;
        b=PrrVbBmZvchTreI3qMLrqw2lYhHRWUGyNzGBc9Eu1CdGKwQbDf/aWOe9cT5q+Szc++
         wmmu8FGPFVfDpCQxvS4SChU/LqKUbFbbFdG1JEbX+uDy9r1Qp5YEJ43dqLc3i4PaJzNw
         zRww7u7f6hXd8oYlP5/1r+N99OxlzIdnO9DqeEhNS4Ny8WIyShXaFlq/iz2DE6Dkdt2H
         cISN+NVAS6kS8GQNQJg0asdG5kGxn9+WF2BPtgbRTyx0NCoPw2eyxmmNMD0XV8ZSxjiw
         u+QF1ZzckixzsOnTexi1GnM/hnaT83NnE2kNlImDdU1vUqqWunIQT/+8oU2ImnBxJM9h
         Aizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mlsyBVdsgGrix6QJ/XCIMgJ4rdeS6CKwjhRKFJ2eHuE=;
        b=szEgUT2gZZH7ZoVxMbyv/rcMuFmsbNqym2d4KMyzoGa5+qaRwCR9dEEQxE9KEPzg1P
         AUWypnj9FUecx+OzsvlaLgAPQtCG9Z2emgOsBIGAQttxmnRuxpr7k7pY7H6kFr8Bl0Je
         vUkPudPCwxfh0WTfPeh68fNUGokMvAkaFGW+1yaDPPtXog6Un81k45MNVecONOOEfq/c
         0v3aiiNHNat0oJ3ZoI0eIP9Dp0ojaOAFEMKSIYwVcFN2MqeRDBUMzN2e/AypMo/vsl6I
         8SovKfNaaOUx9xZLUHpiGEearUe1DttiFvFVarrX7FMNT30gkfJ0cA/tRU41kZdQ/s5K
         ZnkA==
X-Gm-Message-State: AOAM533SS8M75ZCg1QN9Ofp3l0AsDvtnd/XZBSUbkQ3YRAZj1/WADo+f
        G7w7OZZQFC4k1TxL7uatwhN17Q==
X-Google-Smtp-Source: ABdhPJzQOr6pYUWLGr2CxggdovBPjNhhr68AcwPf+dQqPkOnoc7ZEpu4Wmrr91bSEs5HYlIaEjHPMw==
X-Received: by 2002:a17:902:bc83:b029:dc:4525:2b0 with SMTP id bb3-20020a170902bc83b02900dc452502b0mr1194689plb.53.1610007867632;
        Thu, 07 Jan 2021 00:24:27 -0800 (PST)
Received: from [192.168.10.153] (124-171-107-241.dyn.iinet.net.au. [124.171.107.241])
        by smtp.gmail.com with UTF8SMTPSA id h12sm5316274pgs.7.2021.01.07.00.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 00:24:26 -0800 (PST)
Message-ID: <86f99579-7213-0d86-6cdd-dbf0f1bc1385@ozlabs.ru>
Date:   Thu, 7 Jan 2021 19:24:21 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
Subject: Re: [RFC PATCH kernel] block: initialize block_device::bd_bdi for
 bdev_cache
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210106092900.26595-1-aik@ozlabs.ru>
 <20210106104106.GA29271@quack2.suse.cz>
 <5e6716a6-0314-8360-4fb6-5c959022a24c@ozlabs.ru>
 <20210107074812.GA1089@lst.de>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <20210107074812.GA1089@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 07/01/2021 18:48, Christoph Hellwig wrote:
> On Thu, Jan 07, 2021 at 10:58:39AM +1100, Alexey Kardashevskiy wrote:
>>> And AFAICT the root inode on
>>> bdev superblock can get only to bdev_evict_inode() and bdev_free_inode().
>>> Looking at bdev_evict_inode() the only thing that's used there from struct
>>> block_device is really bd_bdi. bdev_free_inode() will also access
>>> bdev->bd_stats and bdev->bd_meta_info. So we need to at least initialize
>>> these to NULL as well.
>>
>> These are all NULL.
>>
>>> IMO the most logical place for all these
>>> initializations is in bdev_alloc_inode()...
>>
>>
>> This works. We can also check for NULL where it crashes. But I do not know
>> the code to make an informed decision...
> 
> The root inode is the special case, so I think moving the the initializers
> for everything touched in ->evict_inode and ->free_inode to
> bdev_alloc_inode makes most sense.
> 
> Alexey, do you want to respin or should I send a patch?

I really prefer you doing this as you will most likely end up fixing the 
commit log anyway :) Thanks,


-- 
Alexey
