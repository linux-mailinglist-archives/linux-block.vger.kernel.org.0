Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C80540315E
	for <lists+linux-block@lfdr.de>; Wed,  8 Sep 2021 01:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347032AbhIGXGn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 7 Sep 2021 19:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240690AbhIGXGm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 19:06:42 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61726C061575
        for <linux-block@vger.kernel.org>; Tue,  7 Sep 2021 16:05:35 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id y18so699779ioc.1
        for <linux-block@vger.kernel.org>; Tue, 07 Sep 2021 16:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/WqGdTadLCtXXo2y/kR/SCyjXiwUCBFZHM8m7zSgBq4=;
        b=ZeZ+12BAIiillN1quw9HtNbnsbBpRYvadFQPd1qT/RKk6Ma3+8A4wVxtWMq82N9pP7
         fXmnGkz66jgOVcfmO4ULXPBWITfunTYijvJICK2vJDyREWjmlstRlOnVn028yQ9jJq68
         Sm59cWiEJtlLxqCmhukG1MnsbZtdGmIQmsJ45Gh1/ZNEOUCq+5+vYYfDnFsWZVGzVb0I
         4DxH+xRZt6GfAf9U58X4yduUao2q59Zva9fHsI9uIalnkYj41C0xTzZArV7C79tN54UT
         6mBliiodfePrMtFa0XNpJk/cl2RBD0HuKVhDqWOALwuK62mP9GQrmL38ob6jxf3NdgLH
         UmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/WqGdTadLCtXXo2y/kR/SCyjXiwUCBFZHM8m7zSgBq4=;
        b=GxX28DbdkZh76km607fo5wfwLPpf4GA/3fSZEgbFCVHjpjf4nhuTRKPJbZ0JJvtEuD
         tGZPkKadKtB1+0rLRXXYK2wuI2NSb29RhwtQqrYxzM5iYcEPBWyb//hGpG07cH5rQxa0
         4FV6MhJ0DxaMN0OE7OHXaP9CyQW2cGJGjVy+SlI0sc0tnaTVH+YQjCoESEU9FvQ9nH0E
         FUPwiHATXx/s38Pw7ZYBdvM5kpQZQLoETNqixvtWuWXDA7Bav1R9we8Q3shg1+voQu7w
         6J3ezPt5ol2CgVHQ+pTI9r6dLQID+E5DoGGtImdN0D4g462N8jkq1s5WgZV0dRFzNaKN
         hkxQ==
X-Gm-Message-State: AOAM533lxu/Q4hZWD9DxaZI0rpkdA7vQyWqKKCCOeD3u2gXi0qonFtVi
        9cKyFULvKUNNEWDbHVFePogiNpMKdCxrrQ==
X-Google-Smtp-Source: ABdhPJxBWhJg3BewEfgj77vyghzozcl09E8uSOxe9n6t0/3BjeM+dZopb0kYT4NeYjPcZYK9K4GF3g==
X-Received: by 2002:a05:6602:1581:: with SMTP id e1mr516323iow.49.1631055934716;
        Tue, 07 Sep 2021 16:05:34 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j5sm238994ilu.11.2021.09.07.16.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 16:05:34 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: allow 4x BLK_MAX_REQUEST_COUNT at blk_plug for
 multiple_queues
To:     Song Liu <songliubraving@fb.com>, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org
Cc:     marcin.wanat@gmail.com
References: <20210907230338.227903-1-songliubraving@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f64a938a-372c-aac1-4c5c-4b9456af5a69@kernel.dk>
Date:   Tue, 7 Sep 2021 17:05:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210907230338.227903-1-songliubraving@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/7/21 5:03 PM, Song Liu wrote:
> Limiting number of request to BLK_MAX_REQUEST_COUNT at blk_plug hurts
> performance for large md arrays. [1] shows resync speed of md array drops
> for md array with more than 16 HDDs.
> 
> Fix this by allowing more request at plug queue. The multiple_queue flag
> is used to only apply higher limit to multiple queue cases.

Applied, thanks.

-- 
Jens Axboe

