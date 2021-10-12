Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B649429D98
	for <lists+linux-block@lfdr.de>; Tue, 12 Oct 2021 08:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhJLGWw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 12 Oct 2021 02:22:52 -0400
Received: from verein.lst.de ([213.95.11.211]:40081 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231190AbhJLGWw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 02:22:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6C0EF68B05; Tue, 12 Oct 2021 08:20:49 +0200 (CEST)
Date:   Tue, 12 Oct 2021 08:20:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH] loop: don't print warnings if the underlying
 filesystem doesn't support discard
Message-ID: <20211012062049.GB17407@lst.de>
References: <alpine.LRH.2.02.2109231539520.27863@file01.intranet.prod.int.rdu2.redhat.com> <20210924155822.GA10064@lst.de> <alpine.LRH.2.02.2110040851130.30719@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2110040851130.30719@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 04, 2021 at 09:01:33AM -0400, Mikulas Patocka wrote:
> Do you want this patch?

Yes, this looks like what I want.  Minor nitpicks below:

> +	.fallocate_flags = BLKDEV_FALLOC_FL_SUPPORTED,

I'd probably call this fallocate_supported_flags.

> +	.fallocate_flags = FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE,

Please avoid over 80 lines for a plain list of flags.
