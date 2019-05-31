Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5345430679
	for <lists+linux-block@lfdr.de>; Fri, 31 May 2019 04:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfEaCIH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 30 May 2019 22:08:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37367 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfEaCIH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 22:08:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id a23so5157096pff.4
        for <linux-block@vger.kernel.org>; Thu, 30 May 2019 19:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y+DNeDpkPOV3XZSv/aRGg+x+WrYKXS0/CjHakrrpa+g=;
        b=Zsx7RFa/zuYiRgvfdopk5pQ+rX3QFQcidDgv8x/HgwPIJLQMwHDEtIb8JK4o3LnKIM
         QYhGxNRc6lkwv6FIDulnKq+TR0YHQm/Oz2U+fIGKA75V9TMFqWX7Edxm3FiH2MFQjVAa
         iQK8T712yTGXqVVdnEL5MXbXwV2IZDQd85cps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y+DNeDpkPOV3XZSv/aRGg+x+WrYKXS0/CjHakrrpa+g=;
        b=DipR7GnKUQaZvFU3xUsA4lFVqLr3m85jVCsufL+f9PZfbNaeBta5ZL/HpwNUZ4X5+I
         XDdh7CzYlGfSmlifo38Z3GG8FhC+SjVx2HCdnJ3y3vFt+3XStMOmYSYJANPTS5oS9vCR
         Q/elmFz+pmvUfNOoPAVDm+ZKSe+k7pgYmOYq/yMQwzHzewNEvIWdul+gsgOhpuJGdTCh
         F29Yh9Btc+XKBCO6P4IUM9v4MJtlEIYbBa8rTra/5uGsmJ6sFnAkaLzI9+Kiy6fSm1p3
         HNkntiBDvLS+w0tXwgo6nVsOhswMt/DTjuEQrGptglZzXlsmYW55LnpTQcx8hHepnM2f
         VFJg==
X-Gm-Message-State: APjAAAWPkIlOokfv/Mmm3P0cRn+uSFEcuSjHMiGP1PaOy7NyC+AzI5N9
        32Po4LamzNJrmAYiLgi3cZtb4w==
X-Google-Smtp-Source: APXvYqy7W2dtC5iqtHH9w87bShUtFtQNlcsFca5GWghv0z/G58RZZzjAJFWyKkHCnHiMkPFLs+beQg==
X-Received: by 2002:a63:470e:: with SMTP id u14mr6370193pga.135.1559268486529;
        Thu, 30 May 2019 19:08:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j8sm4101223pfi.148.2019.05.30.19.08.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 19:08:05 -0700 (PDT)
Date:   Thu, 30 May 2019 19:08:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/8] block: Fix throtl_pending_timer_fn() kernel-doc
 header
Message-ID: <201905301908.D4CD6A81F7@keescook>
References: <20190531000053.64053-1-bvanassche@acm.org>
 <20190531000053.64053-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531000053.64053-4-bvanassche@acm.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 30, 2019 at 05:00:48PM -0700, Bart Van Assche wrote:
> Commit e99e88a9d2b0 renamed a function argument without updating the
> corresponding kernel-doc header. Update the kernel-doc header.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Fixes: e99e88a9d2b0 ("treewide: setup_timer() -> timer_setup()") # v4.15.
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  block/blk-throttle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 1b97a73d2fb1..9ea7c0ecad10 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -1220,7 +1220,7 @@ static bool throtl_can_upgrade(struct throtl_data *td,
>  	struct throtl_grp *this_tg);
>  /**
>   * throtl_pending_timer_fn - timer function for service_queue->pending_timer
> - * @arg: the throtl_service_queue being serviced
> + * @t: the pending_timer member of the throtl_service_queue being serviced
>   *
>   * This timer is armed when a child throtl_grp with active bio's become
>   * pending and queued on the service_queue's pending_tree and expires when
> -- 
> 2.22.0.rc1
> 

-- 
Kees Cook
