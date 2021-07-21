Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A253D1262
	for <lists+linux-block@lfdr.de>; Wed, 21 Jul 2021 17:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239823AbhGUOsC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 21 Jul 2021 10:48:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239877AbhGUOsB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jul 2021 10:48:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D12B261244;
        Wed, 21 Jul 2021 15:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626881317;
        bh=0jHZ4pWPf2qe1qukuDDIoLNdB7hVDGb4pQKb98+3PgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mqcvh0jOpA98PbI4dAQj/v6HU9DlMfG6bW6pBS1uWDEwYw1/ZEW+bBVRfRFoB/PYf
         2Y35YsFxe3wEGnIauRZS3HE9GZk9I5Q8+XdOLn5B+UlO+wakz0Y4umxzCIsX+wjL3r
         0hmxHtubZLl6nLWr023YLutV+EdqRjD6tPYtGf4aOvpqGJfZiwLfigkJ1TDDgi0Z7G
         iyclsPlQE1gKly31m2qYthT2bETf3nfsTaIZMYVQ8fS3WZKjWow8RWn/BnxOt8ax1i
         7ALnJiFFwewPidhh1+/v1VkoGIhkL4dSqUFZuOnkbXbDV8hQU+Ft2EjQoF6zr7MQb5
         PrjRgdTlB5EBg==
Date:   Wed, 21 Jul 2021 08:28:37 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 16/17] iomap: Convert iomap_add_to_ioend to take a
 folio
Message-ID: <20210721152837.GB8572@magnolia>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-17-willy@infradead.org>
 <20210721001219.GR22357@magnolia>
 <YPeiRb8o+zh29Pag@infradead.org>
 <YPejFDYKUn6qtLo5@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPejFDYKUn6qtLo5@casper.infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 21, 2021 at 05:31:16AM +0100, Matthew Wilcox wrote:
> On Wed, Jul 21, 2021 at 05:27:49AM +0100, Christoph Hellwig wrote:
> > On Tue, Jul 20, 2021 at 05:12:19PM -0700, Darrick J. Wong wrote:
> > > I /am/ beginning to wonder, though -- seeing as Christoph and Matthew
> > > both have very large patchsets changing things in fs/iomap/, how would
> > > you like those landed?  Christoph's iterator refactoring looks like it
> > > could be ready to go for 5.15.  Matthew's folio series looks like a
> > > mostly straightforward conversion for iomap, except that it has 91
> > > patches as a hard dependency.
> > > 
> > > Since most of the iomap changes for 5.15 aren't directly related to
> > > folios, I think I prefer iomap-for-next to be based directly off -rcX
> > > like usual, though I don't know where that leaves the iomap folio
> > > conversion.  I suppose one could add them to a branch that itself is a
> > > result of the folio and iomap branches, or leave them off for 5.16?
> > 
> > Maybe willy has a different opinion, but I thought the plan was to have
> > the based folio enablement in 5.15, and then do things like the iomap
> > conversion in the the next merge window.  If we have everything ready
> > this window we could still add a branch that builds on top of both
> > the iomap and folio trees, though.
> 
> Yes, my plan was to have the iomap conversion and the second half of the
> page cache work hit 5.16.  If we're ready earlier, that's great!  Both
> you and I want to see both the folio work and the iomap_iter work
> get merged, so I don't anticipate any lack of will to get the work done.

Ok, good.  I'll await a non-RFC version of the iterator rework for 5.15,
and folio conversions for 5.16.

--D
