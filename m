Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FC16DA845
	for <lists+linux-block@lfdr.de>; Fri,  7 Apr 2023 06:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjDGEdl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 7 Apr 2023 00:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjDGEdl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Apr 2023 00:33:41 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49158A6D
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 21:33:39 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 28E3D67373; Fri,  7 Apr 2023 06:33:36 +0200 (CEST)
Date:   Fri, 7 Apr 2023 06:33:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 15/16] zram: fix synchronous reads
Message-ID: <20230407043335.GA5674@lst.de>
References: <20230406144102.149231-1-hch@lst.de> <20230406144102.149231-16-hch@lst.de> <ZC9CIsMcwCjYvbXX@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC9CIsMcwCjYvbXX@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 06, 2023 at 03:05:22PM -0700, Minchan Kim wrote:
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Acked-by: Minchan Kim <minchan@kernel.org>
> 
> So this fixes zram_rw_page + CONFIG_ZRAM_WRITEBACK feature on
> ppc some arch where PAGE_SIZE is not 4K.

Well, zram_rw_page is gone.  But either way I think CONFIG_ZRAM_WRITEBACK
has been broken on > 4k PAGE_SIZE basically since the code was added.

> IIRC, we didn't have any report since the writeback feature was
> introduced. Then, we may skip having the fix into stable?

If you want a stable fix I'd just disable CONFIG_ZRAM_WRITEBACK
for non-4k PAGE_SIZEs there.
