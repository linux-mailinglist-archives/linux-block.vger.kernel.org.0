Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2464A25A4F8
	for <lists+linux-block@lfdr.de>; Wed,  2 Sep 2020 07:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgIBFWs (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 2 Sep 2020 01:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgIBFWr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Sep 2020 01:22:47 -0400
Received: from sol.localdomain (ip-99-203-42-15.pools.spcsdns.net [99.203.42.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0CA6207DE;
        Wed,  2 Sep 2020 05:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599024167;
        bh=JJKHJkRpz5eKVERVhR4zQ6Eas6o1cq/9/J34GT56Fqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A17oZHeIy21xMqGO3QQ4fvcFLKgGBBOwH3BSfU5U9Rpcg3olgTK6IkPnHGG5hBs6K
         seRxozOR50jMVJ4GVC+aMz7Xgwv6CA0ffRj48F1iOiG39+KWS1A1eJkg4LHWOPIeLO
         7ibo2ig52HIkpwAszEq/uh6L4xOTf7OoFskqEI/U=
Date:   Tue, 1 Sep 2020 22:22:44 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "satyat@google.com" <satyat@google.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: Fix potential NULL pointer dereference in
 __bio_crypt_clone()
Message-ID: <20200902052244.GA54052@sol.localdomain>
References: <1a8ac4099d274d2b994a417c034fa3c6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a8ac4099d274d2b994a417c034fa3c6@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 02, 2020 at 01:56:53AM +0000, linmiaohe wrote:
> Eric Biggers <ebiggers@kernel.org> wrote:
> >On Tue, Sep 01, 2020 at 07:59:21AM -0400, Miaohe Lin wrote:
> >> mempool_alloc() may return NULL if __GFP_DIRECT_RECLAIM is not set in 
> >> gfp_mask under memory pressure. So we should check the return value of
> >> mempool_alloc() against NULL before dereference.
> >> 
> >> Fixes: a892c8d52c02 ("block: Inline encryption support for blk-mq")
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >
> >It's intended that __GFP_DIRECT_RECLAIM always be set here.
> >Do you have an example where it isn't set here?
> 
> map_request() only pass GFP_ATOMIC to gfp_mask, though bio crypt is not used yet.
> 
> >Also, if this can indeed happen, then we need to make __bio_crypt_clone() (and bio_crypt_clone()) return a bool (or an error code) to indicate whether it succeeded or failed.  We can't just ignore the allocation failure.
> >
> >- Eric
> 
> IMO, just the allocation failure is ok or we would break KABI.
> Many thanks.
> 

Ignoring the allocation failure isn't okay, since it would cause encrypted I/O
to fall back to unencrypted I/O, which would cause data corruption.

Also, upstream doesn't have a stable KABI.

I sent out a patch with what I have in mind; can you take a look?
https://lkml.kernel.org/r/20200902051511.79821-1-ebiggers@kernel.org

- Eric
