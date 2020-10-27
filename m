Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20AA929C905
	for <lists+linux-block@lfdr.de>; Tue, 27 Oct 2020 20:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830113AbgJ0Td2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 27 Oct 2020 15:33:28 -0400
Received: from casper.infradead.org ([90.155.50.34]:54352 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503729AbgJ0Td2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Oct 2020 15:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NHrVLbQzcjLB5YvgSgRq84nEm1neW7IrzYRWtYbr+/k=; b=jbOEIj7qccjOQH9puOolryZhp8
        VALZx9iDIJCgZ7WtbyKAQdQ4gUyWdImWbRr2ANmggjQEl3+OWUejIx+D0sGE/LIfKrQJIOBUu53p1
        aJpFQM7gOqN9QK9lzbq6dfjhXcKGEnZYwQVcLFtmUrJL7Iqq30hosGSO5trcCVkaowDLmqR501SO1
        BLwhDUxe31kimlgCmx4AshFMwTERgdWEjJZ74nYMX9Ws6+g4yqjLgUxomxjQ7A1Yp4a5cpVQ9jiIU
        OiT7FXwAnnaJouoeXeED3uehkBdgH0mf66r5Ow+YKLWSs5PIEMi3Se56N4N6U117Z8hQ/vxz3V/Fc
        DgHQu12w==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXUik-0006ul-1H; Tue, 27 Oct 2020 19:33:26 +0000
Date:   Tue, 27 Oct 2020 19:33:25 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, hch@infradead.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [RFC] blk-mq: don't plug for HIPRI IO
Message-ID: <20201027193325.GA26382@infradead.org>
References: <20201027132951.121812-1-xiaoguang.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027132951.121812-1-xiaoguang.wang@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 27, 2020 at 09:29:51PM +0800, Xiaoguang Wang wrote:
> Commit cb700eb3faa4 ("block: don't plug for aio/O_DIRECT HIPRI IO")
> only does not call blk_start_plug() or blk_finish_plug for HIPRI IO
> in __blkdev_direct_IO(), but if upper layer subsystem, such as io_uring,
> still initializes valid plug, block layer may still plug HIPRI IO.
> To disable plug for HIPRI IO completely, do it in blk_mq_plug().

This creates a somewhat awkward layering.  Why can't io_uring just
stop creating a plug?
