Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3535283CAE
	for <lists+linux-block@lfdr.de>; Mon,  5 Oct 2020 18:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgJEQmc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 5 Oct 2020 12:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbgJEQmb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Oct 2020 12:42:31 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7628920774;
        Mon,  5 Oct 2020 16:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601916151;
        bh=ZXXK8oZmlnksw3p+jH6Sk0YsOmdbG+S9WAnVJNUyneg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=djKBBCDusEEV2TwKco3EPZVdo2p1HNwPuAborHJic4U2Zj0sPjex01+WZVzoN/RZV
         efZ2cbTilkLtLGyElF5ZGsfDmKi2CQ7/1y9S4+ObADyjWIOInO6oMg67+iJWnmPpiM
         O+qHCVdwDpBOyaMYAY/PyhTVHKcsuD7CHj2dWnz4=
Date:   Mon, 5 Oct 2020 09:42:29 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        dm-devel@redhat.com, Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v2 0/3] block: fix up bio_crypt_ctx allocation
Message-ID: <20201005164229.GA3128920@gmail.com>
References: <20200916035315.34046-1-ebiggers@kernel.org>
 <20200928205934.GA1340@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928205934.GA1340@sol.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 28, 2020 at 01:59:34PM -0700, Eric Biggers wrote:
> On Tue, Sep 15, 2020 at 08:53:12PM -0700, Eric Biggers wrote:
> > This series makes allocation of encryption contexts either able to fail,
> > or explicitly require __GFP_DIRECT_RECLAIM (via WARN_ON_ONCE).
> > 
> > This applies to linux-block/for-next.
> > 
> > Changed since v1 (https://lkml.kernel.org/r/20200902051511.79821-1-ebiggers@kernel.org):
> >     - Added patches 2 and 3.
> >     - Added kerneldoc for bio_crypt_clone().
> >     - Adjusted commit message.
> > 
> > Eric Biggers (3):
> >   block: make bio_crypt_clone() able to fail
> >   block: make blk_crypto_rq_bio_prep() able to fail
> >   block: warn if !__GFP_DIRECT_RECLAIM in bio_crypt_set_ctx()
> 
> Jens, any interest in applying these patches for 5.10?
> 

Ping.
