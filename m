Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB544DB7E4
	for <lists+linux-block@lfdr.de>; Wed, 16 Mar 2022 19:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349571AbiCPS1s (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 16 Mar 2022 14:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237492AbiCPS1r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 14:27:47 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D266D961
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 11:26:32 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id l2so5972537ybe.8
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 11:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+VVGHpNw2aToH4nlv/qP4fsUY4xFNKKSta7CoxCOLqU=;
        b=Im3UELGk/iBvvXDdwloE1LayQw78/8xAF5xIkzHUcYNoTmJQWTbW5FnZyqyYEgkf/2
         u6yjX7f4cTiiB6Xl/VU6E5cj6YVeOpmIafJOgwchCrZVrCmBGaGiUTzK8ypCnXwxX13n
         /DVouNRz5uqNvN42UYjat3gLTPyDsihe7EGdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+VVGHpNw2aToH4nlv/qP4fsUY4xFNKKSta7CoxCOLqU=;
        b=TPLolZxtISnG9zZoJ1Xp3HG68msmeZfwOONdq7i6aP/L9TTpVTOyGBYoIjBXdQ1/sn
         WxpCP2AJvkZ20rJLir276+koE5jRna8JXX486dDch+qt1D1vh5gmcPV8/1jz5l1q77oX
         L31dGTT5X6cr4gC+Opms+jYNOl7NQKuBTtl0vrF8bxYDwrvi7UYJFY9c5cYwra5M7svI
         WXxM150w6IWMwl2tynbdcwZSuBq0EP7oh2VTkmIyRReXT2lGJqYyiWM3qC2BYImJ8587
         zh+KVIGmFLPKhN3ONNtYNcOVrqhPXHenokOIUpAfOTIvJLuJ5BfkWpBsh6cWGrhKSVdY
         aGOw==
X-Gm-Message-State: AOAM531xeQdxRUARAq2hQku8wK0acIXic2mHumFaW+kTdazQLLqbiRow
        TiFUQ89BdxSJJ9tzKpjSsaQRRzIT5XW3h3LN2uafrQ==
X-Google-Smtp-Source: ABdhPJxgt41Y/UgMqCYCVzLLEzyZ00uN4v/bBuIogqY9sdSDfrECHl2+T+gNWPVLRmPOUuKWlmIHWV6lhzeCmDlncpY=
X-Received: by 2002:a25:918f:0:b0:633:6f7d:6d78 with SMTP id
 w15-20020a25918f000000b006336f7d6d78mr1343447ybl.134.1647455191504; Wed, 16
 Mar 2022 11:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <CABWYdi2a=Tc3dRfQ+037PG0GHKvZd5SEXJxBBbNspsrHK1zNpQ@mail.gmail.com>
 <CABWYdi1PeNbgnM4qE001+_BzHJxQcaaY9sLOK=Y7gjqfXZO0=g@mail.gmail.com>
 <YjA439FwajtHsahr@google.com> <YjEOiZCLBMgbw8oc@google.com>
In-Reply-To: <YjEOiZCLBMgbw8oc@google.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Wed, 16 Mar 2022 11:26:20 -0700
Message-ID: <CABWYdi0jd_pG_qqAnnGK6otNNXeNoiAWtmC14Jv+tiSadJPw0w@mail.gmail.com>
Subject: Re: zram corruption due to uninitialized do_swap_page fault
To:     Minchan Kim <minchan@kernel.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 15, 2022 at 3:09 PM Minchan Kim <minchan@kernel.org> wrote:
> I think the problem with CLONE_VM is following race
>
> CPU A                        CPU B
>
> do_swap_page                do_swap_page
> SWP_SYNCHRONOUS_IO path     SWP_SYNCHRONOUS_IO path
> swap_readpage original data
>   swap_slot_free_notify
>     delete zram entry
>                             swap_readpage zero data
>                             pte_lock
>                             map the *zero data* to userspace
>                             pte_unlock
> pte_lock
> if (!pte_same)
>   goto out_nomap;
> pte_unlock
> return and next refault will
> read zero data
>
> So, CPU A and B see zero data. With patchset below, it changes
>
>
> CPU A                        CPU B
>
> do_swap_page                do_swap_page
> SWP_SYNCHRONOUS_IO path     SWP_SYNCHRONOUS_IO path
>                             swap_readpage original data
>                             pte_lock
>                             map the original data
>                             swap_free
>                               swap_range_free
>                                 bd_disk->fops->swap_slot_free_notify
> swap_readpage read zero data
>                             pte_unlock
> pte_lock
> if (!pte_same)
>   goto out_nomap;
> pte_unlock
> return and next refault will
> read correct data again
>
> Here, CPU A could read zero data from zram but that's not a bug
> (IOW, warning injected doesn't mean bug).
>
> The concern of the patch would increase memory size since it could
> increase wasted memory with compressed form in zram and uncompressed
> form in address space.  However, most of cases of zram uses no
> readahead and then, do_swap_page is followed by swap_free so it will
> free the compressed from in zram quickly.
>
> Ivan, with this patch, you can see the warning you added in the zram
> but it shouldn't trigger the userspace corruption as mentioned above
> if I understand correctly.
>
> Could you test whether the patch prevent userspace broken?

I'm making an internal build and will push it to some location to see
how it behaves, but it might take a few days to get any sort of
confidence in the results (unless it breaks immediately).

I've also pushed my patch that disables SWP_SYNCHRONOUS_IO to a few
locations yesterday to see how it fares.
