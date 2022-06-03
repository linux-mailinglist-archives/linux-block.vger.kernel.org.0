Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8856053CA8D
	for <lists+linux-block@lfdr.de>; Fri,  3 Jun 2022 15:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiFCNUH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 3 Jun 2022 09:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiFCNUA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 09:20:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B7A24580
        for <linux-block@vger.kernel.org>; Fri,  3 Jun 2022 06:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rexwQzSOpHEZCoXJ+OTb8vKOgVj834dHpEvQm1wvWjU=; b=07YPmXOp1RFqGJ9PcXcdBfFIbs
        cdKjD1kL0OLcdwQlU3IvugPa+atz+XK5gIpYuWAURcoifC3cGOY7V1tacqtRFE4zRia2zWdI42tRD
        m7GHNxq0kH5NA2Gxzy8b2VJS+RRB1+qWrCGFOIkoMXfAVaW2gSMW48bZHamwWIJ1C+A8eDBNpghwH
        vt3PPU0U5TRIh/K/T3+mWf1zDcILdgxyXUPJJ3x+Z3GZpDPELs+0lRB4wbB9m4H01NYuvECj07O5Y
        G29FboaH5fgmtp3SXtRs1jUpFTgOEkQvmbwJGEbt4UYprjqQDWQVzj2y5yjHsA9/0aWIa06hZEk6/
        T+BqMVIQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nx7DS-007XPa-Dq; Fri, 03 Jun 2022 13:19:50 +0000
Date:   Fri, 3 Jun 2022 06:19:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, david@fromorbit.com
Subject: Re: bioset_exit poison from dm_destroy
Message-ID: <YpoKduMz1o8SrhFn@infradead.org>
References: <YpK7m+14A+pZKs5k@casper.infradead.org>
 <2523e5b0-d89c-552e-40a6-6d414418749d@kernel.dk>
 <YpZlOCMept7wFjOw@redhat.com>
 <YpcBgY9MMgumEjTL@infradead.org>
 <Ypd0DnmjvCoWj+1P@redhat.com>
 <Yphw2n3ERoFsWgEe@infradead.org>
 <YpoH8uYWf38QkAJU@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpoH8uYWf38QkAJU@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 03, 2022 at 09:09:06AM -0400, Mike Snitzer wrote:
> I think the point was to keep the biosets embedded in struct
> mapped_device to avoid any possible cacheline bouncing due to the
> bioset memory being disjoint.

Probably.

> But preserving that micro-optimization isn't something I've ever
> quantified (at least not with focus).

But we can either avoid the pointer or do the preallocation.  Doing both
doesn't really work.  OTOH given that we've surived quite a while without
the preallocation actually working I wonder if it actually is needed.

> Looks fine, did you want to send an official patch with a proper
> header and Signed-off-by?

I plan to send a series with a few follow on after testing it a bit
more.

