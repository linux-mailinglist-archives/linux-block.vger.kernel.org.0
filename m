Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810411BD5F7
	for <lists+linux-block@lfdr.de>; Wed, 29 Apr 2020 09:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgD2HZo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 Apr 2020 03:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgD2HZn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 03:25:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9E0C03C1AD
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2020 00:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s3Gkbexn9ukcHBTi54dA+1PNWfx7iWpcY9JwowGPDbQ=; b=Tiy9vDXmQAKKlACtRvikocu5ai
        wxaSbIm7yrCyPmv3B0xsAMbZSYZP8z6dkWt/QdjYMZAfb53oDP7yjBOK5acXhcFK0JnMIRGcLZ6jd
        dSZskfk/v6+Ot+w8rYcB4XVHQmSfIIXsFWDsNgHaErrVPTC3psc9BGazaOmrStTk1FaG3DzF98oen
        eoJFpRc5s8N1sX4dr6VbD232UvxcKM34YIvfpucr8LHHBTz3Fpfyv/lFFWvI+3cdlEI7LJ4rkYe59
        gdYqVKIZ5La718B0CGRqC/Y3mK77TnUYLRIYwQCC2KHNpOIvYygT8/Hq19ga36F6/ldYmHiR4cX/c
        FCOtKCzg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTh6E-0000kU-C0; Wed, 29 Apr 2020 07:25:42 +0000
Date:   Wed, 29 Apr 2020 00:25:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 3/3] block: open-code blkg_path in it's sole caller
Message-ID: <20200429072542.GC11410@infradead.org>
References: <20200428164434.1517-1-johannes.thumshirn@wdc.com>
 <20200428164434.1517-4-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428164434.1517-4-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 29, 2020 at 01:44:34AM +0900, Johannes Thumshirn wrote:
> blkg_path() is a trivial one-line helper that only has a single caller,
> bfq_bic_update_cgroup().
> 
> Remove blkg_path() and open-code it in bfq_bic_update_cgroup().
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
