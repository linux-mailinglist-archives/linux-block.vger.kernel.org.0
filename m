Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5A22AEAD2
	for <lists+linux-block@lfdr.de>; Wed, 11 Nov 2020 09:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgKKIGJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 11 Nov 2020 03:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgKKIGJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 03:06:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B24FC0613D1
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2020 00:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tq7pxXzmToZ5e2HiU8aZDPFp+C26CNSRGbm3FKPaHpQ=; b=v3hnwKx6U9y5vMfS5t5VhvKbDB
        qc08pLcb57X48SquBBXwRVtuYMTod0UeJKBO8puzjATS01EIiW7/FNZVtKISLWwh6pKkDDpXWnxiP
        iUPoKgWkNeUe9oNTVwqmmSmOPsXNnB5i8siNSJeI90jUgC2rxsutbOC9jNqY6CWGuQ+5PIB0lFZtj
        pAVolRGUvGAGZyIu7kwcVAbAFoFcIOHuDHscYddBLS5Q1FZtv/BnoZX+Dl5bTi3ENqhIFw6faPwXJ
        FFsDyJltCdklvi5Pd2gYovAJ69ofPGiUGXk81bD5Sq2r2UMRR6WE2qje/3JOcPnXbxrRYaJjvqT0d
        23SjQI/A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcl8p-0006Cl-VN; Wed, 11 Nov 2020 08:06:08 +0000
Date:   Wed, 11 Nov 2020 08:06:07 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 2/9] null_blk: Fail zone append to conventional zones
Message-ID: <20201111080607.GB23360@infradead.org>
References: <20201111051648.635300-1-damien.lemoal@wdc.com>
 <20201111051648.635300-3-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111051648.635300-3-damien.lemoal@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 11, 2020 at 02:16:41PM +0900, Damien Le Moal wrote:
> Conventional zones do not have a write pointer and so cannot accept zone
> append writes. Make sure to fail any zone append write command issued to
> a conventional zone.
> 
> Reported-by: Naohiro Aota <naohiro.aota@wdc.com>
> Fixes: e0489ed5daeb ("null_blk: Support REQ_OP_ZONE_APPEND")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
