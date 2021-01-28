Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEC2307843
	for <lists+linux-block@lfdr.de>; Thu, 28 Jan 2021 15:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhA1OiM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 28 Jan 2021 09:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhA1OiJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 09:38:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E59EC061756
        for <linux-block@vger.kernel.org>; Thu, 28 Jan 2021 06:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I/HIhJ738fkxN1xrE7fOWGMvEJCgbzI6i9HlfCIztVk=; b=lJs48Y1SqUV2ATbwXwZCUyOT55
        1qFIz02Tbea0WGC3THKBIHlWcMUTR1GW8wEFUjWeWVmHcFHfSf3i/7NWIg/Q4fw26ozosbtTqvOko
        EpTAALIPmqQbcGR+Q4aYTCzys9RWYX6TTfHT0U25MJrCnPv6Y/fztrkgmdLjcuRNJUiUBQzDuAewA
        GUkPd97ERuVh8xwgo1HToDNXQlfRneYbhyqI+p/BuZWmkuNszDTjCFgR4LAnBvMKHOUb/0WEHg6aH
        Dx6kUTQ8/akpM2Z5DFhtyLaWNwR5r85YMUZxcjBBIxF9/iaMzPjY1X1sn0ATZNLFU5Z7+mJy3/e8X
        HsBll16w==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l58QF-008ZeE-Nd; Thu, 28 Jan 2021 14:37:25 +0000
Date:   Thu, 28 Jan 2021 14:37:23 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: fix bd_size_lock use
Message-ID: <20210128143723.GB2043450@infradead.org>
References: <20210128063619.570177-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128063619.570177-1-damien.lemoal@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 28, 2021 at 03:36:19PM +0900, Damien Le Moal wrote:
> Some block device drivers, e.g. the skd driver, call set_capacity() with
> IRQ disabled. This results in lockdep ito complain about inconsistent
> lock states ("inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage")
> because set_capacity takes a block device bd_size_lock using the
> functions spin_lock() and spin_unlock(). Ensure a consistent locking
> state by replacing these calls with spin_lock_irqsave() and
> spin_lock_irqrestore(). The same applies to bdev_set_nr_sectors().
> With this fix, all lockdep complaints are resolved.

I'd much rather fix the driver to not call set_capacity with irqs
disabled..
