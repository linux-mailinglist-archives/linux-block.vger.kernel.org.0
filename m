Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78899307874
	for <lists+linux-block@lfdr.de>; Thu, 28 Jan 2021 15:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhA1Ooi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 28 Jan 2021 09:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbhA1OoL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 09:44:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55550C061573
        for <linux-block@vger.kernel.org>; Thu, 28 Jan 2021 06:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pdZmqhJMb4qe8FoLwmPtlkXwD12Q3DS9d3aFJF4id7Y=; b=ZpOaQuRg6SrKXbFg7wL/OqruF0
        2EByAkZVNck/0oCoOCMAMCtkp5heIifDz9svKrwmoGtqethS29bDCcIya6DyenvA7MxNRMGs5m9d2
        e/nxvwOLRLM4YFLEpeH2iTNjekrLctCqzHo94dvmfUzLMmocdQOH1gG2am4worhnOD1QW/06xZPoR
        io+Gv88+/kH264271hLcZhQ0qCZEBHG0eUWFHp8TVgSDrWUSSJkeDkM6wZZIFRDH8/uOn/mNNT3VE
        C1L6l3ih8ZjH+0fJjB99HogLMtsqqOxyKfu/pEAdMay+pgU3KyTwsrxRAEbaqmILR9laJR0ehOqF4
        REK8G0qQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l58W1-008a2B-Qu; Thu, 28 Jan 2021 14:43:23 +0000
Date:   Thu, 28 Jan 2021 14:43:21 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix bd_size_lock use
Message-ID: <20210128144321.GA2045081@infradead.org>
References: <20210128063619.570177-1-damien.lemoal@wdc.com>
 <20210128143723.GB2043450@infradead.org>
 <9fbbeb94-64ee-6a80-05ce-c919de390376@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fbbeb94-64ee-6a80-05ce-c919de390376@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 28, 2021 at 07:39:21AM -0700, Jens Axboe wrote:
> On 1/28/21 7:37 AM, Christoph Hellwig wrote:
> > On Thu, Jan 28, 2021 at 03:36:19PM +0900, Damien Le Moal wrote:
> >> Some block device drivers, e.g. the skd driver, call set_capacity() with
> >> IRQ disabled. This results in lockdep ito complain about inconsistent
> >> lock states ("inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage")
> >> because set_capacity takes a block device bd_size_lock using the
> >> functions spin_lock() and spin_unlock(). Ensure a consistent locking
> >> state by replacing these calls with spin_lock_irqsave() and
> >> spin_lock_irqrestore(). The same applies to bdev_set_nr_sectors().
> >> With this fix, all lockdep complaints are resolved.
> > 
> > I'd much rather fix the driver to not call set_capacity with irqs
> > disabled..
> 
> Agree, but that might be a bit beyond 5.10 at this point..

True.
