Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3C07079F7
	for <lists+linux-block@lfdr.de>; Thu, 18 May 2023 07:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjERF5o (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 18 May 2023 01:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjERF5n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 01:57:43 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050651719
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 22:57:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C1E0D68D0F; Thu, 18 May 2023 07:57:38 +0200 (CEST)
Date:   Thu, 18 May 2023 07:57:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: RFC: less special casing for flush requests
Message-ID: <20230518055738.GA20450@lst.de>
References: <20230416200930.29542-1-hch@lst.de> <2dca2b99-612e-97f7-32de-9713ac1891f4@acm.org> <20230516040351.GB5624@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516040351.GB5624@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 16, 2023 at 06:03:51AM +0200, Christoph Hellwig wrote:
> On Mon, May 15, 2023 at 05:08:27PM -0700, Bart Van Assche wrote:
> > Do you have the time to continue the work on this patch series? Please let 
> > me know in case you would prefer that I continue the work on this patch 
> > series. I just found and fixed a bug in my patch "block: Send FUA requests 
> > to the I/O scheduler" (not included in this series).
> 
> I did another pass last weekend and was planning to finish it off today.

Turns out this all interacts with the scheduler tags vs passthrough
dicussion we had, but I now have a version of the series rebased on top
of that:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-flush

I will send it out once we've settled the tags discussion.
