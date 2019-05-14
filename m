Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90FDE1C999
	for <lists+linux-block@lfdr.de>; Tue, 14 May 2019 15:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfENNwD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 14 May 2019 09:52:03 -0400
Received: from verein.lst.de ([213.95.11.211]:45899 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfENNwD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 May 2019 09:52:03 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6355568B20; Tue, 14 May 2019 15:51:42 +0200 (CEST)
Date:   Tue, 14 May 2019 15:51:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@fb.com,
        Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org
Subject: Re: [PATCH 01/10] block: don't decrement nr_phys_segments for
 physically contigous segments
Message-ID: <20190514135141.GA13683@lst.de>
References: <20190513063754.1520-1-hch@lst.de> <20190513063754.1520-2-hch@lst.de> <20190513094544.GA30381@ming.t460p> <20190513120344.GA22993@lst.de> <20190514043642.GB10824@ming.t460p> <20190514051441.GA6294@lst.de> <20190514090544.GC20468@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514090544.GC20468@ming.t460p>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 14, 2019 at 05:05:45PM +0800, Ming Lei wrote:
> However we still may make it better, for example, the attached patch can
> save 10~20% time when running 'mkfs.ntfs -s 512 /dev/vda', lots of small
> request(63KB) can be merged to big IO(1MB).

And we could save even more time by making the block dev buffered I/O
path not do stupid things to start with.

> > With the gap devices we have unlimited segment size, see my next patch
> > to actually enforce that.  Which is much more efficient than using
> 
> But this patch does effect on non-gap device, and actually most of
> device are non-gap type.

Yes, but only for request merges, and only if merging the requests
goes over max_requests.  The upside is that we actually get a
nr_phys_segments that mirrors what is in the request, fixing bugs
in a few drivers, and allowing for follow on patches that significantly
simplify our I/O path.
