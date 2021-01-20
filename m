Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4C62FCF51
	for <lists+linux-block@lfdr.de>; Wed, 20 Jan 2021 13:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbhATLVR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 20 Jan 2021 06:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbhATJxz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jan 2021 04:53:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64C4C061757;
        Wed, 20 Jan 2021 01:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ytv3jlM2gtrtMmK49VOFEvPBux15eNFiIG9QQ6uVD3o=; b=c7eim7S0XAjLMt4J+qFylnclaF
        KxEqLR2V6TmGsucQKlXs4NTW4pfmFKlHPGfKh8Dy6CW/2HS7u8gnEZJ/y/++TV3fi4bhH1gKI6w8X
        WL6tA7MDL3OeuUCF9fEB00aAK/mMc1JNoTWoUtd1Xxm9GJc3e6udTVH0SeFb0B0Y6c1UASzqiFtYJ
        oTCfAkJuziGQz8qS7O7qXR4pvLEltyz/ttVQj670CXyN+NadXFuKJiufLZesTB9adXv+Rmay5NwID
        TFb9AVDiODR0sIyQ/43tDCzWcWDhBFalYn7KC5iADEfXIHTCTP+9/CeidNdv32j17SsfI+vr1+5kX
        s9BpkAsg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2AAC-00FV5E-5K; Wed, 20 Jan 2021 09:52:36 +0000
Date:   Wed, 20 Jan 2021 09:52:32 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Pan Bian <bianpan2016@163.com>
Cc:     FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] bsg: free the request before return error code
Message-ID: <20210120095232.GA3694085@infradead.org>
References: <20210119123311.108137-1-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119123311.108137-1-bianpan2016@163.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 19, 2021 at 04:33:11AM -0800, Pan Bian wrote:
> Free the request rq before returning error code.
> 
> Fixes: 972248e9111e ("scsi: bsg-lib: handle bidi requests without block layer help")
> Signed-off-by: Pan Bian <bianpan2016@163.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
