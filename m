Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5701F7311D6
	for <lists+linux-block@lfdr.de>; Thu, 15 Jun 2023 10:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbjFOIMq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 15 Jun 2023 04:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239764AbjFOIMn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2023 04:12:43 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AAE26B8
        for <linux-block@vger.kernel.org>; Thu, 15 Jun 2023 01:12:37 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f6283d0d84so10108682e87.1
        for <linux-block@vger.kernel.org>; Thu, 15 Jun 2023 01:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20221208.gappssmtp.com; s=20221208; t=1686816755; x=1689408755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zGTiHQrhaAJSUC61c2YPaRGro3EmyDPsldMcLZccS04=;
        b=rnSud88z3yGn24afsyPHfViHe3GRRLhOk7w3aqRFK5pcfOL54c8yNkvG4URKJODzV3
         74AGtUxjwjQhXOF5a7bk0Kv3rrCdrraecgKCjwCAu/Mtfp0TdhKq8eDJL4FT5pI4rNfm
         d4QeJwuQmE7zAzeXc3ie0OtZwQSbLLpAH/qvQlKC4WZCoVq19HJTqEtksbR7OXvvCSrH
         OLY6zyvpV8D5PcRKLJUPhdAgSqXS+ZgwMpkxrYIU6uiux6QOFC99fpZtJghJKfsYzRz5
         65EYLHqCJnxH7sAurcyKyIflxlN2ooFSdAOU+qV5g539xzq2IZiGKQBYfdy52wtZom0G
         shRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686816755; x=1689408755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGTiHQrhaAJSUC61c2YPaRGro3EmyDPsldMcLZccS04=;
        b=h9qPBWxxAGEu96hHVqTjEYHCTUHUQkN/VQM3vfktbXpel0QgBekRmIrGRLr+OVsAz+
         PLIm5WA0JsnLLshTtZbNY9wXjLbO5MkadnakCfhdJGgJ9ZBy8wjVdWrVH6/xzz8yAYr6
         uf1X3JyNoAo6OdPyKFWjROCbXipyV1QUBBxlU+ZxKxJsE0wMBVNycv6ivraFLlKAZ6IR
         CN7b4TcCtQHSsZ7t4WpGjvODWH7YGDHcCynWGusqB1oW3dnfn4zCBUJjlD1MhKk3eArN
         WsU02JxbhMVO+/QP9nlRC9mwOw+/b3+0DEEineAw4Oa0uaWtdavq1GAmCHjo+VeNm+9T
         nYfQ==
X-Gm-Message-State: AC+VfDwgq5md2bGeV329S8lzlZGpY740OCu9q9Q0qQpNfdGRctyj8hbI
        1LZkcQQge2AFeZc0raGUzaqKKFu/UYQF93v4unqj7w==
X-Google-Smtp-Source: ACHHUZ7++tlNQo4pbEToMtpZEUEumJTy3i0Hm6NVXk3Oq8jUwvT2dviPsNY/5jQvVsXomuzu7Z+ymw==
X-Received: by 2002:ac2:4e8a:0:b0:4f8:4673:26ca with SMTP id o10-20020ac24e8a000000b004f8467326camr264155lfr.47.1686816755378;
        Thu, 15 Jun 2023 01:12:35 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id a3-20020a056000050300b003068f5cca8csm20186044wrf.94.2023.06.15.01.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 01:12:34 -0700 (PDT)
Date:   Thu, 15 Jun 2023 09:12:33 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Jordy Zomer <jordyzomer@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/1] cdrom: Fix spectre-v1 gadget
Message-ID: <ZIrH8fMomznQWZGj@equinox>
References: <20230612110040.849318-1-jordyzomer@google.com>
 <20230612110040.849318-2-jordyzomer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612110040.849318-2-jordyzomer@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 12, 2023 at 11:00:40AM +0000, Jordy Zomer wrote:
> This patch fixes a spectre-v1 gadget in cdrom.
> The gadget could be triggered by,
>  speculatviely bypassing the cdi->capacity check.
> 
> Signed-off-by: Jordy Zomer <jordyzomer@google.com>
> ---
>  drivers/cdrom/cdrom.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 416f723a2dbb..ecf2b458c108 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -264,6 +264,7 @@
>  #include <linux/errno.h>
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
> +#include <linux/nospec.h>
>  #include <linux/slab.h> 
>  #include <linux/cdrom.h>
>  #include <linux/sysctl.h>
> @@ -2329,6 +2330,9 @@ static int cdrom_ioctl_media_changed(struct cdrom_device_info *cdi,
>  	if (arg >= cdi->capacity)
>  		return -EINVAL;
>  
> +	/* Prevent arg from speculatively bypassing the length check */
> +	barrier_nospec();
> +
>  	info = kmalloc(sizeof(*info), GFP_KERNEL);
>  	if (!info)
>  		return -ENOMEM;
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 
Hi Jordy,

Thanks for the patch, I will review/build it properly tonight after
work, although at first glance it looks good to me. I'll be in touch.

Regards,
Phil Potter
