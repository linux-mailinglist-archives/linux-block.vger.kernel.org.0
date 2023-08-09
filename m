Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471A17764BC
	for <lists+linux-block@lfdr.de>; Wed,  9 Aug 2023 18:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjHIQLM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 9 Aug 2023 12:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHIQLL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Aug 2023 12:11:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA1319E
        for <linux-block@vger.kernel.org>; Wed,  9 Aug 2023 09:11:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6E3B86732D; Wed,  9 Aug 2023 18:11:05 +0200 (CEST)
Date:   Wed, 9 Aug 2023 18:11:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Chuck Lever <cel@kernel.org>, linux-block@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH RFC] block: Revert 615939a2ae73
Message-ID: <20230809161105.GA2304@lst.de>
References: <169158653156.2034.8363987273532378512.stgit@bazille.1015granger.net> <d51b0683-8872-4e10-8589-5c6de8db61d4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d51b0683-8872-4e10-8589-5c6de8db61d4@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 09, 2023 at 09:51:18AM -0600, Jens Axboe wrote:
> > Bisected to commit 615939a2ae73 ("blk-mq: defer to the normal
> > submission path for post-flush requests"). I've tested reverting
> > that commit on several kernels from 0aa69d53ac7c ("Merge tag
> > 'for-6.5/io_uring-2023-06-23' of git://git.kernel.dk/linux") to
> > v6.5-rc5, and it seems to address the problem.
> > 
> > I also confirmed that commit 9f87fc4d72f5 ("block: queue data
> > commands from the flush state machine at the head") is still
> > necessary.
> 
> Adding the author - Christoph?

Hmm, weird.  I though we had all this sorted out a few weeks
ago when that 9f87fc4d72f5 fixed it for you?  What is different
in this round of testing?
