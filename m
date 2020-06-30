Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A351E20ED0B
	for <lists+linux-block@lfdr.de>; Tue, 30 Jun 2020 06:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgF3Ezl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 30 Jun 2020 00:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729397AbgF3Ezk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 00:55:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA80C061755
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2020 21:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=teXV9+L5xvCEyC3601NyOp/XvmH2jTUWgtl+vcOpRLY=; b=FBkLKVeOz3911884cAzGaJuzUC
        tq8ytCwNUGpCi4IcYQY/fmNXRMvAKYIlsMAXtgKG45Io1qFY7yNFKo0HrIL1QGxENiXGLqGLguKQF
        OXfN7tj8k6d22iiFWyFaFnxvy26BYzlB/tlZ8IKn6uWRocBRG8bYxWdwWwffcvIZvd1rQ3LWkomiX
        3vPnWcV+pik/LfcpkCSNRCoPLtUhi6RJs1RnohRIyzUV8VE3DOCkMv3r2gZIpXgY6+3GZSihmkmAV
        UhAsenSga/UMfjgT4qPdpr8iCMF0ip4ajXawDJAZc7jpMJhwBByBX7wJvMR7NHPbrlZjnxlRmA5xh
        tTX6KkHw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jq8Iz-0004oM-Jh; Tue, 30 Jun 2020 04:55:37 +0000
Date:   Tue, 30 Jun 2020 05:55:37 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>
Subject: Re: [PATCH V6 6/6] blk-mq: support batching dispatch in case of io
 scheduler
Message-ID: <20200630045537.GA17653@infradead.org>
References: <20200624230349.1046821-1-ming.lei@redhat.com>
 <20200624230349.1046821-7-ming.lei@redhat.com>
 <20200629090452.GA4892@infradead.org>
 <20200629103239.GB1881343@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629103239.GB1881343@T590>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 29, 2020 at 06:32:39PM +0800, Ming Lei wrote:
> 
> > list back onto the main list here, otherwise we can lose those requests.
> 
> The dispatch list always becomes empty after blk_mq_dispatch_rq_list()
> returns, so no need to splice it back.

Oh, true - it moves everyting to the dispatch list eventually.
