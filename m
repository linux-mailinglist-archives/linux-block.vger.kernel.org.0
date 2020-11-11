Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3873B2AEAD1
	for <lists+linux-block@lfdr.de>; Wed, 11 Nov 2020 09:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgKKIF4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 11 Nov 2020 03:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgKKIF4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 03:05:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D66C0613D1
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2020 00:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=j1VAhHZFoiy/V7XvDoEwlwJcDO
        6IXutpRI7TosgjGzZJ8N7VdPdLrGsn4+0PYjVgPrgZgQ2q5R/l4SyN0WUCz9d17m1bf+a3Y1ZQy8O
        997Qu0pCJrctfqRkYARlfumceejsxm35IW1pLWaePuNcaAIxQDL39KWFZV7F0FbGhX0+G/Ys+U5VD
        TVhbCJ6Ktv/P4FYmuo+jUsRZufpsU580tlYgAzaYqUstamGJ4kO8f2vDJnu7ui2+FAhSHx5W0R7u0
        +4lk5IynzicW9zulFqohryW5Bod85fkH9RE8+LMNQg5xL6NGE+ENzizKiV6SCtTBM2Od4TDG5vqcC
        TLSMasrg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcl8c-0006C3-BJ; Wed, 11 Nov 2020 08:05:54 +0000
Date:   Wed, 11 Nov 2020 08:05:54 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 1/9] null_blk: Fix zone size initialization
Message-ID: <20201111080554.GA23360@infradead.org>
References: <20201111051648.635300-1-damien.lemoal@wdc.com>
 <20201111051648.635300-2-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111051648.635300-2-damien.lemoal@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
