Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682B330727C
	for <lists+linux-block@lfdr.de>; Thu, 28 Jan 2021 10:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhA1JVG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 28 Jan 2021 04:21:06 -0500
Received: from verein.lst.de ([213.95.11.211]:56594 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232480AbhA1JSK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 04:18:10 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 480C468B02; Thu, 28 Jan 2021 10:17:27 +0100 (CET)
Date:   Thu, 28 Jan 2021 10:17:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH v4 3/8] nullb: use blk_queue_set_zoned() to setup zoned
 devices
Message-ID: <20210128091727.GB1959@lst.de>
References: <20210128044733.503606-1-damien.lemoal@wdc.com> <20210128044733.503606-4-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128044733.503606-4-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 28, 2021 at 01:47:28PM +0900, Damien Le Moal wrote:
> Use blk_queue_set_zoned() to set a nullb device zone model instead of
> directly assigning the device queue zoned limit. This initialization of
> the devicve zoned model as well as the setup of the queue flag
> QUEUE_FLAG_ZONE_RESETALL and of the device queue elevator feature are
> moved from null_init_zoned_dev() to null_register_zoned_dev() so that
> the initialization of the queue limits is done when the gendisk of the
> nullb device is available.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
