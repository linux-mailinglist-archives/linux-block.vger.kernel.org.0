Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3856D1C1B9
	for <lists+linux-block@lfdr.de>; Tue, 14 May 2019 07:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfENFPD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 14 May 2019 01:15:03 -0400
Received: from verein.lst.de ([213.95.11.211]:43521 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfENFPC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 May 2019 01:15:02 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B655F68AFE; Tue, 14 May 2019 07:14:41 +0200 (CEST)
Date:   Tue, 14 May 2019 07:14:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@fb.com,
        Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org
Subject: Re: [PATCH 01/10] block: don't decrement nr_phys_segments for
 physically contigous segments
Message-ID: <20190514051441.GA6294@lst.de>
References: <20190513063754.1520-1-hch@lst.de> <20190513063754.1520-2-hch@lst.de> <20190513094544.GA30381@ming.t460p> <20190513120344.GA22993@lst.de> <20190514043642.GB10824@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514043642.GB10824@ming.t460p>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 14, 2019 at 12:36:43PM +0800, Ming Lei wrote:
> > > Some workloads need this optimization, please see 729204ef49ec00b
> > > ("block: relax check on sg gap"):
> > 
> > And we still allow to merge the segments with this patch.  The only
> > difference is that these merges do get accounted as extra segments.
> 
> It is easy for .nr_phys_segments to reach the max segment limit by this
> way, then no new bio can be merged any more.

As said in my other mail we only decremented it for request merges
in the non-gap case before and no one complained.

> We don't consider segment merge between two bios in ll_new_hw_segment(),
> in my mkfs test over virtio-blk, request size can be increased to ~1M(several
> segments) from 63k(126 bios/segments) easily if the segment merge between
> two bios is considered.

With the gap devices we have unlimited segment size, see my next patch
to actually enforce that.  Which is much more efficient than using
multiple segments.  Also instead of hacking up the merge path even more
we can fix the block device buffered I/O path to submit large I/Os
instead of relying on merging like we do in the direct I/O code and every
major file system.  I have that on my plate as a todo list item.

> > We do that in a couple of places.  For one the nvme single segment
> > optimization that triggered this bug.  Also for range discard support
> > in nvme and virtio.  Then we have loop that  iterate the segments, but
> > doesn't use the nr_phys_segments count, and plenty of others that
> > iterate over pages at the moment but should be iterating bvecs,
> > e.g. ubd or aoe.
> 
> Seems discard segment doesn't consider bios merge for nvme and virtio,
> so it should be fine in this way. Will take a close look at nvme/virtio
> discard segment merge later.

I found the bio case by looking at doing the proper accounting in the
bio merge path and hitting KASAN warning due to the range kmalloc.
So that issue is real as well.
