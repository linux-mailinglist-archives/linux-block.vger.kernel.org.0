Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 164C41345A1
	for <lists+linux-block@lfdr.de>; Wed,  8 Jan 2020 16:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgAHPEu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 8 Jan 2020 10:04:50 -0500
Received: from verein.lst.de ([213.95.11.211]:49690 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgAHPEt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 8 Jan 2020 10:04:49 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 27CE368BFE; Wed,  8 Jan 2020 16:04:48 +0100 (CET)
Date:   Wed, 8 Jan 2020 16:04:47 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     "Singh, Balbir" <sblbir@amazon.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "Sangaraju, Someswarudu" <ssomesh@amazon.com>
Subject: Re: [resend v1 4/5] drivers/nvme/host/core.c: Convert to use
 disk_set_capacity
Message-ID: <20200108150447.GC10975@lst.de>
References: <20200102075315.22652-1-sblbir@amazon.com> <20200102075315.22652-5-sblbir@amazon.com> <BYAPR04MB57490FFCC025A88F4D97D40A86220@BYAPR04MB5749.namprd04.prod.outlook.com> <1b88bedc6d5435fa7154f3356fa3f1a3e6888ded.camel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b88bedc6d5435fa7154f3356fa3f1a3e6888ded.camel@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 06, 2020 at 12:46:26AM +0000, Singh, Balbir wrote:
> On Sat, 2020-01-04 at 22:27 +0000, Chaitanya Kulkarni wrote:
> > Quick question here if user executes nvme ns-rescan /dev/nvme1
> > will following code result in triggering uevent(s) for
> > the namespace(s( for which there is no change in the size ?
> > 
> > If so is that an expected behavior ?
> > 
> 
> My old code had a check to see if old_capacity != new_capacity as well.
> I can redo those bits if needed.
> 
> The expected behaviour is not clear, but the functionality is not broken, user
> space should be able to deal with a resize event where the previous capacity
> == new capacity IMHO.

I think it makes sense to not bother with a notification unless there
is an actual change.
