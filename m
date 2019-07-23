Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE41A71C95
	for <lists+linux-block@lfdr.de>; Tue, 23 Jul 2019 18:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfGWQLy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 Jul 2019 12:11:54 -0400
Received: from verein.lst.de ([213.95.11.211]:42991 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfGWQLy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 12:11:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7034368B02; Tue, 23 Jul 2019 18:11:52 +0200 (CEST)
Date:   Tue, 23 Jul 2019 18:11:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@fb.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 2/4] block: force an unlimited segment size on queues
 with a virt boundary
Message-ID: <20190723161152.GA1655@lst.de>
References: <20190521070143.22631-1-hch@lst.de> <20190521070143.22631-3-hch@lst.de> <1563896932.3609.15.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563896932.3609.15.camel@HansenPartnership.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 23, 2019 at 08:48:52AM -0700, James Bottomley wrote:
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 2ae348c101a0..46a95536f3bd 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -752,7 +752,8 @@ void blk_queue_virt_boundary(struct request_queue *q, unsigned long mask)
>  	 * page (which might not be idential to the Linux PAGE_SIZE).  Because
>  	 * of that they are not limited by our notion of "segment size".
>  	 */
> -	q->limits.max_segment_size = UINT_MAX;
> +	if (mask != 0 && q->limits.max_segment_size == BLK_MAX_SEGMENT_SIZE)
> +		q->limits.max_segment_size = UINT_MAX;

The first check makes sense, defintively safer than leaving it to the
caller.  The second one is wrong - we need to force an unlimited segment
size because we can't account for it for the virt_boundary merges.  And
the comment just above explains why that is safe.
