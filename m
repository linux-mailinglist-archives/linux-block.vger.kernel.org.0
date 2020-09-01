Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9D225879D
	for <lists+linux-block@lfdr.de>; Tue,  1 Sep 2020 07:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgIAFmh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 1 Sep 2020 01:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgIAFmh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 01:42:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E20C0612A3
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 22:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ku6UMuuofkJhT3YpOFMWwMJg9eV0QSnx7TKG3dNeWAo=; b=k/Ioabkmr872f5I0TGNsvZh6YX
        c/c9pMps21tTBejArH1PL56anERvbNo/XnAuPOcFIiPZaP8lsqQFO8zWpXgmVHiB2g7p47XobeAS+
        B5oD1GFYP1y0v+jZQf4CGaDsqK3u0ZAHJkTolO3k9k9wToDrmrvZpxVupRwoXZVGn+rIhp7GuZUlk
        7laMw9xlzmdINHL75RjMpmnk3ZWG34vURjt8JPMqrQYQapmyuOrZTv92sbVa1eIZCJlnkHGOKN63j
        um3rJmyBrwi/ZjM+pq4JkLTCXvhYS+mGKlZUotQg4/xkJwIJZNUXgm8b9wW8zjMsMyfDOoCmjAb3t
        n+x6a24Q==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCz3z-0007oX-6S; Tue, 01 Sep 2020 05:42:35 +0000
Date:   Tue, 1 Sep 2020 06:42:35 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: fix -EAGAIN IOPOLL task/vm accounting
Message-ID: <20200901054235.GA29886@infradead.org>
References: <d27ff6f0-9347-e880-fa9d-514e993014dc@kernel.dk>
 <20200830062624.GA8972@infradead.org>
 <9681be4b-298d-7fcd-ed72-9599e08a26a9@kernel.dk>
 <20200830152800.GA16467@infradead.org>
 <ebdb0929-782c-fb66-e3e9-86c077e3b710@kernel.dk>
 <20200831141237.GA13231@infradead.org>
 <57807438-3ba0-e320-b6a5-0ad3f46d8335@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57807438-3ba0-e320-b6a5-0ad3f46d8335@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 31, 2020 at 08:18:48AM -0600, Jens Axboe wrote:
> > We'll still need a flag with the above to skip the submit_bio_noacct
> > bios.  But I think it is the right way to go.  Eventually we'll also
> > need to push the accounting down into the individual bio based drivers.
> 
> For the iocb propagation, we'd really need the caller to mark the iocb
> as IOCB_ACCOUNTED (or whatever) if BIO_ACCOUNTED is set, since we can't
> do that further down the stack as we really don't know if we hit -EAGAIN
> before or after the bio was accounted... Which kind of sucks, as it'll
> be hard to contain in a generic fashion.

Well, that's why I think the only proper fix is to only account a bio
when we know the driver is actually going to submit it.
