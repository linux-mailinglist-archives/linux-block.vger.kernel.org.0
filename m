Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77D23198E61
	for <lists+linux-block@lfdr.de>; Tue, 31 Mar 2020 10:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbgCaI2d (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 31 Mar 2020 04:28:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49882 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729795AbgCaI2c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 04:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vy83zvshIwYMcRGB5sJfQ2PFE+Zeokh/mIR59/Lkb/s=; b=TM40hCuYqZQmKXWZMWYXsCZXuj
        ALcfkunpYta4kp7BaQ92aYVMD1cywsic/HgHRMFzWa5fq9CL0zvHwkRXJCeOsoYVns71UTFYRwVdm
        KzeBiTWd60ysQrU+A2re/7NJ42Kx6dVnsIr6G6rJzTPKLakAiLKpO6kTJagC7VzQOS7ZIlAyx3lUX
        QQsMa7kKURCyvQ8yka+sd+zB6ka+ATPWVuUzWlLms4EbeAnWvB61bHaF6rVBTXC76JVzGVB5jQz/d
        kfBUUxbJUGtmPbc/hfG4TbJryvYTx0eTdMdQduu6lwsMBlOQFItrTkgBI6IW7JJgPys+2FTsA/4UC
        z2qkyWtQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJCG8-0006K9-Li; Tue, 31 Mar 2020 08:28:32 +0000
Date:   Tue, 31 Mar 2020 01:28:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 2/2] block: null_blk: Fix zoned command handling
Message-ID: <20200331082832.GC14655@infradead.org>
References: <20200330040116.178731-1-damien.lemoal@wdc.com>
 <20200330040116.178731-3-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330040116.178731-3-damien.lemoal@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
> +				   sector_t sector, sector_t nr_sectors);
> +blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd, enum req_opf op);
> +
> +static inline blk_status_t null_process_cmd(struct nullb_cmd *cmd,
> +					    enum req_opf op, sector_t sector,
> +					    unsigned int nr_sectors)
> +{
> +	struct nullb_device *dev = cmd->nq->dev;
> +	blk_status_t ret;
> +
> +	if (dev->badblocks.shift != -1) {
> +		ret = null_handle_badblocks(cmd, sector, nr_sectors);
> +		if (ret != BLK_STS_OK)
> +			return ret;
> +	}
> +
> +	if (dev->memory_backed)
> +		return null_handle_memory_backed(cmd, op);
> +
> +	return BLK_STS_OK;

I think this should remaing non-inlined in null_blk_main.c.

> +blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd, enum req_opf op)
>  {
>  	struct nullb_device *dev = cmd->nq->dev;
>  	int err;
>  
> +	if (!dev->memory_backed)
> +		return BLK_STS_OK;

Why does this duplicate the check done in the caller?

> +	if (dev->zoned) {
> +		cmd->error = null_handle_zoned(cmd, op, sector, nr_sectors);
> +		goto out;
>  	}
>  
> +	cmd->error = null_process_cmd(cmd, op, sector, nr_sectors);

Why not:

	if (dev->zoned)
		cmd->error = null_handle_zoned(cmd, op, sector, nr_sectors);
	else
		cmd->error = null_process_cmd(cmd, op, sector, nr_sectors);

And maybe rename null_handle_zoned to null_process_zoned_cmd to keep
things symmetric.
