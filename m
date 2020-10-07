Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC25285680
	for <lists+linux-block@lfdr.de>; Wed,  7 Oct 2020 03:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgJGBu7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 6 Oct 2020 21:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgJGBu7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Oct 2020 21:50:59 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515DEC061755
        for <linux-block@vger.kernel.org>; Tue,  6 Oct 2020 18:50:59 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gm14so259273pjb.2
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2020 18:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TqHElblEUNOu/az3HKD2MtYdO4N9TYFu9tSH2Q29boU=;
        b=ESkySwR9q21mUhedBgLuoRUrv5HR5+B4XWDZcTRzoXEV090MPytPwDCZ66oDQXqPYa
         B3reVmXsY8vcvyYVtaTiG+kmWU1vevpS9yDxmtsiq2bJgXkSH37eEq7ShAK0bnHwo/dF
         BAIPkQOYOI0jODjoqawZSVczJF9nOcgsn/F1nLAJ0QGezawlNhvX4Byh4IRZzRcTL8oS
         JyfvK3s2N8KFYxVQqAhfQDDV3cK0vtSU8x1mIqBx5s+yad/IcIY/Xy+LWboJZ2xC+7Of
         2DqOWBCjR34qqC79EjMctEQyKWWjKGpE5N4tdiri5Om4SQG+8aP4Mv+j+xioS53tNaze
         e3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TqHElblEUNOu/az3HKD2MtYdO4N9TYFu9tSH2Q29boU=;
        b=pJmRqztuTR7M0NABk2nUD5FYvjeztnJRFSP6Hy2rgC6JJ+fcLxnmEfVW47I1oKIkq1
         KzyX+QnkcpNiGABt1DlHAEPWqLnWZwhVEMuRcNPwAH++EtoIUht+TbI94Pbb9edQLHxM
         9mO6MZKJWcRNT88jp8cApGV8da8dMLPbmTCKqs/BhLrVm4PB1ReU8+Bda/JvSghsi4SH
         M+Qa8240PVzE7/RvMBI5uwZmKQlgykt/iMzGkcACOneuBRWzuwLnE4K0B2fZmWrrPA1P
         zNe7nTnUmbEUT59+KbQHKLDPP6IQrQ2tcLiGrpS0oYkIOiv7StrqOGknibdasPNUxfPO
         L2zw==
X-Gm-Message-State: AOAM53089sIPE3mclL2iOE3toX8b9ax6fr1JM9r5jgzz1GAn/ZQKjRd7
        zKnEnWG2WdU+2dRLEXRPWzS1EuMFJR7ah+uBeMGNvQ==
X-Google-Smtp-Source: ABdhPJz5tAXgKQtqclifCbHVpDFk9k1IMHruU85dPLUeZi5fxZNaR5jIeWu7k9I7s+v+puPMHINznVZUf/EJB7hMQ7k=
X-Received: by 2002:a17:90a:b78b:: with SMTP id m11mr833325pjr.13.1602035458679;
 Tue, 06 Oct 2020 18:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200923114419.71218-1-songmuchun@bytedance.com>
 <CAMZfGtUFacR9GFfmySEN6EfdxVi7ZKdwTs17HrJmOL9A38J8sg@mail.gmail.com> <a1488045-afd0-39c5-0b56-079fc51723d4@kernel.dk>
In-Reply-To: <a1488045-afd0-39c5-0b56-079fc51723d4@kernel.dk>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 7 Oct 2020 09:50:22 +0800
Message-ID: <CAMZfGtV_L9fDqbF2+cKE3fEjis+bCMhhGQMD0vtyyDb=VcUZEg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 0/5] io_uring: Fix async workqueue is
 not canceled on some corner case
To:     Jens Axboe <axboe@kernel.dk>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Yinyin Zhu <zhuyinyin@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 7, 2020 at 4:26 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/28/20 6:50 AM, Muchun Song wrote:
> > Ping guys. This is worth fixing.
>
> Agree - can you respin with the suggested change?

OK, will do.

>
> --
> Jens Axboe
>


-- 
Yours,
Muchun
