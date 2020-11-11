Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD2E2AEAE7
	for <lists+linux-block@lfdr.de>; Wed, 11 Nov 2020 09:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgKKIPe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 11 Nov 2020 03:15:34 -0500
Received: from verein.lst.de ([213.95.11.211]:39174 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgKKIPe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 03:15:34 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B736B6736F; Wed, 11 Nov 2020 09:15:30 +0100 (CET)
Date:   Wed, 11 Nov 2020 09:15:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Keith Busch <kbusch@kernel.org>, javier@javigon.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, axboe@kernel.dk, joshi.k@samsung.com,
        k.jensen@samsung.com, Niklas.Cassel@wdc.com,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V3] nvme: enable ro namespace for ZNS without append
Message-ID: <20201111081530.GB23062@lst.de>
References: <20201110210708.5912-1-javier@samsung.com> <20201110220941.GA2225168@dhcp-10-100-145-180.wdc.com> <87931ded-b17b-90b2-c5b2-a1a465d109cc@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87931ded-b17b-90b2-c5b2-a1a465d109cc@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 10, 2020 at 05:41:15PM -0800, Sagi Grimberg wrote:
>
>>> -	if (id->nsattr & NVME_NS_ATTR_RO)
>>> +	if (id->nsattr & NVME_NS_ATTR_RO || test_bit(NVME_NS_FORCE_RO, &ns->flags))
>>>   		set_disk_ro(disk, true);
>>
>> If the FORCE_RO flag is set, the disk is set to read-only. If that flag
>> is later cleared, nothing clears the disk's read-only setting.
>
> Yea, that is true also for the non-force case, but before it broke
> BLKROSET so I reverted that. We can use this FORCE_RO for BLKROSET as
> well I think...

Let me prioritize the hard r/o setting.  mkp actually has an older patch
that did just that which I'll resurrect.
