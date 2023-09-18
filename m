Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BFB7A5200
	for <lists+linux-block@lfdr.de>; Mon, 18 Sep 2023 20:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjIRSZL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 18 Sep 2023 14:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjIRSZK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Sep 2023 14:25:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2E4112;
        Mon, 18 Sep 2023 11:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TC8wfBk+ib87P7TgIQGCMrwtRUP58vsgw9dhZZ19d68=; b=hC17YkoDr54/vXu9pLxNScC1tR
        58CYaFjKwojnqasqeKRlYiiyhGN4QyLMZXo7pvNF53AngJGnujARir/IibZbgbOBHea1gQYCq/Adb
        bY5llp7euvOgmQscF8JZZw9iTzNILN3n52VgSdhzDId6M8HxQP0WtxdNDKMDmvtwQXhWX0X9/EnRZ
        9Z6DFZm9ZT5/K0IK4Ws+5L/W2vrIs5ZY9T68/cVRDQHoxPATR3IoWSXl/ui2SpfPnqwTCmj9haQmR
        RirTOGJJ0Z7SauWIWNgcAPcK3Hu/mpvfOupj/ssb6jbVGh4m3ZRjt0hZ4omWsTPNe4GOm9Y3x16Ps
        SNP1t+ig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiIvX-00CXHT-W9; Mon, 18 Sep 2023 18:24:56 +0000
Date:   Mon, 18 Sep 2023 19:24:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Daniel Gomez <da.gomez@samsung.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/6] filemap: make the folio order calculation shareable
Message-ID: <ZQiV96mTMiSXF9yf@casper.infradead.org>
References: <20230915095042.1320180-1-da.gomez@samsung.com>
 <CGME20230915095124eucas1p1eb0e0ef883f6316cf14c349404a51150@eucas1p1.samsung.com>
 <20230915095042.1320180-2-da.gomez@samsung.com>
 <ZQRet4w5VSbvKvKB@casper.infradead.org>
 <ZQiSPEKRJSkeh3Fe@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQiSPEKRJSkeh3Fe@bombadil.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 18, 2023 at 11:09:00AM -0700, Luis Chamberlain wrote:
> On Fri, Sep 15, 2023 at 02:40:07PM +0100, Matthew Wilcox wrote:
> > On Fri, Sep 15, 2023 at 09:51:23AM +0000, Daniel Gomez wrote:
> > > To make the code that clamps the folio order in the __filemap_get_folio
> > > routine reusable to others, move and merge it to the fgf_set_order
> > > new subroutine (mapping_size_order), so when mapping the size at a
> > > given index, the order calculated is already valid and ready to be
> > > used when order is retrieved from fgp_flags with FGF_GET_ORDER.
> > > 
> > > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > > ---
> > >  fs/iomap/buffered-io.c  |  6 ++++--
> > >  include/linux/pagemap.h | 42 ++++++++++++++++++++++++++++++++++++-----
> > >  mm/filemap.c            |  8 --------
> > >  3 files changed, 41 insertions(+), 15 deletions(-)
> > 
> > That seems like a lot of extra code to add in order to avoid copying
> > six lines of code and one comment into the shmem code.
> > 
> > It's not wrong, but it seems like a bad tradeoff to me.
> 
> The suggestion to merge came from me, mostly based on later observations
> that in the future we may want to extend this with a min order to ensure
> the index is aligned the the order. This check would only be useful for
> buffred IO for iomap, readahead. It has me wondering if buffer-heads
> support for large order folios come around would we a similar check
> there?
> 
> So Willy, you would know better if and when a shared piece of code would
> be best with all these things in mind.

In my mind, this is fundamentally code which belongs in the page cache
rather than in individual filesystems.  The fly in the ointment is that
shmem has forked the page cache in order to do its own slightly
specialised thing.  I don't see the buffer_head connection; shmem is
an extremely special case, and we shouldn't mess around with other
filesystems to avoid changing shmem.

Ideally, we'd reunify (parts of) shmem and the regular page cache, but
that's a lot of work, probably involving the swap layer changing.
