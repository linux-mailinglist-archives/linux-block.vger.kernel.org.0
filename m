Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC24E2AD4
	for <lists+linux-block@lfdr.de>; Thu, 24 Oct 2019 09:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437884AbfJXHNi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 24 Oct 2019 03:13:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39426 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437880AbfJXHNh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 03:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1EZbQoJEyYJJNiPOgD6K2QEw5hJaFSH+XHF4j1LJr9c=; b=jxJmlZb5V8+J3Apncvu/f/H6B
        iwnbxRwiiIQDN7y0dbtaEcmwWFLcNRlyuuR0z427rcFiSnlJysfn41u7d9WgyNFla0P+rpqJktVba
        HSORmVS4INcfQxphZ0VfAZgjQQVWlsXTjjhfEbLN3QHIbjjy1+I35XsukJWH9W0I1oOTi0DpAgZVu
        QpYgWldmXoEnv8cp1GjPcvPDyKQmzfvgOca2qwABwtSD+ROPiOGyx/bpkBOBmXUf/J3EZMgVYM5tX
        YL8SLDrY2stIqJtOqv90FcSlQ/DYRkzwllD4KtdhxAlnsAZlXmFqTMuQG7no1cLpq0JqS6QCysaEp
        fpretXdkg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNXJR-0001xI-DA; Thu, 24 Oct 2019 07:13:37 +0000
Date:   Thu, 24 Oct 2019 00:13:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 4/4] block: Generically handle report zones buffer
Message-ID: <20191024071337.GC19572@infradead.org>
References: <20191024065006.8684-1-damien.lemoal@wdc.com>
 <20191024065006.8684-5-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024065006.8684-5-damien.lemoal@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 24, 2019 at 03:50:06PM +0900, Damien Le Moal wrote:
> Instead of relying on a zoned block device driver to allocate a buffer
> for every execution of a report zones command execution, rely on the
> block layer use of the device zone report queue limits to allocate a
> buffer and keep it around when the device report_zones method is
> executed in a loop, e.g.  as in blk_revalidate_disk_zones().
> 
> This simplifies the code in the scsi sd_zbc driver as well as simplify
> the addition of zone supports for upcoming new zoned device drivers.

I wonder if we could just do away with the separate buffer entirely.
As the SCSI zone size (and also ATA even if we don't directly talk
to that) are intentionally the same size as the blk_zone (and the
same true is for the only upcoming standard I know of) we can just
rewrite each entry in-place(-ish) by reusing the same allocation.
Depending on the detailed formate we have to copy a field our two
onto the stack first, but it both avoids the extra allocation, and
the whole queue limits infrastructure in the previous patch and
should simply the code a lot.
