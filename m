Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962983072A3
	for <lists+linux-block@lfdr.de>; Thu, 28 Jan 2021 10:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbhA1JVC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 28 Jan 2021 04:21:02 -0500
Received: from verein.lst.de ([213.95.11.211]:56588 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232476AbhA1JR4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 04:17:56 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 51C6868AFE; Thu, 28 Jan 2021 10:17:10 +0100 (CET)
Date:   Thu, 28 Jan 2021 10:17:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH v4 2/8] nvme: cleanup zone information initialization
Message-ID: <20210128091710.GA1959@lst.de>
References: <20210128044733.503606-1-damien.lemoal@wdc.com> <20210128044733.503606-3-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128044733.503606-3-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>  int nvme_revalidate_zones(struct nvme_ns *ns)
>  {
> -	struct request_queue *q = ns->queue;
> -	int ret;
> -
> -	ret = blk_revalidate_disk_zones(ns->disk, NULL);
> -	if (!ret)
> -		blk_queue_max_zone_append_sectors(q, ns->ctrl->max_zone_append);
> -	return ret;
> +	return blk_revalidate_disk_zones(ns->disk, NULL);

We can just kill off nvme_revalidate_zones now and open code it in
the caller as the stub is no needed now that blk_queue_is_zoned always
return false for the !CONFIG_BLK_DEV_ZONED case.

Otherwise this look great, nice cleanup:

Reviewed-by: Christoph Hellwig <hch@lst.de>
