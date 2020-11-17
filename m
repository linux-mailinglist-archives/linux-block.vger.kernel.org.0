Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DDC2B6914
	for <lists+linux-block@lfdr.de>; Tue, 17 Nov 2020 16:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgKQPvD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 Nov 2020 10:51:03 -0500
Received: from verein.lst.de ([213.95.11.211]:59974 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgKQPvD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Nov 2020 10:51:03 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id DE1F36736F; Tue, 17 Nov 2020 16:51:00 +0100 (CET)
Date:   Tue, 17 Nov 2020 16:51:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Minchan Kim <minchan@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: misc struct block_device related driver cleanups
Message-ID: <20201117155100.GA20977@lst.de>
References: <20201116212020.1099154-1-hch@lst.de> <20201117154629.GA27085@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117154629.GA27085@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 17, 2020 at 10:46:29AM -0500, Mike Snitzer wrote:
> On Mon, Nov 16 2020 at  4:20pm -0500,
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > Hi Jens, Minchan and Mike,
> > 
> > this series cleans up a few interactions of driver with struct
> > block_device, in preparation for big changes to struct block_device
> > that I plan to send soon.
> 
> Thanks, I've picked up 5 and 6 for 5.11.

I actually need them in Jens' for-5.11/block tree for my next series..
