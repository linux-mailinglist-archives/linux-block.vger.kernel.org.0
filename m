Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2A3520E9E
	for <lists+linux-block@lfdr.de>; Tue, 10 May 2022 09:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbiEJHiz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 10 May 2022 03:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240996AbiEJH0n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 May 2022 03:26:43 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B680532D3;
        Tue, 10 May 2022 00:22:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C5A6D68AFE; Tue, 10 May 2022 09:22:43 +0200 (CEST)
Date:   Tue, 10 May 2022 09:22:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     tytso <tytso@mit.edu>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-spdx@vger.kernel.org
Subject: Re: SPDX tag and top of file comment cleanups for the loop driver
Message-ID: <20220510072243.GB11929@lst.de>
References: <20220419063303.583106-1-hch@lst.de> <YnGLRAuS8QGaSADK@mit.edu> <20220503201334.GA7325@lst.de> <YnGgP7ubsXxFTaZE@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnGgP7ubsXxFTaZE@mit.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,

are the comments from Ted here enough to apply the series?  Or do
we need a formal Acked-by to be on the safe side?

On Tue, May 03, 2022 at 02:35:59PM -0700, tytso wrote:
> On Tue, May 03, 2022 at 10:13:34PM +0200, Christoph Hellwig wrote:
> > On Tue, May 03, 2022 at 04:06:28PM -0400, Theodore Ts'o wrote:
> > > > Ted, does the SPDX tag match your original licensing decision back then,
> > > > or do we need to correct it?  Does the auto-converted tag on the loop.h
> > > > SPDX header (GPL1.0 or later with syscall exception) make sense, or
> > > > should that have been GPL2 only with syscall exception?
> > > 
> > > I think you've removed the loop.h in the patch series, so it shouldn't
> > > matter what the tag would be for loop.h, right?  In any case, GPLv2
> > > only was certainly the intent at the time.
> > 
> > Well, there were two loop.h files - drivers/block/loop.h gets removed
> > in this series, but include/uapi/linux/loop.h stays.
> 
> Ah, thanks for the clarification.  Yes, GPLv2 with the syscall
> extension is what would be appropriate for include/uapi/linux/loop.h.
> 
> 	     	  	   	       - Ted
---end quoted text---
