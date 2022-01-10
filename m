Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E599489E76
	for <lists+linux-block@lfdr.de>; Mon, 10 Jan 2022 18:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbiAJRfh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 10 Jan 2022 12:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238135AbiAJRfh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jan 2022 12:35:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED64C061748
        for <linux-block@vger.kernel.org>; Mon, 10 Jan 2022 09:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oboNtAoUWLsyeVM8PpifuWGTYIwJBQfehNw83Vmr4u4=; b=o3SuQnzYKLWCP49KiDSN7cSWhI
        oFTrYYBIWlIumONVPRJwznFC8bUwFzlJdMwQI8gFd3gYh4H7GlZ60Gdp4/zRDLG3JWRKvtXiBwJOr
        Fo7QEYGmq5SMCjc7/VWuBRlwThdzM5w6xvLBxfSV2ygqX1lA2aik/ciy57yzN/wRd+a8r9yADyNSN
        MAU5X57Jb0NVmEkbRAv9UyYl4GIsOwev6TICiM4N725sibLSYZeE/7ScqnOEwXv5pYcvSVxYCeTSZ
        FWQkfXiMOxL+RmAiLuUwKtAzpSJhLJuhzaXmViahkQgRRS0Glg3Upl++wOKjsWqRUzy6AVqLRelXq
        5Cxhys8Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6yZm-00CacX-H0; Mon, 10 Jan 2022 17:35:22 +0000
Date:   Mon, 10 Jan 2022 09:35:22 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        lining <lining2020x@163.com>, Tejun Heo <tj@kernel.org>,
        Chunguang Xu <brookxu@tencent.com>
Subject: Re: [PATCH 1/2] block: add resubmit_bio_noacct()
Message-ID: <YdxuWlZAPJkPyr3h@infradead.org>
References: <20220110075141.389532-1-ming.lei@redhat.com>
 <20220110075141.389532-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110075141.389532-2-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 10, 2022 at 03:51:40PM +0800, Ming Lei wrote:
> Add block layer API of resubmit_bio_noacct() for handling blk-throttle
> iops limit correctly. Typical use case is that bio split, and it isn't
> good to export blk_throtl_charge_bio_split() for drivers, so add new API
> for serving such purpose.

Umm, submit_bio_noacct is meant exactly for this case of resubmitting
a bio.  We should not need another API for that.
