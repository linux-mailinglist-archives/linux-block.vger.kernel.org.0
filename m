Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0AB6128E3
	for <lists+linux-block@lfdr.de>; Sun, 30 Oct 2022 08:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJ3Hug (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 30 Oct 2022 03:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ3Hug (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 03:50:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C680119
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 00:50:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1167068AA6; Sun, 30 Oct 2022 08:50:33 +0100 (CET)
Date:   Sun, 30 Oct 2022 08:50:32 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
Subject: Re: [bug?] blk_queue_may_bounce() has the comparison max_low_pfn
 and max_pfn wrong way
Message-ID: <20221030075032.GC4214@lst.de>
References: <Y1wZTtENDq3fvs6n@ZenIV> <01ce222b-8ad6-b4b3-428a-bae9534795e7@kernel.dk> <Y1wr0g39GzHcAk9v@ZenIV> <Y11YuS3kiOWoOjuI@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y11YuS3kiOWoOjuI@ZenIV>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 29, 2022 at 05:45:45PM +0100, Al Viro wrote:
> completion (in NULL_Q_BIO case, at least).  What happens if request
> gets split and split-off part finishes first with an error?  AFAICS,
> its ->bi_status will be copied to parent (original bio, the one that
> covers the tail).  Now the IO on the original bio is over as well
> and we hit drivers/block/null_blk/main.c:end_cmd().  Suppose this
> part succeeds; won't we end up overwriting ->bi_status with zero
> and assuming that the entire thing had succeeded, despite the
> (now lost) error on the split-off part?

As a rule of thumb drives should never set bi_status to 0, so null_blk
here has a bug.  What is missing everywhere is proper memory barriers,
though.
