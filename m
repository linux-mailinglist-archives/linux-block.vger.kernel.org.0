Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CA430619B
	for <lists+linux-block@lfdr.de>; Wed, 27 Jan 2021 18:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhA0RL0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 27 Jan 2021 12:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbhA0RKF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 12:10:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AB5C061756
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 09:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h0v1Tx9cI/lmIloEVpWKlesNS9gJ2TamXcqRw8fFK4w=; b=EHjrg7n5CaKGXWuwf2kUad3J5F
        cSxinHpO4ZOa75OOevnd2Oc8Tj2dzVD7eAX4zn0t8bsF2CYgFloZim/wn3EueN3NL/V0nWYtY4Kob
        ud88pJGptnTlmnESrJRwos/zlLwOzbukM1HmOz4aaRtwWqeGsF9/NglE2cUK5EintdTtvlYCiVGOI
        dkNrMLY4eeYaFFDpppuy45zSgdmKqogac9Mq68O3iBWaPl7OLr5EbXiwSMtTGSdwvV52TffxxJN1K
        TJCGqgkOzs/OANXiNHyzQ9XPQD13NZt1Z/B5SHPGPipXDLcPIdvkAkPrXqd2U1ns+0lHKeC9FeTjH
        IvrZ4Wjw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l4oJe-007Gjk-5a; Wed, 27 Jan 2021 17:09:16 +0000
Date:   Wed, 27 Jan 2021 17:09:14 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com
Subject: Re: [PATCH 4/4] block: call blk_additional_{latency,sector} only
 when io_extra_stats is true
Message-ID: <20210127170914.GA1732537@infradead.org>
References: <20210127145930.8826-1-guoqing.jiang@cloud.ionos.com>
 <20210127145930.8826-5-guoqing.jiang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127145930.8826-5-guoqing.jiang@cloud.ionos.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 27, 2021 at 03:59:30PM +0100, Guoqing Jiang wrote:
> +		if (blk_queue_io_extra_stat(req->q))
> +			blk_additional_sector(req->part, sgrp, bytes >> SECTOR_SHIFT);

This is completely unreadable due to the long line.
