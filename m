Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08F73EF103
	for <lists+linux-block@lfdr.de>; Tue,  5 Nov 2019 00:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbfKDXE0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 Nov 2019 18:04:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:41600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729653AbfKDXEZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Nov 2019 18:04:25 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32C0620869;
        Mon,  4 Nov 2019 23:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572908665;
        bh=bF8DbuyUHDNHS2Pk17BaB1S7DEPdVzs15qpaTN2jgrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eBnwR7iyOwHgGOkQY9qT0HtGih5Jn2mwviCx75el5gI9P0nh9gKVKYdGVB1nLj5Yc
         V2RXxAB3XkusglDnCTO+Wg6aPkK/p9bGYaWgaeyMEHVYH/0ECZ+KuHypK4PcdNm8MQ
         jvgcGlExbXrnMgpmJbdtXI30+b36RXN2LhjdeJEI=
Date:   Tue, 5 Nov 2019 08:04:21 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: avoid blk_bio_segment_split for small I/O
 operations
Message-ID: <20191104230421.GC21282@redsun51.ssa.fujisawa.hgst.com>
References: <20191104180543.23123-1-hch@lst.de>
 <20191104193002.GA21075@redsun51.ssa.fujisawa.hgst.com>
 <f1050949-31b1-a9cf-02d6-00c94f505290@kernel.dk>
 <20191104225036.GA21282@redsun51.ssa.fujisawa.hgst.com>
 <e5cd73ac-9184-97f5-132f-ba4a7069608d@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5cd73ac-9184-97f5-132f-ba4a7069608d@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 04, 2019 at 02:58:41PM -0800, Bart Van Assche wrote:
> On 11/4/19 2:50 PM, Keith Busch wrote:
> > On Mon, Nov 04, 2019 at 01:13:53PM -0700, Jens Axboe wrote:
> > > > If the device advertises a chunk boundary and this small IO happens to
> > > > cross it, skipping the split is going to harm performance.
> > > 
> > > Does anyone do that, that isn't the first gen intel weirdness? Honest question,
> > > but always seemed to me that this spec addition was driven entirely by that
> > > one device.
> > 
> > There are at least 3 generations of Intel DC P-series that use this,
> > maybe more. I'm not sure if any other available vendor devices report
> > this feature, though.
> > > And if they do, do they align on non-4k?
> > 
> > All existing ones I'm aware of are 128k, so 4k aligned, but if the LBA
> > format is 512B, you could start a 4k IO at a 126k offset to straddle the
> > boundary. Hm, maybe we don't care about the split penalty in that case
> > since unaligned access is already going to be slower for other reasons ...
> 
> Aren't NVMe devices expected to set the NOIOB parameter to avoid that NVMe
> commands straddle boundaries that incur a performance penalty? From the NVMe
> spec: "Namespace Optimal IO Boundary (NOIOB): This field indicates the
> optimal IO boundary for this namespace. This field is specified in logical
> blocks. The host should construct read and write commands that do not cross
> the IO boundary to achieve optimal performance. A value of 0h indicates that
> no optimal IO boundary is reported."

Yes, for nvme, noiob is the feature we're talking about.

I was initially just thinking about performance, but there's other
cases Christoph mentioned where the host split is necessary.
