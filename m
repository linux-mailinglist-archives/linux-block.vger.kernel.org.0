Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C3F43E4DF
	for <lists+linux-block@lfdr.de>; Thu, 28 Oct 2021 17:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhJ1PUJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 28 Oct 2021 11:20:09 -0400
Received: from verein.lst.de ([213.95.11.211]:42402 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230258AbhJ1PUG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Oct 2021 11:20:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AE17368BEB; Thu, 28 Oct 2021 17:17:37 +0200 (CEST)
Date:   Thu, 28 Oct 2021 17:17:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Alexander V. Buev" <a.buev@yadro.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mikhail Malygin <m.malygin@yadro.com>, linux@yadro.com
Subject: Re: [PATCH 3/3] block: fops: handle IOCB_USE_PI in direct IO
Message-ID: <20211028151737.GB9468@lst.de>
References: <20211028112406.101314-1-a.buev@yadro.com> <20211028112406.101314-4-a.buev@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028112406.101314-4-a.buev@yadro.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +		struct blk_integrity *bi = blk_get_integrity(bdev->bd_disk);
> +		unsigned int intervals;
> +
> +		/* Last iovec contains protection information. */
> +		if (!iter->nr_segs)
> +			return -EINVAL;
> +
> +		iter->nr_segs--;
> +		pi_iov = (struct iovec *)(iter->iov + iter->nr_segs);

Please don't poke into the iov_iter abstractions.  This will break
with PI in anything but ITER_IOVEC buffers.
