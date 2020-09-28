Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CA227B6C4
	for <lists+linux-block@lfdr.de>; Mon, 28 Sep 2020 22:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgI1U7g (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 28 Sep 2020 16:59:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbgI1U7g (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Sep 2020 16:59:36 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF42B2080A;
        Mon, 28 Sep 2020 20:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601326776;
        bh=ec6OoHmgvoth50UzS4i3XOLm6RLc5Pxm7GGje4jPB0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J+VdfQfMacRKngiL9dbRg51Sx3tPH8JEYO4Pf9dPr05eYVYk670xoZO7Xv8MnDkPD
         LfDgwPSL3lc5YEHvtXVPWGI2nBdsOepIHa2GmiWtHof01cupmY3XfiVMfIJLBTT9Xd
         IstUej1FacbbaPSLC++7W6Q1fdXjiEUf2b97wVpo=
Date:   Mon, 28 Sep 2020 13:59:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Satya Tangirala <satyat@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH v2 0/3] block: fix up bio_crypt_ctx allocation
Message-ID: <20200928205934.GA1340@sol.localdomain>
References: <20200916035315.34046-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916035315.34046-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 15, 2020 at 08:53:12PM -0700, Eric Biggers wrote:
> This series makes allocation of encryption contexts either able to fail,
> or explicitly require __GFP_DIRECT_RECLAIM (via WARN_ON_ONCE).
> 
> This applies to linux-block/for-next.
> 
> Changed since v1 (https://lkml.kernel.org/r/20200902051511.79821-1-ebiggers@kernel.org):
>     - Added patches 2 and 3.
>     - Added kerneldoc for bio_crypt_clone().
>     - Adjusted commit message.
> 
> Eric Biggers (3):
>   block: make bio_crypt_clone() able to fail
>   block: make blk_crypto_rq_bio_prep() able to fail
>   block: warn if !__GFP_DIRECT_RECLAIM in bio_crypt_set_ctx()

Jens, any interest in applying these patches for 5.10?

- Eric
