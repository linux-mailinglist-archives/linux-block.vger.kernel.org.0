Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616FC302125
	for <lists+linux-block@lfdr.de>; Mon, 25 Jan 2021 05:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbhAYEfy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 24 Jan 2021 23:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbhAYEfw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Jan 2021 23:35:52 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDA4C0613D6
        for <linux-block@vger.kernel.org>; Sun, 24 Jan 2021 20:35:12 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id h15so4335881pli.8
        for <linux-block@vger.kernel.org>; Sun, 24 Jan 2021 20:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RF+U31mjU+vQtmYKwQP7k4EqO/12hyWNFfFTp846sxc=;
        b=CfOwQ7limljMA7zl/lIAXVsTIKtNDlhwsicqotNl3TtlKhEjyZeIlEEJtHYW4c2U31
         UY4hC8hbmTVMaTURi/h7AUevTqeIqn+Q1FFnUUJ35BV9ke4apIRUY5I8NbeB8KXYicfU
         +trWj06hwAqSeMB9yfxG8wvJYR9/caMYTWeGkZl5KTSBZfynGCBz84SyjX0hbk7AWcGA
         /222IeHt9HOYYROpDQ0wb25k1uTdAAL1nhrslb3U6So17SP9tJY8mfEDx1CUbEE7qC63
         qpRcjNyJveRtr7uQu1UM1fJCkiAbkBaCmTSnXoAaT+i+isB4hYXJxGmrbyMs7d8MUbF7
         BPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RF+U31mjU+vQtmYKwQP7k4EqO/12hyWNFfFTp846sxc=;
        b=mXpigXogLhXQG0f3rdygecsDlkZO7GwJlxDUcIa42y6CUR79DHoK85hV8yjwxeocwD
         no+aiVyBv2nrTvePKZ42iu85C5DABlLxW+83WQEKwC3nSGWNF4Fj5g6WZsgxZ+nujin8
         /ybcf3vyLyutjVWya3EWWt8wvemQgCs7W+DTZZWovjFbSGD8TxBOhJLYZJ4E3LWJtBQA
         BuUBRexnPVlvDOZCM/qa5LQJnBRVAG3yQQXZ2BW2sddK3ctLO3jSVRh7fptZk62Cii+i
         sNekOUEZOGcHxe5OmkF5epnSf28QXeH9yjEHVAeK/7OMCiLVmcbqOQkLc3WcHF4a7ScJ
         Agdw==
X-Gm-Message-State: AOAM530FqRas1QVwUcKouuyMfQmi9eKFYrlu2X1fvB6ZC7aPQtgKnsie
        1Vvs8XQQ8TJ1m7fATqxG/ff5uQ==
X-Google-Smtp-Source: ABdhPJwcVIfcZhKpz36wBWgY9pEAr1Osy03vWby4EQev/6n4B5mRbyHylHT/8WSUq/UooHKSU12Q8g==
X-Received: by 2002:a17:90a:1c09:: with SMTP id s9mr6518112pjs.83.1611549310994;
        Sun, 24 Jan 2021 20:35:10 -0800 (PST)
Received: from [10.8.2.15] ([185.125.207.232])
        by smtp.gmail.com with ESMTPSA id x21sm15191515pgi.75.2021.01.24.20.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 20:35:10 -0800 (PST)
Subject: Re: [PATCH V2 0/2] remove unused argument from blk_execute_rq_nowait
 and blk_execute_rq
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, target-devel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-ide@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
        hch@infradead.org
References: <20210122092824.20971-1-guoqing.jiang@cloud.ionos.com>
 <683e16be-1146-e60c-cfea-e4606844f080@kernel.dk>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <73fd70be-90bc-9c6c-dcbe-7981f8fef4f5@cloud.ionos.com>
Date:   Mon, 25 Jan 2021 05:34:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <683e16be-1146-e60c-cfea-e4606844f080@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 1/25/21 02:24, Jens Axboe wrote:
> On 1/22/21 2:28 AM, Guoqing Jiang wrote:
>> V2 changes:
>> 1. update commit header per Christoph's comment.
>>
>> Hi Jens,
>>
>> This series remove unused 'q' from blk_execute_rq_nowait and blk_execute_rq.
>> Also update the comment for blk_execute_rq_nowait.
> 
> What's this against? The lightnvm patch doesn't apply.
> 

Sorry for that, will resend against for-5.12/block.

Thanks,
Guoqing
