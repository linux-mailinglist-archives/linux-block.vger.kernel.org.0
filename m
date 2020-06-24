Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F972076F7
	for <lists+linux-block@lfdr.de>; Wed, 24 Jun 2020 17:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404266AbgFXPOO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 24 Jun 2020 11:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403831AbgFXPOO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 11:14:14 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3022AC061573
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2020 08:14:14 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id d4so1565477pgk.4
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2020 08:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ps+DmDWICz6+D3WRaFwXTobME9VB1u3KQwLSIO91+tk=;
        b=xZIbVshrwWWLxcKIigRdYSM0mQ0nKCs67DOMUGGIQlBMb9rEUc90OCVJt+JA5t2ukE
         o3JKzqQ1VL8Dj8JuTc2eZxA5lvSq3W7ZDZl5QV/P7N2p0EoVUqX+kksHwolzClLiXyLL
         Ys3Ei+a+iCP+ma0Nae31UP5NF3YaLXZj0FSrIpaNqGSa60QGrKZt1OlHUYMAqB8k/6d/
         LbJVQGwTtW7y/Kl6NUbHJFXXOShX7hHl6pCAw4OD5Hm/2kgzz34+Nb4adlSYLKuBxTSW
         VMO4MQ1jZM4E57/tK07JCxoYBCU3cCPRO7EXy4EcFSCd7FePtBbLmw7TP8ogZVX7fUVX
         /4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ps+DmDWICz6+D3WRaFwXTobME9VB1u3KQwLSIO91+tk=;
        b=aSLAndLcFuW960GIcV8Bw/8DCT9yGmjSM0fMTZKehfozbPymCNzNDy3E9f5IsZeMw0
         3ot1G7nyPaSlkj4yb177MzgfaKTVrXC5VnsYIdhFti7O/j2xI984P322A6ie+RXi1S1S
         +fQPMfk/0VqLWzSiYczq2ksMFEVpswXMoCw1T3ztkCWA0SF7eFrQHXdFUOblhvBJAB7q
         8rsKSRyHSF2K0BXGzN+oxG8y+yH4EdwXadwwRRTjJSn28uj3Fne/wx5p5ig23W0vyKgC
         Lu9jQ/CEd5x6+vvC7jL765my2aAV+LYa/OnCLQOmxQoShsdZgZrhDg9u3YaNz3ZxUseY
         wdqQ==
X-Gm-Message-State: AOAM530pt6oaHmcimcCobq/EDsSzbmalQi4agF+BxELKz8pbSE/If4c1
        6H955bqHAdTX74jPbTqdX1ncKw==
X-Google-Smtp-Source: ABdhPJzYL1CFUVfnzLvI6QU88euYu/ZksQ0VBb3mRMhCLNIUkamn41/nsnDt2BfAPm0YWMGKFGGbaw==
X-Received: by 2002:a63:f50b:: with SMTP id w11mr22012876pgh.157.1593011653721;
        Wed, 24 Jun 2020 08:14:13 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b191sm17710007pga.13.2020.06.24.08.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 08:14:13 -0700 (PDT)
Subject: Re: move block bits out of fs.h
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200620071644.463185-1-hch@lst.de>
 <c2fba635-b2ce-a2b5-772b-4bfcb9b43453@kernel.dk>
 <20200624151211.GA17344@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <216bcea4-a38d-8a64-bc0f-be61b2f26e79@kernel.dk>
Date:   Wed, 24 Jun 2020 09:14:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624151211.GA17344@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/20 9:12 AM, Christoph Hellwig wrote:
> On Wed, Jun 24, 2020 at 09:09:42AM -0600, Jens Axboe wrote:
>> Applied for 5.9 - I kept this in a separate topic branch, fwiw. There's the
>> potential for some annoying issues with this, so would rather have it in
>> a branch we can modify easily, if we need to.
> 
> Hmm, I have a bunch of things building on top of this pending, so that
> branch split will be interesting to handle.

We can stuff it in for-5.9/block, but then I'd rather just rebase that
on 5.8-rc2 now since it's still early days. If we don't, we already
have conflicts...

-- 
Jens Axboe

