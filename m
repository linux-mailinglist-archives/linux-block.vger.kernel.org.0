Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D9C395651
	for <lists+linux-block@lfdr.de>; Mon, 31 May 2021 09:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhEaHk7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 31 May 2021 03:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230312AbhEaHkz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 May 2021 03:40:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7784E6120E;
        Mon, 31 May 2021 07:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622446756;
        bh=pCTp3jiJn1iMuVY/2p1ZT4vRAxgTBasdvw80qGkYYRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZAyTQX97Jbe+/ZTbG0i0GlUMUnEreokzI6dJwFmdAex3GQC/TgIHA2FNvNmLkHcR/
         rgcNu9mQjzYKqwAK6E/d9q1m8LN7KcM6015yxBzUCPRaQheIBvjdeC8K/rFx9sMrTz
         mzjqhNzEpNSMHxDb8KCCfmd1VSdMDxUuaV7BZpyc=
Date:   Mon, 31 May 2021 09:39:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, arnd@arndb.de, linux-block@vger.kernel.org
Subject: Re: [PATCH] remove the raw driver
Message-ID: <YLSSoRf3xXWEKGmV@kroah.com>
References: <20210531072526.97052-1-hch@lst.de>
 <YLSSgyznnaUPmRaT@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLSSgyznnaUPmRaT@kroah.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 31, 2021 at 09:38:43AM +0200, Greg KH wrote:
> On Mon, May 31, 2021 at 10:25:26AM +0300, Christoph Hellwig wrote:
> > The raw driver used to provide direct unbuffered access to block devices
> > before O_DIRECT was invented.  It has been obsolete for more than a
> > decade.
> 
> What?  Really?  We can finally do this?  Yes!
> 
> For some reason, I thought there was some IBM userspace tools that
> relied on this device, if not, then great!
> 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 

Ah wait, this is in my subsystem :)

I'll queue this up in a few days if no one complains.

thanks,

greg k-h
