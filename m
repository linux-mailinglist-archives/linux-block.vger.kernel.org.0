Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 401F5AE386
	for <lists+linux-block@lfdr.de>; Tue, 10 Sep 2019 08:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbfIJGNx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 10 Sep 2019 02:13:53 -0400
Received: from verein.lst.de ([213.95.11.211]:56516 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729301AbfIJGNw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Sep 2019 02:13:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E7A4868B02; Tue, 10 Sep 2019 08:13:48 +0200 (CEST)
Date:   Tue, 10 Sep 2019 08:13:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jon Hunter <jonathanh@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 1/3] block: Respect the device's maximum segment size
Message-ID: <20190910061348.GA30982@lst.de>
References: <20190909125658.30559-1-thierry.reding@gmail.com> <20190909125658.30559-2-thierry.reding@gmail.com> <20190909161331.GA19650@lst.de> <20190909191911.GC23804@mithrandir> <TYAPR01MB454470364B682B9BF708E557D8B60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAPR01MB454470364B682B9BF708E557D8B60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 10, 2019 at 02:03:17AM +0000, Yoshihiro Shimoda wrote:
> I'm sorry for causing this trouble on your environment. I have a proposal to
> resolve this issue. The mmc_host struct will have a new caps2 flag
> like MMC_CAP2_MERGE_CAPABLE and add a condition into the queue.c like below.
> 
> +	if (host->caps2 & MMC_CAP2_MERGE_CAPABLE &&
> +	    host->max_segs < MMC_DMA_MAP_MERGE_SEGMENTS &&
> 	    dma_get_merge_boundary(mmc_dev(host)))
> 		host->can_dma_map_merge = 1;
> 	else
> 		host->can_dma_map_merge = 0;
> 
> After that, all mmc controllers disable the feature as default, and if a mmc
> controller has such capable, the host driver should set the flag.

That sounds sensible to me.  Alternatively we'd have to limit
max_sectors to 16-bit values for sdhci if using an iommu that can
merge.
