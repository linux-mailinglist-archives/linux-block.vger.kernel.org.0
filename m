Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591751D27FF
	for <lists+linux-block@lfdr.de>; Thu, 14 May 2020 08:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgENGlf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 14 May 2020 02:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726122AbgENGle (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 May 2020 02:41:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C918DC061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 23:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tdKQLFRAjhwTleO3Wg5bWVOm3KaOEoA4zqJwwED9BEg=; b=aJ39dImC9m2L3HhCmFEWWBMG7r
        e54zdTwD57lZbTZ39171YviPj3OXSisEDThQXELf8rCF0+cqKTbdW0aODrUU5CZI5O408EV0IN6R+
        i5kNtqCcJEazi79KLggIoqTmi4CFMFpttSh2rOJZOhPlxZ4o1WifpdbgBQjxFcJupVGuNAUdNe6r2
        nYnFoNWXUbbaQNsTGr4ZeKG2z6DlogmhZv8rE0L8a/kqSG+NdvHdKoVfC+lh9NCojxuKvTfq+gpy1
        zf+Gtz+HEQgkLKdxgLSptm2xS8WHhOfATkHZdaRg+zjzFiXFOyyQ+J0EyuzGXQRyKMdbIfud6dxZt
        AbgeKiFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZ7Yj-0006p2-JY; Thu, 14 May 2020 06:41:33 +0000
Date:   Wed, 13 May 2020 23:41:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH] block: fix build failure in case of !CONFIG_BLOCK
Message-ID: <20200514064133.GA5058@infradead.org>
References: <20200514014302.2078182-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514014302.2078182-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Can you please just move the function out of line?  If we context
switch it is by definition to performance critical enough to be an
inline function bloating the callers..
