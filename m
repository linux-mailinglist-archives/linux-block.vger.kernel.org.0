Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9332F2FB152
	for <lists+linux-block@lfdr.de>; Tue, 19 Jan 2021 07:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbhASGXx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 19 Jan 2021 01:23:53 -0500
Received: from verein.lst.de ([213.95.11.211]:50691 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbhASGQ0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jan 2021 01:16:26 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B5D076736F; Tue, 19 Jan 2021 07:15:36 +0100 (CET)
Date:   Tue, 19 Jan 2021 07:15:36 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V9 4/9] nvmet: add ZBD over ZNS backend support
Message-ID: <20210119061536.GB21250@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com> <20210112042623.6316-5-chaitanya.kulkarni@wdc.com> <20210112074805.GA24443@lst.de> <BL0PR04MB65145CE93F2AAF66158A3D71E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com> <20210118182515.GC11082@lst.de> <2c3a1a515bd3913f46ecf81a157e35ff56a1fb70.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c3a1a515bd3913f46ecf81a157e35ff56a1fb70.camel@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 19, 2021 at 04:28:00AM +0000, Damien Le Moal wrote:
> What about something like this below to add to Chaitanya series ?
> This adds the queue limit zone_write_granularity which is set to the physical
> block size for scsi, and for NVMe/ZNS too since that value is limited to the
> atomic block size. Lightly tested with both 512e and 4kn SMR drives.

For ZNS it should just be the logic block size, the atomic size is not
the right thing use here.

> +	if (blk_queue_is_zoned(q)) {
> +		if (limits->zone_write_granularity < limits-
> >logical_block_size)

Overly long line here, and your mailer wrapped it as a punishment :)

That being said I don't think the normal path to set the block size
should affect it.  Just add the manual call and leave the non-zoned
path alone.

> +EXPORT_SYMBOL(blk_queue_zone_write_granularity);

EXPORT_SYMBOL_GPL for all zoned stuff.
