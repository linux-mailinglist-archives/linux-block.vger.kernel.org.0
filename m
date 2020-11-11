Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF78C2AEAD4
	for <lists+linux-block@lfdr.de>; Wed, 11 Nov 2020 09:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgKKIG7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 11 Nov 2020 03:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgKKIG6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 03:06:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A654C0613D1
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2020 00:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3lsheu4a2HCCrpRLDdD41EksgxKq2JNLQmBjHBVhmfY=; b=oNXOq9Mg+N+CUpERXFYydVGrQw
        U62trFqX9ul7krn8BPzzJcpDgwuxx8a+91Kr1QA5bANKkoYWeqLPGSJH6EVEoGpFCVXszx4vfkcMK
        jEEa1M5KsGtmbnrc4p3g4wJwqcO3Wu5HbVZyd6y/rySyvLYHfPB5Rjz1Zmv180+xRzDgNLbiliojV
        3hmZMyNT60ejDOMs55OM63tRlGF1d8k5Jwucre0I2ZuBS19D/nyMVDgX8NyQCNusFgp1VZQcm0y9+
        rpuwrCsJh3TMX3WC8+omOYCMGNqfLs5Nh6ptyCZBfbmxLNohGdXAqIWdHl3Uzv+zjfoEVK8ZpEP59
        wQHRQuug==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcl9d-0006FW-9Y; Wed, 11 Nov 2020 08:06:57 +0000
Date:   Wed, 11 Nov 2020 08:06:57 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 3/9] null_blk: Align max_hw_sectors to blocksize
Message-ID: <20201111080657.GC23360@infradead.org>
References: <20201111051648.635300-1-damien.lemoal@wdc.com>
 <20201111051648.635300-4-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111051648.635300-4-damien.lemoal@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 11, 2020 at 02:16:42PM +0900, Damien Le Moal wrote:
> null_blk always uses the default BLK_SAFE_MAX_SECTORS value for the
> max_hw_sectors and max_sectors queue limits resulting in a maximum
> request size of 127 sectors. When the blocksize setting is larger than
> the default 512B, this maximum request size is not aligned to the
> block size. To emulate a real device more accurately, fix this by
> setting the max_hw_sectors and max_sectors queue limits to a value
> that is aligned to the block size.

Shouldn't we fix this in the block layer instead of individual drivers?
