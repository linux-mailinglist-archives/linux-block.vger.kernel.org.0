Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A358256F09
	for <lists+linux-block@lfdr.de>; Sun, 30 Aug 2020 17:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgH3P25 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 30 Aug 2020 11:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgH3P2C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Aug 2020 11:28:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F51C061573
        for <linux-block@vger.kernel.org>; Sun, 30 Aug 2020 08:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ujCIH1QDCf6Kl3DIYsT4AIzDko56AP41LZRgMDgfmWQ=; b=KUB72nVnmzSeZiEQJVuE+pypSI
        /TkkdCKSPY0duxpgD/7gVBzvcMkacVJkOohEtfFPDI6e9iK3nWX5kFEWP9Sr2lpP4re+O4lLLsAv6
        Xf55tA6rRUXNZ5nseY7oA595obRSBE8fVAiPNAkKGnmQBLyytgPBL34N07ktr2ry8nd6MDR1n/bJg
        MF8GzUcAN2hnLzmY8/8fIMe/rM69bJ/XLVkX+XuLHKYLiY3lNB+Y1vS+AK6EglgjmpVQiBPXLNx5k
        USsQchCfFT5slAyVQwx9Zxc8Cg/SlE4vNAI6Zr1/sgORVWFqQUKxd+G61j6mRigLAcgzyRaMXXI6L
        E59nuqNQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCPFQ-0005ha-Rl; Sun, 30 Aug 2020 15:28:00 +0000
Date:   Sun, 30 Aug 2020 16:28:00 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: fix -EAGAIN IOPOLL task/vm accounting
Message-ID: <20200830152800.GA16467@infradead.org>
References: <d27ff6f0-9347-e880-fa9d-514e993014dc@kernel.dk>
 <20200830062624.GA8972@infradead.org>
 <9681be4b-298d-7fcd-ed72-9599e08a26a9@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9681be4b-298d-7fcd-ed72-9599e08a26a9@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Aug 30, 2020 at 09:09:02AM -0600, Jens Axboe wrote:
> On 8/30/20 12:26 AM, Christoph Hellwig wrote:
> > On Sat, Aug 29, 2020 at 10:51:11AM -0600, Jens Axboe wrote:
> >> We currently increment the task/vm counts when we first attempt to queue a
> >> bio. But this isn't necessarily correct - if the request allocation fails
> >> with -EAGAIN, for example, and the caller retries, then we'll over-account
> >> by as many retries as are done.
> >>
> >> This can happen for polled IO, where we cannot wait for requests. Hence
> >> retries can get aggressive, if we're running out of requests. If this
> >> happens, then watching the IO rates in vmstat are incorrect as they count
> >> every issue attempt as successful and hence the stats are inflated by
> >> quite a lot potentially.
> >>
> >> Add a bio flag to know if we've done accounting or not. This prevents
> >> the same bio from being accounted potentially many times, when retried.
> > 
> > Can't the resubmitter just use submit_bio_noacct?  What is the call
> > stack here?
> 
> The resubmitter is way higher than that. You could potentially have that
> done in the block layer, but not higher up.
> 
> The use case is async submissions, going through ->read_iter() again.
> Or ->write_iter().

But how does a bio flag help there?  If we go through the file ops
again the next submission will be a new bio structure.
