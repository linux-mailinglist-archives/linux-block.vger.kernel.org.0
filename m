Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA7D3B0F6E
	for <lists+linux-block@lfdr.de>; Tue, 22 Jun 2021 23:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhFVVfA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Jun 2021 17:35:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229501AbhFVVfA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 17:35:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC3926128E;
        Tue, 22 Jun 2021 21:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624397563;
        bh=ra01qg534yKmakXLE1/PAZ/W4gilL7B6POGHGwDuICA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ipxZmQjLE0nAL9ysiTXm/x4lDr/bYnUUEL52b3rpYmyHMZuQgk2fIZBa3e49pHqVQ
         jyx24Ic1FdQAZXCzKkiuhwhUqhvuG6cudh8BLbPQ7A8bYzN/HCoRPRGEOzrDwyG3Fd
         e5J/KnS9/ByI1F2R/9scn9/zBz8/YlTejxP4o+/4=
Date:   Tue, 22 Jun 2021 23:32:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     rafael@kernel.org, jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, minchan@kernel.org,
        axboe@kernel.dk, mbenes@suse.com, jpoimboe@redhat.com,
        tglx@linutronix.de, keescook@chromium.org, jikos@kernel.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/base/core: refcount kobject and bus on device
 attribute read / store
Message-ID: <YNJW+ZnoV5w8PZhm@kroah.com>
References: <20210622210659.3708231-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622210659.3708231-1-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 22, 2021 at 02:06:59PM -0700, Luis Chamberlain wrote:
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2039,31 +2039,68 @@ EXPORT_SYMBOL(dev_driver_string);
>  
>  #define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
>  
> +struct bus_type *bus_get(struct bus_type *bus);
> +void bus_put(struct bus_type *bus);
> +

Didn't checkpatch complain about this?

We have a local .h file for stuff like this, can you please use it?

thanks,

greg k-h
