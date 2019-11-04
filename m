Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4385EF0CB
	for <lists+linux-block@lfdr.de>; Mon,  4 Nov 2019 23:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbfKDWun (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 Nov 2019 17:50:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:36894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729122AbfKDWun (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Nov 2019 17:50:43 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7AD520663;
        Mon,  4 Nov 2019 22:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572907842;
        bh=blrlGH0qI5gvz+1heHUFs1cOEGXBwHEvYJn89j0vnUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=huCk8sHm80qTZkGgr7JPRbDtCGzrQAguxCD4UQl40CWBPDuMKAO2d8hX4C0WDxu31
         Tlsd50uMuRnDmTA9vOX90fZs54Iwef9ntqAXGjT//vMvvXTUriWl20wsFXU7v1SJSe
         QC9kxQ9lX616F6SzZXcubDw64hxZcknCsrTXIq1w=
Date:   Tue, 5 Nov 2019 07:50:36 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, ming.lei@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: avoid blk_bio_segment_split for small I/O
 operations
Message-ID: <20191104225036.GA21282@redsun51.ssa.fujisawa.hgst.com>
References: <20191104180543.23123-1-hch@lst.de>
 <20191104193002.GA21075@redsun51.ssa.fujisawa.hgst.com>
 <f1050949-31b1-a9cf-02d6-00c94f505290@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1050949-31b1-a9cf-02d6-00c94f505290@kernel.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 04, 2019 at 01:13:53PM -0700, Jens Axboe wrote:
> > If the device advertises a chunk boundary and this small IO happens to
> > cross it, skipping the split is going to harm performance.
> 
> Does anyone do that, that isn't the first gen intel weirdness? Honest question,
> but always seemed to me that this spec addition was driven entirely by that
> one device.

There are at least 3 generations of Intel DC P-series that use this,
maybe more. I'm not sure if any other available vendor devices report
this feature, though.
 
> And if they do, do they align on non-4k?

All existing ones I'm aware of are 128k, so 4k aligned, but if the LBA
format is 512B, you could start a 4k IO at a 126k offset to straddle the
boundary. Hm, maybe we don't care about the split penalty in that case
since unaligned access is already going to be slower for other reasons ...
