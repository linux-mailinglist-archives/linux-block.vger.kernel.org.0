Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C7E3AE395
	for <lists+linux-block@lfdr.de>; Mon, 21 Jun 2021 08:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhFUHBV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 21 Jun 2021 03:01:21 -0400
Received: from verein.lst.de ([213.95.11.211]:40759 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhFUHBU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 03:01:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4AC9068BEB; Mon, 21 Jun 2021 08:59:04 +0200 (CEST)
Date:   Mon, 21 Jun 2021 08:59:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc: switch to blk_mq_alloc_disk
Message-ID: <20210621065904.GA6198@lst.de>
References: <20210616053934.880951-1-hch@lst.de> <20210616053934.880951-3-hch@lst.de> <CGME20210621062208eucas1p2949c830b948c3cf7b3d636c5c5746753@eucas1p2.samsung.com> <1c5b5018-f7ca-609b-b607-827cedc161e6@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c5b5018-f7ca-609b-b607-827cedc161e6@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 21, 2021 at 08:22:07AM +0200, Marek Szyprowski wrote:
> Hi
> 
> On 16.06.2021 07:39, Christoph Hellwig wrote:
> > Use the blk_mq_alloc_disk to allocate the request_queue and gendisk
> > together.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> This patch landed recently in linux-next as commit 281ea6a5bfdc ("mmc: 
> switch to blk_mq_alloc_disk"). It triggers the following warning during 
> boot on all my systems with MMC devices:

Please try this, I lost this hunk in the final cleanup, sorry:

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index e7f89cbf9232..9890a1532cb0 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2331,6 +2331,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	md->queue.blkdata = md;
 
 	md->disk->major	= MMC_BLOCK_MAJOR;
+	md->disk->minors = perdev_minors;
 	md->disk->first_minor = devidx * perdev_minors;
 	md->disk->fops = &mmc_bdops;
 	md->disk->private_data = md;
