Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3711C1D257C
	for <lists+linux-block@lfdr.de>; Thu, 14 May 2020 05:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgENDkl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 May 2020 23:40:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgENDkk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 23:40:40 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74650206BE;
        Thu, 14 May 2020 03:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589427640;
        bh=jtC8xve7kToz69NkCwP2e5hx3uLsfMlMo9DWGsQOp/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gq7FU1UyQ+ga8KTEbnoK/WvRGFNtUVkn948hy7hZ2Ap4Q9uyXbF8OKlkAnoZV2qjk
         0e+NjuI25q70UmPzjPgILo0oKduogJVjN6pEUhdJ8if1xqiYXZjRnZWK7sdoOkX+eO
         jhjTKEgXPOPgUKkXNEgZodbtHO8VlCdXznYwyIlw=
Date:   Thu, 14 May 2020 12:40:33 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] nvme: Fix io_opt limit setting
Message-ID: <20200514034033.GB1833@redsun51.ssa.fujisawa.hgst.com>
References: <20200514015452.1055278-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514015452.1055278-1-damien.lemoal@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 14, 2020 at 10:54:52AM +0900, Damien Le Moal wrote:
> Currently, a namespace io_opt queue limit is set by default to the
> physical sector size of the namespace and to the the write optimal
> size (NOWS) when the namespace reports this value. This causes problems
> with block limits stacking in blk_stack_limits() when a namespace block
> device is combined with an HDD which generally do not report any optimal
> transfer size (io_opt limit is 0). The code:
> 
> /* Optimal I/O a multiple of the physical block size? */
> if (t->io_opt & (t->physical_block_size - 1)) {
> 	t->io_opt = 0;
> 	t->misaligned = 1;
> 	ret = -1;
> }
> 
> results in blk_stack_limits() to return an error when the combined
> devices have different but compatible physical sector sizes (e.g. 512B
> sector SSD with 4KB sector disks).
> 
> Fix this by not setting the optiomal IO size limit if the namespace does
> not report an optimal write size value.

Won't this continue to break if a controller does report NOWS that's not
a multiple of the physical block size of the device it's stacking with?
