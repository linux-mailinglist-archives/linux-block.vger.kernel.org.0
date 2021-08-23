Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EC13F4600
	for <lists+linux-block@lfdr.de>; Mon, 23 Aug 2021 09:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbhHWHvB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 23 Aug 2021 03:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbhHWHvB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 03:51:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C24C061575;
        Mon, 23 Aug 2021 00:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=o93Kz0vZ37phewT/U+LlT8+bGn
        2pyzA1O0pFwntOdXA6y2ccD1Gxxe4Vl4O9NvWNo0o0+BJyNaQbEuh3AXUxVRAqeo2K1bBZTPJKmD1
        IznkpZokexifwKeWKzR5Qqj8/96W0DzHLJCQ9yf5Y5cP6KlCOicJh0mS/g+5tH0uCKqu2XTfpg9ir
        A/q79uxcyhrwoWCwZWjosM67TA34iNd56JEyeM+Z1gKNjxuxuVp4hs2Ztln/I19cz0ajGnshCbhKy
        Pvf45XKC03IXxqSZ+MXYqMiF41EXffpNpNaZI2k8aQgIZOLpp/LLXigSS5sKexzuu9l+AlucxpHny
        LxtL8+vA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mI4hb-009RSK-IJ; Mon, 23 Aug 2021 07:49:16 +0000
Date:   Mon, 23 Aug 2021 08:49:03 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     axboe@kernel.dk, song@kernel.org, hch@infradead.org,
        linux-raid@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH V3] raid1: ensure write behind bio has less than
 BIO_MAX_VECS sectors
Message-ID: <YSNS74AGlLAs4llX@infradead.org>
References: <20210823074513.3208278-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823074513.3208278-1-guoqing.jiang@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
