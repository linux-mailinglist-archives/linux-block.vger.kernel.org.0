Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF23B158599
	for <lists+linux-block@lfdr.de>; Mon, 10 Feb 2020 23:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgBJWdP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 10 Feb 2020 17:33:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbgBJWdO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Feb 2020 17:33:14 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B867920733;
        Mon, 10 Feb 2020 22:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581373994;
        bh=jT3uopW9+7ytWLe7n5gn4LJBnxR0xlA1lSsUTmiEG1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LTPLRKEFL2gTWJLg1ypmQAmyD1AakMbq6MSdiBfuVunfbyjjWU6R4R21dpYh/Y/pz
         l13ATVUm4caArvS4IZA0/tACtNbx3EeX9F7YcU206tQXVcyE8TgQ7JKdFV07XPKAOZ
         NdHA1mYsSQ5bri9MmDHG3RJEir3HFVOR/v1zkwtc=
Date:   Tue, 11 Feb 2020 07:33:08 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, damien.lemoal@wdc.com
Subject: Re: [PATCH] block: support arbitrary zone size
Message-ID: <20200210223308.GA20507@redsun51.ssa.fujisawa.hgst.com>
References: <20200210220816.GA7769@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210220816.GA7769@avx2>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 11, 2020 at 01:08:16AM +0300, Alexey Dobriyan wrote:
>  void blk_queue_chunk_sectors(struct request_queue *q, unsigned int chunk_sectors)
>  {
> -	BUG_ON(!is_power_of_2(chunk_sectors));
>  	q->limits.chunk_sectors = chunk_sectors;
>  }

This breaks blk_max_size_offset() if the value isn't a power of 2,
but I wouldn't want to replace its cheap mask with an expensive divide
operation anyway. Please keep the power-of-2 requirement.
