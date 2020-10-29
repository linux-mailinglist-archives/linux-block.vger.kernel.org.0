Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7465D29F4D8
	for <lists+linux-block@lfdr.de>; Thu, 29 Oct 2020 20:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgJ2TWX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 29 Oct 2020 15:22:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgJ2TVt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Oct 2020 15:21:49 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 050A02076D;
        Thu, 29 Oct 2020 19:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603999308;
        bh=pdykT16/rVEziaaG5RdM3lEtS/w+LI8XiLCAZlcWks4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wvFa+H3ltd/KceNSVzRxuEvb4/yIp8XEWzMhGYowB+Twg2jSJ3L5WyWeusnSBwpn8
         MLGwzanPislMk687l8KcPLRyDB5GIPp9Nv5jMDvN4drnG1SKT1GE0qQKBH5x9VtegP
         uARf1s83D3FCEVBOHmzukS/R4dTxQW3adPDpMses=
Date:   Thu, 29 Oct 2020 20:22:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 02/18] block: open code kobj_map into in block/genhd.c
Message-ID: <20201029192236.GA991240@kroah.com>
References: <20201029145841.144173-1-hch@lst.de>
 <20201029145841.144173-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029145841.144173-3-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 29, 2020 at 03:58:25PM +0100, Christoph Hellwig wrote:
> Copy and paste the kobj_map functionality in the block code in preparation
> for completely rewriting it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Yes!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

After this, you want me to get rid of kobj_map, right?  Or you don't
care as block doesn't use it anymore?  :)

thanks,

greg k-h
