Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D852FA8BD
	for <lists+linux-block@lfdr.de>; Mon, 18 Jan 2021 19:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393196AbhARS00 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 18 Jan 2021 13:26:26 -0500
Received: from verein.lst.de ([213.95.11.211]:49154 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407597AbhARSZ5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jan 2021 13:25:57 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A2DE96736F; Mon, 18 Jan 2021 19:25:15 +0100 (CET)
Date:   Mon, 18 Jan 2021 19:25:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V9 4/9] nvmet: add ZBD over ZNS backend support
Message-ID: <20210118182515.GC11082@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com> <20210112042623.6316-5-chaitanya.kulkarni@wdc.com> <20210112074805.GA24443@lst.de> <BL0PR04MB65145CE93F2AAF66158A3D71E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BL0PR04MB65145CE93F2AAF66158A3D71E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 12, 2021 at 07:52:27AM +0000, Damien Le Moal wrote:
> > 
> > I do not understand the logic here, given that NVMe does not have
> > conventional zones.
> 
> 512e SAS & SATA SMR drives (512B logical, 4K physical) are a big thing, and for
> these, all writes in sequential zones must be 4K aligned. So I suggested to
> Chaitanya to simply use the physical block size as the LBA size for the target
> to avoid weird IO errors that would not make sense in ZNS/NVMe world (e.g. 512B
> aligned write requests failing).

But in NVMe the physical block size exposes the atomic write unit, which
could be way too large.  Іf we want to do this cleanly we need to expose
a minimum sequential zone write alignment value in the block layer.
