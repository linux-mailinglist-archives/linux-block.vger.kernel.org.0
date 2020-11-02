Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610C22A330D
	for <lists+linux-block@lfdr.de>; Mon,  2 Nov 2020 19:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbgKBSd7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 2 Nov 2020 13:33:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgKBSd7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Nov 2020 13:33:59 -0500
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C42722245;
        Mon,  2 Nov 2020 18:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604342038;
        bh=8Xk9SHcN724jkmqolETaQdwcKCNm99W5ejOMIzeeWWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NJYgRC9RyEjCoXvd6B3nVza41sccjCZ4wJnXfKQnN9jRYOVPqg9GmO3rwyH/wTNrD
         0ne2trMrwInSpSQp2N9HR4ZE3eRcXQDzJ6eYQuTuFttNt7mRSa9PNXUJhs6BP0Xgi8
         HXUSmx0v5y6SDF2Gea/bmYVc/yh5Py30v05PyShA=
Date:   Mon, 2 Nov 2020 10:33:55 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     "hch@lst.de" <hch@lst.de>
Cc:     Javier Gonzalez <javier.gonz@samsung.com>,
        "javier@javigon.com" <javier@javigon.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "Klaus B. Jensen" <k.jensen@samsung.com>,
        "Niklas.Cassel@wdc.com" <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH V2] nvme: report capacity 0 for non supported ZNS SSDs
Message-ID: <20201102183355.GB1970293@dhcp-10-100-145-180.wdc.com>
References: <CGME20201102161505eucas1p19415e34eb0b14c7eca5a2c648569cf1e@eucas1p1.samsung.com>
 <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local>
 <20201102180836.GC20182@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102180836.GC20182@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 02, 2020 at 07:08:37PM +0100, hch@lst.de wrote:
> On Mon, Nov 02, 2020 at 04:15:01PM +0000, Javier Gonzalez wrote:
> > That said, I don't mind the concept, though I recall Christoph had
> > concerns about the existing 0-capacity namespace used for invalid
> > formats, so I'd like to hear more on that if he has some spare time to
> > comment.
> 
> Yes, I really don't think 0 sized block devices are the right interface
> for namespaces we can't access.  I think the proper fix is to ensure that
> we have a character device that allows submitting I/O commands for each
> namespaces including those where we don't understand the I/O command set
> or parts of it.  That should also really help to have a proper access
> model for the KV command set.  Initially we only need NVME_IOCTL_IO64_CMD,
> but eventually we'll need some support for async submissions, be
> that through io_uring or other ways.

I can see this going one of two ways:

 a) Set up the existing controller character device with a generic
    disk-less request_queue to the IO queues accepting IO commands to
    arbitrary NSIDs.

 b) Each namespace that can't be supported gets their own character
    device.

I'm leaning toward option "a". While it doesn't create handles to unique
namespaces, it has more resilience to potentially future changes. And I
recall the target side had a potential use for that, too.
