Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BEF4C5F46
	for <lists+linux-block@lfdr.de>; Sun, 27 Feb 2022 23:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbiB0WAR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 27 Feb 2022 17:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiB0WAP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Feb 2022 17:00:15 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8426AA75
        for <linux-block@vger.kernel.org>; Sun, 27 Feb 2022 13:59:38 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id t5so272784pfg.4
        for <linux-block@vger.kernel.org>; Sun, 27 Feb 2022 13:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZrKI3DSZdTxekUPySsEMaohdk0Ebr8lmd+pDdB2Ygvc=;
        b=AEhyForKjbDZKEq/PFv6p/G2ZB3dSs895NqBGgn0JW1Tpv1osByHflyrOYUBKFe77q
         rEzyndlbiiho8KtHMqzE7la0X+pbnixp070cQjW5ARtttgU/Am64dO7sDyfRknxLrR3K
         B5709/Td+SGSynJoMRndSLIvppWg0zHQ/RNreCH4AAiQbKAvmExz7Q5DXgKbdUajZAdz
         6GSAmhxXaOW1i2nQEZWU8VAkNeBD9W+wTXXgmD0ohNTFh0XI/Ziv8rrDbVUm955l6TZL
         0ByyWm6Mlf4+963avEfu65LwMhX6InrJK8z7CPhZ9K5MzRYcNmotW4008jGVKXEw8WvJ
         gqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZrKI3DSZdTxekUPySsEMaohdk0Ebr8lmd+pDdB2Ygvc=;
        b=xfDaciZU5Jpf7NuCvUrFh7uTaFrjBB/fZHeBfQVp5EimS7icIVMGjmDFb7C0qZcnKH
         ynSe5CtZ9jXvrfC4Dt5DjGvtfXs5T/gt3jbqyumnj349X/FsDT2u0Sxv8cH2HPsSg+JH
         NoUOpoGGul+cVGls0Tr9uE2+woOIQlCwt0mumx3heUZ5SGhAx7UbuayiiQFtYzWOUy+e
         QMZrYN/dXMnFbdtEcQ4w8uCgpjXXGkGpWOrWu1bMGmm6NH7jOYii0x8mY2vE4QsWwhez
         YCSO3rMmQSjoAb5rypfHDUqh7xCA6ZIpkCJBQ05UY4fOxzAvtwwdEMdDaqPYA/wbqudC
         riLA==
X-Gm-Message-State: AOAM530IQNFalau+ufX3MXTOyXqPgO2TNALrxT17ba49Xq4CZdWUpZ4N
        mxlx/GgU1qDnfx5lrQtQgRJkSA==
X-Google-Smtp-Source: ABdhPJyaSQFLGaa+8maa8wDtePuQmdliyTg6t1OPFEjFv3DiD8FgQGuKlD2bA9CLsLw5mSJh0YHR0g==
X-Received: by 2002:a05:6a00:8ca:b0:4e0:2ed3:5630 with SMTP id s10-20020a056a0008ca00b004e02ed35630mr18547182pfu.3.1645999178369;
        Sun, 27 Feb 2022 13:59:38 -0800 (PST)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id f31-20020a631f1f000000b003742e45f7d7sm8492806pgf.32.2022.02.27.13.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Feb 2022 13:59:37 -0800 (PST)
Message-ID: <8b5b35fa-3c70-adc8-ca3a-4829388c4d12@kernel.dk>
Date:   Sun, 27 Feb 2022 14:59:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 4/6] block, bio, fs: convert most filesystems to
 pin_user_pages_fast()
Content-Language: en-US
To:     jhubbard.send.patches@gmail.com, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
References: <20220227093434.2889464-1-jhubbard@nvidia.com>
 <20220227093434.2889464-5-jhubbard@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220227093434.2889464-5-jhubbard@nvidia.com>
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

On 2/27/22 2:34 AM, jhubbard.send.patches@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> Use pin_user_pages_fast(), pin_user_page(), and unpin_user_page() calls,
> in place of get_user_pages_fast(), get_page() and put_page().
> 
> This converts the Direct IO parts of most filesystems over to using
> FOLL_PIN (pin_user_page*()) page pinning.

The commit message needs to explain why a change is being made, not what
is being done. The latter I can just look at the code for.

Didn't even find it in in your cover letter, had to go to the original
posting for that.

-- 
Jens Axboe

