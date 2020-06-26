Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B3820B54C
	for <lists+linux-block@lfdr.de>; Fri, 26 Jun 2020 17:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbgFZPw2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 26 Jun 2020 11:52:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728355AbgFZPw1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 11:52:27 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D43D20702;
        Fri, 26 Jun 2020 15:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593186748;
        bh=tCnKt2gRQ2rQ2Ov2BBHApIbR6TvAVURZvumLSwQZKWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tHJ4y1+R7Q1sW6c7bebGE90/JtBY775nTAWRP1sUg44HApyj20r35y1mnBeDnWEFj
         EVvZB/vUmhyCY4NUT1MpoF9EsdLTSbZ7Pb51w2DbI1VmCmkZy9/nRD75ScesaxXwCd
         GM9LJ8mujLnn7IpiVsMkc3gjI9qovXoDlcYcrMsk=
Date:   Fri, 26 Jun 2020 08:52:25 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 4/6] block: introduce IOCTL to report dev properties
Message-ID: <20200626155225.GA1774486@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-5-javier@javigon.com>
 <6333b2f1-a4f1-166f-5e0d-03f47389458a@lightnvm.io>
 <20200625194248.44rwwestffgz4jks@MacBook-Pro.localdomain>
 <20200625202534.GA28784@redsun51.ssa.fujisawa.hgst.com>
 <20200626062828.cmt3ccowzifxn42g@mpHalley.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200626062828.cmt3ccowzifxn42g@mpHalley.localdomain>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 26, 2020 at 08:28:28AM +0200, Javier González wrote:
> On 26.06.2020 05:25, Keith Busch wrote:
> > On Thu, Jun 25, 2020 at 09:42:48PM +0200, Javier González wrote:
> > > We can use nvme passthru, but this bypasses the zoned block abstraction.
> > > Why not representing ZNS features in the standard zoned block API?
> > 
> > This looks too nvme zns specific to want the block layer in the middle.
> > Just use the driver's passthrough interface.
> 
> Ok. Is it OK with you to expose them in sysfs as Damien suggested?

sysfs sounds fine to me for some attributes (ex: mar/mor), but I don't
think every zns property warrants exposing through this interface. I
just don't want to corner driver maintenance into chasing every spec
field. If applications really want every last detail, they can get it
directly from the device without any kernel dependencies.
