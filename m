Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17CF1FA9E8
	for <lists+linux-block@lfdr.de>; Tue, 16 Jun 2020 09:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgFPHaC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 16 Jun 2020 03:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgFPHaC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 03:30:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E689C05BD43
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2020 00:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hRLjeXbeNz86qwreVK3h2qFmY9Q9Ni6dZ5nLmd1OMuM=; b=mX7KVS76k+LeNkfNMXE2F/jKKE
        1EoMutiNBzoYUo0bpUxEklRYY9PF+S9FdcKjeAA4BpeSsVEF9gUMwIkfKeITHWSDhuPTDK0Tp2pN2
        /Ifci+UYf9KLgJNe8yLl3HgjE9PwnIycGYqVQdSbbifTTihqXozjDX9POAAy9r55iPXu2ZLnLSPga
        /ekr2BpvT9QF8qPZi3L4q5hYgz4L17/+OW2LiVGm8nxnPj23aNoeOtLzbO9TKqF0rYou2QS1rdn2r
        dIwqNwVWNugCk8vYneZEZzPghSEkwVtZnPCQq9Y/DiSsR0AifAAPxXJYMyMMzXo/mO/f4w1rBsmEa
        vqNLZ/bA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jl62d-00083Q-Fh; Tue, 16 Jun 2020 07:29:55 +0000
Date:   Tue, 16 Jun 2020 00:29:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-block@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] block: add split_alignment for request queue
Message-ID: <20200616072955.GA30385@infradead.org>
References: <20200616005633.172804-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616005633.172804-1-harshadshirwadkar@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 15, 2020 at 05:56:33PM -0700, Harshad Shirwadkar wrote:
> This feature allows the user to control the alignment at which request
> queue is allowed to split bios. Google CloudSQL's 16k user space
> application expects that direct io writes aligned at 16k boundary in
> the user-space are not split by kernel at non-16k boundaries.

That is a completely bogus assumptions and people who think they can
make that assumption should not be allowed to write software.

Can we stop this crap now please?
