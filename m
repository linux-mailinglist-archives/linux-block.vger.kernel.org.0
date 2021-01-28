Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EEE3072B6
	for <lists+linux-block@lfdr.de>; Thu, 28 Jan 2021 10:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhA1J31 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 28 Jan 2021 04:29:27 -0500
Received: from verein.lst.de ([213.95.11.211]:56607 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232043AbhA1JUN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 04:20:13 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id AF17468AFE; Thu, 28 Jan 2021 10:19:30 +0100 (CET)
Date:   Thu, 28 Jan 2021 10:19:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH v4 5/8] block: introduce zone_write_granularity limit
Message-ID: <20210128091930.GD1959@lst.de>
References: <20210128044733.503606-1-damien.lemoal@wdc.com> <20210128044733.503606-6-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128044733.503606-6-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	t->zone_write_granularity = max(t->zone_write_granularity,
> +					b->zone_write_granularity);
>  	t->zoned = max(t->zoned, b->zoned);

Totally superficial nit:  it would read a little nicer if
zone_write_granularity is assigned after the zoned value.

Otherwise this looks perfect.

Reviewed-by: Christoph Hellwig <hch@lst.de>
