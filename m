Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A420B2FF1EC
	for <lists+linux-block@lfdr.de>; Thu, 21 Jan 2021 18:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388442AbhAUR2G (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 21 Jan 2021 12:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388555AbhAUROE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 12:14:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEA8C061756;
        Thu, 21 Jan 2021 09:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=56fTSLlenokr2qrPGGCCY26K1j6V9io10qQxiBbgx9Q=; b=dF2QBYK8IPtI4OE93MVwt3QbAN
        sfFU+FZzhpaVLI82sY8Bz0IgVEZp6NBsyJ1d22baeFAGaec74ydvxHvprrQbZ/ekgrh4nYS2ceLkw
        4lM1alu6W58YyoFiuVacrpgVgJXyJoY/GqUF4YZrXSLQjxyUKm2WN/DyZfKX/q3ABmaVr5B0X9/Gm
        f62dvn5mRGqa7Mm2WPUW0O+RLIy1gNsq1BKe6DUyK6SQLEmrLhu/4MILSGfrLBnKH+ihbkwx+RBvp
        bGx70ZuaTbdV55XWTledNiRrFnCndD9pgYWKs1aA1CjOYBV2dCkOAHHJbnA/sXjiicho3NNPopKHx
        tTteneqQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2dW3-00HInu-72; Thu, 21 Jan 2021 17:13:07 +0000
Date:   Thu, 21 Jan 2021 17:13:03 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 3/7] block: respect blk_crypto_bio_sectors_alignment() in
 bounce.c
Message-ID: <20210121171303.GB4122715@infradead.org>
References: <20210114154723.2495814-1-satyat@google.com>
 <20210114154723.2495814-4-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114154723.2495814-4-satyat@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 14, 2021 at 03:47:19PM +0000, Satya Tangirala wrote:
> Make __blk_queue_bounce respect blk_crypto_bio_sectors_alignment()
> when calling bio_split().

bounce.c is legacy code that no new driver should use and which we
need to phase out ASAP.  It should be entirely exclusive vs use of a
modern feature like inline crypto.
