Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72899307290
	for <lists+linux-block@lfdr.de>; Thu, 28 Jan 2021 10:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhA1JYB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 28 Jan 2021 04:24:01 -0500
Received: from verein.lst.de ([213.95.11.211]:56624 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231766AbhA1JVv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 04:21:51 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D5BE468B05; Thu, 28 Jan 2021 10:21:08 +0100 (CET)
Date:   Thu, 28 Jan 2021 10:21:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH v4 7/8] block: introduce blk_queue_clear_zone_settings()
Message-ID: <20210128092107.GE1959@lst.de>
References: <20210128044733.503606-1-damien.lemoal@wdc.com> <20210128044733.503606-8-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128044733.503606-8-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 28, 2021 at 01:47:32PM +0900, Damien Le Moal wrote:
> Introduce the internal function blk_queue_clear_zone_settings() to
> cleanup all limits and resources related to zoned block devices. This
> new function is called from blk_queue_set_zoned() when a disk zoned
> model is set to BLK_ZONED_NONE. This particular case can happens when a
> partition is created on a host-aware scsi disk.

Shouldn't we just do all this work when blk_queue_set_zoned is called
with a BLK_ZONED_NONE argument?  That seems like the more obvious API
to me.
