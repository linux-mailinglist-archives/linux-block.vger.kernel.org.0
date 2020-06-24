Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6691E20714B
	for <lists+linux-block@lfdr.de>; Wed, 24 Jun 2020 12:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390436AbgFXKfQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 24 Jun 2020 06:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388005AbgFXKfQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 06:35:16 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0312C061573
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2020 03:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hmMx5oAdyU3XpisZiOSUcmXKwPPs7U3IHVk0V8KEsDg=; b=EdoYEGo3MLFoZn+qjircnqS12G
        PNm8O9p1KL6/1yG0kNePyluorvi2Yin7qLtTNP1pJekJFC3LNBwfPE3HcXtL+ySeA1gXEdb2fQhPu
        sdEJsRxE7AoQ7AKlZrL7AF071WBzmX+dtVZrCa/ZFdBV7N5j781B7BVnNp8/J4z1N8jFIGk4/uSgJ
        2FSF6G7gJlEDBUbjRRLGaTOs7U5UBdHGbWH7VPEvirFA4kdpd0CKe4RDxeft/4B3yt1jUB18nBv2+
        HsmWpRFxV7iYtg3cK2d67iPESHHOhXsqGVKMXK3vc7QUNC+2sWCVO4if1Ki12IcozN8vxxadQM4lo
        ACSIzgiw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo2k4-0006Ll-Gd; Wed, 24 Jun 2020 10:34:56 +0000
Date:   Wed, 24 Jun 2020 11:34:56 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     axboe@kernel.dk, hch@infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] block: release bip in a right way in error path
Message-ID: <20200624103456.GA24340@infradead.org>
References: <20200624102139.5048-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624102139.5048-1-cgxu519@mykernel.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 24, 2020 at 06:21:39PM +0800, Chengguang Xu wrote:
> Release bip using kfree() in error path when that was allocated
> by kmalloc().
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
