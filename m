Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063832AD2B7
	for <lists+linux-block@lfdr.de>; Tue, 10 Nov 2020 10:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgKJJn6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 10 Nov 2020 04:43:58 -0500
Received: from verein.lst.de ([213.95.11.211]:35335 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730505AbgKJJn6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Nov 2020 04:43:58 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 022DE6736F; Tue, 10 Nov 2020 10:43:55 +0100 (CET)
Date:   Tue, 10 Nov 2020 10:43:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
        joshi.k@samsung.com, k.jensen@samsung.com, Niklas.Cassel@wdc.com,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V2] nvme: enable ro namespace for ZNS without append
Message-ID: <20201110094354.GB25672@lst.de>
References: <20201110093938.25386-1-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110093938.25386-1-javier.gonz@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -	if (id->nsattr & NVME_NS_ATTR_RO)
> +	if (id->nsattr & NVME_NS_ATTR_RO ||
> +			test_bit(NVME_NS_FORCE_RO, &ns->flags))
>  		set_disk_ro(disk, true);
>  	else
>  		set_disk_ro(disk, false);

This has a very minor conflict with the patch from Sagi to remove the
else side of the clause.  I'll merge your patch and will fix unless
someone else objects to the approach.

Note that as discussed we really need a hard read-only settings
instead of set_disk_ro for both NVME_NS_ATTR_RO and the zns with missing
features case, but I'll look into that once I've got a few other things
off my plate.
