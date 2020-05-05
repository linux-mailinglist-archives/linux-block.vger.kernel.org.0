Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4394A1C5F80
	for <lists+linux-block@lfdr.de>; Tue,  5 May 2020 20:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbgEESBT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 5 May 2020 14:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730069AbgEESBT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 May 2020 14:01:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563ACC061A0F;
        Tue,  5 May 2020 11:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DEdjlKML1R2TvFeUyu3TZMfM3z2W1qbybh/kO8XwJa0=; b=iJaqA6hbKDkz2nKamSZxrF5zmm
        FU7Kvb/wLNIjVOxrESepN4Te0u2LhOfQW2AG0jVLWeiYZAFHJGd/TNgNgEmplaw9g15MBIfN2Vrsh
        mh4dGkzy3VobdRxXP6YX3xS0+C6I856TKZmIoLGgiQOEkG8yw6r/M7hrk+pcdVurwlowZ6nc+HDru
        0Trn7IA/vMr8RHcBpbie88BD5fv6xLaAYvT2wP8RkMsYaHuTsenY6f8P7YBE7WRirJxuJNlvPzgly
        8XX5mxtWEwN6aX5kgLl8yAf6BgUZPNuoSVKBuTmHtPiKQhZUKrV8pwSNqd8qdPmtlqfOw0USqeZi+
        XR+yIQ0Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jW1sX-00012x-Mg; Tue, 05 May 2020 18:01:13 +0000
Date:   Tue, 5 May 2020 11:01:13 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     antlists <antlists@youngman.org.uk>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        dm-devel <dm-devel@redhat.com>, Song Liu <song@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] eliminate SECTOR related magic numbers and
 duplicated conversions
Message-ID: <20200505180113.GJ16070@bombadil.infradead.org>
References: <20200505115543.1660-1-thunder.leizhen@huawei.com>
 <ea522f15-991d-6f67-ba8b-9cb4954a1064@youngman.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea522f15-991d-6f67-ba8b-9cb4954a1064@youngman.org.uk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 05, 2020 at 06:32:36PM +0100, antlists wrote:
> On 05/05/2020 12:55, Zhen Lei wrote:
> > When I studied the code of mm/swap, I found "1 << (PAGE_SHIFT - 9)" appears
> > many times. So I try to clean up it.
> > 
> > 1. Replace "1 << (PAGE_SHIFT - 9)" or similar with SECTORS_PER_PAGE
> > 2. Replace "PAGE_SHIFT - 9" with SECTORS_PER_PAGE_SHIFT
> > 3. Replace "9" with SECTOR_SHIFT
> > 4. Replace "512" with SECTOR_SIZE
> 
> Naive question - what is happening about 4096-byte sectors? Do we need to
> forward-plan?

They're fully supported already, but Linux defines a sector to be 512
bytes.  So we multiply by 8 and divide by 8 a few times unnecessarily,
but it's not worth making sector size be a per-device property.

Good thought, though.
