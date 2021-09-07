Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4E9402319
	for <lists+linux-block@lfdr.de>; Tue,  7 Sep 2021 07:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhIGFnM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 7 Sep 2021 01:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhIGFnM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 01:43:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE5FC061575;
        Mon,  6 Sep 2021 22:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zPF74JJlYZKHggNQ/frWkxkCUayfP92i3Lm4EYmo0Hw=; b=oHjZ65qY1HMBSYNnrqtVNv/kWD
        qpIlRO37sBt0Fgn8OZDnx0XrKYwcbikpxX3ZZhQNj5ixDxSD9IIOFdnQU6xebbn1O8F42GF0S4X3t
        787WjPuAD33XyIBHoJJn+u3UGmdZ16kBBQVzctINdAVIpSbZ25cJw94gBmP4QuEr8390XjKssqopm
        YNx88xeLrSuBVDcqC0lJr1CoWUZ3iy+VoRLYxknS96Y23zx0mjLZWIMIctjhXMZe3WIMs/xicqv6e
        ztG+z1ef1qA/XRPt7VT9gE9BSuJKMY2/Bn0sp0h2ebgBHj/NokhDVFZ1+id46ZS97xXH2TwEMceAw
        PX1IWmNA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNTrD-007ZNn-L9; Tue, 07 Sep 2021 05:41:23 +0000
Date:   Tue, 7 Sep 2021 06:41:19 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     axboe@kernel.dk, hch@infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] cdrom: add linux-block list to uniform CD-ROM entry in
 MAINTAINERS file
Message-ID: <YTb7f+P/HzeAJDek@infradead.org>
References: <20210906215745.1992-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210906215745.1992-1-phil@philpotter.co.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 06, 2021 at 10:57:45PM +0100, Phillip Potter wrote:
> Add linux-block mailing list line to the uniform CD-ROM entry in the
> MAINTAINERS file, as this will help submitted patches to be seen on a
> list that is more focused without the level of traffic of the overall
> lkml list.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
